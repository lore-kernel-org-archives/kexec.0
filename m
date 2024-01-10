Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724D2C47073
	for <kexec@archiver.kernel.org>; Wed, 10 Jan 2024 07:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=afm/9QWkZCoKoNA/7S8uEvzhfVHh6CB6siDJ4jOmyPk=; b=Gpd5ya8qYdC7LM
	OTUi2J63JKl5NbzQhRzVXggxfQj0NZs/s+tbopGT5hMv2a/XT7dv72N1V2XHZ+6079WptiypgTuOn
	UCrDL/ESS2mjSIwLVylg5mj7BWJ3f6o/q4Q77mSAzTtGcTF6CFmNlpthIno2jBXKrju+21oBkJd5e
	BktS9bLquGjIPgC582s+NcB29uixw0xr3PlP6mjCSTrHTBKuna4g37MHtemRx1UdbMA4J1l3h3nyl
	tej9KFO6n8eBIXGFTnokVb3EfJGxI5Pf7wdh7a48Gn9GYKJ8jf5MrGBklb8fyZ+PlZzBZbE/dIVBL
	f2f36X7g7rLwilTAr/GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSpz-00AaN8-2y;
	Wed, 10 Jan 2024 07:17:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSpw-00AaLQ-1c
	for kexec@lists.infradead.org;
	Wed, 10 Jan 2024 07:17:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704871035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PudTy4UMKikLIiXUIiw3l2EC2dKIPcn2JPVx++F8WCw=;
	b=EZ6LAchqkdxQH9c99M94gclgEBMohpiAOHwhp79NZhHHlawKOVHvZVy1Ii6iDpGW0pbm+O
	CCf7ntLD0UEnxveDMtDW27tK96vIAZhzAq0yrtwddis0o/OANk/cAjQPsjCw2A6mVkm+a/
	Jnw70SmlhLHrwKI1LibsmV85FneJBPg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-XBzp6AYsNBCvI5efuiof_g-1; Wed, 10 Jan 2024 02:15:48 -0500
X-MC-Unique: XBzp6AYsNBCvI5efuiof_g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d486bce39bso15284735ad.1
        for <kexec@lists.infradead.org>; Tue, 09 Jan 2024 23:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870946; x=1705475746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PudTy4UMKikLIiXUIiw3l2EC2dKIPcn2JPVx++F8WCw=;
        b=AAFyykvqT6GKCL5isezVrwwoVbpEG3kKFXBxJSPqiu6AKs4IrdtGaJjLcJA2gQSfXN
         xSJGnn9y52ptoqVKJTodN5iZMaK1IPZg1n3eYzeyCE9/Te7H4p15vN094wmzUwIzGAaS
         YpZ9Yl/er1RCsMS59NNx9l6UBKQSkmghEUKWe351tX7NxSGRZf9c+YcIjHWJpoRDoFkE
         J2Q5fPzmt2Ia3CfgmLMUA8402N7e5xiJIkk87yEzPtW6v/bnjQdc+tZXJIBsXHSUnoZx
         IW4ehdHeOGJ8dM9ryKpFBUEOyQE891yDw/ug4a9zNBQ9daEUXKQD0evqMN2bhoHpspOY
         GUNQ==
X-Gm-Message-State: AOJu0Yw2xVShcYwzVTJos2U9On4fdMs02NNeqQzAXf5n5wKfzVmCSfKV
	9xL73Qmn8xSUk8NBz+lY81C8hTDW2a+HdepO/khrUxTJkJnsMyvJl/Pg8KpIngt7lf9SJei+JWi
	CYuhLMBpM871Qb6XtsG150rObpcvI68mx+Pa4obUTycwjx3585hNDqcsn5gPdifK2JApWOxiMfS
	zsxSXcswgX+HAxufg=
X-Received: by 2002:a17:903:230a:b0:1d5:6b59:bc9e with SMTP id d10-20020a170903230a00b001d56b59bc9emr548226plh.113.1704870946159;
        Tue, 09 Jan 2024 23:15:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGswbCFzBG9UMiPV/9Dz8iVcTS6B/kBunqAERbzsPjXLLiiVVLr67UttS61AMPcGr+g+Ep+Yg==
X-Received: by 2002:a17:903:230a:b0:1d5:6b59:bc9e with SMTP id d10-20020a170903230a00b001d56b59bc9emr548193plh.113.1704870945323;
        Tue, 09 Jan 2024 23:15:45 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db8500b001d4c955cc00sm2906719pld.271.2024.01.09.23.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:45 -0800 (PST)
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
Subject: [PATCH v2 5/5] x86/crash: make the page that stores the dm crypt key inaccessible
Date: Wed, 10 Jan 2024 15:15:20 +0800
Message-ID: <20240110071522.1308935-6-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110071522.1308935-1-coxu@redhat.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_231716_638198_990097B2 
X-CRM114-Status: GOOD (  12.37  )
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
 arch/x86/kernel/machine_kexec_64.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..c9c814b934b8 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -546,14 +546,32 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+static void kexec_mark_dm_crypt_key(bool protect)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->dm_crypt_key_addr) {
+		start_paddr = kexec_crash_image->dm_crypt_key_addr;
+		end_paddr = start_paddr + kexec_crash_image->dm_crypt_key_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		if (protect)
+			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+		else
+			set_memory_rw((unsigned long)phys_to_virt(start_paddr), nr_pages);
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_dm_crypt_key(true);
 }
 
 void arch_kexec_unprotect_crashkres(void)
 {
 	kexec_mark_crashkres(false);
+	kexec_mark_dm_crypt_key(false);
 }
 
 /*
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
