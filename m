From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 25 May 2022 09:30:40 -0400
Subject: [PATCH v8 0/4] use more system keyrings to verify arm64 and
 s390 kexec kernel image signature
In-Reply-To: <20220525095957.vvref4yeaidd5iww@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
	 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
	 <20220525095957.vvref4yeaidd5iww@Rk>
Message-ID: <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, 2022-05-25 at 17:59 +0800, Coiby Xu wrote:
> Hi Mimi,
> 
> On Fri, May 20, 2022 at 01:04:47PM -0400, Mimi Zohar wrote:
> >Hi Coiby,
> >
> >On Thu, 2022-05-12 at 15:01 +0800, Coiby Xu wrote:
> >
> >The cover letter should start out with an overall problem description
> >and then continue with the specifics.  In this case each of the arch's
> >use different keyrings to validate the kexec kernel image signature.  I
> 
> Thanks for the suggestion! I will start with an overall problem
> description in next version. For me, the bigger problem is arm kexec
> can't make use of .secondary_trusted_keys or .platform to verify kernel
> image signature. The by-product of the solution is it also helps
> address the problem of inconsistent usage of keyrings by kexec between
> different arches.
> 
> >would continue with saying the MOK keys were originally loaded onto the
> >.platform keyring with the other EFI keys, but recently with the new
> >.machine keyring that changed.
> 
> It seems I lack some background knowledge that makes me fail to
> appreciate what change the new .machine keyring brings to kexec. As far
> as I can understand, the new .machine keyring doesn't seem to change
> much about kexec kernel image signature verification. kexec should be
> able to use MOK keys to verify signature regardless of the keys being
> loaded into .platform keyring or into the new .machine keyring. Because
> the MOK keys have already be used to verify the 1st booting kernel's
> image signature. To me, the significance of the new .machine keyring is
> the end-users-enrolled keys can be also used to verify kernel modules
> (the end users can also add his key to the .secondary_trusted_keys
> keyring but the key needs to vouched by any existing key from the
> .builtin_trusted_keys or .secondary_trusted_keys which is nearly
> impossible).

"the significance of the new .machine keyring is the end-users-enrolled 
keys can be also used to verify kernel modules" correct.   So any key
stored in MOK and loaded onto the .machine keyring, could also then be
used to verify the kexec'ed kernel image signature as well.

> 
> >
> >The purpose of this patch set is a generic solution for the different
> >archs.
> >
> >
> >> Currently, a problem faced by arm64 is if a kernel image is signed by a
> >> MOK key, loading it via the kexec_file_load() system call would be
> >> rejected with the error "Lockdown: kexec: kexec of unsigned images is
> >> restricted; see man kernel_lockdown.7". This happens because arm64 uses
> >> only the primary keyring i.e. the .builtin_trusted_keys keyring that
> >> contains only kernel built-in keys to verify the kexec kernel image. MOK
> >> keys are loaded into the .platform keyring or/and .machine keyring. The
> >> .machine keyring is linked to the secondary keyring i.e.
> >> .secondary_trusted_keys keyring when the end-user chooses to trust MOK
> >> keys. The platform keyring is exclusively used for kexec kernel image
> >> verification and .secondary_trusted_keys together with
> >> .builtin_trusted_keys are the system trusted keyrings. So obviously
> >> there is no reason to not use .secondary_trusted_keys or .platform
> >> keyring for kernel image signature verification.
> >
> >Both the ".platform" and ".machine" keyring are linked to the
> >".secondary_trusted_keys" keyring.
> 
> I don't find any code that links the .platform keyring to the
> .secondary_trusted_keys keyring and one [1] of your replies to "[PATCH
> 4/4] module, KEYS: Make use of platform keyring for signature
> verification" is as follows,
>    "Permission for loading the pre-OS keys onto the 'platform' keyring and
>    using them is limited to verifying the kexec kernel image, nothing
>    else."

Right, that should have been, "Both the .builtin_trusted_keys and
.machine keyrings are linked ..."

> 
> [1] https://lore.kernel.org/linux-arm-kernel/3e39412657a4b0839bcf38544d591959e89877b8.camel at linux.ibm.com/
> 
> >The root of trust for these
> >keyrings are very different.  Instead of saying "So obviously there is
> >no reason to not use .secondary_trusted_keys" it would be more
> >beneficial to describe the root of trusts, allowing others to draw
> >their own conclusions for their usecase.

Linking the .machine keyring to the .secondary keyring impacts the
root(s) of trust.

> 
> Thanks for the suggestion! I'll add the following text in v9, do it
> looks good to you?
> 
> The root of trusts of the keys in the %.builtin_trusted_keys and
> secondary_trusted_keys keyring is a Linux distribution vendor. 

The root of trust for each keyring should be described separately.

.builtin_trusted_keys:

For example,

Keys may be built into the kernel during build or inserted into memory
reserved for keys post build.  In both of these cases, trust is based
on verification of the kernel image signature.  On a physical system in
a secure boot environment, this trust is rooted in HW.

.machine:

< explanation >

.secondary_trusted_keys:

For example,

Certificates signed by keys on the .builtin_trusted_keys, .machine, or
existing keys on the .secondary_trusted_keys keryings may be loaded
onto the .secondary_trusted_keys keyring.  This establishes a signature
chain of trust based on keys loaded on either the .builtin_trusted_keys
or .machine keyrings, if configured and enabled.

.platform

< explanation >


thanks,

Mimi


> The
> .platform keyring could have both UEFI db keys and MOK keys or only UEFI
> db keys. And the .machine keyring only have MOK keys. The root trust of
> UEFI db keys is UEFI Platform Key which is shipped by an UEFI firmware
> vendor. The root trust of MOK keys is a Linux distribution vendor (shim
> has built-in MOK key) and the end user could also be another root of
> trust if he/she enrolls his own key.
> 
> The %.builtin_trusted_keys keyring consists of the trustable keys built
> into the kernel when a kernel is built by a developer.
> 
> The .secondary_trusted_keys keyring introduced by commit d3bfe84129f6
> ("certs: Add a secondary system keyring that can be added to
> dynamically") consists of the trustable keys that an end-user can add
> dynamically after booting the kernel. When this kernel enables the
> .machine keyring and an end user chooses to trust Machine Owner Keys
> (MOK) provided by shim, MOK keys will be added to the .machine
> keyring and the .machine keyring is be linked to the
> secondary_trusted_keys so keys contained in the .machine keyring will
> automatically be searched when searching secondary_trusted_keys.
> 
> The .platform keyring introduced by commit 9dc92c45177a ("integrity:
> Define a trusted platform keyring") consist of UEFI db and
> MOK keys. If an end user chooses to Machine Owner Keys and the kernel
> has the .machine keyring enabled, the .platform keyring only consists of
> UEFI db keys since the MOK keys are added to the .machine keyring
> instead.



