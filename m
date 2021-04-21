Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZE5M-00Cy9Q-PN
 for kexec@lists.infradead.org; Wed, 21 Apr 2021 14:44:16 +0000
Date: Wed, 21 Apr 2021 16:44:02 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v13 12/12] x86/kvm: Add guest support for detecting and
 enabling SEV Live Migration feature.
Message-ID: <20210421144402.GB5004@zn.tnic>
References: <cover.1618498113.git.ashish.kalra@amd.com>
 <ffd67dbc1ae6d3505d844e65928a7248ebaebdcc.1618498113.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ffd67dbc1ae6d3505d844e65928a7248ebaebdcc.1618498113.git.ashish.kalra@amd.com>
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
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, srutherford@google.com, seanjc@google.com, venu.busireddy@oracle.com, brijesh.singh@amd.com, kexec@lists.infradead.org

On Thu, Apr 15, 2021 at 04:01:16PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> The guest support for detecting and enabling SEV Live migration
> feature uses the following logic :
> 
>  - kvm_init_plaform() invokes check_kvm_sev_migration() which
>    checks if its booted under the EFI
> 
>    - If not EFI,
> 
>      i) check for the KVM_FEATURE_CPUID

Where do you do that?

$ git grep KVM_FEATURE_CPUID
$

Do you mean

	kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION)

per chance?

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 78bb0fae3982..94ef16d263a7 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -26,6 +26,7 @@
>  #include <linux/kprobes.h>
>  #include <linux/nmi.h>
>  #include <linux/swait.h>
> +#include <linux/efi.h>
>  #include <asm/timer.h>
>  #include <asm/cpu.h>
>  #include <asm/traps.h>
> @@ -429,6 +430,59 @@ static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
>  	early_set_memory_decrypted((unsigned long) ptr, size);
>  }
>  
> +static int __init setup_kvm_sev_migration(void)

kvm_init_sev_migration() or so.

...

> @@ -48,6 +50,8 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
>  
>  bool sev_enabled __section(".data");
>  
> +bool sev_live_migration_enabled __section(".data");

Pls add a function called something like:

bool sev_feature_enabled(enum sev_feature)

and gets SEV_FEATURE_LIVE_MIGRATION and then use it instead of adding
yet another boolean which contains whether some aspect of SEV has been
enabled or not.

Then add a

static enum sev_feature sev_features;

in mem_encrypt.c and that function above will query that sev_features
enum for set flags.

Then, if you feel bored, you could convert sme_active, sev_active,
sev_es_active, mem_encrypt_active and whetever else code needs to query
any aspect of SEV being enabled or not, to that function.

> +void __init check_kvm_sev_migration(void)
> +{
> +	if (sev_active() &&
> +	    kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION)) {

Save an indentation level:

	if (!sev_active() ||
	    !kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION))
		return;

> +		unsigned long nr_pages;
> +		int i;
> +
> +		pr_info("KVM enable live migration\n");

That should be at the end of the function and say:

		pr_info("KVM live migration enabled.\n");

> +		WRITE_ONCE(sev_live_migration_enabled, true);

Why WRITE_ONCE?

And that needs to go to the end of the function too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
