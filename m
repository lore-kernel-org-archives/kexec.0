Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD70CCD1A2
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LoyvQzRCTzprsdoa9de6pcDb3TonO2UXL3yb3ppQp48=; b=sZ0cIWtq+tyEI0iKX2YW1ye+QS
	a1Y6/3Gw7dHjqJpCXeBueMq3c83ctmSR3vjun8czzgKrqQA6WeQwFVVWKHsvndiyvULsfbAePV/k0
	QdnSma3MidP1En9iHdWLvqBQAe8SYFFazFnh+qxwUbSEE1PKjWh+iFbbBFJwRBEJx7ibpSqxSZnN3
	GaJnZJjEHWZ86ley3hNP/VRjM8/ddaB2x3DIkhC7FNHAEUhNEEA1suSwUyW7UYjk13wH7t9kYRsTj
	XTVjHtjFgQuK+Ic32lgM0M63qGSC8hSmkxQAamhBUf+D3bxjXWThE6FIWKxB6IuDJL8gRmCqdltB2
	s7YMb6WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIx-0000000FAuz-3twI;
	Mon, 20 Oct 2025 22:24:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIv-0000000FAu0-2CBS
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:24:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoyvQzRCTzprsdoa9de6pcDb3TonO2UXL3yb3ppQp48=;
	b=Q/mp1Ol/sItbmp8OFX8j418TWipvBmHxB+iBWlh4hawDARPR/748/TWj35HY8s92f14fvt
	bA1FeIYfrnGu3nuGwALNifRHRxo/fwraghD8mumYI5MmQtubhRCTFIy6fsLSQTYmfSBFQi
	DBJ7lMqsHFuFRoOG+P9NIfpBnHt5fjY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-IZE0PdegOpWKiKXGXeZFCA-1; Mon, 20 Oct 2025 18:24:34 -0400
X-MC-Unique: IZE0PdegOpWKiKXGXeZFCA-1
X-Mimecast-MFC-AGG-ID: IZE0PdegOpWKiKXGXeZFCA_1760999073
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630753cc38so8712947a12.1
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999073; x=1761603873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoyvQzRCTzprsdoa9de6pcDb3TonO2UXL3yb3ppQp48=;
        b=gannlEe7EUxnMgH9kS5icJEnkfubtXHv0oHgs//GIjXc6PxaSSQFXt4O+FlYaf5wM+
         7T+jVbLt+qeqpGnKJlV+CTnBHMxOQnqZIsEe6G4XnvVgFV2YP790972xw99+FPmzDz/F
         OoKGuuIsAob6j920SSDinV4YS5Rk4PeQDzkHDHrRWbQnatyiKtsHHuketgyI0oSlQyMr
         rAMfzDvu0CLJhlpoFgMAot8NHlPUclLSPYBoW0pK209Yl3yAS5zKddrSZOuIaU1T3EBX
         BgZa3gHbmZMt8GN6NFPzZLYlHqX/cWI3oVEih1gbGCI9ymK30Vdv+tapy5FjcqXi51wX
         E1cA==
X-Forwarded-Encrypted: i=1; AJvYcCU/xrI9WcCVm5SufIFx0oL9v5gC8JfdKc970KOYkMXxskqOW3aNow4esahJbYsyNQcrtkOruQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxBEr0q0O6Md9u4MfSItufASVeqPRfcwcmLbHeafmWiTEgxK1/d
	49aGdmuHz52Ouhb2FUuE+LH/lD+lVvHQrW1EVu3ZIjdd5SiPZJT+904SkD9gXDkutVy0n998xhU
	7Vs/U7MLuLk0LcOtKYbtr816hEhhknpZrsChv69dd64oMkmkjoiwqNFYCGkRGiQ==
X-Gm-Gg: ASbGnctEzOLAh3W2qz8tonyZvkTLyGDie+qTcJagf1Jip/qXCU2t6/hEGZy8krFEXFB
	Mfm6J8CwEXS2zE5O5zmVimo308waGzs0KkxzIJyYD5v/xakvMDB1UdrYqzKcDmNGjX7QbbF8REz
	s/ZzYDlkKB3G+EFxlIK7OaxiGVIeiXkpFr2x9Xd2Dt7QX81oSYhbDN9iH/OEouiZu2H/feZd5ZP
	ICKo3gX/A/8b7FoJM+xEPVbxOgvFSswj0IIQJZ8ZTNWpBPx232s9e/V4p8FfDCN5MD5BAklLdVs
	QwmDwPMAp+pS8os9a4cRcjorrbKnq3f2IXbflnGvWqZMcuaKy442bG0ikJPD9MYb69Ll/OpzOiB
	vRkyQwb6ll3hotE8ytfDg+ephueqnOTbnjvHB/WOFF4w=
X-Received: by 2002:a05:6a21:6da8:b0:309:48d8:cf31 with SMTP id adf61e73a8af0-334a858f4bbmr18576337637.32.1760999073429;
        Mon, 20 Oct 2025 15:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtsXZLGrhfADndtV6/y2FvO3W3SCkrY6AAeJKiGZ3xT1QpGje8ge2T2+y9A2qYwWsVbisBnw==
X-Received: by 2002:a05:6a21:6da8:b0:309:48d8:cf31 with SMTP id adf61e73a8af0-334a858f4bbmr18576321637.32.1760999073137;
        Mon, 20 Oct 2025 15:24:33 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:32 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 04/14] dwarf_info: Fix a infinite recursion bug for rust symbols
Date: Tue, 21 Oct 2025 11:24:00 +1300
Message-ID: <20251020222410.8235-5-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tfaCW-eUeUI4A5-MEsYemXqFGH1vT5BjKJ_eZ5JqHOE_1760999073
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152437_637092_8166B1FC 
X-CRM114-Status: GOOD (  10.21  )
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

There is an infinite recursion bug noticed in rust symbols. The root cause is
unclear to me. This patch will avoid the bug by skip the rust
CompileUnits, since currently we don't need to deal with rust symbols.

Signed-off-by: Tao Liu <ltao@redhat.com>
Suggested-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
 dwarf_info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/dwarf_info.c b/dwarf_info.c
index a3a2fd6..14cf7ca 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -1007,6 +1007,13 @@ get_debug_info(void)
 			ERRMSG("Can't get CU die.\n");
 			goto out;
 		}
+
+		/* NOTE: currently Rust is not supported. */
+		if (dwarf_srclang(&cu_die) == DW_LANG_Rust) {
+			off = next_off;
+			continue;
+		}
+
 		search_die_tree(&cu_die, &found);
 		if (found)
 			break;
-- 
2.47.0


