From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 27 May 2022 12:45:54 -0400
Subject: [PATCH v8 0/4] use more system keyrings to verify arm64 and
 s390 kexec kernel image signature
In-Reply-To: <20220527134315.afnuszqbfqkpnxpv@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
	 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
	 <20220525095957.vvref4yeaidd5iww@Rk>
	 <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
	 <20220527134315.afnuszqbfqkpnxpv@Rk>
Message-ID: <b3c87ce140b8d46659adcf07142e1d01ffbb2267.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org


On Fri, 2022-05-27 at 21:43 +0800, Coiby Xu wrote:
> Hi Mini,

Hi Coiby,

> new cover letter here to collect new feedback from you thus we
> can avoid unnecessary rounds of patch set.

Agreed.   Much better.  Just a couple of nits.

> Currently when loading a kernel image via the kexec_file_load() system
> call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
> .secondary_trusted_keys and .platform keyrings to verify signature.

Either "a signature" or "signatures".

> However, arm64 and s390 can only use the .builtin_trusted_keys and
> .platform keyring respectively. For example, one resulting problem is
> kexec'ing a kernel image  would be rejected with the error "Lockdown:
> kexec: kexec of unsigned images is restricted; see man
> kernel_lockdown.7".
> 
> This patch set enables arm64 and s390 to make use of the same keyrings
> as x86 to very the signature kexec'ed kernel image.

  Fix "very".  Perhaps "verify the kexec'ed kernel image signature".
> 
> The recently introduced .machine keyring impacts the roots of trust by
> linking the .machine keyring to the .secondary keyring. The roots of
> trust of different keyring are described as follows,
> 
"of ... keyring" -> "for the ... keyrings"

> .builtin_trusted_keys:
> 
> Keys may be built into the kernel during build or inserted into memory
> reserved for keys post build. The root of trust is the kernel build i.e.
> a Linux distribution vendor. On a physical system in a secure boot
> environment, this trust is rooted in hardware.

Please look at my response to your question below.

> 
> .machine:
> 
> If the end-users choose to trust the keys provided by first-stage UEFI
> bootloader shim i.e. Machine Owner Keys (MOK keys), the keys will be
> added to this keyring and this keyring is linked to the

 Grammatically "and this"  needs to be fixed.

> .secondary_trusted_keys keyring as same as the .builtin_trusted_keys
> keyring. Shim has built-in keys from a Linux distribution or the
> end-users-enrolled keys. So the root of trust of this keyring is either
> a Linux distribution vendor or the end-users.
> 
> .secondary_trusted_keys:
> 
> Certificates signed by keys on the .builtin_trusted_keys, .machine, or
> existing keys on the .secondary_trusted_keys keryings may be loaded
> onto the .secondary_trusted_keys keyring. This establishes a signature
> chain of trust based on keys loaded on either the .builtin_trusted_keys
> or .machine keyrings, if configured and enabled.
> 
> .platform:
> 
> The .platform keyring consist of UEFI db and MOK keys which are used by
> shim to verify the first boot kernel's image signature. If end-users
> choose to trust MOK keys and the kernel has the .machine keyring
> enabled, the .platform keyring only consists of UEFI db keys since the
> MOK keys are added to the .machine keyring instead. Because the
> end-users could also enroll there own MOK keys, the root of trust could

"there" -> "their"

> be hardware or the end-users.

It's always "hardware".  "or" -> "and"?

<snip>

> >>
> >> The root of trusts of the keys in the %.builtin_trusted_keys and
> >> secondary_trusted_keys keyring is a Linux distribution vendor.
> >
> >The root of trust for each keyring should be described separately.
> >
> >.builtin_trusted_keys:
> >
> >For example,
> >
> >Keys may be built into the kernel during build or inserted into memory
> >reserved for keys post build.  In both of these cases, trust is based
> >on verification of the kernel image signature.  
> 
> Correct me if I'm wrong, without secure boot, there is no verification
> of the kernel image signature so the root of trust should be trust on
> the kernel builder.

No, basing the signature verification on secure boot could not have
been upstreamed.  IMA is based on policy, regardeless of the secure
boot mode.  A builtin policy may be specified on the boot command line,
but should be replaced with a more constrained custom policy [1]. 
Unlike the builtin policy rules, the architecture specific rules are
persistent[2].   The architecture specific rules are normally tied to
the secure boot modes.  On OpenPOWER, the architecture specific
"measure" rules are dependent on the trusted boot mode.

The current IMA policy rules can be viewed by cat'ing
<securityfs>/ima/policy.

[1] The builtin policies are not LSM aware.  The policy rules need to
be constrained to avoid integrity violations.

[2] arch specific policy rules:
security/integrity/ima/ima_efi.c, arch/powerpc/kernel/ima_arch.c

thanks,

Mimi


