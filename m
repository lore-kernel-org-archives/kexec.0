Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5727FE9B25A
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 06:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jAZI4/OSU4kBMOxoXJVKa+WF0ADBr7+Jm8V1UGkVmOI=; b=sH00z5w65nNWoHsG+Udx00ZaFZ
	b3nRuaU1Zruk6cR/t/yTq/2qj8p7/htrJdufVoVw1SCKJno7vMHRJF0nmbo5Xkatp8LQFZDMoRdL4
	iHPChtCekbBdQrLHinmWCTTKZpz+bdNKxxVuuq5u5ixfKO+YeIR382rk7sukaci6K6umfuuDgjJLE
	z2BHgVj9jwIM2Yn2dbiWrD/v5ln2/lpHdFJNj3av+LYuNLali67Iq1ko7gqz6KPvAvwOKY3i15vYv
	Zd0liM9oe3nbj5yWoBokPyBIlsMoNLBI/2k2CahaiGq3svTpeofrJHnIzK0jqHG+nEidUW/LD+V5R
	LBx8OpaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv80M-00000003HBl-1HUA;
	Wed, 25 Feb 2026 06:04:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv80J-00000003H94-1SVO
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 06:04:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771999450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAZI4/OSU4kBMOxoXJVKa+WF0ADBr7+Jm8V1UGkVmOI=;
	b=avREh4q+56nuepxpNGgyDeTUbUkBUs6WDmmriDZzNp6ql/RjFlNBZ4sLKHROfi0/9FHC4/
	A68gv+uDQ9+uuRQlXlBqh7TXr/dam3UsBx00zkeBoJ43E4sXTdOBwNz7k8wDzKnmzm6876
	hgu3dQxkmz7IxXCtU5n3NMhdMV/bUDw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-AyYVW3K3PdK2WXANCfW8KA-1; Wed, 25 Feb 2026 01:04:08 -0500
X-MC-Unique: AyYVW3K3PdK2WXANCfW8KA-1
X-Mimecast-MFC-AGG-ID: AyYVW3K3PdK2WXANCfW8KA_1771999448
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70b75aea3aso2569055a12.0
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 22:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771999447; x=1772604247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jAZI4/OSU4kBMOxoXJVKa+WF0ADBr7+Jm8V1UGkVmOI=;
        b=KNCHFSr+Ibfc6OLh/qsE9+fTjCKQuRMJQui6grZ0vIWSFvoNUsR4kncvqI+vqQ1fx6
         5UXSNkCNEYYx/vitVSzkuyn4VluI22pmF530rI3nhzNpBWEEt47iYA1GNO+HYdCLJMRA
         ePSwQCDWItmavZ9zZtt/GW/J9SCR4+XcoK9E8UHdG+fwKJ4+GawxwPzL3QgusYgSLZa3
         1UztGnZCRPOb71NT7Gg+r3RK0WQY9Bgmc0SIyC8B5z2zevYPIRxbgBrNfE8iy1KP142H
         GGfywysqMj1ycSn4Hl1O2iB9m8kLwiGUPUPTG++7tJPHxqr2NjHODcx5HuRSxVGyoqaz
         QLTw==
X-Gm-Message-State: AOJu0YxdtSxmyJXyJLnew4Ul2ojC0WhcPCJEM3n361vE5UZOfLUr3gQh
	RBDGo70AHjgwkGPtWdB/jBgf94Cg6AzRAvuz/5LbFfD73vOpRWNTbjvzoQejtz8NY1V5HzIAp15
	0e5EqUgy3EZOSU/szGLYeBal17526PA/6Ivlg2KZcV2Ey48fDT+JzOpL8o2lHVLANzWqCYpt/FN
	KUI4KLgrn5OBViC2x7XQ/gThh6p4CLd3e9xJ0ooCG4goQ=
X-Gm-Gg: ATEYQzyV2Dc27EDrGeqn4FvEgsp1qH1gL7nr8+trHfH4BqtkH+L0H87bJ7LAQ18Mnpf
	+4uFHK6FPdHi74gC3gtEbkaeRNSDl7e6UG3kLZ0TLK8rVf9gPghPT/dfrWvyVlqP9+im/krLu1Q
	dAS5ZgcuLE/gIwIPsEtWuCCoa7iSYdtTjpXaRCC+z3Xbh2GBVGaH5YfSYNPLpRd5DROP1L1Otkd
	xTfJmR8oX0cKxbIyIxaA4/xHjlKGaNl3oTmCGMyy720YqFxKwicDKMRHCz+nVxUOuAGTt8SOF6i
	LaqC95TMM8R+f2t5sUgZL97r93RDfYfiLBAyqCJO+McR3isbsWaCcJUyUhDoYNkm2mMx379IXQR
	IxPBtfHJsOwDG
X-Received: by 2002:a05:6a00:2997:b0:824:adf4:5a32 with SMTP id d2e1a72fcca58-826daa01ffcmr10872390b3a.42.1771999447222;
        Tue, 24 Feb 2026 22:04:07 -0800 (PST)
X-Received: by 2002:a05:6a00:2997:b0:824:adf4:5a32 with SMTP id d2e1a72fcca58-826daa01ffcmr10872341b3a.42.1771999446454;
        Tue, 24 Feb 2026 22:04:06 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ecb2dsm12330215b3a.60.2026.02.24.22.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 22:04:06 -0800 (PST)
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel
Date: Wed, 25 Feb 2026 14:03:46 +0800
Message-ID: <20260225060347.718905-4-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225060347.718905-1-coxu@redhat.com>
References: <20260225060347.718905-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WyZkLf6_UvsXyldOLZ9MyuUbt9kyl7OcJVp74M67HsE_1771999448
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_220411_460423_A0DBD0A1 
X-CRM114-Status: GOOD (  22.34  )
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

To also enable this feature for ARM64 and PowerPC, the missing piece is
to let the kdump kernel know where to find the dm-crypt keys which are
randomly stored in memory reserved for kdump. Introduce a new device
tree property dmcryptkeys [2] as similar to elfcorehdr to pass the
memory address of the stored info of dm-crypt keys to the kdump kernel.
Since this property is only needed by the kdump kernel, it won't be
exposed to user space.

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
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c |  4 ++++
 arch/powerpc/kexec/elf_64.c            |  4 ++++
 drivers/of/fdt.c                       | 21 +++++++++++++++++++++
 drivers/of/kexec.c                     | 19 +++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index fba260ad87a9..e31fabed378a 100644
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
index c4cf3552c018..fbd253f0d3c5 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -423,6 +423,25 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
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


