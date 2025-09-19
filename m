Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4618CAC59A
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 07:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rs6R8mVEs35r5CKjZNhmHYeHlL7z4toPz5x2v4fqgSc=; b=Zwykt9YL97R9Rr/5UpoqpN3DAC
	rAS8cQRiMWwcC2AbVDx/6oRSEV3ygTD4qgMEWsJS3G2I77Ikk0ChijME0LXIB7oxXXpEnh9/5b/2e
	WjonKO1NmiHf9RzrVCxtG+KA5eYrJnXLgI/BF2EU7d0vV11KYVLTlqh7YpmY4uTVBipEAOlnOGzVn
	zqxexCAsxNohkR3BnscifpTAWiCVMVd4iRbEbg8LS1U9k7yxFAaGWycE2Dt3Nd4QBZH3Hg1onlT/n
	F4gepJUnFaunUyu74QH36LvG+tlhi9micmUOnzfsjBLq9zsVymsmLbTcSMVSxAbbY9OoJvjvDQa0e
	Wx81RRMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzVeX-000000024mX-0E2v;
	Fri, 19 Sep 2025 07:35:33 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzVeU-000000024lk-11oP
	for kexec@lists.infradead.org;
	Fri, 19 Sep 2025 07:35:31 +0000
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-b5515eaefceso757718a12.2
        for <kexec@lists.infradead.org>; Fri, 19 Sep 2025 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758267329; x=1758872129; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rs6R8mVEs35r5CKjZNhmHYeHlL7z4toPz5x2v4fqgSc=;
        b=SLEGCTZg3HAPbjDqqHqERLhgZyx1HvC4oim5NV8rSFvOOfru8wjznNjg1iwzxHec5f
         XDR3houuvy17MebyZyJ4QPU7T5xDuP5bFhmLkGsee6Jmko7UORsYqgjkhlUWEEzuXm5b
         f4WZqe7jW6QGYWj75Rd21YS/PPkVngo7xt9CVyfSUiqt5MuPdjtkUDCcdDmVS9JbABD4
         21O6pEmmqgszzdaI4FfXGyi97RbxdtmEXDAv+tjt3wgcfNOOc0S3206iBuZ04dk4L/8B
         4rSMe+7cIt9zArEeANbF7Vq2SkOn8rxwgVNEJUDCiRgAL8nyIDw0Gg7wqpXXX3o+qyHb
         DQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267329; x=1758872129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rs6R8mVEs35r5CKjZNhmHYeHlL7z4toPz5x2v4fqgSc=;
        b=AE1AwahJ5RZqXk9op8PZb8fyM38FLjtrlZsTR3wRWMVNtuap1aq70U8JNLlErF/NH9
         3qDbQlEVOJt5g1nIdYqJ2SY8bXEg9AeE5U9dSlED9BaE1227Mjk3bLtf9lsMG/pszIYd
         JsSVxWEIJQEIwPicrLnuqo3w2JNeCmRSJ6MqJYWhvsQ/uBuIvfb+zk+F8SjMV1WScnlw
         yMTlpNESqjTPeEDZUGMXwr6/2IuLueqL58KiOEYHFQy9K6oFYrw3rb+dC5fMTYIi/mCo
         Pv+pFBF+EX8PE5Y670+yBOfkqhVww75/4wjH8+HObZXBwNrgyfjqew4T7cpi+trukT1D
         i84g==
X-Forwarded-Encrypted: i=1; AJvYcCV/5nKlk4mXtXULUECJf0hoOg7TMf9PSGFVPjTwKDCZzaKUu75jS2EhyBnEW0tEnPIsbikdVg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzKCfobQsVqupTaCdQgULC0DUW/+yWtrHuSe2QJDwlgY+y8eBiO
	r3rZQVgIx4nOnKHoLNDusWYx2WsieZLNvKCxxUZiSaHwqU0KC89F6/ZI
X-Gm-Gg: ASbGnct8DZQlCdne4dTvrX/NlCm5pUZCNjKhAZHHQ9nQzcE6f/vlnhxxf22RaIk8r2Z
	dCHnrjgtFMCJ/tCvvVjAjM7ixZPZaaXFZ2XEm50EQNXHwQVsFh5tVloCyyUE7r7VtFwUJNW02br
	rR9DyAddIPGHGpvOmD/AbCAdNxDCeE2XKvSM8hMr3ys7ZNHW3HvFbGkWRtfB/aBrNrZgyGP7Ufo
	fXdPc6R8nc2xoohD01GELo3kgq7B59nG68SYJLl4Aor2nNBDBwFNerxlNC3jtbBmB0A8/Kb/jef
	L/AlhtLCWDYPfGGBnAJfImdh+iD8O5xH8qSwJR9UaY60J4brsv/14mNZAB4DrdXxKZc49LgoVga
	3rLfRr1V/nhwEi7aE9BMtdJWXSNr6DXeowJEjeaBbAbGp
