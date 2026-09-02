Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1D3C624D4
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uqv+RTAI4cJSSsg2qdg0AwAoAqWKAsIT2FLXo2GNbW8=; b=gG1HULPijrJxCJ1gjwv5SKXym9
	Lt3H3RoGGo08qUieup8dR6L9klVAB1kCI7tS8vvJDbTxrtFMLHNz5/+9eaYmTYIuYEGUsX8vWKN1G
	ziq3eN4oDWZj6IX0PbHnTIQvwvd6IJaxr4oES5wTcoUOvEJz0h8fmAowNXNehrSkAzAVF19qBGAdt
	AckZkXbmSlYdGftUqu3vS3t/j/3Veisq6Sy3HusGJ3060BgWdPMyrIk4SUqSRIL3DTEtIM1HKmx+Q
	dowx3tfDInpReETQII3b7nWv6aKt2pkAqQxMgyGAXs10O8dFui1ufU3VEIuwTbEizeGLP953u09YC
	WYokUBBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fRn-0000000Dvib-07Yv;
	Wed, 02 Sep 2026 07:31:51 +0000
Received: from mail-pj2-x05.google.com ([2607:f8b0:4864:39::5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fRi-0000000DvgY-2etv
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 07:31:49 +0000
Received: by mail-pj2-x05.google.com with SMTP id d9443c01a7336-2d6f9dddd99so3087685ad.0
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 00:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334306; x=1788939106; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uqv+RTAI4cJSSsg2qdg0AwAoAqWKAsIT2FLXo2GNbW8=;
        b=T2liDEm/t9Mu1l0AYR0Dgeo/F+RZkNWehenuXv8MBEYxE7D9x7HgUGeo0ScFxLowYI
         1myR99mGNebgEpU3c6qd92zk4MDwzck+xjJ6+durkS0KxeO6MidGYJuxjmfDhVaXhlOZ
         kfAzmIB81NP77yx2ub5qaSu60zChgpRYTj+sgzaPONanj8quW/aNJN2wOqFcxQ8Tzd+W
         PDvo57czoAg259iZXfGINTrJeKW/1jBlyCHyhJ0fsm7DU85dbLssPEhhGZ2eI/a7t4sC
         CllKBAHnKwpZfk9+5jhuZgYJ2irbeYAOjYRb7VDCAQnj/wrglblhI0sJJOCuJYRx3mHp
         Wijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334306; x=1788939106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uqv+RTAI4cJSSsg2qdg0AwAoAqWKAsIT2FLXo2GNbW8=;
        b=a7RO8V6XefSGxhapR4DEj/kXtcskyDJ53fEeRDAggrNqDEqzX+StNz6TCj0VitgKtR
         Ex4dy1ZmB1MKYUs3kWWvlm0cO8JM6HWHVvGOCC5q9hRB/9qvjJ//nweAaRP4Fs15Q/o9
         BwTZ+clACN+lWw2AIilPeSHC1ag9stPwJ89iItXEDXlRKVCebuFiT2krwmvQCRYeTUTy
         ksQJIAwrKse7/OwshXNULWw6/8XwNVRSeqE37MjYj0woHsr7Z+PdGTi+u8kcw2iYAhdV
         geMgxzdV79BrjCdEjSAKhiH3VEHlwJzVxx9drdYlRFcbwSSRr1I4SP0mpc3SlWLn1NJg
         jE9A==
X-Forwarded-Encrypted: i=1; AHgh+Ro0dYBTJqXCkjdyFKCQnHSnLiHaV5P5hfT8M6OG8/1JWBWf5wAtM2zA9nevx6WzlmPGBaUuBg==@lists.infradead.org
X-Gm-Message-State: AFuF++ktg5nGaRJZGQuhX+8rD2XmSEzofV/8q5sdxT9TrL0YoLKhJumr
	B4oWlJ7Hr7+QYfQWMp6yUge2ga9tS7BT/WUlO6xMNC0L9Isl61kgWNEL
X-Gm-Gg: AR+sD13ygx4Zi6HSssSyaVJQb9PlV0K6W4ZaYeTZq0ZbaEc+DENo/IZXgyd8ghWZ1mU
	1ktF6aEtpVjFVT6d03RsB6bi6qJKicCrDjF80VFwDJKFEIt3EvLu+tG9JT7un2lx04Sgx9sqxVo
	HSQDDo0v7Vc0a6ATbwl5Rcgy29V0ITbDLhjmT8tfC4myE+H6+rns+cEWN2i1CgmV/5kvESDPEsZ
	kgiOXB6tHzPlbu41xPUdTVbDXHuHqVHerVDJUURIqF873i2iHt4DqdldNq4jPdMnZ66FYOtWyFh
	dwMuNW2S3nMLpfW/j51DPOGaBLG0bTJy5REuiC55oCCzUC9HPTBM6a0BPVxO2Zz7wlt4yh14cep
	j4V4/HjDqYhnJtfkXNgdrU0V8mkRzrcirzZN6fY1BK2FmZUlMLe0PD/lJlU3u5zzqlq9Q63OFGg
	49eWpkiW1m2BQEv0XACTkPp/3rVJq9vvRT0qI174UleNfEz9z6qt2km/PdaDVaINBcToXv+6Bi
X-Received: by 2002:a05:6a20:258e:b0:3d1:39e9:b261 with SMTP id adf61e73a8af0-3d9aa4ca9c0mr4530228637.0.1788334305736;
        Wed, 02 Sep 2026 00:31:45 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:31:44 -0700 (PDT)
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
Subject: [PATCH v6 01/10] mm: memblock: add missing HugeTLB flag name
Date: Wed,  2 Sep 2026 15:31:07 +0800
Message-ID: <20260902073116.802752-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_003146_739379_828E7A5F 
X-CRM114-Status: UNSURE (   9.95  )
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

From: Meijing Zhao <zhaomeijing@lixiang.com>

Commit 7d163a75f821 ("memblock: make HugeTLB bootmem allocation work
with KHO") added MEMBLOCK_RSRV_HUGETLB but did not add the corresponding
entry to flagname[]. As a result, memblock debugfs cannot report the
flag by name.

Add the missing RSV_HUGETLB entry.

Fixes: 7d163a75f821 ("memblock: make HugeTLB bootmem allocation work with KHO")
Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/lkml/20260821020910.3428585-2-zhaomeijing100@gmail.com/
---
 mm/memblock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 9ce86349a29f..f2952d725c10 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2886,6 +2886,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
+	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0


