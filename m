Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22e.google.com ([2607:f8b0:400e:c03::22e])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZCoAu-0006ci-4x
 for kexec@lists.infradead.org; Wed, 08 Jul 2015 12:10:04 +0000
Received: by pacws9 with SMTP id ws9so132318683pac.0
 for <kexec@lists.infradead.org>; Wed, 08 Jul 2015 05:09:43 -0700 (PDT)
Date: Wed, 8 Jul 2015 20:09:51 +0800
From: Minfei Huang <mnfhuang@gmail.com>
Subject: Re: [PATCH v3] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150708120951.GB8672@dhcp-128-42.nay.redhat.com>
References: <1435801552-1230-1-git-send-email-mnfhuang@gmail.com>
 <20150707211840.GA4388@redhat.com>
 <20150708120638.GA8672@dhcp-128-42.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150708120638.GA8672@dhcp-128-42.nay.redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, linux390@de.ibm.com, holzheu@linux.vnet.ibm.com

On 07/08/15 at 08:06P, Minfei Huang wrote:
> On 07/07/15 at 05:18P, Vivek Goyal wrote:
> > On Thu, Jul 02, 2015 at 09:45:52AM +0800, Minfei Huang wrote:
> > > For some arch, kexec shall map the reserved pages, then use them, when
> > > we try to start the kdump service.
> > > 
> > > Now kexec will never unmap the reserved pages, once it fails to continue
> > > starting the kdump service.
> > > 
> > > Make a pair of reserved pages in kdump starting path, whatever kexec
> > > fails or not.
> > > 
> > > Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> > > ---
> > > v2:
> > > - replace the "failure" label with "fail_unmap_pages"
> > > v1:
> > > - reconstruct the patch code
> > > ---
> > >  kernel/kexec.c | 26 ++++++++++++++------------
> > >  1 file changed, 14 insertions(+), 12 deletions(-)
> > > 
> > 
> > Hi Minfei,
> > 
> > I am thinking of moving kernel loading code in a separate function to
> > make things little simpler. Right now it is confusing.
> 
> In my patch, I think maybe the label confuses with the reviewer, which
> does not express the intention clearly. 
> 
> > 
> > Can you please test attached patch. I have only compile tested it. This
> > is primarily doing what you are doing but in a separate function. It
> > seems more readable now.
> > 
> 
> The patch passed the simple testcase. Since it does change the code
						   ^^^^^
						 does not change
> logic, I think there is no risky.
> 
> Thanks
> Minfei
> 
> > Thanks
> > Vivek
> > 
> > 
> > ---
> >  kernel/kexec.c |   90 +++++++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 56 insertions(+), 34 deletions(-)
> > 
> > Index: rhvgoyal-linux/kernel/kexec.c
> > ===================================================================
> > --- rhvgoyal-linux.orig/kernel/kexec.c	2015-07-06 13:59:35.088129148 -0400
> > +++ rhvgoyal-linux/kernel/kexec.c	2015-07-07 17:14:23.593175644 -0400
> > @@ -1247,6 +1247,57 @@ int kexec_load_disabled;
> >  
> >  static DEFINE_MUTEX(kexec_mutex);
> >  
> > +static int __kexec_load(struct kimage **rimage, unsigned long entry,
> > +			unsigned long nr_segments,
> > +			struct kexec_segment __user * segments,
> > +			unsigned long flags)
> > +{
> > +	unsigned long i;
> > +	int result;
> > +	struct kimage *image;
> > +
> > +	if (flags & KEXEC_ON_CRASH) {
> > +		/*
> > +		 * Loading another kernel to switch to if this one
> > +		 * crashes.  Free any current crash dump kernel before
> > +		 * we corrupt it.
> > +		 */
> > +
> > +		kimage_free(xchg(&kexec_crash_image, NULL));
> > +	}
> > +
> > +	result = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
> > +	if (result)
> > +		return result;
> > +
> > +	if (flags & KEXEC_ON_CRASH)
> > +		crash_map_reserved_pages();
> > +
> > +	if (flags & KEXEC_PRESERVE_CONTEXT)
> > +		image->preserve_context = 1;
> > +
> > +	result = machine_kexec_prepare(image);
> > +	if (result)
> > +		goto out;
> > +
> > +	for (i = 0; i < nr_segments; i++) {
> > +		result = kimage_load_segment(image, &image->segment[i]);
> > +		if (result)
> > +			goto out;
> > +	}
> > +
> > +	kimage_terminate(image);
> > +	*rimage = image;
> > +out:
> > +	if (flags & KEXEC_ON_CRASH)
> > +		crash_unmap_reserved_pages();
> > +
> > +	/* Free image if there was an error */
> > +	if (result)
> > +		kimage_free(image);
> > +	return result;
> > +}
> > +
> >  SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> >  		struct kexec_segment __user *, segments, unsigned long, flags)
> >  {
> > @@ -1292,44 +1343,15 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
> >  	dest_image = &kexec_image;
> >  	if (flags & KEXEC_ON_CRASH)
> >  		dest_image = &kexec_crash_image;
> > -	if (nr_segments > 0) {
> > -		unsigned long i;
> >  
> > -		if (flags & KEXEC_ON_CRASH) {
> > -			/*
> > -			 * Loading another kernel to switch to if this one
> > -			 * crashes.  Free any current crash dump kernel before
> > -			 * we corrupt it.
> > -			 */
> > -
> > -			kimage_free(xchg(&kexec_crash_image, NULL));
> > -			result = kimage_alloc_init(&image, entry, nr_segments,
> > -						   segments, flags);
> > -			crash_map_reserved_pages();
> > -		} else {
> > -			/* Loading another kernel to reboot into. */
> > -
> > -			result = kimage_alloc_init(&image, entry, nr_segments,
> > -						   segments, flags);
> > -		}
> > -		if (result)
> > -			goto out;
> > -
> > -		if (flags & KEXEC_PRESERVE_CONTEXT)
> > -			image->preserve_context = 1;
> > -		result = machine_kexec_prepare(image);
> > +	/* Load new kernel */
> > +	if (nr_segments > 0) {
> > +		result = __kexec_load(&image, entry, nr_segments, segments,
> > +				      flags);
> >  		if (result)
> >  			goto out;
> > -
> > -		for (i = 0; i < nr_segments; i++) {
> > -			result = kimage_load_segment(image, &image->segment[i]);
> > -			if (result)
> > -				goto out;
> > -		}
> > -		kimage_terminate(image);
> > -		if (flags & KEXEC_ON_CRASH)
> > -			crash_unmap_reserved_pages();
> >  	}
> > +
> >  	/* Install the new kernel, and  Uninstall the old */
> >  	image = xchg(dest_image, image);
> >  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
