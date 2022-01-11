From: john.p.donnelly@oracle.com <john.p.donnelly@oracle.com>
Date: Tue, 11 Jan 2022 09:04:43 -0600
Subject: [PATCH v19 03/13] kdump: make parse_crashkernel_{high|low}()
 static
In-Reply-To: <20211228132612.1860-4-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-4-thunder.leizhen@huawei.com>
Message-ID: <f70c75a6-c816-8b20-797e-eda11ffed3a8@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> Make parse_crashkernel_{high|low}() static, they are only referenced by
> parse_crashkernel_high_low() in the same file. The latter is recommended.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   include/linux/crash_core.h | 4 ----
>   kernel/crash_core.c        | 4 ++--
>   2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 2d3a64761d18998..598fd55d83c169e 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -79,10 +79,6 @@ void final_note(Elf_Word *buf);
>   
>   int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
> -int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
> -int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
>   int __init parse_crashkernel_high_low(char *cmdline,
>   				      unsigned long long *high_size,
>   				      unsigned long long *low_size);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 8966beaf7c4fd52..3b9e01fc450b2a4 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -277,7 +277,7 @@ int __init parse_crashkernel(char *cmdline,
>   					"crashkernel=", NULL);
>   }
>   
> -int __init parse_crashkernel_high(char *cmdline,
> +static int __init parse_crashkernel_high(char *cmdline,
>   			     unsigned long long system_ram,
>   			     unsigned long long *crash_size,
>   			     unsigned long long *crash_base)
> @@ -286,7 +286,7 @@ int __init parse_crashkernel_high(char *cmdline,
>   				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
>   }
>   
> -int __init parse_crashkernel_low(char *cmdline,
> +static int __init parse_crashkernel_low(char *cmdline,
>   			     unsigned long long system_ram,
>   			     unsigned long long *crash_size,
>   			     unsigned long long *crash_base)


