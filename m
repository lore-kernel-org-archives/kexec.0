Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com
 ([40.107.243.88] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZEgN-00Czhb-DF
 for kexec@lists.infradead.org; Wed, 21 Apr 2021 15:22:31 +0000
Date: Wed, 21 Apr 2021 15:22:20 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v13 12/12] x86/kvm: Add guest support for detecting and
 enabling SEV Live Migration feature.
Message-ID: <20210421152220.GB14004@ashkalra_ubuntu_server>
References: <cover.1618498113.git.ashish.kalra@amd.com>
 <ffd67dbc1ae6d3505d844e65928a7248ebaebdcc.1618498113.git.ashish.kalra@amd.com>
 <20210421144402.GB5004@zn.tnic>
Content-Disposition: inline
In-Reply-To: <20210421144402.GB5004@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, srutherford@google.com, seanjc@google.com, venu.busireddy@oracle.com, brijesh.singh@amd.com, kexec@lists.infradead.org

On Wed, Apr 21, 2021 at 04:44:02PM +0200, Borislav Petkov wrote:
> On Thu, Apr 15, 2021 at 04:01:16PM +0000, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> > 
> > The guest support for detecting and enabling SEV Live migration
> > feature uses the following logic :
> > 
> >  - kvm_init_plaform() invokes check_kvm_sev_migration() which
> >    checks if its booted under the EFI
> > 
> >    - If not EFI,
> > 
> >      i) check for the KVM_FEATURE_CPUID
> 
> Where do you do that?
> 
> $ git grep KVM_FEATURE_CPUID
> $
> 
> Do you mean
> 
> 	kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION)
> 
> per chance?
> 

Yes, the above mentions to get KVM_FEATURE_CPUID and then check if live
migration feature is supported, i.e.,
kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION). The above comments
are written more generically.

> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 78bb0fae3982..94ef16d263a7 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/kprobes.h>
> >  #include <linux/nmi.h>
> >  #include <linux/swait.h>
> > +#include <linux/efi.h>
> >  #include <asm/timer.h>
> >  #include <asm/cpu.h>
> >  #include <asm/traps.h>
> > @@ -429,6 +430,59 @@ static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
> >  	early_set_memory_decrypted((unsigned long) ptr, size);
> >  }
> >  
> > +static int __init setup_kvm_sev_migration(void)
> 
> kvm_init_sev_migration() or so.
> 
> ...
> 
> > @@ -48,6 +50,8 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
> >  
> >  bool sev_enabled __section(".data");
> >  
> > +bool sev_live_migration_enabled __section(".data");
> 
> Pls add a function called something like:
> 
> bool sev_feature_enabled(enum sev_feature)
> 
> and gets SEV_FEATURE_LIVE_MIGRATION and then use it instead of adding
> yet another boolean which contains whether some aspect of SEV has been
> enabled or not.
> 
> Then add a
> 
> static enum sev_feature sev_features;
> 
> in mem_encrypt.c and that function above will query that sev_features
> enum for set flags.
> 
> Then, if you feel bored, you could convert sme_active, sev_active,
> sev_es_active, mem_encrypt_active and whetever else code needs to query
> any aspect of SEV being enabled or not, to that function.
> 

Ok.

> > +void __init check_kvm_sev_migration(void)
> > +{
> > +	if (sev_active() &&
> > +	    kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION)) {
> 
> Save an indentation level:
> 
> 	if (!sev_active() ||
> 	    !kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION))
> 		return;
> 
> > +		unsigned long nr_pages;
> > +		int i;
> > +
> > +		pr_info("KVM enable live migration\n");
> 
> That should be at the end of the function and say:
> 
> 		pr_info("KVM live migration enabled.\n");
> 
> > +		WRITE_ONCE(sev_live_migration_enabled, true);
> 
> Why WRITE_ONCE?
> 

Just to ensure that the sev_live_migration_enabled is set to TRUE before
it is used immediately next in the function.

Thanks,
Ashish

> And that needs to go to the end of the function too.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CAshish.Kalra%40amd.com%7Cfe47697d718c4326b62108d904d3e9ad%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637546130496140162%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=d%2F%2Bx8t8R7zJclA7ENc%2Fxwt5%2FU13m%2FWObem2Hq8yH190%3D&amp;reserved=0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
