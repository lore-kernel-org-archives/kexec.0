From: Kari Argillander <kari.argillander@gmail.com>
Date: Fri, 6 May 2022 08:28:47 +0300
Subject: [PATCH v4] kernel/crash_core.c : remove redundant check of
 ck_cmdline
In-Reply-To: <20220506043226.125611-1-sensor1010@163.com>
References: <20220506043226.125611-1-sensor1010@163.com>
Message-ID: <e3861491-74f0-1d83-fef7-9086a9ae0fdc@gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 6.5.2022 7.32, lizhe wrote:
> At the end of get_last_crashkernel(), the judgement of ck_cmdline is
> obviously unnecessary and causes redundance, let's clean it up.
> 
> Signed-off-by: lizhe <sensor1010@163.com>

Signed off by should be real name. Greg ask this already, but you did
not ever answer [1].

[1]: https://lore.kernel.org/lkml/Yi2nfjH7aph6CuiX at kroah.com/

> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Philipp Rudo <prudo@redhat.com>
> ---
>   kernel/crash_core.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573c..c232f01a2c54 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -222,9 +222,6 @@ static __init char *get_last_crashkernel(char *cmdline,
>   		p = strstr(p+1, name);
>   	}
>   
> -	if (!ck_cmdline)
> -		return NULL;
> -
>   	return ck_cmdline;
>   }
>   

