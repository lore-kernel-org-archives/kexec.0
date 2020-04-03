Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKLtQ-000375-2z
 for kexec@lists.infradead.org; Fri, 03 Apr 2020 12:57:54 +0000
Date: Fri, 3 Apr 2020 20:57:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v6 14/14] KVM: x86: Add kexec support for SEV Live
 Migration.
Message-ID: <20200403123529.GA107255@dhcp-128-65.nay.redhat.com>
References: <cover.1585548051.git.ashish.kalra@amd.com>
 <0caf809845d2fdb1a1ec17955826df9777f502fb.1585548051.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0caf809845d2fdb1a1ec17955826df9777f502fb.1585548051.git.ashish.kalra@amd.com>
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
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: thomas.lendacky@amd.com, rientjes@google.com, brijesh.singh@amd.com, lijiang@redhat.com, kvm@vger.kernel.org, srutherford@google.com, joro@8bytes.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bhe@redhat.com, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, pbonzini@redhat.com, tglx@linutronix.de, bp@suse.de

Ccing kexec list.

Ashish, could you cc kexec list if you repost later?
On 03/30/20 at 06:23am, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Reset the host's page encryption bitmap related to kernel
> specific page encryption status settings before we load a
> new kernel by kexec. We cannot reset the complete
> page encryption bitmap here as we need to retain the
> UEFI/OVMF firmware specific settings.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kernel/kvm.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 8fcee0b45231..ba6cce3c84af 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -34,6 +34,7 @@
>  #include <asm/hypervisor.h>
>  #include <asm/tlb.h>
>  #include <asm/cpuidle_haltpoll.h>
> +#include <asm/e820/api.h>
>  
>  static int kvmapf = 1;
>  
> @@ -357,6 +358,33 @@ static void kvm_pv_guest_cpu_reboot(void *unused)
>  	 */
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
>  		wrmsrl(MSR_KVM_PV_EOI_EN, 0);
> +	/*
> +	 * Reset the host's page encryption bitmap related to kernel
> +	 * specific page encryption status settings before we load a
> +	 * new kernel by kexec. NOTE: We cannot reset the complete
> +	 * page encryption bitmap here as we need to retain the
> +	 * UEFI/OVMF firmware specific settings.
> +	 */
> +	if (kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION) &&
> +		(smp_processor_id() == 0)) {
> +		unsigned long nr_pages;
> +		int i;
> +
> +		for (i = 0; i < e820_table->nr_entries; i++) {
> +			struct e820_entry *entry = &e820_table->entries[i];
> +			unsigned long start_pfn, end_pfn;
> +
> +			if (entry->type != E820_TYPE_RAM)
> +				continue;
> +
> +			start_pfn = entry->addr >> PAGE_SHIFT;
> +			end_pfn = (entry->addr + entry->size) >> PAGE_SHIFT;
> +			nr_pages = DIV_ROUND_UP(entry->size, PAGE_SIZE);
> +
> +			kvm_sev_hypercall3(KVM_HC_PAGE_ENC_STATUS,
> +				entry->addr, nr_pages, 1);
> +		}
> +	}
>  	kvm_pv_disable_apf();
>  	kvm_disable_steal_time();
>  }
> -- 
> 2.17.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
