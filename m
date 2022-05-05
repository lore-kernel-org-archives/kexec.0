From: Eric DeVolder <eric.devolder@oracle.com>
Date: Thu,  5 May 2022 14:45:59 -0400
Subject: [PATCH v8 3/7] crash: add generic infrastructure for crash hotplug
 support
In-Reply-To: <20220505184603.1548-1-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
Message-ID: <20220505184603.1548-4-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

CPU and memory change notifications are received in order to
regenerate the elfcorehdr.

To support cpu hotplug, a callback is registered to capture the
CPUHP_AP_ONLINE_DYN online and offline events via
cpuhp_setup_state_nocalls().

To support memory hotplug, a notifier is registered to capture the
MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The cpu callback and memory notifiers call handle_hotplug_event()
to handle the hot plug/unplug event. Then handle_hotplug_event()
dispatches the event to the architecture specific
arch_crash_handle_hotplug_event(). During the process, the
kexec_mutex is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/crash_core.h | 10 +++++
 include/linux/kexec.h      |  5 +++
 kernel/crash_core.c        | 92 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..a240f84348aa 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,14 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU		0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
+									unsigned int cpu);
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f93f2591fc1e..5935bc78ed7f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -308,6 +308,11 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+	bool hotplug_event;
+	unsigned int offlinecpu;
+	bool elfcorehdr_index_valid;
+	int elfcorehdr_index;
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..f197af50def6 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,12 +9,17 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/highmem.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
 
 #include <crypto/sha1.h>
 
+#include "kexec_internal.h"
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -491,3 +496,90 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+void __weak arch_crash_handle_hotplug_event(struct kimage *image,
+							unsigned int hp_action, unsigned int cpu)
+{
+	WARN(1, "crash hotplug handler not implemented");
+}
+
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	if (!mutex_trylock(&kexec_mutex))
+		return;
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Flag to differentiate between normal load and hotplug */
+		kexec_crash_image->hotplug_event = true;
+
+		/* Now invoke arch-specific update handler */
+		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
+
+		/* No longer handling a hotplug event */
+		kexec_crash_image->hotplug_event = false;
+
+		/* Change back to read-only */
+		arch_kexec_protect_crashkres();
+	}
+
+	/* Release lock now that update complete */
+	mutex_unlock(&kexec_mutex);
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
+		break;
+
+	case MEM_OFFLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+									"crash/cpuhp",
+									crash_cpuhp_online,
+									crash_cpuhp_offline);
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
-- 
2.27.0


