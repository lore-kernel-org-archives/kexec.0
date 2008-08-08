Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRLqF-0000Ze-GS
	for kexec@lists.infradead.org; Fri, 08 Aug 2008 06:52:51 +0000
Subject: [PATCH -v2 6/8] kexec jump: fix for lockdep
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 08 Aug 2008 14:52:45 +0800
Message-Id: <1218178365.22039.79.camel@caritas-dev.intel.com>
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
@@ -123,7 +123,7 @@ void machine_kexec(struct kimage *image)
 	tracer_disable();
 
 	/* Interrupts aren't acceptable while we reboot */
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
