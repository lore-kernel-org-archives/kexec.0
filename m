Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkxri-006ffA-9F
 for kexec@lists.infradead.org; Thu, 11 Nov 2021 00:22:55 +0000
Date: Thu, 11 Nov 2021 08:22:33 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] s390/kexec: fix memory leak of ipl report buffer
Message-ID: <20211111002233.GA10944@MiWiFi-R3L-srv>
References: <20211029092635.14804-1-bhe@redhat.com>
 <20211029183132.20839ad0@rhtmp> <YYviwi3PVD11xcCs@osiris>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYviwi3PVD11xcCs@osiris>
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
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Philipp Rudo <prudo@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org, dyoung@redhat.com, akpm@linux-foundation.org

On 11/10/21 at 04:18pm, Heiko Carstens wrote:
> On Fri, Oct 29, 2021 at 06:31:32PM +0200, Philipp Rudo wrote:
> > Hi Baoquan,
> > 
> > On Fri, 29 Oct 2021 17:26:35 +0800
> > Baoquan He <bhe@redhat.com> wrote:
> > 
> > > A memory leak is reported by kmemleak scanning:
> ...
> > > The ipl report buffer is allocated via vmalloc, while has no chance to free
> > > if the kexe loading is unloaded. This will cause obvious memory leak
> > > when kexec/kdump kernel is reloaded, manually, or triggered, e.g by
> > > memory hotplug.
> > > 
> > > Here, add struct kimage_arch to s390 to pass out the ipl report buffer
> > > address, and introduce arch dependent function
> > > arch_kimage_file_post_load_cleanup() to free it when unloaded.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > 
> > other than a missing
> > 
> > Fixes: 99feaa717e55 ("s390/kexec_file: Create ipl report and pass to
> > next kernel")
> > 
> > the patch looks good to me.
> > 
> > Reviewed-by: Philipp Rudo <prudo@redhat.com>
> ...
> > >  	buf.buffer = ipl_report_finish(data->report);
> > >  	buf.bufsz = data->report->size;
> > >  	buf.memsz = buf.bufsz;
> > > +	image->arch.ipl_buf = buf.buffer;
> 
> This seems (still) to be incorrect: ipl_report_finish() may return
> -ENOMEN, but there is no error checking anywhere, as far as I can
> tell, which would make this:
> 
> > > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > > +{
> > > +	kvfree(image->arch.ipl_buf);
> > > +	image->arch.ipl_buf = NULL;
> > > +
> > > +	return kexec_image_post_load_cleanup_default(image);
> > > +}
> 
> most likely not do what we want. That is: if this code is reached at
> all in such a case. I'll check and might add a patch before this to
> fix this also.

Right, we should check the returned value firstly. Thanks a lot for
reivewing, Heiko. I will post v2 to add a patch to check the returned
value as you suggested, and also update this patch to add missing Fixes tag. 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
