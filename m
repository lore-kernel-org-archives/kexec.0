Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L0gFC-000288-IJ
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 17:44:38 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 00/11] x86: disable virt on kdump and emergency_restart (v3)
Date: Thu, 13 Nov 2008 15:43:40 -0200
Message-Id: <1226598231-18311-1-git-send-email-ehabkost@redhat.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Hi,

This is a new spin of the series to disable vmx on kdump and on
emergency_restart. Now we avoid doing the function pointer stuff by
moving 4 small KVM functions to a header, as inline functions. The code
looks much simpler now, but we have to be more careful because some
additional code will run on kdump and reboot even when KVM is never
loaded.

I haven't tested the SVM changes on AMD CPUs. The changes are really
simple, but some testing is welcome.

This series is against tip.git#master, that already contains the
nmi_shootdown_cpus() changes I've submitted previously.


*Note: With this series, we will run the NMI stuff only when the CPU
where emergency_restart() was called has VMX enabled. This should work
on most cases because KVM enables VMX on all CPUs, but we may miss it if
we get called during the tiny window where KVM is enabling VMX.
Also, I don't know if all code using VMX out there always enable VMX on
all CPUs like KVM does.

We have two other alternatives for that:

a) Have an API that all code that enables VMX on any CPU should use
   to tell the kernel core that it is going to enable VMX on the CPUs.
b) Always call nmi_shootdown_cpus() if the CPU supports VMX. This is
   a bit intrusive and more risky, as it would unnecessarily run
   nmi_shootdown_cpus() on emergency_reboot() even on systems where
   virtualization is never enabled.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
