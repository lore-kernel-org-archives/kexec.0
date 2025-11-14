Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659EFCE8D6F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MRhbySqLkOs1S7yd4SZQFQOHiDhSCvUI44/bvvGGGJM=; b=yRlOE3eehVx7CzkWtqNAKSJVHc
	ucVtDii1VhzYbcWe9NxSkcmpbMWnAzVS/mZtUOMAeUrx6VV5/T+RGxrSnkrgoimMXmbojtiL2D3qg
	LsvnlDjiZPDNyFJcTN+SVf6Uu0MN6tqdjgulSQcrUIm2LE2RBV7Cb6qLxk+VWqfQSMmtnIosn2ke1
	9msWQ1PlLs4BgSJTJf8RZpE5u49yKygMjbva09ENC+7tXYxrTGNpGBQqizGBqlm+ffywm5rBzGQv4
	9yYlCtvUj8e1mE+4dd0haAxnsSdbzc+uanBli0tl6zuH8oDy8y8k2K8jBn+obTsn7dby3nkpj+24T
	P95xBkcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1p-0000000CzLn-3FsW;
	Fri, 14 Nov 2025 19:00:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1p-0000000CzKZ-1DpU
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 19:00:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=MRhbySqLkOs1S7yd4SZQFQOHiDhSCvUI44/bvvGGGJM=; b=qT6Yc2X0cvmLDDIv4pSHyjXPnw
	hPK/Uom1gZDn+bOTzjtwojKk/2gH/O8XTkXr0cdntjP1Xkm/L8SlIeGNNCCGJAkNQmfsN3fbg8QZs
	bQuyqkUYXQnNUzqZ61/mrjRzcbKTLItSbu1YgsmsZmkSLQUiaJLrPSqCBwVIUBwqhn2jdW1xtZjeV
	NMqgjyaW6VdhVjJXU/JuAoNmaHWfqWUIuVN/VXtPmt8H8sIOEfBk2mjlepnqpsxiNuy6sdILPFzuk
	bkQEzD7PKZ4/dStzooxbNIOzdp3TCSZ12yXqANCrAcBJ/UIzHok6Lw83DXYaNxarOJhMase9Gq397
	+M5F4OHg==;
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJyA7-00000003Jmf-3Jbh
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 18:04:45 +0000
Received: by mail-yx1-xb136.google.com with SMTP id 956f58d0204a3-640d0895d7cso2967230d50.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146808; x=1763751608; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRhbySqLkOs1S7yd4SZQFQOHiDhSCvUI44/bvvGGGJM=;
        b=TDJ5pKdTLvLN4b/tfNB50Zr9qExxJqT04JKZf5vgXNIoTk1jxZCLuQ9TZqXzo0V1dD
         pCXI7IGqxVoez7Hct0QRlyYrRhskE5SRruC1DRmMTd6p1YZcRRKLhHnwrF/W0mdDLyrj
         tO+PkYnB6CZPgA906XhysXQ6y1uJ0KnBP33DdPLjHPa/gKDXgCIE8p30RbqgJjQSIucg
         6Iv7yeWFnrS4/ikrp245nxUP9t47wvL5KsiGnJXk+C+bSCOWX+EcORzpefFVoF2uy5qM
         RpzbIlLPoHR/Yae6h/yVDxvEqGgk4IE+rI9aMmK4J8vSBxnp9L8zEZorMQ+BeNvrE5cQ
         w0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146808; x=1763751608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MRhbySqLkOs1S7yd4SZQFQOHiDhSCvUI44/bvvGGGJM=;
        b=RIjWmdQGEiwfRYsu27Xf9n8lcpm4L/5A5eAmhFlXHV1isTvEeKUMYBtG2eKzwtD1zM
         1qYyZUj93QsaRRmmZUrmEE/jDG2dMHZISeB2N94/jauKoKBuCVdj/iapqh0rYdstLplX
         ZZiXF/04aLohPswV+adPNDEzN6+zfyw7Rwbdj5qO11l6wKBbjaGA/EDttoc1mWJfJ5sY
         cjmQyA9QzPhOB2v0iy8ZmFTpmlbhRDS9o2bPprC1DA0my1VMUGFkkuAoIYDN4EMn0g/i
         Iol68207u5GfWADyqMW5NtiodiWm/qtkoAKZM7fyvhDwCrvORnJAftIesp142k5HTPHa
         EDPg==
X-Forwarded-Encrypted: i=1; AJvYcCVhLgYg5cNiYwa5B3Pku4rdORW3vycLzS7JGWCLZV1xTpTdTJel9nOUcTVeB7I6Y7E5Fp81Aw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzmFLdjVtfZXrBDDwyqXlDXbe+Ie0lLADIlTJ+y7bQJo6BjnFM5
	s9ErFU37g+zGBAURU2vSwa8roEYHVGaEW/Oo9UTGpUS92PH0fQgmmneeqX8s+8fFarI=
X-Gm-Gg: ASbGncs4ZFkxi+kMRE2WfUpW/fgwlyFHAnVtksQlZusDDEpYEnUom9rqYVShmXUaLxY
	t5piNmXuCqRoM2o8cbIhHXc6TCaLN/h/WsqVEOl3Hv4lQ8TdNAuzK8VH64znUjx75AVjyf6upvl
	P2woNO/LsiEDVDnvuJK95r2/l4YhpUedIhFWxhVIwtpnsQdlKmXgRPoEDZqPD44enP8hsmUKg/E
	iMOTt0+17m8vIAcNAusC6Sq2ew3FpVVUrxZgx9O8UPFwnA0b01wJXCWV2Bc0g45hecAI8NNtLYW
	Z7sX8TX6aZ+Qa2ylAFDUux7Q0B+fdZ4w+lz5VqIHDCpvugdktNXI5AomX0iCz2RxgArQQE72eE+
	s6BFHRzzDWmnkfqTkzC0rzueGghofbBJJ3o9nmfbVIRbCd7PwlMLoBcDVGBgTyU6HNl/4+OYS8L
	tu15yABOOnqv6u6TL49jstR13e4e2hWY2/awtVRTERkUygIhR0lNwjRids8SSK6SqZKlQdcqlDt
	SFcE7c=
X-Google-Smtp-Source: AGHT+IFRipa5kdjo6USd5eBEs8ufSqG98/LGRDsWM12ipJewFI9gcyDDCxwJYHschZedkB4cInZt7g==
X-Received: by 2002:a53:d013:0:b0:63f:b61a:71fb with SMTP id 956f58d0204a3-641e6d71af4mr3935840d50.3.1763146808367;
        Fri, 14 Nov 2025 11:00:08 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:07 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 01/13] kho: Fix misleading log message in kho_populate()
Date: Fri, 14 Nov 2025 13:59:50 -0500
Message-ID: <20251114190002.3311679-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_180443_950680_DA9F4A06 
X-CRM114-Status: GOOD (  10.35  )
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

The log message in kho_populate() currently states "Will skip init for
some devices". This implies that Kexec Handover always involves
skipping device initialization.

However, KHO is a generic mechanism used to preserve kernel memory across
reboot for various purposes, such as memfd, telemetry, or reserve_mem.
Skipping device initialization is a specific property of live update
drivers using KHO, not a property of the mechanism itself.

Remove the misleading suffix to accurately reflect the generic nature of
KHO discovery.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9f0913e101be..6ad45e12f53b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1470,7 +1470,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_in.fdt_phys = fdt_phys;
 	kho_in.scratch_phys = scratch_phys;
 	kho_scratch_cnt = scratch_cnt;
-	pr_info("found kexec handover data. Will skip init for some devices\n");
+	pr_info("found kexec handover data.\n");
 
 out:
 	if (fdt)
-- 
2.52.0.rc1.455.g30608eb744-goog


