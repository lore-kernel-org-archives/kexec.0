Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KCE5I-0006Ff-GE
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 13:33:52 +0000
Date: Fri, 27 Jun 2008 09:32:56 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
Message-ID: <20080627133256.GB5801@redhat.com>
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1214510048-21215-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Jun 26, 2008 at 09:54:08PM +0200, Bernhard Walle wrote:
> This patch removes the need of the crashkernel=...@offset parameter to define
> a fixed offset for crashkernel reservation. That feature can be used together
> with a relocatable kernel where the kexec-tools relocate the kernel and
> get the actual offset from /proc/iomem.
> 
> The use case is a kernel where the .text+.data+.bss is after 16M physical
> memory (debug kernel with lockdep on x86_64 can cause that) which caused a
> major pain in autoconfiguration in our distribution.
> 
> Also, that patch unifies crashdump architectures a bit since IA64 has
> that semantics from the very beginning of the kdump port.
> 
> Please provide feedback!
> 

Hi Bernhard,

This looks like a good idea. That means distributions don't have to
hardcode the crashbase at 16MB and the decision to find a free memory
can be left on kernel. Users will also find it easy that way.

> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  arch/x86/kernel/setup.c |   70 +++++++++++++++++++++++++++++++++++------------
>  1 files changed, 52 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a81d82c..c30bb7b 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -435,6 +435,34 @@ static inline unsigned long long get_total_mem(void)
>  }
>  
>  #ifdef CONFIG_KEXEC
> +
> +/**
> + * Reserve @size bytes of crashkernel memory at any suitable offset.
> + *
> + * @size: Size of the crashkernel memory to reserve.
> + * Returns the base address on success, and -1ULL on failure.
> + */
> +unsigned long long find_and_reserve_crashkernel(unsigned long long size)
> +{
> +	const unsigned long long alignment = 16<<20; 	/* 16M */
> +	unsigned long long start = 0LL;
> +
> +	while (1) {
> +		int ret;
> +
> +		start = find_e820_area(start, ULONG_MAX, size, alignment);
> +		if (start == -1ULL)
> +			return start;
> +
> +		/* try to reserve it */
> +		ret = reserve_bootmem_generic(start, size, BOOTMEM_EXCLUSIVE);
> +		if (ret >= 0)
> +			return start;
> +
> +		start += alignment;
> +	}

I think both i386 and x86_64 relocatable kernels had some upper limits
where these could be loaded (Eric had mentioned those in the patch. I
don't remember these). It might be a good idea to capture it here
making sure "start" does not cross those limits otherwise don't reserve
the memory.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
