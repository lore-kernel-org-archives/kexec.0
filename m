Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZIvQN-0007HF-Ib
 for kexec@lists.infradead.org; Sat, 25 Jul 2015 09:07:19 +0000
Date: Sat, 25 Jul 2015 17:11:31 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] kexec: Remove the unnecessary conditional judgement to
 simplify the code logic
Message-ID: <20150725091131.GA7062@dhcp-128-25.nay.redhat.com>
References: <1433571252-11874-1-git-send-email-mhuang@redhat.com>
 <20150615092848.GB15858@dhcp-128-59.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150615092848.GB15858@dhcp-128-59.nay.redhat.com>
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
To: vgoyal@redhat.com, Dave Young <dyoung@redhat.com>
Cc: Minfei Huang <mnfhuang@gmail.com>, kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

Hi, Vivek.

Since Dave acked this patch, Could you help to merge it?

Thanks
Minfei

On 06/15/15 at 05:28pm, Dave Young wrote:
> On 06/06/15 at 02:14pm, Minfei Huang wrote:
> > From: Minfei Huang <mnfhuang@gmail.com>
> > 
> > Transforming PFN(Page Frame Number) to struct page is never failure, so
> > we can simplify the code logic to do the image->control_page assignment
> > directly in the loop, and remove the unnecessary conditional judgement.
> > 
> > Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> > ---
> >  kernel/kexec.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index 7a36fdc..4589899 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -796,11 +796,10 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
> >  		/* If I don't overlap any segments I have found my hole! */
> >  		if (i == image->nr_segments) {
> >  			pages = pfn_to_page(hole_start >> PAGE_SHIFT);
> > +			image->control_page = hole_end;
> >  			break;
> >  		}
> >  	}
> > -	if (pages)
> > -		image->control_page = hole_end;
> >  
> >  	return pages;
> >  }
> 
> Acked-by: Dave Young <dyoung@redhat.com>
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
