Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCKPl-0000QJ-QN
 for kexec@lists.infradead.org; Mon, 04 Mar 2013 01:42:10 +0000
Date: Mon, 4 Mar 2013 10:41:52 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc: Fix kernel program entry point while changing
 the load addr
Message-ID: <20130304014152.GB9007@verge.net.au>
References: <20130303073540.12040.16854.stgit@suzukikp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130303073540.12040.16854.stgit@suzukikp>
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
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: Matthew McClintock <msm@freescale.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

[ Cc: linuxppc-dev@lists.ozlabs.org ]

On Sun, Mar 03, 2013 at 01:06:00PM +0530, Suzuki K. Poulose wrote:
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
> 
> uImage probe fills the entry point (ep) based on the load_addr
> from the uImage headers. If we change the load_addr, we should
> accordingly update the entry point.
> 
> For ELF, calculate the offset of e_entry from the virtual start
> address and add it to the physical start address to find the
> physical address of kernel entry.
> 
> i.e,
>   pa (e_entry) = pa(phdr[0].p_vaddr) + (e_entry - phdr[0].p_vaddr)
>                = kernel_addr + (e_entry - phdr[0].p_vaddr)

Would it be possible for someone to provide a review of this change?

> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Matthew McClintock <msm@freescale.com>
> ---
>  kexec/arch/ppc/kexec-elf-ppc.c    |   12 ++++++++----
>  kexec/arch/ppc/kexec-uImage-ppc.c |    6 +++++-
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
> index 8e408cc..5f63a64 100644
> --- a/kexec/arch/ppc/kexec-elf-ppc.c
> +++ b/kexec/arch/ppc/kexec-elf-ppc.c
> @@ -397,10 +397,14 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
>  		die("Error device tree not loadded to address it was expecting to be loaded too!\n");
>  	}
>  
> -	/* set various variables for the purgatory  ehdr.e_entry is a
> -	 * virtual address, we can use kernel_addr which
> -	 * should be the physical start address of the kernel */
> -	addr = kernel_addr;
> +	/* 
> +	 * set various variables for the purgatory.
> +	 * ehdr.e_entry is a virtual address. we know physical start
> +	 * address of the kernel (kernel_addr). Find the offset of
> +	 * e_entry from the virtual start address(e_phdr[0].p_vaddr)
> +	 * and calculate the actual physical address of the 'kernel entry'.
> +	 */
> +	addr = kernel_addr + (ehdr.e_entry - ehdr.e_phdr[0].p_vaddr);
>  	elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
>  
>  	addr = dtb_addr;
> diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
> index e0bc7bb..900cd16 100644
> --- a/kexec/arch/ppc/kexec-uImage-ppc.c
> +++ b/kexec/arch/ppc/kexec-uImage-ppc.c
> @@ -159,15 +159,19 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
>  
>  	/*
>  	 * If the provided load_addr cannot be allocated, find a new
> -	 * area.
> +	 * area. Rebase the entry point based on the new load_addr.
>  	 */
>  	if (!valid_memory_range(info, load_addr, load_addr + (len + _1MiB))) {
> +		int ep_offset = ep - load_addr;
> +
>  		load_addr = locate_hole(info, len + _1MiB, 0, 0, max_addr, 1);
>  		if (load_addr == ULONG_MAX) {
>  			printf("Can't allocate memory for kernel of len %ld\n",
>  					len + _1MiB);
>  			return -1;
>  		}
> +
> +		ep = load_addr + ep_offset;
>  	}
>  
>  	add_segment(info, buf, len, load_addr, len + _1MiB);
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
