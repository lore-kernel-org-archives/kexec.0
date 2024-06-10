Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8ECC27C55
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xpQw0mSGY8WYrQIavkFocxjVWazbhHUey54lsK2BdAg=; b=MeDPg1JmnetSgV
	WXEBgRTmEfubxntjcBrUn3O9K5i+t8MF3Z17Ctpcsl065o4NZKIJ4bitJE0bx+CPN8M00uSV6RxdI
	BzQUcBytTCLKPMllPIkayygJIxMe9SOfN+aXkdw2khGSu9SLrA/ZT0dZItXW2DepK5CYCeJP1BaHh
	stbZM//Yc8gsDUgTTOcGCWH5ola03/Lhv6oOELuazu/0mzTBQYlkoDB2SP5wRkOWTpKOrEmTeM6V4
	oXBHOi4fJkK5Xh32dQTMhXaeqA7ejdJZWOz0mWE8AhSJt08+z0mIGm6Ts/1iIQ4Z4ZPk7dX0StK6k
	9NgnrZatPSHOQYIq8Qyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9e-00000004cIo-3AGO;
	Mon, 10 Jun 2024 10:21:34 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9b-00000004cEY-0051
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 10:21:33 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso144962466b.2
        for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014885; x=1718619685; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEfSemHRxgSOfPiZYMvW6KyDv2YGLxFXvDUpF+fStco=;
        b=Dph2ocOR+u9R6uhwm3EDBdHPfAuI2DGooJKFH6D+0xlAPQG2d+ZH/NjB7tC+2xZzVv
         RWoRuHqf8YK9RYLLR0R0rxS0DAlh6StKV5jXgXH10wVtXIvkqapzYeQUYlXNNOWdtvXA
         1J5Am69/L7ccn8EVUya2tTjhqfucSJ5/oBy3O27c2SjXTx1mAYSkestgRAYVl69al2/Z
         nXOgOzP2F5Z+C4OsnowFbiRvTBnsUo5ZqJ5Z0SB6PCoNyHPmdv6MZ9p8uF+2QPxYGzms
         +GHpQP7hzncbcm0WpTTb62DhQ1EN8vm/TFxyk6ekJ7jANabagEa+3eFuPg/8AZmTJ0Ud
         2Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014885; x=1718619685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEfSemHRxgSOfPiZYMvW6KyDv2YGLxFXvDUpF+fStco=;
        b=hfehgEsybMt9d9mQgEJp56DlvRdFTNNPb0dbadbwoPIcE2reuTaCMrjmcevTQ/fLWB
         Ug63BGFCZYLPZQO3PbG+gIZi+3AG6tb0NMfcb5dEctWFq8OvZ7c/nAdMAhFBn8MW6IEA
         s1lHBUigHXZb99nz4bcQSZVMKmbnRCT2973izgfV6COLOLbpm1ZOnTZ63mckdyaokr0y
         FfQzIoMMsfCNCjsBzjsiVmCjD7qu86Y+mZ8ctX+v9/koZCZHm2WpyTaiPWYThM7RghMX
         MLBZyxlqLWiM97Vl6zq5J7lz+m/YR8tu39E8Q1aQGlxHCtrG/5np4c53cgHYmUXBwyc0
         +04Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrPI4NbyI5nv9wIaMmw+6JRjdc/w6ZPHzBjkUU9SToY3tMNHh4Mcm6+1pKLX7p3d1adWKhKPappqtrrfIaSEJPHMVE9jZoiJbF
X-Gm-Message-State: AOJu0YzvKvmqYdRnhadFADJ9GXF9xFGMTljJJc/XOxszPqf7F6TnV6+j
	SX5pYz+BMdp2wnGV0L6xNQ45xRS0sJuvNKQXuMN2BYcZZJK8EZ2e
X-Google-Smtp-Source: AGHT+IG1u2X9S9HjwLyvUzoKmM04a54bnBw7Lz54/NkJdSpdqT0nvOtendvNpOdVPb71wHGOXHjzEw==
X-Received: by 2002:a17:906:3289:b0:a69:1a11:d396 with SMTP id a640c23a62f3a-a6cdc0e252amr568492666b.71.1718014885293;
        Mon, 10 Jun 2024 03:21:25 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:24 -0700 (PDT)
From: vsntk18@gmail.com
To: vsntk18@gmail.com
Cc: x86@kernel.org,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com,
	ashish.kalra@amd.com,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jroedel@suse.de,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	michael.roth@amd.com,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de
Subject: [PATCH v6 01/10] x86/kexec/64: Disable kexec when SEV-ES is active
Date: Mon, 10 Jun 2024 12:21:04 +0200
Message-Id: <20240610102113.20969-2-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_032131_078338_CD6F94EA 
X-CRM114-Status: GOOD (  10.34  )
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

From: Joerg Roedel <jroedel@suse.de>

SEV-ES needs special handling to support kexec. Disable it when SEV-ES
is active until support is implemented.

Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/machine_kexec_64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cc0f7f70b17b..1dfb47df5c01 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -267,11 +267,22 @@ static void load_segments(void)
 		);
 }
 
+static bool machine_kexec_supported(void)
+{
+	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return false;
+
+	return true;
+}
+
 int machine_kexec_prepare(struct kimage *image)
 {
 	unsigned long start_pgtable;
 	int result;
 
+	if (!machine_kexec_supported())
+		return -ENOSYS;
+
 	/* Calculate the offsets */
 	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
