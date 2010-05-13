Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OCSvk-0001kk-Jn
	for kexec@lists.infradead.org; Thu, 13 May 2010 07:34:06 +0000
Message-ID: <4BEBAB67.30107@ozlabs.org>
Date: Thu, 13 May 2010 17:33:59 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
Subject: [PATCH] kexec-tools: remove unused code from arch_process_options
	(arm, cris, ia64, mips, ppc)
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au


These architectures don't have any architecture-specific options
(note: distinct from loader options, which are more specific), yet
their arch_process_options() functions contain getopts_long() calls
followed by no argument processing.  The code doesn't do anything,
so this patch removes it.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 kexec/arch/arm/kexec-arm.c   |   17 -----------------
 kexec/arch/cris/kexec-cris.c |   17 -----------------
 kexec/arch/ia64/kexec-ia64.c |   21 +++------------------
 kexec/arch/mips/kexec-mips.c |   17 -----------------
 kexec/arch/ppc/kexec-ppc.c   |   17 -----------------
 5 files changed, 3 insertions(+), 86 deletions(-)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 06ed8fd..de3f713 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -88,23 +88,6 @@ void arch_usage(void)
 
 int arch_process_options(int argc, char **argv)
 {
-	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
-		{ 0,			0, NULL, 0 },
-	};
-	static const char short_options[] = KEXEC_ARCH_OPT_STR;
-	int opt;
-
-	opterr = 0; /* Don't complain about unrecognized options here */
-	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
-		switch(opt) {
-		default:
-			break;
-		}
-	}
-	/* Reset getopt for the next pass; called in other source modules */
-	opterr = 1;
-	optind = 1;
 	return 0;
 }
 
diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
index 30df27e..38876f6 100644
--- a/kexec/arch/cris/kexec-cris.c
+++ b/kexec/arch/cris/kexec-cris.c
@@ -54,23 +54,6 @@ void arch_usage(void)
 
 int arch_process_options(int argc, char **argv)
 {
-	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
-		{ 0,                    0, NULL, 0 },
-	};
-	static const char short_options[] = KEXEC_ARCH_OPT_STR;
-	int opt;
-
-	opterr = 0; /* Don't complain about unrecognized options here */
-	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
-		switch(opt) {
-		default:
-			break;
-		}
-	}
-	/* Reset getopt for the next pass; called in other source modules */
-	opterr = 1;
-	optind = 1;
 	return 0;
 }
 
diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
index edd3674..aa510a9 100644
--- a/kexec/arch/ia64/kexec-ia64.c
+++ b/kexec/arch/ia64/kexec-ia64.c
@@ -180,29 +180,14 @@ void arch_usage(void)
 
 int arch_process_options(int argc, char **argv)
 {
-	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
-		{ 0, 0, NULL, 0 },
-	};
-	static const char short_options[] = KEXEC_ARCH_OPT_STR;
-	int opt;
+	/* This doesn't belong here!  Some sort of arch_init() ? */
 
 	/* execute from monarch processor */
-        cpu_set_t affinity;
+	cpu_set_t affinity;
 	CPU_ZERO(&affinity);
 	CPU_SET(0, &affinity);
-        sched_setaffinity(0, sizeof(affinity), &affinity);
+	sched_setaffinity(0, sizeof(affinity), &affinity);
 
-	opterr = 0; /* Don't complain about unrecognized options here */
-	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
-		switch(opt) {
-		default:
-			break;
-		}
-	}
-	/* Reset getopt for the next pass; called in other source modules */
-	opterr = 1;
-	optind = 1;
 	return 0;
 }
 
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index bd12bb3..fe0c945 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -88,23 +88,6 @@ struct arch_options_t arch_options = {
 
 int arch_process_options(int argc, char **argv)
 {
-	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
-		{ 0,                    0, NULL, 0 },
-	};
-	static const char short_options[] = KEXEC_ARCH_OPT_STR;
-	int opt;
-
-	opterr = 0; /* Don't complain about unrecognized options here */
-	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
-		switch(opt) {
-		default:
-			break;
-		}
-	}
-	/* Reset getopt for the next pass; called in other source modules */
-	opterr = 1;
-	optind = 1;
 	return 0;
 }
 
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index f552d79..effe94c 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -495,23 +495,6 @@ void arch_usage(void)
 
 int arch_process_options(int argc, char **argv)
 {
-	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
-		{ 0, 			0, NULL, 0 },
-	};
-	static const char short_options[] = KEXEC_ARCH_OPT_STR;
-	int opt;
-
-	opterr = 0; /* Don't complain about unrecognized options here */
-	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
-		switch(opt) {
-		default:
-			break;
-		}
-	}
-	/* Reset getopt for the next pass; called in other source modules */
-	opterr = 1;
-	optind = 1;
 	return 0;
 }
 
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
