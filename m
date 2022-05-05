From: Baoquan He <bhe@redhat.com>
Date: Fri, 6 May 2022 07:19:07 +0800
Subject: [PATCH] kernel/crash_core.c : Remove redundant checks for
 ck_cmdline is NULL
In-Reply-To: <20220504123623.36852-1-sensor1010@163.com>
References: <20220504123623.36852-1-sensor1010@163.com>
Message-ID: <20220505231907.GB2331@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/04/22 at 05:36am, lizhe wrote:
> When ck_cmdline is NULL. The last three lines of
> this function(get_last_crashkernel()) are equivalent to :
> 	if (!NULL)
> 		return NULL;
> 
> 	return NULL;
> This is obviously a redundant check

Now the patch log correctly reflects the code change, even though the
log is a little redundant. While it's far far better than a wrong log
which will definitely confuse, even mislead people. I would go with:

======
kernel/crash_core.c : remove redundant check of ck_cmdline

At the end of get_last_crashkernel(), the judgement of ck_cmdline is
obviously unnecessary and causes redundance, let's clean it up.
======

And the patch version is missing. If you agree on the above log
rephrasing, please post v4 with the updated log, and can add my ack:

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> 
> Signed-off-by: lizhe <sensor1010@163.com>
> ---
>  kernel/crash_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573c..c232f01a2c54 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -222,9 +222,6 @@ static __init char *get_last_crashkernel(char *cmdline,
>  		p = strstr(p+1, name);
>  	}
>  
> -	if (!ck_cmdline)
> -		return NULL;
> -
>  	return ck_cmdline;
>  }
>  
> -- 
> 2.25.1
> 


