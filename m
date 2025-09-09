Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E427CAC583
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zCmAQ9E1zzf2oww3L+0ScmydA57h//TWKN5Ptw1aNtc=; b=YxN57929diodmRMexz9UHimykZ
	o4DWPkrmOIMviT1ly6+WaCFNYZD1x52GjOiG9Dvqdz/EzHqa1yCV87qV6dc/atFCCzxQjWb8naBA/
	sqcOJYAl8yCEDUYArHEBiFXIJ3h1s2W7yFguuKJcZU7vJcRosRV/PKZkTXXf0kV0Rq/QRYjOplktY
	iourNuXbQLYIQ5mLli1T8gs3oUcKqf4nhGGJvvB9R4647l24eyEYN1IWre92X5ucDBGFfPlvuVoDW
	xf4Wpu6IIVaeFnIuSpTzKSPoii4GyoIXYnX5699MbGw7LIaeLVaIYU7i6dbpuiBO4W0CIf5/vpJrW
	klUyBCSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4kn-00000009wBB-0jSx;
	Tue, 09 Sep 2025 20:15:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4km-00000009w9y-1Hyn
	for kexec@bombadil.infradead.org;
	Tue, 09 Sep 2025 20:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zCmAQ9E1zzf2oww3L+0ScmydA57h//TWKN5Ptw1aNtc=; b=Tp7hcDm36diqzioRqgWxDDDZcV
	eVAYXLlft6zCAhEFHvfSOqClSzV6ZqU77g/VgS7zbNkYtZFsjtoyYmHfOfnN6nYEMvsIusb0V12Gr
	pT+Mc3JNNRuvj8uA3zpWMHhdCiAW7IOm+cckxgJA0zdBXewghA/1z6UYHqWgO+xdqUAsR/SEOhsnw
	tyoSd0/XeSMFXBQtXzeTY5QesLqTDxr9lgekb2Mjrc3uwjgpfuMllfpg0w9qSBzcmxqk+WrzXzovl
	8CMy5qHIs3JwVcPSpYK6pmzZiSwlU4dkx3TzYSwfoNSUXtmzxct4aHxDXgnyWRj1cO2VLQ5JhiWRl
	akuGZdXQ==;
Received: from forwardcorp1a.mail.yandex.net ([2a02:6b8:c0e:500:1:45:d181:df01])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4ki-00000005XUl-30Lx
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 20:15:46 +0000
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7FC46C01A1;
	Tue, 09 Sep 2025 23:15:41 +0300 (MSK)
Received: from localhost.localdomain (172.31.115.73-vpn.dhcp.yndx.net [172.31.115.73])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id IFQqlX5GteA0-KRuqVmhs;
	Tue, 09 Sep 2025 23:15:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1757448940;
	bh=zCmAQ9E1zzf2oww3L+0ScmydA57h//TWKN5Ptw1aNtc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=uEzS3uievKUGgVzVo0XM3CO7O2ofI0YqYncCVzgEakehhvnc4qFhCFRVQGZevHwi7
	 CsQOMPEcV3YUF+z629p8DXGKYRKMBn5aPJVuffYv3pT3WEedSZtyRhs7RNlM2tFIQO
	 Rai9V/CC6os2Ibdv73XbRLEYv8Q0/+Dnk2oRckgk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 4/7] kho: replace KHO FDT with kstate metadata
Date: Tue,  9 Sep 2025 22:14:39 +0200
Message-ID: <20250909201446.13138-5-arbn@yandex-team.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250909201446.13138-1-arbn@yandex-team.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_211545_046573_1F9ED7D1 
X-CRM114-Status: GOOD (  19.38  )
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

Store KSTATE physical address & size instead of FDT in kho_data.
and initialize KSTATE from kho_populate().
To be able to use FDT in parallel with KSTATE place FDT
address&size into 'struct kho_fdt' and save/restore it using KSTATE.

