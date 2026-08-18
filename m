Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ABEC5DF7E
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:From:
	Content-Transfer-Encoding:To:Mime-Version:Cc:Content-Type:Message-Id:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A2IkRQOZlTVlS2PwwIJE08oe59qsH8fY/JMtFFpLApY=; b=18+1SxHwTzumV0Fu0mFbxvJXYj
	6vaCFIhRzT5nx1GBjY+FaViNijFPnjaowcEu4Eqs6pBb5jKG8U7bJhHdjNtAogBDNnZ5/FZShOS3Y
	GgLhRBsSMW6ljiqqcyhMTiBOEN2XOi7Tzatkg/RBqznslOHxUIhs4MM/QGo4ZKVp+vqtusAgbbtFo
	Igl22bFcCByOEdgd8noZXQNfrcgT3psoVRRuHk5i9hhCRzjG3jizQw7hDEJN3eaPXOLDPcpt7zMb4
	EnRv2y3z5IWa3YbAkV0ecdWUId0EJ8C4kFzVU9bWJfmsWbJ1YXlANPrkHjxHXe3vzsXYoocA9ATsa
	pyX0wYfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJ2U-00000007w3i-1X8h;
	Tue, 18 Aug 2026 12:35:34 +0000
Received: from va-2-113.ptr.blmpb.com ([209.127.231.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJ2R-00000007w1v-0Hpx
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 12:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787056522; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=A2IkRQOZlTVlS2PwwIJE08oe59qsH8fY/JMtFFpLApY=;
 b=TrrZkZuAZamJAY4QT1inn9zt7AN1vyHDnxKTuZBHp/YyyvJZxThttiBSLqhQENPDwA0se/
 2LsqaPYIaqHVpcoodmEl4d2XFT4mx1QkakCaIXE/4CtvuaD4f4M15S1dHo0KtMGiDMWC/u
 S1Gda5dFIziqlpx3hsUWzrjWJlkEpurKgRdQc5CYnmJLPy8X2W/X2/20pVUKUW4l5x/R9e
 AVNoaz/zOfMYKwwoO8QGe8SSOA+BJNBvfoGsjzYvUVnS7HWZzjVnm0wqOO8ZBheJBBPL5C
 Dp9USngGIKKQx+17+dU2tY8THP/P6za0xqouEbgN4OzABNtEmm2p0pQh+Z4kiA==
X-Lms-Return-Path: <lba+26a845188+5f1f03+lists.infradead.org+qirui.001@bytedance.com>
Date: Tue, 18 Aug 2026 20:35:05 +0800
Message-Id: <20260818123504.12022-4-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset=UTF-8
Cc: <horms@kernel.org>, <linux-riscv@lists.infradead.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>
To: <kexec@lists.infradead.org>
Content-Transfer-Encoding: 7bit
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH 0/2] kexec-tools: Fix split crash kernel reservations
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_053531_187116_62720E44 
X-CRM114-Status: UNSURE (   7.54  )
X-CRM114-Notice: Please train this message.
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

This series fixes two kexec-tools issues seen with split crash kernel
reservations.

The first patch makes --print-ckr-size prefer
/sys/kernel/kexec_crash_size. This restores the option's original
user-visible contract: report the same crash kernel reserved size and
unit as the kernel sysfs attribute when that attribute is available.
The existing arch load-range based calculation is kept as a fallback for
older kernels.

The second patch fixes the RISC-V kexec_load crash path. RISC-V records
all Crash kernel ranges from /proc/iomem, but it currently writes only
the selected load range to linux,usable-memory-range. On systems with
high/low crash kernel reservations, that prevents the crash kernel from
seeing the low reservation after boot.

Keep placing the crash image segments in the selected load range, but
pass all crash kernel ranges to the crash kernel through
linux,usable-memory-range. This follows the split-reservation handoff
model already used by arm64 kexec-tools, where
linux,usable-memory-range = <BASE1 SIZE1 BASE2 SIZE2> advertises both
high and low crash kernel ranges to the crash dump kernel.

Tested on riscv64 with:

  /proc/iomem:
    f7e00000-ffdfffff       : Crash kernel  (128 MiB low)
    1f88c00000-1ff6bfffff   : Crash kernel  (1760 MiB high)

  /sys/kernel/kexec_crash_size:
    1979711488

With the patched kexec binary:

  kexec --print-ckr-size
    1979711488

  kexec -c -p ... followed by a panic completed kdump successfully.
  The crash kernel reported both ranges as System RAM in /proc/iomem:

    f7e00000-ffdfffff       : System RAM
    1f88c00000-1ff6bfffff   : System RAM

The vmcore was saved successfully.

Rui Qi (2):
  kexec: Print crash kernel reserved size from sysfs
  RISC-V: Pass all crash kernel ranges to crash kernel

 kexec/arch/riscv/crashdump-riscv.c | 14 ++++++++
 kexec/arch/riscv/kexec-riscv.c     | 35 +++++++++++++++++--
 kexec/arch/riscv/kexec-riscv.h     |  1 +
 kexec/dt-ops.c                     | 55 ++++++++++++++++++++++++------
 kexec/dt-ops.h                     |  5 ++-
 kexec/kexec.c                      | 27 ++++++++++++---
 6 files changed, 118 insertions(+), 19 deletions(-)

-- 
2.52.0

