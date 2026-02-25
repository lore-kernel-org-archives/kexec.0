Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E453AEF5862
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gmrGSNfnGiWDwNvctHFqdcRxKu8ZGchqf9tdlqmXs2o=; b=HpQhJAwnmwW2hDETuuYWe1eZcY
	nSjSMGw+WHlPZYpP1tYyd2R5KyCPhN2fyTFJ3HH1C7ZWFXG4181Vm6FbCv/10keQhWuWziySD74iT
	44RTYf7b8sB26Y/Xm86jKIOkJ4o65FZ4zmnGfwaxEhg6H74IFjrs93Ff/qpNgCbYqVnV/cegxcjcj
	/I0/bjJXoqNvvOi+BBrWmajMAv3Ih5XdFP/wMZA3PP9AZ8iJ+V60olZNsO8QIAmN9DkLf7OXqhm9y
	+YVvRQ0fBWVX6wf1fut90qoHS9If9OQkZ/jJc1NE9VxgWXsMvryX3e9v0LO/maqYgYU2VUisb4xCb
	9zrgaQDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv80C-00000003H5O-2aON;
	Wed, 25 Feb 2026 06:04:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv80A-00000003H3o-3yJg
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 06:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771999442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmrGSNfnGiWDwNvctHFqdcRxKu8ZGchqf9tdlqmXs2o=;
	b=fpxHKFZE2RgTpFFveNzUpKkRxrMgMUD1LQa0nRlXQavh88M7uE0fKZWmJcIiPeog3eiqlJ
	oeIpdxY207H/j2n1BtwKCsxUxYtQDh4lK4fOaKBiLXn+1d4fGau54NG5GocnLQNaKn1Pnz
	daDd62ob5/gHeugywoOfJBrkd9lyL+0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-EeEAyEC0PaOHQfKnTsFyow-1; Wed, 25 Feb 2026 01:03:59 -0500
X-MC-Unique: EeEAyEC0PaOHQfKnTsFyow-1
X-Mimecast-MFC-AGG-ID: EeEAyEC0PaOHQfKnTsFyow_1771999438
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso3785479a12.0
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 22:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771999438; x=1772604238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gmrGSNfnGiWDwNvctHFqdcRxKu8ZGchqf9tdlqmXs2o=;
        b=k+vstz/i+xwiJmUKGAYsE5S1QUCDkuD6QA7/uq9TLeVeKj02DbFN49dfXBfCpPVy5U
         40lefItnLDqfjbm/9wA2CipwFXojILyx5L3yP4kRfCbXfA6skNTGrzQQwP+/YFSbiALc
         o+9CnAxZYjTknCxqPpyq7bB7hRZDbqLcywm5VsuTYKP7fi3paE7SHHrdvF0tTfyGqrAK
         Z5RrHZGR/VpSaYYDNMcGCZ/6/Kiystz7h9INifvlIPEO3XA95Ccjf59sxQ20JmFeGASM
         d/k7b9u61D9f/G2iCD71TJxxJVNT+yYnu2V/7hNURoq5zpKbXULel9KX/sgVmAL0Ze/h
         pLug==
X-Gm-Message-State: AOJu0YwS68B932mjcSpeBrax3+dkmWR248+/yRrv1RW0tUuq2ZfN++qQ
	aRSidNgO08/WbwIK4+oxb15AWvANdR2YXCI3DK7UPX7MCM7KYOyzQlow9pkbcsyrv8wnOD2v8uR
	wvVPDWclluSK4tY3Zy0jDv6SKnzmSdelv0QY//F1aYZUbp4UaFPZaue6RT+/GuUVkdmlkYolFYe
	AzGFetVxY4+IpZNI7pZXP64PFF4P7od+qIn7U41nST/IM=
X-Gm-Gg: ATEYQzzNGTWUvwdk48C6puSRsuJAbW1YzR58x9FUHDLlGg05EGB2FEMj92e/7DBNMav
	vGZAaE3xnsBk4IVJBKQUdVI1pMxBoJ75P8/96T8aO99t+ylTlIGgRmQwgszj1j1CvGOGFQJvKmI
	/whkBnVDfaSHzhP+P1nmlEZfVvv5xkbxdTXH2MjUw6hBVPqmeeIo3P9vUPaceP3ohqGKdMHMm0d
	4HwN50puViLQhoSfElvyyr5BDxaUQYW9kCmln9Dw0zGsBXmaplFnsgv9WVYthUVpAQTlMamWaXy
	XqsaGohbdaY+3lUUMrjUDdJYAP/54il+oGgLm5T+kPPxJh+j7AIGQZdjz8h3huxld7IJVw2LgNu
	NLPbB9U6ifM3C
X-Received: by 2002:a05:6a00:4c82:b0:81f:4d16:5d8a with SMTP id d2e1a72fcca58-82724a3529bmr1223072b3a.29.1771999438003;
        Tue, 24 Feb 2026 22:03:58 -0800 (PST)
X-Received: by 2002:a05:6a00:4c82:b0:81f:4d16:5d8a with SMTP id d2e1a72fcca58-82724a3529bmr1223028b3a.29.1771999437424;
        Tue, 24 Feb 2026 22:03:57 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8fdb81sm13000482b3a.64.2026.02.24.22.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 22:03:57 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v5 1/3] crash_dump/dm-crypt: Don't print in arch-specific code
Date: Wed, 25 Feb 2026 14:03:44 +0800
Message-ID: <20260225060347.718905-2-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225060347.718905-1-coxu@redhat.com>
References: <20260225060347.718905-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N73dN0VRr_LpMgDCTcIrmrjLZ4ULXT7F6EHJRQvltX0_1771999438
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_220403_074181_5ABA06C1 
X-CRM114-Status: GOOD (  15.15  )
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

When the vmcore dumping target is not a LUKS-encrypted target, it's
expected that there is no dm-crypt key thus no need to return -ENOENT.
Also print more logs in crash_load_dm_crypt_keys. The benefit is
arch-specific code can be more succinct.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 6 +-----
 kernel/crash_dump_dm_crypt.c      | 7 +++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 5630c7dca1f3..7e980ea49d8d 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -525,12 +525,8 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		if (ret)
 			return ERR_PTR(ret);
 		ret = crash_load_dm_crypt_keys(image);
-		if (ret == -ENOENT) {
-			kexec_dprintk("No dm crypt key to load\n");
-		} else if (ret) {
-			pr_err("Failed to load dm crypt keys\n");
+		if (ret)
 			return ERR_PTR(ret);
-		}
 		if (image->dm_crypt_keys_addr &&
 		    cmdline_len + MAX_ELFCOREHDR_STR_LEN + MAX_DMCRYPTKEYS_STR_LEN >
 			    header->cmdline_size) {
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 1f4067fbdb94..2f7b42b09673 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -414,14 +414,16 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 
 	if (key_count <= 0) {
 		kexec_dprintk("No dm-crypt keys\n");
-		return -ENOENT;
+		return 0;
 	}
 
 	if (!is_dm_key_reused) {
 		image->dm_crypt_keys_addr = 0;
 		r = build_keys_header();
-		if (r)
+		if (r) {
+			pr_err("Failed to build dm-crypt keys header, ret=%d\n", r);
 			return r;
+		}
 	}
 
 	kbuf.buffer = keys_header;
@@ -432,6 +434,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	r = kexec_add_buffer(&kbuf);
 	if (r) {
+		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
 		kvfree((void *)kbuf.buffer);
 		return r;
 	}
-- 
2.53.0


