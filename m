Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RaNht-0006ua-6Y
 for kexec@lists.infradead.org; Tue, 13 Dec 2011 08:27:27 +0000
Subject: Re: [PATCH] makedumpfile: s390x: Obtain the vmalloc_start value
 fromhigh_memory for s390x arch.
In-reply-to: <20111213061616.23145.88262.stgit@mars.in.ibm.com>
Message-Id: <20111213172340tachibana@mail.jp.nec.com>
References: <20111213061616.23145.88262.stgit@mars.in.ibm.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Tue, 13 Dec 2011 17:23:40 +0900
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Ananth Narayan <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Mahesh,

Thank you for the patch.
I will check and merge it into the next makedumpfile.


Thanks
tachibana

On 2011/12/13 11:46:55 +0530, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Currently the vmalloc_start address for s390x is obtained by using
> vmlist.addr symbol, which is not correct. The correct vmalloc_start address
> can be obtained using 'high_memory' symbol. Even crash utility is depend
> on high_memory symbol to get vmalloc_start address for s390x arch.
> 
> Without this patch makedumpfile fails to translate some virtual addresses to
> to physical addresses on s390x.
> 
> [root@h4245043 makedumpfile]# ./makedumpfile -d 16 -x /root/dump.makedumpfile_problem/vmlinux /root/dump.makedumpfile_
problem/vmcore /tmp/out.dump
> The kernel version is not supported.
> The created dumpfile may be incomplete.
> Checking for memory holes          : [100 %] readmem: Can't convert a physical address(3d2805c1830) to offset.
> readmem: type_addr: 0, addr:3d2805c1830, size:8
> reset_bitmap_of_free_pages: Can't get prev list_head.
> 
> makedumpfile Failed.
> [root@h4245043 makedumpfile]#
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/s390x.c   |   19 ++++++-------------
>  makedumpfile.c |    3 +++
>  makedumpfile.h |    5 +++++
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/s390x.c b/arch/s390x.c
> index e7d7603..9237eaa 100644
> --- a/arch/s390x.c
> +++ b/arch/s390x.c
> @@ -62,7 +62,7 @@
>  int
>  get_machdep_info_s390x(void)
>  {
> -	unsigned long vmlist, vmalloc_start;
> +	unsigned long vmalloc_start;
>  	char *term_str = getenv("TERM");
>  
>  	if (term_str && strcmp(term_str, "dumb") == 0)
> @@ -81,19 +81,13 @@ get_machdep_info_s390x(void)
>  	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
>  
>  	/*
> -	 * For the compatibility, makedumpfile should run without the symbol
> -	 * vmlist and the offset of vm_struct.addr if they are not necessary.
> +	 * Obtain the vmalloc_start address from high_memory symbol.
>  	 */
> -	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
> -	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
> +	if (SYMBOL(high_memory) == NOT_FOUND_SYMBOL) {
>  		return TRUE;
>  	}
> -	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
> -		ERRMSG("Can't get vmlist.\n");
> -		return FALSE;
> -	}
> -	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
> -	    sizeof(vmalloc_start))) {
> +	if (!readmem(VADDR, SYMBOL(high_memory), &vmalloc_start,
> +			sizeof(vmalloc_start))) {
>  		ERRMSG("Can't get vmalloc_start.\n");
>  		return FALSE;
>  	}
> @@ -265,8 +259,7 @@ vaddr_to_paddr_s390x(unsigned long vaddr)
>  	if (paddr != NOT_PADDR)
>  		return paddr;
>  
> -	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
> -	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
> +	if (SYMBOL(high_memory) == NOT_FOUND_SYMBOL) {
>  		ERRMSG("Can't get necessary information for vmalloc "
>  			"translation.\n");
>  		return NOT_PADDR;
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 7b7c266..67f1a10 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -797,6 +797,7 @@ get_symbol_info(void)
>  	SYMBOL_INIT(log_end, "log_end");
>  	SYMBOL_INIT(max_pfn, "max_pfn");
>  	SYMBOL_INIT(modules, "modules");
> +	SYMBOL_INIT(high_memory, "high_memory");
>  
>  	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
>  		SYMBOL_ARRAY_TYPE_INIT(node_data, "node_data");
> @@ -1108,6 +1109,7 @@ generate_vmcoreinfo(void)
>  	WRITE_SYMBOL("log_buf_len", log_buf_len);
>  	WRITE_SYMBOL("log_end", log_end);
>  	WRITE_SYMBOL("max_pfn", max_pfn);
> +	WRITE_SYMBOL("high_memory", high_memory);
>  
>  	/*
>  	 * write the structure size of 1st kernel
> @@ -1366,6 +1368,7 @@ read_vmcoreinfo(void)
>  	READ_SYMBOL("log_buf_len", log_buf_len);
>  	READ_SYMBOL("log_end", log_end);
>  	READ_SYMBOL("max_pfn", max_pfn);
> +	READ_SYMBOL("high_memory", high_memory);
>  
>  	READ_STRUCTURE_SIZE("page", page);
>  	READ_STRUCTURE_SIZE("mem_section", mem_section);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index f0e5da8..b3de521 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -974,6 +974,11 @@ struct symbol_table {
>  	 */
>  
>  	unsigned long long	modules;
> +
> +	/*
> +	 * vmalloc_start address on s390x arch
> +	 */
> +	unsigned long long	high_memory;
>  };
>  
>  struct size_table {
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
