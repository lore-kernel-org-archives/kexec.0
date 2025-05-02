Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF30C369DC
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/EXCS7YZfoYbLHPYyFkucRV4RaFlxZolah51T9bD/WA=; b=qxEt+G+RoGuvErFwXgj3ywd19S
	zKjYPXKvPRhnRRu6XXrBe5NLTA7O19zxEG4W5MmfcBJ26jgacxnA7+hgMKtog2Ig7g4/gjkijUUBr
	OcJdLQn7tcnbhXrJ1fi+nnj8TnvreR0YBWKQb+gtPWVxYbDed7vBU2Z9KKII3zLU9iaczSyHRrS6+
	vPYfspMaicbz+1UQVBkNdLoNSCPHLM3fcLosTcOugkXM0ws+a6WR0NOB0W3L47s5cs0+HUopxNs4U
	cweoB1m9Rdgaf2hQyT1oyriUHF5zgf8tS2nf9uuCFwVK/zQNMtjD8wxv0UbM0rn7a4M17dkwDjJnx
	2llNFH9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAf0P-00000000UJC-0TjP;
	Fri, 02 May 2025 01:15:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAexz-00000000TiT-1tY7
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 01:13:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746148406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/EXCS7YZfoYbLHPYyFkucRV4RaFlxZolah51T9bD/WA=;
	b=A/wW+q/FaBxtPepyJxOeDEMQ0HmcIOy1RX8Et/woMoFCswiYFfUvmPDwghQ6P2mabNLnbX
	XfQi+DCfCG4iD528wYKqJOdc2QSpA/WX+QQtPyOTq0yHtT4lb6TI0uAJgg9gP9HPV9PmET
	gB789a3IDri7OMTxmvnR3I10ATCUgpo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Vsj-Yl2yN9ioyNlyf4ECRg-1; Thu, 01 May 2025 21:13:24 -0400
X-MC-Unique: Vsj-Yl2yN9ioyNlyf4ECRg-1
X-Mimecast-MFC-AGG-ID: Vsj-Yl2yN9ioyNlyf4ECRg_1746148404
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74041404f8dso1034871b3a.0
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 18:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148404; x=1746753204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EXCS7YZfoYbLHPYyFkucRV4RaFlxZolah51T9bD/WA=;
        b=HB1HamV+rNnOokjWxB1kWI+Pm/4ff0qMA3zy25VKLxQt6YNayM1pxngxR7dh5fmhwP
         xBK5CanBJmjFs82QjXIgFztFV5DxZ45DC/i62lh1zm9pgsXOm31Hc7CutJG6ZziQeNdT
         smzJ3MezaD/6hYTfnsKBrMWl1PyKwzg4j7uDhxZC8FmFnbyxNNQQS9McvuUgad6OIxNX
         HrlTOYcy/vtohNHZEAYZZh0muaa10+vyMnFap8uw05ad8lZt+1vH78DHPG2Hbsb6MI3G
         lqwzgTTM01zn8ZesMvKQRn6qmvnnx9NBlYpZo9D71kHlJVx21q6n+ADdLjsJJjWeXtPc
         tsjg==
X-Gm-Message-State: AOJu0Yz/uHS2rXXCxfvTmf6do00fvO1CeLeaF8QMAy5F+5lU8Q/rNX50
	0x8GQWIFzJr/yPeLP+WM7tfK4g4EYU4DoExjB3I+3CWrmdPahTBiHdri96T65nssoj9T3k/e4Xq
	wNcA4Zi/L5AKJfQWAJkm1UkOZI1ofuuCJ4kLfOaGnLTOYL7t3VRaOGOmuUuLbtYH7ea0GtiHtl3
	ZD87zEKu6tdBJHz70u3LtbDfHbGjiLszxqaCOBPMHWJQ==
