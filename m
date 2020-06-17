Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlRBt-0001dV-Bz
 for kexec@lists.infradead.org; Wed, 17 Jun 2020 06:04:54 +0000
Received: by mail-pg1-x542.google.com with SMTP id t7so748806pgt.3
 for <kexec@lists.infradead.org>; Tue, 16 Jun 2020 23:04:53 -0700 (PDT)
Subject: Re: [PATCH] fs: move kernel_read_file* to its own include file
References: <20200617033152.16883-1-scott.branden@broadcom.com>
 <20200617052633.GA1351336@kroah.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <8d70da48-7c3c-5d24-ed43-2d705417e7b5@broadcom.com>
Date: Tue, 16 Jun 2020 23:04:48 -0700
MIME-Version: 1.0
In-Reply-To: <20200617052633.GA1351336@kroah.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, "Rafael J . Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Luis Chamberlain <mcgrof@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Eric Biederman <ebiederm@xmission.com>, Jessica Yu <jeyu@kernel.org>, linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>, linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>, Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>

Hi Greg,

On 2020-06-16 10:26 p.m., Greg Kroah-Hartman wrote:
> On Tue, Jun 16, 2020 at 08:31:52PM -0700, Scott Branden wrote:
>> Move kernel_read_file* to it own kernel_read_file.h include file.
> That says what you did, but not _why_ you are doing it :(
>
I have no real opinion as to where these functions end up.
I simply wish to add kernel_pread_file* support and current comment is 
the existing kernel_read_file* functions
are in linux/fs.h and I shouldn't add more to that file.

I'd be quite happy to leave them in linux/fs.h if that is desired as well.

I can update the commit according to Christoph's comment:

"Can you also move kernel_read_* out of fs.h?  That header gets pulled
in just about everywhere and doesn't really need function not related
to the general fs interface."







_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
