Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjZkb-0004k2-Cz
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 19:17:17 +0000
Date: Thu, 21 Nov 2013 14:16:53 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131121191653.GM16208@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131121190350.GC17070@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121190350.GC17070@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: mjg59@srcf.ucam.org, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On Thu, Nov 21, 2013 at 11:03:50AM -0800, Greg KH wrote:
> On Wed, Nov 20, 2013 at 12:50:49PM -0500, Vivek Goyal wrote:
> > This patch implements the in kernel kexec functionality. It implements a
> > new system call kexec_file_load. I think parameter list of this system
> > call will change as I have not done the kernel image signature handling
> > yet. I have been told that I might have to pass the detached signature
> > and size as part of system call.
> 
> This could be done as we do with modules, and just tack the signature
> onto the end of the 'blob' of the image.  That way we could use the same
> tool to sign the binary as we do for modules, and save the need for
> extra parameters in the syscall.

I was hoping to do that. Just that we will have to somehow resolve the
conflict with PE/COFF authenticode signature of kernel.

> 
> > +/*
> > + * Free up tempory buffers allocated which are not needed after image has
> > + * been loaded.
> > + *
> > + * Free up memory used by kernel, initrd, and comand line. This is temporary
> > + * memory allocation which is not needed any more after these buffers have
> > + * been loaded into separate segments and have been copied elsewhere
> > + */
> > +static void kimage_file_post_load_cleanup(struct kimage *image)
> > +{
> > +	if (image->kernel_buf) {
> > +		vfree(image->kernel_buf);
> > +		image->kernel_buf = NULL;
> > +	}
> > +
> > +	if (image->initrd_buf) {
> > +		vfree(image->initrd_buf);
> > +		image->initrd_buf = NULL;
> > +	}
> > +
> > +	if (image->cmdline_buf) {
> > +		vfree(image->cmdline_buf);
> > +		image->cmdline_buf = NULL;
> > +	}
> 
> No need to check the buffer before calling vfree(), it can handle NULL
> just fine.

Ok, I will remove this extra non-null check.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
