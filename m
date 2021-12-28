Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n24hb-000Cfo-M9
 for kexec@lists.infradead.org; Tue, 28 Dec 2021 05:07:13 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 lr15-20020a17090b4b8f00b001b19671cbebso16064866pjb.1
 for <kexec@lists.infradead.org>; Mon, 27 Dec 2021 21:07:06 -0800 (PST)
Date: Tue, 28 Dec 2021 05:06:58 +0000
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v4 3/3] mm/page_alloc.c: do not warn allocation failure
 on zone DMA if no managed pages
Message-ID: <20211228050658.GA2115590@odroid>
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-4-bhe@redhat.com>
 <Ycax90Xex3THEZTi@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <20211227083253.GA24172@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211227083253.GA24172@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, David.Laight@aculab.com, david@redhat.com, x86@kernel.org, bp@alien8.de

On Mon, Dec 27, 2021 at 04:32:53PM +0800, Baoquan He wrote:
> On 12/25/21 at 05:53am, Hyeonggon Yoo wrote:
> > On Thu, Dec 23, 2021 at 05:44:35PM +0800, Baoquan He wrote:
> ...... 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 7c7a0b5de2ff..843bc8e5550a 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -4204,7 +4204,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
> > >  	va_list args;
> > >  	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
> > >  
> > > -	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
> > > +	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs) ||
> > > +		(gfp_mask & __GFP_DMA) && !has_managed_dma())
> > >  		return;
> > >
> > 
> > Warning when there's always no page in DMA zone is unnecessary 
> > and it confuses user.
> > 
> > The patch looks good.
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > 
> > And there is some driers that allocate memory with GFP_DMA
> > even if that flag is unnecessary. We need to do cleanup later.
> 
> Thanks for reviewing and giving out some awesome suggestions.
> 

You're welcome. Impressed to see you keep following the issue.

> > 
> > Baoquan Are you planning to do it soon?
> > I want to help that.
> 
> Yes, I had the plan and have done a little part. I talked to Christoph
> about my thought. I planned to collect all kmalloc(GFP_DMA) callsite and
> post a RFC mail, CC mailing list and maintainers related. Anyone
> interested or know one or several callsites well can help.
>

Good to hear that.
I want to help by reviewing and discussing your patches.

> Now, Christoph has handled all under drviers/scsi, and post patches to
> fix them.

Oh, didn't know he was already doing that work.

> I have gone throug those places and found out below callsites
> where we can remove GFP_DMA directly when calling kmalloc() since not
> necessary.

Note that some of them might have 24bit addressing limitation.
we need to ask maintainer or read its specification to know GFP_DMA
is unnecessary.

> And even found one place kmalloc(GFP_DMA32).

kmalloc(GFP_DMA32) is wrong because we do not create DMA32 kmalloc caches.

> (HEAD -> master) vxge: don't use GFP_DMA
> mtd: rawnand: marvell: don't use GFP_DMA
> HID: intel-ish-hid: remove wrong GFP_DMA32 flag
> ps3disk: don't use GFP_DMA
> atm: iphase: don't use GFP_DMA

> Next, I will send a RFC mail to contain those suspect callsites. We can
> track them and can help if needed. Suggest to change them with:
> 1) using dma_alloc_xx , or dma_map_xx after kmalloc()
> 2) using alloc_pages(GFP_DMA) instead

Well if the buffer is not sensitive to performance, we can just
allocate with kmalloc(GFP_KERNEL) so that dma api can use proper bounce
buffer.

if the buffer is for fastpath, I think we should convert them to
use dma_alloc_pages() to get a proper buffer.

Note that most of devices are already calling dma_map_xx directly or indirectly
(think about block layer for example) if they don't use deprecated virt_to_bus()
or friends.

But if the device do not use DMA API at all, we have few choices.
maybe convert them to use alloc_pages(GFP_DMA/GFP_DMA32) I guess?

> When we fix, we all post patch with subject key words as
> 'xxxx: don't use GFP_DMA'. Christoph has posted patch with the similar
> subject, we can search subject to get all related patches for later back
> porting.
> 
> I will add you to CC when sending. Could be tomorrow. Any suggestion or thought?
>
> Thanks
> Baoquan
> 

Thank you!
Hyeonggon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
