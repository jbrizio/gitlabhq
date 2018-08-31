class AddIndexOnDefaultPrometheusMetrics < ActiveRecord::Migration
  include Gitlab::Database::MigrationHelpers

  DOWNTIME = false

  disable_ddl_transaction!

  def up
    add_concurrent_index :prometheus_metrics, :common
  end

  def down
    remove_concurrent_index :prometheus_metrics, :project_id
  end
end
