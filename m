Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2E6E77188
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lxzi816vsV82LbZekUeaxCWiwSFstfTOO/juIDysp+o=; b=CiEItPxkJWFX4ixzEe4XqYQWoI
	eKJen/HF0lyp85tizI8T6qhJ6fVg5Jwth5JXipRYeZZW3muHTwcWHL4HYQJs1eKuUg1sRgkeR2pfa
	D8uyPOCt2M/VoH6X+77s3rfcPwGzx62kBuEDJTA/Otb/Pw8kbZAWoW08SLwY6XabYVJGB808xi/uR
	3GqX5Yuk451KC/P8jUxFtpiC03AHHSzfmZ1tasCvVwq0K5dfUAT5k5UIlM5AYp5AbuWrHCnqAdlar
	MON5eEuRnpyyAEygVlddVw/3P17BKfqbeFAaSlglKpy4uXOd/Z+wGpObKkYyH/XeMIxxZW417z6LO
	N4RVHp0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVe6L-00000009xcG-3Tvn;
	Wed, 08 Jan 2025 22:00:33 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVe6C-00000009xZp-2moG
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 22:00:26 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6d8e8445219so2870576d6.0
        for <kexec@lists.infradead.org>; Wed, 08 Jan 2025 14:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736373623; x=1736978423; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lxzi816vsV82LbZekUeaxCWiwSFstfTOO/juIDysp+o=;
        b=QQiztxZ81xymXQY6eT1IuXo4WdIS2/N7iECnTnkNoev8jJmlE6JDqbcMr159UzmZLE
         8MO5nNwm1bu/sv7NJGlkyFMxIabyP1fExcdjKt0Gbitr8sRoCg6XsYhrQpbf8JAKTBj2
         axNKKTWIoF7juIOIUA0erqCxz2L6zGH7uhIrk53Op+DLL8KjL6NnhC4wKWuLRMhwcR3o
         sVzIDRTc9m4xceAuvSnwbBtcfs6foBgKZ6q93O0q82BADgWJagd46fRgrmixFCcX4EwM
         FWARZKfrcmirOV0tmcRmD6a/ItpOkFCviaRTQF7IPjNDK8rVMUI+76b/OGVePOVuTvRe
         uX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736373623; x=1736978423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lxzi816vsV82LbZekUeaxCWiwSFstfTOO/juIDysp+o=;
        b=Im6WDeVuCcKqu3do6LTwtLoUfA5NskagTgH3PWnJk0SFjNyw2fw3iwW6raLBbo5vhs
         TCUphiA5Or6W2JJ5k+gpwzBsHcC8ktiMr0hcAKS8LkLdzqxdQOF1EKqxUdVxI3ISZAxq
         EVe0zPGw/NI4AzYFVY3mnpqkg27RtW7ngl/wo0HZH05+kqXJzl2+T9j4ZdllgkKYvtFe
         uqLYkXDE+PJb0gwhS9H+NudQ0J2zQ60R6901tUOttUd0/5okHoCT8PfCbZgREWTvVnQr
         9lSiPI1P79N4d7B+jznfn2Gww0cblsq/tcUZvsvQ1eAOHalCzbAmLZ+FDIiDaWxa2ZK7
         1kiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIGQ1ECvpI+iiD9jicTEo43g+DynSgCW/OJ7PA1xeDX1tbXxBpyqewNX7Sk1yMG5v3fBBKOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxXsTE55UYiLAp0P5IFLdTY+NhYGlI1xvf1bw4WHxeQolSsmjpF
	+ZZPMUo4N2FE8KqbGKpx1S4j+S3HZVo2yrS0qGisHs+VxBIltQ6V
X-Gm-Gg: ASbGncs0yN/7MPrN3eHVl/qX/0HAV5GY2k9wafmirIKqvOPvFwiUXN93gVWrmllx4vJ
	gl9uIc/fAdrrVCvQC2lCewEBOkc7aoyv9ti2JOJFDD33C+ty9UNQo4X4H7Ze3sj5+tqtXI60JZc
	xqLnqNqaRTjwP2IviJdNfSDJ3k+vzEr4UK0pdQxdPxXG9gB1Q+ox9PfffbKKE8Flg4bRco36Wg/
	h9SqnCRDZtWRVtnTy3j6Z2YAmOIHis+ANPdZzyHA3BadZ0QpdPyvQ==
