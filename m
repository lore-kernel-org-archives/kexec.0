Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1445469125.30908.105.camel@infradead.org>
Subject: [PATCH] kexec: Add --lite option
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 21 Oct 2015 16:12:05 -0700
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Petitboot@lists.ozlabs.org

Add a new option --lite to kexec that allows for a fast reboot
by avoiding the purgatory integrity checks.  This option is
intended for use by kexec based bootloaders that load a new
image and then immediately transfer control to it.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Simon,

It was reported that on some systems where purgatory is running
without caches enabled the sha256 calculations would take several
minutes.  For bootloaders that just load a new image and
immediately jump into it the loss of the integrity check is worth
the increase in boot speed.  Please consider.  

-Geoff

 kexec/kexec.8         |  3 +++
 kexec/kexec.c         | 19 +++++++++++++++++--
 kexec/kexec.h         |  4 ++++
 purgatory/purgatory.c |  3 ++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 4d0c1d1..93ed588 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -126,6 +126,9 @@ in one call.
 Open a help file for
 .BR kexec .
 .TP
+.B \-i\ (\-\-lite)
+Fast reboot, no memory integrity checks.
+.TP
 .BI \-l\ (\-\-load) \ kernel
 Load the specified
 .I kernel
diff --git a/kexec/kexec.c b/kexec/kexec.c
index ff024f3..ebb1310 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -613,6 +613,15 @@ static void update_purgatory(struct kexec_info *info)
 		return;
 	}
 	arch_update_purgatory(info);
+
+	if (info->kexec_lite) {
+		unsigned int tmp = 1;
+
+		elf_rel_set_symbol(&info->rhdr, "kexec_lite", &tmp,
+			sizeof(tmp));
+		return;
+	}
+
 	memset(region, 0, sizeof(region));
 	sha256_starts(&ctx);
 	/* Compute a hash of the loaded kernel */
@@ -652,7 +661,7 @@ static void update_purgatory(struct kexec_info *info)
  *	Load the new kernel
  */
 static int my_load(const char *type, int fileind, int argc, char **argv,
-		   unsigned long kexec_flags, void *entry)
+		   unsigned long kexec_flags, int kexec_lite, void *entry)
 {
 	char *kernel;
 	char *kernel_buf;
@@ -665,6 +674,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 
 	memset(&info, 0, sizeof(info));
 	info.kexec_flags = kexec_flags;
+	info.kexec_lite = kexec_lite;
 
 	result = 0;
 	if (argc - fileind <= 0) {
@@ -914,6 +924,7 @@ void usage(void)
 	       " -v, --version        Print the version of kexec.\n"
 	       " -f, --force          Force an immediate kexec,\n"
 	       "                      don't call shutdown.\n"
+	       " -i, --lite           Fast reboot, no memory integrity checks.\n"
 	       " -x, --no-ifdown      Don't bring down network interfaces.\n"
 	       " -y, --no-sync        Don't sync filesystems before kexec.\n"
 	       " -l, --load           Load the new kernel into the\n"
@@ -1173,6 +1184,7 @@ int main(int argc, char *argv[])
 	int do_unload = 0;
 	int do_reuse_initrd = 0;
 	int do_kexec_file_syscall = 0;
+	int do_lite = 0;
 	void *entry = 0;
 	char *type = 0;
 	char *endptr;
@@ -1314,6 +1326,9 @@ int main(int argc, char *argv[])
 		case OPT_KEXEC_FILE_SYSCALL:
 			/* We already parsed it. Nothing to do. */
 			break;
+		case OPT_LITE:
+			do_lite = 1;
+			break;
 		default:
 			break;
 		}
@@ -1374,7 +1389,7 @@ int main(int argc, char *argv[])
 						 kexec_file_flags);
 		else
 			result = my_load(type, fileind, argc, argv,
-						kexec_flags, entry);
+						kexec_flags, do_lite, entry);
 	}
 	/* Don't shutdown unless there is something to reboot to! */
 	if ((result == 0) && (do_shutdown || do_exec) && !kexec_loaded()) {
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 7c97b25..06e08f4 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -165,6 +165,8 @@ struct kexec_info {
 	int initrd_fd;
 	char *command_line;
 	int command_line_len;
+
+	int kexec_lite;
 };
 
 struct arch_map_entry {
@@ -218,6 +220,7 @@ extern int file_types;
 #define OPT_TYPE		't'
 #define OPT_PANIC		'p'
 #define OPT_KEXEC_FILE_SYSCALL	's'
+#define OPT_LITE		'i'
 #define OPT_MEM_MIN             256
 #define OPT_MEM_MAX             257
 #define OPT_REUSE_INITRD	258
@@ -243,6 +246,7 @@ extern int file_types;
 	{ "mem-max",		1, 0, OPT_MEM_MAX }, \
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
+	{ "lite",		0, 0, OPT_LITE }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
 
 #define KEXEC_OPT_STR "h?vdfxyluet:ps"
diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
index 3bbcc09..7e99b92 100644
--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -8,6 +8,7 @@
 
 struct sha256_region sha256_regions[SHA256_REGIONS] = {};
 sha256_digest_t sha256_digest = { };
+int kexec_lite = 0;
 
 int verify_sha256_digest(void)
 {
@@ -43,7 +44,7 @@ void purgatory(void)
 {
 	printf("I'm in purgatory\n");
 	setup_arch();
-	if (verify_sha256_digest()) {
+	if (!kexec_lite && verify_sha256_digest()) {
 		for(;;) {
 			/* loop forever */
 		}
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
