Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNJ9H-0004Lr-2g
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 12:20:20 +0000
Subject: [PATCH 2/2] Allow kdump with crash_kexec_post_notifiers
From: Petr Tesarik <ptesarik@suse.com>
Date: Wed, 13 Jul 2016 14:20:00 +0200
Message-ID: <20160713122000.14969.99963.stgit@hananiah.suse.cz>
In-Reply-To: <20160713121950.14969.78606.stgit@hananiah.suse.cz>
References: <20160713121950.14969.78606.stgit@hananiah.suse.cz>
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
To: Juergen Gross <jgross@suse.com>, Josh Triplett <josh@joshtriplett.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>
Cc: "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, "open list:KEXEC" <kexec@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>

If a crash kernel is loaded, do not crash the running domain. This is
needed if the kernel is loaded with crash_kexec_post_notifiers, because
panic notifiers are run before __crash_kexec() in that case, and this
Xen hook prevents its being called later.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/x86/xen/enlighten.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 760789a..6e3e7c6 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1325,7 +1325,8 @@ static void xen_crash_shutdown(struct pt_regs *regs)
 static int
 xen_panic_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
-	xen_reboot(SHUTDOWN_crash);
+	if (!kexec_crash_loaded())
+		xen_reboot(SHUTDOWN_crash);
 	return NOTIFY_DONE;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
