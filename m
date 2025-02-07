Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56FCC021A0
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aL14X0leHlIaXriDDuvzj+jBkNI10p+NUwdo4iMYdVY=; b=MCXkUd3kIFJEaUjpEj5I0x6Xt4
	f9wIiYexWsWT8eDvQD3PmVi+EWDpAaUBkksbLMVVuXOCDSV9NDmvak5lMUcG5HwpOcCNPCrKzt80n
	njShJgJWkhCJox7AaAcv6gGjGAPzmZrlWUchMSCZYDp9SNb1CJ1y5sCOFg/FlMj7768+YlxjQpx+h
	G7XJ/60GuEZmOCnhEGHpY1s+NbnNO9ANIF9moSWXKWmnsJrNOf4uI3wRSzNRiwcypQLooBw0pQba8
	9ppxK+gGijjDb7dqjKq51joJTkgxA4gDXnAaSSZU90yooNdGLpmo62GvbNWJUI/0pEaOW2FJS9w0V
	0DVZsagA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJQz-00000008lCg-1rLD;
	Fri, 07 Feb 2025 08:09:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJPw-00000008koD-31vM
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 08:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738915731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aL14X0leHlIaXriDDuvzj+jBkNI10p+NUwdo4iMYdVY=;
	b=HmX21roiI5IU68ZG7mjtdnPwJODjgBT/jB7JTcdYxmz5c5n553MHW82UFH+AVB/cClGbQX
	0wXQr6Ho+TU2TMw4DUTuVUAproLzlWvHy2Kt/n1VLfudcv6fwWd8A3Kmc7g47Cwy68+fi4
	Ruw6P52GFUlRq823LhqcSaPcBtMYL3U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-e-nftA4COZqo1Pb551RfNQ-1; Fri, 07 Feb 2025 03:08:50 -0500
X-MC-Unique: e-nftA4COZqo1Pb551RfNQ-1
X-Mimecast-MFC-AGG-ID: e-nftA4COZqo1Pb551RfNQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fa2e61c187so441266a91.0
        for <kexec@lists.infradead.org>; Fri, 07 Feb 2025 00:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915729; x=1739520529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL14X0leHlIaXriDDuvzj+jBkNI10p+NUwdo4iMYdVY=;
        b=XGcvgxhQ+V/+5+M74iDFX+p04roXjqMQIwbBhgz4+dPEd5hZnrJkNV7OQOGhcqxO+X
         BT7hBEqYRPAths4iOD//gVpLk4nU7DoXFOXZUBAex4/cpF1kd2KVoqjglW8LvQuJJ4H+
         XBFoTpBvxZlTltznvJFQ0aXB/5SzT5PIN6tnZuTIPa9R5uFBVfdX9dDHvdTHUPpGtozn
         BvG6gAPP7cYf+X0YqBGJHibMT9TSSbN1ueHvKf5ROmpvmDOfm27JAgJvDne64kg/18Gx
         irbLL/IZnpz/mJILM3p5fIoM5hAPFltDwYZuoImDppp1JSZHcba4L2FvLs6MeymOA91E
         3BFw==
X-Gm-Message-State: AOJu0YxpVq890MbwvtZYdh34evMKy7wSrGy3/Ov+3rmbBwnfUPhyvKns
	JdURxMO7QFpmUqPn+nruoQjYd+YYQBwxddtLubGzui9uupOM1tx15hBh34Ex7svTEAa9A6YIXZm
	DdzBYwtNA9r2DAwdYdagcpymxQ9159rXjzlJkRhlO4lmzYazMmkFhOuHZQUlnBaX3IqJswTwhDH
	uQJ8P3Jpr8LEtyChnJR3QQLQqBn6Z16eBJCSLf0QMVSJbT
X-Gm-Gg: ASbGncuIJVa4uUMaskNSFGlu59reikHupjij2yZSiUsWC0r4VncImJsmo58GxxjNOhQ
	kp31fX7DG8Nq7JG9uBUfxPpbrceeuIKsWGxNKlFQjMQUDDVYtZibsMJJowMoY2w6r+X1cKIGiC2
	JNsF4vbk1gY5YClqzl9bIEPjcFPx1XubdlNXf/PnPsWmmLwUVPjDwip+MtqZU+vrhS2X3tecwCk
	yZGSUOgRKbUFcygwS4q0CXoLbUZl6Nr7J4oimz1jkDvATh+DNzSBOdFAEjCZBKYYAtjwKNV
X-Received: by 2002:a17:90b:4b83:b0:2fa:3174:e344 with SMTP id 98e67ed59e1d1-2fa3174e3camr490295a91.14.1738915728887;
        Fri, 07 Feb 2025 00:08:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGForNSQZIeWtJV5QgUb8FCeJOL+p2N2wYN66XEWld0+A3AqNwNbyWXDtNkREAyMmDul4JNQQ==
X-Received: by 2002:a17:90b:4b83:b0:2fa:3174:e344 with SMTP id 98e67ed59e1d1-2fa3174e3camr490228a91.14.1738915728354;
        Fri, 07 Feb 2025 00:08:48 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1d77b73sm5465432a91.12.2025.02.07.00.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:08:46 -0800 (PST)
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
Subject: [PATCH v8 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Fri,  7 Feb 2025 16:08:14 +0800
Message-ID: <20250207080818.129165-7-coxu@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207080818.129165-1-coxu@redhat.com>
References: <20250207080818.129165-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V7aNyPEp0LfI98ZSEB6wmftErLuNjikP20YIaJHPbhk_1738915730
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_000852_833128_A93E9404 
X-CRM114-Status: GOOD (  18.42  )
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
index 1283f0244614..2209caf36d79 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -555,8 +555,8 @@ Write the dump file to encrypted disk volume
 ============================================
 
 CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to an
-encrypted disk volume. User space can interact with
-/sys/kernel/config/crash_dm_crypt_keys for setup,
+encrypted disk volume (only x86_64 supported for now). User space can interact
+with /sys/kernel/config/crash_dm_crypt_keys for setup,
 
 1. Tell the first kernel what keys are needed to unlock the disk volumes,
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
2.48.1


