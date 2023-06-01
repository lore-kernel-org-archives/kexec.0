Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52653C77B7A
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 07:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8kkftvHpoiLk7T7xBAD8qUQj3E+OZd9Gqax4Y/A7Kgc=; b=gsuTV0h9c0Kapd
	cgUey5r3fGGIfmeympnoQAIK4ZKdYtF72z3G/fUCCd/bFtECi+QMWrB5OrG/X0vPO9c06HKwQ+cfh
	z132Dj2YllKoZt9CG0hFUdUvRMgC7Jaoq/Mrg6/EYYN1hLSvSPHyifzWeBdqiSwvBmP6An3QZnVSc
	+0ZGxejaqfk7Lnc7nCSPAQWGalYxtj320xbelK/6aDNEmH+U4mhflaQBcp87cdnJg99OCbcT9dBf1
	QzGWsEbzsY+FrcOEljlL41BItvGFBWPnIIsDPDa0lRWrjfM2GpPc557/HFizykeRXdnygVxgmZkdj
	wmbYXHBZnMACwk1/HpWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ciD-002M0o-1k;
	Thu, 01 Jun 2023 07:27:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ci6-002LxN-1Z
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 07:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685604421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgH6lkMBE6SH6kwKQ2OLQdShNDxo5U5zIXrPWoXTrzY=;
	b=XMbYeBBnweO3TPrJPMqkuTaP+oYL73MZ1+3U4g7ZrnewYndzddfZicGPYAnYkGFkePhoga
	dCbIocdZxm667ZGQnCIvu8wd7U//SJ3BNf2RRt/VUQlY7CYRokPD3H4BhaLhi+03L+J90T
	ScNbxotBnaLzujuHyC36sIZhA4HI4c4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-ht8IqsLsNdObl4Z6RIzpCg-1; Thu, 01 Jun 2023 03:25:05 -0400
X-MC-Unique: ht8IqsLsNdObl4Z6RIzpCg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2568fd3f360so104780a91.2
        for <kexec@lists.infradead.org>; Thu, 01 Jun 2023 00:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604304; x=1688196304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgH6lkMBE6SH6kwKQ2OLQdShNDxo5U5zIXrPWoXTrzY=;
        b=EOxR2RAKrrogX3Vbk5Yghm+RwrxYNQOPenAREb7aPMtVGg60SsKYYslQzNLD4wmP85
         XzrETQAk7vYUFxvUJDAcHN296N5+PLP6G2qvgPLpZKp4uRTfawJdE9CV0aS5Qwl8z/0t
         5PGyfmGe+cPXvJMnZUgtYYjmPJLsuPc4AROEBKVjM0CReS/Uc5GHygjpB55/m+3njjln
         lKyVSaEwoq+u06vVm87Pjqb09sj4YrQAhGHI4/ycMqVzrG8DciX/lyEVvSTlKzp5Ge8v
         lMceBFZxyvd/50Qr8qWZ5aIE8YNwfg+oCYVihzFRDm2CzgzD49RkFwTItWfzfV7jt2iS
         eXlA==
X-Gm-Message-State: AC+VfDz6ACq3FuyZQSEKeRb9OOcX+os5FpcIeSkaTb4O7Xfd9Qib9zCY
	ThgPdrMXyQq0Rs1gAek5iXTgmvunKXMMhLuaziS5elBnljy0bF3fXz/Ec4U40eAAFDgJ7+9xUQ6
	B4c5AtCbAr3sg6WX5Ox8ukw5Kl0p1hXN0SLQWVoDy6pJm9i9Wdozf4T3VKgRoK08/IwMqAzVtpu
	8AaLrQn7I=
X-Received: by 2002:a17:90a:1d5:b0:258:ad44:1881 with SMTP id 21-20020a17090a01d500b00258ad441881mr348571pjd.11.1685604303993;
        Thu, 01 Jun 2023 00:25:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xgKGdx+9FIXW6GTYR3P3F8V57UwAyR9jIH88D5P2XGZN+XYlgvqnsqFZh+mlMZMuhp1bt/w==
X-Received: by 2002:a17:90a:1d5:b0:258:ad44:1881 with SMTP id 21-20020a17090a01d500b00258ad441881mr348543pjd.11.1685604303582;
        Thu, 01 Jun 2023 00:25:03 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090a4e8b00b00256799877ffsm702466pjh.47.2023.06.01.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:25:03 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 4/5] x86/crash: pass the LUKS volume key to kdump kernel
Date: Thu,  1 Jun 2023 15:24:43 +0800
Message-Id: <20230601072444.2033855-5-coxu@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_002702_628579_A15DE196 
X-CRM114-Status: GOOD (  19.92  )
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

1st kernel will build up the kernel command parameter luksvolumekey as
similar to elfcorehdr to pass the memory address of the stored info of
LUKS volume key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/include/asm/crash.h      |  1 +
 arch/x86/kernel/crash.c           | 47 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 +++++
 include/linux/kexec.h             |  4 +++
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 8b6bd63530dc..485f75dce2ca 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -4,6 +4,7 @@
 
 struct kimage;
 
+int crash_load_luks_volume_key(struct kimage *image);
 int crash_load_segments(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..32d4a9e3badf 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -289,6 +289,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -297,7 +298,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	r = crash_exclude_mem_range(cmem, start, end);
+
+	if (r)
+		return r;
+
+	/* Exclude LUKS volume key region */
+	if (image->luks_volume_key_addr) {
+		start = image->luks_volume_key_addr;
+		end = start + image->luks_volume_key_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return r;
 }
 
 /* Prepare memory map for crash dump kernel */
@@ -368,6 +381,38 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	return ret;
 }
 
+int crash_load_luks_volume_key(struct kimage *image)
+{
+	int ret;
+	struct kexec_buf kbuf = {
+		.image = image,
+		.buf_min = 0,
+		.buf_max = ULONG_MAX,
+		.top_down = false,
+		.random = true,
+	};
+
+	image->luks_volume_key_addr = 0;
+	ret = crash_pass_temp_luks_volume_key(&kbuf.buffer, &kbuf.bufsz);
+	if (ret)
+		return ret;
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		vfree((void *)kbuf.buffer);
+		return ret;
+	}
+	image->luks_volume_key_addr = kbuf.mem;
+	image->luks_volume_key_sz = kbuf.bufsz;
+	pr_debug("Loaded LUKS volume key at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 image->luks_volume_key_addr, kbuf.bufsz, kbuf.bufsz);
+
+	return ret;
+}
+
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..a859e9e5c876 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->luks_volume_key_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"luksvolumekey=0x%lx ", image->luks_volume_key_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -433,6 +437,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_luks_volume_key(image);
+		if (ret)
+			pr_debug("Either no LUKS volume key or error to retrieve the LUKS volume key\n");
 	}
 
 	/*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5b2440444112..20d213076e46 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -374,6 +374,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* LUKS volume key buffer */
+	unsigned long luks_volume_key_addr;
+	unsigned long luks_volume_key_sz;
 };
 
 /* kexec interface functions */
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
