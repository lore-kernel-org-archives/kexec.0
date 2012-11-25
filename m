Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TcdAb-0007xp-ES
 for kexec@lists.infradead.org; Sun, 25 Nov 2012 14:26:54 +0000
Date: Sun, 25 Nov 2012 16:26:42 +0200
From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH v8 0/2] x86: vmclear vmcss on all cpus when doing kdump
 if necessary
Message-ID: <20121125142642.GC25516@redhat.com>
References: <50ADE0C2.1000106@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50ADE0C2.1000106@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>

On Thu, Nov 22, 2012 at 04:22:26PM +0800, Zhang Yanfei wrote:
> Currently, kdump just makes all the logical processors leave VMX operation by
> executing VMXOFF instruction, so any VMCSs active on the logical processors may
> be corrupted. But, sometimes, we need the VMCSs to debug guest images contained
> in the host vmcore. To prevent the corruption, we should VMCLEAR the VMCSs before
> executing the VMXOFF instruction.
> 
> The patch set provides a way to VMCLEAR vmcss related to guests on all cpus before
> executing the VMXOFF when doing kdump. This is used to ensure the VMCSs in the
> vmcore updated and non-corrupted.
> 
Looks fine to me, but kexec part should get acks from exec maintainers.

> Changelog from v7 to v8:
> 1. KEXEC: regression for using name crash_notifier_list
>    and remove comments related to KVM
>    and just call function atomic_notifier_call_chain directly.
> 
> Changelog from v6 to v7:
> 1. KVM-INTEL: in hardware_disable, we needn't disable the
>    vmclear, so remove it.
> 
> Changelog from v5 to v6:
> 1. KEXEC: the atomic notifier list renamed:
>    crash_notifier_list --> vmclear_notifier_list
> 2. KVM-INTEL: provide empty functions if CONFIG_KEXEC is
>    not defined and remove unnecessary #ifdef's.
> 
> Changelog from v4 to v5:
> 1. use an atomic notifier instead of function call, so
>    have all the vmclear codes in vmx.c.
> 
> Changelog from v3 to v4:
> 1. add a new percpu variable vmclear_skipped to skip
>    vmclear in kdump in some conditions.
> 
> Changelog from v2 to v3:
> 1. remove unnecessary conditions in function
>    cpu_emergency_clear_loaded_vmcss as Marcelo suggested.
> 
> Changelog from v1 to v2:
> 1. remove the sysctl and clear VMCSs unconditionally.
> 
> Zhang Yanfei (2):
>   x86/kexec: add a new atomic notifier list for kdump
>   KVM-INTEL: add a notifier and a bitmap to support VMCLEAR in kdump
> 
>  arch/x86/include/asm/kexec.h |    2 +
>  arch/x86/kernel/crash.c      |    9 +++++
>  arch/x86/kvm/vmx.c           |   70 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 0 deletions(-)

--
			Gleb.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
