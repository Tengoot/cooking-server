# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute # rubocop:disable Metrics/MethodLength
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      warden: warden,
      viewer: viewer
    }
    result = CookingServerSchema.execute(query, variables: variables,
                                                context: context,
                                                operation_name: operation_name)
    render json: result
  end

  private

  def viewer
    warden&.user
  end

  def warden
    request.env['warden']
  end

  def ensure_hash(ambiguous_param) # rubocop:disable Metrics/MethodLength
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(error)
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))

    render json: {
      error: {
        message: error.message,
        backtrace: error.backtrace
      },
      data: {}
    },
           status: 500
  end
end
