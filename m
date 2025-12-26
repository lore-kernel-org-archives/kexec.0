Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C854E8FDA3
	for <kexec@archiver.kernel.org>; Fri, 26 Dec 2025 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C1Eb8Tbzs2NO6bPeBqhZrfOFwL0tG0ndVs0MF0jDIGQ=; b=oFa0BMKhN/KdntG5ahwVvCxP6X
	hDj98OlRYJVuHLN0O862P7tqcbygqjLUO/sO6g+LEXi0uiKcQZ82aqBOgiw0WT+M07OdWrgeGD97O
	yi5gu/kGqx9UXvKmBXB+uE/TfpoRh0kkLFFc1rr2IeaTqq2o8CtDrPppRYyX5nZQ1Vg6HrEeRdN+/
	E3HG7yH4LOxwB6ACQO9P+muby5u1OvmOBzdTtRJOV7JZzVAalU1EsDPEaZ619g+E4do9FAZ2l5W9f
	ssPTIzg+VVxQvBnggzedjlFte0H3b2suEkoBQXiPu3GvwXu4W6fgSRJkfRzEWw7zI/iexbDO6gusr
	rhPwQALA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZ8XO-00000001EWI-1Ndp;
	Fri, 26 Dec 2025 14:11:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZ8XM-00000001EVV-18SN
	for kexec@lists.infradead.org;
	Fri, 26 Dec 2025 14:11:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766758283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C1Eb8Tbzs2NO6bPeBqhZrfOFwL0tG0ndVs0MF0jDIGQ=;
	b=FM9lmZ62Z0k0QvOs7EsIaOF4L+zDjKwPDonVOngrvonjRVZRo89ltadHexLkUrjqXv4AfJ
	m3TjghHXQd8hbEK6jelB9np2C/VuDYPPLtazpivRMb+jbbVz1iHtr9vgiforpM+u4BfGjT
	R3j1EpXC5Nxb1zK6gqhIXEzaXqHmez4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-Z-o6pzPoPdGHHRVupavBSw-1; Fri, 26 Dec 2025 09:11:22 -0500
X-MC-Unique: Z-o6pzPoPdGHHRVupavBSw-1
X-Mimecast-MFC-AGG-ID: Z-o6pzPoPdGHHRVupavBSw_1766758281
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a08cbeb87eso122317575ad.3
        for <kexec@lists.infradead.org>; Fri, 26 Dec 2025 06:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766758281; x=1767363081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1Eb8Tbzs2NO6bPeBqhZrfOFwL0tG0ndVs0MF0jDIGQ=;
        b=olX0TJOHgPAkrvnjoca89IpzFjuLQs+0KsxV9h22C6ChsUFWjsjiWsMui8XD5V6HPt
         ewgvmtTPKPRZ/2CYCRLKW3hUuDiY7hFn900lN8X3ZdL02qCvo/Z+RUgB43RNxB2J36rw
         OUAacedrMKYmPWQszoC+8EkDW9smzhTo5bF/MSapcADuMlJwR7bWpmE02k1ggm71He9g
         qEoQCQJY/l0RzbjJhG5BUg6BFeR9UbQRY5Z9maNpmYIKfLlctqZcMTopvsoDhjlXbPOv
         3hI8y8YjuvgA1yQtr7BzlrEQH6MC2CwaOr/iuyg5gWmAZQATmy7EZESZax9ODuIrdyz1
         +uGQ==
X-Gm-Message-State: AOJu0YyRH5+QaroKaa3+LKuh/zcvgxBs8phtWmtj3a+qzTuHgzQqEHBl
	E3/i/zsEPB2DhnkLd711zNWpIjUfS8616ZViXuWrZ8wJVmSqjCoFsJhGxv+zDF0o0/HDfbDktJP
	ENVWQj/f1QLPMjkN3WYmoOB/tz5G+kG/nARk+W364wkXvYt4W+tB8VC1UXdJ+XHducc7ajGc2oc
	0DUDhEABhYCMbe5Q1REOyLv4WbV6qP1P7XO4CxuZzDLTw=
X-Gm-Gg: AY/fxX76Ev4z+2PUMhZFk6mmSnuV+l2W18EqvID/vX7FzhM+3XrPd7iJzXz8cLLezSz
	74inXt/rNKgEH3q8HSGiPEXQuUcpLXx5rB0aFhYvtGDQiLUOJEPNQ1HxmG733MaVTXcC4CgCI2S
	WbYAegtg10vWyoE1jbXKzMjZWcGktvDZ7Kt6/9VzhEKIE867O1RJf4hx3up/FT+wO99Xc2jbvbu
	GdRHLPdwbRArAuVGY4CUvtC1X6iheQV5Rn70NZ4iuMEC2OFl4f6vjeUwsxbvE2IAicwZRgyXuuA
	DJsf+b6QVqmgzmwgrFyyQ4H7Rug6M/H+mZbSIxfBnrcZjambJbUD0ReNph/O64Ph2WjmHh53+ZP
	C
