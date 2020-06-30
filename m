Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqPxV-000398-DH
 for kexec@lists.infradead.org; Tue, 30 Jun 2020 23:46:38 +0000
Received: by mail-ed1-x541.google.com with SMTP id a8so16723692edy.1
 for <kexec@lists.infradead.org>; Tue, 30 Jun 2020 16:46:35 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] fs: move kernel_read_file* to its own include file
References: <20200617161218.18487-1-scott.branden@broadcom.com>
 <20200624075516.GA20553@lst.de>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <a1447797-c6b7-d04a-0661-897845942864@broadcom.com>
Date: Tue, 30 Jun 2020 16:46:27 -0700
MIME-Version: 1.0
In-Reply-To: <20200624075516.GA20553@lst.de>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Luis Chamberlain <mcgrof@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jessica Yu <jeyu@kernel.org>, linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>, linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Hi Al (Viro),

Are you able to take this patch into your tree or does someone else?

On 2020-06-24 12:55 a.m., Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
