Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKD4h-0005Hx-Vh
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 20:01:12 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 1/5] purgatory: put variables altered by kexec in .data not
 .bss
Date: Thu, 12 Sep 2013 21:00:38 +0100
Message-ID: <1379016042-22510-2-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1379016042-22510-1-git-send-email-david.vrabel@citrix.com>
References: <1379016042-22510-1-git-send-email-david.vrabel@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

elf_rel_set_symbol() fails if the symbol is in the .bss section.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 purgatory/arch/i386/console-x86.c        |    6 +++---
 purgatory/arch/i386/crashdump_backup.c   |    8 +++++---
 purgatory/arch/x86_64/purgatory-x86_64.c |    6 +++---
 purgatory/include/purgatory.h            |    4 ++++
 purgatory/purgatory.c                    |    4 ++--
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/purgatory/arch/i386/console-x86.c b/purgatory/arch/i386/console-x86.c
index 9773573..40a734b 100644
--- a/purgatory/arch/i386/console-x86.c
+++ b/purgatory/arch/i386/console-x86.c
@@ -55,9 +55,9 @@ static void putchar_vga(int ch)
  */
 
 /* Base Address */
-uint8_t console_serial = 0;
-uint16_t serial_base = 0x3f8; /* TTYS0 */
-uint32_t serial_baud = 0;
+uint8_t console_serial __data = 0;
+uint16_t serial_base __data = 0x3f8; /* TTYS0 */
+uint32_t serial_baud __data = 0;
 
 #define XMTRDY          0x20
 
diff --git a/purgatory/arch/i386/crashdump_backup.c b/purgatory/arch/i386/crashdump_backup.c
index 365eb5d..0438a75 100644
--- a/purgatory/arch/i386/crashdump_backup.c
+++ b/purgatory/arch/i386/crashdump_backup.c
@@ -21,13 +21,15 @@
 #include <stdint.h>
 #include <string.h>
 
+#include <purgatory.h>
+
 /* Backup region start gets set after /proc/iomem has been parsed. */
 /* We reuse the same code for x86_64 also so changing backup_start to
    unsigned long */
-unsigned long  backup_start = 0;
+unsigned long  backup_start __data = 0;
 
-unsigned long backup_src_start = 0;
-unsigned long backup_src_size = 0;
+unsigned long backup_src_start __data = 0;
+unsigned long backup_src_size __data = 0;
 
 /* Backup first 640K of memory to backup region as reserved by kexec.
  * Assuming first 640K has to be present on i386 machines and no address
diff --git a/purgatory/arch/x86_64/purgatory-x86_64.c b/purgatory/arch/x86_64/purgatory-x86_64.c
index c25a9c2..8a3e24d 100644
--- a/purgatory/arch/x86_64/purgatory-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-x86_64.c
@@ -3,11 +3,11 @@
 #include <purgatory.h>
 #include "purgatory-x86_64.h"
 
-uint8_t reset_vga = 0;
+uint8_t reset_vga __data = 0;
 uint8_t legacy_pic = 0;
-uint8_t panic_kernel = 0;
+uint8_t panic_kernel __data = 0;
 unsigned long jump_back_entry = 0;
-char *cmdline_end = NULL;
+char *cmdline_end __data = NULL;
 
 void setup_arch(void)
 {
diff --git a/purgatory/include/purgatory.h b/purgatory/include/purgatory.h
index ed50dc4..e2b061a 100644
--- a/purgatory/include/purgatory.h
+++ b/purgatory/include/purgatory.h
@@ -1,6 +1,10 @@
 #ifndef PURGATORY_H
 #define PURGATORY_H
 
+/* Force variables that are adjusted by kexec to be in .data not
+   .bss. */
+#define __data __attribute__((section("data")))
+
 void putchar(int ch);
 void sprintf(char *buffer, const char *fmt, ...);
 void printf(const char *fmt, ...);
diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
index 3bbcc09..05f3b48 100644
--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -6,8 +6,8 @@
 #include <string.h>
 #include "../kexec/kexec-sha256.h"
 
-struct sha256_region sha256_regions[SHA256_REGIONS] = {};
-sha256_digest_t sha256_digest = { };
+struct sha256_region sha256_regions[SHA256_REGIONS] __data = {};
+sha256_digest_t sha256_digest __data = { };
 
 int verify_sha256_digest(void)
 {
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
