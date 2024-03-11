Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3033AC5475B
	for <kexec@archiver.kernel.org>; Mon, 11 Mar 2024 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JT3XczsoT5XXRRRWLrtSAR0fs4Zl2hKIZ0+9NsqRRjs=; b=WQdx5NVg4zopnj
	yyq2bH4zyGkcuG+cgftrXKih6cZXCZtjdwJSuQSoyMWmqJfeT59no2r5DdUbKnAdWgi1F6wOWzM2x
	vdn1SjF8bPvJ9Qk2qhjHdGAZ7yBdGY+SWYfZ9xi7lT8f2qQOD+kFIkj1u5i9XfopqIOt+IukCQ/9Y
	AoRSxHJcEmC4sEbViAslpbDSaUFGg/uoWdTfjDubU+RhmbFkLkCut+eMlcv5cnwwPwrC1cbMhCP8A
	CqIj5wfADucQS6/Freyx0P16qUdycN6e+E/U0lC8GF3fKfK1CzhqVFoP2NBn7PRsi1wqNjYMUgf8l
	mUm2vJNW2pokpln163qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLT-00000002Gic-1JON;
	Mon, 11 Mar 2024 16:17:47 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLJ-00000002GYa-2FDG
	for kexec@lists.infradead.org;
	Mon, 11 Mar 2024 16:17:40 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33e162b1b71so4320940f8f.1
        for <kexec@lists.infradead.org>; Mon, 11 Mar 2024 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173854; x=1710778654; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwrPOtCFWcQDMfUXPx+XS96HNczA3gaW/2MdY2qxab4=;
        b=ZG8G17MFHGPByxND3Am4RkKFAxDFY037K2oOtB17ctN8Nv5EEfoHhkYuNq80JzF5Yo
         VIrrz6wvFzhXdqsrefQJwIRXgzIp4DDYJsuf7imayIFMjTHvu/LBaHQztlSJUEt2mY+b
         DMxk0cIZEWgSzzDEE/KWcEMDdT2fsc4Fi/DNtvvOOGJy/7hR/WqRZb1a9DYnidSOMX8v
         WMT+Ca4hTGJAH5W4aK8TRBbQDUY1+QLizaq9Lu+zO7rNW4EspX+9E0P9A+zowxAEOafY
         iLq0A/T+fz9WhcRlImTaXL9CGdm40cNAHDP8ETlVtoRwKafdCNcO6odWQyLK+DEnSoG3
         rZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173854; x=1710778654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwrPOtCFWcQDMfUXPx+XS96HNczA3gaW/2MdY2qxab4=;
        b=mj3Pu5X3Su9qnGRS+ObP4JFKH3Aqc9LwcL3jvxlOvPtJWaTR/8ZfDWQ2WSEgXTwlpK
         hw8FwN79Y1ycggh7pdEBXLx0AwLQWJ8+mrxzi9uWs3IU884zgpT3GPoQmFREV6iXFVr9
         69Di1bZSV3JZiEEnA+Oy4MZOID33qSaYy56pgg/MK9J3VkrCKFUpJTLglZzWSXrKIfcb
         jySi+pRXfncdKR2QSzLjNFjwxU59HxOcA/IHsTikflxpjLm3pBq3ObgsyPd+U8o0ePBZ
         Pnasye+3e6kCbN3aGFu7X08PFjfjAEo7z3+3CW3smk+txXFGv6K17Uhbzf5sZ0lzZtIa
         Q1jw==
X-Forwarded-Encrypted: i=1; AJvYcCVBTQnS/14QZ99nh9lVt6oPGUQtvZ4VH3QzjUx/I2wwvQwJQpdGHEoYGWNepts/XmrFFBA7eIrclyuBaIS4b5Uk4ZeshMaOqe/E
X-Gm-Message-State: AOJu0YwS0UfNFwuuE3hjPSLAn8D1BrRvvPYs4xKNMV0ZuK73vuupuG06
	5kHv7YGkSeaeiA9EY3iSlu9A9bTX6p3dU1EgmFG9wbgt4DS9Mhfc
X-Google-Smtp-Source: AGHT+IH2ferHpfaCLktwprSAlut0kfkjOaWyxqFOcoy+lU0gHOdVqoYzZnhz4uQfv99VU6U5lBGYiQ==
X-Received: by 2002:a5d:45ce:0:b0:33d:3abb:6db4 with SMTP id b14-20020a5d45ce000000b0033d3abb6db4mr4095738wrs.69.1710173853730;
        Mon, 11 Mar 2024 09:17:33 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:33 -0700 (PDT)
From: Vasant Karasulli <vsntk18@gmail.com>
To: x86@kernel.org
Cc: joro@8bytes.org,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	Joerg Roedel <jroedel@suse.de>,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v4 1/9] x86/kexec/64: Disable kexec when SEV-ES is active
Date: Mon, 11 Mar 2024 17:17:19 +0100
Message-Id: <20240311161727.14916-2-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311161727.14916-1-vsntk18@gmail.com>
References: <20240311161727.14916-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_091737_797238_79E3493D 
X-CRM114-Status: GOOD (  10.09  )
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

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/machine_kexec_64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index bc0a5348b4a6..3671ea1a5045 100644
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
