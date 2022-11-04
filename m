Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4996C433FE
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6wg8SPnntNYUHSKTK3HxgeOLKOM5qo5+evF6e1qwPWk=; b=QF5ByVHxGvcPQR
	WROaxm6wVW4+wlFYEkgoLrEQt+ztdl+i1TfOk7o5xmjf5sDs45D6Y45eRTp4NcFjAU1yTjmbHGhcZ
	VoYnCRnvWtE10BU+f3v6piZnGMY72GNUpTc1z+CUQZoIGjvN54of33o2Pwl0ogToQOz+xJVH9xH8L
	gS+7LbRzLyGK0RdgfMS25MVV/hLaoiNNLCgp1Ox+057/432yqATImdl0DDW5sZFzEqS2ca8Y3WRCN
	Gdpc0QSJrfUQxyT72HaRfIzcml3OrSmek/V6CEMp2IEgLqk+9cSjLgcFbmSPYFBBbz+mtWVF+Q8Ns
	hdYB1GAistBbKmAsgUpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquvt-003M9w-6i; Fri, 04 Nov 2022 11:32:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquvr-003M8g-EG
	for kexec@lists.infradead.org; Fri, 04 Nov 2022 11:32:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667561538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RevsFdiPw/fb8SaWA4i0OScuHjqawmx3PhXyedjj5ck=;
	b=Fn8U3v8LndMXiGqPoh6Sx4wlK7OmXBr2N3075/rwEFRCxljGKOlA9vzRAQQTDlhk93YAOS
	mPd2ZexHpXmZFXc/gvW0ZZvb0zNuiIT3VXIXCP2oTOC/GroSUMcK15+IRwqGIAriQxul50
	6NqHjxcZer634DyOsdj9kwxcnhWTA5o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-_AWabyIbONyCigsj4Z1jWQ-1; Fri, 04 Nov 2022 07:30:47 -0400
X-MC-Unique: _AWabyIbONyCigsj4Z1jWQ-1
Received: by mail-pj1-f70.google.com with SMTP id ch8-20020a17090af40800b002140ba517b6so2237163pjb.4
        for <kexec@lists.infradead.org>; Fri, 04 Nov 2022 04:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RevsFdiPw/fb8SaWA4i0OScuHjqawmx3PhXyedjj5ck=;
        b=6eGXsYonale0qeEjJAOfs5k6sAD9XQ4ANXLob5/rm2GsVhGloBjw47z4SPNYiGt+Ef
         yuHot3nAOqCF6jQfJ/Vj4kJ+5N1YMWuT2/9ZHRvGpaccmd8chWUtSxLAdp/BD47RlnY0
         6ks9YwL0KMcparX3Jh/ODBbcaGG+3QDBEb3r2EhmCiJVb9GRkv7cx3xn5AlTXZV53EZN
         RKbYErbtRfVwzSM4iu0BIzNcsNbmrmgaFyDHNj9IuyZCFfNAFO5BB6yik13fIVwOtr3V
         fzlJ3mVQd07YURCnAQslZQ52uhGp6p8416ypKcvjraCmoxJDVyrJndHZuMinMnsGSJPc
         Tlrw==
X-Gm-Message-State: ACrzQf3d9u4CL3dQVAOTDTTCqcA8iRG8qWWtcPbRjZI2e4E3gbQxG9rE
	XA6VZF+8O4ntKp6HE62HM3sUHR2S7Q1nK0JQ++mJVuCgJONAd+H0aa5EpY+iH1CUuZO6pNFH8JU
	G68a1HLwKRQaWBEXTsoVrqj9zcoEriYdK/B0G+XCY6HceG07am8mygZC0/KN/FtL06bc=
X-Received: by 2002:a17:90a:6d22:b0:213:7e1e:9be0 with SMTP id z31-20020a17090a6d2200b002137e1e9be0mr35804917pjj.17.1667561445902;
        Fri, 04 Nov 2022 04:30:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51CDYLEqWginckV/rN0elEiAXD4s8pR8U6DdMP+NZPO37JWjN6xDUyvoO9upVjiEVTkeoywQ==
X-Received: by 2002:a17:90a:6d22:b0:213:7e1e:9be0 with SMTP id z31-20020a17090a6d2200b002137e1e9be0mr35804871pjj.17.1667561445499;
        Fri, 04 Nov 2022 04:30:45 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00008500b005629b6a8b53sm2609597pfj.15.2022.11.04.04.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:45 -0700 (PDT)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC v2 4/5] x86/crash: make the page that stores the LUKS volume key inaccessible
Date: Fri,  4 Nov 2022 19:29:59 +0800
Message-Id: <20221104113000.487098-5-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104113000.487098-1-coxu@redhat.com>
References: <20221104113000.487098-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_043219_561891_22D3B456 
X-CRM114-Status: GOOD (  10.85  )
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
 arch/x86/kernel/machine_kexec_64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 0611fd83858e..f3d51c38a1c9 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -557,9 +557,25 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+static void kexec_mark_luks_volume_key_inaccessible(void)
+{
+	unsigned long start, end;
+	struct page *page;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->luks_volume_key_addr) {
+		start = kexec_crash_image->luks_volume_key_addr;
+		end = start + kexec_crash_image->luks_volume_key_sz - 1;
+		page = pfn_to_page(start >> PAGE_SHIFT);
+		nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
+		set_memory_np((unsigned long)page_address(page), nr_pages);
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
2.37.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
