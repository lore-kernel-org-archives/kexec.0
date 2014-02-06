Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBFsg-0001Si-Gp
 for kexec@lists.infradead.org; Thu, 06 Feb 2014 03:44:04 +0000
Date: Thu, 6 Feb 2014 11:44:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/3] kexec: align initrd when no --image-size
Message-ID: <20140206034415.GA3943@dhcp-16-126.nay.redhat.com>
References: <1390387924-73946-1-git-send-email-wangnan0@huawei.com>
 <1390387924-73946-2-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390387924-73946-2-git-send-email-wangnan0@huawei.com>
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

On 01/22/14 at 06:52pm, Wang Nan wrote:
> Before this patch, when no --image-size passed, initrd_base is caculated using
> base + len * 4, which is unaligned, and unable to pass check in
> add_segment_phys_virt():
> 
> 	if (base & (pagesize -1)) {
> 		die("Base address: 0x%lx is not page aligned\n", base);
> 	}
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Geng Hui <hui.geng@huawei.com>
> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 792187a..4547765 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -351,7 +351,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  	} else {
>  		/* Otherwise, assume the maximum kernel compression ratio
>  		 * is 4, and just to be safe, place ramdisk after that */
> -		initrd_base = base + len * 4;
> +		initrd_base =  base + _ALIGN(len * 4, 4096);

get_page_size should be used instead of 4096, otherwise it looks good to me.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
