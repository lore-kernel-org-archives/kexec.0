Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KbUkG-0007L1-6N
	for kexec@lists.infradead.org; Fri, 05 Sep 2008 06:24:36 +0000
Date: Fri, 5 Sep 2008 16:24:34 +1000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] ia64: use generic put_unaligned()
Message-ID: <20080905062433.GC23955@verge.net.au>
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
Cc: Paul Mundt <lethal@linux-sh.org>

Now that put_unaligned() has been revived from the dead it can be used.

Signed-off-by: Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/ia64/kexec-elf-rel-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-elf-rel-ia64.c	2008-09-05 12:54:42.000000000 +1000
+++ kexec-tools/kexec/arch/ia64/kexec-elf-rel-ia64.c	2008-09-05 12:58:36.000000000 +1000
@@ -66,15 +66,6 @@ ia64_patch (uint64_t insn_addr, uint64_t
         b[1] = (b1 & ~m1) | (v1 & m1);
 }
 
-static void
-put_unaligned64(unsigned long val, unsigned char *location)
-{
-	unsigned char *src = (unsigned char *)&val;
-	int i;
-	for (i = 0; i < sizeof(long); i++)
-		*location++ = *src++;
-}
-
 static inline uint64_t
 bundle (const uint64_t insn)
 {
@@ -136,7 +127,7 @@ void machine_apply_elf_rel(struct mem_eh
 		break;
 	case R_IA64_PCREL64LSB: {
 		value = value - address;
-		put_unaligned64(value, location);
+		put_unaligned(value, (uint64_t *)location);
 	} break;
 	case R_IA64_GPREL22:
 	case R_IA64_LTOFF22X:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
