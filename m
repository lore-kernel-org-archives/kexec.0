Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hskcB-0002Nn-LS
 for kexec@lists.infradead.org; Wed, 31 Jul 2019 09:09:45 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH] x86: Fix broken multiboot2 buliding for i386
Date: Wed, 31 Jul 2019 17:09:02 +0800
Message-Id: <20190731090902.29481-1-kasong@redhat.com>
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
Cc: Varad Gautam <vrd@amazon.de>, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Kairui Song <kasong@redhat.com>

When building for i386, an error occured:

kexec/arch/i386/kexec-x86.c:39:22: error: 'multiboot2_x86_probe'
undeclared here (not in a function); did you mean 'multiboot_x86_probe'?
39 |  { "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
   |                      ^~~~~~~~~~~~~~~~~~~~
   |                      multiboot_x86_probe

kexec/arch/i386/kexec-x86.c:39:44: error: 'multiboot2_x86_load'
undeclared here (not in a function); did you mean 'multiboot_x86_load'?
39 |  { "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
   |                                            ^~~~~~~~~~~~~~~~~~~
   |                                            multiboot_x86_load
kexec/arch/i386/kexec-x86.c:40:4: error: 'multiboot2_x86_usage'
 undeclared here (not in a function); did you mean 'multiboot_x86_usage'?
40 |    multiboot2_x86_usage },
   |    ^~~~~~~~~~~~~~~~~~~~
   |    multiboot_x86_usage

Fix this issue by putting the definition in the right header, also tidy
up Makefile.

Fixes: 22a2ed55132e ("x86: Support multiboot2 images")
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 kexec/arch/i386/Makefile         | 2 +-
 kexec/arch/i386/kexec-x86.h      | 5 +++++
 kexec/arch/x86_64/kexec-x86_64.h | 5 -----
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index 1b58c3b..16d0f6c 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -60,6 +60,11 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void multiboot_x86_usage(void);
 
+int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
+                       struct kexec_info *info);
+void multiboot2_x86_usage(void);
+int multiboot2_x86_probe(const char *buf, off_t buf_len);
+
 int elf_x86_probe(const char *buf, off_t len);
 int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
diff --git a/kexec/arch/x86_64/kexec-x86_64.h b/kexec/arch/x86_64/kexec-x86_64.h
index 21c3a73..4cdeffb 100644
--- a/kexec/arch/x86_64/kexec-x86_64.h
+++ b/kexec/arch/x86_64/kexec-x86_64.h
@@ -33,9 +33,4 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info);
 void bzImage64_usage(void);
 
-int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
-			struct kexec_info *info);
-void multiboot2_x86_usage(void);
-int multiboot2_x86_probe(const char *buf, off_t buf_len);
-
 #endif /* KEXEC_X86_64_H */
-- 
2.21.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