X-Google-Smtp-Source: AGHT+IERhB4z90VYqb4Dv2R+PhhDYDodptRvo0eGmXLkrsvBtS5WFJP/mvaGuTVc1PGcKc2NU8POeg==
X-Received: by 2002:a05:6214:3008:b0:6d4:2646:109c with SMTP id 6a1803df08f44-6df9b1cf3c5mr54781556d6.3.1736373623069;
        Wed, 08 Jan 2025 14:00:23 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:6::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181372easm195398346d6.63.2025.01.08.14.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:00:21 -0800 (PST)
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
Subject: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved region in 820_table_firmware
Date: Wed,  8 Jan 2025 21:53:37 +0000
Message-ID: <20250108215957.3437660-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108215957.3437660-1-usamaarif642@gmail.com>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_140024_719763_6F593B3F 
X-CRM114-Status: GOOD (  18.47  )
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

When this area is not reserved, it comes up as usable in
/sys/firmware/memmap. This means that kexec, which uses that memmap
to find usable memory regions, can select the region where
efi_mem_attr_table is and overwrite it and relocate_kernel.

Since the patch in [1] was merged, all boots after kexec
are producing the warning that it introduced.

Having a fix in firmware can be difficult to get through.
The next ideal place would be in libstub. However, it looks like
InstallMemoryAttributesTable [2] is not available as a boot service
call option [3], [4], and install_configuration_table does not
seem to work as a valid substitute.

As a last option for a fix, this patch marks that region as reserved in
e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
use it for kernel segments.

[1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
[2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
[3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
[4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 arch/x86/include/asm/e820/api.h | 2 ++
 arch/x86/kernel/e820.c          | 6 ++++++
 arch/x86/platform/efi/efi.c     | 9 +++++++++
 drivers/firmware/efi/memattr.c  | 1 +
 include/linux/efi.h             | 7 +++++++
 5 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 2e74a7f0e935..4e9aa24f03bd 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
 
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
+extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
+					enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
 extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 82b96ed9890a..01d7d3c0d299 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
 	return __e820__range_update(t, start, size, old_type, new_type);
 }
 
+u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
+				       enum e820_type new_type)
+{
+	return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
+}
+
 /* Remove a range of memory from the E820 table: */
 u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
 {
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index a7ff189421c3..13684c5d7c05 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -168,6 +168,15 @@ static void __init do_add_efi_memmap(void)
 	e820__update_table(e820_table);
 }
 
+/* Reserve firmware area if it was marked as RAM */
+void arch_update_firmware_area(u64 addr, u64 size)
+{
+	if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
+		e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		e820__update_table(e820_table_firmware);
+	}
+}
+
 /*
  * Given add_efi_memmap defaults to 0 and there is no alternative
  * e820 mechanism for soft-reserved memory, import the full EFI memory
diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index d3bc161361fb..d131781e2d7b 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -53,6 +53,7 @@ int __init efi_memattr_init(void)
 	size = tbl->num_entries * tbl->desc_size;
 	tbl_size = sizeof(*tbl) + size;
 	memblock_reserve(efi_mem_attr_table, tbl_size);
+	arch_update_firmware_area(efi_mem_attr_table, tbl_size);
 	set_bit(EFI_MEM_ATTR, &efi.flags);
 
 unmap:
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e5815867aba9..8eb9698bd6a4 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1358,4 +1358,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
 
+#ifdef CONFIG_X86_64
+void __init arch_update_firmware_area(u64 addr, u64 size);
+#else
+static inline void __init arch_update_firmware_area(u64 addr, u64 size)
+{
+}
+#endif
 #endif /* _LINUX_EFI_H */
-- 
2.43.5


