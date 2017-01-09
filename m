Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cQOXY-0004FC-9B
 for kexec@lists.infradead.org; Mon, 09 Jan 2017 01:14:27 +0000
Date: Mon, 9 Jan 2017 09:13:55 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH V3] purgatory: fix up declarations
Message-ID: <20170109011355.GA11654@dhcp-128-65.nay.redhat.com>
References: <1483806161-14841-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1483806161-14841-1-git-send-email-hofrat@osadl.org>
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
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

On 01/07/17 at 05:22pm, Nicholas Mc Guire wrote:
> Add the missing declarations of basic purgatory functions and variables
> to allow a clean build.
> 
> Fixes: commit 8fc5b4d4121c ("purgatory: core purgatory functionality")
> Link: http://lkml.org/lkml/2017/1/4/25
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> V2: after kbuild test robot <lkp@intel.com> reported a build failure
>     removed incorrect declaration of copy_backup_region which is static
>     anyway.
> 
> V3: move it all into purgatory.h as fixing up the declarations in the .c
>     file as suggested by Dave Young <dyoung@redhat.com>, fixes the sparse
>     warnings but then triggers a batch of checkpatch warnings. So the only
>     clear solution it seems is to move it to a dedicated .h file.
> 
> sparse complained about:
>   CHECK   arch/x86/purgatory/purgatory.c
> arch/x86/purgatory/purgatory.c:21:15: warning: symbol 'backup_dest' was not declared. Should it be static?
> arch/x86/purgatory/purgatory.c:22:15: warning: symbol 'backup_src' was not declared. Should it be static?
> arch/x86/purgatory/purgatory.c:23:15: warning: symbol 'backup_sz' was not declared. Should it be static?
> arch/x86/purgatory/purgatory.c:25:4: warning: symbol 'sha256_digest' was not declared. Should it be static?
> arch/x86/purgatory/purgatory.c:27:19: warning: symbol 'sha_regions' was not declared. Should it be static?
> arch/x86/purgatory/purgatory.c:42:5: warning: symbol 'verify_sha256_digest' was not declared. Should it be static?
> arch/x86/purgatory/purgatory.c:61:6: warning: symbol 'purgatory' was not declared. Should it be static?
>   CC      arch/x86/purgatory/purgatory.o
> 
> Numerous sparse messages regarding functions not being declared, these
> functions are resolved via kexec_purgatory_get_set_symbol() and not
> directly called anywhere. To resolve the sparse issues appropriate
> declarations were added in a dedicated purgatory.h file.
> 
> Patch was compile tested with: x86_64_defconfig (implies CONFIG_KEXEC=y)
> 
> Patch is against 4.10-rc2 (localversion-next is next-20170106)
> 
>  arch/x86/purgatory/purgatory.c |  6 +-----
>  arch/x86/purgatory/purgatory.h | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 5 deletions(-)
>  create mode 100644 arch/x86/purgatory/purgatory.h
> 
> diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
> index 25e068b..9420fe5 100644
> --- a/arch/x86/purgatory/purgatory.c
> +++ b/arch/x86/purgatory/purgatory.c
> @@ -12,11 +12,7 @@
>  
>  #include "sha256.h"
>  #include "../boot/string.h"
> -
> -struct sha_region {
> -	unsigned long start;
> -	unsigned long len;
> -};
> +#include "purgatory.h"
>  
>  unsigned long backup_dest = 0;
>  unsigned long backup_src = 0;
> diff --git a/arch/x86/purgatory/purgatory.h b/arch/x86/purgatory/purgatory.h
> new file mode 100644
> index 0000000..2754e83
> --- /dev/null
> +++ b/arch/x86/purgatory/purgatory.h
> @@ -0,0 +1,24 @@
> +#ifndef BOOT_PURGATORY_H
> +#define BOOT_PURGATORY_H
> +
> +/* This is really just to make sparse happy.
> + * Declaring it all static as sparse suggests is not an option as,
> + * the symbol information is needed. see kexec_purgatory_get_set_symbol()
> + * Technically these prototype and extern declarations are unnecessary
> + */
> +void purgatory(void);
> +int verify_sha256_digest(void);
> +
> +extern unsigned long backup_dest;
> +extern unsigned long backup_src;
> +extern unsigned long backup_sz;
> +
> +struct sha_region {
> +	unsigned long start;
> +	unsigned long len;
> +};
> +
> +extern u8 sha256_digest[];
> +extern struct sha_region sha_regions[];
> +
> +#endif
> -- 
> 2.1.4
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
