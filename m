Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789CEEB597C
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jg6rUiFx+q06U0spbnVO76byiw3N0jzh2FjIOHbS9H8=; b=DpILvcH4myl9luDAp3/1hgMGQn
	Ohjs2BWXefwwQfdfRAjmmb1/+Kb1FAUltq/3gNKSJxNHV4oRHMFIYP+e7TrRPQkRSG+nZ5ChIK655
	gNQ1/VhJVnBXOb8MhjnaEwKhY40pwsK6zHlzFnLAGteuDWk4m9IrZ60xnUXcNyzFv5vnfc/b0oP+K
	19DZbQBn89pUMJRCnPBUpgmSZr3X89fsMNKYXAaz3wMGj+q9pMsTdyyhpTaBdQf1IB4mzsRfQEXJV
	m+bj/3eFa24itota6H/jNbRfkqPhQw694ZV4vJsQZIePP044kfUMcRYKQICXwGugeoKGKHYJqzr+k
	Nvoa8lOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq5WJ-00000000O4l-2FC7;
	Wed, 11 Feb 2026 08:24:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq5WG-00000000O2e-1BTO
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 08:24:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770798259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg6rUiFx+q06U0spbnVO76byiw3N0jzh2FjIOHbS9H8=;
	b=SyCV01+/BLqFIJ4UBOTAmLkMPkAhHqGrVKRjq3UIQPlEKZrB7DQOJ9XUo5yCmzjkgmpL+6
	eA9V36dQL/i1eGadLFVuePJ5S7J4ahCEF0b0aNHdvL5WWzveKIhaHD4bpz4HReomRBtzoq
	1wD96HanhHOw3NY52fSxKoegG6y2ADA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-X3r7t21vM8qTPbH03jPE2Q-1; Wed, 11 Feb 2026 03:24:15 -0500
X-MC-Unique: X3r7t21vM8qTPbH03jPE2Q-1
X-Mimecast-MFC-AGG-ID: X3r7t21vM8qTPbH03jPE2Q_1770798255
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8243a081fd2so2924982b3a.1
        for <kexec@lists.infradead.org>; Wed, 11 Feb 2026 00:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770798255; x=1771403055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jg6rUiFx+q06U0spbnVO76byiw3N0jzh2FjIOHbS9H8=;
        b=hRfDKgFIi0f4rw/Aqw8ntRw0ip40q0LrPAhc/kdUasZFaDwJF0gEmjDSTOQiSBYd8s
         eGvC+BZaFHrXNiWmn0beD2MxjnHkvfgQ1oPnqoJ0ce7MXdF3lZv8Q7X3//JOWfHUnJFv
         Jxq8OMxxGKw8CRmne33JRXYsJWCZA/OSAxSbXUjczvI6c2ZXJ0LkoZTKJUvEQ7c2AUei
         rT12cJf7N8gJk2MRrEVehT0Z3c3OGB/WDX5ZPDqew5HbVltdXNRyQSpuTz1HtXGjP3/9
         itSOIG7vPArkMYYb/Q78P0EUG195dqeJ3gryumNNfo1AaoTqTjP6hGRi2774gBEmyY6t
         0Y+w==
X-Gm-Message-State: AOJu0YwjhXlBbbfOgmHR+F3NYfnA4OzWs3fRXu625RPKO3D7rfdr2lU0
	1XHB82O1qjJtAAgfho/m71ZYFpRnEWFieZtfoTtnxpXvQKmNMmkMIc4RzAAFLkMD/hjwa/DpHpY
	kWQju3qmrgMnIWHXrrvCpwrfXtjPvyENuQxiASQFbSofyYEdwPjbSx85KqWg+R0mEye57J9C32Z
	QF3EGiOYhWTanXExcSEc+Z5bxib4GGq/BB4ZqSrfg57tE=
