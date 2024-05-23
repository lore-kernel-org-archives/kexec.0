Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0482C25B75
	for <kexec@archiver.kernel.org>; Thu, 23 May 2024 05:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZpDEe2XmcrLaxfYIaHGZpINnk1Nxqh0Z/jXatBLt24k=; b=RcTfnQJXQq7dWI
	tq364Ftl6m40y4Q8W0ZONxs2jw5rO8QS5yKZwXH3IPJoLJvmnY93TGjzu3rATMQ/jeW1k8E6dXYAu
	vbo/4eJiZtT/yQQ81B5U1TEU+/PdwfvToJTNXE3tjepddpNYXSWIs+RILjDCVw1/SkKXDDz+WYipp
	iF1TvKnhoUaodO4XLeByn7GqoOtJEwHIeJWRWDE0y7pR83Hb7bYUlxBUxuXgRUYa8puYfaofrDbmK
	DSyyXZpWq7006z6UiTPqjRGG4sAgwDfafeWx2ArmnLrLtbVc1yJ8vxU5CNV4u5+d5Dsdaa3d2fGxE
	zovD2+yLZPjHU1OIc3CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0dz-00000005462-0vqj;
	Thu, 23 May 2024 05:05:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0du-0000000541b-1Au1
	for kexec@lists.infradead.org;
	Thu, 23 May 2024 05:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgyDYqAPwEwrwLxe8ILuedZgvx3RZsbJnZUXSZSXc28=;
	b=hFhXi41MIUQEDNGNJms88sxjnOzbWZTICFxambfljiKYVjdkpvs84F9v1RTkRaR9QRw+Iq
	02inUoiQuViScEJbLXdUJR10XKR4QzCHUUgdjxRZpOpDx70cO47bof0oTKIsU3PtULNF5h
	c431tenwUoJ6rvsSqFDD5sjp/ci4j9I=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-zA6s897PML-GUP0-pcO-gg-1; Thu, 23 May 2024 01:05:28 -0400
X-MC-Unique: zA6s897PML-GUP0-pcO-gg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-61cb5628620so672953a12.3
        for <kexec@lists.infradead.org>; Wed, 22 May 2024 22:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440726; x=1717045526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgyDYqAPwEwrwLxe8ILuedZgvx3RZsbJnZUXSZSXc28=;
        b=AyN+heS0pzCXMDDYkcdRd6aV4XXPz18vHY78rEWQ63omT+3YcV/MWnLsKqmLNK/LFz
         PvZO2aliaUKZ+FJuWj+LyLLOE1j3ZhC5kr2pZXx+ttm8BWlj5+4DEpXrlNkeZy4SmjET
         7YbdL8CffYyBelUrCDk3114SP+GfQ6DYAM4S0/6ZhHHvNoXxwogLtuRY7NFGQArMbBUi
         mBYuoxx9pqxe6o4C678tRBjnvm5/++gq2etWQycioVqFY0XTGS8XAO1zBvucCa+TZYma
         qJ1yL+BiNzp6yrUE6z2VXC1k7BPzXjzwqQgdqcwDY4hzv7ycz29d9EyHejLXB7kV5aUg
         x8Cw==
X-Gm-Message-State: AOJu0YwE2UYd0K5OIEHcu2IEnV+haufBYzvpmyXkHxUp9TQ7efXJ146b
	Sm1kplibtZQwKxFAhQ7Mrps+zpa8E6Pl2uDNS+5jmXQhzLyhscVYznSwfgkH0ibEuLO5axjwNhd
	ZApsk7kgB3vMaKovktY2+1E8Runv+SSPYZNSPz8Q9XpjnkxR67PehF/ieexxXo9aeTZ+k6ly09O
	WYtxjbk3tMi+VF9xtGvbZMd2kCuYXUWQpF77s4AmtZapQI
X-Received: by 2002:a05:6a21:2792:b0:1b1:ea57:d6ac with SMTP id adf61e73a8af0-1b1f8a749c2mr3773809637.51.1716440725602;
        Wed, 22 May 2024 22:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPjibNNUlzkGUbJC55LkT4ayzeyD3K0jDKK0WT1v3T+lpkRCBTbOfygRm48CKMedkbGJzihQ==
X-Received: by 2002:a05:6a21:2792:b0:1b1:ea57:d6ac with SMTP id adf61e73a8af0-1b1f8a749c2mr3773771637.51.1716440724853;
        Wed, 22 May 2024 22:05:24 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036272sm247051165ad.188.2024.05.22.22.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:24 -0700 (PDT)
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
Subject: [PATCH v4 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Thu, 23 May 2024 13:04:48 +0800
Message-ID: <20240523050451.788754-8-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
References: <20240523050451.788754-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_220530_558990_C59D0104 
X-CRM114-Status: GOOD (  12.00  )
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
2.45.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
