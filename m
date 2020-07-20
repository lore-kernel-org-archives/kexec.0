Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxRFv-0005m8-NX
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 08:34:41 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 07/13] fs/kernel_read_file: Switch buffer size arg to
 size_t
Date: Mon, 20 Jul 2020 08:34:32 +0000
Message-ID: <5db582d3ec08401eb4731ce3acd51561@AcuMS.aculab.com>
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-8-keescook@chromium.org>
In-Reply-To: <20200717174309.1164575-8-keescook@chromium.org>
Content-Language: en-US
MIME-Version: 1.0
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
To: 'Kees Cook' <keescook@chromium.org>, Scott Branden <scott.branden@broadcom.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E.
 Hallyn" <serge@hallyn.com>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, "Eric
 W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

From: Kees Cook
> Sent: 17 July 2020 18:43
> In preparation for further refactoring of kernel_read_file*(), rename
> the "max_size" argument to the more accurate "buf_size", and correct
> its type to size_t. Add kerndoc to explain the specifics of how the
> arguments will be used. Note that with buf_size now size_t, it can no
> longer be negative (and was never called with a negative value). Adjust
> callers to use it as a "maximum size" when *buf is NULL.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/kernel_read_file.c            | 34 +++++++++++++++++++++++---------
>  include/linux/kernel_read_file.h |  8 ++++----
>  security/integrity/digsig.c      |  2 +-
>  security/integrity/ima/ima_fs.c  |  2 +-
>  4 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index dc28a8def597..e21a76001fff 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -5,15 +5,31 @@
>  #include <linux/security.h>
>  #include <linux/vmalloc.h>
> 
> +/**
> + * kernel_read_file() - read file contents into a kernel buffer
> + *
> + * @file	file to read from
> + * @buf		pointer to a "void *" buffer for reading into (if
> + *		*@buf is NULL, a buffer will be allocated, and
> + *		@buf_size will be ignored)
> + * @buf_size	size of buf, if already allocated. If @buf not
> + *		allocated, this is the largest size to allocate.
> + * @id		the kernel_read_file_id identifying the type of
> + *		file contents being read (for LSMs to examine)
> + *
> + * Returns number of bytes read (no single read will be bigger
> + * than INT_MAX), or negative on error.
> + *
> + */

That seems to be self-inconsistent.
If '*buf' is NULL is both says that buf_size is ignored and
is treated as a limit.
To make life easier, zero should probably be treated as no-limit.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
