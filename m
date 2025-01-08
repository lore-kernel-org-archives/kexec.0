Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270C2E77188
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0jr6jtY+a/6uK4MIkuZ3gaQWU+DzTIgpKl/TdDtWvr8=; b=O6OchD7D+vQM2H50KDjtogXJZl
	yc0YqZ0pzoM1Evv49Jkdyn8MPPxN+C+5bk+G75d3CXxJGsPEjfYkJKSmtENs+twe+FTGA9UpezQjp
	YF2P9aAgsLY3VJw0ja4a5dDlNFbgD7rgpX5Z+EvCCkxRt4LRgBnwcJHqe82DNgho5xpQfzq2Ktyry
	F/I1wOY2sKfkJymRKtu/PHi52WKqOimgUlykRFnsGqIsK8xn/ix5AShsuoZyYjOfgxDcgwy+QiYzO
	C1I001DMc6bWpNnA/GpV7eYUoRDCXRMZSJKTvpfOnRr0g83gmJEIFtlqQLT3SGr0gW+2SbIcNE0GS
	4OtpMnNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVe6C-00000009xaB-29Bn;
	Wed, 08 Jan 2025 22:00:24 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVe6A-00000009xZS-2bF1
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 22:00:23 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6d8f916b40bso3960916d6.3
        for <kexec@lists.infradead.org>; Wed, 08 Jan 2025 14:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736373621; x=1736978421; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jr6jtY+a/6uK4MIkuZ3gaQWU+DzTIgpKl/TdDtWvr8=;
        b=MCG+hQKHt5EwmXXL6ePPdlB401h6iHqVgoBdZei2toOnQK11herHixEuxY3g/YTtYp
         CLi0bIsqEKzbqoA4DWex+QUm9+28L7UkUsW2+XD2kV/q/5Yt8kemiYD3lBUvSUIY/aRL
         YAgfXPjSX3PixzdpzrdtRuza/fTrE6Z0tLKdipEjTiynnhegGZV438u3WAFX2eNpHm3s
         fPZcV0MsRgiZ+ZEzowrW1aNk8c5Uaiubm5VTZaJ8aPNwJ75cj+brUJmZipiedslYwjJe
         Q82VihenIolmO6ptbBFYQM1TQbH/F35DRbBLxh3lUOrBYdlfUKEdDeN7ITeQYaUhrv1p
         VTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736373621; x=1736978421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jr6jtY+a/6uK4MIkuZ3gaQWU+DzTIgpKl/TdDtWvr8=;
        b=eVUG9zLUrCDjpignLMhLVejVVrlH65zrt+M33wxf5EJaAJoLV2qQmwHB82ksudkTyU
         gSLu2buL7rQMsXYGyRlo2iNlcK2oZ1ZQKL47moQ5FbyOomECx0VZEcRg295VA6FehmCV
         S4BoM1QzXX3rO/u6vX6mhRhIXCwPDEVsQz1eSzSrgPOKMtGoeArMLEg93ryS9+EsNfOU
         Xoe3pDp/S2Mz1XXdNXr7IzXhIcVwwB+pwpJ2i92mMFHr5cT65eozUWHNTpuUg7WXgVCY
         ShEHEP0q+46lRAjazNIW163ENEVUg9S0rG306Z3FzcD4rAIU4bzsrnMQp6ufNfse0TM0
         cwOA==
X-Forwarded-Encrypted: i=1; AJvYcCVa4O5cFsMx5lwUSZktviwwlcBlt9yGVjxbZcExC5QqZ6QVPVFwFg642w2NIaiUqwmH+H8IDA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzTJI/LVnyc4nxOMPOeDmhCytDvZVcSZ59QLKICJEXLh9u9nz/8
	SFQuQw8Izk3IyFQCbjx+rnFiZkHKpH9KSbX/b3pTM7ZBcMMLLJ/r
X-Gm-Gg: ASbGncu/tAafr/HFQqba/Lvpu2J3Chlds/5ZQxD0viS6amTCPor6G74QsW4qdlsKvGK
	Ef5eGefyK8KiEIov653QjqWuW1V0c2HygH9DC3CQ7q8iOGUH+8FP6PnhgCV5CeeygHQ2MNoxzjo
	OAXcgJ46LcY7I9vVcDFADzTBz4KgweiosTmvCIdOEeoWG202RMGZ5+GCbxQg7iClgp6HSVkmyK4
	2LUc1CBpUdqzZjZqO9ajUCAwJEcPdr6f+wpBFTPBiA2z8GYFVKpH5w=
