Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwYYq-0003fJ-M5
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 22:10:34 +0000
Received: by mail-pl1-x642.google.com with SMTP id x9so6006438plr.2
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 15:10:32 -0700 (PDT)
Date: Fri, 17 Jul 2020 15:10:28 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 00/13] Introduce partial kernel_read_file() support
Message-ID: <202007171506.CCE3902A9@keescook>
References: <20200717174309.1164575-1-keescook@chromium.org>
 <8de85fc3-9f31-fc59-abc1-29f43fb90988@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8de85fc3-9f31-fc59-abc1-29f43fb90988@broadcom.com>
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

On Fri, Jul 17, 2020 at 12:17:02PM -0700, Scott Branden wrote:
> Thanks for sending out.=A0 This looks different than your other patch ser=
ies.

Yes, it mutated in my head as I considered how all of this should hang
together, which is why I wanted to get it sent before the weekend. I'm
still trying to figure out why the fireware testsuite fails for me, etc.

> We should get the first 5 patches accepted now though as they are
> simple cleanups and fixes.=A0 That will reduce the number of outstanding
> patches in the series.

Agreed. I'd like to get some more eyes on it, but I can get it ready for
-next.

> At first glance the issue with the changes after that is the existing
> API assumes it has read the whole file and failed if it did not.
> Now, if the file is larger than the amount requested there is no indicati=
on?

The intention is to have old API users unchanged and new users can use
a pre-allocated buf (with buf_size) along with file_size to examine
their partial read progress. If I broke the old API, that's a bug and I
need to fix it, but that's why I wanted to start with the firmware test
suite (basic things like module loading work fine after this series, but
I wanted to really exercise the corners that the firmware suite pokes
at).

-- =

Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
