Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0aGP-0005Ab-KC
 for kexec@lists.infradead.org; Wed, 29 Jul 2020 00:48:10 +0000
Received: by mail-pg1-f194.google.com with SMTP id m22so13302640pgv.9
 for <kexec@lists.infradead.org>; Tue, 28 Jul 2020 17:48:09 -0700 (PDT)
Date: Wed, 29 Jul 2020 00:48:06 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 01/18] test_firmware: Test platform fw loading on
 non-EFI systems
Message-ID: <20200729004806.GK4332@42.do-not-panic.com>
References: <20200722193020.2676422-1-keescook@chromium.org>
 <20200722193020.2676422-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200722193020.2676422-2-keescook@chromium.org>
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
To: Kees Cook <keescook@chromium.org>
Cc: linux-efi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, Stephen Boyd <stephen.boyd@linaro.org>, SeongJae Park <sjpark@amazon.de>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Peter Jones <pjones@redhat.com>, linux-kselftest@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Shuah Khan <shuah@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Cedeno <thomascedeno@google.com>, Anders Roxell <anders.roxell@linaro.org>, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Aaron Goidel <acgoide@tycho.nsa.gov>, "Serge E. Hallyn" <serge@hallyn.com>, Wenwen Wang <wenwen@cs.uga.edu>, Scott Branden <scott.branden@broadcom.com>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthieu Baerts <matthieu.baerts@tessares.net>, KP Singh <kpsingh@chromium.org>, Eric Paris <eparis@parisplace.org>, linux-integrity@vger.kernel.org, Florent Revest <revest@google.com>, Andrea Righi <andrea.righi@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

On Wed, Jul 22, 2020 at 12:30:03PM -0700, Kees Cook wrote:
> On non-EFI systems, it wasn't possible to test the platform firmware
> loader because it will have never set "checked_fw" during __init.
> Instead, allow the test code to override this check. Additionally split
> the declarations into a private header file so it there is greater
> enforcement of the symbol visibility.
> 
> Fixes: 548193cba2a7 ("test_firmware: add support for firmware_request_platform")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

A *clearly* private symbol namespace would seem cleaner, example the existing:

EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
