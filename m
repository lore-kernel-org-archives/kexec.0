Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393DBCA5FC5
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 00:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YTQtDRZE6hbaSqiCeRYm1Tiy2pek4MhmDBkS+QhXVW0=; b=CVobFht8xC+XmHGqgnfxU0TTFj
	qKGhNA/Tfbk6xEX1kIgFViOzjVZX8yykFWkj5BHSsWEhKTqPZanH7WH5oW7kT9vTL0QuZjiHp/13a
	dEiyIc4aGks/df3xd6AKMtnrk+zVFPa72YJI5SecIKP0k04k3qd9ESxgz2W/2VfcQsEQHFPd60p/u
	V62BXhgNtP13qz79+50RS2PldDKbw3TRvG+w+FNZn8SRx+vR7zi+KhcIfY38tAI5nA+3Lo2G14bMN
	0o8pS5ed2uATkRlqbAnoNPyAni4pyqt1BJL2njxfqRX2N0zQBgDyRwpZTt3qXiJFTS+bc83WoTHev
	dkE0LArA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57N-00000007XHg-0Okh;
	Thu, 01 Oct 2026 00:57:49 +0000
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57K-00000007XFJ-0tMF
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 00:57:47 +0000
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so13718101a91.0
        for <kexec@lists.infradead.org>; Wed, 30 Sep 2026 17:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790816264; x=1791421064; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTQtDRZE6hbaSqiCeRYm1Tiy2pek4MhmDBkS+QhXVW0=;
        b=Bb9ei3FyjCHLgwmN9s7NVwtqR3l/WKu6/ohaTUhDHAF7zZ/qIZTuQMyK1ooHv4iJk8
         BeNwmj2o/9UKNXFCMKyTNkXJIe2k8NQgITpWLTaI2bwS7RVd2cAUt1oaOgOD00jHCK5b
         DPi368lfY8l9zEntJAVVKe31neK5SUBvGOkqtnwjcqvbolLFDibojVLyemQMXWHIQScn
         9B3WFpQzbt48A/nyAc1cOzx/hREyHzMwUwAQF5IEPzCbd1pMR6mRKer0/plix5Bx5sMx
         U7lm5B/fvj1RfnA3eanMEu4h6NdlF1w2Ekjgz0XtJOlSk/HwXZXQemvisT7RDhKjV0+h
         7q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816264; x=1791421064;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTQtDRZE6hbaSqiCeRYm1Tiy2pek4MhmDBkS+QhXVW0=;
        b=wzMRJQDU1eOoj8NPLiM/YTdn3CS4lOlePPf2AmY0WBNkXbeCGDi4cmRvGHnVA9bVFD
         R+4+4ixGRhVasHAo6iwa0xfGVh05lnNlOEnMMN6Awb3wWVxk7WoavQjdbnRqdem6zMSi
         BMOo1RXD1r9hQa1Cq/BYJmGmezYMqqL0IrP2i5dH2Vl2nt/dyAfOS7bqEdcoc9xxwh1J
         JIyBh4CiznfnV4ZsPE1z/10Y9/RCCTMcr6unlueyibst1DqThGjc2jJEPyj3CflVL9Pt
         aegsU1CPPxHzNuuF7S3K77kctnN74qA8qmtKjdSLlroIk3ivOK7kdpt18v2MFRXRf7FN
         voXw==
X-Forwarded-Encrypted: i=1; AKwUvBz9xxoYZobWTgxvxmjTgwdaGcw10sKctKZKF8rgx0qjULxmaQwIVFTykZaKWcM9Z1plumbtdQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLeYdlT8R5YoWoHB571QdSLL7mefUQ2XQcvOr0uzqszmvyVaPN5
	f9FutjkBedUVp+yd3DgRAtlE3b52MzH6vfaLtYwOM7YVGYG+oR1fRJtZidrxLBDGdmi6q5TbeHH
	IArxSS3MEYT44Zg==
X-Received: from plsm24.prod.google.com ([2002:a17:902:bb98:b0:2e2:dfc9:4865])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3bcc:b0:2e3:110:b71a with SMTP id d9443c01a7336-2e30110bc9cmr8262235ad.0.1790816264188;
 Wed, 30 Sep 2026 17:57:44 -0700 (PDT)
Date: Thu,  1 Oct 2026 00:57:32 +0000
In-Reply-To: <20261001005734.1033516-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20261001005734.1033516-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001005734.1033516-5-skhawaja@google.com>
Subject: [RFC PATCH 4/6] vfio/pci: Set live update file handler level
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_175746_261351_93BCB1C1 
X-CRM114-Status: UNSURE (   9.67  )
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

Set live update file handler to LIVEUPDATE_LEVEL_DEVICE.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index fb2141ee8942..4b8a350b867a 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -335,6 +335,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
 	.ops = &vfio_pci_liveupdate_file_ops,
 	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
+	.level = LIVEUPDATE_LEVEL_DEVICE,
 };
 
 int __init vfio_pci_liveupdate_init(void)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