X-Gm-Gg: ASbGncsEwzL9MUNNk5TXj+4i7gL9YP2qlKn1RjESVxhbGD0ogBdRATcrIm6OW7AWBT7
	c96bCL2Vh+7/DUvRsm0hSWoh6VkWPlsuDVRoZp2b/of0dADC4II7wJ+NT2OseTpEOUTHZKxtuyS
	U0IHEIZzj5a8l+XiNNng/OEMkGpAasDGZWllqFdXny+Dj7KN1CBFMzRLgLlGcoMv8rsJXzj2QtW
	a3OswXYL0RKeml3lioMDfLUXMkOwklB/NiOxv4UCHkqUTLMGHF6t4g74+eSUHPYZkStB5S4XF6H
	nbc=
X-Received: by 2002:a05:6a21:78c:b0:1f5:6b36:f574 with SMTP id adf61e73a8af0-20ce02e7da0mr1498457637.38.1746148403680;
        Thu, 01 May 2025 18:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU0R9cOfxCknV2YN3iEnSYLPTc4nx8JnX2KM70AD+jCoO7YKr4yHDcrBlPC1IzEWkqBT/rQg==
X-Received: by 2002:a05:6a21:78c:b0:1f5:6b36:f574 with SMTP id adf61e73a8af0-20ce02e7da0mr1498402637.38.1746148403254;
        Thu, 01 May 2025 18:13:23 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a3b1sm357910b3a.15.2025.05.01.18.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 18:13:23 -0700 (PDT)
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
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v9 7/8] x86/crash: pass dm crypt keys to kdump kernel
Date: Fri,  2 May 2025 09:12:41 +0800
Message-ID: <20250502011246.99238-8-coxu@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502011246.99238-1-coxu@redhat.com>
References: <20250502011246.99238-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eRU0DzxaOV-cNXnYWW6_uFRubix4X4JOzPFiZ9ke4mk_1746148404
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_181327_561288_B6614E92 
X-CRM114-Status: GOOD (  20.76  )
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
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst |  4 ++--
 arch/x86/kernel/crash.c                   | 26 +++++++++++++++++++++--
 arch/x86/kernel/kexec-bzimage64.c         | 21 ++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index e25edaa8e533..20fabdf6567e 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -551,8 +551,8 @@ Write the dump file to encrypted disk volume
 ============================================
 
 CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to an
-encrypted disk volume. User space can interact with
-/sys/kernel/config/crash_dm_crypt_keys for setup,
+encrypted disk volume (only x86_64 supported for now). User space can interact
+with /sys/kernel/config/crash_dm_crypt_keys for setup,
 
 1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
     # Add key #1
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 0be61c45400c..bcb534688dfe 100644
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
index 68530fad05f7..c71cdd8e425a 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -27,6 +27,8 @@
 #include <asm/kexec-bzimage64.h>
 
 #define MAX_ELFCOREHDR_STR_LEN	30	/* elfcorehdr=0x<64bit-value> */
+#define MAX_DMCRYPTKEYS_STR_LEN	31	/* dmcryptkeys=0x<64bit-value> */
+
 
 /*
  * Defines lowest physical address for various segments. Not sure where
@@ -76,6 +78,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
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
@@ -441,6 +447,19 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
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
+		if (image->dm_crypt_keys_addr &&
+		    cmdline_len + MAX_ELFCOREHDR_STR_LEN + MAX_DMCRYPTKEYS_STR_LEN >
+			    header->cmdline_size) {
+			pr_err("Appending dmcryptkeys=<addr> to command line exceeds maximum allowed length\n");
+			return ERR_PTR(-EINVAL);
+		}
 	}
 #endif
 
@@ -468,6 +487,8 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	efi_map_sz = efi_get_runtime_map_size();
 	params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
 				MAX_ELFCOREHDR_STR_LEN;
+	if (image->dm_crypt_keys_addr)
+		params_cmdline_sz += MAX_DMCRYPTKEYS_STR_LEN;
 	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
 	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
 				sizeof(struct setup_data) +
-- 
2.49.0


