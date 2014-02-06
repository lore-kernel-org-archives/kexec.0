Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBG9G-0001iB-3Y
 for kexec@lists.infradead.org; Thu, 06 Feb 2014 04:01:11 +0000
Date: Thu, 6 Feb 2014 12:01:32 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 3/3] kexec: increase zImage compression ratio from 4 to 5
Message-ID: <20140206040132.GC3943@dhcp-16-126.nay.redhat.com>
References: <1390387924-73946-1-git-send-email-wangnan0@huawei.com>
 <1390387924-73946-4-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390387924-73946-4-git-send-email-wangnan0@huawei.com>
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
> Old code assume the zImage compression ration is 4, it is not enough, 5 shall be
> better.

4 works well during my test. Do you have real test case to reproduce this problem?

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
> index 6d6b239..6e5e12b 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -351,7 +351,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  	} else {
>  		/* Otherwise, assume the maximum kernel compression ratio
>  		 * is 4, and just to be safe, place ramdisk after that */
> -		initrd_base =  base + _ALIGN(len * 4, 4096);
> +		initrd_base =  base + _ALIGN(len * 5, 4096);
>  	}
>  
>  	if (use_atags) {
> -- 
> 1.8.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
