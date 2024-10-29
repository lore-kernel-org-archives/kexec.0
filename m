Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48251D5B87A
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 05:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0yToDl9uz06nAbofz4ZH2A8xRf+G/b0zstVRjG5Y9Po=; b=V0NsZcN9bYy9bJ
	YGqfBE3HG+oFXsW/y97uwBEByhJbqI8DWR6c6sSRGxxCTKS1vr7AIanhoccx/VIRFAfJXi9nT8BKt
	nX5OYRZd4F55yPTY9bhuflAx+Qaxm5bIbyNOBVqalM7XBIgQovbA5xE17j9VwkriAmMwx4N2jOfUv
	J0eibFXxJRf5WD4xFpa35wAr1KEBuEYk2hmhGvTuaT49iosoRPqIJzPsZohPpircIhAz0kS7i7HM+
	6Uy9RZShLhKwNnEnTFLqbiKqWFMxhFA315uIhkucKks9/bqf3Q+xMruZ6u3Tv1Iwyt8lZ0U+9BPTx
	ky9WoPK0s57l+X9Q/WqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fAG-0000000DIP1-3luU;
	Tue, 29 Oct 2024 05:53:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fAC-0000000DIKz-1Ypq
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 05:53:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxN33tdMukhisw/yIqoyNXhrPQQ42HlFh3ca/0Qlc2k=;
	b=DRuPStO8TAKCNt7gAYzzxdelGyc3DWfhdr3yKSrPZrHZh/FrmpFLDdA1hyhPC+2N65G0EY
	x4jGRjzngw7Qhk4vzOOkXubDYofCz2q/nKF6UqymB2zRcbuhY0Txh1NWJZyJ5NUAYpPZvh
	jgrrU26eDwnxDAqORXXEfA+gNnEwQ8k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-CHQOZA_WO4y3bwfirYRRYw-1; Tue, 29 Oct 2024 01:53:06 -0400
X-MC-Unique: CHQOZA_WO4y3bwfirYRRYw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7eb07db7812so3740470a12.0
        for <kexec@lists.infradead.org>; Mon, 28 Oct 2024 22:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181182; x=1730785982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxN33tdMukhisw/yIqoyNXhrPQQ42HlFh3ca/0Qlc2k=;
        b=FVo8YCOEFUHGYz524gB+jNzSMLe3+v5vchqu/vhSMD+sq+M+2J5n+Hoz8fG55Q6uS5
         jYWxJVSSsEk6vI/OdUMqggPADuRNVeioP8185n29jcws6eFA8yre3jfJV0RJWDNZoNji
         IcYCk6OyTKAHC0rgJJjRVsei60NAXWA+zZd9wnloQCxKUL8aiRNK1GKPykBOpNSUUF07
         uN29fmNseNIadkiy5sQcXCWhJH/npuEOjfLdsWnX/zxn2BHhGp+FvIB5qg54W8O7rOpn
         up3FfDCZj1TQaJr12m9arKN1Vaef/yAKJ77Rlzx7jnuVR7OrAUgc9WjeiuHjU9vWD98S
         NnEw==
X-Gm-Message-State: AOJu0YyVgUBRE+4X5X4QltUE5zovD/AhBsKRj4prBAskaDqenXlfsyqI
	cnria6S1GB0cwvOMMsu7ltSdYy1R/vckAqeqrl5SFbkjUmsrX0QaFKRjf+JsNzBtiWPaNMBf2pq
	lHd/5AhGKvGIdeJ24QTQ7Tfpp12JhbTQzR6JSLgliBoykCSY+0PpMjOrafaCwOy3J161D5ATVYV
	30KQTqNn3eFukTnIx1DFbKatYxXwDyTI6hQL/jwMWxXIDP
X-Received: by 2002:a05:6a20:1594:b0:1d9:1661:56b8 with SMTP id adf61e73a8af0-1d9e1a37b6cmr1403802637.24.1730181182464;
        Mon, 28 Oct 2024 22:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+5lOO2h8SrB779IPVLSPIhRIwwoXPjJUnB9hq/AGjJ6AhPouE5mbdohA59r2JGo+YR4/Uog==
X-Received: by 2002:a05:6a20:1594:b0:1d9:1661:56b8 with SMTP id adf61e73a8af0-1d9e1a37b6cmr1403764637.24.1730181181979;
        Mon, 28 Oct 2024 22:53:01 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a39b15sm6630484a12.79.2024.10.28.22.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:52:59 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Tue, 29 Oct 2024 13:52:19 +0800
Message-ID: <20241029055223.210039-7-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_225308_496706_95164677 
X-CRM114-Status: GOOD (  16.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

1st kernel will build up the kernel command parameter dmcryptkeys as
similar to elfcorehdr to pass the memory address of the stored info of
dm crypt key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/crash.c           | 20 ++++++++++++++++++--
 arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 340af8155658..99d50c31db02 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -278,6 +278,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int ret;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -286,22 +287,37 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	ret = crash_exclude_mem_range(cmem, start, end);
+
+	if (ret)
+		return ret;
+
+	/* Exclude dm crypt keys region */
+	if (image->dm_crypt_keys_addr) {
+		start = image->dm_crypt_keys_addr;
+		end = start + image->dm_crypt_keys_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return ret;
 }
 
 /* Prepare memory map for crash dump kernel */
 int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 {
+	unsigned int max_nr_ranges = 3;
 	int i, ret = 0;
 	unsigned long flags;
 	struct e820_entry ei;
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 
-	cmem = vzalloc(struct_size(cmem, ranges, 1));
+	cmem = vzalloc(struct_size(cmem, ranges, max_nr_ranges));
 	if (!cmem)
 		return -ENOMEM;
 
+	cmem->max_nr_ranges = max_nr_ranges;
+
 	memset(&cmd, 0, sizeof(struct crash_memmap_data));
 	cmd.params = params;
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 68530fad05f7..9c94428927bd 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->dm_crypt_keys_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -441,6 +445,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret)
+			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");
 	}
 #endif
 
-- 
2.47.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
