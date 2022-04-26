From: Philipp Rudo <prudo@redhat.com>
Date: Tue, 26 Apr 2022 10:39:52 +0200
Subject: [PATCH] kernel/crash_core.c : Remove redundant checks for
 ck_cmdline is NULL
In-Reply-To: <20220425153857.21922-1-sensor1010@163.com>
References: <20220425153857.21922-1-sensor1010@163.com>
Message-ID: <20220426103952.0a080eb8@rotkaeppchen>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi lizhe,

On Mon, 25 Apr 2022 08:38:57 -0700
lizhe <sensor1010@163.com> wrote:

>  When ck_cmdline is NULL, the only caller of get_last_crashkernel()
>  has already done non-NULL check(see __parse_crashkernel()),
>  so it doesn't make any sense to make a check here

sorry, but I still don't like the description. What I don't understand
in particular is why you are mentioning the caller (__parse_crashkernel)
here. ck_cmdline is a local variable to get_last_crashkernel. So the
caller cannot perform any check on the variable but only the return
value of the function. So the patch description should describe why we
can remove the additional return NULL without changing the behavior of
the function.

Thanks
Philipp

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


