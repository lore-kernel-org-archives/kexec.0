Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DD7C43458
	for <kexec@archiver.kernel.org>; Sat, 27 Jun 2026 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1a/DgFcrrEHwkA8ET4o3flsjcsRtGN3BOYsiECe4Zmg=; b=OcKj5rTwUGsXi8bO+YCLexWBQI
	oumEAK8fUj/WjL9NurixBeIpg1WNUgdgMw3tILNS54Djf6jfF8heeSerj0wVL+v6/k8DgAxB6AH2y
	e0C9GTJiutS7RAv/RvNRp4o2w2ehSQCd2qaiaqcvk2zqnkWJs0RPY/tfgEAZcuO8pkAvhA83PDg2q
	/VmqEJhS7Qlk5rSzl5gpmLEXK0Vey9BtNKI9cNXfvBv4aS12XmEbZNpfkR7MHCQRL7BxQ/wrXZp9/
	6vWRKYBfHFKS+UKUKd6N7T4r3IycAIROgA8MFovqJNNmxJamwiAAFesMzP/znulsdodIESje8cdqa
	09/DYfDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdbW9-0000000CnPL-2HEM;
	Sat, 27 Jun 2026 22:28:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdbW1-0000000CnOj-0t3t
	for kexec@lists.infradead.org;
	Sat, 27 Jun 2026 22:28:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782599322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1a/DgFcrrEHwkA8ET4o3flsjcsRtGN3BOYsiECe4Zmg=;
	b=Uyc1hL8F8QzQhThlXqGBTz4ZBCHn0LfosvBrvuH/tnsniqdcCVUTi5/QVRHbT0xeyo1q9W
	jef0HjMxvdCGyLubIle9to8Z6YSUVCDSjprRz7bWm7jJfBtnurgo/Wtzad5G0nlqc+4+T9
	2c0NeCZrtaaT63QU6/ECczVekrB8s2Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-PhoqwLOcPMmv8nC7rS65cg-1; Sat, 27 Jun 2026 18:28:40 -0400
X-MC-Unique: PhoqwLOcPMmv8nC7rS65cg-1
X-Mimecast-MFC-AGG-ID: PhoqwLOcPMmv8nC7rS65cg_1782599319
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c81db324caso14246695ad.0
        for <kexec@lists.infradead.org>; Sat, 27 Jun 2026 15:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782599319; x=1783204119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a/DgFcrrEHwkA8ET4o3flsjcsRtGN3BOYsiECe4Zmg=;
        b=EhCH6c3oUyR1k5895Ltz1xce7w9T1O+exmlvO3Zi/B7PMV6sYeHWBhEe+nscWmmeEU
         q6xHoPVzbfZhNqw8W3q8vZ9SMnz/+nICxMhQtsuABHXPeubZ9+vDTRiU6qJ9CmaWLP46
         3TUjbhM0AtlXqeFXjPwxN04vftUn15fxp+6isB44eU/lFa6FWJVht9upGQsktFKr0AUe
         W4QNXg9i0JmQTP/ac1UleGo9tKeaslcafyoG1x1OgPd/m6buPVdaLf6RIF/XlpTzcoU6
         amFidILjMqlWN3SR1xNlg+ZhWVRAKlDy4q4A53tO13kQWed88nLG+fmnb60IhMB3Cbim
         YoPw==
X-Forwarded-Encrypted: i=1; AHgh+RrUMKPF1KAPr1vzF8RNOUkltXlzKtdMbglXyog1LtWw3Ehvrrst4/ZXYVyBowE1qTdTx/tlIg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzOpSWhAZMFgCIPZbs3lQnvUk+nC6h6OZMWrv5h/SqH3xdSkchJ
	VrheP8xNTT0Eqoyr7ySGh6gzLOs2LEwe0vZH8MA3eSZ4D9iMsWqfqpZin9+lE+7h8v7do0Ce0LS
	kgTwXlpp+TizDevZMa/PHWyFZpg1KTorkVSXm4LUdCIkQUoMXrbXfN6oIcBQMvNBEJEzlUg==
X-Gm-Gg: AfdE7ck6uIudzcc5kF+7SjG/I/SZ4qYAvYiAKHpwIBOlNqI3nkBZDdyxlF14Nxaw4+8
	s0rh4F7KSmJw2EKHygkqu/nzkXu8VESNd3vqXKrhHHUqrS1jqP/rVp67KzLgg0QfG2s0SeMbuqA
	l5RnoOqWJbiDNeCknUKfkTMKLc6w7PXlcTiJ+5QPjrQvtaic6YWl8kl3QoCYYc/PXCjk7ac5fzW
	EiDa/P0rl45x1VIA6a/UmxikM1ruWv+jIYYv1NOEe3xaT6O27WIOyBKc/+jGN5qt1DzdTJPjl5+
	4/v4SsWUSjrpWdPYKv4VXGppzwSYU3ULyqy2zHqZAp3GTZDzLi/KMQ+OR+4wznotFXY2TFjJ8vu
	zb+EFEEytzG2HrHXohSlEk0sN2xGig1Kr4yoTgkW5sBogiZ4uV2R+
X-Received: by 2002:a17:902:e886:b0:2c9:b96a:285b with SMTP id d9443c01a7336-2c9b96a2a3fmr22166415ad.33.1782599319080;
        Sat, 27 Jun 2026 15:28:39 -0700 (PDT)
X-Received: by 2002:a17:902:e886:b0:2c9:b96a:285b with SMTP id d9443c01a7336-2c9b96a2a3fmr22166275ad.33.1782599318583;
        Sat, 27 Jun 2026 15:28:38 -0700 (PDT)
Received: from localhost.localdomain (122-63-64-251.mobile.spark.co.nz. [122.63.64.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9deed3733sm2423215ad.23.2026.06.27.15.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 15:28:37 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	bhe@redhat.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2] riscv: Fix a NULL pointer reference in machine_kexec_prepare
Date: Sun, 28 Jun 2026 10:26:03 +1200
Message-ID: <20260627222602.23594-2-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Joh6Yu8CcjeKqcmbNhwpMb7js9hJWQOkNAqG4rgfQZI_1782599319
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_152845_314974_E4C825DF 
X-CRM114-Status: UNSURE (   9.18  )
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

A NULL pointer reference issue is noticed in riscv's machine_kexec_prepare,
where image->segment[i].buf might be NULL and copied unchecked.

The NULL buf comes from security/integrity/ima/ima_kexec.c:
ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
but kbuf.buffer is NULL.

Fix this by simply adding a check before copy.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---

v2 -> v1: add code comments as suggested by Baoquan.
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


