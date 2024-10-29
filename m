Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF5DD5B874
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 05:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hmCTjLt7eQMGY0wcmMy6l2BLQ2AJxdyKmutwNaY5HYE=; b=Re7c7ZGzO7dOon
	EgK4/iD+N5hM1Jfq1otKNwZbLRgI6FJtI0lv1GdR1JPC++qTQXis1omateN79zOYz4ulNkjZdfHK4
	qPO5NqXfG04ZXzGap8+a7aTcohg9GVPsXlJi4mO5CIdcmXGkxLIrVQ+eKmMu5qL8EVnAFhNjGCFLy
	1VicNGE5jBavXNEXN8UXa5JOtEaeiw6hD9R4Z4/ISTwUtt814/hH8J0VbUeRNBAYfiIu3fE98iXrx
	QIOx3Kvzc2LRTAiYiLp6JVyxw/PgGoQCAmhaHoFhSEMspPenREyG4uTZOIfNrpbCiwspAF19N9xIc
	DFQ612e5QuYO1HuFpiYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fAR-0000000DIYG-0FGK;
	Tue, 29 Oct 2024 05:53:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fAN-0000000DIUX-2ScM
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 05:53:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo5L+VgmTjh6XwtSjWx3uno6HruWIf6FNemxob1bKlI=;
	b=GiMUrcmO2vjh9jnXeSpzfA0R8hJPmTXLANS/Bk75uRiENzYeU7ebqzFN6EOvT7rseSHUTd
	qUXQBUVBQvBJuEQTCGH78s1+JbJ809x7vL2FGJ+xrLqAitj/svkN5ExdZPw7ZI9ML4gA9h
	RBRFeGpJY/ilBtJGW+qTPIOyN91S798=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Wdmt2RKkNW2eqf71ueUHHg-1; Tue, 29 Oct 2024 01:53:12 -0400
X-MC-Unique: Wdmt2RKkNW2eqf71ueUHHg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-288485b2358so5439048fac.3
        for <kexec@lists.infradead.org>; Mon, 28 Oct 2024 22:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181191; x=1730785991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uo5L+VgmTjh6XwtSjWx3uno6HruWIf6FNemxob1bKlI=;
        b=mHs0JrMpup+6t/S7CjHTT4P6MHw0aGUa4pIZS4vszaGsE6Seui08cW6MrnBRi8fAs2
         PrHPkK9mokl2j5P867EhehIV9neUFpnf9U60xrZ3m/u7W+zC358bTpCP+DBh32diL7e0
         Occk4lAhO8u+UwU/1ZA17EqZ/Wq+iKl0SPvOBIfyAMLxpSr081BrEzY+XmnqzqcxPTA4
         kdGPORqmSgpajsVEdBYC3rWf0mn44Aio85iQGSyu5+roVYs87TJNzzxrou2jR6YyJjLv
         vMza634oG3ZvRFoodPu0fgu4bGpLa1zFGU/5k5hDWXh2cxOwJxSLpMbwbwv2PtvED4CS
         vQLg==
X-Gm-Message-State: AOJu0YyFnvRz+0/Nbtzt7fy9qqR5+bLMi/sXjpV9603WwkR5iGAeHKv6
	76oK5Qg+/NxCwfh7y2zX1RRfOFIkus8LC4U1mAs7A6VGX+sCnbIgXjQWEpFGwh6mekASpfNL2bQ
	6bXzZNrFAcDAp3eOFuGIBW39C+o1pl5fBqC2haunDz8Ay8OyUXAQKSyS2dGEX2iX1zTEM5/pA7Y
	pP6hQHlixhoV9xNjiXa+aE6UhWDJJxVr6djuoySEyO0LFI
X-Received: by 2002:a05:6870:6590:b0:278:1863:f4b6 with SMTP id 586e51a60fabf-29051b5edb6mr9553439fac.15.1730181190882;
        Mon, 28 Oct 2024 22:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOrme0N7lDABZ6zeXKC9s2HBoZLQciyQpqHGHhIZzIWySUR20Lx1U8S8dKA1C/4iFsv3PKjQ==
X-Received: by 2002:a05:6870:6590:b0:278:1863:f4b6 with SMTP id 586e51a60fabf-29051b5edb6mr9553412fac.15.1730181190562;
        Mon, 28 Oct 2024 22:53:10 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm6757783b3a.33.2024.10.28.22.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:53:09 -0700 (PDT)
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
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Tue, 29 Oct 2024 13:52:20 +0800
Message-ID: <20241029055223.210039-8-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_225319_701559_C7EB0EA8 
X-CRM114-Status: GOOD (  12.64  )
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
2.47.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
