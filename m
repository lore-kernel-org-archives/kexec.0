Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1lRS-00GN4t-Hd
 for kexec@lists.infradead.org; Mon, 27 Dec 2021 08:33:16 +0000
Date: Mon, 27 Dec 2021 16:32:53 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4 3/3] mm/page_alloc.c: do not warn allocation failure
 on zone DMA if no managed pages
Message-ID: <20211227083253.GA24172@MiWiFi-R3L-srv>
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-4-bhe@redhat.com>
 <Ycax90Xex3THEZTi@ip-172-31-30-232.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ycax90Xex3THEZTi@ip-172-31-30-232.ap-northeast-1.compute.internal>
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
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, David.Laight@aculab.com, david@redhat.com, x86@kernel.org, bp@alien8.de

On 12/25/21 at 05:53am, Hyeonggon Yoo wrote:
> On Thu, Dec 23, 2021 at 05:44:35PM +0800, Baoquan He wrote:
...... 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 7c7a0b5de2ff..843bc8e5550a 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4204,7 +4204,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
> >  	va_list args;
> >  	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
> >  
> > -	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
> > +	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs) ||
> > +		(gfp_mask & __GFP_DMA) && !has_managed_dma())
> >  		return;
> >
> 
> Warning when there's always no page in DMA zone is unnecessary 
> and it confuses user.
> 
> The patch looks good.
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> And there is some driers that allocate memory with GFP_DMA
> even if that flag is unnecessary. We need to do cleanup later.

Thanks for reviewing and giving out some awesome suggestions.

> 
> Baoquan Are you planning to do it soon?
> I want to help that.

Yes, I had the plan and have done a little part. I talked to Christoph
about my thought. I planned to collect all kmalloc(GFP_DMA) callsite and
post a RFC mail, CC mailing list and maintainers related. Anyone
interested or know one or several callsites well can help.

Now, Christoph has handled all under drviers/scsi, and post patches to
fix them. I have gone throug those places and found out below callsites
where we can remove GFP_DMA directly when calling kmalloc() since not
necessary. And even found one place kmalloc(GFP_DMA32).

(HEAD -> master) vxge: don't use GFP_DMA
mtd: rawnand: marvell: don't use GFP_DMA
HID: intel-ish-hid: remove wrong GFP_DMA32 flag
ps3disk: don't use GFP_DMA
atm: iphase: don't use GFP_DMA

Next, I will send a RFC mail to contain those suspect callsites. We can
track them and can help if needed. Suggest to change them with:
1) using dma_alloc_xx , or dma_map_xx after kmalloc()
2) using alloc_pages(GFP_DMA) instead

When we fix, we all post patch with subject key words as
'xxxx: don't use GFP_DMA'. Christoph has posted patch with the similar
subject, we can search subject to get all related patches for later back
porting.

I will add you to CC when sending. Could be tomorrow. Any suggestion or thought?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