X-Google-Smtp-Source: AGHT+IH/JbewrU8tMCRdVSKymQBC4NY9RBJRAxG3PQ4rO2Tkwc+lt+/BMdoxAoQ8MQgLVhADR4NFLw==
X-Received: by 2002:a17:902:ec90:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-269ba53c9d9mr31131235ad.46.1758267328839;
        Fri, 19 Sep 2025 00:35:28 -0700 (PDT)
Received: from PC-YLX4G5XJ.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33046a4d0basm6196155a91.27.2025.09.19.00.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:35:27 -0700 (PDT)
From: Chen Wandun <chenwandun1@gmail.com>
X-Google-Original-From: Chen Wandun <chenwandun@lixiang.com>
To: piliu@redhat.com,
	kexec@lists.infradead.org,
	zhaomeijing@lixiang.com
Subject: [PATCH] arm64/crashdump-arm64: Fix makedumpfile error caused by fail to get _text address
Date: Fri, 19 Sep 2025 15:35:22 +0800
Message-Id: <20250919073522.1840036-1-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_003530_284236_95E89B5D 
X-CRM114-Status: GOOD (  12.76  )
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

I encountered the following error while makedumpfile without enableing
kernel CONFIG_PROC_KCORE and CONFIG_KALLSYMS_ALL, this error only exists
before commit 29fe506 (kexec: make -a the default), this commit change
from kexec_load to kexec_file_load.

read_from_vmcore: Can't seek the dump memory(/proc/vmcore). (offset: ffff800084f4c000) Invalid argument
readpage_elf: Can't read the dump memory(/proc/vmcore).
readmem: type_addr: 1, addr:41f29800, size:8
vaddr_to_paddr_arm64: Can't read pgd
readmem: Can't convert a virtual address(ffff800082edf8a0) to physical address.
readmem: type_addr: 0, addr:ffff800082edf8a0, size:390
check_release: Can't get the address of system_utsname.

Although several error messages appear when loading second kernel using kexec without
kernel CONFIG_PROC_KCORE and CONFIG_KALLSYMS_ALL, but kexec return 0.

Can't open (/proc/kcore).
Can't get the symbol of _text to calculate page_offset.
Can't get the symbol of _text to calculate page_offset.

If kexec unable to get the _text address, it will result in elf_info.kern_paddr_start
to be a large value, and also phdr->p_filesz/phdr->p_offset to be a large value, such as:

readelf -l /proc/vmcore
Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x0000000000001000 0x0000000000000000 0x0000000000000000
                 0x0000000000001a44 0x0000000000001a44         0x4
  LOAD           0x0000000000003000 0xffffffffffffffff 0x00007fffc0200000
                 0xffff800083020000 0xffff800083020000  RWE    0x0
  LOAD           0xffff800083023000 0x0000000000000000 0x0000000040000000
                 0x00000001e6e00000 0x00000001e6e00000  RWE    0x0
  LOAD           0xffff800269e23000 0x00000001f6e00000 0x0000000236e00000
                 0x0000000009200000 0x0000000009200000  RWE    0x0

This patch avoiding makedumpfile failure by ending the kexec process and explicitly
notifying error.

Reported-by: Zhao Meijing <zhaomeijing@lixiang.com>
Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
---
 kexec/arch/arm64/crashdump-arm64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 73cb611..8629610 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -94,9 +94,11 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 		 * For compatibility, deduce by comparing the gap "__init_begin - _stext"
 		 * and the res size of "Kernel code" in /proc/iomem
 		 */
-		if (kva_text_end - kva_stext == length)
+		if (kva_text_end - kva_stext == length) {
+			if (!kva_text)
+				die("Cannot get kernel _text symbol address\n");
 			elf_info.kern_paddr_start = base - (kva_stext - kva_text);
-		else
+		} else
 			elf_info.kern_paddr_start = base;
 	}
 	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
-- 
2.25.1


