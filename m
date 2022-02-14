From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 14 Feb 2022 10:14:16 -0500
Subject: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
In-Reply-To: <cff97dbe262919ff709a5ad2c4af6a702cc72a95.camel@linux.ibm.com>
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
 <cff97dbe262919ff709a5ad2c4af6a702cc72a95.camel@linux.ibm.com>
Message-ID: <a8d717a44e5e919676e9b1e197cac781db46da87.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Michal,

On Sun, 2022-02-13 at 21:59 -0500, Mimi Zohar wrote:

> 
> On Tue, 2022-01-11 at 12:37 +0100, Michal Suchanek wrote:
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index dea74d7717c0..1cde9b6c5987 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -560,6 +560,22 @@ config KEXEC_FILE
> >  config ARCH_HAS_KEXEC_PURGATORY
> >         def_bool KEXEC_FILE
> >  
> > +config KEXEC_SIG
> > +       bool "Verify kernel signature during kexec_file_load() syscall"
> > +       depends on KEXEC_FILE && MODULE_SIG_FORMAT
> > +       help
> > +         This option makes kernel signature verification mandatory for
> > +         the kexec_file_load() syscall.
> 
> When KEXEC_SIG is enabled on other architectures, IMA does not define a
> kexec 'appraise' policy rule.  Refer to the policy rules in
> security/ima/ima_efi.c.  Similarly the kexec 'appraise' policy rule in
> arch/powerpc/kernel/ima_policy.c should not be defined.

The discussion shouldn't only be about IMA vs. KEXEC_SIG kernel image
signature verification.  Let's try and reframe the problem a bit.

1. Unify and simply the existing kexec signature verification so
verifying the KEXEC kernel image signature works irrespective of
signature type - PE, appended signature.

solution: enable KEXEC_SIG  (This patch set, with the above powerpc IMA
policy changes.)

2. Measure and include the kexec kernel image in a log for attestation,
if desired.

solution: enable IMA_ARCH_POLICY 
- Powerpc: requires trusted boot to be enabled.
- EFI:   requires  secure boot to be enabled.  The IMA efi policy
doesn't differentiate between secure and trusted boot.

3. Carry the kexec kernel image measurement across kexec, if desired
and supported on the architecture.

solution: enable IMA_KEXEC

Comparison: 
- Are there any differences between IMA vs. KEXEC_SIG measuring the
kexec kernel image?

One of the main differences is "what" is included in the measurement
list differs.  In both cases, the 'd-ng' field of the IMA measurement
list template (e.g. ima-ng, ima-sig, ima-modsig) is the full file hash
including the appended signature.  With IMA and the 'ima-modsig'
template, an additional hash without the appended signature is defined,
as well as including the appended signature in the 'sig' field.

Including the file hash and appended signature in the measurement list
allows an attestation server, for example, to verify the appended
signature without having to know the file hash without the signature.

Other differences are already included in the Kconfig KEXEC_SIG "Notes"
section.

-- 
thanks,

Mimi


