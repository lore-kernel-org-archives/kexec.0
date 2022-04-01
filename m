From: Coiby Xu <coxu@redhat.com>
Date: Fri,  1 Apr 2022 09:31:15 +0800
Subject: [PATCH v5 0/3] use more system keyrings to verify arm64 kdump kernel
 image signature
Message-ID: <20220401013118.348084-1-coxu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Currently, a problem faced by arm64 is if a kernel image is signed by a
MOK key, loading it via the kexec_file_load() system call would be
rejected with the error "Lockdown: kexec: kexec of unsigned images is
restricted; see man kernel_lockdown.7".

This patch set allows arm64 to use more system keyrings to verify kdump 
kernel image signature by making the existing code in x64 public.

v5:
 - improve commit message [Baoquan]

v4:
 - fix commit reference format issue and other checkpatch.pl warnings [Baoquan]

v3:
 - s/arch_kexec_kernel_verify_pe_sig/kexec_kernel_verify_pe_sig [Eric]
 - clean up arch_kexec_kernel_verify_sig [Eric]

v2:
 - only x86_64 and arm64 need to enable PE file signature check [Dave]

Coiby Xu (3):
  kexec: clean up arch_kexec_kernel_verify_sig
  kexec, KEYS: make the code in bzImage64_verify_sig generic
  arm64: kexec_file: use more system keyrings to verify kernel image
    signature

 arch/arm64/kernel/kexec_image.c   |  4 +--
 arch/x86/kernel/kexec-bzimage64.c | 13 +-------
 include/linux/kexec.h             |  7 +++--
 kernel/kexec_file.c               | 51 ++++++++++++++++++-------------
 4 files changed, 37 insertions(+), 38 deletions(-)

-- 
2.34.1


