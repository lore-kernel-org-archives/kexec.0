Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876DDC46CD4
	for <kexec@archiver.kernel.org>; Wed, 27 Dec 2023 02:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sV7WAp4No1iS9/nCnhwTz1R22nKJEmEijkb2vNzJTBY=; b=VW2dMYE9O9NWB3
	sJVRc61XYCxhj6aVOWFUChqx0R3eulvv4oSIgi+SCTa9uoZIDeuaqsYUM3l89pmmpj3QRaX2i7Is/
	BeDx6e19pFM/odn02ySqeY7ZAAyTkmvxi03SWWxbB72Yy/E2Rz4O5Te+6V7sR1v1bfkNIbcmtJrSp
	+gea11oga2WhR++ZqaLilucU00fCM2eBR/UNHJLpCtronn1jqcT/RHl+1oicxo1z7Nxvy8kFFjeUY
	qdPgpkM8KLYZeRrjcHd7mvABCFjZIptpM1Lngz5r9p6Wixw5vxNimb64fub7W0ZDF/TvmSC9W2/V5
	ET0NFJMqoHSbGxUGamnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIJpu-00Dq2T-0S;
	Wed, 27 Dec 2023 02:39:58 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIJps-00Dq26-07
	for kexec@lists.infradead.org;
	Wed, 27 Dec 2023 02:39:57 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28b82dc11e6so1731463a91.1
        for <kexec@lists.infradead.org>; Tue, 26 Dec 2023 18:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703644795; x=1704249595; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIL9z1K+903Rh3aHRwyuDGVekLCKVq2u3rRzi6i5f88=;
        b=m/IHTcU+riuyH7Pc5+pHkrLdul7Sax2PrwkvTs1rEW6SkIisTT97Mk0C+V/hGeqEk+
         3J9FR3G7wVYY+BUOrzm30CbcE0weM5kCMyGM5ixm/aTALzDJcEroTC1EwzF6LYNhjiWr
         M762xVI7ej3p0s8vlVtbLOK0EYb7rglVS6dVXcD3yC3ngEUVGEGyqzKe1vWaya5SB+wr
         z0/C54qMPSlv2b4kSuayT3boVPxfpkLpNtGsaub5R9NG4EGbrTr3uLSol+5ugoBC3IVn
         nDAuEQLvsSkXY1TCoDaTaeipftuESb3PZQp+zI28QKbCjjrKNuXm2aBnTEpJnrcYJJN7
         mq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703644795; x=1704249595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIL9z1K+903Rh3aHRwyuDGVekLCKVq2u3rRzi6i5f88=;
        b=PQtWiFXM3d3hsyxPYpQ2mKCVgf4U6cuLpHsK5ycfZycblNtM6fQ92swSINpqBSrA63
         3VncGil9UONLXfJwk4dN6aogj55qPjZ9o8xPrxV2CZe3AF5P9hwalYvXkleUuKhYWPGh
         93eqmYBKsWMnIfNQ5ra5DSLSY2P8/OUCEcw9HF7L9vV+nLlLLrECEK9HYRrS4d6f6ZpW
         QMiCpYCPEN6I7FcLOY9NmfrdfZ84mxzB7arwkuJPf3Wfh50OWxxxYwrpRWJzsMht9nCT
         txcmC4iFuhoVPeTJe2jxBGZUZcSIP+AnRsFkzSyAMtbCqBlZo6JK/aLOfVCLJ1s0H02/
         GTuA==
X-Gm-Message-State: AOJu0YzegjjRQeu1bR9kBPISv33BNGD7h26NjyLYGk5WNzywTsu3fuSK
	G2snncd4JE5GlgYOCUpwpg==
X-Google-Smtp-Source: AGHT+IGZvG3gCfSUeZvM4P88xxoLyrISs0xdog3hM2HWUCBOAqPUfCfKMA7wSU2kc9npPVA0sBX3jw==
X-Received: by 2002:a17:90a:b396:b0:285:adb1:6acb with SMTP id e22-20020a17090ab39600b00285adb16acbmr2089744pjr.29.1703644795539;
        Tue, 26 Dec 2023 18:39:55 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a134800b0028c387b2528sm6727454pjf.8.2023.12.26.18.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 18:39:54 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Wen Xiong <wenxiong@us.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	kexec@lists.infradead.org
Subject: [PATCHv10 1/3] powerpc/kernel: Remove check on paca_ptrs_size
Date: Wed, 27 Dec 2023 10:39:32 +0800
Message-Id: <20231227023934.12299-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231227023934.12299-1-kernelfans@gmail.com>
References: <20231227023934.12299-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231226_183956_078423_74E3BEA0 
X-CRM114-Status: UNSURE (   9.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Pingfan Liu <piliu@redhat.com>

Between early_setup()->allocate_paca_ptrs() and
smp_setup_cpu_maps()->free_unused_pacas(), there is no call to
set_nr_cpu_ids(), which means nr_cpu_ids is unchanged.

Hence removing the check.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/paca.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index cda4e00b67c1..760f371cf096 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -286,16 +286,6 @@ void __init allocate_paca(int cpu)
 
 void __init free_unused_pacas(void)
 {
-	int new_ptrs_size;
-
-	new_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
-	if (new_ptrs_size < paca_ptrs_size)
-		memblock_phys_free(__pa(paca_ptrs) + new_ptrs_size,
-				   paca_ptrs_size - new_ptrs_size);
-
-	paca_nr_cpu_ids = nr_cpu_ids;
-	paca_ptrs_size = new_ptrs_size;
-
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	if (early_radix_enabled()) {
 		/* Ugly fixup, see new_slb_shadow() */
@@ -304,9 +294,6 @@ void __init free_unused_pacas(void)
 		paca_ptrs[boot_cpuid]->slb_shadow_ptr = NULL;
 	}
 #endif
-
-	printk(KERN_DEBUG "Allocated %u bytes for %u pacas\n",
-			paca_ptrs_size + paca_struct_size, nr_cpu_ids);
 }
 
 #ifdef CONFIG_PPC_64S_HASH_MMU
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
