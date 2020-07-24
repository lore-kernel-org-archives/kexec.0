Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz2MB-0001uT-Ak
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 18:23:45 +0000
Received: by mail-pg1-x544.google.com with SMTP id l63so5737722pge.12
 for <kexec@lists.infradead.org>; Fri, 24 Jul 2020 11:23:41 -0700 (PDT)
Date: Fri, 24 Jul 2020 11:23:37 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 15/18] fs/kernel_file_read: Add "offset" arg for
 partial reads
Message-ID: <202007241122.50FD503@keescook>
References: <20200722193020.2676422-1-keescook@chromium.org>
 <20200722193020.2676422-16-keescook@chromium.org>
 <c0cf63be-7291-9e8f-b622-00205f0d637a@broadcom.com>
 <202007231131.9704A8B330@keescook>
 <02cffea0-5ed4-05a5-f86d-b6643f32e595@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <02cffea0-5ed4-05a5-f86d-b6643f32e595@broadcom.com>
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
Cc: linux-efi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, Stephen Boyd <stephen.boyd@linaro.org>, SeongJae Park <sjpark@amazon.de>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Peter Jones <pjones@redhat.com>, linux-kselftest@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Shuah Khan <shuah@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Cedeno <thomascedeno@google.com>, linux-security-module@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Aaron Goidel <acgoide@tycho.nsa.gov>, "Serge E. Hallyn" <serge@hallyn.com>, Wenwen Wang <wenwen@cs.uga.edu>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthieu Baerts <matthieu.baerts@tessares.net>, KP Singh <kpsingh@chromium.org>, Eric Paris <eparis@parisplace.org>, linux-integrity@vger.kernel.org, Florent Revest <revest@google.com>, Andrea Righi <andrea.righi@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

On Thu, Jul 23, 2020 at 10:41:07PM -0700, Scott Branden wrote:
> 
> 
> On 2020-07-23 12:15 p.m., Kees Cook wrote:
> > On Wed, Jul 22, 2020 at 03:29:26PM -0700, Scott Branden wrote:
> > > These changes don't pass the kernel-selftest for partial reads I added
> > > (which are at the end of this patch v2 series).
> > Oh, interesting. Is there any feedback in dmesg? I wonder if I have the
> > LSMs configured differently than you?
> I have no LSMs configured that I know of.
> Yes, there is failure in dmesg which is how I determined to add my
> workaround.
> Without workaround, dmesg log attached after booting and running
> fw_run_tests.h
> > > See change below added for temp workaround for issue.
> > > > [...]
> > > > +
> > > > +	whole_file = (offset == 0 && i_size <= buf_size);
> > > A hack to get this passing I added which probably breaks some security?
> > > if (whole_file) {
> > > > +	ret = security_kernel_read_file(file, id, whole_file);
> > > > +	if (ret)
> > > > +		goto out;
> > > > +
> > > }
> > This would imply I did something wrong in the LSM hook refactoring (i.e.
> > some LSM is rejecting the !whole_file case, but if the entire call to
> > the hooks are skipped, it's okay).
> > 
> > What does this return on your test system:
> > 
> > 	echo $(cat /sys/kernel/security/lsm)
> ima kernel configs are enabled but I don't enable security policies
> on the kernel command line.
> 
> echo $(cat /sys/kernel/security/lsm)
> cat: /sys/kernel/security/lsm: No such file or directory

Oh, er... CONFIG_SECURITYFS is missing?

Can you send me your .config?

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
