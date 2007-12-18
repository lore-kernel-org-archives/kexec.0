Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Y7l-0008E4-Up
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 08:48:32 +0000
MIME-Version: 1.0
Subject: [PATCH 3/8] Consolidate BOOTLOADER defines
Message-Id: <1197967675.857024.533881457160.3.gpush@pokey>
In-Reply-To: <1197967675.854275.930419561848.0.gpush@pokey>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 18 Dec 2007 17:47:55 +0900
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

The BOOTLOADER and BOOTLOADER_VERSION #defines are repeated in multiple
files. This change removes the unnecessary definition of these, and
keeps the kexec/kexec.h as the main source.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 kexec/arch/i386/kexec-multiboot-x86.c |    2 --
 kexec/arch/ppc/kexec-dol-ppc.c        |    2 --
 kexec/arch/ppc/kexec-elf-ppc.c        |    2 --
 kexec/arch/ppc64/kexec-elf-ppc64.c    |    3 ---
 4 files changed, 9 deletions(-)

diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 8ec8bba..5ad279a 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -61,8 +61,6 @@
 static char headerbuf[MULTIBOOT_SEARCH];
 static struct multiboot_header *mbh = NULL;
 
-#define BOOTLOADER "kexec"
-#define BOOTLOADER_VERSION VERSION
 #define MIN(_x,_y) (((_x)<=(_y))?(_x):(_y))
 
 
diff --git a/kexec/arch/ppc/kexec-dol-ppc.c b/kexec/arch/ppc/kexec-dol-ppc.c
index 1b34f2a..5e7e078 100644
--- a/kexec/arch/ppc/kexec-dol-ppc.c
+++ b/kexec/arch/ppc/kexec-dol-ppc.c
@@ -90,8 +90,6 @@ typedef struct {
 #define PAGE_MASK		(~((1 << PAGE_SHIFT) - 1))
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-#define BOOTLOADER         "kexec"
-#define BOOTLOADER_VERSION VERSION
 #define MAX_COMMAND_LINE   256
 
 #define UPSZ(X) ((sizeof(X) + 3) & ~3)
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index e5e5ebd..241c803 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -27,8 +27,6 @@
 
 static const int probe_debug = 0;
 
-#define BOOTLOADER         "kexec"
-#define BOOTLOADER_VERSION VERSION
 #define MAX_COMMAND_LINE   256
 
 #define UPSZ(X) ((sizeof(X) + 3) & ~3)
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 165a0f6..a8df885 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -39,9 +39,6 @@
 #include "crashdump-ppc64.h"
 #include <arch/options.h>
 
-#define BOOTLOADER         "kexec"
-#define BOOTLOADER_VERSION VERSION
-
 uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
 const char *ramdisk;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
