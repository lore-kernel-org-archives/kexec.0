Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF9FC19F4F
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 10:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jU1GWjmZsVSiNpMq47DOj4bimHxzdpg50nKBTAXi8g4=; b=n9WhBVzuT+YImx
	8MSgA8esu8NRKAMjXhhvjt1Ecxdbp0JRPhH8kOO6NZzOafOkNS2re1nFyc2l2ZIairuPL6/kzhfxX
	t+tjuUD8Vj9eH0886PQnVJ1AJujzi1QwvWUfkz114Ioi8u8RntyAoCRkD8DUmG8AGG56uK2W1FBSN
	pSKgz3SEvV1hp405pVsPXV271wle+/g9sdq0reprzIJizNY529GyuclN4fVH5SPq6gRGDULYG5tCf
	g8kRnPQajEFuPP139NVyEtGN8x3p+A4zIbk2oVgQAXSLjWOSBsRJL/giWDMKc/jYkVLD/sC4De45c
	ovyoDguhHcb+J7EshZnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyZ-00000007ksI-3kr2;
	Thu, 25 Apr 2024 10:05:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyW-00000007kpA-1Ny1
	for kexec@lists.infradead.org;
	Thu, 25 Apr 2024 10:05:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqT75ILAb+wFvlIguVkiSmYBoQIWQKOiZ3Xjg0k4Etc=;
	b=if5bGIiWU4xXfsG5wCuj9bdzRVT0tzCRYNOLS9DaTaHdqGu+ahRzDssBbu+W/FbPpQ/wib
	7RfySae6Yn3jr7nDXwtOwai/Ra9KatK7WwyDqfj8/lQLu3NFtY4rcmtpSUdMJP1Y4qAK5M
	V/a8u0MhDUnAX6SPh9mP8nZGnK8+WL8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-Vb6925d1MVCj8hPKBf17hw-1; Thu, 25 Apr 2024 06:05:01 -0400
X-MC-Unique: Vb6925d1MVCj8hPKBf17hw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a30dc503f3so953598a91.0
        for <kexec@lists.infradead.org>; Thu, 25 Apr 2024 03:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039499; x=1714644299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqT75ILAb+wFvlIguVkiSmYBoQIWQKOiZ3Xjg0k4Etc=;
        b=NyVvt4VH3hMWBWodlukesz7PSMkyqAPfJ0elzfA3OzsU1fEsS/iiwNia0z2r+51H/H
         8oBVQ7GINXLwUbObLZadaHW0v5kYU6nlKBj/4iLB/K+nkpqJF+JbYlHx/FJEWFnzNHNL
         apv8qdTUQpH9v+utgmie3qXgetIxa/YyYvvs95aspfh8v+veyURnTJpTsZCyr03F2ApK
         +5UM9u4i2nQZEpZ557ghDA7DvxKzg8YmFp2Jwyb4Nhv+0pPE7jVPRYFnlodG3MPw4sEY
         SmN7DokaQ+g/QdZUVHlzabHwJHUWZoU0tl/NcivzO1oRlimxfC48zGfkclvnXyb5UNCT
         1eoQ==
X-Gm-Message-State: AOJu0YwgWuvfT4wLKfTF+nsYRmJGUcL0NIA2Fzuf2JZsajZx2Ois+ePO
	qGUWqb446JN7MOrAVbe03HzsbEebNHc8waUJyZCoGaV98Y1IDFVS4dKl/8QGec53KKVcFp0IA6p
	hyByw+5BHS3bgp4EdO9oTxq2ciBNwd3TgdUm/eu/GYTqieSs864pJSwaEmB19LAwUV/ogDfng2C
	SUYeXXISvQk9/1TLhynSksB7uBT+r6Y6XoVOBTtkyBSxDZ
X-Received: by 2002:a17:90b:33ce:b0:2a0:215f:dc9c with SMTP id lk14-20020a17090b33ce00b002a0215fdc9cmr5203430pjb.35.1714039498299;
        Thu, 25 Apr 2024 03:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkerGAZtBVpYNpabl6fa4ODw4MLi/9vUZ8BidoUeAUkdpOcdSRlbDJ6GDMr9WbPTTtyP66jA==
X-Received: by 2002:a17:90b:33ce:b0:2a0:215f:dc9c with SMTP id lk14-20020a17090b33ce00b002a0215fdc9cmr5203372pjb.35.1714039497570;
        Thu, 25 Apr 2024 03:04:57 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cn19-20020a17090af09300b002a2b06ce909sm14227786pjb.17.2024.04.25.03.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:56 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Thu, 25 Apr 2024 18:04:30 +0800
Message-ID: <20240425100434.198925-7-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
References: <20240425100434.198925-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_030508_810242_9AA29662 
X-CRM114-Status: GOOD (  15.13  )
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
index e74d0c4286c1..d852f9c99f0e 100644
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
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
