Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0mgw-0004WR-1B
 for kexec@lists.infradead.org; Wed, 08 Jan 2014 06:32:39 +0000
Date: Wed, 8 Jan 2014 14:32:09 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH] makedumpfile: -v shows if lzo or snappy support enabled
 or not
Message-ID: <20140108063209.GA14589@dhcp-17-89.nay.redhat.com>
References: <20140108054033.GA6109@dhcp-17-89.nay.redhat.com>
 <52CCE8B9.8060008@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52CCE8B9.8060008@cn.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: kexec@lists.infradead.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

On 01/08/14 at 01:57pm, Zhang Yanfei wrote:
> Hello chao
> 
> On 01/08/2014 01:40 PM, WANG Chao wrote:
> > It would be great to have makedumpfile -v to show if lzo or snappy
> > support is enabled or not, since --help prints too much and we have to
> > scroll back three screens to check it out.
> > 
> > Using "+lzo" to indicate lzo is enabled and vice versa "-lzo" for lzo is
> > disabled. Same for snappy.
> > 
> > For exmaple, If lzo and snappy support are enabled,
> > 
> >     $ ./makedumpfile -v
> >     makedumpfile: version 1.5.5 (released on 18 Dec 2013)
> >     +lzo +snappy
> > 
> > If both of them are disabled,
> > 
> >     $ ./makedumpfile -v
> >     makedumpfile: version 1.5.5 (released on 18 Dec 2013)
> >     -lzo -snappy
> 
> This is weird... we may even think we have lzo/snappy enabled
> since an option is always specified with '-'.

I took this idea from `vim --version`. But it seems like vim has too
many features that there's always +xxx out there to distinguish them
from -xxx. I think you make a good point.

> 
> My idea is to have "with lzo/snappy enabled" directly appended
> when lzo/snappy enabled.

That works for me either as long as -v has the information about
lzo/snappy is enabled or not. But to simplify the code, I prefer
something like this:
" lzo    enabled
  snappy enabled"
and also display "lzo disabled" explicitly.

> 
> And is it ok to add such info to the version ? I don't know.
> kumagai may give the answer.

Yeah, let's wait.

Thanks
WANG Chao

> 
> Thanks.
> 
> > 
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > ---
> >  print_info.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/print_info.c b/print_info.c
> > index 90b6cee..242b42c 100644
> > --- a/print_info.c
> > +++ b/print_info.c
> > @@ -26,7 +26,17 @@ void
> >  show_version(void)
> >  {
> >  	MSG("makedumpfile: version " VERSION " (released on " RELEASE_DATE ")\n");
> > -	MSG("\n");
> > +#ifdef USELZO
> > +	MSG("+lzo ");
> > +#else
> > +	MSG("-lzo ");
> > +#endif
> > +#ifdef USESNAPPY
> > +	MSG("+snappy ");
> > +#else
> > +	MSG("-snappy ");
> > +#endif
> > +	MSG("\n\n");
> >  }
> >  
> >  void
> > 
> 
> 
> -- 
> Thanks.
> Zhang Yanfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
