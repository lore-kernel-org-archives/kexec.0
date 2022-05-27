From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 27 May 2022 02:55:33 +0000
Subject: [PATCH v2 0/2] Allow to kexec with initramfs larger than 2G
Message-ID: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Currently, the largest initramfs that is supported by kexec_file_load()
syscall is 2G.

This is because kernel_read_file() returns int, and is limited to
INT_MAX or 2G.

On the other hand, there are kexec based boot loaders (i.e. u-root),
that may need to boot netboot images that might be larger than 2G.

The first patch changes the return type from int to ssize_t in
kernel_read_file* functions.

The second patch increases the maximum initramfs file size to 4G.

Tested: verified that can kexec_file_load() works with 4G initramfs
on x86_64.

Pasha Tatashin (2):
  fs/kernel_read_file: Allow to read files up-to ssize_t
  kexec_file: Increase maximum file size to 4G

 fs/kernel_read_file.c            | 38 ++++++++++++++++----------------
 include/linux/kernel_read_file.h | 32 +++++++++++++--------------
 include/linux/limits.h           |  1 +
 kernel/kexec_file.c              | 10 ++++++---
 4 files changed, 43 insertions(+), 38 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog


