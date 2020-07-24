Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz3Kz-0002iL-6A
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 19:26:35 +0000
Received: by mail-pf1-x444.google.com with SMTP id u185so5776266pfu.1
 for <kexec@lists.infradead.org>; Fri, 24 Jul 2020 12:26:32 -0700 (PDT)
Date: Fri, 24 Jul 2020 12:26:28 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 15/18] fs/kernel_file_read: Add "offset" arg for
 partial reads
Message-ID: <202007241207.0B09E32@keescook>
References: <20200722193020.2676422-1-keescook@chromium.org>
 <20200722193020.2676422-16-keescook@chromium.org>
 <c0cf63be-7291-9e8f-b622-00205f0d637a@broadcom.com>
 <202007231131.9704A8B330@keescook>
 <02cffea0-5ed4-05a5-f86d-b6643f32e595@broadcom.com>
 <202007241122.50FD503@keescook> <202007241138.8A3E468@keescook>
 <02221f39-ad01-c45d-cc60-a3ffe3d0d284@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <02221f39-ad01-c45d-cc60-a3ffe3d0d284@broadcom.com>
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
To: Scott Branden <scott.branden@broadcom.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-efi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, Stephen Boyd <stephen.boyd@linaro.org>, SeongJae Park <sjpark@amazon.de>, Aaron Goidel <acgoide@tycho.nsa.gov>, David Howells <dhowells@redhat.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Peter Jones <pjones@redhat.com>, linux-kselftest@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Shuah Khan <shuah@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Cedeno <thomascedeno@google.com>, linux-security-module@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, "Serge E. Hallyn" <serge@hallyn.com>, Wenwen Wang <wenwen@cs.uga.edu>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthieu Baerts <matthieu.baerts@tessares.net>, KP Singh <kpsingh@chromium.org>, Eric Paris <eparis@parisplace.org>, linux-integrity@vger.kernel.org, Florent Revest <revest@google.com>, Andrea Righi <andrea.righi@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

On Fri, Jul 24, 2020 at 12:03:36PM -0700, Scott Branden wrote:
> Now I'm confused.=A0 The original patch series I made with IMA additions =
under
> Mimi's direction
> passed the kernel selftests with partial read.=A0 And
> request_partial_firmware_into_buf therefore worked.
> Your changes don't work with CONFIG_IMA_APPRAISE=3Dy on?=A0 Is there a wa=
y to
> make IMA ignore this file to make things work then?
> Seems like another change is needed for IMA to ignore partial reads if it
> can't appraise them?

Ah yes, I missed this in porting your series[1] (i.e. calling
process_measurement() with a valid "file" and NULL "buf" is handled
correctly -- I misunderstood these changes). I will send a corrected
patch.

-Kees

[1] https://lore.kernel.org/lkml/20200706232309.12010-10-scott.branden@broa=
dcom.com/

-- =

Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
