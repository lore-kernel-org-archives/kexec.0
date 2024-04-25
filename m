Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5498BC4345F
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PS8dzs3gX1Ri/syj6khylAKz1z0Z+FANuuX7txYH3ck=; b=y62ZH7I6ZyY35I
	dEefyLl9KAcaz9+XwqMgHDOwrQbcOkS6EDkZWdT98Y1+hAFaNap0/EPT7WZfAfbcsIa6n929wauH8
	mzcfArXfvliLuiqlrqSyOWLIWrjs4YsUFsu10aDOg3eApAh4zSLx+euMEG+QsHGzjERM3Cucx2Yrv
	W9hfhcqpsH8HP/G5gBvaXoBWQzFsgtHX1OfUoc26/C/DROserBqkqguI4InmWD3CI/NEDab69VaGN
	NOyCypx82B9QQKnDHuaKYMA5TnhWKHeJ51LpFJJ8js22US3Xlg/MPOob/T5tZy+9a7rOjLHHDDmum
	dUeVH11dyUZ5GHFhxEYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyX-00000007kqO-3CfN;
	Thu, 25 Apr 2024 10:05:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyU-00000007ko0-2Y35
	for kexec@lists.infradead.org;
	Thu, 25 Apr 2024 10:05:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xe1JC3zOdrEKx3bfWos3eNZ27bBtqkJg+ds4Xh05xA=;
	b=FEl6ahLHymgG+JKCsMnqYebfgHcqcnIFsSJtzuAquRjvgfSGTTJso/DkpdGXHwpNhh9wbD
	kTIWaeJzuoBsONNBnaws6u9UEl3lVos9DpJcODcev06RKBFgpMaTiY80/f94hPufDUUiIO
	hEenPYBxEHtNImX1zVpmqAjzhnOSBgY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-mT0cBi-CMJKIHnde85-Hbw-1; Thu, 25 Apr 2024 06:05:03 -0400
X-MC-Unique: mT0cBi-CMJKIHnde85-Hbw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ed25eb8e01so687455b3a.1
        for <kexec@lists.infradead.org>; Thu, 25 Apr 2024 03:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039502; x=1714644302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Xe1JC3zOdrEKx3bfWos3eNZ27bBtqkJg+ds4Xh05xA=;
        b=tDI8OcPsegA8RypxFepjVttFd8ErjO7h8FjaJdAZ3mdnlPQPfhuK1RzSBLt7WMHBA+
         y6abtDtYBF6TnvjMfC8ePaGelYU4F7yFvM7XKxnaXyiPe9tVJ7rnYWtHVejhzq8x8xn3
         cmd+T+UDNFP/KUL0wnl3jatHS0WJPlckGb45ChHbXlECNRWP3QG+ihQOayxJIqDAxi5O
         1dsxpMiTH0pqbvH+6tvgCZdMXcxDMMPIZa67kpkksnNHsJ7KBZjGOpkAQlIMRrVQVOde
         e/7hDvwHs4g6JlnhezB1gIK8I06qqKNAAYhhBUIeBnW+FH2QwW0INsDxPXe7vC5w5JbJ
         HSKw==
X-Gm-Message-State: AOJu0Yz+CbQAXVZG1LBI3MzFFXEcNOoHtMQ0oGjlOT7lpjT5p4iYEitd
	X5cqX6UpYqCRRgv9/+w8606a9zPljYAIw9YC8buzUoAAp/G3SBwgOIMzpUTN3W13UQ+BO3/4KHz
	RRBtNtwxkFVNer346sq5egZ3ByscvZdbNL0hxSt6lEtfOMyjstd25RnGzudSfGfuopj5FrF/42J
	bwpGIJfRbHzb2Z1BTYFBJ9w6j3nJIMST+qQlQ7llvKSHyd
X-Received: by 2002:a05:6a00:2d87:b0:6ed:60a4:6d9c with SMTP id fb7-20020a056a002d8700b006ed60a46d9cmr6295374pfb.4.1714039501942;
        Thu, 25 Apr 2024 03:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlZH/ckE52CwcRJf2H+llCxl7yd6By1lfHpxqvpexbrw9hs0sai3i4uDCf98L8TPTdXJ+Vcw==
X-Received: by 2002:a05:6a00:2d87:b0:6ed:60a4:6d9c with SMTP id fb7-20020a056a002d8700b006ed60a46d9cmr6295321pfb.4.1714039501295;
        Thu, 25 Apr 2024 03:05:01 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id go20-20020a056a003b1400b006e6233563cesm12775607pfb.218.2024.04.25.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:05:00 -0700 (PDT)
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
Subject: [PATCH v3 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Thu, 25 Apr 2024 18:04:31 +0800
Message-ID: <20240425100434.198925-8-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
References: <20240425100434.198925-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_030506_766931_B5A8AE9D 
X-CRM114-Status: GOOD (  12.05  )
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

This adds an addition layer of protection for the saved copy of dm
crypt key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..fc0a80f4254e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -545,13 +545,34 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
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
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
