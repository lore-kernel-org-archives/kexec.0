Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqg1A-0005Ov-HR
 for kexec@lists.infradead.org; Wed, 01 Jul 2020 16:55:29 +0000
Date: Wed, 1 Jul 2020 18:55:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/1] fs: move kernel_read_file* to its own include file
Message-ID: <20200701165513.GA3176669@kroah.com>
References: <20200617161218.18487-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200617161218.18487-1-scott.branden@broadcom.com>
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

On Wed, Jun 17, 2020 at 09:12:18AM -0700, Scott Branden wrote:
> Move kernel_read_file* out of linux/fs.h to its own linux/kernel_read_file.h
> include file. That header gets pulled in just about everywhere
> and doesn't really need functions not related to the general fs interface.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
