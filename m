Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a2lta-0002Zi-9a
 for kexec@lists.infradead.org; Sat, 28 Nov 2015 20:14:59 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [RFC PATCH] crashdump/x86: Add option to get crash kernel region size
Date: Sat, 28 Nov 2015 21:14:04 +0100
Message-Id: <1448741644-905-1-git-send-email-daniel.kiper@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xenproject.org, kexec@lists.infradead.org
Cc: andrew.cooper3@citrix.com, keir@xen.org, david.vrabel@citrix.com, jbeulich@suse.com, konrad.wilk@oracle.com

Crash kernel region size is available via sysfs on Linux running on
bare metal. However, this does not work when Linux runs as Xen dom0.
In this case Xen crash kernel region size should be established using
__HYPERVISOR_kexec_op hypercall (Linux kernel kexec functionality does
not make a lot of sense in Xen dom0). Sadly hypercalls are not easily
accessible using shell scripts or something like that. Potentially we
can check "xl dmesg" output for crashkernel option but this is not nice.
So, let's add this functionality, for Linux running on bare metal and
as Xen dom0, to kexec-tools. This way kdump scripts may establish crash
kernel region size in one way regardless of platform. All burden of
platform detection lies on kexec-tools.

Figure (and unit) displayed by this new kexec-tools functionality is
the same as one taken from /sys/kernel/kexec_crash_size.

This functionality is available on x86 platform only. If idea is acceptable
then I can prepare patches for other platforms (if it is possible and make
sense) and repost them as fully flagged patch series.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c |   18 +++++++++++++++++-
 kexec/crashdump.h               |    1 -
 kexec/kexec.8                   |    3 +++
 kexec/kexec.c                   |    4 ++++
 kexec/kexec.h                   |    5 ++++-
 5 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index bbc0f35..4b31112 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -1056,7 +1056,7 @@ static int crashkernel_mem_callback(void *UNUSED(data), int nr,
 	return 0;
 }
 
-int is_crashkernel_mem_reserved(void)
+static int get_crashkernel_region(void)
 {
 	int ret;
 
@@ -1079,3 +1079,19 @@ int is_crashkernel_mem_reserved(void)
 
 	return !!crash_reserved_mem_nr;
 }
+
+int is_crashkernel_mem_reserved(void)
+{
+	return get_crashkernel_region();
+}
+
+void print_crashkernel_region_size(void)
+{
+	uint64_t end, start;
+
+	if (get_crashkernel_region()) {
+		get_crash_kernel_load_range(&start, &end);
+		printf("%lu\n", end - start + 1);
+	} else
+		printf("0\n");
+}
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 95f1f0c..320767b 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -1,7 +1,6 @@
 #ifndef CRASHDUMP_H
 #define CRASHDUMP_H
 
-int get_crashkernel_region(uint64_t *start, uint64_t *end);
 extern int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len);
 extern int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len);
 extern int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len);
diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 4d0c1d1..ba7d096 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -173,6 +173,9 @@ Load a helper image to jump back to original kernel.
 .TP
 .BI \-\-reuseinitrd
 Reuse initrd from first boot.
+.TP
+.BI \-\-print-ckr-size
+Print crash kernel region size.
 
 
 .SH SUPPORTED KERNEL FILE TYPES AND OPTIONS
diff --git a/kexec/kexec.c b/kexec/kexec.c
index cf6e03d..43c7e8c 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -960,6 +960,7 @@ void usage(void)
 	       "     --mem-max=<addr> Specify the highest memory address to\n"
 	       "                      load code into.\n"
 	       "     --reuseinitrd    Reuse initrd from first boot.\n"
+	       "     --print-ckr-size Print crash kernel region size.\n"
 	       "     --load-preserve-context Load the new kernel and preserve\n"
 	       "                      context of current kernel during kexec.\n"
 	       "     --load-jump-back-helper Load a helper image to jump back\n"
@@ -1345,6 +1346,9 @@ int main(int argc, char *argv[])
 		case OPT_KEXEC_FILE_SYSCALL:
 			/* We already parsed it. Nothing to do. */
 			break;
+		case OPT_PRINT_CKR_SIZE:
+			print_crashkernel_region_size();
+			return 0;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index c02ac8f..42a602d 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -224,7 +224,8 @@ extern int file_types;
 #define OPT_LOAD_PRESERVE_CONTEXT 259
 #define OPT_LOAD_JUMP_BACK_HELPER 260
 #define OPT_ENTRY		261
-#define OPT_MAX			262
+#define OPT_PRINT_CKR_SIZE	262
+#define OPT_MAX			263
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -244,6 +245,7 @@ extern int file_types;
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
+	{ "print-ckr-size",	0, 0, OPT_PRINT_CKR_SIZE }, \
 
 #define KEXEC_OPT_STR "h?vdfxyluet:ps"
 
@@ -290,6 +292,7 @@ int arch_compat_trampoline(struct kexec_info *info);
 void arch_update_purgatory(struct kexec_info *info);
 int is_crashkernel_mem_reserved(void);
 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end);
+void print_crashkernel_region_size(void);
 char *get_command_line(void);
 
 int kexec_iomem_for_each_line(char *match,
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
