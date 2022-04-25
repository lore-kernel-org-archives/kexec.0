From: Baoquan He <bhe@redhat.com>
Date: Mon, 25 Apr 2022 11:49:48 +0800
Subject: [PATCH v22 1/9] kdump: return -ENOENT if required cmdline option
 does not exist
In-Reply-To: <20220414115720.1887-2-thunder.leizhen@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-2-thunder.leizhen@huawei.com>
Message-ID: <YmYaXDrEYOXLzT5H@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/14/22 at 07:57pm, Zhen Lei wrote:
> According to the current crashkernel=Y,low support in other ARCHes, it's
> an optional command-line option. When it doesn't exist, kernel will try
> to allocate minimum required memory below 4G automatically.
> 
> However, __parse_crashkernel() returns '-EINVAL' for all error cases. It
> can't distinguish the nonexistent option from invalid option.
> 
> Change __parse_crashkernel() to return '-ENOENT' for the nonexistent option
> case. With this change, crashkernel,low memory will take the default
> value if crashkernel=,low is not specified; while crashkernel reservation
> will fail and bail out if an invalid option is specified.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/crash_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573cd09..4d57c03714f4e13 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -243,9 +243,8 @@ static int __init __parse_crashkernel(char *cmdline,
>  	*crash_base = 0;
>  
>  	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
> -
>  	if (!ck_cmdline)
> -		return -EINVAL;
> +		return -ENOENT;
>  
>  	ck_cmdline += strlen(name);
>  
> -- 
> 2.25.1
> 


