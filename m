Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53059C61DD6
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 07:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c+6c1mxNeRcK5OGJwTOV8Umz+CvUvEErlItanMxKc4I=; b=zpl9T5XAUpKa6439Ckz44aqx0B
	AVf+z+8psNoXxmq2JQqrLY4nOcS0T5fEtk8lh0iWMc+PSzsgDiw9cSjKy2hg+K1g9PPlgGZH0miSP
	f8fK6Dm98GlQTucNw7tC4IXno8GU9QOYmoYH1wiRP6/L8RaxUJhWXtfF9dkD+RIgulhd55NKUFZuN
	xFB74rKCbEIEoRNuMvclIfAx0dlyWthHGEw8y4jR4rrs92uDuJ8HAyjHJQyojeStLeKf8X2jEkjTa
	34YNg5C5wbl6IisC6Rp4z1HGG7+uCJC17LC5Ou6h0yjQqQTeaI230tteyD8jAFe1ZbnRDWXsNLYBM
	L1LH7MUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fTF-0000000Dwmk-0gB5;
	Wed, 02 Sep 2026 07:33:21 +0000
Received: from mail-pz2-x0b.google.com ([2607:f8b0:4864:3b::b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fSx-0000000DwcW-1SSS
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 07:33:13 +0000
Received: by mail-pz2-x0b.google.com with SMTP id 41be03b00d2f7-cc1cb94b583so255038a12.0
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334383; x=1788939183; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+6c1mxNeRcK5OGJwTOV8Umz+CvUvEErlItanMxKc4I=;
        b=DbtCKXYySsdTJ1s9ojiPhwH28F16Ysh4gI0by2+TjTT9dgG0/opWYpo0CTZvCPiUfS
         sMrHO5C6pQJFWdTkpt0Z6IDN0TX0AD+n/r1aw1lUSKUH3Uq0dxF0QJKHErz7l+ZICa8z
         9j/YBotLKQflAiemzuh7TcNJF9gRrXtgmCTl0iJyZQnNC/3UCZ/akjdCagk/fWgTq8ol
         clUWEsK/amDzR/Vu+9FO0A4hRTU2ky1yOQGRCs99adB7nP+jlmjJuDA4GxiOUOFcTJ5p
         VIQ4HSAhFOYDx+DZORJXnaSIOZiHbC3/PYwhGgmCTsKa53o08Z9ULaY0RCLmKIJjGgiu
         hX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334383; x=1788939183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c+6c1mxNeRcK5OGJwTOV8Umz+CvUvEErlItanMxKc4I=;
        b=SnQ1tBrmi4eQKkI8xYK9m6/JItLSBp6kXo15eFhXUn+i95enUoMTT3pltvuqdKtt7K
         rtMfRtDXrqARAsNL3SfFvCsvjWsxW0N8uOpMmd/tL0OPlK3OSKb+L2rUO/uaTaQbgsiZ
         HN/epWpB2g2i2CJ47tPO0TxUqerRbiV8xYDdGJSRiKAtnmXFlsrd7D8Hhh68oKxQcqAF
         Anv+9DAVMrLkrjXmg7gjhnFMIVOUsPdhjJGt6t8tdVZGInLxEcyhba7TLGnbUmA/gXd7
         HH24mIic0gJjECLZiPPaRevemw2MoZLNzpeRLacXJVsO5dnYRKTyqiazI88bemtE40H8
         Q14A==
X-Forwarded-Encrypted: i=1; AKwUvBwCKoQPTYM8UgjbX77HV4U0OfufGovq+cePoCxzucXEUgI7jFkUBQ/nrYz0tRr5EWy4XDA5QQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nEC/VlRHH7SBIiFN+Dc4Lf3+xcv05pTS3Ymg3sRb6jmH3tVvP9
	5Ki6WuEVfKAJxYqJe+6VW/dyVzfVr1Un3YGcZ5duVDlglyKGJ7e8Pb9z
X-Gm-Gg: AYBFou071F/eHGaZBsNdbYC+eZhkqJpBdEGjgeIcfQg5Ssx8iiaB41nzRfw7459U31d
	/O88S4yzNI5bElaceD4KxTiSZPRi/NCRJ+Cat7BcNPUXWi0NC1CfHjSZcSfd+G/XFvlrQx1c/eg
	2EuYO7cvLrJ1KM31eQfaSjwWCqI3tbEVxlcZKQ0foArWvZQ2bjrDycbsp9BMZpU4u6rPRuohOIb
	FGerbl0mnmcDE9nNhNX0XdvmQquTBT735pzbEBbZ+L34bXiTMe8V9FWNfXHRTSGgma6j9RbGO+V
	zcR0oVeyLSuZJvRzfk9Zadz9Gzp/frvQNNCsMDnyTKdw/g+6cuE2+PKtHUR9LjNg+DhKyxD1adz
	77naN8fY2hRZH2ztJP9twiPE2tJHWotXv670cdEsqzJoZk8zDP/Vyj5ba6AZ1K9TYqGkpGjrNJM
	826titDamVdKphaLDA5WiJZusNNz7tIJNnvOY4jWQ1y7RdBqwtcumJXB+9iDNrp+RKZ6wOYntL
X-Received: by 2002:a05:6a00:330a:b0:857:74ae:ad76 with SMTP id d2e1a72fcca58-85ed4e09b6fmr5077449b3a.26.1788334382541;
        Wed, 02 Sep 2026 00:33:02 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:33:02 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com
Cc: mark.rutland@arm.com,
	kernel@xen0n.name,
	alex@ghiti.fr,
	hpa@zytor.com,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v6 07/10] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Wed,  2 Sep 2026 15:31:13 +0800
Message-ID: <20260902073116.802752-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_003304_394105_77A99491 
X-CRM114-Status: GOOD (  13.49  )
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

From: Wandun Chen <chenwandun@lixiang.com>

Add a 'dumpable' flag to struct reserved_mem to decide whether a
reserved area should be included in the kdump vmcore. Non-dumpable
regions are later marked MEMBLOCK_NODUMP;the filtering itself happens
in memblock, keeping the arch kdump code independent of the DT API.

Most reserved regions are owned by devices and do not contain data
useful for kernel crash analysis, so dumpable default to false.
Reusable CMA regions are different: their pages are handed back to the
buddy allocator and may contain key data for crash analysis, so set
dumpable to true in rmem_cma_setup().

The dumpable flag is also used to check /memreserve/ entries for overlap
with other dumpable regions.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 49da515859f2..99c0f3ccc297 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -15,6 +15,7 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+	bool				dumpable;
 };
 
 struct reserved_mem_ops {
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 66093460584e..caa6a5c66bd0 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -567,6 +567,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0