This finishes wiring KSTATE with KHO, making it fully functional.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 arch/x86/include/uapi/asm/setup_data.h |  4 +-
 arch/x86/kernel/kexec-bzimage64.c      |  6 +--
 arch/x86/kernel/setup.c                |  3 +-
 drivers/of/fdt.c                       |  6 +--
 include/linux/kexec.h                  |  2 +-
 include/linux/kstate.h                 |  1 +
 kernel/liveupdate/kexec_handover.c     | 60 +++++++++++++++++++++-----
 7 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
index 2671c4e1b3a0..844f5b93473f 100644
--- a/arch/x86/include/uapi/asm/setup_data.h
+++ b/arch/x86/include/uapi/asm/setup_data.h
@@ -83,8 +83,8 @@ struct ima_setup_data {
  * Locations of kexec handover metadata
  */
 struct kho_data {
-	__u64 fdt_addr;
-	__u64 fdt_size;
+	__u64 kstate_addr;
+	__u64 kstate_size;
 	__u64 scratch_addr;
 	__u64 scratch_size;
 } __attribute__((packed));
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 24a41f0e0cf1..1bf9474d4286 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -253,12 +253,12 @@ static void setup_kho(const struct kimage *image, struct boot_params *params,
 	sd->len = sizeof(struct kho_data);
 
 	/* Only add if we have all KHO images in place */
-	if (!image->kho.fdt || !image->kho.scratch)
+	if (!image->kho.kstate || !image->kho.scratch)
 		return;
 
 	/* Add setup data */
-	kho->fdt_addr = image->kho.fdt;
-	kho->fdt_size = PAGE_SIZE;
+	kho->kstate_addr = image->kho.kstate;
+	kho->kstate_size = PAGE_SIZE;
 	kho->scratch_addr = image->kho.scratch->mem;
 	kho->scratch_size = image->kho.scratch->bufsz;
 	sd->next = params->hdr.setup_data;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..eedcf4be8985 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -467,7 +467,8 @@ static void __init add_kho(u64 phys_addr, u32 data_len)
 		return;
 	}
 
-	kho_populate(kho->fdt_addr, kho->fdt_size, kho->scratch_addr, kho->scratch_size);
+	kho_populate(kho->kstate_addr, kho->kstate_size, kho->scratch_addr,
+		kho->scratch_size);
 
 	early_memunmap(kho, size);
 }
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0edd639898a6..f682ef6a1187 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -893,8 +893,8 @@ static void __init early_init_dt_check_kho(void)
 	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
 		return;
 
-	fdt_start = dt_mem_next_cell(dt_root_addr_cells, &p);
-	fdt_size = dt_mem_next_cell(dt_root_addr_cells, &p);
+	kstate_start = dt_mem_next_cell(dt_root_addr_cells, &p);
+	kstate_size = dt_mem_next_cell(dt_root_addr_cells, &p);
 
 	p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
 	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
@@ -903,7 +903,7 @@ static void __init early_init_dt_check_kho(void)
 	scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
 	scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
 
-	kho_populate(fdt_start, fdt_size, scratch_start, scratch_size);
+	kho_populate(kstate_addr, kstate_size, scratch_start, scratch_size);
 }
 
 #ifdef CONFIG_SERIAL_EARLYCON
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 39fe3e6cd282..ebf70361269f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -416,7 +416,7 @@ struct kimage {
 
 	struct {
 		struct kexec_segment *scratch;
-		phys_addr_t fdt;
+		phys_addr_t kstate;
 	} kho;
 
 	/* Core ELF header buffer */
diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index 53992593cb19..5a95960e5b03 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -94,6 +94,7 @@ struct kstate_field {
 
 enum kstate_ids {
 	KSTATE_FOLIO_ID = 1,
+	KSTATE_KHO_FDT_ID,
 	KSTATE_LAST_ID = -1,
 };
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index f1c6378b2657..216cb58553d6 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -806,6 +806,10 @@ int kho_abort(void)
 		goto unlock;
 	}
 
+	ret = kstate_abort();
+	if (ret)
+		goto unlock;
+
 	ret = __kho_abort();
 	if (ret)
 		goto unlock;
@@ -984,6 +988,25 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
+
+#define KHO_FDT_INSTANCE_ID 1
+
+static struct kho_fdt {
+	phys_addr_t fdt_phys;
+	u64 fdt_len;
+} kho_fdt;
+
+struct kstate_description kho_fdt_state = {
+	.name = "kho_fdt",
+	.version_id = 1,
+	.id = KSTATE_KHO_FDT_ID,
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(fdt_phys, struct kho_fdt, phys_addr_t),
+		KSTATE_BASE_TYPE(fdt_len, struct kho_fdt, u64),
+		KSTATE_END_OF_LIST()
+	},
+};
+
 static __init int kho_init(void)
 {
 	int err = 0;
@@ -1000,13 +1023,20 @@ static __init int kho_init(void)
 	}
 	kho_out.fdt = page_to_virt(fdt_page);
 
