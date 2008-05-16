Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.242])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwtCn-0007SR-IV
	for kexec@lists.infradead.org; Fri, 16 May 2008 06:14:14 +0000
Received: by rv-out-0708.google.com with SMTP id b17so8620rvf.42
	for <kexec@lists.infradead.org>; Thu, 15 May 2008 23:14:12 -0700 (PDT)
Date: Thu, 15 May 2008 22:42:10 -0700
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH] Factor uname-based native architecture detection into a
	common function.
Message-ID: <20080516054210.GA21189@oh.minilop.net>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This code was copy-pasted into every architecture and was basically
identical.

Besides producing a nice net reduction in code, this factors a
portability challenge into a single function that can be easily replaced
at build-time.

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
This would allow arch_compat_trampoline to be simplified, since every
architecture besides i386 has only "return 0;" in the function body now.

Note: I can't confirm that this works on any architecture but i386.

 kexec/Makefile                   |    1 +
 kexec/arch/arm/kexec-arm.c       |   23 ++++-----------------
 kexec/arch/i386/kexec-x86.c      |   39 ++++++++++++-------------------------
 kexec/arch/ia64/kexec-ia64.c     |   23 ++++-----------------
 kexec/arch/mips/kexec-mips.c     |   29 +++++++--------------------
 kexec/arch/ppc/kexec-ppc.c       |   29 +++++++--------------------
 kexec/arch/ppc64/kexec-ppc64.c   |   29 +++++++--------------------
 kexec/arch/s390/kexec-s390.c     |    8 +++++-
 kexec/arch/sh/kexec-sh.c         |   34 +++++++++-----------------------
 kexec/arch/x86_64/kexec-x86_64.c |   29 +++++++--------------------
 kexec/kexec.c                    |    6 +++++
 kexec/kexec.h                    |    8 +++++++
 kexec/phys_arch.c                |   23 ++++++++++++++++++++++
 13 files changed, 109 insertions(+), 172 deletions(-)
 create mode 100644 kexec/phys_arch.c

diff --git a/kexec/Makefile b/kexec/Makefile
index 98fed4c..a80b940 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -20,6 +20,7 @@ KEXEC_SRCS += kexec/kexec-elf-boot.c
 KEXEC_SRCS += kexec/kexec-iomem.c
 KEXEC_SRCS += kexec/crashdump.c
 KEXEC_SRCS += kexec/crashdump-xen.c
+KEXEC_SRCS += kexec/phys_arch.c
 
 KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
 
diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 78a55e6..a7efdb0 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -12,7 +12,6 @@
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
-#include <sys/utsname.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-arm.h"
@@ -109,25 +108,13 @@ int arch_process_options(int argc, char **argv)
 	return 0;
 }
 
+const struct arch_map_entry arches[] = {
+	{ "arm", KEXEC_ARCH_ARM },
+	{ 0 },
+};
+
 int arch_compat_trampoline(struct kexec_info *info)
 {
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	if (strncmp(utsname.machine, "arm",3) == 0)
-	{
-		info->kexec_flags |= KEXEC_ARCH_ARM;
-	}
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
 	return 0;
 }
 
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 4a41fed..89ccb0b 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -25,7 +25,6 @@
 #include <limits.h>
 #include <stdlib.h>
 #include <getopt.h>
-#include <sys/utsname.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
 #include "../../kexec-syscall.h"
@@ -223,29 +222,22 @@ int arch_process_options(int argc, char **argv)
 	return 0;
 }
 
+const struct arch_map_entry arches[] = {
+	/* For compatibility with older patches
+	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_386 here.
+	 */
+	{ "i386", KEXEC_ARCH_DEFAULT },
+	{ "i486", KEXEC_ARCH_DEFAULT },
+	{ "i586", KEXEC_ARCH_DEFAULT },
+	{ "i686", KEXEC_ARCH_DEFAULT },
+	{ "x86_64", KEXEC_ARCH_X86_64 },
+	{ 0 },
+};
+
 int arch_compat_trampoline(struct kexec_info *info)
 {
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	if (	(strcmp(utsname.machine, "i386") == 0) ||
-		(strcmp(utsname.machine, "i486") == 0) ||
-		(strcmp(utsname.machine, "i586") == 0) ||
-		(strcmp(utsname.machine, "i686") == 0)) 
+	if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64)
 	{
-		/* For compatibility with older patches 
-		 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_386 here.
-		 */
-		info->kexec_flags |= KEXEC_ARCH_DEFAULT;
-	}
-	else if (strcmp(utsname.machine, "x86_64") == 0)
-	{
-		info->kexec_flags |= KEXEC_ARCH_X86_64;
 		if (!info->rhdr.e_shdr) {
 			fprintf(stderr, 
 				"A trampoline is required for cross architecture support\n");
@@ -256,11 +248,6 @@ int arch_compat_trampoline(struct kexec_info *info)
 		
 		info->entry = (void *)elf_rel_get_addr(&info->rhdr, "compat_x86_64");
 	}
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
 	return 0;
 }
 
diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
index fc27f4f..0aefea1 100644
--- a/kexec/arch/ia64/kexec-ia64.c
+++ b/kexec/arch/ia64/kexec-ia64.c
@@ -28,7 +28,6 @@
 #include <string.h>
 #include <getopt.h>
 #include <sched.h>
-#include <sys/utsname.h>
 #include <limits.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
@@ -204,25 +203,13 @@ int arch_process_options(int argc, char **argv)
 	return 0;
 }
 
+const struct arch_map_entry arches[] = {
+	{ "ia64", KEXEC_ARCH_IA_64 },
+	{ 0 },
+};
+
 int arch_compat_trampoline(struct kexec_info *info)
 {
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	if (strcmp(utsname.machine, "ia64") == 0)
-	{
-		info->kexec_flags |= KEXEC_ARCH_IA_64;
-	}
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
 	return 0;
 }
 
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index b17a20b..e4ec71b 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -16,7 +16,6 @@
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
-#include <sys/utsname.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-mips.h"
@@ -122,28 +121,16 @@ int arch_process_options(int argc, char **argv)
 	return 0;
 }
 
+const struct arch_map_entry arches[] = {
+	/* For compatibility with older patches
+	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_MIPS here.
+	 */
+	{ "mips", KEXEC_ARCH_DEFAULT },
+	{ 0 },
+};
+
 int arch_compat_trampoline(struct kexec_info *info)
 {
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	 if (strcmp(utsname.machine, "mips") == 0)
-	 {
-		 /* For compatibility with older patches
-		  * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_MIPS here.
-		  */
-		info->kexec_flags |= KEXEC_ARCH_DEFAULT;
-	 }
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
 	return 0;
 }
 
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index 96537f6..ef4fe35 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -12,7 +12,6 @@
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
-#include <sys/utsname.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-ppc.h"
@@ -76,28 +75,16 @@ int arch_process_options(int argc, char **argv)
 	return 0;
 }
 
+const struct arch_map_entry arches[] = {
+	/* For compatibility with older patches
+	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_PPC here.
+	 */
+	{ "ppc", KEXEC_ARCH_DEFAULT },
+	{ 0 },
+};
+
 int arch_compat_trampoline(struct kexec_info *info)
 {
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	if (strcmp(utsname.machine, "ppc") == 0)
-	{
-		/* For compatibility with older patches 
-		 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_PPC here.
-		 */
-		info->kexec_flags |= KEXEC_ARCH_DEFAULT;
-	}
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
 	return 0;
 }
 
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 2c74484..5f73469 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -28,7 +28,6 @@
 #include <sys/types.h>
 #include <dirent.h>
 #include <getopt.h>
-#include <sys/utsname.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-ppc64.h"
@@ -681,28 +680,16 @@ int arch_process_options(int argc, char **argv)
 	return 0;
 }
 
+const struct arch_map_entry arches[] = {
+	/* We are running a 32-bit kexec-tools on 64-bit ppc64.
+	 * So pass KEXEC_ARCH_PPC64 here
+	 */
+	{ "ppc64", KEXEC_ARCH_PPC64 },
+	{ 0 },
+};
+
 int arch_compat_trampoline(struct kexec_info *info)
 {
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	if (strcmp(utsname.machine, "ppc64") == 0)
-	{
-		/* We are running a 32-bit kexec-tools on 64-bit ppc64.
-		 * So pass KEXEC_ARCH_PPC64 here
-		 */
-		info->kexec_flags |= KEXEC_ARCH_PPC64;
-	}
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
 	return 0;
 }
 
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index 94a5d9e..15c2837 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -14,7 +14,6 @@
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
-#include <sys/utsname.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-s390.h"
@@ -95,9 +94,14 @@ int arch_process_options(int argc, char **argv)
 	return 0;
 }
 
