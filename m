Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bScW5-00037P-KU
 for kexec@lists.infradead.org; Thu, 28 Jul 2016 04:01:51 +0000
Received: by mail-pa0-f50.google.com with SMTP id fi15so16634861pac.1
 for <kexec@lists.infradead.org>; Wed, 27 Jul 2016 21:01:28 -0700 (PDT)
Date: Thu, 28 Jul 2016 09:31:25 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v2 4/4] arm64: Add support for binary image files
Message-ID: <20160728040125.GA27150@localhost.localdomain>
References: <cover.1469559530.git.geoff@infradead.org>
 <f352dcfc827a4cbb3878dd1043877a4154b1bd08.1469559530.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f352dcfc827a4cbb3878dd1043877a4154b1bd08.1469559530.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 26/07/2016:08:18:57 PM, Geoff Levand wrote:
> From: Pratyush Anand <panand@redhat.com>
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> [Reworked and cleaned up]

You removed page_offset calculation in rework.
I am unable to understand that how arm64_mem.page_offset will be filled up now
for binary image case.

I think, we still need to keep page_offset user input. You may take following
two patches which does this, or you may leave binary image support patch which I
will send after your patches are merged.

https://github.com/pratyushanand/kexec-tools/commit/5b7e49a75d1d6cd4ac846f50ff10275fd54cb545
https://github.com/pratyushanand/kexec-tools/commit/a0ce0ce673755c4061c1f081170a3a75dfa1d1fb

~Pratyush

> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  kexec/arch/arm64/kexec-image-arm64.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
> index 84386f7..cad7c73 100644
> --- a/kexec/arch/arm64/kexec-image-arm64.c
> +++ b/kexec/arch/arm64/kexec-image-arm64.c
> @@ -24,21 +24,40 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
>  		return -1;
>  	}
>  
> -	fprintf(stderr, "kexec: ARM64 binary image files are currently NOT SUPPORTED.\n");
> -
> -	return -1;
> +	return 0;
>  }
>  
>  int image_arm64_load(int argc, char **argv, const char *kernel_buf,
>  	off_t kernel_size, struct kexec_info *info)
>  {
> -	return -EFAILED;
> +	const struct arm64_image_header *h;
> +	unsigned long image_base;
> +
> +	h = (const struct arm64_image_header *)(kernel_buf);
> +
> +	if (arm64_process_image_header(h))
> +		return -EINVAL;
> +
> +	dbgprintf("%s: text_offset:   %016lx\n", __func__,
> +		arm64_mem.text_offset);
> +	dbgprintf("%s: image_size:    %016lx\n", __func__,
> +		arm64_mem.image_size);
> +	dbgprintf("%s: phys_offset:   %016lx\n", __func__,
> +		arm64_mem.phys_offset);
> +	dbgprintf("%s: PE format:     %s\n", __func__,
> +		(arm64_header_check_pe_sig(h) ? "yes" : "no"));
> +
> +	image_base = get_phys_offset() + arm64_mem.text_offset;
> +	
> +	add_segment_phys_virt(info, kernel_buf, kernel_size, image_base,
> +		arm64_mem.image_size, 0);
> +
> +	return arm64_load_other_segments(info, image_base);
>  }
>  
>  void image_arm64_usage(void)
>  {
>  	printf(
>  "     An ARM64 binary image, compressed or not, big or little endian.\n"
> -"     Typically an Image, Image.gz or Image.lzma file.\n"
> -"     This file type is currently NOT SUPPORTED.\n\n");
> +"     Typically an Image, Image.gz or Image.lzma file.\n\n");
>  }
> -- 
> 2.5.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
