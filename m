Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A080DFF8873
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 07:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ngtzchp/6x72pHggoOfcu8l1aVao/9O/WyChqA+UT9g=; b=TtVPk6tDzezZeJRzq/bQ0YjSij
	IYFzha/aLcdQCPWdnLHmHBNhNtqZodIuDKGI13C6pffCkhEBlN/j+EWEO/Q7f24zn6mol8b5bnDMK
	9YvquMmxHiVEk64qE7jI0lTms4oih9+9flsJuJOZg1VJxtZEQ96onYVMG5qjT0lr0cqBjFsQDM4Rb
	yo/ac92ODoH2G6aARXqk8XHDE7XKMtvFZBb7MCpkK+G3/gKkzmnmsoiJPy4ian+hyQzY5dY+CAN3z
	cl+SsiqY7G4PMpaRcK3WhFMzkU0tnORiP4G4fQXsHXzzj9r+gnBJdLdezlFuB/W0KzKZxoNfuaOoy
	d4Gf+MEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHyu1-000000035sI-0B6n;
	Wed, 29 Apr 2026 07:00:09 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHytw-000000035mS-0psO
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 07:00:06 +0000
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-82418b0178cso7399218b3a.1
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777446003; x=1778050803; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngtzchp/6x72pHggoOfcu8l1aVao/9O/WyChqA+UT9g=;
        b=ZtJDhivFb1XApFNdkR32I35l0xlYt3wwtO0ZwtRSggxJWvkLP9581Q1dllj9JMXN7T
         3/IORw4bxMqNmfNOtZjSv7Z9YYQtstZWDSgUPr27Kofa3+6p2IGwx5oYqx3WcOf9gwru
         hMYuS8OvTe6pp9y74o/gE012M0mb2ATYW71Ev/O6ZS7pG/eeM4sZQ1qKsG4/72/nK2Zv
         Qeks1N01tesuLxyIaiA2wkRv+8pS+zH2M6ZheG7fRnbmmVEthZk5eLR8a3Vm4eqeUY5W
         d1JVp+jx/0F97wjJQFPWdmAjOGoIWDwZVliqETHDMEM3tPiuxBrXv/X+01Sb1Pol1/vr
         HJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777446003; x=1778050803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngtzchp/6x72pHggoOfcu8l1aVao/9O/WyChqA+UT9g=;
        b=p2J/0shTe+lcuQ1fReatTkwj/L5m1QIoX2KA/DA97Vk8jOcb2lfVPgxl4C145LUgvC
         EVgvXeJ0MEm5xfH8JZ0/DMnamZROjaR8/NtMKm/OuxnYi7KgOO4L8XYmV0i3Hany47PD
         Xty9HuKaCt3OrT8VLUY86V63zCma1qdtJwKbDzUKwkXCMO/2hzzUejwXNwc7E8u6J03t
         fDKuFnqiu60plBx5ChxR3+tNiTSkgZ/Rb8BZibRIrdOVU/z/SfIxd/gEJoppzTEkVdDj
         pY5A0Xd9f6eW39PbtR/5Q0mybvJYLbXopdIQxO03C2jvfW3g09lCfPSLzsNctFyzQ9Tk
         IKrQ==
X-Gm-Message-State: AOJu0YzzisgAyKMkJZVU+v4hHBJsPiN0oZV6Wov+/LHcn12mQNUBU5gY
	lnRCqgAcdkQof0UtkGOibnYS6JFzuigtP4QysL6gL4/XR9m9w9iMKTgY2Bf5Fn9gbc+ODUY6
X-Gm-Gg: AeBDietX0+xgT1IzEOzTqXtsUaz/5ZzzVP1VipGAHlnpXlZv6hjK/RWRHAz42QO0HuU
	HAZs7+zU9ai6GAv9cfEd0vEsuXD5zFHcBDM3RJrwE46BVae+OMSP0umG8zBu9pGgdF253iOk3kF
	D6Sgs+iBPhaRnjQGDFCYiEpel2pJAycUt0cBunHW0z2G5XMskpkbYhHMmxiMc8mMpI49zrHiwou
	xb05ACoQbtwfyQT9GAcled2r/ChvWjH1OLGEAjx0k7DFWBSDG+wTCV4Az62cmJrFctIte3F3W2u
	MQ4DbbTECsnB0m3U4THXGNisryGh3nV8/rwWO44OQ/YfuFCz1YVaQf+NpXmjS/nehyM5Bc4hn8z
	GDDLDKbv6zg7RneP0d/ZpiBeYbalT19uJazBTJ8HsZ6+zK/kSCsNm9ZCXQ2kQ9+0PMuC/mfYyC1
	UkSojUfS01RwBogbV92RMi2AzEpwQ40hjeq+WNObyM0V7+GEzZdcw2ps6RI5s=
X-Received: by 2002:a05:6a00:338e:b0:82f:6e7:152d with SMTP id d2e1a72fcca58-834ea569f84mr2491372b3a.21.1777446002842;
        Wed, 29 Apr 2026 00:00:02 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7eaf93sm1043146b3a.40.2026.04.28.23.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 00:00:02 -0700 (PDT)
From: Chen Wandun <chenwandun1@gmail.com>
X-Google-Original-From: Chen Wandun <chenwandun@lixiang.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	chenwandun@lixiang.com,
	zhaomeijing@lixiang.com,
	everyzhao@126.com
Subject: [PATCH 08/11] arm64: kdump: exclude no-dump reserved memory regions from vmcore
Date: Wed, 29 Apr 2026 14:58:28 +0800
Message-ID: <20260429065831.1510858-9-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429065831.1510858-1-chenwandun@lixiang.com>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_000004_349147_7F26DBFB 
X-CRM114-Status: GOOD (  11.21  )
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

Exclude reserved memory regions marked with the linux,no-dump property
from the elfcorehdr PT_LOAD segments when preparing kdump vmcore.

Device firmware memory regions (e.g., GPU, DSP, modem) reserved via
the device tree typically contain data that is not useful for kernel
crash analysis and can significantly increase vmcore size. By honoring
the no_dump flag in the reserved_mem array, these regions are filtered
out from the crash dump, resulting in smaller and more focused vmcore
files.

Use the common of_reserved_mem_exclude_no_dump() helper to perform the
exclusion, and pre-size the crash_mem array via
of_reserved_mem_no_dump_nr_ranges().

Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
Tested-by: Zhao Meijing <zhaomeijing@lixiang.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index e31fabed378a..7c9c38096c60 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -17,6 +17,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -51,6 +52,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
+	nr_ranges += of_reserved_mem_no_dump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -75,6 +77,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
+	ret = of_reserved_mem_exclude_no_dump(cmem);
+	if (ret)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0


