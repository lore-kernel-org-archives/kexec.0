Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546F7C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dquujKaEWXj9SeOR2cw//kdvyk2bjQlGJyeh7Df3DyQ=; b=FcPN2F1TYrkRIQsncbxUVUX8PM
	BxlQvl+O2W0ycxQnsFGg06sNFSUrIDLB2b1nzZkeMjbPiljcHxbs4JjoVKZ0/7Rqinb6T+M2yZeNd
	hEr+Gj9xhUZ3A+Dz9WmLwR+3Zx5pyAA8MbUg8qse1bY5fWtwAxq17FnlbPGq37w3uEuSFjmnABPef
	H/KgQGQLo/UctsK1Z35yJWFrSONBkAobCR11B/ALA+rYk3agjAoWohUtTAJORoSUdfTJlarNZ3g9l
	jvomNRSvh6x8JwFUpMl5aaAa6GwCxHe52wMP3IKuhXtOZIRXliRdpLTn1juz8EMj4S72REUVImb4w
	UkbIjcDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfc33-00000006nxa-07OK;
	Fri, 03 Jul 2026 11:27:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfc30-00000006nwW-0gQB
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 11:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783078025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dquujKaEWXj9SeOR2cw//kdvyk2bjQlGJyeh7Df3DyQ=;
	b=YxGGZfSV2DKPrapT33FL7MT65cRA82py+zbINV9LLkXXnVMMagmA+gp0rt99ODOb3/vlu3
	tRkkK2mNB51gchoo15+7H7WSN74fO43/AkCMDzBjEkWU2VCvzk+5Y3vdfVm26+Ovw/loFM
	pfIPfYK7URTXf31Z7uCBCVR9Pvk3qxk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-PYBttxUHPOeM4-At6Vx5_Q-1; Fri, 03 Jul 2026 07:27:02 -0400
X-MC-Unique: PYBttxUHPOeM4-At6Vx5_Q-1
X-Mimecast-MFC-AGG-ID: PYBttxUHPOeM4-At6Vx5_Q_1783078021
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c825562f8bso9448895ad.2
        for <kexec@lists.infradead.org>; Fri, 03 Jul 2026 04:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783078021; x=1783682821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dquujKaEWXj9SeOR2cw//kdvyk2bjQlGJyeh7Df3DyQ=;
        b=mrWURGhGWcw1d1TLyKx5usoJ6wiPCBs/rBscu+Ri7IMREnfz7p/PGOkPP1ObIyPSsE
         0RLCgW9NZzz7cC9eqfMj2baHnMacnItHTVnatTP9/AtfOWmAnRvH6II9QWQctrSAw6Ls
         vt2Nd16EOkf++Q2pR6/jRWxSMVo0x6vPGrj9Qfi3IY+cN7l1ss5Q4BQLSTdi3PISTDaO
         9Wztm756+Qj7RaVeK93q2fOXSdxdmoObejRfCwRWUJizWDJc11LdONcZGVLcC2xuRZF3
         Qx+ZKm4s+GVe0XrtIpbrPvEXnqp8FH3uPpgtaq3PVByMqGTjzHZM6b/NSADjasw3BPES
         N0ew==
X-Forwarded-Encrypted: i=1; AHgh+RrqmKJjgrB+H4CpAXZt0GosMmcjJU5Ry7dlEGrU2bcbF5kbjK3Qq8IuLDV6sjMFUjQ2XvPDCw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwQa51hohu7xtA2lP88gHB+fp+Lqnu2156CFzl0dvWwWCCE7KJy
	W4bYJu5WSSuu2SdzMZE2ngHXLrSfm0tM8Tui7rBTCiPSxPgh8Sk6oal8rs1wpx42gOs8mkPX5+V
	WDs/7utft+qXCcW5HyHAZfdpMtTplE26A/ZBer3gAIeZYu09ZayQZoLJSDZwrGg==
X-Gm-Gg: AfdE7cmOoUMmd3Os/LRgl0Y49qpUf6bnHsMfdKVIKqzsmeSvC3MyTU6vKL1GPcdbLr5
	V0VQEiFicpKDP59Amlnvf4xelFD9naQUeOJXkWiVyDkx+kiqpPEV6hU9rX/wPIIxQmN+Zb9gHbP
	RimP1hU1QCzE72nuGdV/yAEBqBWp/i4PkISofFTw8UU1WRSxUmrtGljvQx06to5yhh0q3k3WyTR
	xyNPkwZCt5TJUNyeZhFECSruFloKXLo1s4QiHC9S5pP4aXm8erDT68RkaQg1TVXZH8mBHyoiJXS
	9j0BRdJuYlogyjh4ZHUfo3lipvOGaD7+7hlCUyg+B3Z/KiWFvDxx/qnFBcTHRSiMTi+BwWQz0aK
	mDNUv9iDi639evWMt9+8pT7WwpiATELzrGWqULZTsXE/m3OAN/Q==
X-Received: by 2002:a17:902:e54c:b0:2c9:adbb:5862 with SMTP id d9443c01a7336-2ca7e8b686fmr102173435ad.45.1783078021225;
        Fri, 03 Jul 2026 04:27:01 -0700 (PDT)
X-Received: by 2002:a17:902:e54c:b0:2c9:adbb:5862 with SMTP id d9443c01a7336-2ca7e8b686fmr102173215ad.45.1783078020656;
        Fri, 03 Jul 2026 04:27:00 -0700 (PDT)
Received: from localhost.localdomain (122-63-67-56.mobile.spark.co.nz. [122.63.67.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f260acsm8227305ad.6.2026.07.03.04.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:27:00 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	bhe@redhat.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org,
	pratyush@kernel.org,
	Markus.Elfring@web.de,
	kernel-janitors@vger.kernel.org,
	jarkko@kernel.org,
	Tao Liu <ltao@redhat.com>,
	stable@vger.kernel.org,
	Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v4] riscv: Prevent NULL pointer dereference in machine_kexec_prepare
Date: Fri,  3 Jul 2026 23:15:31 +1200
Message-ID: <20260703111530.91285-2-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yA58sNtRdtmSis2Dk5qKyPemOWT1W_8sp11WLw7iCDc_1783078021
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_042706_269945_60A7155D 
X-CRM114-Status: UNSURE (   8.95  )
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

A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare(),
where image->segment[i].buf might be NULL and copied unchecked.

The NULL buf comes from ima_add_kexec_buffer(), where kbuf is added by
kexec_add_buffer(), but kbuf.buffer is NULL, then it is copied without
a check in machine_kexec_prepare().

Relevant path:

  kexec_file_load
    -> kimage_file_alloc_init()
       -> kimage_file_prepare_segments()
          -> ima_add_kexec_buffer()
             -> kexec_add_buffer()
    -> machine_kexec_prepare()
       -> memcpy()

Address this by adding a check before the data copy attempt.

Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/kexec/CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com/
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
v4 -> v3: 1) Remove code comment.
          2) Replace (buf == NULL) to (!buf).
          3) Reword commit message.

link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
link to v3: https://lore.kernel.org/linux-riscv/20260701025732.66330-2-ltao@redhat.com/
---
 arch/riscv/kernel/machine_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 2306ce3e5f22..738df176ff6f 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
 		if (image->segment[i].memsz <= sizeof(fdt))
 			continue;
 
+		if (!image->segment[i].buf)
+			continue;
+
 		if (image->file_mode)
 			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
 		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
-- 
2.54.0


