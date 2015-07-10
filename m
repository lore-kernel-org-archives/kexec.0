Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZDTgM-0000dd-RD
 for kexec@lists.infradead.org; Fri, 10 Jul 2015 08:29:19 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 10 Jul 2015 09:28:56 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8AC741B0804B
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 09:30:05 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6A8SrpY32047284
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 08:28:53 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6A3LkWK019848
 for <kexec@lists.infradead.org>; Thu, 9 Jul 2015 23:21:47 -0400
Date: Fri, 10 Jul 2015 10:28:50 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150710102850.06041275@holzheu>
In-Reply-To: <20150710040527.GA3642@dhcp-128-21.nay.redhat.com>
References: <1435801552-1230-1-git-send-email-mnfhuang@gmail.com>
 <20150707211840.GA4388@redhat.com>
 <20150709175411.7037a4fa@holzheu>
 <20150710040527.GA3642@dhcp-128-21.nay.redhat.com>
Mime-Version: 1.0
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
To: Minfei Huang <mnfhuang@gmail.com>
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, linux390@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

On Fri, 10 Jul 2015 12:05:27 +0800
Minfei Huang <mnfhuang@gmail.com> wrote:

> On 07/09/15 at 05:54P, Michael Holzheu wrote:
> > On Tue, 7 Jul 2015 17:18:40 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > On Thu, Jul 02, 2015 at 09:45:52AM +0800, Minfei Huang wrote:
> > 
> > [snip]
> > 
> > > I am thinking of moving kernel loading code in a separate function to
> > > make things little simpler. Right now it is confusing.
> > > 
> > > Can you please test attached patch. I have only compile tested it. This
> > > is primarily doing what you are doing but in a separate function. It
> > > seems more readable now.
> > 
> > The patch looks good to me. What about the following patch on top
> > to make things even more readable?
> > ---
> >  kernel/kexec.c |   50 +++++++++++++++++---------------------------------
> >  1 file changed, 17 insertions(+), 33 deletions(-)
> > 
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1236,14 +1236,18 @@ int kexec_load_disabled;
> >  
> >  static DEFINE_MUTEX(kexec_mutex);
> >  
> > -static int __kexec_load(struct kimage **rimage, unsigned long entry,
> > -			unsigned long nr_segments,
> > +static int __kexec_load(unsigned long entry, unsigned long nr_segments,
> >  			struct kexec_segment __user * segments,
> >  			unsigned long flags)
> >  {
> > +	struct kimage *image, **dest_image;
> >  	unsigned long i;
> >  	int result;
> > -	struct kimage *image;
> > +
> > +	dest_image = (flags & KEXEC_ON_CRASH) ? &kexec_crash_image : &kexec_image;
> > +
> > +	if (nr_segments == 0)
> > +		return 0;
> 
> It is fine, if nr_segments is 0. So we should deal with this case like
> original kexec code.
> 
> >  
> >  	if (flags & KEXEC_ON_CRASH) {
> >  		/*
> > @@ -1251,7 +1255,6 @@ static int __kexec_load(struct kimage **
> >  		 * crashes.  Free any current crash dump kernel before
> >  		 * we corrupt it.
> >  		 */
> > -
> >  		kimage_free(xchg(&kexec_crash_image, NULL));
> >  	}
> >  
> > @@ -1267,30 +1270,29 @@ static int __kexec_load(struct kimage **
> >  
> >  	result = machine_kexec_prepare(image);
> >  	if (result)
> > -		goto out;
> > +		goto fail;
> >  
> >  	for (i = 0; i < nr_segments; i++) {
> >  		result = kimage_load_segment(image, &image->segment[i]);
> >  		if (result)
> > -			goto out;
> > +			goto fail;
> >  	}
> > -
> >  	kimage_terminate(image);
> > -	*rimage = image;
> > -out:
> > +	/* Install the new kernel, and  uninstall the old */
> > +	kimage_free(xchg(dest_image, image));
> >  	if (flags & KEXEC_ON_CRASH)
> >  		crash_unmap_reserved_pages();
> > -
> > -	/* Free image if there was an error */
> > -	if (result)
> > -		kimage_free(image);
> > +	return 0;
> > +fail:
> > +	if (flags & KEXEC_ON_CRASH)
> > +		crash_unmap_reserved_pages();
> > +	kimage_free(image);
> 
> Kernel release image again

Again? This is only done in the error case.

> , and will crash in here, since we do not
> assign the image to NULL when we release the image above.

Good catch, I should have set image=NULL at the beginning of __kexec_load().

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
