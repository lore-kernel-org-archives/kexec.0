Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C068AC3DA6E
	for <kexec@archiver.kernel.org>; Wed, 10 Jan 2024 07:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7etDMAvG9B06VOy8fs3v7eDlenMNhg0BFQ0bFvR/VNo=; b=CZ3lRlIQuQ1sP0
	TMn2E8XTRT+J/EY6jGD+4bgRzlEvgl1qVPc4HYmP/i161vUlL6o6l59DNc1mruo4MolFerjQMhtI9
	461IjRlAngZ6HKrj1lRy+Cn8NXD65T7bGkE2SzmYJ+Qy9JeuefOMwnvaFurXJmy1YUQJ3DGOUP3fL
	nqZwMUC0wTCajj4Ptx/5G0I/TxyBBkoeYgVnIlNDSsOzN/SfMR0AjodR5TbcsFN0ENkLJYFZfQEAj
	FDZsumvkj3BizxVN99L3rvJLsAG1Kwdx0Cm/xGMjJ7QaFWY0BBFLLcYrKv1daCpnV3kTQOpcPGEzy
	fqYybcA523vPFsnzR7YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSpz-00AaMx-0o;
	Wed, 10 Jan 2024 07:17:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSpw-00AaLX-1e
	for kexec@lists.infradead.org;
	Wed, 10 Jan 2024 07:17:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704871035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIMuati7cTP1ekV5ZbT9f3EKmgfJPaZbTXabrZEOoZs=;
	b=E2SDlvnUz3o5jgY1J3fBnzFOc7kJCkeOuCjcqB6bTYmR34DRVNhlM/rp5Cbjus+y4v52jJ
	z3MmGuNYOcQku4VMhZJOWKcsFuU8r0IcXoeTbchOn9D5MaK18tsRsxWfzlyNFDWUydbdvw
	BER5oZQHfvSiEIkglsp9xWWU58jmz1Y=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-kQW2SO1kMtqOIVzpwaWhMQ-1; Wed, 10 Jan 2024 02:15:42 -0500
X-MC-Unique: kQW2SO1kMtqOIVzpwaWhMQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bbf47262ccso4677270b6e.1
        for <kexec@lists.infradead.org>; Tue, 09 Jan 2024 23:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870941; x=1705475741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIMuati7cTP1ekV5ZbT9f3EKmgfJPaZbTXabrZEOoZs=;
        b=XfAnJ+VLIYVFfo+80w/YTOW+ICuHFTPgd4dkK1nYh8TAHCwH0gL/Vkde6wGtCdZkBc
         8Hih2kp4f8tRnNlCO2lkKrlNGAaimaiu707pL4QTTAghtH6M/URRMPDR20ND3eMVWBTG
         ztTIJpGIYa4Uxo2sbt/AVWGrhdibJVAF6gbMIP2XPDoXRIbZqCgvzXnDTIcKNfMor95f
         MntI30KI0aRn67Ed4paFvHNSYm822Pm+NP4NAURRXEnX1hSipl1HRJNrGz5VhWfRvG+4
         Ls6S1nt+tJxgxD3miqzgCc6UEyLTLcFP/Wl8p+BHcNJMX69ITQ+I3MDfBNIoAkBZgQYJ
         gI1A==
X-Gm-Message-State: AOJu0YxCbkoy8g8yTsIEo2Erty1NKzv0927iXDxILRx8WXqkhbsYKmBx
	iEPzVugPujy4aDsDahMKC3kflNEiKPK4sKeWmuCTBSBcj7nJvDo72Qd4FBxBrlKeJU77Mn/5Lo6
	laoOkFyk40H39yQxPy0oAT1wxphNHCC+4ApwFtWP0v1Cb0O2mnwtKbBuYvx7pKzQOVMccL+w1lx
	iGqRgckzOtLuZAG1o=
X-Received: by 2002:a05:6358:1aaf:b0:170:efd3:2d03 with SMTP id gm47-20020a0563581aaf00b00170efd32d03mr362976rwb.24.1704870940829;
        Tue, 09 Jan 2024 23:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJcFUBjKVUIJPEhGlRkafdWTlR6G4YnJSwKhOQCYafVe4/F9qJkNxmR+QYOhfzYVY6ABRGog==
X-Received: by 2002:a05:6358:1aaf:b0:170:efd3:2d03 with SMTP id gm47-20020a0563581aaf00b00170efd32d03mr362951rwb.24.1704870940380;
        Tue, 09 Jan 2024 23:15:40 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090ac10e00b0028d0c8c9d37sm751199pjt.22.2024.01.09.23.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:40 -0800 (PST)
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
Subject: [PATCH v2 4/5] x86/crash: pass the dm crypt key to kdump kernel
Date: Wed, 10 Jan 2024 15:15:19 +0800
Message-ID: <20240110071522.1308935-5-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110071522.1308935-1-coxu@redhat.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_231716_648828_F6BA7CE8 
X-CRM114-Status: GOOD (  16.35  )
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

1st kernel will build up the kernel command parameter dmcryptkey as
similar to elfcorehdr to pass the memory address of the stored info of
dm crypt key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/crash.c           | 15 ++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..69e1090f01bc 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -262,6 +262,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -270,7 +271,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	r = crash_exclude_mem_range(cmem, start, end);
+
+	if (r)
+		return r;
+
+	/* Exclude dm crypt key region */
+	if (image->dm_crypt_key_addr) {
+		start = image->dm_crypt_key_addr;
+		end = start + image->dm_crypt_key_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return r;
 }
 
 /* Prepare memory map for crash dump kernel */
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..6e8adfe0b417 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->dm_crypt_key_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"dmcryptkey=0x%lx ", image->dm_crypt_key_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -433,6 +437,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_dm_crypt_key(image);
+		if (ret)
+			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");
 	}
 
 	/*
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
