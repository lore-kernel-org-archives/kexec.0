From: Philipp Rudo <prudo@redhat.com>
Date: Tue, 26 Apr 2022 10:17:18 +0200
Subject: [PATCH] kernel/crash_core.c: No judgment required
In-Reply-To: <62058381.3b6e.1805f62c8f4.Coremail.sensor1010@163.com>
References: <20211210032003.16278-1-sensor1010@163.com>
 <20211214173242.192f47e8@rhtmp> <YmX7EW4Gs+c1ZueQ@MiWiFi-R3L-srv>
 <62058381.3b6e.1805f62c8f4.Coremail.sensor1010@163.com>
Message-ID: <20220426101718.765686a9@rotkaeppchen>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi lizhe,

On Mon, 25 Apr 2022 14:22:31 +0800 (CST)
lizhe  <sensor1010@163.com> wrote:

> HI :
> 
> 
> I found the problem at the first time and gave the solution,
> 
> 
> 
> 
> Pphilipp Rudo just saw the solution to the problem and gave an explanation.
> the author of this patch should only be me

right, I only commented on the patch you sent.

Could you please update the commit message and send a v2.

Thanks
Philipp

> 
> 
> 
> 
> 
> 
> 
>                                                                                        lizhe
> 
> 
> 
> 
> 
> 
> 
> 
> At 2022-04-25 09:36:17, "Baoquan He" <bhe@redhat.com> wrote:
> >On 12/14/21 at 05:32pm, Philipp Rudo wrote:  
> >> Hi lizhe,
> >> 
> >> On Thu,  9 Dec 2021 19:20:03 -0800
> >> lizhe <sensor1010@163.com> wrote:
> >>   
> >> > No judgment required ck_cmdline is NULL
> >> > its caller has alreadly judged, see __parse_crashkernel
> >> > function
> >> > 
> >> > Signed-off-by: lizhe <sensor1010@163.com>
> >> > ---
> >> >  kernel/crash_core.c | 3 ---
> >> >  1 file changed, 3 deletions(-)
> >> > 
> >> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >> > index eb53f5ec62c9..9981cf9b9fe4 100644
> >> > --- a/kernel/crash_core.c
> >> > +++ b/kernel/crash_core.c
> >> > @@ -221,9 +221,6 @@ static __init char *get_last_crashkernel(char *cmdline,
> >> >  		p = strstr(p+1, name);
> >> >  	}
> >> >  
> >> > -	if (!ck_cmdline)
> >> > -		return NULL;
> >> > -
> >> >  	return ck_cmdline;
> >> >  }
> >> >    
> >> 
> >> I agree that the if-block is not needed and can be removed. However, I
> >> cannot follow your reasoning in the commit message. Could you please
> >> explain it in more detail.
> >> 
> >> The reason why I think that the 'if' can be removed is that the
> >> expression can only be true when ck_cmdline = NULL. But with that the
> >> last three lines are equivalent to
> >> 
> >> 	if (!ck_cmdline)
> >> 		return ck_cmdline;
> >> 
> >> 	return ck_cmdline;
> >> 
> >> Which simply doesn't make any sense.  
> >
> >Right, the judgement actually introduces redundant codes. As Zhe
> >replied, maybe you can rewrite the log and repost with your
> >Signed-off-by, Philipp. As for Author, you two can discuss in private
> >mail.  


