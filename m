Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WPX5b-00016W-Ue
 for kexec@lists.infradead.org; Mon, 17 Mar 2014 12:56:24 +0000
Date: Mon, 17 Mar 2014 08:56:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] x86, kaslr: Kernel base can be randomized at 0-1G
 offset.
Message-ID: <20140317125601.GA13373@redhat.com>
References: <1394785218-25168-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394785218-25168-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: dyoung@redhat.com, kexec@lists.infradead.org, ebiederm@xmission.com

On Fri, Mar 14, 2014 at 04:20:18PM +0800, WANG Chao wrote:
> With kASLR enabled (CONFIG_RANDOMIZED_BASE=y), kernel virtual address
> base is PAGE_OFFSET plus a randomized offset from 0 to 1G.
> 
> Current kexec-tools gets kernel vaddr and size from /proc/kcore. It
> assumes kernel vaddr start/end is within the range [0,512M). If kaslr
> enabled, kernel vaddr start/end will stay at [0+offset, 512M+offset).

Hi Chao,

Documentation/x86/x86_64/mm.txt still says that kernel text mapping area
is 512MB.

ffffffff80000000 - ffffffffa0000000 (=512 MB)  kernel text mapping, from
phys 0

So has that changed now due to kASLR.

Thanks
Vivek

> 
> To adapt kaslr, introduce a new macro X86_64_RANDOMIZED_BASE_MAX_OFFSET
> to address the max offset and use this macro to filter out the kernel
> text PT_LOAD from /proc/kcore.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 3 ++-
>  kexec/arch/i386/crashdump-x86.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index cb19e7d..1e6d3a3 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -156,7 +156,8 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
>  
>  			/* Look for kernel text mapping header. */
>  			if ((saddr >= X86_64__START_KERNEL_map) &&
> -			    (eaddr <= X86_64__START_KERNEL_map + X86_64_KERNEL_TEXT_SIZE)) {
> +			    (saddr <= X86_64__START_KERNEL_map + X86_64_RANDOMIZE_BASE_MAX_OFFSET) &&
> +			    (eaddr - saddr  < X86_64_KERNEL_TEXT_SIZE)) {
>  				saddr = _ALIGN_DOWN(saddr, X86_64_KERN_VADDR_ALIGN);
>  				elf_info->kern_vaddr_start = saddr;
>  				size = eaddr - saddr;
> diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
> index e68b626..71a09f8 100644
> --- a/kexec/arch/i386/crashdump-x86.h
> +++ b/kexec/arch/i386/crashdump-x86.h
> @@ -15,6 +15,9 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
>  #define X86_64_PAGE_OFFSET_PRE_2_6_27	0xffff810000000000ULL
>  #define X86_64_PAGE_OFFSET		0xffff880000000000ULL
>  
> +/* kASLR - Kernel base offset could be randomized up to 1G */
> +#define X86_64_RANDOMIZE_BASE_MAX_OFFSET	0x40000000
> +
>  #define X86_64_MAXMEM        		0x3fffffffffffUL
>  
>  /* Kernel text size */
> -- 
> 1.8.5.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
