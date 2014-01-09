Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W14OM-0007O4-R1
 for kexec@lists.infradead.org; Thu, 09 Jan 2014 01:26:40 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: -v shows if lzo or snappy support enabled
 or not
Date: Thu, 9 Jan 2014 01:24:03 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971D9AFD@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: WANG Chao <chaowang@redhat.com>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 2014/01/08 15:32:51, kexec <kexec-bounces@lists.infradead.org> wrote:
> On 01/08/14 at 01:57pm, Zhang Yanfei wrote:
> > Hello chao
> >
> > On 01/08/2014 01:40 PM, WANG Chao wrote:
> > > It would be great to have makedumpfile -v to show if lzo or snappy
> > > support is enabled or not, since --help prints too much and we have to
> > > scroll back three screens to check it out.
> > >
> > > Using "+lzo" to indicate lzo is enabled and vice versa "-lzo" for lzo is
> > > disabled. Same for snappy.
> > >
> > > For exmaple, If lzo and snappy support are enabled,
> > >
> > >     $ ./makedumpfile -v
> > >     makedumpfile: version 1.5.5 (released on 18 Dec 2013)
> > >     +lzo +snappy
> > >
> > > If both of them are disabled,
> > >
> > >     $ ./makedumpfile -v
> > >     makedumpfile: version 1.5.5 (released on 18 Dec 2013)
> > >     -lzo -snappy
> >
> > This is weird... we may even think we have lzo/snappy enabled
> > since an option is always specified with '-'.
>
> I took this idea from `vim --version`. But it seems like vim has too
> many features that there's always +xxx out there to distinguish them
> from -xxx. I think you make a good point.
>
> >
> > My idea is to have "with lzo/snappy enabled" directly appended
> > when lzo/snappy enabled.
>
> That works for me either as long as -v has the information about
> lzo/snappy is enabled or not. But to simplify the code, I prefer
> something like this:
> " lzo    enabled
>   snappy enabled"
> and also display "lzo disabled" explicitly.

I agree with this idea.

> >
> > And is it ok to add such info to the version ? I don't know.
> > kumagai may give the answer.
>
> Yeah, let's wait.

I think it's good, I'm tired of that scroll back :-(
Could you post a v2 patch ?


Thanks
Atsushi Kumagai

>
> Thanks
> WANG Chao
>
> >
> > Thanks.
> >
> > >
> > > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > > ---
> > >  print_info.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/print_info.c b/print_info.c
> > > index 90b6cee..242b42c 100644
> > > --- a/print_info.c
> > > +++ b/print_info.c
> > > @@ -26,7 +26,17 @@ void
> > >  show_version(void)
> > >  {
> > >   MSG("makedumpfile: version " VERSION " (released on " RELEASE_DATE ")\n");
> > > - MSG("\n");
> > > +#ifdef USELZO
> > > + MSG("+lzo ");
> > > +#else
> > > + MSG("-lzo ");
> > > +#endif
> > > +#ifdef USESNAPPY
> > > + MSG("+snappy ");
> > > +#else
> > > + MSG("-snappy ");
> > > +#endif
> > > + MSG("\n\n");
> > >  }
> > >
> > >  void
> > >
> >
> >
> > --
> > Thanks.
> > Zhang Yanfei
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
