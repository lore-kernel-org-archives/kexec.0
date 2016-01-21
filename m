Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aM2lD-00077C-2V
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 00:05:59 +0000
Date: Thu, 21 Jan 2016 01:05:36 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC PATCH v2 09/11] ima: load policy using path
Message-ID: <20160121000536.GO11277@wotan.suse.de>
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

EXPORT_SYMBOL_GPL() needed.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
