Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtbX-0003fa-Nk
 for kexec@lists.infradead.org; Fri, 11 Jan 2019 09:59:57 +0000
Received: by mail-yw1-xc41.google.com with SMTP id h193so5576041ywc.4
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2019 01:59:55 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 0/3] arm64: handle "reserved" entries in /proc/iomem
Date: Fri, 11 Jan 2019 18:59:43 +0900
Message-Id: <20190111095946.28070-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au, james.morse@arm.com, bhsharma@redhat.com
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org

# @James, @Bhupesh
# Could you kindly test this patch, please?
# I'm not quite confident that I correctly merged my patch with,
# particularly, Bhupesh's recent change.

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
          59a77000-59a77fff : reserved
        5be40000-5becffff : reserved
        5bed0000-5bedffff : System RAM
        5bee0000-5bffffff : reserved
        5c000000-5fffffff : System RAM
          5da00000-5e9fffff : reserved
          5ec00000-5edfffff : reserved
          5ef6a000-5ef6afff : reserved
          5ef6b000-5efcafff : reserved
          5efcd000-5efcffff : reserved
          5efd0000-5effffff : reserved
          5f000000-5fffffff : reserved

where "reserved" entries can be an APCI table, UEFI related code or data,
and they are expected to be preserved across kexec'ing.
With this patch[1], kexec/kdump will be allowed to handle them properly.

[1] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/resv_mem

AKASHI Takahiro (3):
  kexec: add variant helper functions for handling memory regions
  arm64: kexec: allocate memory space avoiding reserved regions
  arm64: kdump: deal with a lot of resource entries in /proc/iomem

 kexec/arch/arm64/crashdump-arm64.c |  25 ++---
 kexec/arch/arm64/kexec-arm64.c     | 146 +++++++++++++++++------------
 kexec/mem_regions.c                |  42 +++++++++
 kexec/mem_regions.h                |   7 ++
 4 files changed, 146 insertions(+), 74 deletions(-)

-- 
2.19.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
