Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hbL4J-00027V-LI
 for kexec@lists.infradead.org; Thu, 13 Jun 2019 08:26:49 +0000
Date: Thu, 13 Jun 2019 16:26:27 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH V8 3/3] Call ima_kexec_cmdline to measure the cmdline args
Message-ID: <20190613082627.GA30288@dhcp-128-65.nay.redhat.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
 <20190612221549.28399-4-prsriva02@gmail.com>
 <1560378703.4578.91.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1560378703.4578.91.camel@linux.ibm.com>
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec <kexec@lists.infradead.org>, Prakhar Srivastava <prsriva02@gmail.com>, roberto.sassu@huawei.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, vgoyal@redhat.com

On 06/12/19 at 06:31pm, Mimi Zohar wrote:
> [Cc: kexec mailing list]
> 
> Hi Eric, Dave,
> 
> On Wed, 2019-06-12 at 15:15 -0700, Prakhar Srivastava wrote:
> > During soft reboot(kexec_file_load) boot cmdline args
> > are not measured.Thus the new kernel on load boots with
> > an assumption of cold reboot.
> > 
> > This patch makes a call to the ima hook ima_kexec_cmdline,
> > added in "Define a new IMA hook to measure the boot command
> > line arguments"
> > to measure the boot cmdline args into the ima log.
> > 
> > - call ima_kexec_cmdline from kexec_file_load.
> > - move the call ima_add_kexec_buffer after the cmdline
> > args have been measured.
> > 
> > Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> 
> Any chance we could get some Acks?

The ima_* is blackbox functions to me, looks like this patch is trying
to measure kexec cmdline buffer and save in some ima logs and then add all the
measure results including those for kernel/initrd to a kexec_buf and pass to 2nd
kernel.

It should be good and only take effect when IMA enabled. If all the
assumptions are right:

Acked-by: Dave Young <dyoung@redhat.com>
> 
> thanks,
> 
> Mimi
> 
> > ---
> >  kernel/kexec_file.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 072b6ee55e3f..b0c724e5d86c 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -198,9 +198,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >  		return ret;
> >  	image->kernel_buf_len = size;
> >  
> > -	/* IMA needs to pass the measurement list to the next kernel. */
> > -	ima_add_kexec_buffer(image);
> > -
> >  	/* Call arch image probe handlers */
> >  	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> >  					    image->kernel_buf_len);
> > @@ -241,8 +238,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >  			ret = -EINVAL;
> >  			goto out;
> >  		}
> > +
> > +		ima_kexec_cmdline(image->cmdline_buf,
> > +				  image->cmdline_buf_len - 1);
> >  	}
> >  
> > +	/* IMA needs to pass the measurement list to the next kernel. */
> > +	ima_add_kexec_buffer(image);
> > +
> >  	/* Call arch image load handlers */
> >  	ldata = arch_kexec_kernel_image_load(image);
> >  
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
