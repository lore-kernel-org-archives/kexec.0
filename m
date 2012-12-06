Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TgdVT-0001oO-Ty
 for kexec@lists.infradead.org; Thu, 06 Dec 2012 15:37:00 +0000
Received: by mail-pb0-f49.google.com with SMTP id un15so4055604pbc.36
 for <kexec@lists.infradead.org>; Thu, 06 Dec 2012 07:36:57 -0800 (PST)
Message-ID: <50C0BB90.1080804@gmail.com>
Date: Thu, 06 Dec 2012 23:36:48 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH v11 0/2] x86: vmclear vmcss on all cpus when doing kdump if
 necessary
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

Currently, kdump just makes all the logical processors leave VMX operation by
executing VMXOFF instruction, so any VMCSs active on the logical processors may
be corrupted. But, sometimes, we need the VMCSs to debug guest images contained
in the host vmcore. To prevent the corruption, we should VMCLEAR the VMCSs before
executing the VMXOFF instruction.

The patch set provides a way to VMCLEAR vmcss related to guests on all cpus before
executing the VMXOFF when doing kdump. This is used to ensure the VMCSs in the
vmcore updated and non-corrupted.

Changelog from v10 to v11:
1. regenerate the patch set against current queue branch in
   git://git.kernel.org/pub/scm/virt/kvm/kvm.git

Changelog from v9 to v10:
1. add rcu protect to the callback function

Changelog from v8 to v9:
1. KEXEC: use a callback function instead of a notifier.
2. KVM-INTEL: use a new vmclear function instead of just calling 
   vmclear_local_loaded_vmcss to make sure we just do the core vmclear
   operation in kdump.

Changelog from v7 to v8:
1. KEXEC: regression for using name crash_notifier_list
   and remove comments related to KVM
   and just call function atomic_notifier_call_chain directly.

Changelog from v6 to v7:
1. KVM-INTEL: in hardware_disable, we needn't disable the
   vmclear, so remove it.

Changelog from v5 to v6:
1. KEXEC: the atomic notifier list renamed:
   crash_notifier_list --> vmclear_notifier_list
2. KVM-INTEL: provide empty functions if CONFIG_KEXEC is
   not defined and remove unnecessary #ifdef's.

Changelog from v4 to v5:
1. use an atomic notifier instead of function call, so
   have all the vmclear codes in vmx.c.

Changelog from v3 to v4:
1. add a new percpu variable vmclear_skipped to skip
   vmclear in kdump in some conditions.

Changelog from v2 to v3:
1. remove unnecessary conditions in function
   cpu_emergency_clear_loaded_vmcss as Marcelo suggested.

Changelog from v1 to v2:
1. remove the sysctl and clear VMCSs unconditionally.

Zhang Yanfei (2):
  x86/kexec: VMCLEAR VMCSs loaded on all cpus if necessary
  KVM-INTEL: provide the vmclear function and a bitmap to support
    VMCLEAR in kdump

 arch/x86/include/asm/kexec.h |    2 + 
 arch/x86/kernel/crash.c      |   32 ++++++++++++++++++++
 arch/x86/kvm/vmx.c           |   67 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 0 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
