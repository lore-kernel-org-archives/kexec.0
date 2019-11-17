Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iWULH-00024M-MM
 for kexec@lists.infradead.org; Sun, 17 Nov 2019 23:52:33 +0000
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] kexec: build multiboot2 for i386
Date: Mon, 18 Nov 2019 12:52:15 +1300
Message-Id: <20191117235215.18159-1-chris.packham@alliedtelesis.co.nz>
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
Cc: horms@verge.net.au, Chris Packham <chris.packham@alliedtelesis.co.nz>

This addresses the following compilation issues when building for i386.

 kexec/arch/i386/kexec-x86.c:39:22: error: 'multiboot2_x86_probe' undeclared here (not in a function); did you mean 'multiboot_x86_probe'?
   { "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
                       ^~~~~~~~~~~~~~~~~~~~
                       multiboot_x86_probe
 kexec/arch/i386/kexec-x86.c:39:44: error: 'multiboot2_x86_load' undeclared here (not in a function); did you mean 'multiboot_x86_load'?
   { "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
                                             ^~~~~~~~~~~~~~~~~~~
                                             multiboot_x86_load
 kexec/arch/i386/kexec-x86.c:40:4: error: 'multiboot2_x86_usage' undeclared here (not in a function); did you mean 'multiboot_x86_usage'?
     multiboot2_x86_usage },
     ^~~~~~~~~~~~~~~~~~~~
     multiboot_x86_usage
 make: *** [Makefile:114: kexec/arch/i386/kexec-x86.o] Error 1
 make: *** Waiting for unfinished jobs....

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
I wasn't sure whether this should be fixed by linking with kexec-mb2-x86.o or
by removing the code from kexec-x86.c. I went for the former but I'd happily
change to the latter.

 kexec/arch/i386/Makefile    | 2 +-
 kexec/arch/i386/kexec-x86.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/i386/Makefile b/kexec/arch/i386/Makefile
index 105cefd..f486103 100644
--- a/kexec/arch/i386/Makefile
+++ b/kexec/arch/i386/Makefile
@@ -7,6 +7,7 @@ i386_KEXEC_SRCS += kexec/arch/i386/kexec-elf-x86.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-elf-rel-x86.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-bzImage.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
+i386_KEXEC_SRCS += kexec/arch/i386/kexec-mb2-x86.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
 i386_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
 i386_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
@@ -14,7 +15,6 @@ i386_KEXEC_SRCS += kexec/arch/i386/crashdump-x86.c
 
 dist += kexec/arch/i386/Makefile $(i386_KEXEC_SRCS)			\
 	kexec/arch/i386/crashdump-x86.h					\
-	kexec/arch/i386/kexec-mb2-x86.c					\
 	kexec/arch/i386/kexec-x86.h					\
 	kexec/arch/i386/x86-linux-setup.h				\
 	kexec/arch/i386/include/arch/options.h
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 1b58c3b..0f941df 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -60,6 +60,11 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void multiboot_x86_usage(void);
 
+int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info);
+void multiboot2_x86_usage(void);
+int multiboot2_x86_probe(const char *buf, off_t buf_len);
+
 int elf_x86_probe(const char *buf, off_t len);
 int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
-- 
2.24.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
