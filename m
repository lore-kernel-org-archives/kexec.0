Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bU4p8-0007NN-76
 for kexec@lists.infradead.org; Mon, 01 Aug 2016 04:27:33 +0000
Received: by mail-pf0-x233.google.com with SMTP id p64so50984022pfb.1
 for <kexec@lists.infradead.org>; Sun, 31 Jul 2016 21:27:09 -0700 (PDT)
Date: Mon, 1 Aug 2016 13:32:30 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH] kexec: (bugfix) mem_regions_sort()
Message-ID: <20160801043229.GB7995@linaro.org>
References: <20160729082323.12253-1-takahiro.akashi@linaro.org>
 <20160729082537.GA28046@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160729082537.GA28046@localhost.localdomain>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: rmk@armlinux.org.uk, horms@verge.net.au, kexec@lists.infradead.org

On Fri, Jul 29, 2016 at 01:55:37PM +0530, Pratyush Anand wrote:
> On 29/07/2016:05:23:23 PM, AKASHI Takahiro wrote:
> > The third argument of qsort() must be the size of each array element.
> 
> Yes, I had sent it day before yesterday which has been ACKed by Russell.

Oops, thanks.
You must have found it in trying my kdump patch.

Thanks,
-Takahiro AKASHI

> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  kexec/mem_regions.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> > index e61c074..a8cb510 100644
> > --- a/kexec/mem_regions.c
> > +++ b/kexec/mem_regions.c
> > @@ -24,7 +24,7 @@ static int mem_range_cmp(const void *a1, const void *a2)
> >   */
> >  void mem_regions_sort(struct memory_ranges *ranges)
> >  {
> > -	qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges),
> > +	qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges[0]),
> >  	      mem_range_cmp);
> >  }
> >  
> > -- 
> > 2.9.0
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
