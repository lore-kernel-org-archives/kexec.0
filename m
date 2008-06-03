Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K3R1E-0002mT-JN
	for kexec@lists.infradead.org; Tue, 03 Jun 2008 07:33:21 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 310AF41530
	for <kexec@lists.infradead.org>; Tue,  3 Jun 2008 09:33:18 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Fix implicit declaration of inb/outb
Date: Tue,  3 Jun 2008 09:33:57 +0200
Message-Id: <1212478437-8935-1-git-send-email-bwalle@suse.de>
In-Reply-To: <e2ed954f0806021843r648e4276v6c0d49aa1f601e17@mail.gmail.com>
References: <e2ed954f0806021843r648e4276v6c0d49aa1f601e17@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>

This patch fixes following compiler warning:

    purgatory/arch/i386/console-x86.c:84: \
        warning: implicit declaration of function `outb'
    purgatory/arch/i386/console-x86.c:89: \
        warning: implicit declaration of function `inb'

Found on x86_64. The problem did not happen with i386.
Fix tested on x86_64-suse-linux and i586-suse-linux.

I also added __always_inline__ to make sure that the function gets always
inlined, regardless of optimisation compiler flags.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 purgatory/arch/i386/include/arch/io.h   |   42 ++++++++++++++++++++-----------
 purgatory/arch/x86_64/include/arch/io.h |   40 +++--------------------------
 2 files changed, 31 insertions(+), 51 deletions(-)

diff --git a/purgatory/arch/i386/include/arch/io.h b/purgatory/arch/i386/include/arch/io.h
index 13ad887..0a9430a 100644
--- a/purgatory/arch/i386/include/arch/io.h
+++ b/purgatory/arch/i386/include/arch/io.h
@@ -1,10 +1,11 @@
-#ifndef ARCH_IO_H
-#define ARCH_IO_H
+#ifndef ARCH_I386_IO_H
+#define ARCH_I386_IO_H
 
 #include <stdint.h>
 /* Helper functions for directly doing I/O */
 
-extern inline uint8_t inb(uint16_t port)
+static inline __attribute__((__always_inline__))
+uint8_t inb(uint16_t port)
 {
 	uint8_t result;
 
@@ -15,7 +16,8 @@ extern inline uint8_t inb(uint16_t port)
 	return result;
 }
 
-extern inline uint16_t inw(uint16_t port)
+static inline __attribute__((__always_inline__))
+uint16_t inw(uint16_t port)
 {
 	uint16_t result;
 
@@ -26,7 +28,8 @@ extern inline uint16_t inw(uint16_t port)
 	return result;
 }
 
-extern inline uint32_t inl(uint32_t port)
+static inline __attribute__((__always_inline__))
+uint32_t inl(uint32_t port)
 {
 	uint32_t result;
 
@@ -37,7 +40,8 @@ extern inline uint32_t inl(uint32_t port)
 	return result;
 }
 
-extern inline void outb (uint8_t value, uint16_t port)
+static inline __attribute__((__always_inline__))
+void outb (uint8_t value, uint16_t port)
 {
 	__asm__ __volatile__ (
 		"outb %b0,%w1"
@@ -45,7 +49,8 @@ extern inline void outb (uint8_t value, uint16_t port)
 		:"a" (value), "Nd" (port));
 }
 
-extern inline void outw (uint16_t value, uint16_t port)
+static inline __attribute__((__always_inline__))
+void outw (uint16_t value, uint16_t port)
 {
 	__asm__ __volatile__ (
 		"outw %w0,%w1"
@@ -53,7 +58,8 @@ extern inline void outw (uint16_t value, uint16_t port)
 		:"a" (value), "Nd" (port));
 }
 
-extern inline void outl (uint32_t value, uint16_t port)
+static inline __attribute__((__always_inline__))
+void outl (uint32_t value, uint16_t port)
 {
 	__asm__ __volatile__ (
 		"outl %0,%w1"
@@ -69,30 +75,36 @@ extern inline void outl (uint32_t value, uint16_t port)
  * memory location directly.
  */
 
-static inline unsigned char readb(const volatile void  *addr)
+static inline __attribute__((__always_inline__))
+unsigned char readb(const volatile void  *addr)
 {
 	return *(volatile unsigned char *) addr;
 }
-static inline unsigned short readw(const volatile void  *addr)
+static inline __attribute__((__always_inline__))
+unsigned short readw(const volatile void  *addr)
 {
 	return *(volatile unsigned short *) addr;
 }
-static inline unsigned int readl(const volatile void  *addr)
+static inline __attribute__((__always_inline__))
+unsigned int readl(const volatile void  *addr)
 {
 	return *(volatile unsigned int *) addr;
 }
 
-static inline void writeb(unsigned char b, volatile void  *addr)
+static inline __attribute__((__always_inline__))
+void writeb(unsigned char b, volatile void  *addr)
 {
 	*(volatile unsigned char *) addr = b;
 }
-static inline void writew(unsigned short b, volatile void  *addr)
+static inline __attribute__((__always_inline__))
+void writew(unsigned short b, volatile void  *addr)
 {
 	*(volatile unsigned short *) addr = b;
 }
-static inline void writel(unsigned int b, volatile void  *addr)
+static inline __attribute__((__always_inline__))
+void writel(unsigned int b, volatile void  *addr)
 {
 	*(volatile unsigned int *) addr = b;
 }
 
-#endif /* ARCH_IO_H */
+#endif /* ARCH_I386_IO_H */
diff --git a/purgatory/arch/x86_64/include/arch/io.h b/purgatory/arch/x86_64/include/arch/io.h
index dcd01bf..464cd14 100644
--- a/purgatory/arch/x86_64/include/arch/io.h
+++ b/purgatory/arch/x86_64/include/arch/io.h
@@ -1,39 +1,7 @@
-#ifndef ARCH_IO_H
-#define ARCH_IO_H
+#ifndef ARCH_X86_64_IO_H
+#define ARCH_X86_64_IO_H
 
 #include <stdint.h>
+#include "../../../i386/include/arch/io.h"
 
-/*
- * readX/writeX() are used to access memory mapped devices. On some
- * architectures the memory mapped IO stuff needs to be accessed
- * differently. On the x86 architecture, we just read/write the
- * memory location directly.
- */
-
-static inline unsigned char readb(const volatile void  *addr)
-{
-	return *(volatile unsigned char *) addr;
-}
-static inline unsigned short readw(const volatile void  *addr)
-{
-	return *(volatile unsigned short *) addr;
-}
-static inline unsigned int readl(const volatile void  *addr)
-{
-	return *(volatile unsigned int *) addr;
-}
-
-static inline void writeb(unsigned char b, volatile void  *addr)
-{
-	*(volatile unsigned char *) addr = b;
-}
-static inline void writew(unsigned short b, volatile void  *addr)
-{
-	*(volatile unsigned short *) addr = b;
-}
-static inline void writel(unsigned int b, volatile void  *addr)
-{
-	*(volatile unsigned int *) addr = b;
-}
-
-#endif /* ARCH_IO_H */
+#endif /* ARCH_X86_64_IO_H */
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
