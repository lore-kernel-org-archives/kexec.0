From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 14 Feb 2022 12:09:39 -0500
Subject: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
In-Reply-To: <20220214155524.GN3113@kunlun.suse.cz>
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
 <cff97dbe262919ff709a5ad2c4af6a702cc72a95.camel@linux.ibm.com>
 <a8d717a44e5e919676e9b1e197cac781db46da87.camel@linux.ibm.com>
 <20220214155524.GN3113@kunlun.suse.cz>
Message-ID: <f324d8e04e4576d01325a4cfcad939abef29821b.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, 2022-02-14 at 16:55 +0100, Michal Such?nek wrote:
> Hello,
> 
> On Mon, Feb 14, 2022 at 10:14:16AM -0500, Mimi Zohar wrote:
> > Hi Michal,
> > 
> > On Sun, 2022-02-13 at 21:59 -0500, Mimi Zohar wrote:
> > 
> > > 
> > > On Tue, 2022-01-11 at 12:37 +0100, Michal Suchanek wrote:
> > > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > > index dea74d7717c0..1cde9b6c5987 100644
> > > > --- a/arch/powerpc/Kconfig
> > > > +++ b/arch/powerpc/Kconfig
> > > > @@ -560,6 +560,22 @@ config KEXEC_FILE
> > > >  config ARCH_HAS_KEXEC_PURGATORY
> > > >         def_bool KEXEC_FILE
> > > >  
> > > > +config KEXEC_SIG
> > > > +       bool "Verify kernel signature during kexec_file_load() syscall"
> > > > +       depends on KEXEC_FILE && MODULE_SIG_FORMAT
> > > > +       help
> > > > +         This option makes kernel signature verification mandatory for
> 
> This is actually wrong. KEXEC_SIG makes it mandatory that any signature
> that is appended is valid and made by a key that is part of the platform
> keyiring (which is also wrong, built-in keys should be also accepted).
> KEXEC_SIG_FORCE or an IMA policy makes it mandatory that the signature
> is present.

I'm aware of MODULE_SIG_FORCE, which isn't normally enabled by distros,
but enabling MODULE_SIG allows MODULE_SIG_FORCE to be enabled on the
boot command line.  In the IMA arch policies, if MODULE_SIG is enabled,
it is then enforced, otherwise an IMA "appraise" policy rule is
defined.  This rule would prevent the module_load syscall.

I'm not aware of KEXEC_SIG_FORCE.  If there is such a Kconfig, then I
assume it could work similarly.

> 
> > > > +         the kexec_file_load() syscall.
> > > 
> > > When KEXEC_SIG is enabled on other architectures, IMA does not define a
> > > kexec 'appraise' policy rule.  Refer to the policy rules in
> > > security/ima/ima_efi.c.  Similarly the kexec 'appraise' policy rule in
> 
> I suppose you mean security/integrity/ima/ima_efi.c

Yes

> 
> I also think it's misguided because KEXEC_SIG in itself does not enforce
> the signature. KEXEC_SIG_FORCE does.

Right, which is why the IMA efi policy calls set_module_sig_enforced().

> 
> > > arch/powerpc/kernel/ima_policy.c should not be defined.
> 
> I suppose you mean arch/powerpc/kernel/ima_arch.c - see above.

Sorry, yes.  

> 
> 
> Thanks for taking the time to reseach and summarize the differences.
> 
> > The discussion shouldn't only be about IMA vs. KEXEC_SIG kernel image
> > signature verification.  Let's try and reframe the problem a bit.
> > 
> > 1. Unify and simply the existing kexec signature verification so
> > verifying the KEXEC kernel image signature works irrespective of
> > signature type - PE, appended signature.
> > 
> > solution: enable KEXEC_SIG  (This patch set, with the above powerpc IMA
> > policy changes.)
> > 
> > 2. Measure and include the kexec kernel image in a log for attestation,
> > if desired.
> > 
> > solution: enable IMA_ARCH_POLICY 
> > - Powerpc: requires trusted boot to be enabled.
> > - EFI:   requires  secure boot to be enabled.  The IMA efi policy
> > doesn't differentiate between secure and trusted boot.
> > 
> > 3. Carry the kexec kernel image measurement across kexec, if desired
> > and supported on the architecture.
> > 
> > solution: enable IMA_KEXEC
> > 
> > Comparison: 
> > - Are there any differences between IMA vs. KEXEC_SIG measuring the
> > kexec kernel image?
> > 
> > One of the main differences is "what" is included in the measurement
> > list differs.  In both cases, the 'd-ng' field of the IMA measurement
> > list template (e.g. ima-ng, ima-sig, ima-modsig) is the full file hash
> > including the appended signature.  With IMA and the 'ima-modsig'
> > template, an additional hash without the appended signature is defined,
> > as well as including the appended signature in the 'sig' field.
> > 
> > Including the file hash and appended signature in the measurement list
> > allows an attestation server, for example, to verify the appended
> > signature without having to know the file hash without the signature.
> 
> I don't understand this part. Isn't the hash *with* signature always
> included, and the distinguishing part about IMA is the hash *without*
> signature which is the same irrespective of signature type (PE, appended
> xattr) and irrespective of the keyt used for signoing?

Roberto Sassu added support for IMA templates.  These are the
definitions of 'ima-sig' and 'ima-modsig'.

{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"}

d-ng: is the file hash.  With the proposed IMA support for fs-verity
digests, the 'd-ng' field may also include the fsverity digest, based
on policy.

n-ng: is the file pathname.
sig: is the file signature stored as a 'security.ima' xattr (may be
NULL).
d-modsig: is the file hash without the appended signature (may be
NULL).

FYI, changing from "module signature" to "appended signature", might
impact the template field and name.  :)

modsig: is the appended signature (May be NULL).

I really haven't looked at PE signatures, so I can't comment on them.

> 
> > Other differences are already included in the Kconfig KEXEC_SIG "Notes"
> > section.
> 
> Which besides what is already described above would be blacklisting
> specific binaries, which is much more effective if you have hashes of
> binaries without signature.

Thanks, Nayna will be happy to hear you approve.

FYI, IMA calculates the file hash once, which is then added to the IMA
measurement list, extended into the TPM (when available), used to
verify signatures, and included in the audit log.

With the KEXEC_SIG support, assuming the IMA arch policy is enabled,
the file hash would be calculated twice - once for verifying the file
signature and again for the measurement.

-- 
thanks,

Mimi