+const struct arch_map_entry arches[] = {
+	{ "s390", KEXEC_ARCH_S390 },
+	{ "s390x", KEXEC_ARCH_S390 },
+	{ 0 },
+};
+
 int arch_compat_trampoline(struct kexec_info *info)
 {
-	info->kexec_flags |= KEXEC_ARCH_S390;
 	return 0;
 }
 
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 7050ccd..f0b5a76 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -14,7 +14,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <getopt.h>
-#include <sys/utsname.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-sh.h"
@@ -99,31 +98,18 @@ int arch_process_options(int argc, char **argv)
 	return 0;
 }
 
+const struct arch_map_entry arches[] = {
+	/* For compatibility with older patches
+	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_SH here.
+	 */
+	{ "sh3", KEXEC_ARCH_DEFAULT },
+	{ "sh4", KEXEC_ARCH_DEFAULT },
+	{ "sh4a", KEXEC_ARCH_DEFAULT },
+	{ 0 },
+};
+
 int arch_compat_trampoline(struct kexec_info *info)
 {
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	if (	(strcmp(utsname.machine, "sh3") == 0) ||
-		(strcmp(utsname.machine, "sh4") == 0) ||
-		(strcmp(utsname.machine, "sh4a") == 0))
-	{
-		/*
-		 * For compatibility with older patches
-		 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_SH here.
-		 */
-		info->kexec_flags |= KEXEC_ARCH_DEFAULT;
-	}
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
 	return 0;
 }
 
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index f222ec8..5fef6ef 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -25,7 +25,6 @@
 #include <limits.h>
 #include <stdlib.h>
 #include <getopt.h>
-#include <sys/utsname.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
 #include "../../kexec-syscall.h"
@@ -224,28 +223,16 @@ int arch_process_options(int argc, char **argv)
 	return 0;
 }
 
+const struct arch_map_entry arches[] = {
+	/* For compatibility with older patches
+	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_X86_64 here.
+	 */
+	{ "x86_64", KEXEC_ARCH_DEFAULT },
+	{ 0 },
+};
+
 int arch_compat_trampoline(struct kexec_info *info)
 {
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	if (strcmp(utsname.machine, "x86_64") == 0)
-	{
-		/* For compatibility with older patches 
-		 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_X86_64 here.
-		 */
-		info->kexec_flags |= KEXEC_ARCH_DEFAULT;
-	}
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
 	return 0;
 }
 
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 1da6c1e..0b02a3a 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -587,6 +587,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	int i = 0;
 	int result;
 	struct kexec_info info;
+	long native_arch;
 	int guess_only = 0;
 
 	memset(&info, 0, sizeof(info));
@@ -654,6 +655,11 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 		return -1;
 	}
 	/* If we are not in native mode setup an appropriate trampoline */
+	native_arch = physical_arch();
+	if (native_arch < 0) {
+		return -1;
+	}
+	info.kexec_flags |= native_arch;
 	if (arch_compat_trampoline(&info) < 0) {
 		return -1;
 	}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 9b45476..3724862 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -126,6 +126,14 @@ struct kexec_info {
 	unsigned long kern_size;
 };
 
+struct arch_map_entry {
+	const char *machine;
+	unsigned long arch;
+};
+
+extern const struct arch_map_entry arches[];
+long physical_arch(void);
+
 void usage(void);
 int get_memory_ranges(struct memory_range **range, int *ranges,
 						unsigned long kexec_flags);
diff --git a/kexec/phys_arch.c b/kexec/phys_arch.c
new file mode 100644
index 0000000..ff8c28b
--- /dev/null
+++ b/kexec/phys_arch.c
@@ -0,0 +1,23 @@
+#include "kexec.h"
+#include <errno.h>
+#include <string.h>
+#include <sys/utsname.h>
+
+long physical_arch(void)
+{
+	struct utsname utsname;
+	int i, result = uname(&utsname);
+	if (result < 0) {
+		fprintf(stderr, "uname failed: %s\n",
+			strerror(errno));
+		return -1;
+	}
+
+	for (i = 0; arches[i].machine; ++i)
+		if (strcmp(utsname.machine, arches[i].machine) == 0)
+			return arches[i].arch;
+
+	fprintf(stderr, "Unsupported machine type: %s\n",
+		utsname.machine);
+	return -1;
+}
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
