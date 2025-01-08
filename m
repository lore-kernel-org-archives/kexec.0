Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27707E77199
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HeT4ErdiiGPVV6JW5GrqxuTR4ROk2Xofm4urABtvZA8=; b=Ze10NSnfb8QXBhmIsidiwY5C1A
	oHh81T9pk0fw0/3jsuKP4gaEtqLoyhbqU1Wu5hkgA+r4gBBp5huaFkN3545ctmFu80afiZYQHbhlg
	ZOlp57MV2aSEcyNHwlwSpom/uWyNT9V+HRxHmSjwK6NoRoYDsa0lrEOhBOqqDoWtuvNd/NpQV1xdd
	eKAautbF3YM9IsrDksb6KU2EnMITHELDEQYsabuuMv3A3qC9t3efvYCvaychaRbqcthHJLRnXJv1Y
	lc9OP612MdCTzxKNPrK0ctXdLoBgbOGXj0RRT98WYpY5hzgD/8wHh3kwgJ+XBUJFUYf6qspbVx7pe
	3mgE/ARA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVe6B-00000009xZh-0YTK;
	Wed, 08 Jan 2025 22:00:23 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVe67-00000009xYu-34Rr
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 22:00:21 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6dd01781b56so3493336d6.0
        for <kexec@lists.infradead.org>; Wed, 08 Jan 2025 14:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736373618; x=1736978418; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HeT4ErdiiGPVV6JW5GrqxuTR4ROk2Xofm4urABtvZA8=;
        b=Alx5I4KmVNsRz9P1BIpKbPCl0J3qpCy8jAeXiE3m5/gBW+OdjKwBQ/ziJN2OVgq5fn
         ajkyLIxpbkPmeVtckG5sYn5HJzFM5WG+fs+CG8sr7ZGmLTHUdpZC7knwaiYreysvrsUj
         U86r/vvhXBNvyWD39xnwgZ9afQIqe7SqbxdUT3E1rAkFjUZYtG9DRF17Y21fEDuxI/8i
         MU7UoGpT5NtEdOTjg4p0nvnapuOp76tKkfcTECxDl0PhftT+ZbFiZioraP0IEX2sz8pT
         4Z1296Iw57EQUnyFJrluNRb9W/+K4ytyaGIyOZ84YDPJv4+/mz51rZX6FkgAn0nmNiHi
         AclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736373618; x=1736978418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeT4ErdiiGPVV6JW5GrqxuTR4ROk2Xofm4urABtvZA8=;
        b=PuOOiK3uPFkQ/MQYlNyFfRZIPr9vZk5MzMC5Jso7K1h6g4ng0UioyveBVSOtWcNFNo
         3feHGfrMc9dxxb17iM9HG/9zPiFR1eqI28cS3wUE7CaYBQZyKsF2E8F7Z2Xg+lqJ1YNL
         wpbLaFQpBd3viHDDbdZkV6hTYL6l6R4/4YYGzgWcDRomnri6+qayfQKXh06OtmfXPefi
         scvhbEcO/h1LHBU7eb4kcrye29CSkU7KxTVfGa4HVwYAuA/l5TrrE53STDyHVEt+hoJl
         KNFYAPi93tqDTc85VJ1ml9Ml0ig4S6gy2xGRxOV0e3Mj6XPj6SCg5MvvCTB8OztOBMbI
         fdVA==
X-Forwarded-Encrypted: i=1; AJvYcCXxrdQwlI26g4Sx14IRLC80E5Pnf2jbUHi15G6SfK5Xh4WtO8HwoqviEFd4B/hcP5QHFD32eg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyUwnpxE2utWHS0I6vUlb1O5wsgiIy8OfHTOPpT4CS0ec8IiXP0
	IR6EzzsjxqeiiUe/bXATrHaC/Vjfl4YH76pRpwnnmL9WgLsvZ104TmtzAIAk
X-Gm-Gg: ASbGncuxr4x/aoX4CtGLk9K5SBYcIhK1J9CecGBE9nj/WkF6mRg9JWyPTQZEumBheGn
	9BcDYXbCb550TAyK4QkW/unhGPVgzu/sm26l/6zTeGzdB1yLW3rcGbT0C9NBq88GoAn9YtGiQaJ
	QSXp7eriQDnxgcEco6i7Kl8E6M2TxdNoQzjX/W4OVdLxCIvWfn+nc9tP2wuRTd8lReIlhglsbLM
	WwC3vqaZ+6mS8iDxrhajvGt3u2S+j21spZSCWtt2u2/gU2oTS/cPNE=
X-Google-Smtp-Source: AGHT+IF4hH60nxcnGXdqVmtHpLDsAQ0bc+xnqwT1KrZUp9d8EtouYvj31KMcJ5KbHMY1SOUkw+kr9g==
X-Received: by 2002:a05:6214:e8b:b0:6d8:81cd:a0ce with SMTP id 6a1803df08f44-6df9b327016mr89269066d6.43.1736373617535;
        Wed, 08 Jan 2025 14:00:17 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:72::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1813858csm194311126d6.70.2025.01.08.14.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:00:16 -0800 (PST)
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
Subject: [RFC 0/2] efi/memattr: Fix memory corruption and warning issues
Date: Wed,  8 Jan 2025 21:53:35 +0000
Message-ID: <20250108215957.3437660-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_140019_787944_826A8196 
X-CRM114-Status: GOOD (  23.56  )
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

