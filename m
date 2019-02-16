Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv6Vj-0008Ew-T4
 for kexec@lists.infradead.org; Sat, 16 Feb 2019 20:24:34 +0000
Received: by mail-pl1-f196.google.com with SMTP id o6so6687283pls.13
 for <kexec@lists.infradead.org>; Sat, 16 Feb 2019 12:24:29 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 0/2] makedumpfile/arm64: Add support for ARMv8.2 extensions
Date: Sun, 17 Feb 2019 01:54:16 +0530
Message-Id: <1550348658-15300-1-git-send-email-bhsharma@redhat.com>
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
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, k-hagio@ab.jp.nec.com

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
2. ARMv8 FVP model, which supports ARMv8.2 extensions.

Bhupesh Sharma (2):
  makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit PA support)
  makedumpfile/arm64: Add support for ARMv8.2-LVA (52-bit user-space VA
    support)

 arch/arm64.c   | 411 +++++++++++++++++++++++++++++++++++++++++----------------
 makedumpfile.c |   2 +
 makedumpfile.h |   1 +
 3 files changed, 298 insertions(+), 116 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
