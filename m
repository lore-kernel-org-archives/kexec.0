Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jy09Q-00071w-3F
 for kexec@lists.infradead.org; Tue, 21 Jul 2020 21:50:18 +0000
Received: by mail-pl1-x641.google.com with SMTP id k4so10827889pld.12
 for <kexec@lists.infradead.org>; Tue, 21 Jul 2020 14:50:15 -0700 (PDT)
Date: Tue, 21 Jul 2020 14:50:12 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
Message-ID: <202007211449.E211351@keescook>
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
 <ec326654-c43b-259c-409c-63929ad5b217@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ec326654-c43b-259c-409c-63929ad5b217@broadcom.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-integrity@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, Jul 21, 2020 at 02:43:07PM -0700, Scott Branden wrote:
> On 2020-07-17 10:43 a.m., Kees Cook wrote:
> > In preparation for refactoring kernel_read_file*(), remove the redundant
> > "size" argument which is not needed: it can be included in the return
> > code, with callers adjusted. (VFS reads already cannot be larger than
> > INT_MAX.)
> > =

> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   drivers/base/firmware_loader/main.c |  8 ++++----
> >   fs/kernel_read_file.c               | 20 +++++++++-----------
> >   include/linux/kernel_read_file.h    |  8 ++++----
> >   kernel/kexec_file.c                 | 13 ++++++-------
> >   kernel/module.c                     |  7 +++----
> >   security/integrity/digsig.c         |  5 +++--
> >   security/integrity/ima/ima_fs.c     |  5 +++--
> >   7 files changed, 32 insertions(+), 34 deletions(-)
> > =

> > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmwar=
e_loader/main.c
> > index d4a413ea48ce..ea419c7d3d34 100644
> > --- a/drivers/base/firmware_loader/main.c
> > +++ b/drivers/base/firmware_loader/main.c
> > @@ -462,7 +462,7 @@ fw_get_filesystem_firmware(struct device *device, s=
truct fw_priv *fw_priv,
> >   					     size_t in_size,
> >   					     const void *in_buffer))
> >   {
> > -	loff_t size;
> > +	size_t size;
> >   	int i, len;
> >   	int rc =3D -ENOENT;
> >   	char *path;
> > @@ -494,10 +494,9 @@ fw_get_filesystem_firmware(struct device *device, =
struct fw_priv *fw_priv,
> >   		fw_priv->size =3D 0;
> >   		/* load firmware files from the mount namespace of init */
> > -		rc =3D kernel_read_file_from_path_initns(path, &buffer,
> > -						       &size, msize,
> > +		rc =3D kernel_read_file_from_path_initns(path, &buffer, msize,
> >   						       READING_FIRMWARE);
> > -		if (rc) {
> > +		if (rc < 0) {
> >   			if (rc !=3D -ENOENT)
> >   				dev_warn(device, "loading %s failed with error %d\n",
> >   					 path, rc);
> > @@ -506,6 +505,7 @@ fw_get_filesystem_firmware(struct device *device, s=
truct fw_priv *fw_priv,
> >   					 path);
> >   			continue;
> >   		}
> > +		size =3D rc;
> Change fails to return 0.=A0 Need rc =3D 0; here.

Oh nice; good catch! I'll fix this.

-- =

Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
