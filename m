Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWwG6-0006cI-TL
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 01:55:16 +0000
Received: by mail-pf0-x236.google.com with SMTP id x72so124621382pfd.2
 for <kexec@lists.infradead.org>; Mon, 08 Aug 2016 18:54:55 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 0/7] (kexec-tools) arm64: add kdump support
Date: Tue,  9 Aug 2016 11:00:25 +0900
Message-Id: <20160809020032.28654-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

My kernel patches of kdump suport on arm64 are currently under reviews [1].

This patchset is synced with them (v24) and provides necessary changes for
kexec-tools. It should be applied on top of Geoff's kexec-tools patches
v3[2] along with a bugfix[3].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/447597.html
[2] http://lists.infradead.org/pipermail/kexec/2016-August/016768.html
[3] http://lists.infradead.org/pipermail/kexec/2016-July/016664.html

Changes for v2:
 - Trim a temoprary buffer in setup_2nd_dtb()
 - Add patch#6("kexec: generalize and rename get_kernel_stext_sym()")
 - Update patch#7 from Pratyush
   (re-worked by akashi)

AKASHI Takahiro (5):
  arm64: kdump: identify memory regions
  arm64: kdump: add elf core header segment
  arm64: kdump: set up kernel image segment
  arm64: kdump: set up other segments
  arm64: kdump: add DT properties to crash dump kernel's dtb

Pratyush Anand (2):
  kexec: generalize and rename get_kernel_stext_sym()
  arm64: kdump: Add support for binary image files

 kexec/arch/arm/crashdump-arm.c          |  40 +------
 kexec/arch/arm64/Makefile               |   2 +
 kexec/arch/arm64/crashdump-arm64.c      | 188 +++++++++++++++++++++++++++++++-
 kexec/arch/arm64/crashdump-arm64.h      |  18 ++-
 kexec/arch/arm64/include/arch/options.h |   8 +-
 kexec/arch/arm64/kexec-arm64.c          |  91 ++++++++++++++--
 kexec/arch/arm64/kexec-elf-arm64.c      |  23 +++-
 kexec/arch/arm64/kexec-image-arm64.c    |  60 +++++++++-
 kexec/arch/i386/crashdump-x86.c         |  32 +-----
 kexec/crashdump.c                       |  37 +++++++
 kexec/crashdump.h                       |   1 +
 11 files changed, 407 insertions(+), 93 deletions(-)

-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
