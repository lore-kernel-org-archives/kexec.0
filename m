Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTnCf-00EyLV-5a
 for kexec@lists.infradead.org; Fri, 24 Sep 2021 15:33:34 +0000
Date: Fri, 24 Sep 2021 17:33:25 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec:Remove unused local variable in
 get_kernel_page_offset()
Message-ID: <20210924153325.GA25765@vergenet.net>
References: <20210923053243.8320-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923053243.8320-1-songkai01@inspur.com>
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
To: Kai Song <songkai01@inspur.com>
Cc: kexec@lists.infradead.org

On Thu, Sep 23, 2021 at 01:32:43PM +0800, Kai Song wrote:
> In get_kernel_page_offset(),the local variable kv is unused,remove it.
> 
> Signed-off-by: Kai Song <songkai01@inspur.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 81610dc..9826f6d 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -52,7 +52,6 @@ extern struct arch_options_t arch_options;
>  static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>  				  struct crash_elf_info *elf_info)
>  {
> -	int kv;
>  
>  	if (elf_info->machine == EM_X86_64) {
>  		/* get_kernel_vaddr_and_size will override this */

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
