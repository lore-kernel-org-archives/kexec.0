Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYTO1-0004Js-Vw
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 04:48:22 +0000
Date: Fri, 11 Apr 2014 12:47:51 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v5 02/10] x86, cleanup: add extra arguments to
 add_memmap() and delete_memmap()
Message-ID: <20140411044751.GI2944@dhcp-17-89.nay.redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
 <1397121186-9353-3-git-send-email-chaowang@redhat.com>
 <20140411022258.GE5493@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140411022258.GE5493@dhcp-16-198.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/11/14 at 10:22am, Dave Young wrote:
> On 04/10/14 at 05:12pm, WANG Chao wrote:
> > This change will be used later:
> > 
> > add_memmap(.., int *nr_memmap, .., int type);
> > delete_memmap(.., int *nr_memmap, ..);
> > 
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > ---
> >  kexec/arch/i386/crashdump-x86.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index 72bce0b..e695eaf 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -476,8 +476,8 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
> >  
> >  /* Adds a segment from list of memory regions which new kernel can use to
> >   * boot. Segment start and end should be aligned to 1K boundary. */
> > -static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
> > -								size_t size)
> > +static int add_memmap(struct memory_range *memmap_p, int *nr_memmap_p,
> > +			unsigned long long addr, size_t size, int type)
> 
> Maybe nr_memmap is better than nr_memmap_p?

Sure. Will rename. I thought nr_memmap_p vs. memmap_p looked more no-brainer.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
