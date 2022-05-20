From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 20 May 2022 13:04:47 -0400
Subject: [PATCH v8 0/4] use more system keyrings to verify arm64 and
 s390 kexec kernel image signature
In-Reply-To: <20220512070123.29486-1-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
Message-ID: <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Coiby,

On Thu, 2022-05-12 at 15:01 +0800, Coiby Xu wrote:

The cover letter should start out with an overall problem description
and then continue with the specifics.  In this case each of the arch's
use different keyrings to validate the kexec kernel image signature.  I
would continue with saying the MOK keys were originally loaded onto the
.platform keyring with the other EFI keys, but recently with the new
.machine keyring that changed.

The purpose of this patch set is a generic solution for the different
archs.


> Currently, a problem faced by arm64 is if a kernel image is signed by a
> MOK key, loading it via the kexec_file_load() system call would be
> rejected with the error "Lockdown: kexec: kexec of unsigned images is
> restricted; see man kernel_lockdown.7". This happens because arm64 uses
> only the primary keyring i.e. the .builtin_trusted_keys keyring that
> contains only kernel built-in keys to verify the kexec kernel image. MOK
> keys are loaded into the .platform keyring or/and .machine keyring. The
> .machine keyring is linked to the secondary keyring i.e.
> .secondary_trusted_keys keyring when the end-user chooses to trust MOK
> keys. The platform keyring is exclusively used for kexec kernel image
> verification and .secondary_trusted_keys together with
> .builtin_trusted_keys are the system trusted keyrings. So obviously
> there is no reason to not use .secondary_trusted_keys or .platform
> keyring for kernel image signature verification. 

Both the ".platform" and ".machine" keyring are linked to the
".secondary_trusted_keys" keyring.   The root of trust for these
keyrings are very different.  Instead of saying "So obviously there is
no reason to not use .secondary_trusted_keys" it would be more
beneficial to describe the root of trusts, allowing others to draw
their own conclusions for their usecase.

thanks,

Mimi

> 
> Similarly, s390 only uses platform keyring for kernel image signature
> verification and built-in keys and secondary keyring are not used.
> 
> This patch set allows arm64 and s390 to use more system keyrings
> including the .secondary_trusted_keys and .platform keyring to verify
> kexec kernel image signature as x86 does.
> 
> The 3rd arm64 patch depends on the first two patches. The 4th s390 patch
> can be applied independently.

> v8:
>  - drop "Cc: stable at vger.kernel.org" for the first two prerequisite
>    patches [Baoquan]
> 
> v7:
>  - drop the Fixes tag for the 2nd patch and add patch prerequisites
>    [Baoquan]
>  - improve cover letter
> 
> v6:
>  - integrate the first three patches of "[PATCH 0/4] Unifrom keyring
>    support across architectures and functions" from Michal [1]
>  - improve commit message [Baoquan, Michal]
>  - directly assign kexec_kernel_verify_pe_sig to
>    kexec_file_ops->verify_sig [Michal]
> 
> v5:
>  - improve commit message [Baoquan]
> 
> v4:
>  - fix commit reference format issue and other checkpatch.pl warnings [Baoquan]
> 
> v3:
>  - s/arch_kexec_kernel_verify_pe_sig/kexec_kernel_verify_pe_sig [Eric]
>  - clean up arch_kexec_kernel_verify_sig [Eric]
> 
> v2:
>  - only x86_64 and arm64 need to enable PE file signature check [Dave]
> 
> [1] https://lore.kernel.org/lkml/cover.1644953683.git.msuchanek at suse.de/
> 
> Coiby Xu (3):
>   kexec: clean up arch_kexec_kernel_verify_sig
>   kexec, KEYS: make the code in bzImage64_verify_sig generic
>   arm64: kexec_file: use more system keyrings to verify kernel image
>     signature
> 
> Michal Suchanek (1):
>   kexec, KEYS, s390: Make use of built-in and secondary keyring for
>     signature verification
> 
>  arch/arm64/kernel/kexec_image.c       | 11 +-----
>  arch/s390/kernel/machine_kexec_file.c | 18 +++++++---
>  arch/x86/kernel/kexec-bzimage64.c     | 20 +----------
>  include/linux/kexec.h                 |  7 ++--
>  kernel/kexec_file.c                   | 51 ++++++++++++++++-----------
>  5 files changed, 50 insertions(+), 57 deletions(-)
> 



