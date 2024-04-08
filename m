Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5986ACD129C
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 07:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1FO9Jp9MGb7mMkkHCVcj14X8zTkUefTX32MM6BK1JUs=; b=2RkLDHK7feozqQ
	S9VFUkfGKmal49GKNZuiDSfoBb2Hmle/zmtgIJWvLYJVO1pA128I/xpuXyGSybTd0OOSy+5COaGik
	3WDeXPOQ2cobx3rZlZaLRo/T3ARMiUl/6rR64Ub4t3a90TauGxqdxjVAkvgVXCF23gvdQAsd1cBNp
	mq13cUrCD64JSEY4F97LPeyLIf2PWbX2DiJPiWyaNpMQMWeJ2A6XYfDqfQ9OgtwTa3VJahM0jwIJn
	fBJRFt+O51xIZJe+tjd9E2cMV3cRdKlGqZUbjiNcxemZnLF9Acb1tD0ZA/ILRVU2mqeC8k5I1OaqZ
	Esy7kmGGFhcEatpnkJGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjcz-0000000EhZ2-1U85;
	Mon, 08 Apr 2024 07:41:18 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjco-0000000EhST-0tql
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 07:41:10 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-41551500a7eso33906305e9.2
        for <kexec@lists.infradead.org>; Mon, 08 Apr 2024 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562063; x=1713166863; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UC5Sjs0y+1l0bqhsbHpWK9vOawmeA7/6gd6QlKv6W8=;
        b=NMhswZyb7YcIoa1/0T12G+1EA7YjyhpH6Mus+CG7Ol9J1375yKeHfv+lvlrSdyB3nN
         Z4Y5J0X51fcRpapifKRQAvdmoaROB4yEmpzaxwlmveBFfUK95HpMPSMxa3Us0Q8UtYqo
         MrA6g7QSzbDHbzfMrB/BBc/azyHDzfNolsy82YkvbHSrslzuhmcHBAz2/ig/jxWVtmIX
         0zFjfwJxNeTPU2HEDNRTqHmNTjEtznd8oI2sLv5pE7YSkumAXN108u/0Qpbbqv+oYXuu
         /F5V+1SNMr8n7U4fLw0xuCNFHsKFlLEDFRN2+/UlJHdtjgbM4/r+E1dVP7jCNOFLm5t2
         OmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562063; x=1713166863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UC5Sjs0y+1l0bqhsbHpWK9vOawmeA7/6gd6QlKv6W8=;
        b=X0E9lbo30oKLnpoJxFAc3z+0H/GssOPrOviBRd2ZIOVQrelbLRCJ3kYgMYKuKs2Z4K
         jx+n4eJP0xX0Qera/95F385ekHH76oXovmdLRlmYmfUww8P+85krn8fLor8+xV2tWDJw
         kSVLVfTF8t561wVipvLrGCMMgruPUuOuV0txOtGNZdQ7TwptXwV70nzL7X3CXJmWJxYo
         Q0wXUBF5XTE+oIoEayvihLrVwyi/VdcICuyHtOItNC5uKz8ZTBejNwbBFzPoabethwbV
         XvGHK2sRWlCzHw0l/VRQ0tNjyov8QnlnfqOQ63tKYhWCIO5LbIKsJvTMffpOtLwoftyy
         DRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuOW1Bhn+BKHIC273y28tZJksrtvXBnTu6AAEoSDNT1hGnRjCzSwjor70pfNYp6q8vqWiE/LKUUE5w3A/oExh+Fr11V/u0RSwV
X-Gm-Message-State: AOJu0Yx8rPkraBL21NT+01687uxZVJLfuNrR8pj+ZmUOr6vEI4vYuw7B
	PVO5tg2mwoLh6I7/0Hg0CD04KSkqiKlA6u30vPIBIBEG9yT0bqDl
X-Google-Smtp-Source: AGHT+IEA4rqVnV0zCmstOW3Lm+tswAKk7lUuBX8iEtTS9cgrpMZ4GU/tM2sKL8kd/pn/zpEd0eSv3A==
X-Received: by 2002:a05:600c:470b:b0:416:6a7a:8528 with SMTP id v11-20020a05600c470b00b004166a7a8528mr1630488wmo.39.1712562063310;
        Mon, 08 Apr 2024 00:41:03 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:02 -0700 (PDT)
From: vsntk18@gmail.com
To: x86@kernel.org
Cc: cfir@google.com,
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
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com
Subject: [PATCH v5 01/10] x86/kexec/64: Disable kexec when SEV-ES is active
Date: Mon,  8 Apr 2024 09:40:40 +0200
Message-Id: <20240408074049.7049-2-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004106_466280_2E1F8C2D 
X-CRM114-Status: GOOD (  10.48  )
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
index b180d8e497c3..4696e149d70d 100644
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
