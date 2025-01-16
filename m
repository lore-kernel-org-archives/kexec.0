Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CECC02180
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aHQUprvYUxpGchCCyLRuJWs5QUXLD5ilgW79Ys2jOQY=; b=QxTLeBlyL6tlEsY681gAdgQSQ4
	SIej1naOLOsWNzqD8mrktF9XU/qozzji5/9U53MyO0XFi+BLAUh7BuhGx0BWkOFLNBpTyNUTXctKc
	lOyk1veDpFNa4lcDt+JoNf0kppTdBvAMkX0ECkagFRa9n6Fmnvo7Tf59Ro0cPaBJms70/MMSZhx2o
	BUUxNTw5eQSFKxT3B2tdKm0+HoI4ewQA5mfvJ54gzg+vY/aRufbQQau+CtGi4zvn2xJoWYF0aPz3L
	sCUli41zKnCpyLCbMLroTFIaGx+t1TdxrRGUNbL8HCZ5Q1uahve0oXNvNs6YHbn6mocQRenNjMh0H
	VbRrNgvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYKLJ-0000000E3FC-0VSr;
	Thu, 16 Jan 2025 07:31:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYKLF-0000000E3EJ-3nOd
	for kexec@lists.infradead.org;
	Thu, 16 Jan 2025 07:31:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737012660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHQUprvYUxpGchCCyLRuJWs5QUXLD5ilgW79Ys2jOQY=;
	b=LgYma9p2iN8R108HF3uM4YEfyKDALoSGz3AQALutTe5ZH4SiF4IzlBzRdJXsoAhvOFmbIp
	gsWy10NCkjfCn42vTf/38ktMQQsaFyUDDo/Z7iqlGo30FBEeLWnHLuZv83j/FYF/+I1qV3
	+Q4PxUZvDrtREAkM8DmmTLkDhRM9HfE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-KxB_I7iyNcOEeZg6dctN6g-1; Thu, 16 Jan 2025 02:30:59 -0500
X-MC-Unique: KxB_I7iyNcOEeZg6dctN6g-1
X-Mimecast-MFC-AGG-ID: KxB_I7iyNcOEeZg6dctN6g
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so1442648a91.1
        for <kexec@lists.infradead.org>; Wed, 15 Jan 2025 23:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737012658; x=1737617458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHQUprvYUxpGchCCyLRuJWs5QUXLD5ilgW79Ys2jOQY=;
        b=Q2j2516gMBlk/HKK5ozG6LTAmpSiroW2LkHcyry7HFx3DQ2Ylvf2hEL2s8NcFwVUzE
         HBh6PJjvsH+xaMFPIfxo+tCpBJ10avqqAAKfpOb1tNGauSwJjq1BMrowYnNTNULlj9bK
         x25s2a3KnjyKhbnvAbEQfKDoNCItTIsW4w1dNQ4W8W/o0NbeEsTbAEbH/P1WBR5a14S+
         yAHNX9Adc4b7YPKZFyME5uM9mxSc/FfUBN+wS3Jnr9YsxHqORzh36d1DX9PjKrTYD0bx
         Ru3TP/7Fl454p3dwL2bihUd6HtEqfD5tqvwpD9kglTHAxV/iZsKpB8IVfmTgreuGl2MD
         cjhg==
X-Gm-Message-State: AOJu0Ywr2YBX8L3b6KuiUULOYusHRhQ6hU1ekiouk3hG0zdHTkq4vSTv
	rqUGpB0ywtcBVvMql79JdPFQbitMxXbf7ck3eZFAN0ypl+ja+JxrccmymetOJtTl8dM7p5hSFuG
	RsVCzlCNUjpV+zZcmMzckY4zh8K57ilmmE0SPMAnN+WvSqwVk69tFehopkDAtRLNpFP6A+dPRXF
	+RfZdiMNSovUpvE8UiqgVuTxBD9xcfn/SHdyzMP30knQ==
