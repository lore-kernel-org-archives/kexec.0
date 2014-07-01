Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X24d7-0004o1-QD
 for kexec@lists.infradead.org; Tue, 01 Jul 2014 20:26:18 +0000
Date: Tue, 1 Jul 2014 16:25:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 09/15] kexec: Implementation of new syscall kexec_file_load
Message-ID: <20140701202540.GC19352@redhat.com>
References: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
 <1403814824-7587-10-git-send-email-vgoyal@redhat.com>
 <20140626135826.d1679d6eb5b7bd0f82dd7deb@linux-foundation.org>
 <20140627163141.GE13337@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140627163141.GE13337@redhat.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, chaowang@redhat.com

On Fri, Jun 27, 2014 at 12:31:41PM -0400, Vivek Goyal wrote:
> On Thu, Jun 26, 2014 at 01:58:26PM -0700, Andrew Morton wrote:
> 
> [..]
> > > +	while (pos < stat.size) {
> > > +		bytes = kernel_read(f.file, pos, (char *)(*buf) + pos,
> > > +				    stat.size - pos);
> > > +		if (bytes < 0) {
> > > +			vfree(*buf);
> > > +			ret = bytes;
> > > +			goto out;
> > > +		}
> > > +
> > > +		if (bytes == 0)
> > > +			break;
> > 
> > Here we can get a short read: (pos < stat.size).  Seems to me that it
> > is risky to return this result to the caller as if all is well.
> 
> Hi Andrew,
> 
> That's a good point. Please find attached the patch which fixes both
> the issues.
> 
> Thanks
> Vivek
> 
> 
> 

Hi Andrew,

Based on your feedback, I wrote following patch. Does it look good to
you. If yes, can you please include this one too. Do let me know if you
want me to post it separately.

Thanks
Vivek

> Subject: kexec: Return error if file bytes are less then file size 
> 
> If number of bytes read from file are not same as file size, return error.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  kernel/kexec.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/kernel/kexec.c
> ===================================================================
> --- linux-2.6.orig/kernel/kexec.c	2014-06-27 09:55:41.826755422 -0400
> +++ linux-2.6/kernel/kexec.c	2014-06-27 10:04:23.409024171 -0400
> @@ -343,7 +343,7 @@ out_free_image:
>  static int copy_file_from_fd(int fd, void **buf, unsigned long *buf_len)
>  {
>  	struct fd f = fdget(fd);
> -	int ret = 0;
> +	int ret;
>  	struct kstat stat;
>  	loff_t pos;
>  	ssize_t bytes = 0;
> @@ -387,6 +387,12 @@ static int copy_file_from_fd(int fd, voi
>  		pos += bytes;
>  	}
>  
> +	if (pos != stat.size) {
> +		ret = -EBADF;
> +		vfree(*buf);
> +		goto out;
> +	}
> +
>  	*buf_len = pos;
>  out:
>  	fdput(f);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
