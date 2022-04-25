From: Baoquan He <bhe@redhat.com>
Date: Mon, 25 Apr 2022 09:36:17 +0800
Subject: [PATCH] kernel/crash_core.c: No judgment required
In-Reply-To: <20211214173242.192f47e8@rhtmp>
References: <20211210032003.16278-1-sensor1010@163.com>
 <20211214173242.192f47e8@rhtmp>
Message-ID: <YmX7EW4Gs+c1ZueQ@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/14/21 at 05:32pm, Philipp Rudo wrote:
> Hi lizhe,
> 
> On Thu,  9 Dec 2021 19:20:03 -0800
> lizhe <sensor1010@163.com> wrote:
> 
> > No judgment required ck_cmdline is NULL
> > its caller has alreadly judged, see __parse_crashkernel
> > function
> > 
> > Signed-off-by: lizhe <sensor1010@163.com>
> > ---
> >  kernel/crash_core.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index eb53f5ec62c9..9981cf9b9fe4 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -221,9 +221,6 @@ static __init char *get_last_crashkernel(char *cmdline,
> >  		p = strstr(p+1, name);
> >  	}
> >  
> > -	if (!ck_cmdline)
> > -		return NULL;
> > -
> >  	return ck_cmdline;
> >  }
> >  
> 
> I agree that the if-block is not needed and can be removed. However, I
> cannot follow your reasoning in the commit message. Could you please
> explain it in more detail.
> 
> The reason why I think that the 'if' can be removed is that the
> expression can only be true when ck_cmdline = NULL. But with that the
> last three lines are equivalent to
> 
> 	if (!ck_cmdline)
> 		return ck_cmdline;
> 
> 	return ck_cmdline;
> 
> Which simply doesn't make any sense.

Right, the judgement actually introduces redundant codes. As Zhe
replied, maybe you can rewrite the log and repost with your
Signed-off-by, Philipp. As for Author, you two can discuss in private
mail.


