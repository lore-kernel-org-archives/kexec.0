Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-Id: <154f98dc113651c2b7e76ff919d59d39ee344a39.1380746425.git.geoff@infradead.org>
In-Reply-To: <cover.1380746425.git.geoff@infradead.org>
References: <cover.1380746425.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 2/6] kexec: Remove unused -? option handling
Date: Wed, 02 Oct 2013 20:49:46 +0000
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

The main kexec option code handles the -? option.  Remove all the
duplicate -? handlers in the arch code which are never used.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 kexec/arch/arm/kexec-zImage-arm.c     | 3 ---
 kexec/arch/cris/kexec-elf-cris.c      | 3 ---
 kexec/arch/i386/kexec-beoboot-x86.c   | 3 ---
 kexec/arch/i386/kexec-bzImage.c       | 4 ----
 kexec/arch/i386/kexec-elf-x86.c       | 3 ---
 kexec/arch/i386/kexec-multiboot-x86.c | 3 ---
 kexec/arch/i386/kexec-nbi.c           | 4 ----
 kexec/arch/ia64/kexec-elf-ia64.c      | 3 ---
 kexec/arch/mips/kexec-elf-mips.c      | 3 ---
 kexec/arch/ppc/kexec-dol-ppc.c        | 3 ---
 kexec/arch/ppc/kexec-elf-ppc.c        | 3 ---
 kexec/arch/ppc/kexec-uImage-ppc.c     | 3 ---
 kexec/arch/ppc64/kexec-elf-ppc64.c    | 3 ---
 kexec/arch/s390/kexec-image.c         | 4 ----
 kexec/arch/sh/kexec-elf-sh.c          | 3 ---
 kexec/arch/sh/kexec-netbsd-sh.c       | 3 ---
 kexec/arch/sh/kexec-sh.c              | 3 ---
 kexec/arch/sh/kexec-zImage-sh.c       | 3 ---
 kexec/arch/x86_64/kexec-bzImage64.c   | 4 ----
 kexec/arch/x86_64/kexec-elf-x86_64.c  | 3 ---
 20 files changed, 64 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index dd2e06f..bb1b002 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -263,9 +263,6 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
diff --git a/kexec/arch/cris/kexec-elf-cris.c b/kexec/arch/cris/kexec-elf-cris.c
index b48b7b3..7e251e6 100644
--- a/kexec/arch/cris/kexec-elf-cris.c
+++ b/kexec/arch/cris/kexec-elf-cris.c
@@ -107,9 +107,6 @@ int elf_cris_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
diff --git a/kexec/arch/i386/kexec-beoboot-x86.c b/kexec/arch/i386/kexec-beoboot-x86.c
index a65e094..b121834 100644
--- a/kexec/arch/i386/kexec-beoboot-x86.c
+++ b/kexec/arch/i386/kexec-beoboot-x86.c
@@ -103,9 +103,6 @@ int beoboot_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_REAL_MODE:
 			real_mode_entry = 1;
 			break;
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index c2a82b7..fc1a54f 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -413,10 +413,6 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
-			break;
 		case OPT_APPEND:
 			append = optarg;
 			break;
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index 9751a76..d0f9838 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -133,9 +133,6 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			append = optarg;
 			break;
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 4520fd7..2f59d7b 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -188,9 +188,6 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_CL:
 			append = optarg;
 			break;
diff --git a/kexec/arch/i386/kexec-nbi.c b/kexec/arch/i386/kexec-nbi.c
index 443a3a7..8eb2154 100644
--- a/kexec/arch/i386/kexec-nbi.c
+++ b/kexec/arch/i386/kexec-nbi.c
@@ -177,10 +177,6 @@ int nbi_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
-			break;
 		}
 	}
 	/* Get a copy of the header */
diff --git a/kexec/arch/ia64/kexec-elf-ia64.c b/kexec/arch/ia64/kexec-elf-ia64.c
index 7303c03..142dee3 100644
--- a/kexec/arch/ia64/kexec-elf-ia64.c
+++ b/kexec/arch/ia64/kexec-elf-ia64.c
@@ -154,9 +154,6 @@ int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index 6951247..a27d986 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -100,9 +100,6 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
diff --git a/kexec/arch/ppc/kexec-dol-ppc.c b/kexec/arch/ppc/kexec-dol-ppc.c
index 8d0d1a0..800c072 100644
--- a/kexec/arch/ppc/kexec-dol-ppc.c
+++ b/kexec/arch/ppc/kexec-dol-ppc.c
@@ -355,9 +355,6 @@ int dol_ppc_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index df1b521..291f06d 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -208,9 +208,6 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			tmp_cmdline = optarg;
 			break;
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 83a7a5f..c89a1a7 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -118,9 +118,6 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			tmp_cmdline = optarg;
 			break;
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 9a0e69a..cc0531d 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -124,9 +124,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			/* Ignore core options */
 			if (opt < OPT_ARCH_MAX)
 				break;
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			cmdline = optarg;
 			break;
diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index e49b75b..be1e0f8 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -72,10 +72,6 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 
 	while ((opt = getopt_long(argc,argv,short_options,options,0)) != -1) {
 		switch(opt) {
-		case '?':
-			usage();
-			return -1;
-			break;
 		case OPT_APPEND:
 			if (command_line_add(optarg))
 				return -1;
diff --git a/kexec/arch/sh/kexec-elf-sh.c b/kexec/arch/sh/kexec-elf-sh.c
index 1186c09..897552c 100644
--- a/kexec/arch/sh/kexec-elf-sh.c
+++ b/kexec/arch/sh/kexec-elf-sh.c
@@ -92,9 +92,6 @@ int elf_sh_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
diff --git a/kexec/arch/sh/kexec-netbsd-sh.c b/kexec/arch/sh/kexec-netbsd-sh.c
index 8a7e75e..ed93759 100644
--- a/kexec/arch/sh/kexec-netbsd-sh.c
+++ b/kexec/arch/sh/kexec-netbsd-sh.c
@@ -83,9 +83,6 @@ int netbsd_sh_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_NBSD_HOWTO:
 			howto = optarg;
 			break;
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index ea56041..aea5dfb 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -117,9 +117,6 @@ int arch_process_options(int argc, char **argv)
 			if (opt < OPT_MAX) {
 				break;
 			}
-		case '?':
-		        usage();
-		  	return -1;
 		case OPT_APPEND:
 		case OPT_NBSD_HOWTO:
 		case OPT_NBSD_MROOT:
diff --git a/kexec/arch/sh/kexec-zImage-sh.c b/kexec/arch/sh/kexec-zImage-sh.c
index 7399052..6dc2c13 100644
--- a/kexec/arch/sh/kexec-zImage-sh.c
+++ b/kexec/arch/sh/kexec-zImage-sh.c
@@ -94,9 +94,6 @@ int zImage_sh_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index 01bd9d9..a7b9f15 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -261,10 +261,6 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 			/* Ignore core options */
 			if (opt < OPT_ARCH_MAX)
 				break;
-		case '?':
-			usage();
-			return -1;
-			break;
 		case OPT_APPEND:
 			append = optarg;
 			break;
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index 7944be4..ae65692 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -131,9 +131,6 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 				break;
 			}
 			fprintf(stderr, "Unknown option: opt: %d\n", opt);
-		case '?':
-			usage();
-			return -1;
 		case OPT_APPEND:
 			append = optarg;
 			break;
-- 
1.8.1.2



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
