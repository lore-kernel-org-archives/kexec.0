From: Baoquan He <bhe@redhat.com>
Date: Tue, 15 Mar 2022 19:57:52 +0800
Subject: [PATCH v21 1/5] kdump: return -ENOENT if required cmdline option
 does not exist
In-Reply-To: <20220227030717.1464-2-thunder.leizhen@huawei.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-2-thunder.leizhen@huawei.com>
Message-ID: <YjB/QILintgvo1AL@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/27/22 at 11:07am, Zhen Lei wrote:
> The crashkernel=Y,low is an optional command-line option. When it doesn't
> exist, kernel will try to allocate minimum required memory below 4G
> automatically. Give it a unique error code to distinguish it from other
> error scenarios.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
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

Firstly, I am not sure if '-ENOENT' is a right value to return. From the
code comment of ENOENT, it's used for file or dir?
#define ENOENT           2      /* No such file or directory */

Secondly, we ever discussed the case including
 - no crashkernel=,low is provided;
 - messy code is provied, e.g crashkernel=aaaaaabbbb,low

The 2nd one is not handled in this patchset. How about taking the
handling into another round of patches. This patchset just adds
crashkernel=,high purely.

>  
>  	ck_cmdline += strlen(name);
>  
> -- 
> 2.25.1
> 


