Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo0Fb-0006Qz-Cu
 for kexec@lists.infradead.org; Wed, 24 Jun 2020 07:55:20 +0000
Date: Wed, 24 Jun 2020 09:55:16 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/1] fs: move kernel_read_file* to its own include file
Message-ID: <20200624075516.GA20553@lst.de>
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
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "Serge E . Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Eric Paris <eparis@parisplace.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
