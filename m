Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMoQa-0004Hx-Jp
 for kexec@lists.infradead.org; Sat, 23 Jan 2016 02:59:53 +0000
Date: Sat, 23 Jan 2016 03:59:28 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC PATCH v2 09/11] ima: load policy using path
Message-ID: <20160123025928.GD20964@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-10-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1453129886-20192-10-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Kasatkin <d.kasatkin@samsung.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Mon, Jan 18, 2016 at 10:11:24AM -0500, Mimi Zohar wrote:
> From: Dmitry Kasatkin <d.kasatkin@samsung.com>
> 
> echo /etc/ima/ima_policy > /sys/kernel/security/ima/policy

>  fs/exec.c                       | 21 ++++++++++++++++++++

> diff --git a/fs/exec.c b/fs/exec.c
> index 3524e5f..5731b40 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -903,6 +903,27 @@ out:
>  	return ret;
>  }
>  
> +int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
> +			       loff_t max_size, int policy_id)
> +{
> +	struct file *file;
> +	int ret;
> +
> +	if (!path || !*path)
> +		return -EINVAL;
> +
> +	file = filp_open(path, O_RDONLY, 0);
> +	if (IS_ERR(file)) {
> +		ret = PTR_ERR(file);
> +		pr_err("Unable to open file: %s (%d)", path, ret);
> +		return ret;
> +	}
> +
> +	ret = kernel_read_file(file, buf, size, max_size, policy_id);
> +	fput(file);
> +	return ret;
> +}
> +

I like this strategy, and can see it being further generalized in
areas of the kernel where we may want self policy / file loading
appraisal. Those policies are now defined through LSMs, in IMA
here you do your own vetting but -- it seems we might better
want instead to enable easily *any* LSM to do its vetting. In this
case I suppose that's still possible given kernel_read_file() is
used and that in turn would have a pre LSM hook and post-LSM hook.

Is that right? If so then it should just be a matter of all other
areas of the kernel to use kernel_read_file_from_path() or
kernel_read_file() to take advantage of similar strategies. Or
is there more work? The other obvious alternative for the heavy
handed users would be to just use the future sysdata helpers, that
in turn would use kernel_read_file_from_path() and still if a
distribution wants can also in the future get kernel signature
verification.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
