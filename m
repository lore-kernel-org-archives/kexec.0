Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B4CFA374F
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yBZj2F93B0VknEVYf7xGk1WgByUhBAGZQZsBhmv5asg=; b=Xq00kPtTDts8/Y0kZoDkI/B9xw
	15rtEbouEELHxea3JafKXxW6evJhs4HU2wl3DEYENVgZMjksRGp67Rr/MjM8u8LLg+KxldOVk6sOZ
	3qf7sd4Mx4KeMqEZiLAJeCxYnfvA4A8xCWEpUTathH/kFpqxDzwOijniogiqNMUHO7TKwNJpwrFJE
	rlY3NsTJh8rPMQYdNkemA0tT4M5AvdWrelp7s8X1aIJvVaEOprRWD3lINLyRBoPES6Q2975zHzsKr
	ayVHtbFRgcurcUsvHzdbV2vYT60vMr9hkyWYa0rS4YozV+5isuP7Ajnsmkx0xE+g0KsFfalvf7E7D
	Rbo8Lv9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgXD-00000008OIx-3C9H;
	Fri, 02 Jan 2026 14:53:47 +0000
Received: from mail-oa1-f52.google.com ([209.85.160.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgXB-00000008OI0-16Pc
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 14:53:46 +0000
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e89d226c3aso9523414fac.2
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 06:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767365624; x=1767970424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBZj2F93B0VknEVYf7xGk1WgByUhBAGZQZsBhmv5asg=;
        b=APo6CjwU5irgT4Xaf4JeySInHD+/Sn/IvNPZx3d5OTRZDfkYcvrgmU+zCnBxxVEEa1
         3zz52Z+otGSYQXTv513T2aWwXmXThbIe+i2uFDmID6rzm2ZL4o7eub1i2ln46t8hJJVD
         9ScOEWFJ6vX0EJp9EoAjqZ4NmjdtRqrq6xuMtnn2DWjKPkIIw3D8LW23UgjVvpxL1FKG
         T62W3E+8oKXaW341Ug0mdri2c5NgMctEF4KDQf0JdD3Vvcx2aNgh65TD4X85yXPV1WMA
         vo7deH1cYddb5qU0cK7vqF51npmGwR5/YFBTZ0sbYxuqtOpF5CFUvwTsSYm3gm7C0rvU
         I/xg==
X-Forwarded-Encrypted: i=1; AJvYcCXEPaoVwDjpsEZONoSl9ca8z2e8c1zuuNydWtBfD93mJ82MODvg97dV+7vncHqtCmTGRDUSzg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxjcjtoCJ/B46Oz+CGGWBgxViRCbjDkGXQVlUCp0qArPIpUPzf3
	C07xlNoEXBZxg0QuvUsuAzrqev4Hlfzdh8IFPGCR4pczd8FHhvMTPDNb
X-Gm-Gg: AY/fxX7jDgcjdDNFud3FImeBTpgXSPtWFWQFpv3Kbe+SB8Mcl6KDcMICONiVRJWn+ZT
	Wf/53u1A0d6P8d7i++wSmwLc0v2sK3RGDBf3gexIyc78ofUrCaJOWjDiX74Ds4J6Mjx2j9toNk4
	EE+pQJBIjV1XDkk7EMxr2cuk7aF9dAy9BPe5V2xduuYgId5JMtCQCvLbmyYaKXhfFDJHG913Nxd
	vLSIlviemJn61ZbD0tvlQf9ethSxEof+4ZFwwaa5J8BjMTsjRH5IUvaD2RlRBhqF9Prb6A4ml97
	rT3m45OWJVKObJHpaPVd3zqYZ9a+ST3S33zaKvidk8JSfJuBtgYI/Bj4Gec9GT/J8tC+hjYOFCN
	J0gqcvPP8RFOQaw34HwqxlzNbMZBnHlbv0Iz6Il+7ZUMogO1SLCr5X5S2bG2v4eZ9seN9FLumpr
	FxdQPHV9xqHxMmig==
X-Google-Smtp-Source: AGHT+IFOaVirBFIVBZXp+VZPeHS4wt8YP6E5VjPc88CEkvgr+k+wnwNlOhaQTCbgaVjjYSCBS7oZqQ==
X-Received: by 2002:a05:6871:3607:b0:3f5:4172:17 with SMTP id 586e51a60fabf-3fda5481b05mr24323475fac.56.1767365623867;
        Fri, 02 Jan 2026 06:53:43 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaac145bcsm23292303fac.22.2026.01.02.06.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:53:43 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 02 Jan 2026 06:53:23 -0800
Subject: [PATCH v2 1/2] kexec: history: track previous kernel version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-kho-v2-1-1747b1a3a1d6@debian.org>
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
In-Reply-To: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3988; i=leitao@debian.org;
 h=from:subject:message-id; bh=wkabXvOflaMtjicTrJd388Qj/w3vpwAMxUhL5Eu01do=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpV9v1U6zJLO/ry+WPczyFJZR1wa6NiK54DUKmT
 /oKNSxUEUWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVfb9QAKCRA1o5Of/Hh3
 bRJyD/4sYGh1GsPWiH6s8aw30fI88MqDBiSHTaYzpuOZCJMhkh1im4Uqn0+m95TXj5JEClEJV8d
 gIardAHHIJ8vnaLCm2ex+aTkT3SWIUoHp74QgDp0VtP6QHqbsp+RK+cCyNokL89rWx2/RsJfwzp
 n1Hoc5m1P4F8MJjksTjNdceX2C1zrJ8iLlzjnlUiTDQKZQng+7nJz2LhzeoXFLU9PqW0kJ5Vhtp
 epab9wfi+G4uEFf4GCU2h5xLiBBenVW/woOk6XXfMSi8QchtXwx/6qQ3LBKNZX0xHEQkOO9GUrl
 WkYdO3KVJ1x6joMJcins4nEPiantJViFgi4EW22q8TcuMTAQZZZCDdlJI2fBTm3+g1XboDOjZSh
 8bA2PBGH2BnpccZffEraNywxbyK3hROLRsxrKvcJw+vDHnLRk7pU24j/tVPwUEw/v+ca+qC4gMO
 xOQjHJc7sv6QO1+ug+/gys3oM8FU6KpKiV2yHoxrLgv1FEx1wT5VTbCX4lA6ncA20QFfwDYFgdf
 b7yptHQN0RsyLF6WC/YxU0snOsIO95kx/E54y6SRO8lJuLp15Vh8pvD+ni/uRYUSYRX3/I5W179
 JM9EXTiuctOk+dk78FPHuCWSXV5kV0wA0tmuHpnz7xgj/09oQNH7pZJ9bJC59NEi7/Wihbbx8lA
 5iKY0CP3fzn2maw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_065345_309545_7AAF3B8B 
X-CRM114-Status: GOOD (  17.16  )
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

Add CONFIG_KEXEC_HISTORY to store and display the kernel version from
the previous kexec boot.

When enabled, the current kernel's release string is saved to the
"previous-release" property in the KHO device tree before kexec. On
the next boot, if this property exists, the previous kernel version
is retrieved and printed during early boot.

This helps diagnose bugs that only manifest when kexecing from
specific kernel versions, making it easier to correlate crashes with
the kernel that initiated the kexec.

Disabled by default to avoid overhead for users who don't need this
information.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/Kconfig.kexec               | 13 +++++++++++++
 kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..b770c68a3800 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -94,6 +94,19 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
+config KEXEC_HISTORY
+	bool "Track kexec kernel history"
+	depends on KEXEC_HANDOVER
+	help
+	  When enabled, the kernel will store its release version in the
+	  KHO FDT before kexec, and the newly booted kernel will read and
+	  print this information during early boot.
+
+	  This is useful for debugging and auditing to know which kernel
+	  version performed the kexec that booted the current kernel.
+
+	  If unsure, say N.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 73da00aeaa99..06d99627bb3c 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -21,6 +21,7 @@
 #include <linux/page-isolation.h>
 #include <linux/unaligned.h>
 #include <linux/vmalloc.h>
+#include <linux/utsname.h>
 
 #include <asm/early_ioremap.h>
 
@@ -36,6 +37,7 @@
 #define KHO_FDT_COMPATIBLE "kho-v1"
 #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
 #define PROP_SUB_FDT "fdt"
+#define PROP_PREVIOUS_RELEASE "previous-release"
 
 #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
 
@@ -1253,6 +1255,9 @@ bool kho_finalized(void)
 struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
+#ifdef CONFIG_KEXEC_HISTORY
+	char previous_release[__NEW_UTS_LEN + 1];
+#endif
 	struct kho_debugfs dbg;
 };
 
@@ -1332,6 +1337,10 @@ static __init int kho_out_fdt_setup(void)
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
 	err |= fdt_property(root, PROP_PRESERVED_MEMORY_MAP, &empty_mem_map,
 			    sizeof(empty_mem_map));
+#ifdef CONFIG_KEXEC_HISTORY
+	err |= fdt_property_string(root, PROP_PREVIOUS_RELEASE,
+				   init_uts_ns.name.release);
+#endif
 	err |= fdt_end_node(root);
 	err |= fdt_finish(root);
 
@@ -1455,6 +1464,25 @@ void __init kho_memory_init(void)
 	}
 }
 
+#ifdef CONFIG_KEXEC_HISTORY
+static void __init kho_print_previous_kernel(const void *fdt)
+{
+	const char *prev_release;
+	int len;
+
+	prev_release = fdt_getprop(fdt, 0, PROP_PREVIOUS_RELEASE, &len);
+	if (!prev_release || len <= 0)
+		return;
+
+	strscpy(kho_in.previous_release, prev_release,
+		sizeof(kho_in.previous_release));
+	pr_info("This kernel was kexec'ed from kernel release: %s\n",
+		kho_in.previous_release);
+}
+#else
+static void __init kho_print_previous_kernel(const void *fdt) { }
+#endif
+
 void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 			 phys_addr_t scratch_phys, u64 scratch_len)
 {
@@ -1527,6 +1555,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_in.scratch_phys = scratch_phys;
 	kho_scratch_cnt = scratch_cnt;
 	pr_info("found kexec handover data.\n");
+	kho_print_previous_kernel(fdt);
 
 out:
 	if (fdt)

-- 
2.47.3


