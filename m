Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMLth-0002sn-Mx
 for kexec@lists.infradead.org; Thu, 09 Apr 2020 01:22:27 +0000
Date: Thu, 9 Apr 2020 09:22:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] KVM: VMX: fix crash cleanup when KVM wasn't used
Message-ID: <20200409012214.GB14381@MiWiFi-R3L-srv>
References: <20200401081348.1345307-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200401081348.1345307-1-vkuznets@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>, kexec@lists.infradead.org
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>

On 04/01/20 at 10:13am, Vitaly Kuznetsov wrote:
> If KVM wasn't used at all before we crash the cleanup procedure fails with
>  BUG: unable to handle page fault for address: ffffffffffffffc8
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 23215067 P4D 23215067 PUD 23217067 PMD 0
>  Oops: 0000 [#8] SMP PTI
>  CPU: 0 PID: 3542 Comm: bash Kdump: loaded Tainted: G      D           5.6.0-rc2+ #823
>  RIP: 0010:crash_vmclear_local_loaded_vmcss.cold+0x19/0x51 [kvm_intel]
> 
> The root cause is that loaded_vmcss_on_cpu list is not yet initialized,
> we initialize it in hardware_enable() but this only happens when we start
> a VM.
> 
> Previously, we used to have a bitmap with enabled CPUs and that was
> preventing [masking] the issue.
> 
> Initialized loaded_vmcss_on_cpu list earlier, right before we assign
> crash_vmclear_loaded_vmcss pointer. blocked_vcpu_on_cpu list and
> blocked_vcpu_on_cpu_lock are moved altogether for consistency.
> 
> Fixes: 31603d4fc2bb ("KVM: VMX: Always VMCLEAR in-use VMCSes during crash with kexec support")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Kdump kernel hang can be reproduced on a bare metal machine of Intel always,
issue disappeared with this patch applied. Feel free to add:

Tested-by: Baoquan He <bhe@redhat.com>

> ---
>  arch/x86/kvm/vmx/vmx.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3aba51d782e2..39a5dde12b79 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2257,10 +2257,6 @@ static int hardware_enable(void)
>  	    !hv_get_vp_assist_page(cpu))
>  		return -EFAULT;
>  
> -	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> -	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> -	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> -
>  	r = kvm_cpu_vmxon(phys_addr);
>  	if (r)
>  		return r;
> @@ -8006,7 +8002,7 @@ module_exit(vmx_exit);
>  
>  static int __init vmx_init(void)
>  {
> -	int r;
> +	int r, cpu;
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	/*
> @@ -8060,6 +8056,12 @@ static int __init vmx_init(void)
>  		return r;
>  	}
>  
> +	for_each_possible_cpu(cpu) {
> +		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> +		INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> +		spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> +	}
> +
>  #ifdef CONFIG_KEXEC_CORE
>  	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
>  			   crash_vmclear_local_loaded_vmcss);
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
