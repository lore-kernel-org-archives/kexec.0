Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h2w9K-0008AN-58
 for kexec@lists.infradead.org; Sun, 10 Mar 2019 10:57:47 +0000
Received: by mail-pg1-f195.google.com with SMTP id a22so1748044pgg.13
 for <kexec@lists.infradead.org>; Sun, 10 Mar 2019 03:57:45 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 0/3] makedumpfile/arm64: Add support for ARMv8.2 extensions
Date: Sun, 10 Mar 2019 16:27:32 +0530
Message-Id: <1552215455-12696-1-git-send-email-bhsharma@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: bhupesh.linux@gmail.com, bhsharma@redhat.com, k-hagio@ab.jp.nec.com

Changes since v2:
----------------
- v2 can be seen here:
  http://lists.infradead.org/pipermail/kexec/2019-February/022456.html
- I missed some comments from Kazu sent on the LVA v1 patch when I sent
  out the v2. So, addressing them now in v3.
- Also added a patch that adds a tree-wide feature to read
  'MAX_PHYSMEM_BITS' from vmcoreinfo (if available).

Changes since v1:
----------------
- v1 was sent as two separate patches:
  http://lists.infradead.org/pipermail/kexec/2019-February/022424.html
  (ARMv8.2-LPA)
  http://lists.infradead.org/pipermail/kexec/2019-February/022425.html
  (ARMv8.2-LVA)
- v2 combined the two in a single patchset and also addresses Kazu's
  review comments.

This patchset adds support for ARMv8.2 extensions in makedumpfile code.
I cover the following two cases with this patchset:
 - 48-bit VA + 52-bit PA (LPA)
 - 48-bit kernel VA + 52-bit virtual VA (LVA)

This has been tested for the following user-cases:
1. Calculating --mem-usage on the primary kernel,
2. Creating a dumpfile using /proc/vmcore, and
3. Post-processing a vmcore.

I have tested this patchset on the following platforms, with kernels
which support/do-not-support ARMv8.2 features:
1. CPUs which don't support ARMv8.2 features, e.g. qualcomm-amberwing,
   ampere-osprey.
2. Prototype models which support ARMv8.2 extensions (e.g. ARMv8 FVP
   simulation model).

Also a preparation patch has been added in this patchset which adds a
common feature for archs (except arm64, for which similar support is
added via subsequent patch) to retrieve 'MAX_PHYSMEM_BITS' from
vmcoreinfo (if available).

I recently posted two kernel patches (see [0] and [1]) which append
'PTRS_PER_PGD' and 'MAX_PHYSMEM_BITS' to vmcoreinfo in the kernel
code, so that user-space code can benefit from the same.

This patchset ensures backward compatibility for kernel versions in
which 'PTRS_PER_PGD' and 'MAX_PHYSMEM_BITS' are not available in
vmcoreinfo.

[0]. http://lists.infradead.org/pipermail/kexec/2019-March/022532.html
[1]. http://lists.infradead.org/pipermail/kexec/2019-March/022533.html

Bhupesh Sharma (3):
  tree-wide: Retrieve 'MAX_PHYSMEM_BITS' from vmcoreinfo (if available)
  makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit PA support)
  makedumpfile/arm64: Add support for ARMv8.2-LVA (52-bit user-space VA
    support)

 arch/arm.c     |   8 +-
 arch/arm64.c   | 394 ++++++++++++++++++++++++++++++++++++++++-----------------
 arch/ia64.c    |   7 +-
 arch/ppc.c     |   8 +-
 arch/ppc64.c   |  49 ++++---
 arch/s390x.c   |  29 +++--
 arch/sparc64.c |   9 +-
 arch/x86.c     |  34 +++--
 arch/x86_64.c  |  27 ++--
 makedumpfile.c |   2 +
 makedumpfile.h |   1 +
 11 files changed, 390 insertions(+), 178 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
