Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lVtyG-006STD-JM
 for kexec@lists.infradead.org; Mon, 12 Apr 2021 10:39:11 +0000
Date: Mon, 12 Apr 2021 12:38:53 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/1] arm: do not copy magic 4 bytes of appended DTB in
 zImage
Message-ID: <20210412103853.GA28946@vergenet.net>
References: <20210408200644.19724-1-egorenar-dev@posteo.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408200644.19724-1-egorenar-dev@posteo.net>
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
To: Alexander Egorenkov <egorenar-dev@posteo.net>
Cc: rmk@armlinux.org.uk, kexec@lists.infradead.org

On Thu, Apr 08, 2021 at 10:06:44PM +0200, Alexander Egorenkov wrote:
> If the passed zImage happens to have a DTB appended, then the magic 4 bytes
> of the DTB are copied together with the kernel image. This leads to
> failed kexec boots because the decompressor finds the aforementioned
> DTB magic and falsely tries to replace the DTB passed in the register r2
> with the non-existent appended one.
> 
> Signed-off-by: Alexander Egorenkov <egorenar-dev@posteo.net>

Hi,

I also see that, on line 558 len is further expanded as follows:

        /*
         * The zImage length does not include its stack (4k) or its
         * malloc space (64k).  Include this.
         */
        len += 0x11000;

Is it intentional that this patch also excludes this extra length
from the DTB? Or am I missing something?

> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 925a9be..8ec289d 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -382,6 +382,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
>  	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
>  	const struct zimage_tag *tag;
> +	size_t kernel_buf_size;
>  	size_t kernel_mem_size;
>  	const char *command_line;
>  	char *modified_cmdline = NULL;
> @@ -537,6 +538,8 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  		}
>  	}
>  
> +	kernel_buf_size = len;
> +
>  	/*
>  	 * Always extend the zImage by four bytes to ensure that an appended
>  	 * DTB image always sees an initialised value after _edata.
> @@ -759,7 +762,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  		add_segment(info, dtb_buf, dtb_length, dtb_offset, dtb_length);
>  	}
>  
> -	add_segment(info, buf, len, kernel_base, kernel_mem_size);
> +	add_segment(info, buf, kernel_buf_size, kernel_base, kernel_mem_size);
>  
>  	info->entry = (void*)kernel_base;
>  
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
