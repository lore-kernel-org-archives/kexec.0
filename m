Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wsyjo-0007Wg-VJ
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 18:19:37 +0000
Date: Fri, 6 Jun 2014 14:19:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 07/13] kexec: Implementation of new syscall kexec_file_load
Message-ID: <20140606181859.GK1526@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-8-git-send-email-vgoyal@redhat.com>
 <20140606065605.GE2785@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140606065605.GE2785@dhcp-17-89.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com

On Fri, Jun 06, 2014 at 02:56:05PM +0800, WANG Chao wrote:
> On 06/03/14 at 09:06am, Vivek Goyal wrote:
> > Previous patch provided the interface definition and this patch prvides
> > implementation of new syscall.
> > 
> > Previously segment list was prepared in user space. Now user space just
> > passes kernel fd, initrd fd and command line and kernel will create a
> > segment list internally.
> > 
> > This patch contains generic part of the code. Actual segment preparation
> > and loading is done by arch and image specific loader. Which comes in
> > next patch.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> 
> [..]
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index a3044e6..1ad4d60 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> 
> > +static int kimage_file_prepare_segments(struct kimage *image, int kernel_fd,
> > +		int initrd_fd, const char __user *cmdline_ptr,
> > +		unsigned long cmdline_len)
> > +{
> > +	int ret = 0;
> > +	void *ldata;
> > +
> > +	ret = copy_file_from_fd(kernel_fd, &image->kernel_buf,
> > +					&image->kernel_buf_len);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Call arch image probe handlers */
> > +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> > +						image->kernel_buf_len);
> > +
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = copy_file_from_fd(initrd_fd, &image->initrd_buf,
> > +					&image->initrd_buf_len);
> > +	if (ret)
> > +		goto out;
> > +
> > +	image->cmdline_buf = vzalloc(cmdline_len);
> 
> You should validate the upper/lower boundary of cmdline_len before
> calling vzalloc. When cmdline_len is 0 or too large, vmalloc failure
> message would be fired.

What's the upper length of vzalloc(). I think if it is too big to alloc,
then vzalloc() should return me an error?

> 
> > +	if (!image->cmdline_buf)
> > +		goto out;
> > +
> > +	ret = copy_from_user(image->cmdline_buf, cmdline_ptr, cmdline_len);
> > +	if (ret) {
> > +		ret = -EFAULT;
> > +		goto out;
> > +	}
> > +
> > +	image->cmdline_buf_len = cmdline_len;
> > +
> > +	/* command line should be a string with last byte null */
> > +	if (image->cmdline_buf[cmdline_len - 1] != '\0') {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> 
> Given the fact that command line is optional as well as initrd, I think
> above chunk of code needs to update a bit for the case cmdline_len is 0
> or cmdline_buf is pointing NULL?

I agree. I think all this vzalloc(), copy_from_user() etc should be called
only fir cmdline_len is non-zero. Will fix it.

Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
