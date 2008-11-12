Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0FsL-0006yr-OW
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 13:35:18 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 0/8] Make nmi_shootdown_cpus() usable by non-kdump code
Date: Wed, 12 Nov 2008 11:34:36 -0200
Message-Id: <1226496884-24628-1-git-send-email-ehabkost@redhat.com>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Hi, Ingo,

As tip/master is a moving target, I am splitting the previous kdump/reboot
virtualization-disable code series[1] into smaller series so the simpler
parts can be included sooner. This first series is just for making
nmi_shootdown_cpus() usable by non-kdump code, by moving their generic
parts to reboot.c.

They are exactly the same patches I've sent as 01-08 in the previous
series.

The NMI IPIs method used by nmi_shootdown_cpus() is the only way
we can make sure VMX is disabled on all CPUs before rebooting, on
emergency_restart(), because CPUs may have IRQs disabled. That's why I
will reuse nmi_shootdown_cpus() for the emergency_restart code when
VMX is enabled.

The virtualization-specific parts should come soon, after I implement
the suggestions by Eric and Avi, by making the virtualization-disabling
functions inline so they can be used directly by the core code (instead
of using the function pointer tricks from my previous series).

[1] http://marc.info/?l=linux-kernel&m=122591590923455&w=2

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
