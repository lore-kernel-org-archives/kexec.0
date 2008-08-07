Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR1R3-0005sN-Qj
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 09:05:30 +0000
Subject: [PATCH 2/6] kexec jump: check code size in control page
From: Huang Ying <ying.huang@intel.com>
Date: Thu, 07 Aug 2008 17:05:26 +0800
Message-Id: <1218099926.5164.33.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, nigel@nigel.suspend2.net, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, mingo@elte.hu, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org

Kexec/Kexec-jump requires code size in control page is less than
PAGE_SIZE/2. This patch adds runtime checking for this.

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 arch/x86/kernel/machine_kexec_32.c   |    4 ++++
 arch/x86/kernel/relocate_kernel_32.S |    3 +++
 include/asm-x86/kexec.h              |    1 +
 3 files changed, 8 insertions(+)

--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -92,6 +92,10 @@ int machine_kexec_prepare(struct kimage 
 {
 	if (nx_enabled)
 		set_pages_x(image->control_code_page, 1);
+
+	BUG_ON((unsigned long)kexec_control_page_code_end - \
+	       (unsigned long)relocate_kernel >= PAGE_SIZE/2);
+
 	return 0;
 }
 
--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -376,3 +376,6 @@ swap_pages:
 	popl	%ebx
 	popl	%ebp
 	ret
+
+	.globl kexec_control_page_code_end
+kexec_control_page_code_end:
--- a/include/asm-x86/kexec.h
+++ b/include/asm-x86/kexec.h
@@ -159,6 +159,7 @@ relocate_kernel(unsigned long indirectio
 		unsigned long start_address,
 		unsigned int has_pae,
 		unsigned int preserve_context);
+void kexec_control_page_code_end(void);
 #else
 NORET_TYPE void
 relocate_kernel(unsigned long indirection_page,



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
