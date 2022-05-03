From: Philipp Rudo <prudo@redhat.com>
Date: Tue, 3 May 2022 18:43:11 +0200
Subject: [PATCH] kernel/crash_core.c : Remove redundant checks for
 ck_cmdline is NULL
In-Reply-To: <6a0fa9cc.19d4.1808440ca50.Coremail.sensor1010@163.com>
References: <20220425153857.21922-1-sensor1010@163.com>
 <20220426103952.0a080eb8@rotkaeppchen>
 <6a0fa9cc.19d4.1808440ca50.Coremail.sensor1010@163.com>
Message-ID: <20220503184311.1d8c20a1@rotkaeppchen>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi lizhe,

On Mon, 2 May 2022 18:11:20 +0800 (CST)
lizhe  <sensor1010@163.com> wrote:

> HI Philipp Rudo.
> 
> 
>       When ck_cmdline is NULL. The last three lines of this function are equivalent to : 
>           if ( !  NULL)
>                  return NULL;
>           return NULL;
>      This is obviously a redundant check.
> 
> 
>        I will use the above description to  describe the patch,

the explanation looks good to me.

Thanks!
Philipp


>  
>                                                                             thanks.
>                                                                             lizhe
>       
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2022-04-26 16:39:52, "Philipp Rudo" <prudo@redhat.com> wrote:
> >Hi lizhe,
> >
> >On Mon, 25 Apr 2022 08:38:57 -0700
> >lizhe <sensor1010@163.com> wrote:
> >  
> >>  When ck_cmdline is NULL, the only caller of get_last_crashkernel()
> >>  has already done non-NULL check(see __parse_crashkernel()),
> >>  so it doesn't make any sense to make a check here  
> >
> >sorry, but I still don't like the description. What I don't understand
> >in particular is why you are mentioning the caller (__parse_crashkernel)
> >here. ck_cmdline is a local variable to get_last_crashkernel. So the
> >caller cannot perform any check on the variable but only the return
> >value of the function. So the patch description should describe why we
> >can remove the additional return NULL without changing the behavior of
> >the function.
> >
> >Thanks
> >Philipp
> >  
> >> Signed-off-by: lizhe <sensor1010@163.com>
> >> ---
> >>  kernel/crash_core.c | 3 ---
> >>  1 file changed, 3 deletions(-)
> >> 
> >> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >> index 256cf6db573c..c232f01a2c54 100644
> >> --- a/kernel/crash_core.c
> >> +++ b/kernel/crash_core.c
> >> @@ -222,9 +222,6 @@ static __init char *get_last_crashkernel(char *cmdline,
> >>  		p = strstr(p+1, name);
> >>  	}
> >>  
> >> -	if (!ck_cmdline)
> >> -		return NULL;
> >> -
> >>  	return ck_cmdline;
> >>  }
> >>    


