Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fy5Dt-0007Rx-CN
 for kexec@lists.infradead.org; Fri, 07 Sep 2018 01:06:10 +0000
Date: Fri, 7 Sep 2018 09:05:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] kdump: fix an error that can not parse the e820
 reserved region
Message-ID: <20180907010550.GA30391@dhcp-128-65.nay.redhat.com>
References: <20180906055618.3210-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180906055618.3210-1-lijiang@redhat.com>
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

On 09/06/18 at 01:56pm, Lianbo Jiang wrote:
> When kexec-tools load the kernel and initramfs for kdump, kexec-tools will
> read /proc/iomem and recreate the e820 ranges for kdump kernel. But it fails
> to parse the e820 reserved region, because the memcmp() is case sensitive
> when comparing the string. In fact, it may be "Reserved" or "reserved" in
> the /proc/iomem, so we have to fix these cases.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 437e8a8..140f45b 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -289,6 +289,8 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  			type = RANGE_PMEM;
>  		} else if(memcmp(str,"reserved\n",9) == 0 ) {
>  			type = RANGE_RESERVED;
> +		} else if (memcmp(str, "Reserved\n", 9) == 0) {
> +			type = RANGE_RESERVED;
>  		} else if (memcmp(str, "GART\n", 5) == 0) {
>  			gart_start = start;
>  			gart_end = end;
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
