Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC61BC4332F
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XAxGP1S8oA4WRv822Oz4V/ifczLJL+35aOCpjXrbcbs=; b=LlMaYRVJGJcQE+
	+hzchWpQr4RJ80yO0dIhxyDA1gcXI11aH7CrlXd5PSx+y+E/1y5oBQmb60nrdBse94WelC2oSKxap
	RS5Vg9m5tPChRe6DrjQ7bNsAUhey94syKyljxNNQEdbOFLw/sj9KhJ372aSJQnHSeDaRZ8eiUyq3n
	MSEX6GuD91V5+LIF/JWkS9yV4OOgz0HIg/sv+I2ccuaQMSxSseSmFtHrTkRpePC1dZXWIelU6LUFr
	YEZnTrw0UUcwhQt1uIl9MFWn8uF/JvEebAYdw2TUX+YUwRvKpVjwPKBOTuRRk3dxvOcYeZvJKb2vg
	q4w/hpW7pl08gxeFuI5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquvk-003M5a-LL; Fri, 04 Nov 2022 11:32:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquvf-003M3Z-Cj
	for kexec@lists.infradead.org; Fri, 04 Nov 2022 11:32:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667561526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9ieE4VIDGcBaiULL1C+z5L6S0lWIm/B8H9v1NRSxPo=;
	b=h5dHY2b821bkEyNZCR9y3W8UKQXb5WxqncAWhtxjpLC7rOiMhCVGKl5eYjK+FXESJPnPRA
	dVjyoD1eCCIZzlnPym9WdTirfZlUkxpX5AttKsrPRJY43+wWjDK/lrxPMzFm/KrUk4HF9X
	FGG49A5cWsgUEQF5Bwh5m45Fg1F35iE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-V3K7hzarNzq_FnwF42Pb2A-1; Fri, 04 Nov 2022 07:30:39 -0400
X-MC-Unique: V3K7hzarNzq_FnwF42Pb2A-1
Received: by mail-pj1-f71.google.com with SMTP id n4-20020a17090a2fc400b002132adb9485so2313619pjm.0
        for <kexec@lists.infradead.org>; Fri, 04 Nov 2022 04:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9ieE4VIDGcBaiULL1C+z5L6S0lWIm/B8H9v1NRSxPo=;
        b=ejQ/sUhQSWO1DgdIgfENQ5BJYpeE0lwNFHqe6RA/0iRP4O7Vy6Pz1vOvNqfsh2HHei
         tABUJZrd1/59aqKwK91Bs30+jXKYCKqzOMX+TQGFmxi3UGFG7lYVbkeUZa68W5BvcU3L
         KpDuXxDMcJXktCH6p1Y7gDlHohKVBby1qUja8HqRnWkFYudcKIz2R+0DyG8hxKk+KPR3
         rlXtJyd/YjzB8WPzH6Hk0ngWm9kXkUhnvhtlWyWjNoWxWvYCMkA+y9eAngDHsotIxf/S
         yAEKlY0YUIhRcUJESQB1JO5+NHbaDe4PEmNWE+7hAgydEYBNt76GlavVazhOEVgYStHo
         uB7w==
X-Gm-Message-State: ACrzQf0AQY6jpQeW1dIrg5UTjk/b/5u8WcprAiiMKEAs9a+ep28/Dcub
	7fOV4k26sL079MXdNGcyMNaH/cPUe3n/oAtiHuMDcSHwdZW/5QcvE/0l0qYXRJ9E4d0nFovr8Ch
	5McUjT+h/QhH5K67eBfF35A4P8Y+9TVDcpeLZJ8OQy3QOIqsSDD3LR/bv7ziDl4hfitg=
X-Received: by 2002:a17:902:f28b:b0:186:b069:63fc with SMTP id k11-20020a170902f28b00b00186b06963fcmr35566396plc.38.1667561437695;
        Fri, 04 Nov 2022 04:30:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7qypMeRgTqbqOB76+RxKWKqrfx12CwgsfSjDZBxgJGySGlq0PpZpwe2FJNfIghklVFI91+FQ==
X-Received: by 2002:a17:902:f28b:b0:186:b069:63fc with SMTP id k11-20020a170902f28b00b00186b06963fcmr35566345plc.38.1667561437294;
        Fri, 04 Nov 2022 04:30:37 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k30-20020aa7999e000000b0056bcfe015c9sm2458149pfh.204.2022.11.04.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:36 -0700 (PDT)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [RFC v2 3/5] x86/crash: pass the LUKS volume key to kdump kernel
Date: Fri,  4 Nov 2022 19:29:58 +0800
Message-Id: <20221104113000.487098-4-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104113000.487098-1-coxu@redhat.com>
References: <20221104113000.487098-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_043207_516241_CDEE023D 
X-CRM114-Status: GOOD (  18.75  )
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
index 9730c88530fc..5ceda2802482 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -304,6 +304,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -312,7 +313,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
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
@@ -383,6 +396,38 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
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
index f299b48f9c9f..e556dbf96695 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -75,6 +75,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
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
@@ -371,6 +375,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_luks_volume_key(image);
+		if (ret)
+			pr_debug("Either no LUKS volume key or error to retrieve the LUKS volume key\n");
 	}
 
 	/*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c0edb64bf6c4..ed7a0ec70129 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -385,6 +385,10 @@ struct kimage {
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
2.37.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
