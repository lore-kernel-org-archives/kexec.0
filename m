Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h6X8t-00031z-Il
 for kexec@lists.infradead.org; Wed, 20 Mar 2019 09:04:13 +0000
Date: Wed, 20 Mar 2019 17:04:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 0/8] selftests/kexec: add kexec tests
Message-ID: <20190320090401.GA2591@dhcp-128-65.nay.redhat.com>
References: <1552588876-28481-1-git-send-email-zohar@linux.ibm.com>
 <20190318140643.GA17706@dhcp-128-65.nay.redhat.com>
 <1552932562.8658.274.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1552932562.8658.274.camel@linux.ibm.com>
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, Petr Vorel <pvorel@suse.cz>, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org

Hi Mimi,

Thank you for help about the pointer about IMA testing.
Probably I should cc list as well since we are talking about the patch
itself.  For the ima test itself I could still ask for help in a private
email thread.

On 03/18/19 at 02:09pm, Mimi Zohar wrote:
> On Mon, 2019-03-18 at 22:06 +0800, Dave Young wrote:
> > Hi Mimi,
> > =

> > On 03/14/19 at 02:41pm, Mimi Zohar wrote:
> > > The kernel may be configured or an IMA policy specified on the boot
> > > command line requiring the kexec kernel image signature to be verifie=
d.
> > > At runtime a custom IMA policy may be loaded, replacing the policy
> > > specified on the boot command line.  In addition, the arch specific
> > > policy rules are dynamically defined based on the secure boot mode th=
at
> > > may require the kernel image signature to be verified.
> > > =

> > > The kernel image may have a PE signature, an IMA signature, or both. =
In
> > > addition, there are two kexec syscalls - kexec_load and kexec_file_lo=
ad
> > > - but only the kexec_file_load syscall can verify signatures.
> > > =

> > > These kexec selftests verify that only properly signed kernel images =
are
> > > loaded as required, based on the kernel config, the secure boot mode,
> > > and the IMA runtime policy.
> > > =

> > > Loading a kernel image or kernel module requires root privileges.  To
> > > run just the KEXEC selftests: sudo make TARGETS=3Dkexec kselftest
> > > =

> > > Changelog v4:
> > > - Moved the kexec tests to selftests/kexec, as requested by Dave Youn=
g.
> > > - Removed the kernel module selftest from this patch set.
> > > - Rewritten cover letter, removing reference to kernel modules.
> > > =

> > > Changelog v3:
> > > - Updated tests based on Petr's review, including the defining a comm=
on
> > >   test to check for root privileges.
> > > - Modified config, removing the CONFIG_KEXEC_VERIFY_SIG requirement.
> > > - Updated the SPDX license to GPL-2.0 based on Shuah's review.
> > > - Updated the secureboot mode test to check the SetupMode as well, ba=
sed
> > >   on David Young's review.
> > > =

> > > =

> > I was trying to review the patches although I'm slow due to something
> > else.
> > =

> > But I still did not setup a IMA testable system, need check your old
> > email about how to setup it.
> =

> (The ima-evm-utils package contains a README with directions.)
> =

> > =

> > A quick testing gives me below results
> > =

> > /* test #1, my default kconfig
> > # NO CONFIG_INTEGRITY compiled in
> > */
> > =

> > make[1]: Nothing to be done for 'all'.
> > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing=
/selftests/kexec'
> > make[1]: Entering directory '/home/dyoung/git/github/linux/tools/testin=
g/selftests/kexec'
> > TAP version 13
> > selftests: kexec: test_kexec_load.sh
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > selftests: kexec: test_kexec_load.sh: Warning: file
> > test_kexec_load.sh is not executable, correct this.
> > not ok 1..1 selftests: kexec: test_kexec_load.sh [FAIL]
> =

> That's really weird. =A0Both before and after applying these patches
> test_kexec_load.sh is executable (stable linux-5.0.y). =A0Could
> something else be preventing it from executing?
> =

> > selftests: kexec: test_kexec_file_load.sh
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [INFO] kexec_file_load is enabled
> > [INFO] secure boot mode not enabled
> > [INFO] kexec kernel image PE signed
> > [INFO] kexec kernel image not IMA signed
> > kexec_file_load succeeded (possibly missing IMA sig) [FAIL]
> > not ok 1..2 selftests: kexec: test_kexec_file_load.sh [FAIL]
> > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing=
/selftests/kexec'
> > make: Leaving directory '/home/dyoung/git/github/linux/tools/testing/se=
lftests'
> =

> This message is because neither CONFIG_KEXEC_BZIMAGE_VERIFY_SIG or an
> IMA signature is required. =A0It couldn't read the IMA runtime policy
> rules to determine if an IMA signature is required. =A0So, it's trying
> to provide a hint as to what happened.
> =

> I'll update the test to see if CONFIG_IMA_APPRAISE is enabled, before
> emitting this message.
> =

> > =

> > /* test #2, enabled IMA kconfigs, simply test without other ima
> > setup eg. use a policy etc. need to follow up some guide to test the
> > ima functionality (TODO..)
> > */
> > =

> > =

> > [root@dhcp-128-65 linux-x86]# make -C tools/testing/selftests TARGETS=
=3Dkexec run_tests
> > make: Entering directory '/home/dyoung/git/github/linux/tools/testing/s=
elftests'
> > make[1]: Entering directory '/home/dyoung/git/github/linux/tools/testin=
g/selftests/kexec'
> > make[1]: Nothing to be done for 'all'.
> > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing=
/selftests/kexec'
> > make[1]: Entering directory '/home/dyoung/git/github/linux/tools/testin=
g/selftests/kexec'
> > TAP version 13
> > selftests: kexec: test_kexec_load.sh
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > selftests: kexec: test_kexec_load.sh: Warning: file test_kexec_load.sh =
is not executable, correct this.
> > not ok 1..1 selftests: kexec: test_kexec_load.sh [FAIL]
> > selftests: kexec: test_kexec_file_load.sh
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [INFO] kexec_file_load is enabled
> > [INFO] reading IMA policy permitted
> > [INFO] secure boot mode not enabled
> > No signature verification required
> > not ok 1..2 selftests: kexec: test_kexec_file_load.sh [SKIP]
> > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing=
/selftests/kexec'
> > make: Leaving directory '/home/dyoung/git/github/linux/tools/testing/se=
lftests'
> =

> The purpose of these tests was to coordinate kernel image signature
> verification.
> =

> If you require a PE signature, load an IMA policy requiring an IMA
> signature, or even enable CONFIG_IMA_ARCH_POLICY, the test would
> require some form of signature verification.

Did a test with a embedded ima key in kernel, with secure boot disabled,
but with Secure Boot enabled, but failed to sign the kernel with both
pesign and evmctl, will continue to see how to work on it and ask in
private email if needed :)

About the patch itself, as we talked in another email, I would expect it
can work with other test cases eg. without IMA/secure boot.  But if that
is not easy, maybe you can change the test script filename to something
like:  test_kexec_load_sigcheck.sh and test_kexec_file_load_sigcheck.sh =

then we can add other non-sigcheck related cases to other test scripts
later.  But ideally if we can handle them in current files it would be
better.

Another issue I noticed is even if boot with ima_appraise=3Doff, kexec
load still checking the conditions. Will see if I'm having something
wrong in test steps.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
