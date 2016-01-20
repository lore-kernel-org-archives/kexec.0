Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aLhHb-0006I3-Bs
 for kexec@lists.infradead.org; Wed, 20 Jan 2016 01:10:00 +0000
Date: Wed, 20 Jan 2016 02:09:36 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC PATCH v2 02/11] vfs: define a generic function to read a
 file from the kernel
Message-ID: <20160120010936.GD11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-3-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1453129886-20192-3-git-send-email-zohar@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Mon, Jan 18, 2016 at 10:11:17AM -0500, Mimi Zohar wrote:
> diff --git a/fs/exec.c b/fs/exec.c
> index b06623a..6d623c2 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -831,6 +832,58 @@ int kernel_read(struct file *file, loff_t offset,
>  
>  EXPORT_SYMBOL(kernel_read);
>  
> +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> +		     loff_t max_size)
> +{
> +	loff_t i_size, pos;
> +	ssize_t bytes = 0;
> +	int ret;
> +
> +	if (!S_ISREG(file_inode(file)->i_mode))
> +		return -EINVAL;
> +
> +	i_size = i_size_read(file_inode(file));
> +	if (max_size > 0 && i_size > max_size)
> +		return -EFBIG;

loff_t is a __kernel_loff_t, which in turn is a long long, and that's
signed. We don't catch a negative value here, for max_size, we could
return -EINVAL if its < 0.

> +	if (i_size == 0)
> +		return -EINVAL;

Likewise for i_size. The setter of the size will depend on how the
code calling this routine setup the struct file passed.

So how about adding a i_size <= 0 check here as well here?
At least fw_read_file_contents() has historically done this,
so if this generic read is going to skip that I'd like to
see why. We're unifying so I rather be more pedantic.

Provided this is addressed feel free to peg:

Reviewed-by: Luis R. Rodriguez <mcgrof@suse.com>

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
