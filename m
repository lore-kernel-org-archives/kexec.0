From: john.p.donnelly@oracle.com <john.p.donnelly@oracle.com>
Date: Tue, 11 Jan 2022 09:05:28 -0600
Subject: [PATCH v19 04/13] kdump: reduce unnecessary parameters of
 parse_crashkernel_{high|low}()
In-Reply-To: <20211228132612.1860-5-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-5-thunder.leizhen@huawei.com>
Message-ID: <6dbf6d62-a860-4b69-5ea0-f540d52dbf43@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> Delete confusing parameters 'system_ram' and 'crash_base' of
> parse_crashkernel_{high|low}(), they are only needed by the case of
> "crashkernel=X@[offset]".
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   kernel/crash_core.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 3b9e01fc450b2a4..b7d024eb464d0ae 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -278,20 +278,20 @@ int __init parse_crashkernel(char *cmdline,
>   }
>   
>   static int __init parse_crashkernel_high(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> +					 unsigned long long *crash_size)
>   {
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> +	unsigned long long base;
> +
> +	return __parse_crashkernel(cmdline, 0, crash_size, &base,
>   				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
>   }
>   
>   static int __init parse_crashkernel_low(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> +					unsigned long long *crash_size)
>   {
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> +	unsigned long long base;
> +
> +	return __parse_crashkernel(cmdline, 0, crash_size, &base,
>   				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
>   }
>   
> @@ -310,12 +310,11 @@ int __init parse_crashkernel_high_low(char *cmdline,
>   				      unsigned long long *low_size)
>   {
>   	int ret;
> -	unsigned long long base;
>   
>   	BUG_ON(!high_size || !low_size);
>   
>   	/* crashkernel=X,high */
> -	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
> +	ret = parse_crashkernel_high(cmdline, high_size);
>   	if (ret)
>   		return ret;
>   
> @@ -323,7 +322,7 @@ int __init parse_crashkernel_high_low(char *cmdline,
>   		return -EINVAL;
>   
>   	/* crashkernel=Y,low */
> -	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);
> +	ret = parse_crashkernel_low(cmdline, low_size);
>   	if (ret)
>   		*low_size = -1;
>   


