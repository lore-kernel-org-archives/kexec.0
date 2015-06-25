Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z83vV-00080N-W9
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 09:58:34 +0000
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 0/5] Drivers: hv: add kexec support (and fix kdump)
Date: Thu, 25 Jun 2015 11:58:01 +0200
Message-Id: <1435226286-24842-1-git-send-email-vkuznets@redhat.com>
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
To: devel@linuxdriverproject.org
Cc: Olaf Hering <olaf@aepfle.de>, Greg KH <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>

Changes since v2:
- Get rid of #ifdefs in mshyperv.c [Olaf Hering, Greg KH]
  PATCH 2/5 is added to support the change.
- Fix (also broken) kdump [K. Y. Srinivasan]
  PATCH 5/5 added.

Changes since v1:
- rebased on top of current Greg's char-misc-next tree.

To make general-purpose kexec (not just kdump) possible for Hyper-V guests
we need to perform some additional cleanup before starting new kernel (see
[PATCH 3/5] for the detailed description). Kdump also requires some
mandatory cleanup [PATCH 5/5]

Know limitations: kexec with balloned out memory is not possible as the
newly loaded kernel doesn't know about this memory and there is no way to
ask the host to bring all the memory back on cleanup (or at least I'm not
aware of such a way). Kexec with hotplugged memory leads to reboot (not
exactly sure why).

Vitaly Kuznetsov (5):
  Drivers: hv: vmbus: remove hv_synic_free_cpu() call from
    hv_synic_cleanup()
  kexec: define kexec_in_progress in !CONFIG_KEXEC case
  Drivers: hv: vmbus: add special kexec handler
  Drivers: hv: don't do hypercalls when hypercall_page is NULL
  Drivers: hv: vmbus: add special crash handler

 arch/x86/include/asm/mshyperv.h |  4 ++++
 arch/x86/kernel/cpu/mshyperv.c  | 46 +++++++++++++++++++++++++++++++++++++++++
 drivers/hv/hv.c                 | 15 +++++++-------
 drivers/hv/vmbus_drv.c          | 29 ++++++++++++++++++++++++++
 include/linux/kexec.h           |  1 +
 5 files changed, 88 insertions(+), 7 deletions(-)

-- 
2.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
