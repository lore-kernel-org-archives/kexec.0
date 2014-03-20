Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQTaa-00013s-JS
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 03:24:18 +0000
Date: Thu, 20 Mar 2014 11:25:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2] kexec: align initrd when no --image-size passed
Message-ID: <20140320032506.GA4722@dhcp-16-126.nay.redhat.com>
References: <1395282993-37549-1-git-send-email-wangnan0@huawei.com>
 <1395282993-37549-2-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395282993-37549-2-git-send-email-wangnan0@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On 03/20/14 at 10:36am, Wang Nan wrote:
> Before this patch, when no --image-size passed, initrd_base is caculated using
> base + len * 4, which is unaligned, and unable to pass check in
> add_segment_phys_virt():
> 
> 	if (base & (pagesize -1)) {
> 		die("Base address: 0x%lx is not page aligned\n", base);
> 	}
> 
> This patch also uses getpagesize() instead of hard encoded 4096.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Geng Hui <hui.geng@huawei.com>
> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 792187a..8a35018 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -347,11 +347,11 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  		/* If the image size was passed as command line argument,
>  		 * use that value for determining the address for initrd,
>  		 * atags and dtb images. page-align the given length.*/
> -		initrd_base = base + _ALIGN(kexec_arm_image_size, 4096);
> +		initrd_base = base + _ALIGN(kexec_arm_image_size, getpagesize());
>  	} else {
>  		/* Otherwise, assume the maximum kernel compression ratio
>  		 * is 4, and just to be safe, place ramdisk after that */
> -		initrd_base = base + len * 4;
> +		initrd_base = base + _ALIGN(len * 4, getpagesize());
>  	}
>  
>  	if (use_atags) {
> -- 
> 1.8.4
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
