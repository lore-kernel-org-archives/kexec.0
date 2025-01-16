Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A85E77188
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 07:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4HyMInoAYn9hX25Xcky+1R5gRqRXU1eKRQBtwuBzyQo=; b=BbQ+HjvKHRfomfTnlXjHSUxLsA
	aA5qJRXB9y6oY7qKTGfKefEymLjlARnWoxGAfb2fX0e12oFV4bLp8IPTgWYR6LL/3AFe76SDiT3Rc
	S725l9PfOuoGq/nybUzgbMg7HpIfCAEGW8rBu7DULrNNebae1OBNwBfCX+FgkZdB62MrarH7visKr
	aSjC7AtsyCrrkPhBuC2NMxPPPqSPwl24U7kkP+wr6TxgOu1G1aA5f9T6REz6gzM5ZRp5TzDY7FaeX
	ife4EzUjbbj515zRKT0YhKSemws892u1mXNjtQu0S9V2Uk54J9ZFpPw0Eleoa+ysk/OrbxEpfLoj7
	gikhYJaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYKNx-0000000E3ss-3VQ9;
	Thu, 16 Jan 2025 07:33:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYKLq-0000000E3Pd-32hs
	for kexec@lists.infradead.org;
	Thu, 16 Jan 2025 07:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737012697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HyMInoAYn9hX25Xcky+1R5gRqRXU1eKRQBtwuBzyQo=;
	b=efahrMmD16Iq1Zukg8yJd/iY368OgP72uTilzFzMsHm2Nd4fk9rxtSKqVMhiZW0qF+SXgq
	ue4WM2PVicFjPGk4FL88f68UhfWImmb7kmZqyiqbcIAWxu+eopyB7gcGB39gV9OncrIvpJ
	2pDMbrGaC8+oG+C+OGtwCfoV5mjyHds=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-gywdCtgGOq2Qrj2yDtmiHw-1; Thu, 16 Jan 2025 02:31:36 -0500
X-MC-Unique: gywdCtgGOq2Qrj2yDtmiHw-1
X-Mimecast-MFC-AGG-ID: gywdCtgGOq2Qrj2yDtmiHw
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2166855029eso14045075ad.0
        for <kexec@lists.infradead.org>; Wed, 15 Jan 2025 23:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737012695; x=1737617495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HyMInoAYn9hX25Xcky+1R5gRqRXU1eKRQBtwuBzyQo=;
        b=Jd8BcAyC7e8b385GwidLEpOAdOe//gtA3uqG3XrodX0DUMjgyLRbGHEMc+la3B2mBS
         lidjR420dwaK/JNjZl/c2x0zvCCbfUJ8SR6Py+YYuuBbeX/DP8GZJWL+R+Y6OpynU4MA
         EWPsLpfLCuebKeHs2wVaov9fWnepYQiSH2BdBpSL+0+/gNC2SlTRHdmOREYYC6ppGn/8
         BGFnvHKUbwOWVEoomakH7ZuTYQVTIaO5JY/dOVtOLSpkLpHLlr5w0W0vDkgqbvOdQPyf
         yttBqHEFN5Yp2qsQcpGut/rBVepyVHkr1VndT8m2LKtiDZ1qngZp9s9lpqNrKn4DXqMd
         Hk3Q==
X-Gm-Message-State: AOJu0YzQodvxl3Lb/h1ILYx8bP6HKR8JvE3uTnQZT4TOHz5gY0ADMHMI
	3MUGveyd4gVGsjqE3XPYG9HG0AG9pho6qd0FXqrQDonOyor4EbqVM5rhGnsg05K/weV0PMolKK0
	UaIbk1YjL7Gs5zl50GPuuW2l2JYHxHK0ZUGhofai22ojLu58pi7IfZF2SiHXL8VYVASnVqMZ46A
	k0Oeyi5w4eAg3EHPS5zptvfOhNhUhwXBo3O9M31x1rmw==
X-Gm-Gg: ASbGnct2Ao2gcl4lWH6khdk5iIi8oSGXWTCVTGLYg59R+F1m4o7hOoP288vThjQ7R9a
	d/IyDOc2+w4nBKJh/3lQyE1JoGJ5+D0yPNnnJR8USh49sgr9jEdjPKCAyLihPb3rHhax3VqTLz8
	eoyh9HiTO9puRmyFKfGquifdJK1zumr8kO8Oyugew6zZxPaeXVV9M8K6TuWfMd/CZx7YqcYW/Mp
	5myaLvaojgraidP24WthYpBwSeaMLEqFoFJu5qmoOuyHatP
X-Received: by 2002:a17:902:cec3:b0:216:7ee9:220b with SMTP id d9443c01a7336-21a83f4f43amr572987165ad.22.1737012695096;
        Wed, 15 Jan 2025 23:31:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnDcvWN0Dcty6Dcu7TZDQFkD2YMlJT6ykiEDCc5NZUb+o/QPLJQrH8BeqNF7oR5PEH5HIFtA==
X-Received: by 2002:a17:902:cec3:b0:216:7ee9:220b with SMTP id d9443c01a7336-21a83f4f43amr572986675ad.22.1737012694645;
        Wed, 15 Jan 2025 23:31:34 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f256fe3sm93416395ad.243.2025.01.15.23.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 23:31:34 -0800 (PST)
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
Subject: [PATCH v7 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Thu, 16 Jan 2025 15:31:31 +0800
Message-ID: <20250116073131.1044000-1-coxu@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116065825.1041558-1-coxu@redhat.com>
References: <20250116065825.1041558-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CY3soSb_y9PVWwFU2NbEwB1Wwv_hsEE-IzKSalUBjW0_1737012695
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_233138_831244_7FE02066 
X-CRM114-Status: GOOD (  12.81  )
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
index 9c9ac606893e..7389b912ba43 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -579,13 +579,35 @@ static void kexec_mark_crashkres(bool protect)
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
2.47.1


