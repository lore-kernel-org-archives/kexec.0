Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eEqYT-0007tJ-GJ
 for kexec@lists.infradead.org; Wed, 15 Nov 2017 05:48:11 +0000
Date: Wed, 15 Nov 2017 13:47:42 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/3] X86/kdump: crashkernel=X try to reserve below 896M
 first then below 4G and MAXMEM
Message-ID: <20171115054742.GL10474@x1>
References: <20171024053901.757504190@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171024053901.757504190@redhat.com>
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
To: dyoung@redhat.com
Cc: corbet@lwn.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, yinghai@kernel.org, vgoyal@redhat.com

Hi Dave,

Thanks for your effort to push this into upstream. While I have one
concern, please see the inline comments.

On 10/24/17 at 01:31pm, Dave Young wrote:
> Now crashkernel=X will fail if there's not enough memory at low region
> (below 896M) when trying to reserve large memory size.  One can use
> crashkernel=xM,high to reserve it at high region (>4G) but it is more
> convinient to improve crashkernel=X to: 
> 
>  - First try to reserve X below 896M (for being compatible with old
>    kexec-tools).
>  - If fails, try to reserve X below 4G (swiotlb need to stay below 4G).
>  - If fails, try to reserve X from MAXMEM top down.
> 
> It's more transparent and user-friendly.
> 
> If crashkernel is large and the reserved is beyond 896M, old kexec-tools
> is not compatible with new kernel because old kexec-tools can not load
> kernel at high memory region, there was an old discussion below:
> https://lkml.org/lkml/2013/10/15/601
> 
> But actually the behavior is consistent during my test. Suppose
> old kernel fail to reserve memory at low areas, kdump does not
> work because no meory reserved. With this patch, suppose new kernel
> successfully reserved memory at high areas, old kexec-tools still fail
> to load kdump kernel (tested 2.0.2), so it is acceptable, no need to
> worry about the compatibility.
> 
> Here is the test result (kexec-tools 2.0.2, no high memory load
> support):
> Crashkernel over 4G:
> # cat /proc/iomem|grep Crash
>   be000000-cdffffff : Crash kernel
>   213000000-21effffff : Crash kernel
> # ./kexec  -p /boot/vmlinuz-`uname -r`
> Memory for crashkernel is not reserved
> Please reserve memory by passing "crashkernel=X@Y" parameter to the kernel
> Then try loading kdump kernel
> 
> crashkernel: 896M-4G:
> # cat /proc/iomem|grep Crash
>   96000000-cdefffff : Crash kernel
> # ./kexec -p /boot/vmlinuz-4.14.0-rc4+
> ELF core (kcore) parse failed
> Cannot load /boot/vmlinuz-4.14.0-rc4+
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/kernel/setup.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> --- linux-x86.orig/arch/x86/kernel/setup.c
> +++ linux-x86/arch/x86/kernel/setup.c
> @@ -568,6 +568,22 @@ static void __init reserve_crashkernel(v
>  						    high ? CRASH_ADDR_HIGH_MAX
>  							 : CRASH_ADDR_LOW_MAX,
>  						    crash_size, CRASH_ALIGN);
> +#ifdef CONFIG_X86_64
> +		/*
> +		 * crashkernel=X reserve below 896M fails? Try below 4G
> +		 */
> +		if (!high && !crash_base)
> +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> +						(1ULL << 32),
> +						crash_size, CRASH_ALIGN);
> +		/*
> +		 * crashkernel=X reserve below 4G fails? Try MAXMEM
> +		 */
> +		if (!high && !crash_base)
> +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> +						CRASH_ADDR_HIGH_MAX,
> +						crash_size, CRASH_ALIGN);

For kdump, most of systems are x86 64. If both Yinghai and Vivek have no
objection to search an available region of crash_size above 896M
naturely, why don't we search it with function
__memblock_find_range_bottom_up(). It can search from below 896M to
above 4G, almost the same as the change you have made currently. Mainly
the code will be much simpler.

The several times of searching looks not good and a little confusing.

What do you think?

Thanks
Baoquan

> +#endif
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
