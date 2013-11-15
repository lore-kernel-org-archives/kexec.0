Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VhLmg-0005oC-IS
 for kexec@lists.infradead.org; Fri, 15 Nov 2013 15:58:15 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH] xen/kexec: Clear unused registers before jumping into an image
Date: Fri, 15 Nov 2013 16:56:14 +0100
Message-Id: <1384530974-26813-1-git-send-email-daniel.kiper@oracle.com>
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
To: andrew.cooper3@citrix.com, david.vrabel@citrix.com, ebiederm@xmission.com, george.dunlap@eu.citrix.com, jbeulich@suse.com, keir@xen.org, kexec@lists.infradead.org, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Clear unused registers before jumping into an image. This way
loaded image could not assume that any register has an specific
info about earlier running Xen hypervisor. However, it also
does not mean that the image may expect that a given register
is zeroed. The image MUST assume that every register has a random
value or in other words it is uninitialized or has undefined state.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 xen/arch/x86/x86_64/kexec_reloc.S |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/xen/arch/x86/x86_64/kexec_reloc.S b/xen/arch/x86/x86_64/kexec_reloc.S
index 7a16c85..e7eef79 100644
--- a/xen/arch/x86/x86_64/kexec_reloc.S
+++ b/xen/arch/x86/x86_64/kexec_reloc.S
@@ -71,6 +71,29 @@ identity_mapped:
         jnz     call_32_bit
 
 call_64_bit:
+        /*
+         * Clear unused registers before jumping into an image. This way
+         * loaded image could not assume that any register has an specific
+         * info about earlier running Xen hypervisor. However, it also
+         * does not mean that the image may expect that a given register
+         * is zeroed. The image MUST assume that every register has a random
+         * value or in other words it is uninitialized or has undefined state.
+         */
+        xorl    %eax, %eax
+        xorl    %ebx, %ebx
+        xorl    %ecx, %ecx
+        xorl    %edx, %edx
+        xorl    %esi, %esi
+        xorl    %edi, %edi
+        xorl    %r8d, %r8d
+        xorl    %r9d, %r9d
+        xorl    %r10d, %r10d
+        xorl    %r11d, %r11d
+        xorl    %r12d, %r12d
+        xorl    %r13d, %r13d
+        xorl    %r14d, %r14d
+        xorl    %r15d, %r15d
+
         /* Call the image entry point.  This should never return. */
         callq   *%rbp
         ud2
@@ -164,6 +187,20 @@ compatibility_mode:
         xorl    %eax, %eax
         movl    %eax, %cr4
 
+        /*
+         * Clear unused registers before jumping into an image. This way
+         * loaded image could not assume that any register has an specific
+         * info about earlier running Xen hypervisor. However, it also
+         * does not mean that the image may expect that a given register
+         * is zeroed. The image MUST assume that every register has a random
+         * value or in other words it is uninitialized or has undefined state.
+         */
+        xorl    %ebx, %ebx
+        xorl    %ecx, %ecx
+        xorl    %edx, %edx
+        xorl    %esi, %esi
+        xorl    %edi, %edi
+
         /* Call the image entry point.  This should never return. */
         call    *%ebp
         ud2
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