X-Gm-Gg: AZuq6aL8+BA/GyXPcJ+cvUlHSqcm04xQDH120ddrrKsm26R8+ASnc3Plai7fbtEJqDZ
	uizN84yA8q3OaYh65nNcJwGWCeuzghAdbGnMkTPENEJS6doT/we8b+QmqHrk8D3MkDJt6G887Q8
	9vDy1Ofh/ZYXHTQkyCRafNwUDNRoZBKWE6fMFP7tLCCHdRpCA3G9hc6j6WiVccWtVsk6+3cD4NP
	z42YhdWfbTuPR/0jW89haAXsnh2AWUVpALd6KArwxIQXOqutOwQ26N4XFEcNCJOPV4WeunZp3Xz
	UuppBztlmdfgH1ttVYc6AsYmt1Hd0DOhZ72H01yHBOgXaQqaPhPM1+S03OHznjZ1Xo/aK+HH4/Q
	RRQul7ZekAiEi
X-Received: by 2002:a05:6a00:4211:b0:81f:c6d1:d167 with SMTP id d2e1a72fcca58-8249fdf39edmr1252059b3a.61.1770798254549;
        Wed, 11 Feb 2026 00:24:14 -0800 (PST)
X-Received: by 2002:a05:6a00:4211:b0:81f:c6d1:d167 with SMTP id d2e1a72fcca58-8249fdf39edmr1252015b3a.61.1770798253951;
        Wed, 11 Feb 2026 00:24:13 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e7d7136sm1228850b3a.42.2026.02.11.00.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:24:13 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Baoquan he <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel
Date: Wed, 11 Feb 2026 16:24:00 +0800
Message-ID: <20260211082401.2407853-3-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211082401.2407853-1-coxu@redhat.com>
References: <20260211082401.2407853-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pe_J5hr2JDc_r1i18XdaLY8o2AzkaOkEBFrnI7Dcpx4_1770798255
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_002420_388516_E067F43A 
X-CRM114-Status: GOOD (  20.65  )
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

CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
device dump target by addressing two challenges [1],
 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump.

To also enable this feature for ARM64 and PowerPC, we only need to add
a device tree property dmcryptkeys [2] as similar to elfcorehdr to pass
the memory address of the stored info of dm-crypt keys to the kdump
kernel. Since this property is only needed by the kdump kernel, it won't
be exposed to user space.

[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
[2] https://github.com/devicetree-org/dt-schema/pull/181

Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Thomas Staudt <tstaudt@de.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c |  4 ++++
 arch/powerpc/kexec/elf_64.c            |  4 ++++
 drivers/of/fdt.c                       | 21 +++++++++++++++++++++
 drivers/of/kexec.c                     | 19 +++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 410060ebd86d..b6798bb2bb82 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -134,6 +134,10 @@ int load_other_segments(struct kimage *image,
 
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
+
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret)
+			goto out_err;
 	}
 #endif
 
diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index 5d6d616404cf..ea50a072debf 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -79,6 +79,10 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 			goto out;
 		}
 
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret)
+			goto out;
+
 		/* Setup cmdline for kdump kernel case */
 		modified_cmdline = setup_kdump_cmdline(image, cmdline,
 						       cmdline_len);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 331646d667b9..2967e4aff807 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -866,6 +866,26 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 		 elfcorehdr_addr, elfcorehdr_size);
 }
 
+static void __init early_init_dt_check_for_dmcryptkeys(unsigned long node)
+{
+	const char *prop_name = "linux,dmcryptkeys";
+	const __be32 *prop;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DM_CRYPT))
+		return;
+
+	pr_debug("Looking for dmcryptkeys property... ");
+
+	prop = of_get_flat_dt_prop(node, prop_name, NULL);
+	if (!prop)
+		return;
+
+	dm_crypt_keys_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
+
+	/* Property only accessible to crash dump kernel */
+	fdt_delprop(initial_boot_params, node, prop_name);
+}
+
 static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 
 /*
@@ -1097,6 +1117,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 
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
-- 
2.53.0


