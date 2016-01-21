Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aM2ig-0005oz-J5
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 00:03:23 +0000
Date: Thu, 21 Jan 2016 01:03:00 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
Message-ID: <20160121000300.GN11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-9-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1453129886-20192-9-git-send-email-zohar@linux.vnet.ibm.com>
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

On Mon, Jan 18, 2016 at 10:11:23AM -0500, Mimi Zohar wrote:
> This patch replaces the module copy_module_from_fd() call with the VFS
> common kernel_read_file_from_fd() function.  Instead of reading the
> kernel module twice, once for measuring/appraising and then loading
> the kernel module, the file is read once.
> 
> This patch defines a new security hook named security_kernel_read_file(),
> which is called before reading the file.  For now, call the module
> security hook from security_kernel_read_file until the LSMs have been
> converted to use the kernel_read_file hook.
> 
> This patch retains the kernel_module_from_file hook, but removes the
> security_kernel_module_from_file() function.

I think it would help if your cover letter and this patch described
a bit that some LSMs either prefer to read / check / appraise files
prior to loading and some other prefer to do that later. You could
explain the LSM hook preferences and what they do. Then here you
can explain how this one prefers a hook early, but acknowledge that
the other one still exists.

So:

kernel_read_file() {
	...
	security_kernel_read_file();
	...
	security_kernel_post_read_file();
	...
}

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4e6e2af..9915310 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1465,6 +1471,7 @@ union security_list_options {
>  	int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
>  	int (*kernel_module_request)(char *kmod_name);
>  	int (*kernel_module_from_file)(struct file *file);
> +	int (*kernel_read_file)(struct file *file, int policy_id);
>  	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
>  				     int policy_id);
>  	int (*task_fix_setuid)(struct cred *new, const struct cred *old,

Is the goal to eventually kill the other LSM hooks and just keep the
file one? If so where is that done in this series? It was not clear.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
