From: Coiby Xu <coxu@redhat.com>
Date: Fri, 27 May 2022 21:43:15 +0800
Subject: [PATCH v8 0/4] use more system keyrings to verify arm64 and s390
 kexec kernel image signature
In-Reply-To: <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
References: <20220512070123.29486-1-coxu@redhat.com>
 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
 <20220525095957.vvref4yeaidd5iww@Rk>
 <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
Message-ID: <20220527134315.afnuszqbfqkpnxpv@Rk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Mini,

It seems I need to only change cover letter and commit message i.e.
there is no concern about the code. So it's better to provide a
new cover letter here to collect new feedback from you thus we
can avoid unnecessary rounds of patch set.

Currently when loading a kernel image via the kexec_file_load() system
call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
.secondary_trusted_keys and .platform keyrings to verify signature.
However, arm64 and s390 can only use the .builtin_trusted_keys and
.platform keyring respectively. For example, one resulting problem is
kexec'ing a kernel image  would be rejected with the error "Lockdown:
kexec: kexec of unsigned images is restricted; see man
kernel_lockdown.7".

This patch set enables arm64 and s390 to make use of the same keyrings
as x86 to very the signature kexec'ed kernel image.

The recently introduced .machine keyring impacts the roots of trust by
linking the .machine keyring to the .secondary keyring. The roots of
trust of different keyring are described as follows,

.builtin_trusted_keys:

Keys may be built into the kernel during build or inserted into memory
reserved for keys post build. The root of trust is the kernel build i.e.
a Linux distribution vendor. On a physical system in a secure boot
environment, this trust is rooted in hardware.

.machine:

If the end-users choose to trust the keys provided by first-stage UEFI
bootloader shim i.e. Machine Owner Keys (MOK keys), the keys will be
added to this keyring and this keyring is linked to the
.secondary_trusted_keys keyring as same as the .builtin_trusted_keys
keyring. Shim has built-in keys from a Linux distribution or the
end-users-enrolled keys. So the root of trust of this keyring is either
a Linux distribution vendor or the end-users.

.secondary_trusted_keys:

Certificates signed by keys on the .builtin_trusted_keys, .machine, or
existing keys on the .secondary_trusted_keys keryings may be loaded
onto the .secondary_trusted_keys keyring. This establishes a signature
chain of trust based on keys loaded on either the .builtin_trusted_keys
or .machine keyrings, if configured and enabled.

.platform:

The .platform keyring consist of UEFI db and MOK keys which are used by
shim to verify the first boot kernel's image signature. If end-users
choose to trust MOK keys and the kernel has the .machine keyring
enabled, the .platform keyring only consists of UEFI db keys since the
MOK keys are added to the .machine keyring instead. Because the
end-users could also enroll there own MOK keys, the root of trust could
be hardware or the end-users.


On Wed, May 25, 2022 at 09:30:40AM -0400, Mimi Zohar wrote:
>On Wed, 2022-05-25 at 17:59 +0800, Coiby Xu wrote:
>> Hi Mimi,
>>
[...]
>> It seems I lack some background knowledge that makes me fail to
>> appreciate what change the new .machine keyring brings to kexec. As far
>> as I can understand, the new .machine keyring doesn't seem to change
>> much about kexec kernel image signature verification. kexec should be
>> able to use MOK keys to verify signature regardless of the keys being
>> loaded into .platform keyring or into the new .machine keyring. Because
>> the MOK keys have already be used to verify the 1st booting kernel's
>> image signature. To me, the significance of the new .machine keyring is
>> the end-users-enrolled keys can be also used to verify kernel modules
>> (the end users can also add his key to the .secondary_trusted_keys
>> keyring but the key needs to vouched by any existing key from the
>> .builtin_trusted_keys or .secondary_trusted_keys which is nearly
>> impossible).
>
>"the significance of the new .machine keyring is the end-users-enrolled
>keys can be also used to verify kernel modules" correct.   So any key
>stored in MOK and loaded onto the .machine keyring, could also then be
>used to verify the kexec'ed kernel image signature as well.

Thanks for explanation!

>
[...]
>> >
>> >Both the ".platform" and ".machine" keyring are linked to the
>> >".secondary_trusted_keys" keyring.
>>
>> I don't find any code that links the .platform keyring to the
>> .secondary_trusted_keys keyring and one [1] of your replies to "[PATCH
>> 4/4] module, KEYS: Make use of platform keyring for signature
>> verification" is as follows,
>>    "Permission for loading the pre-OS keys onto the 'platform' keyring and
>>    using them is limited to verifying the kexec kernel image, nothing
>>    else."
>
>Right, that should have been, "Both the .builtin_trusted_keys and
>.machine keyrings are linked ..."

Thanks for the confirmation! I should have realized it's a typo.

>
>>
>> [1] https://lore.kernel.org/linux-arm-kernel/3e39412657a4b0839bcf38544d591959e89877b8.camel at linux.ibm.com/
>>
>> >The root of trust for these
>> >keyrings are very different.  Instead of saying "So obviously there is
>> >no reason to not use .secondary_trusted_keys" it would be more
>> >beneficial to describe the root of trusts, allowing others to draw
>> >their own conclusions for their usecase.
>
>Linking the .machine keyring to the .secondary keyring impacts the
>root(s) of trust.

Thanks for the clarification!

>
>>
>> Thanks for the suggestion! I'll add the following text in v9, do it
>> looks good to you?
>>
>> The root of trusts of the keys in the %.builtin_trusted_keys and
>> secondary_trusted_keys keyring is a Linux distribution vendor.
>
>The root of trust for each keyring should be described separately.
>
>.builtin_trusted_keys:
>
>For example,
>
>Keys may be built into the kernel during build or inserted into memory
>reserved for keys post build.  In both of these cases, trust is based
>on verification of the kernel image signature.  

Correct me if I'm wrong, without secure boot, there is no verification
of the kernel image signature so the root of trust should be trust on
the kernel builder.


> On a physical system in
>a secure boot environment, this trust is rooted in HW.
>
>.machine:
>
>< explanation >
>
>.secondary_trusted_keys:
>
>For example,
>
>Certificates signed by keys on the .builtin_trusted_keys, .machine, or
>existing keys on the .secondary_trusted_keys keryings may be loaded
>onto the .secondary_trusted_keys keyring.  This establishes a signature
>chain of trust based on keys loaded on either the .builtin_trusted_keys
>or .machine keyrings, if configured and enabled.
>
>.platform
>
>< explanation >
>
>
>thanks,
>
>Mimi

Thanks for providing the examples!

-- 
Best regards,
Coiby


