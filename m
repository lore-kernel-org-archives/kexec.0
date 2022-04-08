From: Baoquan He <bhe@redhat.com>
Date: Fri, 8 Apr 2022 15:17:19 +0800
Subject: [PATCH v5 0/3] use more system keyrings to verify arm64 kdump
 kernel image signature
In-Reply-To: <20220401013118.348084-1-coxu@redhat.com>
References: <20220401013118.348084-1-coxu@redhat.com>
Message-ID: <Yk/hf7JEgALZOqE8@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Coiby,

On 04/01/22 at 09:31am, Coiby Xu wrote:
> Currently, a problem faced by arm64 is if a kernel image is signed by a
> MOK key, loading it via the kexec_file_load() system call would be
> rejected with the error "Lockdown: kexec: kexec of unsigned images is
> restricted; see man kernel_lockdown.7".
> 
> This patch set allows arm64 to use more system keyrings to verify kdump 
> kernel image signature by making the existing code in x64 public.

Thanks for updating. It would be great to tell why the problem is
met, then allow arm64 to use more system keyrings can solve it.

Meanwhile, I noticed Michal also posted a patchset to address the same
issue, while he tries to make it work on s390 too. Could you check and
consider if these two patches can be integrated?

[PATCH 0/4] Unifrom keyring support across architectures and functions
https://lore.kernel.org/lkml/cover.1644953683.git.msuchanek at suse.de/

Thanks
Baoquan

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
> Coiby Xu (3):
>   kexec: clean up arch_kexec_kernel_verify_sig
>   kexec, KEYS: make the code in bzImage64_verify_sig generic
>   arm64: kexec_file: use more system keyrings to verify kernel image
>     signature
> 
>  arch/arm64/kernel/kexec_image.c   |  4 +--
>  arch/x86/kernel/kexec-bzimage64.c | 13 +-------
>  include/linux/kexec.h             |  7 +++--
>  kernel/kexec_file.c               | 51 ++++++++++++++++++-------------
>  4 files changed, 37 insertions(+), 38 deletions(-)
> 
> -- 
> 2.34.1
> 


