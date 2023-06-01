Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D80CC77B7E
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 07:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A9u0RQcD8+77a+Oggmzj/ZzTW9MrmyQoHbog8edyOkI=; b=jNYe8jPQzaIgsk
	TO2tGveBZR7TyuMnLtqZQ5p2lW1rDOh8y86AXMkBnrAWMfjkQHHtDoGSmiBUehAkf+Y4VOyQ/nZ9k
	bCQZxGgvJCfU8F8go7FYzvitCPQ2wVokquiEGXLSdgCTI2QNN0rdCGB1bGCKjnuu5oTSMwkIoxAGe
	hv6JcaqUbVke5Se+61ruOGIWKKRixAfPQBsYSp2EZOMc8fje3OL11jIUBCJXAXYRM3YFJB+Fv1oP0
	hTI9SOcNPG+lwFJDb9VndqHBnbU/xv3wn8PZjU97ZFhE4CRbcgpkIpUxLrIKBQfcmGGHfqxNKGe+q
	yimWM+5u+9U0dDhQd/Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4cho-002Ltp-1s;
	Thu, 01 Jun 2023 07:26:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4chm-002LtG-2f
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 07:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685604402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aefU4VwU8oFOQYKmAqFmOKJxhlCYs6WtVK98Xo9Ylw8=;
	b=J9ibt8fbEP0yVHmSgD7CHJfUJhwc4aHfDG5MCJWqjENlcavJhq4Wyl3mAPSvi+K6qC+I/Q
	7DmkQAB9mM33MExG+jb8L2KErH961wnu71vxqvj9aYar/+IzeQKjwz2HVHWkmT+/ZzkpmF
	mvfRYW5rutqCnO1SjxZz6OSW14nPKEw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-teT737p8O7mnakQ_o5_Jjw-1; Thu, 01 Jun 2023 03:25:08 -0400
X-MC-Unique: teT737p8O7mnakQ_o5_Jjw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-53450fa3a18so579712a12.0
        for <kexec@lists.infradead.org>; Thu, 01 Jun 2023 00:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604307; x=1688196307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aefU4VwU8oFOQYKmAqFmOKJxhlCYs6WtVK98Xo9Ylw8=;
        b=lyB5F2BgEAnIbLgZ1k/UpaJGQBflVe+IYPqOfBVBJxoUuI4LGVBlF850gy0nN3S8Q5
         yISiNOolH5xqLnHiGuu4qBVc1WDonOYogmTpeL8lmAO8aZaPJO/usCZSjblcYSaL1HQn
         gxzo2AIr+VGh9hp/gh0hQb9BlCgKlCetjhDJAhQhy81OrsAk3oVYFk3TwUVWTYSwmAMS
         2MK2B9IPnlvTCeHQmc6p5qtyBV4tMlvuDt3ih7EmTphGaGM9Lw2eFM10mPVxMMcidyhU
         MjITt4O9CzF2EosVcV17rHucmH9CLnF8vQhzqwjrw/Q6WGHI6YbQVSHVnYCPXWc7K6iF
         mX3Q==
X-Gm-Message-State: AC+VfDy7kljA3wD1tY4QRAogtllyx9f0zKNX4AQFidrKhp7Askdiwr4g
	K5xh5zriIk8LE8TEd8AsR+jnFQFSy7uDMkzeE8lmpsuaFGfyayG2gVdQSWcrJ6aMUqhNLcMWeti
	FY5AF48z01BGKGPbH5KVYxTz+I0Bu7ExXAm0ed6VfnPwtRzRRfkNrwxWRKPsmvxn2zCGOvyBLY+
	mGR0gdcSM=
X-Received: by 2002:a05:6a21:998c:b0:10c:37ed:3e88 with SMTP id ve12-20020a056a21998c00b0010c37ed3e88mr8900725pzb.23.1685604307481;
        Thu, 01 Jun 2023 00:25:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63I95P8dhhdJ7s5jrMayaANp/DzsGmHfYS5azIKGpulSOOXmtAzsGrmoW2rz/wazIGcv1tqA==
X-Received: by 2002:a05:6a21:998c:b0:10c:37ed:3e88 with SMTP id ve12-20020a056a21998c00b0010c37ed3e88mr8900696pzb.23.1685604307121;
        Thu, 01 Jun 2023 00:25:07 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001ac5896e96esm2644901plg.207.2023.06.01.00.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:25:06 -0700 (PDT)
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 5/5] x86/crash: make the page that stores the LUKS volume key inaccessible
Date: Thu,  1 Jun 2023 15:24:44 +0800
Message-Id: <20230601072444.2033855-6-coxu@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_002642_938455_AAC7F20F 
X-CRM114-Status: GOOD (  11.23  )
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

This adds an addition layer of protection for the saved copy of LUKS
volume key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..82d1ecb35827 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -546,9 +546,23 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+static void kexec_mark_luks_volume_key_inaccessible(void)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->luks_volume_key_addr) {
+		start_paddr = kexec_crash_image->luks_volume_key_addr;
+		end_paddr = start_paddr + kexec_crash_image->luks_volume_key_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_luks_volume_key_inaccessible();
 }
 
 void arch_kexec_unprotect_crashkres(void)
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
