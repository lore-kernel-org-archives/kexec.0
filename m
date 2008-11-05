Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxoVG-0007gw-N8
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 19:57:23 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 00/15] x86: disable virt on kdump and emergency_restart (v2)
Date: Wed,  5 Nov 2008 17:56:43 -0200
Message-Id: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
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
To: Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Hi,

This is an updated version of the reboot/kdump virtualization disable
series that I've sent previously.

In short, the x86 and kdump changes are the same as before, except for
EXPORT_SYMBOL_GPL, and the KVM parts are completely different.

Details of changes since the previous series:

- Style fixes suggested by checkpatch
- Added local_irq_disable() to nmi_shootdown_cpus() (patch 08)
- Use EXPORT_SYMBOL_GPL() on set_virt_disable_func() &
  clear_virt_disable_func()
- Add comments to source code on places where emergency_virt_disable()
  is called, explaining why.
- kvm: Move the set_virt_disable_func() call to vmx.c and svm.c.
  This made the patch series shorter and removing one level
  of abstraction.

This series is against linux-next-20081105.

Patches 01-07 simply move the non-kdump-specific parts
of nmi_shootdown_cpus() to reboot.c, so it can be used by
emergency_restart(). They should be a no-op in relation to existing code.

Patch 08 adds an additional local_irq_disable() to nmi_shootdown_cpus(),
in case it is called with IRQs enabled.

Patch 09 adds the virt_disable function registering interface, like
the previous series.

Patch 10 hooks emergency_virt_disable() into kdump crash_shutdown code.

Patch 11 hooks emergency_virt_disable() into emergency_restart() using
nmi_shootdown_cpus().

Patches 12-14 change KVM so that it registers a virt_disable function
when loading.

Finally, patch 15 restore the previous reboot=kbd default.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
