Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ie9JP-00068J-G3
 for kexec@lists.infradead.org; Mon, 09 Dec 2019 03:02:17 +0000
Received: by mail-pf1-x443.google.com with SMTP id b19so6456102pfo.2
 for <kexec@lists.infradead.org>; Sun, 08 Dec 2019 19:02:14 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 0/2] arm64: kexec_file: add kdump
Date: Mon,  9 Dec 2019 12:03:43 +0900
Message-Id: <20191209030345.5735-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com
Cc: kexec@lists.infradead.org, james.morse@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

This is the last piece of my kexec_file_load implementation for arm64.
It is now ready for being merged as some relevant patch to dtc/libfdt[1]
has finally been integrated in v5.3-rc1.
(Nothing changed since kexec_file v16[2] except adding Patch#1.)

Patch#1 is preliminary patches for libfdt component.
Patch#2 is to add kdump support.

Bhepesh's patch[3] will be required for 52-bit VA support either against
legacy kexec or kexec_file.
Once this patch is applied, whether or not CONFIG_ARM64_VA_BITS_52 is
enabled or not, a matching fix[4] on user space side, crash utility,
will also be needed. 
# NOTE:
# As of v5.5-rc1, crash utility doesn't work due to the commit
# b6e43c0e3129 ("arm64: remove __exception annotations").
# But the fix is trivial and it won't affect this kernel patch.

Anyway, I tested my patch, at least, with the following configuration:
1) CONFIG_ARM64_BITS_48=y
2) CONFIG_ARM64_BITS_52=y, but vabits_actual=48

(I don't have any platform to use for
3) CONFIG_ARM64_BITS_52=y, and vabits_actual=52)

[1] commit 9bb9c6a110ea ("scripts/dtc: Update to upstream version
    v1.5.0-23-g87963ee20693"), in particular
	7fcf8208b8a9 libfdt: add fdt_append_addrrange()
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612641.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-November/693411.html
[4] https://www.redhat.com/archives/crash-utility/2019-November/msg00014.html

Changes in v3 (Dec 9, 2019)
* rebased to v5.5-rc1
* remove v2's patch#2 as the same fix has been applied
* Otherwise, no functional changes (since v1)

Changes in v2 (Nov 14, 2019)
* rebased to v5.4-rc7
* no functional changes

v1 (Sept 12, 2019)
* on top of v5.3-rc8

AKASHI Takahiro (2):
  libfdt: include fdt_addresses.c
  arm64: kexec_file: add crash dump support

 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/kexec_image.c        |   4 -
 arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
 lib/Makefile                           |   2 +-
 lib/fdt_addresses.c                    |   2 +
 5 files changed, 109 insertions(+), 9 deletions(-)
 create mode 100644 lib/fdt_addresses.c

-- 
2.24.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