Since the patch with the warning in [1] was merged, a very significant
number of kexec boots are producing the warning in our (Meta) fleet.

I believe there are 2 problems, the warning itself might not be
triggered on the right condition, and memory attributes
table is getting corrupted.
An example of the warning when its not triggered correctly and
is fixed by patch 1:
efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 2, desc_size == 48, num_entries == 48)
An example of the warning when memory attributes table
is getting corrupted and might possibly be fixed by patch 2:
efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 1, desc_size == 2072184435, num_entries == 3248688968)
Its clear that the desc size and num_entries are wrong.

The logic behind patch 1 is explained in its commit message.

The memory corruption is looking very similar to the problem that was
fixed by 77d48d39e99170 ("efistub/tpm: Use ACPI reclaim memory for
event log to avoid corruption"), but this time with memattr table,
where it might not be preserved during kexec. I have
not been able to reproduce this in the test machine I have
over the past couple of days (hence marked as RFC) , but its
happening often in our prod.
When this area is not reserved, it comes up as usable in
/sys/firmware/memmap. This means that kexec, which uses that memmap
to find usable memory regions, can select the region where
efi_mem_attr_table is and overwrite it and relocate_kernel.

Having a fix in firmware can be difficult to get through.
The next ideal place would be in libstub. However, it looks like
InstallMemoryAttributesTable [2] is not available as a boot service
call option [3], [4], I tried to use install_configuration_table as
a substitute, but its not valid and corrupts the MemoryAttributesTable.
The prints I got from the below code in coverletter were:
EFI stub: ERROR: KKK tbl 5f19e018 tbl_>version=1, tbl->num_entries 48 tbl->desc_size 48
EFI stub: ERROR: KKK2 tbl 67184018 tbl_>version=2048, tbl->num_entries 0 tbl->desc_size 0
which shows the table got corrupted. This can bee seen in the kernel boot as well after
(with the version showing up as 2048).

As a last option for a fix, the patch marks that region as reserved in
e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
use it for kernel segments.

[1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
[2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
[3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
[4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327


diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d33ccbc4a2c6..a1a956f2d963 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1143,6 +1143,7 @@ efi_enable_reset_attack_mitigation(void) { }
 #endif
 
 void efi_retrieve_eventlog(void);
+void efi_mem_attr_init(void);
 
 struct screen_info *alloc_screen_info(void);
 struct screen_info *__alloc_screen_info(void);
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 4f1fa302234d..c5b60aea342e 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -128,3 +128,35 @@ void efi_free(unsigned long size, unsigned long addr)
        nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
        efi_bs_call(free_pages, addr, nr_pages);
 }
+
+void efi_mem_attr_init(void)
+{
+       efi_guid_t linux_mem_attr_guid = EFI_MEMORY_ATTRIBUTES_TABLE_GUID;
+       efi_memory_attributes_table_t *tbl = NULL;
+       efi_status_t status;
+       unsigned long size;
+
+       tbl = get_efi_config_table(linux_mem_attr_guid);
+       efi_err("KKK tbl %lx tbl_>version=%d, tbl->num_entries %d tbl->desc_size %d\n", tbl, tbl->version, tbl->num_entries, tbl->desc_size);
+
+       size = tbl->num_entries * tbl->desc_size;
+       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
+                            sizeof(*tbl) + size, (void **)&tbl);
+
+       if (status != EFI_SUCCESS) {
+               efi_err("Unable to allocate memory for event log\n");
+               return;
+       }
+
+       status = efi_bs_call(install_configuration_table,
+                            &linux_mem_attr_guid, tbl);
+
+       if (status != EFI_SUCCESS)
+               efi_err("Unable to install configuration table to update memory type\n");
+       efi_bs_call(free_pool, tbl);
+
+       /* verify if its the same table */
+       tbl = get_efi_config_table(linux_mem_attr_guid);
+       efi_err("KKK2 tbl %lx tbl_>version=%d, tbl->num_entries %d tbl->desc_size %d\n", tbl, tbl->version, tbl->num_entries, tbl->desc_size);
+
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f8e465da344d..c0c3d278451d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -1036,6 +1036,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
        efi_retrieve_eventlog();
 
+       efi_mem_attr_init();
+
        setup_graphics(boot_params);
 
        setup_efi_pci(boot_params);
 
Usama Arif (2):
  efi/memattr: Use desc_size instead of total size to check for
    corruption
  efi/memattr: add efi_mem_attr_table as a reserved region in
    820_table_firmware

 arch/x86/include/asm/e820/api.h |  2 ++
 arch/x86/kernel/e820.c          |  6 ++++++
 arch/x86/platform/efi/efi.c     |  9 +++++++++
 drivers/firmware/efi/memattr.c  | 17 +++++++----------
 include/linux/efi.h             |  7 +++++++
 5 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.43.5


