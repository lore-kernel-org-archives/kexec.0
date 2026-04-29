Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D060FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 07:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+aKzcozrfPvAHDOI307L3sGfueBolTmIlF5K5tQEKM=; b=dVogTP1b6hOYda0CtlntOsvFQn
	ehwvuXBEqApPVBz/UMlq3pINZjhw4yHM+Iul45VCQeHjOKBO0WgXIED/p/Pd9gm4GKm4XIgxng5UN
	ug71m60WBmyravMCMt6WPN0CCL9TG5Kr6DsPii48qJes6d3jjkJejAyQCCqSFirzgKH+hT+vmL0vo
	atTD/Q4hv2tsf26d1wKEyMtR+0eMtfHfTtv1GSH3/PZimmvwUQxxmdrwylA1RJTgrI0fYDirQyj0f
	WERXuTeGBs4qNx+gVI0/2aBelx2g7CNRE5Z9yFMj/KAALs0Gx/sFEXV+rGRRbihLnuWflCjrNZrjL
	6JGWvN9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHyuD-0000000365m-2EXe;
	Wed, 29 Apr 2026 07:00:21 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHyu6-000000035y2-2Elp
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 07:00:16 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-82cf636dac8so5271974b3a.3
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 00:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777446013; x=1778050813; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+aKzcozrfPvAHDOI307L3sGfueBolTmIlF5K5tQEKM=;
        b=WmSXNrhEVjbg9XQjpcmbBweiOctow6zt8L0Yvr2TyyfjfYUFsXeGfE6hEREg4wBAf5
         ana3HJ63efBHbQlNPO7RCAs61dIhGZAuHD56oIvjBNgS8SmMwHOEU9/djVSKvG7t5OSd
         +yFthVt46Sv5CNIpxKL8GSVSe92g/VudoTLz/c6I15jnb7sRSOzUj7G8m0efRKTfof2a
         bbKZXTqhAKXwHqAul8u41L+26DaqB9kTamfgm8rYaMS0uU89dhCifhnj2p49wLyVZHuy
         hUwn9YDsbGhO8HfT0/esOlzFHDgC8M6CdkabH4My5/nnqZmsshnQUF+f0jAT7i0LYTll
         LDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777446013; x=1778050813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2+aKzcozrfPvAHDOI307L3sGfueBolTmIlF5K5tQEKM=;
        b=horqeVvFNbAcvX7woE+XASYNbUbsrMUbWvq+jCI+oULe6Zo9mS94aZpXxSb9nkEcei
         e9p2jAtxWDPGziJ32BF53CoE9ns6bAGfqRgG/Uxm3+UGx1xEcbAroThguz2b6xi0KYf8
         7iRRq4FyS9qN+lJbnDNHEnLOU/9m4S4vUOjX1jXNHxeGmpxUTFihpip6FiQWMbNqPjEe
         vR8nkOolwih2ykXgFi1koBZ6ZhUahXwcDeatit7nSVmaPGEGKSKUZ1RMAk7PcGC+iBMn
         HBlSEWR8ktZtRR9dZbQ9un0LeX6XJDjLQXuLUyLXwd82Q/xUo8TeE61raDMGbtM5DOdo
         Mr3g==
X-Gm-Message-State: AOJu0Yyz9g+5k6wSUsUOdR15CuZ2RujOvTTT7MoIDCV+yv4xVzy+RF3E
	Gf1EQ1XXAog4gylyqc4EGvzNsERpIFUhA4Ts3iaEKemcoK3FElrUGzuv8M8oLmeGLBwZqkmE
X-Gm-Gg: AeBDietyVZSHs6v3b6nHHPW9Q5cd+iiSrpcf/6lqsunAoa7EOyQLf9Ief5ThkWgNi8g
	ziO2H6vbtXzPnlmJ0IQHaWObdVSI6EXg+yh1wnJhAMMDdnTPfewh5J89/78Z2uk6mswwkkohjZy
	pzjvFIff0auSxYnVXNnukLjhU7RhiWW4xBKK7kpU5ohvNEFBxwJ4ofD3b9/muS/l1K5CV5Yglfq
	YEzdv/ywOMgFXjxeMEGyS5nlGCkhKFzDnXW4H1a7anRcXHBdZ7gm40z+MveKbVVT6od0FitjeLw
	oT/J53AXBFkyLI+/QoSCg30KwyPM9VOhXNPgnoc4EzFB6bCC9I4/Y+fV9m2QeT6ZCaa4RXdyEvS
	JW+i5JccnjeRPP07T+r2thI2JOWtlCI8iZD6ASyvNhpd5kP1rbqk3q8HV+ic2XCaC5rZZKIdIDN
	7OvhVI+bMzaFdXQQQ4GdSpbFcmlkQArL7r7CJLqVakppVSzaV+
X-Received: by 2002:a05:6a00:995:b0:82c:9fe1:aa4d with SMTP id d2e1a72fcca58-834ddb2d0d8mr6649550b3a.13.1777446012829;
        Wed, 29 Apr 2026 00:00:12 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7eaf93sm1043146b3a.40.2026.04.29.00.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 00:00:12 -0700 (PDT)
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
Subject: [PATCH 09/11] riscv: kdump: exclude no-dump reserved memory regions from vmcore
Date: Wed, 29 Apr 2026 14:58:29 +0800
Message-ID: <20260429065831.1510858-10-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429065831.1510858-1-chenwandun@lixiang.com>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_000014_580159_F9288C28 
X-CRM114-Status: GOOD (  10.75  )
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

Apply the same no-dump reserved memory filtering to RISC-V kdump as was
done for arm64. Use of_reserved_mem_exclude_no_dump() to drop flagged
regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_no_dump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 54e2d9552e93..012885ac9b79 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -10,6 +10,7 @@
 #include <linux/elf.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/libfdt.h>
 #include <linux/types.h>
 #include <linux/memblock.h>
@@ -63,6 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	nr_ranges = 1; /* For exclusion of crashkernel region */
 	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	nr_ranges += of_reserved_mem_no_dump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -76,6 +78,8 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (!ret)
+		ret = of_reserved_mem_exclude_no_dump(cmem);
 	if (!ret)
 		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
-- 
2.43.0


