Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihcPp-0006G1-Ru
 for kexec@lists.infradead.org; Wed, 18 Dec 2019 16:43:15 +0000
Received: by mail-qt1-x842.google.com with SMTP id k40so2439213qtk.8
 for <kexec@lists.infradead.org>; Wed, 18 Dec 2019 08:43:13 -0800 (PST)
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: [PATCH v3 0/3] arm64: handle "reserved" entries in /proc/iomem
Date: Wed, 18 Dec 2019 11:42:29 -0500
Message-Id: <20191218164232.6086-1-msys.mizuma@gmail.com>
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
To: kexec mailing list <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh Sharma <bhsharma@redhat.com>, Masayoshi Mizuma <msys.mizuma@gmail.com>, James Morse <james.morse@arm.com>

In recent arm64 kernels, /proc/iomem has an extended file format like:

 40000000-5871ffff : System RAM
   41800000-426affff : Kernel code
   426b0000-42aaffff : reserved
   42ab0000-42c64fff : Kernel data
   54400000-583fffff : Crash kernel
   58590000-585effff : reserved
   58700000-5871ffff : reserved
 58720000-58b5ffff : reserved
 58b60000-5be3ffff : System RAM
   58b61000-58b61fff : reserved

where "reserved" entries can be an ACPI table, UEFI related code or
data. They can be corrupted and result in early failure in booting
a new kernel. As an actual example, LPI pending table and LPI property
table, which are pointed by a UEFI data, are sometimes destroyed.

They are expected to be preserved across kexec'ing.

Changelog:
    v3: - Re-based to the latest commit (bd07796).
        - Added Tested-by tag from Bhupesh and Masayoshi
        - Added an error handling in case
          mem_regions_alloc_and_exclude() fails (0002 patch).

AKASHI Takahiro (3):
  kexec: add variant helper functions for handling memory regions
  arm64: kexec: allocate memory space avoiding reserved regions
  arm64: kdump: deal with a lot of resource entries in /proc/iomem

 kexec/arch/arm64/crashdump-arm64.c |  25 ++---
 kexec/arch/arm64/kexec-arm64.c     | 153 ++++++++++++++++++-----------
 kexec/mem_regions.c                |  42 ++++++++
 kexec/mem_regions.h                |   7 ++
 4 files changed, 153 insertions(+), 74 deletions(-)

-- 
2.18.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
