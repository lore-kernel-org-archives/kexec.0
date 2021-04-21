Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com
 ([40.107.93.71] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZHu3-00D6z6-0f
 for kexec@lists.infradead.org; Wed, 21 Apr 2021 18:48:50 +0000
Date: Wed, 21 Apr 2021 18:48:32 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v13 12/12] x86/kvm: Add guest support for detecting and
 enabling SEV Live Migration feature.
Message-ID: <20210421184832.GA14208@ashkalra_ubuntu_server>
References: <cover.1618498113.git.ashish.kalra@amd.com>
 <ffd67dbc1ae6d3505d844e65928a7248ebaebdcc.1618498113.git.ashish.kalra@amd.com>
 <20210421144402.GB5004@zn.tnic>
 <2d3170ae-470a-089d-bdec-a43f8190cce7@redhat.com>
Content-Disposition: inline
In-Reply-To: <2d3170ae-470a-089d-bdec-a43f8190cce7@redhat.com>
MIME-Version: 1.0
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, srutherford@google.com, seanjc@google.com, venu.busireddy@oracle.com, brijesh.singh@amd.com, kexec@lists.infradead.org

Hello Paolo,

The earlier patch#10 of SEV live migration patches which is now part of
the guest interface patches used to define
KVM_FEATURE_SEV_LIVE_MIGRATION. 

So now, will the guest patches need to define this feature ?

Thanks,
Ashish

On Wed, Apr 21, 2021 at 05:38:45PM +0200, Paolo Bonzini wrote:
> On 21/04/21 16:44, Borislav Petkov wrote:
> > On Thu, Apr 15, 2021 at 04:01:16PM +0000, Ashish Kalra wrote:
> > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > 
> > > The guest support for detecting and enabling SEV Live migration
> > > feature uses the following logic :
> > > 
> > >   - kvm_init_plaform() invokes check_kvm_sev_migration() which
> > >     checks if its booted under the EFI
> > > 
> > >     - If not EFI,
> > > 
> > >       i) check for the KVM_FEATURE_CPUID
> > 
> > Where do you do that?
> > 
> > $ git grep KVM_FEATURE_CPUID
> > $
> > 
> > Do you mean
> > 
> > 	kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION)
> > 
> > per chance?
> 
> Yep.  Or KVM_CPUID_FEATURES perhaps.
> 
> > 
> > > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > > index 78bb0fae3982..94ef16d263a7 100644
> > > --- a/arch/x86/kernel/kvm.c
> > > +++ b/arch/x86/kernel/kvm.c
> > > @@ -26,6 +26,7 @@
> > >   #include <linux/kprobes.h>
> > >   #include <linux/nmi.h>
> > >   #include <linux/swait.h>
> > > +#include <linux/efi.h>
> > >   #include <asm/timer.h>
> > >   #include <asm/cpu.h>
> > >   #include <asm/traps.h>
> > > @@ -429,6 +430,59 @@ static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
> > >   	early_set_memory_decrypted((unsigned long) ptr, size);
> > >   }
> > > +static int __init setup_kvm_sev_migration(void)
> > 
> > kvm_init_sev_migration() or so.
> > 
> > ...
> > 
> > > @@ -48,6 +50,8 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
> > >   bool sev_enabled __section(".data");
> > > +bool sev_live_migration_enabled __section(".data");
> > 
> > Pls add a function called something like:
> > 
> > bool sev_feature_enabled(enum sev_feature)
> > 
> > and gets SEV_FEATURE_LIVE_MIGRATION and then use it instead of adding
> > yet another boolean which contains whether some aspect of SEV has been
> > enabled or not.
> > 
> > Then add a
> > 
> > static enum sev_feature sev_features;
> > 
> > in mem_encrypt.c and that function above will query that sev_features
> > enum for set flags.
> 
> Even better: let's stop callings things SEV/SEV_ES.  Long term we want
> anyway to use things like mem_encrypt_enabled (SEV),
> guest_instruction_trap_enabled (SEV/ES), etc.
> 
> For this one we don't need a bool at all, we can simply check whether the
> pvop points to paravirt_nop.  Also keep everything but the BSS handling in
> arch/x86/kernel/kvm.c.  Only the BSS handling should be in
> arch/x86/mm/mem_encrypt.c.  This way all KVM paravirt hypercalls and MSRs
> are in kvm.c.
> 
> That is:
> 
> void kvm_init_platform(void)
> {
> 	if (sev_active() &&
> 	    kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION)) {
> 		pv_ops.mmu.notify_page_enc_status_changed =
> 			kvm_sev_hc_page_enc_status;
> 		/* this takes care of bss_decrypted */
> 		early_set_page_enc_status();
> 		if (!efi_enabled(EFI_BOOT))
> 			wrmsrl(MSR_KVM_SEV_LIVE_MIGRATION,
> 			       KVM_SEV_LIVE_MIGRATION_ENABLED);
> 	}
> 	/* existing kvm_init_platform code goes here */
> }
> 
> // the pvop is changed to take the pfn, so that the vaddr loop
> // is not KVM specific
> static inline void notify_page_enc_status_changed(unsigned long pfn,
> 				int npages, bool enc)
> {
> 	PVOP_VCALL3(mmu.page_encryption_changed, pfn, npages, enc);
> }
> 
> static void notify_addr_enc_status_changed(unsigned long addr,
> 					   int numpages, bool enc)
> {
> #ifdef CONFIG_PARAVIRT
> 	if (pv_ops.mmu.notify_page_enc_status_changed == paravirt_nop)
> 		return;
> 
> 	/* the body of set_memory_enc_dec_hypercall goes here */
> 	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
> 		...
> 		notify_page_enc_status_changed(pfn, psize >> PAGE_SHIFT,
> 					       enc);
> 		vaddr_next = (vaddr & pmask) + psize;
> 	}
> #endif
> }
> 
> static int __set_memory_enc_dec(unsigned long addr,
> 				int numpages, bool enc)
> {
> 	...
>  	cpa_flush(&cpa, 0);
> 	notify_addr_enc_status_changed(addr, numpages, enc);
>  	return ret;
> }
> 
> 
> > +static int __init setup_kvm_sev_migration(void)
> 
> Please rename this to include efi in the function name.
> 
> > 
> > +		 */
> > +		if (!efi_enabled(EFI_BOOT))
> > +			wrmsrl(MSR_KVM_SEV_LIVE_MIGRATION,
> > +			       KVM_SEV_LIVE_MIGRATION_ENABLED);
> > +		} else {
> > +			pr_info("KVM enable live migration feature unsupported\n");
> > +		}
> > +}
> 
> I think this pr_info is incorrect, because it can still be enabled in the
> late_initcall.  Just remove it as in the sketch above.
> 
> Paolo
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
