Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50864C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 03:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lCaMYc8eNrfsW+6kx9m1j6d4lfDzKZwvqiqCl5u41Vk=; b=SYZBYU8L9jU8XL4r3UVX/TGBh2
	vsSnuMH5QbV7GHQpVj9KYtGDLelPeUOn/qu2E/nBOK/NMD7ME7fNMuzDwHJDlHdl9CeFpY8KhnOao
	fms8+BD7q3MvqHYHtCwHgrAI/8ivxCvSjMziTfF7zyo+4VUyDnXGSkDysKdJgkEwI9kesM4v9OW4u
	Y04N246bWTWt1ask6qFR1icgzhWcX3WlscMT7a/sKSzjmqIrYhL+Y7OItk8xoaPiphlmosSoZfFQM
	skGagRcHUrKfPoaFit7pZV69jd+i6K1w0w3om2iCvksxynGeHr6PNO8UlDeuY3U+o53sudIziC8li
	3okFPeuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1welFx-00000000YN3-0Jqx;
	Wed, 01 Jul 2026 03:04:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1welFt-00000000YMP-0HbI
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 03:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782875090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCaMYc8eNrfsW+6kx9m1j6d4lfDzKZwvqiqCl5u41Vk=;
	b=T65OBtDOnHpHS7K1lakYHig1pNcnfGjMlBirsSQAPmdjxTnLxsE784dFsquZlVcdz0uB8/
	diMy4cAJV2RCqYIQ1OrLKK54tYhVRIbhJis4IRIhE1qr/rfeOYbEQikokrJWX6vB7Wg0rB
	t0VdX9jrqQ1eVSq/TVZreAFA9VUFqc0=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-nrq9u973PEqofYMNGq2UXQ-1; Tue, 30 Jun 2026 23:04:48 -0400
X-MC-Unique: nrq9u973PEqofYMNGq2UXQ-1
X-Mimecast-MFC-AGG-ID: nrq9u973PEqofYMNGq2UXQ_1782875087
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30cb5001ed8so345789eec.1
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 20:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782875087; x=1783479887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCaMYc8eNrfsW+6kx9m1j6d4lfDzKZwvqiqCl5u41Vk=;
        b=HU13CVCb8UYm5CmEnFKMKnWkfNSCuL++k8pFBNCO/yOcdED30AnoLepYeTwrtRtDhz
         jKaHr8qN5ETbvFtpHOyccXwqQOZWpPk3+GX410hfBEnLPoLndmJdpqeNStNRNek87C74
         zj/qpvxbfIUyCP4ETXUklFyhJ9Mn3iVug5JroEBFM2LPMglbAIY5vt7dS7L1f0TA8puK
         UwFxGbHZrwIvvMfZ+j5R/h58NM9EiaElPFmwXB5hAQ0CIk/8CUGA/3iOAX1y69pJofU4
         tzsPulrKnf4zrwKhps/Y8HB2sBbCnez7MQPWld77tEYM4DaGTLQWV+9nuC8j5OJN/rnq
         GjAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7l/nBqNYlU5Ry0nKEdTNSCkr1+iDaY5DgZralRYVTNGL9P4QHYayY+xb7d/aJm1/maWeTew==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkTfvTGWAIHKGmpICP8oP5y5Bn4iqStZYpQrMciC4vWilCq//v
	xenoIVCyzPdub0noiU+N++JrNf38hY2rjtsrRfEt2PYgqzgPOhGwF9LUBkXjbYNrjsjHhptbzum
	WvMzgYyhiXTE4fXPNLaBdJ1H9rm+KjKs0MwzSsBx+ymCNbrff7H2hmzk821/A9Q==
X-Gm-Gg: AfdE7cleDQbvY8txVO2RewN0Sjl46YVOz1DRHi21Wi6/PDtztrS+02pONSnBvqA+F41
	MSlQsyCMso9ravANL+THYSog2mDa3ZQAKvSvBoiGglrz2Kfxdh6X0jW9enA7IVt0X84YBtnJeJ8
	FkDOTwHAUI4DG9GQsHCfqU7cJ8wzhP4FH16TJqSpK4ajvjl8v5VDMKmnElF1oKtFl2lflSimnnS
	0CzoIIWg7w3E0qEHhQkO7bvkpI2VVIBSU2YeUwgbZZ6e8tGXfJ6GxK5FQZiCwmuNPPNTdfvhQjG
	dMtae4civ+JeAOP9nJbojR57a9gQux1F/WaEQ5gaAopDiuVpdU0tG4QgUQynksCnO69kqHVS6uF
	ZFea5UIFYtnZ23frtCn36tpsc3fKQLmnJr9uWNNd1WlX1LgEszz32AIU=
X-Received: by 2002:a05:7022:23a3:b0:139:ed5a:eef3 with SMTP id a92af1059eb24-13b315a4cd0mr2248705c88.50.1782875087313;
        Tue, 30 Jun 2026 20:04:47 -0700 (PDT)
X-Received: by 2002:a05:7022:23a3:b0:139:ed5a:eef3 with SMTP id a92af1059eb24-13b315a4cd0mr2248677c88.50.1782875086647;
        Tue, 30 Jun 2026 20:04:46 -0700 (PDT)
Received: from localhost.localdomain.com (122-63-73-73.mobile.spark.co.nz. [122.63.73.73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2abbba8dsm15858670c88.13.2026.06.30.20.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 20:04:46 -0700 (PDT)
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
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3] riscv: Fix a NULL pointer dereference in machine_kexec_prepare
Date: Wed,  1 Jul 2026 14:57:33 +1200
Message-ID: <20260701025732.66330-2-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lOHQuer32pHKXML4TQiV8uPXLY6QYIXvqFUT8u53o7Y_1782875087
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_200453_178973_D253EAE0 
X-CRM114-Status: UNSURE (   9.65  )
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

A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare,
where image->segment[i].buf might be NULL and copied unchecked.

The NULL buf comes from security/integrity/ima/ima_kexec.c:
ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
but kbuf.buffer is NULL.

Fix this by simply adding a check before copy.

Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Tao Liu <ltao@redhat.com>
---

v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/

---
 arch/riscv/kernel/machine_kexec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 2306ce3e5f22..afc68f6a4aa1 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
 		if (image->segment[i].memsz <= sizeof(fdt))
 			continue;
 
+		/*
+		 * Some segments (e.g. IMA) reserve space but have no buffer
+		 * loaded yet. Skip them as they cannot contain an FDT.
+		 */
+		if (image->segment[i].buf == NULL)
+			continue;
+
 		if (image->file_mode)
 			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
 		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
-- 
2.54.0


