Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwYUi-00031c-Sy
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 22:06:17 +0000
Received: by mail-pj1-x1042.google.com with SMTP id o22so6998371pjw.2
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 15:06:16 -0700 (PDT)
Date: Fri, 17 Jul 2020 15:06:12 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
Message-ID: <202007171502.22E12A4E9@keescook>
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
 <39b2d8af-812f-8c5e-3957-34543add0173@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39b2d8af-812f-8c5e-3957-34543add0173@broadcom.com>
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-integrity@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, Jul 17, 2020 at 12:04:18PM -0700, Scott Branden wrote:
> On 2020-07-17 10:43 a.m., Kees Cook wrote:
> > In preparation for refactoring kernel_read_file*(), remove the redundant
> > "size" argument which is not needed: it can be included in the return
>
> I don't think the size argument is redundant though.
> The existing kernel_read_file functions always read the whole file.
> Now, what happens if the file is bigger than the buffer.
> How does kernel_read_file know it read the whole file by looking at the
> return value?

Yes; an entirely reasonable concern. This is why I add the file_size
output argument later in the series.

> > code, with callers adjusted. (VFS reads already cannot be larger than
> > INT_MAX.)
> > [...]
> > -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> > +	if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
>
> Should this be SSIZE_MAX?

No, for two reasons: then we need to change the return value and likely
the callers need more careful checks, and more importantly, because the
VFS already limits single read actions to INT_MAX, so limits above this
make no sense. Win win! :)

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
