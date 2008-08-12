Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KSkLG-0000Wb-Gb
	for kexec@lists.infradead.org; Tue, 12 Aug 2008 03:14:38 +0000
Subject: [PATCH -v3 5/7] kexec jump: in sync with hibernation implementation
From: Huang Ying <ying.huang@intel.com>
Date: Tue, 12 Aug 2008 11:14:33 +0800
Message-Id: <1218510873.24951.44.camel@caritas-dev.intel.com>
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

Add device_pm_lock() and device_pm_unlock() in kernel_kexec() in sync
with current hibernation implementation.

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 kernel/kexec.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1457,6 +1457,7 @@ int kernel_kexec(void)
 		error = disable_nonboot_cpus();
 		if (error)
 			goto Resume_devices;
+		device_pm_lock();
 		local_irq_disable();
 		/* At this point, device_suspend() has been called,
 		 * but *not* device_power_down(). We *must*
@@ -1485,6 +1486,7 @@ int kernel_kexec(void)
 		device_power_up(PMSG_RESTORE);
  Enable_irqs:
 		local_irq_enable();
+		device_pm_unlock();
 		enable_nonboot_cpus();
  Resume_devices:
 		device_resume(PMSG_RESTORE);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
