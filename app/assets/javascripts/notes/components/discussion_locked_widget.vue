<script>
import { GlLink } from '@gitlab/ui';
import Icon from '~/vue_shared/components/icon.vue';
import { __, sprintf } from '~/locale';
import Issuable from '~/vue_shared/mixins/issuable';
import issuableStateMixin from '../mixins/issuable_state';

export default {
  components: {
    Icon,
    GlLink,
  },
  mixins: [Issuable, issuableStateMixin],
  computed: {
    lockedIssueWarning() {
      return sprintf(
        __('This %{issuableDisplayName} is locked. Only project members can comment.'),
        { issuableDisplayName: this.issuableDisplayName },
      );
    },
  },
};
</script>

<template>
  <div class="disabled-comment text-center">
    <span class="issuable-note-warning inline">
      <icon :size="16" name="lock" class="icon" />
      <span>
        {{ lockedIssueWarning }}

        <gl-link :href="lockedIssueDocsPath" target="_blank" class="learn-more">
          {{ __('Learn more') }}
        </gl-link>
      </span>
    </span>
  </div>
</template>
