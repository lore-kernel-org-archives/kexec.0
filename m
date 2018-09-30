Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g6Xut-0003ff-Px
 for kexec@lists.infradead.org; Sun, 30 Sep 2018 09:21:33 +0000
Date: Sun, 30 Sep 2018 17:21:10 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/3] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one
 error
Message-ID: <20180930092110.GB6950@dhcp-128-65.nay.redhat.com>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, dan.j.williams@intel.com, bp@suse.de, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

Hi Bjorn,

On 09/27/18 at 09:21am, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The only use of KEXEC_BACKUP_SRC_END is as an argument to
> walk_system_ram_res():
> 
>   int crash_load_segments(struct kimage *image)
>   {
>     ...
>     walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
>                         image, determine_backup_region);
> 
> walk_system_ram_res() expects "start, end" arguments that are inclusive,
> i.e., the range to be walked includes both the start and end addresses.

Looking at the function comment of find_next_iomem_res,  the res->end
should be exclusive, am I missing something?


/*
 * Finds the lowest iomem resource existing within [res->start.res->end).
 * The caller must specify res->start, res->end, res->flags, and optionally
 * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
 * This function walks the whole tree and not just first level children until
 * and unless first_level_children_only is true.
 */
static int find_next_iomem_res(struct resource *res, unsigned long desc,
                               bool first_level_children_only)


> 
> KEXEC_BACKUP_SRC_END was previously defined as (640 * 1024UL), which is the
> first address *past* the desired 0-640KB range.
> 
> Define KEXEC_BACKUP_SRC_END as (640 * 1024UL - 1) so the KEXEC_BACKUP_SRC
> region is [0-0x9ffff], not [0-0xa0000].
> 
> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/include/asm/kexec.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index f327236f0fa7..5125fca472bb 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -67,7 +67,7 @@ struct kimage;
>  
>  /* Memory to backup during crash kdump */
>  #define KEXEC_BACKUP_SRC_START	(0UL)
> -#define KEXEC_BACKUP_SRC_END	(640 * 1024UL)	/* 640K */
> +#define KEXEC_BACKUP_SRC_END	(640 * 1024UL - 1)	/* 640K */
>  
>  /*
>   * CPU does not save ss and sp on stack if execution is already
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
