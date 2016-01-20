Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aLjJN-0008Ft-Aw
 for kexec@lists.infradead.org; Wed, 20 Jan 2016 03:19:58 +0000
Date: Wed, 20 Jan 2016 11:22:34 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
Message-ID: <20160120032234.GA20122@dhcp-128-25.nay.redhat.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On 01/18/16 at 10:11am, Mimi Zohar wrote:
> diff --git a/fs/exec.c b/fs/exec.c
> index 211b81c..a5ae51e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -884,6 +884,21 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file);
>  
> +int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> +			     int policy_id)
> +{
> +	struct fd f = fdget(fd);
> +	int ret = -ENOEXEC;
> +
> +	if (!f.file)
> +		goto out;

It is no need to call the fdput, if f.file is NULL. It is better to
return it directly.

> +
> +	ret = kernel_read_file(f.file, buf, size, max_size, policy_id);
> +out:
> +	fdput(f);
> +	return ret;
> +}
> +

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
