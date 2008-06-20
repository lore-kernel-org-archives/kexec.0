Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K9me9-0005PQ-Sb
	for kexec@lists.infradead.org; Fri, 20 Jun 2008 19:51:46 +0000
Date: Fri, 20 Jun 2008 15:45:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 3/3] Limit E820 map when a user-defined memory map is
	specified
Message-ID: <20080620194540.GD21235@redhat.com>
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
	<1213977420-1555-4-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1213977420-1555-4-git-send-email-bwalle@suse.de>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jun 20, 2008 at 05:57:00PM +0200, Bernhard Walle wrote:
> This patch brings back limiting of the E820 map when a user-defined
> E820 map is specified. While the behaviour of i386 (32 bit) was to limit
> the E820 map (and /proc/iomem), the behaviour of x86-64 (64 bit) was not to
> limit.
> 
> That patch limits the E820 map again for both x86 architectures.
> 
> Code was tested for compilation and booting on a 32 bit and 64 bit system.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  arch/x86/kernel/e820.c |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index f5b1736..2e7d385 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -934,6 +934,33 @@ static void early_panic(char *msg)
>  	panic(msg);
>  }
>  
> +void __init e820_limit_regions(unsigned long long size)
> +{
> +	unsigned long long current_addr;
> +	int i;
> +
> +	for (i = 0; i < e820.nr_map; i++) {
> +		current_addr = e820.map[i].addr + e820.map[i].size;
> +		if (current_addr < size)
> +			continue;
> +
> +		if (e820.map[i].type != E820_RAM)
> +			continue;
> +
> +		if (e820.map[i].addr >= size) {
> +			/*
> +			 * This region starts past the end of the
> +			 * requested size, skip it completely.
> +			 */
> +			e820.nr_map = i;
> +		} else {
> +			e820.nr_map = i + 1;
> +			e820.map[i].size -= current_addr - size;
> +		}
> +		return;
> +	}
> +}
> +
>  /* "mem=nopentium" disables the 4MB page tables. */
>  static int __init parse_memopt(char *p)
>  {
> @@ -951,6 +978,8 @@ static int __init parse_memopt(char *p)
>  
>  	mem_size = memparse(p, &p);
>  	end_user_pfn = mem_size>>PAGE_SHIFT;
> +	e820_limit_regions(mem_size);
> +
>  	return 0;
>  }
>  early_param("mem", parse_memopt);
> @@ -995,6 +1024,7 @@ static int __init parse_memmap_opt(char *p)
>  		e820_add_region(start_at, mem_size, E820_RESERVED);
>  	} else {
>  		end_user_pfn = (mem_size >> PAGE_SHIFT);
> +		e820_limit_regions(mem_size);
>  	}

Hi Bernhard,

Just curious, when do we hit this bottom else condition?

In Documentation/kernel-parameters.txt file, I see, there are four
types of memmap= options. "exactmap" "@" "#" and "$". In the code
above we have already parsed all these option. So default condition
should be an error. Instead we seem to be limiting the memory size,
(something done by mem= parameter)..

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