-	err = kho_debugfs_init();
+	err = kstate_register(&kho_fdt_state, &kho_fdt, KHO_FDT_INSTANCE_ID);
 	if (err)
 		goto err_free_fdt;
 
+	kho_fdt.fdt_phys = page_to_phys(fdt_page);
+	kho_fdt.fdt_len = PAGE_SIZE;
+
+	err = kho_debugfs_init();
+	if (err)
+		goto err_free_kstate;
+
 	err = kho_out_debugfs_init(&kho_out.dbg);
 	if (err)
-		goto err_free_fdt;
+		goto err_free_kstate;
 
 	if (fdt) {
 		kho_in_debugfs_init(&kho_in.dbg, fdt);
@@ -1025,6 +1055,8 @@ static __init int kho_init(void)
 
 	return 0;
 
+err_free_kstate:
+	kstate_unregister(&kho_fdt_state, &kho_fdt, KHO_FDT_INSTANCE_ID);
 err_free_fdt:
 	put_page(fdt_page);
 	kho_out.fdt = NULL;
@@ -1165,24 +1197,30 @@ static int __init kho_scratch_init(phys_addr_t scratch_phys, u64 scratch_len)
 	return err;
 }
 
-void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
-			 phys_addr_t scratch_phys, u64 scratch_len)
+void __init kho_populate(phys_addr_t kstate_phys, u64 kstate_len,
+			phys_addr_t scratch_phys, u64 scratch_len)
 {
-
 	int err = 0;
-	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 
-	err = kho_fdt_init(fdt_phys, fdt_len);
+	err = kho_scratch_init(scratch_phys, scratch_len);
 	if (err)
 		goto out;
 
-	err = kho_scratch_init(scratch_phys, scratch_len);
+	err = kstate_early_init(kstate_phys, kstate_len);
+	if (err)
+		goto out;
+
+	err = kstate_restore(&kho_fdt_state, &kho_fdt, KHO_FDT_INSTANCE_ID);
+	if (err)
+		goto out;
+
+	err = kho_fdt_init(kho_fdt.fdt_phys, kho_fdt.fdt_len);
 	if (err)
 		goto out;
 
-	kho_in.fdt_phys = fdt_phys;
+	kho_in.fdt_phys = kho_fdt.fdt_phys;
 	kho_in.scratch_phys = scratch_phys;
-	kho_scratch_cnt = scratch_cnt;
+	kho_scratch_cnt = scratch_len / sizeof(*kho_scratch);
 	pr_info("found kexec handover data. Will skip init for some devices\n");
 
 out:
@@ -1201,7 +1239,7 @@ int kho_fill_kimage(struct kimage *image)
 	if (!kho_enable)
 		return 0;
 
-	image->kho.fdt = virt_to_phys(kho_out.fdt);
+	image->kho.kstate = kstate_out_paddr;
 
 	scratch_size = sizeof(*kho_scratch) * kho_scratch_cnt;
 	scratch = (struct kexec_buf){
-- 
2.49.1


