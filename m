Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cEopE-0001ck-MD
 for kexec@lists.infradead.org; Thu, 08 Dec 2016 02:52:49 +0000
Date: Thu, 8 Dec 2016 10:52:22 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] kexec-tools/x86: get_kernel_vaddr_and_size off-by-one fix
Message-ID: <20161208025222.GA5427@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

I got below error while tesing kexec -p:
"Can't find kernel text map area from kcore"

The case is the pt_load start addr was same as stext_sym. The checking
code should really be saddr <= stext_sym so that the right pt_load area
includes stext_sym can be matched.

This was not reported by people previously because it will fail over to
use hardcode X86_64__START_KERNEL_map to match the pt_load areas again
in later code and it sometimes succeeds because of kernel address
randomization.

With this change according to my test stext_sym checking can garantee
falling into right pt_load area if we get correct stext_sym.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c
@@ -205,7 +205,7 @@ static int get_kernel_vaddr_and_size(str
 			unsigned long long size;
 
 			/* Look for kernel text mapping header. */
-			if (saddr < stext_sym && eaddr > stext_sym) {
+			if (saddr <= stext_sym && eaddr > stext_sym) {
 				saddr = _ALIGN_DOWN(saddr, X86_64_KERN_VADDR_ALIGN);
 				elf_info->kern_vaddr_start = saddr;
 				size = eaddr - saddr;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
