Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jla7L-0003yw-AB
 for kexec@lists.infradead.org; Wed, 17 Jun 2020 15:36:48 +0000
Date: Wed, 17 Jun 2020 17:36:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/1] fs: move kernel_read_file* to its own include file
Message-ID: <20200617153639.GA2702068@kroah.com>
References: <20200617151710.16613-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200617151710.16613-1-scott.branden@broadcom.com>
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
To: Scott Branden <scott.branden@broadcom.com>
Cc: linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, "Rafael J . Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Luis Chamberlain <mcgrof@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Eric Biederman <ebiederm@xmission.com>, Jessica Yu <jeyu@kernel.org>, linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>, linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>, Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>

On Wed, Jun 17, 2020 at 08:17:10AM -0700, Scott Branden wrote:
> Move kernel_read_file* out of linux/fs.h to its own linux/kernel_read_file.h
> include file. That header gets pulled in just about everywhere
> and doesn't really need functions not related to the general fs interface.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/base/firmware_loader/main.c |  1 +
>  fs/exec.c                           |  1 +
>  include/linux/fs.h                  | 39 ----------------------
>  include/linux/ima.h                 |  1 +
>  include/linux/kernel_read_file.h    | 52 +++++++++++++++++++++++++++++
>  include/linux/security.h            |  1 +
>  kernel/kexec_file.c                 |  1 +
>  kernel/module.c                     |  1 +
>  security/integrity/digsig.c         |  1 +
>  security/integrity/ima/ima_fs.c     |  1 +
>  security/integrity/ima/ima_main.c   |  1 +
>  security/integrity/ima/ima_policy.c |  1 +
>  security/loadpin/loadpin.c          |  1 +
>  security/security.c                 |  1 +
>  security/selinux/hooks.c            |  1 +
>  15 files changed, 65 insertions(+), 39 deletions(-)
>  create mode 100644 include/linux/kernel_read_file.h

What changed from v1?  Always put that below the --- line.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