X-Received: by 2002:a17:902:c103:b0:2a0:97d2:a264 with SMTP id d9443c01a7336-2a2f2735214mr156670215ad.37.1766758280590;
        Fri, 26 Dec 2025 06:11:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXwhad5jc3xv4cqcmnL6jgHZfUywv9Z9yVyVbU1Tg52LQN7cnj/6oCJmqPwsvSlt7Wg7i7lA==
X-Received: by 2002:a17:902:c103:b0:2a0:97d2:a264 with SMTP id d9443c01a7336-2a2f2735214mr156669855ad.37.1766758279936;
        Fri, 26 Dec 2025 06:11:19 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d663sm207266485ad.77.2025.12.26.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 06:11:19 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Baoquan he <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org (open list),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE)
Subject: [PATCH] arm64/kdump: pass dm-crypt keys to kdump kernel
Date: Fri, 26 Dec 2025 22:11:15 +0800
Message-ID: <20251226141116.1379601-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xJUYtbKGT8_BTv8Ya9prjnf41WXybJ7FAfNaCAf24TA_1766758281
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251226_061124_441576_034EA9CA 
X-CRM114-Status: GOOD (  17.58  )
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

Based on the CONFIG_CRASH_DM_CRYPT feature, this patch adds
LUKS-encrypted device dump target support to ARM64 by addressing two
challenges [1],
 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump.

1st kernel will add device tree property dmcryptkeys as similar to
elfcorehdr to pass the memory address of the stored info of dm-crypt
keys to the kdump kernel.

[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/

Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c |  9 +++++++++
 drivers/of/fdt.c                       | 19 +++++++++++++++++++
 drivers/of/kexec.c                     | 19 +++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 410060ebd86d..5f3bad8ca96d 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -134,6 +134,15 @@ int load_other_segments(struct kimage *image,
 
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
+
+		ret = crash_load_dm_crypt_keys(image);
+
+		if (ret == -ENOENT) {
+			kexec_dprintk("No dm crypt key to load\n");
+		} else if (ret) {
+			pr_err("Failed to load dm crypt keys\n");
+			goto out_err;
+		}
 	}
 #endif
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 331646d667b9..2b22dc7e2b5f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -866,6 +866,24 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 		 elfcorehdr_addr, elfcorehdr_size);
 }
 
+static void __init early_init_dt_check_for_dmcryptkeys(unsigned long node)
+{
+	const __be32 *prop;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DM_CRYPT))
+		return;
+
+	pr_debug("Looking for dmcryptkeys property... ");
+
+	prop = of_get_flat_dt_prop(node, "linux,dmcryptkeys", NULL);
+	if (!prop)
+		return;
+
+	dm_crypt_keys_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
+
+	pr_debug("dm_crypt_keys_addr=0x%llx\n", dm_crypt_keys_addr);
+}
+
 static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 
 /*
@@ -1097,6 +1115,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 
 	early_init_dt_check_for_initrd(node);
 	early_init_dt_check_for_elfcorehdr(node);
+	early_init_dt_check_for_dmcryptkeys(node);
 
 	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
 	if (rng_seed && l > 0) {
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 1ee2d31816ae..4bfb1ea5744e 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -432,6 +432,25 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		if (ret)
 			goto out;
 
+		if (image->dm_crypt_keys_addr != 0) {
+			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+						       "linux,dmcryptkeys",
+						       image->dm_crypt_keys_addr,
+						       image->dm_crypt_keys_sz);
+
+			if (ret)
+				goto out;
+
+			/*
+			 * Avoid dmcryptkeys from being stomped on in kdump kernel by
+			 * setting up memory reserve map.
+			 */
+			ret = fdt_add_mem_rsv(fdt, image->dm_crypt_keys_addr,
+					      image->dm_crypt_keys_sz);
+			if (ret)
+				goto out;
+		}
+
 #ifdef CONFIG_CRASH_DUMP
 		/* add linux,usable-memory-range */
 		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,

base-commit: ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1
prerequisite-patch-id: af871421d3653569c735073a3d2d4915412736d7
prerequisite-patch-id: 536241bdf9240e12a5b038415875d4ce417a0892
-- 
2.52.0


