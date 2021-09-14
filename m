Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPzVg-00464t-TN
 for kexec@lists.infradead.org; Tue, 14 Sep 2021 03:53:30 +0000
From: Zhaofeng Li <hello@zhaofeng.li>
Subject: [PATCH v2 1/5] x86: Consolidate elf_x86_probe routines
Date: Mon, 13 Sep 2021 20:51:38 -0700
Message-Id: <20210914035142.251818-2-hello@zhaofeng.li>
In-Reply-To: <20210914035142.251818-1-hello@zhaofeng.li>
References: <20210914035142.251818-1-hello@zhaofeng.li>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: Zhaofeng Li <hello@zhaofeng.li>, Simon Horman <horms@verge.net.au>

Signed-off-by: Zhaofeng Li <hello@zhaofeng.li>
---
 kexec/arch/i386/kexec-elf-x86.c      | 44 +++++++++++++++++++++++-----
 kexec/arch/i386/kexec-x86.h          |  1 +
 kexec/arch/x86_64/kexec-elf-x86_64.c | 28 ++----------------
 3 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index fedf031..8eba242 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -42,7 +42,7 @@
 
 static const int probe_debug = 0;
 
-int elf_x86_probe(const char *buf, off_t len)
+int elf_x86_any_probe(const char *buf, off_t len, enum coretype arch)
 {
 	
 	struct mem_ehdr ehdr;
@@ -56,20 +56,50 @@ int elf_x86_probe(const char *buf, off_t len)
 	}
 
 	/* Verify the architecuture specific bits */
-	if ((ehdr.e_machine != EM_386) && (ehdr.e_machine != EM_486)) {
-		/* for a different architecture */
-		if (probe_debug) {
-			fprintf(stderr, "Not i386 ELF executable\n");
+	switch (arch) {
+	case CORE_TYPE_ELF32:
+		if ((ehdr.e_machine != EM_386) && (ehdr.e_machine != EM_486)) {
+			if (probe_debug)
+				fprintf(stderr, "Not i386 ELF executable\n");
+			result = -1;
+			goto out;
 		}
-		result = -1;
-		goto out;
+		break;
+
+	case CORE_TYPE_ELF64:
+		if (ehdr.e_machine != EM_X86_64) {
+			if (probe_debug)
+				fprintf(stderr, "Not x86_64 ELF executable\n");
+			result = -1;
+			goto out;
+		}
+		break;
+
+	case CORE_TYPE_UNDEF:
+	default:
+		if (
+			(ehdr.e_machine != EM_386) &&
+			(ehdr.e_machine != EM_486) &&
+			(ehdr.e_machine != EM_X86_64)
+		) {
+			if (probe_debug)
+				fprintf(stderr, "Not i386 or x86_64 ELF executable\n");
+			result = -1;
+			goto out;
+		}
+		break;
 	}
+
 	result = 0;
  out:
 	free_elf_info(&ehdr);
 	return result;
 }
 
+int elf_x86_probe(const char *buf, off_t len) {
+	return elf_x86_any_probe(buf, len, CORE_TYPE_ELF32);
+}
+
 void elf_x86_usage(void)
 {
 	printf(	"    --command-line=STRING Set the kernel command line to STRING\n"
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 0f941df..71e4329 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -66,6 +66,7 @@ void multiboot2_x86_usage(void);
 int multiboot2_x86_probe(const char *buf, off_t buf_len);
 
 int elf_x86_probe(const char *buf, off_t len);
+int elf_x86_any_probe(const char *buf, off_t len, enum coretype arch);
 int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_x86_usage(void);
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index ad22311..7f9540a 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -37,37 +37,13 @@
 #include "../../kexec-elf-boot.h"
 #include "../i386/x86-linux-setup.h"
 #include "kexec-x86_64.h"
+#include "../i386/kexec-x86.h"
 #include "../i386/crashdump-x86.h"
 #include <arch/options.h>
 
-static const int probe_debug = 0;
-
 int elf_x86_64_probe(const char *buf, off_t len)
 {
-	
-	struct mem_ehdr ehdr;
-	int result;
-	result = build_elf_exec_info(buf, len, &ehdr, 0);
-	if (result < 0) {
-		if (probe_debug) {
-			fprintf(stderr, "Not an ELF executable\n");
-		}
-		goto out;
-	}
-
-	/* Verify the architecuture specific bits */
-	if (ehdr.e_machine != EM_X86_64) {
-		/* for a different architecture */
-		if (probe_debug) {
-			fprintf(stderr, "Not x86_64 ELF executable\n");
-		}
-		result = -1;
-		goto out;
-	}
-	result = 0;
- out:
-	free_elf_info(&ehdr);
-	return result;
+	return elf_x86_any_probe(buf, len, CORE_TYPE_ELF64);
 }
 
 void elf_x86_64_usage(void)
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
