Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22b.google.com ([2607:f8b0:400e:c03::22b])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRxI8-0007qY-CG
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 08:00:42 +0000
Received: by mail-pa0-x22b.google.com with SMTP id fi15so69778767pac.1
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 01:00:19 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/6] (kexec-tools) arm64: add kdump support
Date: Tue, 26 Jul 2016 17:05:19 +0900
Message-Id: <20160726080525.2539-1-takahiro.akashi@linaro.org>
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

This patchset is synced with them (v23) and provides necessary changes for
kexec-tools. It should be applied on top of Geoff's kexec-tools patches
v1/1.2 [2].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445558.html
[2] http://lists.infradead.org/pipermail/kexec/2016-July/016532.html

AKASHI Takahiro (5):
  arm64: kdump: identify memory regions
  arm64: kdump: add elf core header segment
  arm64: kdump: set up kernel image segment
  arm64: kdump: set up other segments
  arm64: kdump: add DT properties to crash dump kernel's dtb

Pratyush Anand (1):
  arm64: kdump: Add support for binary image

 kexec/arch/arm64/Makefile            |   2 +
 kexec/arch/arm64/crashdump-arm64.c   | 188 ++++++++++++++++++++++++++++++++++-
 kexec/arch/arm64/crashdump-arm64.h   |  18 +++-
 kexec/arch/arm64/kexec-arm64.c       |  85 ++++++++++++++--
 kexec/arch/arm64/kexec-elf-arm64.c   |  23 ++++-
 kexec/arch/arm64/kexec-image-arm64.c |  18 +++-
 6 files changed, 318 insertions(+), 16 deletions(-)

-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
