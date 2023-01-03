def sentry_span(op:, description:, &block)
  span = Sentry.get_current_scope&.get_span
  if span
    span.with_child_span(op: op, description: description) do
      block.call
    end
  else
    block.call
  end
end
