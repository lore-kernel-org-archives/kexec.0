From: Eric DeVolder <eric.devolder@oracle.com>
Date: Fri,  1 Apr 2022 14:30:38 -0400
Subject: [PATCH v6 6/8] kexec: exclude hot remove cpu from elfcorehdr notes
In-Reply-To: <20220401183040.1624-1-eric.devolder@oracle.com>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
Message-ID: <20220401183040.1624-7-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
crash_hotplug_handler(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in crash_hotplug_handler() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 10 ++++++++++
 kernel/kexec_file.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 76959d440f71..d3fd51f2195c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -522,6 +522,16 @@ static void crash_hotplug_handler(unsigned int hp_action,
 		/* Flag to differentiate between normal load and hotplug */
 		kexec_crash_image->hotplug_event = true;
 
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		kexec_crash_image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				(unsigned int)a : ~0U;
+
 		/* Now invoke arch-specific update handler */
 		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 94a459209111..9d5c4eea0179 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.27.0


