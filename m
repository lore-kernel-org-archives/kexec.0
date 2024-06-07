Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75336C27C55
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HUogrYdRsLv0zLy8GeNEJw/CPT2qlY8cNxHXFfabwyI=; b=x7YftGCbl10trg
	uu8uidvzhcfbhGkdCkkkY/X2VfDfba1x2A/Eot0E9xFRvDp4rSX25DAq6ck8yVX9HH0a1Nuc+9RNA
	c1xfVcttP9dI4pFFK1YGjQ004w/vWIqW89ytiqWBQwpN+tOpy6gpa4B9P1FvqJJ0gxaLvSUHQispi
	0NXtXfvraREBnr2xDd0mepyhwr71p/XukWid1kXZ9w7qImgDdXPhr62HYXxmrsR1ZwQrke+ZbEFdI
	ZTW02fk4umFJ22ehLN7IyrzXgNBjQqBNZoNyUmWtVMaEbZ12TeyzEDxWRLg1IhLK6a9LcdpAeMYFa
	09YNpG9N8kFE32qcntDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgY-0000000Dumh-0Kqz;
	Fri, 07 Jun 2024 12:27:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgT-0000000DugJ-46jV
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:27:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8eSDPJOHg5XX+C6EnMgGjbvp60roI+VIhJqlmfxAK0=;
	b=J0/3Nv344IO+pxIstLsSpXGZPqzlHgkWhnSuH24L3r5AYtMKPV1AnekdQ/r40CkM0m6tXN
	RtJYZ44f+pkUpD5nprPDU9WgezAHmrnUgmbLNp3TK1LK+88pWlgLYydw4yb12vvHd3jozJ
	fs7xIXx9LCulLnQ3+j1aJa8UIATlv1k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-kxiKouRsOrKq4gysnJbaOg-1; Fri, 07 Jun 2024 08:27:02 -0400
X-MC-Unique: kxiKouRsOrKq4gysnJbaOg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c20e7731cbso1994800a91.1
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763220; x=1718368020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8eSDPJOHg5XX+C6EnMgGjbvp60roI+VIhJqlmfxAK0=;
        b=T7vuXPAhpw0jwn6Wz7G72DDzxFQeA5/i5O6l+COwlA3lpDFReAHWuOZ5LkyYpBooGo
         34xk4qvIL2006D6azSPLwOYoBHMXC/twfqtlKWhIuiQccRpEGd24pQ4wZaS44/hm3Sme
         9TfeAIBtsFLaBfKqjHkeLaKOPyPKcnzHfvJP5H06Uh4PpBaBuqOgBjiDBHV4z+ykniRg
         4TnVdYMUJrBlJCT7IqkPHrQm+WQc0hOqWkMdcARLjJeRHD21CxbzvPLBFtgsyOarNtV5
         dQmaCuYfsuINXlu+p8V2aUloBOe3c9Xwfpnyd4t6Nd52mN7yTu63kkkCmZUxT2hjQbX7
         KPQA==
X-Gm-Message-State: AOJu0Yy6VGs2nzZOdPEn2XqnvMTZc6arwXnZVY4LuEisse7AXhYjnqCK
	lD/PzIdvXjdjZAzBVhe5IaBsoqfkwKHbQFatp3mgOAGZjJ6+9IibjTfSh/PMgJ/C600vwlGNo/O
	7ghu1KvJLbk6bizEzHHUiPGBs7vxLKdAzYG0Ls6yCvkrErxqljXutrrAiliYFHzw5mpuj0kdoXP
	ilcMyf+5LBiG41tpjIhaPud4KaUFrAqPDrWSuhURI36xTn
X-Received: by 2002:a17:90a:c68a:b0:2c2:d294:4b37 with SMTP id 98e67ed59e1d1-2c2d2944e21mr159162a91.16.1717763219679;
        Fri, 07 Jun 2024 05:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw9d3+j4Qxyr3iy7YrPWSmR+eC0E/vLf1RLdGhWBQep6818IZh3UHaedUhxP520TTrHOJycQ==
X-Received: by 2002:a17:90a:c68a:b0:2c2:d294:4b37 with SMTP id 98e67ed59e1d1-2c2d2944e21mr159112a91.16.1717763218929;
        Fri, 07 Jun 2024 05:26:58 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806cfa57sm5342060a91.49.2024.06.07.05.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:58 -0700 (PDT)
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
Subject: [PATCH v5 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Fri,  7 Jun 2024 20:26:16 +0800
Message-ID: <20240607122622.167228-7-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052706_147406_60328B73 
X-CRM114-Status: GOOD (  16.07  )
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
index f06501445cd9..ca7f7d44a433 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -266,6 +266,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int ret;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -274,22 +275,37 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
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
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
