Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AF8C0219B
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 08:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+vuW6U48iDvPQRM7yyRLxHLzZYL+ucqowEQ4SiSdz8=; b=2PrVCUQqD9v5hCdz0WMx1fYpnc
	VVE0YIa96Rw00fkBI5hdW2pGeFlXPRKEModJE74jD4pfn2qDHPybpoCl7Mi1SD8UX6yNxi2QRs3lG
	XA7xlr5Pue3noZJdvVYOFulkvclAySq71uwYDwhC12VjhTo2jIoIi3RMFiifQb35MDX56wQj26Woa
	bYb3jqpUXQReaJ7/L/j7B+XGF56dY5uli0ESCgEmRcDm5Ox8XvQu8UObHQ1yF7uah7Bb80ATzxDVH
	mcCHcavvSd2x90ftc3Acjd6HdCqFZs841tu54sf0PC6ocubLpEcUG/oV0tVmCdekdA3JLPF0sSwGc
	3G65wIsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJWI-00000008mS7-3x0h;
	Fri, 07 Feb 2025 08:15:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJV0-00000008mCh-41Eq
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 08:14:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738916045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+vuW6U48iDvPQRM7yyRLxHLzZYL+ucqowEQ4SiSdz8=;
	b=CpSmcV25onSDhLsTkwikTKSEh/pQTG+b6d/TrSMPVKk5UTwV4RYaqpOwrPx+5rKcbXJr2/
	gsil4hcDsJEwJRQsPaipyW5iDnLVUd2FJrDnGrK3XaH4MTwWJsVGRR4USlyBgZIDMvTPwO
	xpFkkQfVazlojyI4am0SN0IebJ8F0iw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-nwa1LEOsOvyzZHEXVAvg-g-1; Fri, 07 Feb 2025 03:14:04 -0500
X-MC-Unique: nwa1LEOsOvyzZHEXVAvg-g-1
X-Mimecast-MFC-AGG-ID: nwa1LEOsOvyzZHEXVAvg-g
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f49f0bd8fso16402015ad.2
        for <kexec@lists.infradead.org>; Fri, 07 Feb 2025 00:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738916042; x=1739520842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+vuW6U48iDvPQRM7yyRLxHLzZYL+ucqowEQ4SiSdz8=;
        b=JIZQLjQRGhctsFrrPkKc96GosOUmJaxSKNPEpxOZZkdDXhaU7dwLRq7CS8oMUMtk4I
         y4MKpMdF9E97pESghU4yJkOcmfjypEZy/mHj3gsbboBk2ct0mIH+VXPRtDIT/JN7qeVC
         5tmhqjkGNHl3nSesF8osCxoQgGFrdUra5M7+MEiHV1VR17oRQCDSYy/p1I784QKbD12E
         /0+mWRbbNG+2HnKBbXLLVTDvs7v2qQsFLYlZU4zFHjaYiLfKgca5ZjcAO0/Z+jnJNH7m
         NqdaIn+rZr5HKSJ8ce10dK9LcPJtFU3g7RXio42bgufV0fSWeK6hlqbt2RIRU5c3RzvQ
         UUAQ==
X-Gm-Message-State: AOJu0Yw4Kkd2QrSpAqGK555Np7yj/u7GXNHDmA4L+tX24SWU0B4ZLufc
	N9jw+rgbv+K9294BfnpJbuJ+evCi1YBJGxKfkZB9HUjey6JS6eoC3xTebzsdulXNuq9FW/enXeQ
	hf+MWP6K/iv1nzUJMrTBOs7MYBYrzxV9khd9817n/XHr84T8/nkX4Gl4LVrW6Hrq9uEQKGOEHCE
	s2xgZen7BptPkKstevvjaNd8Nye8d5r66g4/uVTj4EVzSF
X-Gm-Gg: ASbGnctiC7ympUEsM5XlwRdzs+SDujNhsq3bganaK07zq28FXBr/oeBSpHFw6ppd5DC
	dugmG+2dpbz07GoJVxJQ4tr0eC+Mx8U7lshG8h8RDJ2oyT57Fmnge3bGew/lgewHQqIYDtSxlAK
	n/IDDBo4gPJgf9UOxPPbbY7yzXKM44vzQr3gcfzMnAxlpUru8EVsbDeK5cUyMU1TR4uWB6imDvX
	jRxnnLW5glaLkgmXuYZPhI97FR6msUHPNwQxQn4/VAHP2dtroFflHzoQpiqQa3z4GmJOlKu
X-Received: by 2002:a17:903:2309:b0:215:a04a:89d5 with SMTP id d9443c01a7336-21f4e1cf038mr40201575ad.2.1738916042523;
        Fri, 07 Feb 2025 00:14:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgk9M0daWYVa2Ek7u8oS/CFLYtRBIoNw24mfM3TS73uCeiCwSamNzyIev1riImUKcHHz726g==
X-Received: by 2002:a17:903:2309:b0:215:a04a:89d5 with SMTP id d9443c01a7336-21f4e1cf038mr40201145ad.2.1738916042195;
        Fri, 07 Feb 2025 00:14:02 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d8bdsm24540065ad.151.2025.02.07.00.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:14:01 -0800 (PST)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v8 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Fri,  7 Feb 2025 16:13:58 +0800
Message-ID: <20250207081358.129794-1-coxu@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207080818.129165-1-coxu@redhat.com>
References: <20250207080818.129165-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pLTwAp7bFwULg5AhFgXZo9OVbr7Q3eqFYnkM72EoIy8_1738916043
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_001407_076984_2A083F0A 
X-CRM114-Status: GOOD (  12.35  )
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

This adds an addition layer of protection for the saved copy of dm
crypt key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a68f5a0a9f37..f615fcb6d35d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -598,13 +598,35 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+/* make the memory storing dm crypt keys in/accessible */
+static void kexec_mark_dm_crypt_keys(bool protect)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->dm_crypt_keys_addr) {
+		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
+		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		if (protect)
+			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+		else
+			__set_memory_prot(
+				(unsigned long)phys_to_virt(start_paddr),
+				nr_pages,
+				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_dm_crypt_keys(true);
 }
 
 void arch_kexec_unprotect_crashkres(void)
 {
+	kexec_mark_dm_crypt_keys(false);
 	kexec_mark_crashkres(false);
 }
 #endif
-- 
2.48.1


