Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR1Rb-0005xY-4K
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 09:06:03 +0000
Subject: [PATCH 5/6] kexec jump: fix for lockdep
From: Huang Ying <ying.huang@intel.com>
Date: Thu, 07 Aug 2008 17:05:35 +0800
Message-Id: <1218099935.5164.36.camel@caritas-dev.intel.com>
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

Replace local_irq_disable() with raw_local_irq_disable() to prevent
lockdep complain.

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 arch/x86/kernel/machine_kexec_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -130,7 +130,7 @@ void machine_kexec(struct kimage *image)
 #endif
 
 	/* Interrupts aren't acceptable while we reboot */
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
