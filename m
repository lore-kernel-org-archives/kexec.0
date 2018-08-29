Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fv1H0-0005eR-Rt
 for kexec@lists.infradead.org; Wed, 29 Aug 2018 14:16:45 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] Add restrictions for kexec/kdump jumping between 5-level
 and 4-level kernel
Date: Wed, 29 Aug 2018 22:16:21 +0800
Message-Id: <20180829141624.13985-1-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, kirill.shutemov@linux.intel.com
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

This was suggested by Kirill several months ago, I worked out several
patches to fix, then interrupted by other issues. So sort them out
now and post for reviewing.

The current upstream kernel supports 5-level paging mode and supports
dynamically choosing paging mode during bootup according to kernel
image, hardware and kernel parameter setting. This flexibility brings
several issues for kexec/kdump:
1)
Switching between paging modes, requires changes into target kernel.
It means you cannot kexec() 4-level paging kernel from 5-level paging
kernel if 4-level paging kernel doesn't include changes. 

2)
Switching from 5-level paging to 4-level paging kernel would fail, if
kexec() put kernel image above 64TiB of memory.

3)
Kdump jumping has similar issue as 2). This require us to only
reserve crashkernel below 64TB, otherwise jumping from 5-level to
4-level kernel will fail.

4)
The current kexec_load interface will put kernel at the top of system
RAM. This also need be restricted to be under 64TB. However this is not
an issue for kexec_file_load interface since it puts kernel at the top
of lowest 4GB. I ever planned to unify these two's behavior to put
kernel at top of system RAM the reason is we have been using the old
kexec_load, and still more widely than kexec_file_load. Just the change
involves too mamy lines of code change, seems people don't like it. Now
I decide to give up the unifying thing, just leave with it, and add the
restriction for kexec_load in kexec_tools unitilies. The unifying
behaviour patches are:

[PATCH v7 0/4] resource: Use list_head to link sibling resource
http://lkml.kernel.org/r/20180718024944.577-1-bhe@redhat.com

Note:
The issues 1), 2) need be done in kernel for kexec_file_load interface.
Meanwhile, 1), 2), and 4) need be done in user space kexec_tools
utility. I will post patches later for user space fix. Issue 3) can only
be done in kernel.

Baoquan He (3):
  x86/boot: Add bit fields into xloadflags for 5-level kernel checking
  x86/kexec/64: Error out if try to jump to old 4-level kernel from
    5-level kernel
  x86/kdump/64: Change the upper limit of crashkernel reservation

 arch/x86/boot/header.S                | 12 +++++++++++-
 arch/x86/include/uapi/asm/bootparam.h |  2 ++
 arch/x86/kernel/kexec-bzimage64.c     |  5 +++++
 arch/x86/kernel/setup.c               | 18 ++++++++++++++----
 4 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
