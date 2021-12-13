Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <c99abca7-8c3f-94da-3f0e-e4b9872d2db0@oracle.com>
Date: Mon, 13 Dec 2021 08:34:03 -0600
Subject: Re: [PATCH v17 08/10] of: fdt: Aggregate the processing of
 "linux,usable-memory-range"
Content-Language: en-US
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-9-thunder.leizhen@huawei.com>
From: john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-9-thunder.leizhen@huawei.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On 12/10/21 12:55 AM, Zhen Lei wrote:
> Currently, we parse the "linux,usable-memory-range" property in
> early_init_dt_scan_chosen(), to obtain the specified memory range of the
> crash kernel. We then reserve the required memory after
> early_init_dt_scan_memory() has identified all available physical memory.
> Because the two pieces of code are separated far, the readability and
> maintainability are reduced. So bring them together.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   drivers/of/fdt.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bdca35284cebd56..37b477a51175359 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -965,8 +965,7 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>   		 elfcorehdr_addr, elfcorehdr_size);
>   }
>   
> -static phys_addr_t cap_mem_addr;
> -static phys_addr_t cap_mem_size;
> +static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>   
>   /**
>    * early_init_dt_check_for_usable_mem_range - Decode usable memory range
> @@ -977,6 +976,11 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>   {
>   	const __be32 *prop;
>   	int len;
> +	phys_addr_t cap_mem_addr;
> +	phys_addr_t cap_mem_size;
> +
> +	if ((long)node < 0)
> +		return;
>   
>   	pr_debug("Looking for usable-memory-range property... ");
>   
> @@ -989,6 +993,8 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>   
>   	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
>   		 &cap_mem_size);
> +
> +	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
>   }
>   
>   #ifdef CONFIG_SERIAL_EARLYCON
> @@ -1137,9 +1143,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>   	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
>   		return 0;
>   
> +	chosen_node_offset = node;
> +
>   	early_init_dt_check_for_initrd(node);
>   	early_init_dt_check_for_elfcorehdr(node);
> -	early_init_dt_check_for_usable_mem_range(node);
>   
>   	/* Retrieve command line */
>   	p = of_get_flat_dt_prop(node, "bootargs", &l);
> @@ -1275,7 +1282,7 @@ void __init early_init_dt_scan_nodes(void)
>   	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>   
>   	/* Handle linux,usable-memory-range property */
> -	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +	early_init_dt_check_for_usable_mem_range(chosen_node_offset);
>   }
>   
>   bool __init early_init_dt_scan(void *params)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
