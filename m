Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxNHR-0007O5-CJ
	for kexec@lists.infradead.org; Tue, 04 Nov 2008 14:53:17 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 00/14] x86: disable virt on kdump and emergency_restart
Date: Tue,  4 Nov 2008 12:52:28 -0200
Message-Id: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
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

This is a new version of the series to disabling virtualization on kdump,
now extended to do the same tricks on emergency_restart() if needed.

This series is against linux-next-20081103.

Patches 01-07 simply move the non-kdump-specific parts
of nmi_shootdown_cpus() to reboot.c, so it can be used by
emergency_restart(). They should be a no-op in relation to existing code.

Patches 08 adds the virt_disable function registering interface, like
the previous series.

Patch 09 hooks emergency_virt_disable() into kdump crash_shutdown code.

Patch 10 hooks emergency_virt_disable() into emergency_restart() using
nmi_shootdown_cpus().

Patches 11-15 change KVM so that it registers a virt_disable function
when loading.

Finally, patch 16 restore the previous reboot=kbd default.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
