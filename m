Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fxk3y-0000Mq-Me
 for kexec@lists.infradead.org; Thu, 06 Sep 2018 02:30:32 +0000
Date: Thu, 6 Sep 2018 10:30:09 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kdump: fix an error that can not parse the e820 reserved
 region
Message-ID: <20180906023009.GA12218@dhcp-128-65.nay.redhat.com>
References: <20180905134104.18237-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180905134104.18237-1-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

Hi Lianbo,

On 09/05/18 at 09:41pm, Lianbo Jiang wrote:
> When kexec-tools load the kernel and initramfs for kdump, kexec-tools will
> read /proc/iomem and recreate the e820 ranges for kdump kernel. But it fails
> to parse the e820 reserved region, because the memcmp() is case sensitive
> when comparing the string. In fact, it may be "Reserved" or "reserved" in
> the /proc/iomem, so we use the strncasecmp() instead of the memcmp() to fix
> it.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 437e8a8..6669c1a 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -287,7 +287,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  			type = RANGE_PRAM;
>  		} else if(memcmp(str,"Persistent Memory\n",18) == 0 ) {
>  			type = RANGE_PMEM;
> -		} else if(memcmp(str,"reserved\n",9) == 0 ) {
> +		} else if(strncasecmp(str,"reserved\n",9) == 0 ) {
>  			type = RANGE_RESERVED;

It would be better to use two memcmp in two "else if" for "reserved" and "Reserved"

BTW, add one whitespace before the function arguments. 

>  		} else if (memcmp(str, "GART\n", 5) == 0) {
>  			gart_start = start;
> -- 
> 2.17.1
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
