Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8D2C5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 10:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uSbfStPdbr5U0zykVDsBNKewNVAMS5oNdmlQT4Yzkm4=; b=zQumXRRQYMHEEo2c0W/ZuY70Pc
	EsXjjXe3XsqzmiZYI8Fhp4A2Fa08OR+RJI/zpA9T8I3wsl2OVkKiknyVdDUp+9s5gkKRiEps0uEJE
	Ynz28W/QI+VXg3GaTZ2/WI/2UkOpNGDKh8VgmMuM6Eoo01gm5dNHza2O513YtQk5sDxaMC8Wkp6Uu
	nWeghQ4KBxcgcHRG1bG6uCsrxQSw1uDbhYITBDKFaQsuBrV7g1ksIkcqo8MFXZI0UQa2NKjQZ7YTh
	MQ+JnzN32Fd1CHZ+vc/Jg9jUxxC35GITq8T1KVJ3LfIozxwS6lZICDLulv8GV1kRM0TfTcrgdfZ7k
	Lh8qH0Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM95-0000000D1Pb-1Wve;
	Fri, 21 Aug 2026 10:06:43 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM90-0000000D1If-3ONM
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 10:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=uSbfStPdbr5U0zykVDsBNKewNVAMS5oNdmlQT4Yzkm4=; b=JpgEkXdvDryDyqfLO0w6yqBV2Y
	po9ZYmBcuuqI6K+8Bngw5grb44nVueQqJqyMib3N12wBXWSTP3kfjJpViJ/KqsWS10+pKLtQXroux
	3zs72OdNSfraFY5tvnzRIMOPasTACbKrv7irFHssTWRMwqkrZqxqF0MgtrFDskCuCuzMiWDGyv6n9
	11trmB9cEpvrFyXbSHx4T5gRUqghgL+4kERDaojynRBBe69+Mh5YZDRTMfp6hEMJx1f42y+Cp4faK
	Ve9zBMAX0DYXQaEPNx1lahDGe0fDgiLNriggWzRHsW40wDi10ol3DFJsI0eC7vYI9TeACJDS9Xezb
	OgZtd8zg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxM8p-00BGBE-2w;
	Fri, 21 Aug 2026 10:06:28 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Aug 2026 03:06:01 -0700
Subject: [PATCH v2 1/6] efi/libstub: add a helper for the top of usable RAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-hwpoison-kho-v2-1-5743791e48e6@debian.org>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
In-Reply-To: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, kas@kernel.org, riel@surriel.com, 
 kexec@lists.infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=3412; i=leitao@debian.org;
 h=from:subject:message-id; bh=zsnCaEJjr4WDYRVIG0kIJ3bs7R9uvNp2xzudAoWoA6U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqiCMa+W8jcyD0u0SyGOn1kbwZALutc1lA3Zhhy
 qAmTakDK4KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaogjGgAKCRA1o5Of/Hh3
 bT35D/9SVn4DqMGqAj5kaAZRL6R7KVMcpYT4xdA1bnQ36xXLRr6PlPIy3/U/Avm8oLzAWW8h0/T
 dSpko6t2GqNkpZYSY8IuELnOGbhlzMtTySVLrEXxcH4gCWWYdxgetVxBTgtJj+9bAiLd3dUhji0
 hg7W+VVaskZGhLAenosUqpF3/mwgIO8JWuf55/DrJj9ZY05EBcaU/eWyyZqDvRNX9ENWezAHfYW
 gDXz2Ib7cyRJSknqb1J0FAFM+xUaiV2P0X0wq2+jyk0COyMd5wWOAMGUc764hQXhmEV2MlVr+Qi
 LXWEpp9encGy7VnT7uDYRXg8kWsAK/19ivwcBlYO+tuXOmRb7RiB+OkURRv2nqb7Azd0XmlItJn
 CvbWlmSOoS06/vNZhmzAIFuJ5yf8tZaJEmEkuRa1q7MMcNJtIdA0YDceKm2kt/bbf+hoDgqJz2K
 qNYqHn1BWMoR4VIbM+ZrpSSTAr3OCpuXF2le6KrbP0PHb+SG1MPSGJTPKIr5TMJAUR+/jrX04xV
 9WUeW4FasYe5O9C/izHkbKCql1JrHv2/q2cUPN4rCwjPhPW9QA6eVgETQ/8hXeAf7V/YxYojrlY
 GkMu0GuBk6f3sfjOtJfAKfXRyVu6l4ljhLKWQ3v54aBtxVD8PKnUSLn91ZD6FH6E6PwfWdVKIYu
 kW1eajB8O7w2lFg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_030638_860853_6DF20EB6 
X-CRM114-Status: GOOD (  17.90  )
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

The stub has no way to ask how far RAM reaches, which is useful to
create a bitmap that covers the whole memory.

max_pfn answers that for the kernel, but it is only set in
setup_arch(), long after the stub has handed off, so, unfortunately we
cannot use it here..

Add efi_get_ram_top(), which returns the highest address reached by the
entry types that become usable RAM. Unaccepted memory is counted as
well, as suggested by Kiryl.

Memory the firmware hot-adds later is *not* in the memory map, so it is
not covered; that matches max_pfn, which is likewise the top of the
memory present at boot.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/libstub/efistub.h |  2 ++
 drivers/firmware/efi/libstub/mem.c     | 53 ++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index fd91fc15ec810..77ba576779aca 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1094,6 +1094,8 @@ char *efi_convert_cmdline(efi_loaded_image_t *image);
 efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
 				bool install_cfg_tbl);
 
+efi_status_t efi_get_ram_top(u64 *top);
+
 efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 				unsigned long max);
 
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 59f3f83de50c2..777f1f180c66e 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -64,6 +64,59 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
 	return EFI_SUCCESS;
 }
 
+/**
+ * efi_get_ram_top() - find the top of usable RAM
+ * @top:	on return, the end of the highest memory map entry that becomes
+ *		usable RAM
+ *
+ * Walk the UEFI memory map for the entry types that become usable RAM, the set
+ * setup_e820() maps to E820_TYPE_RAM, and return the highest address any of
+ * them reaches. Memory a confidential guest has not accepted yet counts as
+ * well, since it becomes RAM once accepted. This is what the stub has in place
+ * of max_pfn, which is only set once the kernel proper is up.
+ *
+ * Memory the firmware hot-adds later is not described by the memory map and so
+ * is not accounted for here.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_get_ram_top(u64 *top)
+{
+	struct efi_boot_memmap *map __free(efi_pool) = NULL;
+	efi_status_t status;
+	u64 ram_top = 0;
+	int i, nr_desc;
+
+	status = efi_get_memory_map(&map, false);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	nr_desc = map->map_size / map->desc_size;
+	for (i = 0; i < nr_desc; i++) {
+		efi_memory_desc_t *d;
+
+		d = efi_memdesc_ptr((unsigned long)map->map, map->desc_size, i);
+		switch (d->type) {
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_CONVENTIONAL_MEMORY:
+		case EFI_UNACCEPTED_MEMORY:
+			ram_top = max(ram_top,
+				      d->phys_addr + d->num_pages * EFI_PAGE_SIZE);
+			break;
+		default:
+			break;
+		}
+	}
+	if (!ram_top)
+		return EFI_NOT_FOUND;
+
+	*top = ram_top;
+	return EFI_SUCCESS;
+}
+
 /**
  * efi_allocate_pages() - Allocate memory pages
  * @size:	minimum number of bytes to allocate

-- 
2.53.0-Meta


