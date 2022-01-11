From: john.p.donnelly@oracle.com <john.p.donnelly@oracle.com>
Date: Tue, 11 Jan 2022 09:03:22 -0600
Subject: [PATCH v19 01/13] kdump: add helper parse_crashkernel_high_low()
In-Reply-To: <20211228132612.1860-2-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-2-thunder.leizhen@huawei.com>
Message-ID: <7f420af1-9fce-5a36-5788-8de52502781f@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> The bootup command line option crashkernel=Y,low is valid only when
> crashkernel=X,high is specified. Putting their parsing into a separate
> function makes the code logic clearer and easier to understand the strong
> dependencies between them.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   include/linux/crash_core.h |  3 +++
>   kernel/crash_core.c        | 35 +++++++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e7db..2d3a64761d18998 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -83,5 +83,8 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
> +int __init parse_crashkernel_high_low(char *cmdline,
> +				      unsigned long long *high_size,
> +				      unsigned long long *low_size);
>   
>   #endif /* LINUX_CRASH_CORE_H */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index eb53f5ec62c900f..8966beaf7c4fd52 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -295,6 +295,41 @@ int __init parse_crashkernel_low(char *cmdline,
>   				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
>   }
>   
> +/**
> + * parse_crashkernel_high_low - Parsing "crashkernel=X,high" and possible
> + *				"crashkernel=Y,low".
> + * @cmdline:	The bootup command line.
> + * @high_size:	Save the memory size specified by "crashkernel=X,high".
> + * @low_size:	Save the memory size specified by "crashkernel=Y,low" or "-1"
> + *		if it's not specified.
> + *
> + * Returns 0 on success, else a negative status code.
> + */
> +int __init parse_crashkernel_high_low(char *cmdline,
> +				      unsigned long long *high_size,
> +				      unsigned long long *low_size)
> +{
> +	int ret;
> +	unsigned long long base;
> +
> +	BUG_ON(!high_size || !low_size);
> +
> +	/* crashkernel=X,high */
> +	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
> +	if (ret)
> +		return ret;
> +
> +	if (*high_size <= 0)
> +		return -EINVAL;
> +
> +	/* crashkernel=Y,low */
> +	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);
> +	if (ret)
> +		*low_size = -1;
> +
> +	return 0;
> +}
> +
>   Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>   			  void *data, size_t data_len)
>   {


