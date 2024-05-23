Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5AEC25B75
	for <kexec@archiver.kernel.org>; Thu, 23 May 2024 05:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1zW1VYP4874NAxMlkpR2riJadADIiCLQKvKXzdXt49g=; b=zvG+DQhYzXMy7X
	yti3ofIvhuCNHB/j0jDE1uBBb1rvYaYLxaDAa7Q636om6gqZCJTD87/k4BqW7vyO9esSrqFGWbw3u
	6FMlRvKghbIu0aDF8Ro/a+n6j4g0PsH4R6jJ2SHl6mjCZqmRkiQTPOd+TJO8YtFOaCRzTAqBOeVpU
	XKd/5KW9zlkftA8QoKlwe4p+uTw9GMM91+rDU4b5Lqw/oFZOSIyoQLPy0wAgNdLSebASUuA7Pd00u
	D2O5ZQrgc2+5pDIsXwb69r6n/KX/HN0j780cR7GngRIM7b9Y3FKqUyrNMmWufesZHfoddh9yMlM9m
	p+rBKIZMz+aXiTpjC2+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0du-0000000541p-0MW5;
	Thu, 23 May 2024 05:05:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0dp-000000053xS-2ND2
	for kexec@lists.infradead.org;
	Thu, 23 May 2024 05:05:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXqG8tM8YcaI9rGWt1KJ0lfMUtcaUoa1T7IYtFP1N5A=;
	b=YgqolL8fi/zwKwhe1zJQfLFZNDWzAjVR8+Y0xho0VKhFw+C5wZ5RSY3Ky2HFLk04JtNlfo
	v/OOe9GTlOKMdqXPtgxqez4fF3G3+af8GG7u2wJcslTCBsflQMC5UwdK1W/6W1513PnyXb
	MxaH9WauBCVegO91MVrXpiJ5OQie4vM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-Af3DTSY1NlO3vpUxmhOV0g-1; Thu, 23 May 2024 01:05:21 -0400
X-MC-Unique: Af3DTSY1NlO3vpUxmhOV0g-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6f10ce0beb8so779062a34.2
        for <kexec@lists.infradead.org>; Wed, 22 May 2024 22:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440720; x=1717045520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXqG8tM8YcaI9rGWt1KJ0lfMUtcaUoa1T7IYtFP1N5A=;
        b=m2/Y8pK3orYL47erPin+LR8TYZk+qliZdP2XTXLPK68zQSy2xMbDLWlqrStaQXRT/c
         kejlRYAAAkOVFd4yYjXeTpLVCA5g3cCDK6muuHo7G42IYc8mIE+2H9UKsfUVHm5OLHfP
         1VWd5eBjjf0ZQayPlVHxMDvzVmn0BWEru1yEjU7gbNnBHMClhWgZT+nrPj2v11fEAXLM
         1jx3wmWQ3DSotTnn9FniKoVkSWRutz66SQJG2fmi7A9xyjzXAdU3ZCBdDbwRVNeO+o1I
         elprWWsswI6pS5oMAb+bzLRRP8RCLTStWj9zGGm2dYBb5FF2HJxbq6Qe/5HrPq94T1vR
         TvrA==
X-Gm-Message-State: AOJu0YyNWnzAwyubZ7IKSuNlIaKNzGi+/P0FL9vO/8Jl4AtXjxGiHmZt
	JHhgDskl7KfyPlWCZjzgxDED/OcdSdk33Tb7ZD5EcA91CjXdkiLvNe9Hk7IKq9xHGQAlv8ZCZTO
	ZS05Sw0nkN+y0NOtCEoLFD+OWcl8+eqO4olHB1BypXIf3GVwMznyjZE+JeKG1K8LlUd8g1hl8p4
	bTuOCDAPRq/efqFXHniferK9zF331AvlFSkbscJiNtvPjn
X-Received: by 2002:a05:6830:10cd:b0:6f0:bf65:9c42 with SMTP id 46e09a7af769-6f666f7914bmr3888035a34.15.1716440719484;
        Wed, 22 May 2024 22:05:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWQA1xavODDuyHNmo2P3AvBsnEdbuteghicukf23qUMHJD1rGUHnEt8+t2eLKuyEOwcoEKaA==
X-Received: by 2002:a05:6830:10cd:b0:6f0:bf65:9c42 with SMTP id 46e09a7af769-6f666f7914bmr3888000a34.15.1716440718826;
        Wed, 22 May 2024 22:05:18 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63a917264d6sm20539102a12.73.2024.05.22.22.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:18 -0700 (PDT)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Thu, 23 May 2024 13:04:47 +0800
Message-ID: <20240523050451.788754-7-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
References: <20240523050451.788754-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_220525_716799_708D1157 
X-CRM114-Status: GOOD (  15.17  )
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
 arch/x86/kernel/crash.c           | 15 ++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f06501445cd9..74b3844ae53c 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -266,6 +266,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -274,7 +275,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	r = crash_exclude_mem_range(cmem, start, end);
+
+	if (r)
+		return r;
+
+	/* Exclude dm crypt keys region */
+	if (image->dm_crypt_keys_addr) {
+		start = image->dm_crypt_keys_addr;
+		end = start + image->dm_crypt_keys_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return r;
 }
 
 /* Prepare memory map for crash dump kernel */
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
2.45.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
