Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F01ECD5BD2
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PmAA5z5t6XdNPHFYJxkTDYvo5Zq4DgJyNWi+6SrmBDo=; b=3X5RYaoTUTMdLFbGWPiEHwpPCU
	2OrvE0Rxk87g/kry+SR0TX2g2vLIr7iXy1f3zfU0Zp61dTM8GqStn1AnLV5AiEbAwMQconArm41w3
	Ay5OHfnsWZhR+NUvDRqN6bopScpK8pdZ0fmJRdmAuc3zjZSpVdXW/GQcrtq2Tl1jtrNMLV8jAnkXG
	+jjgQby6L/QvhLolcU9oXosgrxdtAEA3ZEpP1uLjAWD7iXn53iO5hcOcfcpj7674AfsGIom4AEFH7
	pwGht37KTTL81vQlLRgwNnMqr2rkp41csULL0Xo/obXpYMA5ahOzyujrqV9RVWQNigKT5pL8D5DT3
	lvdIi8lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4yG-00000003Ew0-0u6f;
	Wed, 27 May 2026 03:30:16 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4yD-00000003EsI-2R1U
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:30:14 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so5657236b3a.3
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852613; x=1780457413; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmAA5z5t6XdNPHFYJxkTDYvo5Zq4DgJyNWi+6SrmBDo=;
        b=Nvpb4OiQWFRiw+DRbtPTduevhZTJBs4DFUgMWvYx1xSQ8X8ssT3gDxyVjvZSlUIeFj
         dERvAJs/jAGhmLbE5QvCmTEYoHy6fkIdSjmC2uSffKT+i61e0rwD+6D1TvJ45WNQ6Vru
         YbH8UuSPLwyyw0jIRbvaWd2xOvX1rEsj5Xv6pWxPO3GqFF2z5Axw05wa6D8+i5aWJY7J
         Fvk/fv44Fv8/Cm43cHlrjHfkbKT+Xbc/itho0s/D+zzr9q+g8wlab4CknYCaLEXlegRn
         ZIXHYpWoMO86LQ8OKJ7/tYATSmPbXQ0p+shpfUpar7nO3SLKqaASrbm+LgVGmmOoa5dB
         76Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852613; x=1780457413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PmAA5z5t6XdNPHFYJxkTDYvo5Zq4DgJyNWi+6SrmBDo=;
        b=UwN/TQJBTitYvpi8VHfas0DjKziRwcmyp02XPsH8IfO3Dsq1ZRpVnoOK3UBnfrzjGE
         CIkPkBK8OOJga6H7Vhp1gve91P+DTNzmj0RBpI9xHA4xzdnqfVy3fsWdTpbZyViuGetM
         cCOKWbmv7m0+2wTOIpi+YNUe59fZ/MpBFr7NxlmREN5w362abYM5wa0hXb63oVSjjCRS
         7cuY2I4Ddc84+4mywRS5rZSFKHFFo4f5/a2/RCQn+QhucT7QN7Y7cQrpNJzbhD1GeN7s
         7mv8cRudhbKKB8cKZY3MrqLwVhpUOHlQxjMj3KtmcNfldrj7ZtmR7zye1DU2HqdPqT1B
         a5Fw==
X-Forwarded-Encrypted: i=1; AFNElJ8y7FCx+Xe9IB0gxF+tpDXYi5qo1ktnDO0Wck1IR0X25yGvL2HuuVNXUMmxKFEIy2QT7qqgdg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwS4eDpSl86wmmJaZM9zuqSferXOxv1loy1shZMZBY1hcmYs7Q7
	KNiQtRNLL9TaHcJVakHyp2zAPIkbPyoEaheWrnbxjzATrYzIMsmK4YNE
X-Gm-Gg: Acq92OEtSwTUT37KvziWHbCz4lEQRYn3VJlWVh2/5yYmpYDRGurYY7J7z+QObAWZqLP
	tmOAoGj8cNNDllClIEDXtYMYRvny7zhxpwHv78d5l6JihkSi/dfCzNCjcsziZVzqQOUIe9yjlNO
	hL5K6gBl+5N3EQ9gX8Ema2BFLJ05nVEqikX1JHSVm/7tbILqykbn5PigFVIN7GY55PXF+z9qCXj
	Ag3OumdDhVKK0Xxel1RfbseKe4RFdPFJQpbBvqX6pU7eAnqxPWth3KbiKQxqB8fY45sC7SCZDnW
	NtndQOk+a7q/4v/QGn7jRcXaNnvXhrZaSrJaswyBW9R+6M+Mu5S1fUl7K7NW5YVytQHjJpFYJtT
	NEQSkDXeR0f82As8RGMLr/ME/WV398FBmqN+F8o6LCuj/sNN2pKK6VtzYwBr6RgUjFa3sILYtnr
	6t5tNvl4YxjzqnSKHuS3foTb3ThYcjwmP8fw6x+QKMS5c5zqg=
X-Received: by 2002:a05:6a00:1407:b0:838:c01a:7a50 with SMTP id d2e1a72fcca58-8415f406e6emr20083726b3a.30.1779852612592;
        Tue, 26 May 2026 20:30:12 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:30:12 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 04/11] of: reserved_mem: zero total_reserved_mem_cnt if no valid /reserved-memory entry
Date: Wed, 27 May 2026 11:29:10 +0800
Message-ID: <20260527032917.3385849-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_203013_626931_7777133F 
X-CRM114-Status: GOOD (  12.43  )
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

Prepare for storing /memreserve/ entries in the reserved_mem array.
Zero total_reserved_mem_cnt if no valid /reserved-memory entry,
instead of keeping it's initial value of MAX_RESERVED_REGIONS, this
allows accounting /memreserve entries based on total_reserved_mem_cnt
in a follow-up patch.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 6d479381ff1f..05defc91e901 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -329,11 +329,14 @@ int __init fdt_scan_reserved_mem(void)
 	const void *fdt = initial_boot_params;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
-	if (node < 0)
+	if (node < 0) {
+		total_reserved_mem_cnt = 0;
 		return -ENODEV;
+	}
 
 	if (__reserved_mem_check_root(node) != 0) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		total_reserved_mem_cnt = 0;
 		return -EINVAL;
 	}
 
-- 
2.43.0


