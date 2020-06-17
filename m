Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlQat-000593-MJ
 for kexec@lists.infradead.org; Wed, 17 Jun 2020 05:26:40 +0000
Date: Wed, 17 Jun 2020 07:26:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] fs: move kernel_read_file* to its own include file
Message-ID: <20200617052633.GA1351336@kroah.com>
References: <20200617033152.16883-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200617033152.16883-1-scott.branden@broadcom.com>
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

On Tue, Jun 16, 2020 at 08:31:52PM -0700, Scott Branden wrote:
> Move kernel_read_file* to it own kernel_read_file.h include file.

That says what you did, but not _why_ you are doing it :(


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
