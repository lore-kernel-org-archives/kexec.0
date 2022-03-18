From: Milan Broz <gmazyland@gmail.com>
Date: Fri, 18 Mar 2022 12:29:06 +0100
Subject: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
References: <20220318103423.286410-1-coxu@redhat.com>
Message-ID: <c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 18/03/2022 11:34, Coiby Xu wrote:
> With kdump enabled, when kernel crashes, the system could boot into the
> kdump kernel and dump the memory image i.e. /proc/vmcore to a specified
> target. Currently, when dumping vmcore to a LUKS encrypted device, there
> are two problems,
>   - for some machines, the user may don't have a chance enter the password
>     to decrypt the device after kernel crashes and kdump initrd is loaded
>   - LUKS2 by default use the memory-hard Argon2 key derivation function
>     which is quite memory-consuming compared to the limited memory reserved
>     for kdump. Take Fedora example, by default, only 256M is reserved for
>     systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>     to be reserved for kdump.
>   
> Besides the users (at least for Fedora) usually expect kdump to work out
> of the box i.e. no manual password input is needed. And it doesn't make
> sense to derivate the master key again in kdump kernel which seems to be
> redundant work.
> 
> Based on Milan's feedback [1] on Kairui's ideas to support kdump with
> LUKS encryption, this patch set addresses the above issues by

Hi,

I think you are creating another attack vector here, storing the encryption
key to yet another place... but I already mentioned that in the referenced mail.

Why is it not done through keyring and forcing kdump to retain key there
(under the same keyring key name as dm-crypt used)?
Kernel dm-crypt supports this already; LUKS2 uses keyring by default too.
That's all you need, or not? Why do you need to add another "kdump:" thing?
IOW why kdump cannot copy the key to keyring under the name dm-crypt
has in the mapping table and let dm-crypt activate the device almost without
code changes?

Anyway, please fix the naming before this patchset can be read or reviewed!

LUKS is user-space key management only (on-disk metadata); the kernel has
no idea how the key is derived or what LUKS is - dm-crypt only knows the key
(either through keyring or directly in the mapping table).

Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
is used in many other mappings (plain, bitlocker, veracrypt, ...)
Just use the dm-crypt key, do not reference LUKS at all.

Milan



>   1) first saving the LUKS master key to kexec when opening the encrypted
>      device
>   2) then saving the master key to the reserved memory for kdump when
>      loading kdump kernel image.
> 
> So the LUKS master key never leaves the kernel space and once the key has
> been saved to the reserved memory for kdump, it would be wiped
> immediately. If there is no security concern with this approach or any
> other concern, I will drop the following assumptions made for this RFC
> version in v1,
>   - only x86 is supported
>   - there is only one LUKS device for the system
> 
> to extend the support to other architectures including POWER, ARM and
> s390x and address the case of multiple LUKS devices. Any feedback will be
> appreciated, thanks!
> 
> For a proof of concept, I've patched cryptsetup [2] in a quick-and-dirty
> way to support a new option "--kdump-kernel-master-key"
> and hacked systemd [3]. It works for Fedora 34.
> 
> [1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79 at gmail.com/
> [2] https://gitlab.com/coxu/cryptsetup/-/commit/ee54bb15445da0bc3f9155a7227a9799da4dac20
> [3] https://github.com/coiby/systemd/tree/reuse_kdump_master_key
> 
> Coiby Xu (4):
>    kexec, dm-crypt: receive LUKS master key from dm-crypt and pass it to
>      kdump
>    kdump, x86: pass the LUKS master key to kdump kernel using a kernel
>      command line parameter luksmasterkey
>    crash_dump: retrieve LUKS master key in kdump kernel
>    dm-crypt: reuse LUKS master key in kdump kernel
> 
>   arch/x86/include/asm/crash.h      |  1 +
>   arch/x86/kernel/crash.c           | 42 ++++++++++++++++++-
>   arch/x86/kernel/kexec-bzimage64.c |  7 ++++
>   drivers/md/dm-crypt.c             | 26 +++++++++---
>   include/linux/crash_dump.h        |  4 ++
>   include/linux/kexec.h             |  7 ++++
>   kernel/crash_dump.c               | 69 +++++++++++++++++++++++++++++++
>   kernel/kexec_core.c               | 66 +++++++++++++++++++++++++++++
>   8 files changed, 215 insertions(+), 7 deletions(-)
> 

