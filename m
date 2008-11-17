Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L2BGX-0002wd-G5
	for kexec@lists.infradead.org; Mon, 17 Nov 2008 21:04:13 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 00/12] x86: disable virt on kdump and emergency_restart (v4)
Date: Mon, 17 Nov 2008 19:03:12 -0200
Message-Id: <1226955804-16802-1-git-send-email-ehabkost@redhat.com>
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

Hi, Ingo,

This is yet another spin of the series to disable vmx on kdump and on
emergency_restart, after some feedback from Avi.

The only change from v3 is that vmx.h and svm.h were moved from
arch/x86/kvm to arch/x86/include/asm, instead of moving code
from those headers to asm/virtext.h.

I haven't tested the SVM changes on AMD CPUs. The changes are really
simple, but some testing is welcome.

This series is against tip.git#master, that already contains the
nmi_shootdown_cpus() changes I've submitted previously.


For reference, this is the history of the patchset:

v1: Implemented the changes using a function pointer registering interface
    where KVM could hook the virt-disable functions
v2: Style fixes
v3: Implemented the changes by moving the virt-disable code from KVM
    to inline functions on asm/virtext.h
v4: Move KVM svm.h and vmx.h to include/asm, instead of moving
    pieces of their contents to asm/virtext.h

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
