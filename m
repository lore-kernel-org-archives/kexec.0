Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X0Gkq-00022T-Ak
 for kexec@lists.infradead.org; Thu, 26 Jun 2014 20:58:48 +0000
Date: Thu, 26 Jun 2014 13:58:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 09/15] kexec: Implementation of new syscall kexec_file_load
Message-Id: <20140626135826.d1679d6eb5b7bd0f82dd7deb@linux-foundation.org>
In-Reply-To: <1403814824-7587-10-git-send-email-vgoyal@redhat.com>
References: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
 <1403814824-7587-10-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, chaowang@redhat.com

On Thu, 26 Jun 2014 16:33:38 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:

> Previous patch provided the interface definition and this patch prvides
> implementation of new syscall.
> 
> Previously segment list was prepared in user space. Now user space just
> passes kernel fd, initrd fd and command line and kernel will create a
> segment list internally.
> 
> This patch contains generic part of the code. Actual segment preparation
> and loading is done by arch and image specific loader. Which comes in
> next patch.
> 
> ...
>
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -6,6 +6,8 @@
>   * Version 2.  See the file COPYING for more details.
>   */
>  
> +#define pr_fmt(fmt)	"kexec: " fmt
> +
>  #include <linux/capability.h>
>  #include <linux/mm.h>
>  #include <linux/file.h>
> @@ -326,6 +328,215 @@ out_free_image:
>  	return ret;
>  }
>  
> +static int copy_file_from_fd(int fd, void **buf, unsigned long *buf_len)
> +{
> +	struct fd f = fdget(fd);
> +	int ret = 0;

unneeded initialisation.

> +	struct kstat stat;
> +	loff_t pos;
> +	ssize_t bytes = 0;
> +
> +	if (!f.file)
> +		return -EBADF;
> +
> +	ret = vfs_getattr(&f.file->f_path, &stat);
> +	if (ret)
> +		goto out;
> +
> +	if (stat.size > INT_MAX) {
> +		ret = -EFBIG;
> +		goto out;
> +	}
> +
> +	/* Don't hand 0 to vmalloc, it whines. */
> +	if (stat.size == 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	*buf = vmalloc(stat.size);
> +	if (!*buf) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	pos = 0;
> +	while (pos < stat.size) {
> +		bytes = kernel_read(f.file, pos, (char *)(*buf) + pos,
> +				    stat.size - pos);
> +		if (bytes < 0) {
> +			vfree(*buf);
> +			ret = bytes;
> +			goto out;
> +		}
> +
> +		if (bytes == 0)
> +			break;

Here we can get a short read: (pos < stat.size).  Seems to me that it
is risky to return this result to the caller as if all is well.

> +		pos += bytes;
> +	}
> +
> +	*buf_len = pos;
> +out:
> +	fdput(f);
> +	return ret;
> +}
> 
> ...
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