X-Google-Smtp-Source: AGHT+IGYAtV0NWg+g25XA8prhBZQtnI1Wq2npFdzbcYk2MRvl9G6tk69B/IbxPWv68nknyTKZ78xgA==
X-Received: by 2002:ad4:5d61:0:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6df9b28c6aemr74791756d6.34.1736373619641;
        Wed, 08 Jan 2025 14:00:19 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:40::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd3c151877sm165560896d6.127.2025.01.08.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:00:19 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: linux-efi@vger.kernel.org,
	devel@edk2.groups.io,
	kexec@lists.infradead.org
Cc: ardb@kernel.org,
	hannes@cmpxchg.org,
	dyoung@redhat.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org,
	gourry@gourry.net,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC 1/2] efi/memattr: Use desc_size instead of total size to check for corruption
Date: Wed,  8 Jan 2025 21:53:36 +0000
Message-ID: <20250108215957.3437660-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108215957.3437660-1-usamaarif642@gmail.com>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_140022_662111_22FC0CA8 
X-CRM114-Status: GOOD (  16.80  )
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

The commit in [1] introduced a check to see if EFI memory attributes
table was corrupted. It assumed that efi.memmap.nr_map remains
constant, but it changes during late boot.
Hence, the check is valid during cold boot, but not in the subsequent
kexec boot.

This is best explained with an exampled. At cold boot, for a test
machine:
efi.memmap.nr_map=91,
memory_attributes_table->num_entries=48,
desc_size = 48
Hence, the check introduced in [1] where 3x the size of the
entire EFI memory map is a reasonable upper bound for the size of this
table is valid.

In late boot __efi_enter_virtual_mode calls 2 functions that updates
efi.memmap.nr_map:
- efi_map_regions which reduces the `count` of map entries
  (for e.g. if should_map_region returns false) and which is reflected
  in efi.memmap by __efi_memmap_init.
  At this point efi.memmap.nr_map becomes 46 in the test machine.
- efi_free_boot_services which also reduces the number of memory regions
  available (for e.g. if md->type or md->attribute is not the right value).
  At this point efi.memmap.nr_map becomes 9 in the test machine.
Hence when you kexec into a new kernel and pass efi.memmap, the
paramaters that are compared are:
efi.memmap.nr_map=9,
memory_attributes_table->num_entries=48,
desc_size = 48
where the check in [1] is no longer valid with such a low efi.memmap.nr_map
as it was reduced due to efi_map_regions and efi_free_boot_services.

A more appropriate check is to see if the description size reported by
efi and memory attributes table is the same.

[1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/

Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 drivers/firmware/efi/memattr.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index c38b1a335590..d3bc161361fb 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -40,21 +40,17 @@ int __init efi_memattr_init(void)
 		goto unmap;
 	}
 
-
 	/*
-	 * Sanity check: the Memory Attributes Table contains up to 3 entries
-	 * for each entry of type EfiRuntimeServicesCode in the EFI memory map.
-	 * So if the size of the table exceeds 3x the size of the entire EFI
-	 * memory map, there is clearly something wrong, and the table should
-	 * just be ignored altogether.
+	 * Sanity check: the Memory Attributes Table desc_size and
+	 * efi.memmap.desc_size should match.
 	 */
-	size = tbl->num_entries * tbl->desc_size;
-	if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
-		pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
-			tbl->version, tbl->desc_size, tbl->num_entries);
+	if (efi.memmap.desc_size != tbl->desc_size) {
+		pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, table desc_size == %u, efi.memmap.desc_size == %lu, table num_entries == %u)\n",
+			tbl->version, tbl->desc_size, efi.memmap.desc_size, tbl->num_entries);
 		goto unmap;
 	}
 
+	size = tbl->num_entries * tbl->desc_size;
 	tbl_size = sizeof(*tbl) + size;
 	memblock_reserve(efi_mem_attr_table, tbl_size);
 	set_bit(EFI_MEM_ATTR, &efi.flags);
-- 
2.43.5