X-Gm-Gg: ASbGnctkyLB6BrfdZTl0zHG2/zJinlVoI+0BaQ3SVxC+GwOnRZxaJkQmiVEzk5cTqpH
	wgYwbeKusOOC3I1D+O4Wyh6QGXE5Rj7ewTGU+Q2xElDr62XisPpqz3tnEcqIlYL0Has2MfOdZoJ
	nlvcj8LbPsLiAJBVEe4ExZTiBi3wAum3roq/KPb8t3jGeCMzcekn4UB0ywgPSd0bTr0IvXxlWeL
	+3VnOQh5X0FvDNubQENAD7B/LQCU01sLepvvceaNfchIfT+
X-Received: by 2002:a05:6a00:230a:b0:725:90f9:daf9 with SMTP id d2e1a72fcca58-72d21f650a1mr43969941b3a.15.1737012657562;
        Wed, 15 Jan 2025 23:30:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWDRrztzuIkg9Q5tBVV6pQohQ2pViv+9rbr1S07QCHNZTPnu4LF6hxA89i8/UG0IYrbzHiVg==
X-Received: by 2002:a05:6a00:230a:b0:725:90f9:daf9 with SMTP id d2e1a72fcca58-72d21f650a1mr43969860b3a.15.1737012656652;
        Wed, 15 Jan 2025 23:30:56 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405493basm10334829b3a.27.2025.01.15.23.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 23:30:56 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v7 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Thu, 16 Jan 2025 15:30:52 +0800
Message-ID: <20250116073053.1043873-1-coxu@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116065825.1041558-1-coxu@redhat.com>
References: <20250116065825.1041558-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M6Wb2Jj0VQBMqLpp8XkRV5MdSQMFb6YsUoDc7fMfaGs_1737012659
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_233102_012878_7766BDCE 
X-CRM114-Status: GOOD (  19.22  )
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

1st kernel will build up the kernel command parameter dmcryptkeys as
similar to elfcorehdr to pass the memory address of the stored info of
dm crypt key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst |  4 ++--
 arch/x86/kernel/crash.c                   | 26 +++++++++++++++++++++--
 arch/x86/kernel/kexec-bzimage64.c         | 11 ++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index cecfa5d34f01..c4bd6ecb6ab7 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -555,8 +555,8 @@ Write the dump file to encrypted disk volume
 ============================================
 
 CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to
-encrypted disk volume. User space can interact with
-/sys/kernel/config/crash_dm_crypt_keys for setup,
+encrypted disk volume (only x86_64 supported for now). User space can interact
+with /sys/kernel/config/crash_dm_crypt_keys for setup,
 
 1. Tell the 1st kernel what keys are needed to unlock the disk volumes,
     # Add key #1
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 340af8155658..a525ee639b63 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -278,6 +278,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int ret;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -286,22 +287,43 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
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
+	unsigned int nr_ranges = 0;
 	int i, ret = 0;
 	unsigned long flags;
 	struct e820_entry ei;
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 
-	cmem = vzalloc(struct_size(cmem, ranges, 1));
+	/*
+	 * Using random kexec_buf for passing dm crypt keys may cause a range
+	 * split. So use two slots here.
+	 */
+	nr_ranges = 2;
+	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return -ENOMEM;
 
+	cmem->max_nr_ranges = nr_ranges;
+	cmem->nr_ranges = 0;
+
 	memset(&cmd, 0, sizeof(struct crash_memmap_data));
 	cmd.params = params;
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 68530fad05f7..5604a5109858 100644
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
@@ -441,6 +445,13 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret == -ENOENT) {
+			kexec_dprintk("No dm crypt key to load\n");
+		} else if (ret) {
+			pr_err("Failed to load dm crypt keys\n");
+			return ERR_PTR(ret);
+		}
 	}
 #endif
 
-- 
2.47.1


