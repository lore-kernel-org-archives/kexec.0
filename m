From: Eric DeVolder <eric.devolder@oracle.com>
Date: Wed,  9 Feb 2022 14:57:02 -0500
Subject: [PATCH v4 06/10] crash hp: generic crash hotplug support
 infrastructure
In-Reply-To: <20220209195706.51522-1-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
Message-ID: <20220209195706.51522-7-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

This patch introduces a generic crash hot plug/unplug infrastructure
for CPU and memory changes. Upon CPU and memory changes, a generic
crash_hotplug_handler() obtains the appropriate lock, does some
important house keeping and then dispatches the hot plug/unplug event
to the architecture specific arch_crash_hotplug_handler(), and when
that handler returns, the lock is released.

This patch modifies crash_core.c to implement a subsys_initcall()
function that installs handlers for hot plug/unplug events. If CPU
hotplug is enabled, then cpuhp_setup_state() is invoked to register a
handler for CPU changes. Similarly, if memory hotplug is enabled, then
register_memory_notifier() is invoked to install a handler for memory
changes. These handlers in turn invoke the common generic handler
crash_hotplug_handler().

On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
the CPU still shows up in foreach_present_cpu() during the regeneration
of the new CPU list, thus the need to explicitly check and exclude the
soon-to-be offlined CPU in crash_prepare_elf64_headers().

On the memory side, each un/plugged memory block passes through the
handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
memory events, one for each 128MiB memblock.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/crash_core.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 0ff06d0698ad..524470e18883 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,12 +10,16 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
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
@@ -521,5 +525,105 @@ void unmap_crash_pages(void **ptr)
 		*ptr = NULL;
 	}
 }
+
+void __weak arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	pr_warn("crash hp: %s not implemented", __func__);
+}
+
+static void crash_hotplug_handler(unsigned int hp_action,
+	unsigned long a, unsigned long b)
+{
+	/* Obtain lock while changing crash information */
+	if (!mutex_trylock(&kexec_mutex))
+		return;
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
+			a, b);
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Flag to differentiate between normal load and hotplug */
+		kexec_crash_image->hotplug_event = true;
+
+		/* Now invoke arch-specific update handler */
+		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
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
+#if defined(CONFIG_MEMORY_HOTPLUG)
+static int crash_memhp_notifier(struct notifier_block *nb,
+	unsigned long val, void *v)
+{
+	struct memory_notify *mhp = v;
+	unsigned long start, end;
+
+	start = mhp->start_pfn << PAGE_SHIFT;
+	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
+
+	switch (val) {
+	case MEM_ONLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
+			start, end-start);
+		break;
+
+	case MEM_OFFLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			start, end-start);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
 #endif
 
+#if defined(CONFIG_HOTPLUG_CPU)
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
+	return 0;
+}
+#endif
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	register_memory_notifier(&crash_memhp_nb);
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+				"crash/cpuhp",
+				crash_cpuhp_online, crash_cpuhp_offline);
+#endif
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0


