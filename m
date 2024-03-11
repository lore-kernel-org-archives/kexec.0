Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EECC54E60
	for <kexec@archiver.kernel.org>; Mon, 11 Mar 2024 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NweR40MmrT8P7EzyRAElngAZW8ieJkPu0AhRjjIRnqY=; b=yIvKy3FtD4Vefr
	s8Slu63Q3qbaiclOwWlD3poBS94Yp7ETHh9TWUxy52p95nZjCS03IDi7ZGSVd6n1T7+uK/24LImzs
	1mFA516eBzxsh87VQPbEU//nXES/M+8XjgN3DFl/5W5TZ48PObZnMc9OYm0TfkT/ki6hlelQj2Qb9
	lh2Na5HL5mTVQjlfJsxclKOHGCUd5pdl1vZE7lMBK2fbi3ypI7as6pX8gEhYK5GftY4ePQBMown7z
	UNe5UoxqQ2KE8KZlAqGGq34sxPww8AhZ+jhHvdpr/hfvTBkwjUZ+nkqKxFfBt8SiUGXu/XS31iogV
	EBUS7JocNvP+ur08Ut2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLV-00000002Gkg-03wi;
	Mon, 11 Mar 2024 16:17:49 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLK-00000002GZG-2WT2
	for kexec@lists.infradead.org;
	Mon, 11 Mar 2024 16:17:42 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4132f37e170so3677825e9.2
        for <kexec@lists.infradead.org>; Mon, 11 Mar 2024 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173857; x=1710778657; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lx7gS4QP7mPyluL8Zu2ZDhyswvsRIpNUouI6tZofm4=;
        b=C0SllOZ7yqAZLNUPxAWYOoeaDdmlKUtECvAb0wY/XLEL9JsDPfRwoEIpCMMPVuwbhj
         yBb9LUUKdeg54NRrutuoWI95fIa1v4dWGWEaObGDam50GHsBoJzTCpBDi1kYtDENbFDQ
         uXrDK+0FE1Vb8QQnDKJnM8xrdBY9IWaIm3UsMqQOTQw9ELyxFvlEFjMFQGTkd2lBtK9w
         LTO0653IUHf4fNN49xnaX/+03/PKs1AA/LdJczp9bWIV6Z/L2sbG4Dyhz3a4AufcAfa8
         uaNKGtm8bcq4xE0ZzDgP4hYj0BCE2nKteNg7l01JqcU/ToB9r6ghsEMFGS3aoLF8NfVw
         K0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173857; x=1710778657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lx7gS4QP7mPyluL8Zu2ZDhyswvsRIpNUouI6tZofm4=;
        b=bzILosgz0PRhGvBqH7JvKjwS5eZ+M/H97+uMVps+Nbdpxb+4hgEGj5um6ZM1hq1gcv
         n8JLIfiko3wJfSlwd9IITi4awiSZDiWLtR+a94XjTfT6uf2cupULAI7age4IXl8hgUTY
         8mpwEsta9tNyLVkbCS39LzEJ5H6tbbtHS9iy/VM3enzBc8g7Zfu+ihi2FxPWkMOxFXVF
         5yZwkgBUtL6MMQf1ImRhDQaXmNppg8O9r+eyFiprayS3U7Den949s8ZwgukzfeeSpi8B
         /BiHwMW7dnCR/mSaxjZ7+iJ2k3zw1xSFHYjNzyutG8V50YF4UHTAGBEORP+T3VBeSV8L
         mMkg==
X-Forwarded-Encrypted: i=1; AJvYcCUpXLDGueqPMkpcA3s0+p52+ovvmebze99yH2XaDplkZIkeIvirEJ3Kj6rwV7xwRLsK38yPoGtYdwZTjGiAfaICI7gREQ334Lhy
X-Gm-Message-State: AOJu0Yz8zTz/kA6pb7y5EfgQJ6JB4f3E2SFeoBleBNpMrrK7r5/2qNDm
	+BXGGCMEKXIhF0B47tS6REFs9Cn7lx9oPVuMPwqSRiX75OBX3sDp
X-Google-Smtp-Source: AGHT+IGnYShk1v+ZpEc4xRU9N5TjXvx2xTfMB9p+pJwWcXHMA9n5F9S6x1ihlL1DyRVWu7ib73UDKg==
X-Received: by 2002:a05:600c:358c:b0:413:18e7:2388 with SMTP id p12-20020a05600c358c00b0041318e72388mr4922789wmq.27.1710173856688;
        Mon, 11 Mar 2024 09:17:36 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:36 -0700 (PDT)
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
Subject: [PATCH v4 3/9] x86/sev: Set GHCB data structure version
Date: Mon, 11 Mar 2024 17:17:21 +0100
Message-Id: <20240311161727.14916-4-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311161727.14916-1-vsntk18@gmail.com>
References: <20240311161727.14916-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_091738_666684_90D5FA33 
X-CRM114-Status: GOOD (  12.56  )
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

It turned out that the GHCB->protocol field does not declare the
version of the guest-hypervisor communication protocol, but rather the
version of the GHCB data structure. Reflect that in the define used to
set the protocol field.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/sev.h   | 3 +++
 arch/x86/kernel/sev-shared.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..c48db0bfb707 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -20,6 +20,9 @@
 #define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL

+/* Version of the GHCB data structure */
+#define GHCB_VERSION		1
+
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }

 enum es_result {
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index c02a087c7945..6adae48c501f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -257,7 +257,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = ghcb_version;
+	ghcb->protocol_version = GHCB_VERSION;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;

 	ghcb_set_sw_exit_code(ghcb, exit_code);
--
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
