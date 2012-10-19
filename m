Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TP5Mu-0007ve-SJ
 for kexec@lists.infradead.org; Fri, 19 Oct 2012 05:43:37 +0000
Message-ID: <5080E813.7030302@cn.fujitsu.com>
Date: Fri, 19 Oct 2012 13:41:39 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2 0/2] x86: clear vmcss on all cpus when doing kdump if
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
To: x86@kernel.org, kexec@lists.infradead.org, Avi Kivity <avi@redhat.com>, mtosatti@redhat.com
Cc: linux-kernel@vger.kernel.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

Currently, kdump just makes all the logical processors leave VMX operation by
executing VMXOFF instruction, so any VMCSs active on the logical processors may
be corrupted. But, sometimes, we need the VMCSs to debug guest images contained
in the host vmcore. To prevent the corruption, we should VMCLEAR the VMCSs before
executing the VMXOFF instruction.

The patch set provides a way to VMCLEAR vmcss related to guests on all cpus before
executing the VMXOFF when doing kdump. This is used to ensure the VMCSs in the
vmcore updated and non-corrupted.

Changelog from v1 to v2:
1. remove the sysctl and clear VMCSs unconditionally.

zhangyanfei (2):
  x86/kexec: VMCLEAR vmcss on all cpus if necessary
  KVM: make crash_clear_loaded_vmcss valid when loading kvm_intel
    module

 arch/x86/include/asm/kexec.h |    2 ++
 arch/x86/kernel/crash.c      |   27 +++++++++++++++++++++++++++
 arch/x86/kvm/vmx.c           |    9 +++++++++
 3 files changed, 38 insertions(+), 0 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
