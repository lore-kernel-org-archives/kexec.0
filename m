Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmrER-0003hY-GZ
 for kexec@lists.infradead.org; Fri, 25 Jan 2019 02:28:37 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Date: Fri, 25 Jan 2019 10:28:14 +0800
Message-Id: <20190125022817.29506-1-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, mingo@kernel.org, kirill.shutemov@linux.intel.com

This is a RESEND post.

The original v1 post can be found here:
http://lkml.kernel.org/r/20180829141624.13985-1-bhe@redhat.com

It's trying to fix several corner case issues for kexec/kdump when
dynamic switching of paging mode is enabled in x86_64. Please click 
above link to check the details.

In v1, hpa raised concern that why the paging mode checking is not done
before kexec jumping, the discussion can be found here:

http://lkml.kernel.org/r/alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de

As tglx said, it might be not doable for kdump since kdump kernel's
reserved crashkernel region only owns a portion of memory, may
be above 4G; and might be not safer to do paging mode checking and
switching thing after crash.

So resend this patchset.

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
