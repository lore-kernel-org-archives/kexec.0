Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v2] kexec: Add --no-checks option
References: <1445469125.30908.105.camel@infradead.org>
Message-ID: <fc68e396-1eab-7cc3-fcbd-01b03e5967cb@infradead.org>
Date: Wed, 11 Apr 2018 11:30:48 -0700
MIME-Version: 1.0
In-Reply-To: <1445469125.30908.105.camel@infradead.org>
Content-Language: en-US
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
Cc: James Morse <james.morse@arm.com>, Kostiantyn Iarmak <kiarmak@cisco.com>, kexec@lists.infradead.org, Petitboot@lists.ozlabs.org

Add a new option --no-checks to kexec that allows for a fast
reboot by avoiding the purgatory integrity checks.  This option is
intended for use by kexec based bootloaders that load a new
image and then immediately transfer control to it.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Simon,

On 10/21/2015 04:12 PM, Geoff Levand wrote:
> Hi Simon,
> 
> It was reported that on some systems where purgatory is running
> without caches enabled the sha256 calculations would take several
> minutes.  For bootloaders that just load a new image and
> immediately jump into it the loss of the integrity check is worth
> the increase in boot speed.  Please consider.

There seems to be continued interest in faster kexec re-boot times
on arm64 systems so I rebased my old patch and renamed the
option from '--lite' to '--no-checks'.  Please consider.

-Geoff

 kexec/kexec.8         |  3 +++
 kexec/kexec.c         | 19 +++++++++++++++++--
 kexec/kexec.h         |  6 +++++-
 purgatory/purgatory.c |  3 ++-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index fb8a4c9..2fafaaa 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -132,6 +132,9 @@ in one call.
 Open a help file for
 .BR kexec .
 .TP
+.B \-i\ (\-\-no-checks)
+Fast reboot, no memory integrity checks.
+.TP
 .BI \-l\ (\-\-load) \ kernel
 Load the specified
 .I kernel
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 313d9fe..a512047 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -647,6 +647,15 @@ static void update_purgatory(struct kexec_info *info)
 		return;
 	}
 	arch_update_purgatory(info);
+
+	if (info->skip_checks) {
+		unsigned int tmp = 1;
+
+		elf_rel_set_symbol(&info->rhdr, "skip_checks", &tmp,
+			sizeof(tmp));
+		return;
+	}
+
 	memset(region, 0, sizeof(region));
 	sha256_starts(&ctx);
 	/* Compute a hash of the loaded kernel */
@@ -686,7 +695,7 @@ static void update_purgatory(struct kexec_info *info)
  *	Load the new kernel
  */
 static int my_load(const char *type, int fileind, int argc, char **argv,
-		   unsigned long kexec_flags, void *entry)
+		   unsigned long kexec_flags, int skip_checks, void *entry)
 {
 	char *kernel;
 	char *kernel_buf;
@@ -699,6 +708,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 
 	memset(&info, 0, sizeof(info));
 	info.kexec_flags = kexec_flags;
+	info.skip_checks = skip_checks;
 
 	result = 0;
 	if (argc - fileind <= 0) {
@@ -980,6 +990,7 @@ void usage(void)
 	       " -v, --version        Print the version of kexec.\n"
 	       " -f, --force          Force an immediate kexec,\n"
 	       "                      don't call shutdown.\n"
+	       " -i, --no-checks      Fast reboot, no memory integrity checks.\n"
 	       " -x, --no-ifdown      Don't bring down network interfaces.\n"
 	       " -y, --no-sync        Don't sync filesystems before kexec.\n"
 	       " -l, --load           Load the new kernel into the\n"
@@ -1250,6 +1261,7 @@ int main(int argc, char *argv[])
 	int do_reuse_initrd = 0;
 	int do_kexec_file_syscall = 0;
 	int do_kexec_fallback = 0;
+	int skip_checks = 0;
 	int do_status = 0;
 	void *entry = 0;
 	char *type = 0;
@@ -1385,6 +1397,9 @@ int main(int argc, char *argv[])
 			do_kexec_file_syscall = 1;
 			do_kexec_fallback = 1;
 			break;
+		case OPT_NOCHECKS:
+			skip_checks = 1;
+			break;
 		case OPT_STATUS:
 			do_status = 1;
 			break;
@@ -1519,7 +1534,7 @@ int main(int argc, char *argv[])
 		}
 		if (!do_kexec_file_syscall)
 			result = my_load(type, fileind, argc, argv,
-						kexec_flags, entry);
+						kexec_flags, skip_checks, entry);
 	}
 	/* Don't shutdown unless there is something to reboot to! */
 	if ((result == 0) && (do_shutdown || do_exec) && !kexec_loaded(KEXEC_LOADED_PATH)) {
diff --git a/kexec/kexec.h b/kexec/kexec.h
index d445fbe..a97b9ce 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -166,6 +166,8 @@ struct kexec_info {
 	int initrd_fd;
 	char *command_line;
 	int command_line_len;
+
+	int skip_checks;
 };
 
 struct arch_map_entry {
@@ -211,6 +213,7 @@ extern int file_types;
 #define OPT_VERSION		'v'
 #define OPT_DEBUG		'd'
 #define OPT_FORCE		'f'
+#define OPT_NOCHECKS		'i'
 #define OPT_NOIFDOWN		'x'
 #define OPT_NOSYNC		'y'
 #define OPT_EXEC		'e'
@@ -234,6 +237,7 @@ extern int file_types;
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
 	{ "force",		0, 0, OPT_FORCE }, \
+	{ "no-checks",		0, 0, OPT_NOCHECKS }, \
 	{ "no-ifdown",		0, 0, OPT_NOIFDOWN }, \
 	{ "no-sync",		0, 0, OPT_NOSYNC }, \
 	{ "load",		0, 0, OPT_LOAD }, \
@@ -254,7 +258,7 @@ extern int file_types;
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 
-#define KEXEC_OPT_STR "h?vdfxyluet:pscaS"
+#define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
 
 extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
 extern void die(const char *fmt, ...)
diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
index 3bbcc09..73930aa 100644
--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -8,6 +8,7 @@
 
 struct sha256_region sha256_regions[SHA256_REGIONS] = {};
 sha256_digest_t sha256_digest = { };
+int skip_checks = 0;
 
 int verify_sha256_digest(void)
 {
@@ -43,7 +44,7 @@ void purgatory(void)
 {
 	printf("I'm in purgatory\n");
 	setup_arch();
-	if (verify_sha256_digest()) {
+	if (!skip_checks && verify_sha256_digest()) {
 		for(;;) {
 			/* loop forever */
 		}
-- 
2.14.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
