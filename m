Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFECC43458
	for <kexec@archiver.kernel.org>; Sun,  5 Jul 2026 23:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qWgX8hRK0wDWBZMkA2UqYafCnMgGjGfI+mUA5gi2rBg=; b=KYQXb+QUXPYrzHOnUrP3hO2s01
	5Vuu0FFeOASN87/BSnfJ9i32Z/DC+jC7DwhibPLyJFx4drX5f/jodaswFGIG7MvmUxq4Or+vXuAQZ
	BTcgdxGbGxAaZuCwvqotA3l7uFipCEoXycLN7pEAj8pjl69wDK/dpgkYehKTMczJaJN/+G09Jd/H/
	NDlZTueWRV8lLeoIQUOCZvIMsWPCFhXxWbu0vxx4D28GfXiCGf6lcnrrsCVp5C6EIvQx8pa4NwKO8
	6k/r0CpshIN5BtL1/DOUj1zHplKVZI9K9PyS5YLQOACA/ghyyrpMF0oOdx3oR9FvpmMHrxU15sMuV
	1NH/QDNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgWLG-0000000Aipp-1orU;
	Sun, 05 Jul 2026 23:33:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgWL9-0000000AinR-1fEF
	for kexec@lists.infradead.org;
	Sun, 05 Jul 2026 23:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783294412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qWgX8hRK0wDWBZMkA2UqYafCnMgGjGfI+mUA5gi2rBg=;
	b=ImVUNVlGCIBjHySjxy1C9otLgR5lmbFiZ60Tx0zWpbWGx+HMPreoXm9Xe/LGoMLXBfMs95
	0rZARYppcoF7/4DtobdCH9Y/j/NqIVnqi43I1qfev5B5oJzbnFYiw5CrJMEn1kVk3bp73l
	MuLVvh1nwAvGkC2ujnSQODcxlBDwBsY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-zleWzsPvMd6Cer19bgGvkA-1; Sun, 05 Jul 2026 19:33:30 -0400
X-MC-Unique: zleWzsPvMd6Cer19bgGvkA-1
X-Mimecast-MFC-AGG-ID: zleWzsPvMd6Cer19bgGvkA_1783294409
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ca0481106cso25647475ad.0
        for <kexec@lists.infradead.org>; Sun, 05 Jul 2026 16:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783294409; x=1783899209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWgX8hRK0wDWBZMkA2UqYafCnMgGjGfI+mUA5gi2rBg=;
        b=Ko4kR764OLt9PI72sWaxOat9Nd1z+tfayY7sHcruheQcrvCIcEpYX53kQqNl/ZFLYN
         ILGyyBS1TgMNnXzCp8IS+RlMXbhWW5a9jH+RuWrgqVEBCrrZoOIqt5vtog4XnZNOI9Em
         2IXwN+6mFO9B/rDUIhezkmgosdOMHqWYC8eBPzT2zUxMjbaiTq6iH/H5ZBG28VcdVDrT
         U9rrmvkCmEDUsm7y8xcVbhVO46bK4oHFsqXRxGSC9l7h36qiJCdh2GPqdGCr8wO/S5rV
         wjWuZOd11qXTEUUXwvSgsUtWEyQmTzIhurxzo551uABzqm6PbVbYT6U6MWpN1lh/ysgG
         5uaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rof/nheCqkATs/Dyiveaz9f/bFlbHxGw1vvNul0ETuc6VlmV5r1He0tN1KAEUx2Y26hYFegUA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyfGuXfBufohmfb6YgFoanwxhik1M2G3YEOwxmVHrlhWZVcOBdf
	w0ZQ7ogUAEnx71L3pQKXwst6MfY1mOgM44LO6QNZLrUsLKYI69+McIHzwss+wsPkGjWsw03IgVU
	Bkk7X6DZd5+gUbeDecyHcJru7F7+DI6zLzJyFe0iwqTiv5VPt9X918lUZbm/pBg==
X-Gm-Gg: AfdE7ckVN/vBIamhrv25AYLpm/TSXQjTkBEBcX4PEVhx2oP3iNjdFioUZ0H1tpcHTGR
	qRk1JxvafxE+c9xpK5W7JqPzGbdkl0hMXLBYT2mm1+MOiP/P10GVqKjBfII66epeATjJxN0yyyy
	xY1W725l1UCx4BJKn5inWrbwOa5leuwTPkMOAe6IfCq0xJiTJBnTL9k0oYuZd17AOtFM+uvjAAm
	vSURdrgcvKEGCsr5DWm+qCWFvaKTmhT7CePB4sXrRI7aFgbqyU7U/ZyPnIjSmKLc8NZJv7TNCIe
	Zw+1m8FucZgKaxwf3x5kRt7vr1ns6G04Sl+uM5MfiaRnaujcuJ5PRfTq+opblH0T1P9Bq26dJSE
	KADMnaZk0u8SYJHtQR78kpCMkS1s0l74HSSzD7+trlnFfpMqqYv6nhTVLCQ==
X-Received: by 2002:a17:902:fa84:b0:2ca:52ce:6f91 with SMTP id d9443c01a7336-2cbb9eb434bmr53329115ad.27.1783294409463;
        Sun, 05 Jul 2026 16:33:29 -0700 (PDT)
X-Received: by 2002:a17:902:fa84:b0:2ca:52ce:6f91 with SMTP id d9443c01a7336-2cbb9eb434bmr53328835ad.27.1783294409024;
        Sun, 05 Jul 2026 16:33:29 -0700 (PDT)
Received: from localhost.localdomain.com (122-63-66-137.mobile.spark.co.nz. [122.63.66.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad789237bsm38168945ad.71.2026.07.05.16.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 16:33:28 -0700 (PDT)
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
Subject: [PATCH v5] riscv: Prevent NULL pointer dereference in machine_kexec_prepare()
Date: Mon,  6 Jul 2026 11:27:07 +1200
Message-ID: <20260705232706.30265-2-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LfyCN5BCIVO1Qy4XwnI3j012Wz-Jy6yvjMKufQjgyKQ_1783294409
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260705_163335_513896_9503F3F9 
X-CRM114-Status: UNSURE (   8.79  )
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
a check in machine_kexec_prepare():

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

v5 -> v4: 1) Add parentheses to function name in patch subject

link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
link to v3: https://lore.kernel.org/linux-riscv/20260701025732.66330-2-ltao@redhat.com/
link to v4: https://lore.kernel.org/linux-riscv/20260703111530.91285-2-ltao@redhat.com/

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


