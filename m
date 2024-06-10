Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A1AC27C65
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vUGsWuY1EaM4z7y/WaBNx2OrqeIXjNQ1xnrt5hl5PSg=; b=YHMeycdsULa4He
	zBZKShXWAhx6dT4Vt6e0zHp/VhtlaI97HgUiiyaUxXClD7x7AoqwdkOFahq+bLIEpL8skN7DW9GpM
	7MkdgbXY7Z/w88dY9s3EKyVtYks1Z91IooVmGz0iux3K83ZYedafjt25mfIMrvsPAVSuMnTE6sDta
	rbwCOnIstHvh/xWLkggZH39QbazZ21fzGxDUfLgT27lLMOsfiFNxA9F8l47q6EEzsffTBb40UBT+j
	nOKGqAu9bG6wS+37FWfwEjOCuQ2k7eOYQrvK2WN9zc63zkFzOOILczYAFVUeuNX/lYIinHyz9gTPq
	EIfQntcmjKEIx3brifRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9j-00000004cNI-1drt;
	Mon, 10 Jun 2024 10:21:39 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9b-00000004cEv-3Pkk
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 10:21:34 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so3168964e87.0
        for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014889; x=1718619689; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXpLAMRWKrEJAxhlnztpKOQCT6b3mNAcjXJNnKoGzl0=;
        b=iqFLfC0i+CGKZUyRWMrQ4gEPrbOFACYGMZ1dn0tHdvTSGjJwSi2UDbgCQauxG72hdl
         CggLricb7U5i0pvu+8WmeVoFVGbK1OAbfNjNc8I3Knqnk1bC3m75+YIH4vtR/p2f5OVG
         iPnxtBWKVWTWo1blmbFeMGruVvIkz/HEq+pKbwhgUXYceJtrgrxUwVOBnAnRO1l0HPSd
         xVyUe6QBV5zNP104p9i1UX/+GLZa2DBN8Gc3A9Ak+Aa7ZcpJqtDQSAmB1sdpDeuHI5pS
         GUYy7NbtiupmnpiGKo0kZuoxxzxP9gjd4W9b6SxfyPU0Idggab1j69g5wGhjVFl+Wffj
         IxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014889; x=1718619689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXpLAMRWKrEJAxhlnztpKOQCT6b3mNAcjXJNnKoGzl0=;
        b=WYlRdvn8tWLSln3GXiy3Bj/r5pQ89eib01SICIT87ldwA7h3FyPsHpFQca9TL2ZqFi
         CPlVaFfeYQ5m6YH2ewFQlb+/ru8JUYVwNVQKJ7Wr4ASMU587grhZ+kgGvc8e0dhrjS2H
         eczQ/ZxnowrRXHos4IhrFIhAq/1nP48fpG+g+7O1lL4hspJtg/mTNeTrw3Xy60on3+cD
         j1Wa/Y66qNhokLeF6iM5RsRfXckSsa1KQ+OK7ZtbBEw/WtuIL0R4Xa3YRCLxjUUTFpa3
         ujaTpi7yE7OLLLVScMVoDWAKdGftr/ofggLLehXuBP7gIJLQHlScsjJfWRT9HbSkxGLy
         klQA==
X-Forwarded-Encrypted: i=1; AJvYcCVIGu3FC+GZ7naa6unY1mQsYq7/kuqumsg+Acp5qT4aKhbjsRe9rz//fRWr1CJwjxSTSqfg8p9p1F9ruOQS9WRtZ5HG1Hc6mzbj
X-Gm-Message-State: AOJu0YyA67PqTSqkBPnjiU/mZof4hiNo8pcZi18k8SRPhrbml3LQ3/ow
	zTGP7sgnaNyMZi1dsGLuQkhwVp4+CltRdmRyZfCGkcXo7it2Tc81
X-Google-Smtp-Source: AGHT+IHJj4AaRNhrX7A2v/Kk6aeuS0bX16/27Qun+QcsTNsjyz064wpO/4XTT3yY1voEgsZC5VV9Fw==
X-Received: by 2002:ac2:4c82:0:b0:52c:8289:e891 with SMTP id 2adb3069b0e04-52c8289e9a0mr3434713e87.6.1718014889127;
        Mon, 10 Jun 2024 03:21:29 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:28 -0700 (PDT)
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
Subject: [PATCH v6 03/10] x86/sev: Set GHCB data structure version
Date: Mon, 10 Jun 2024 12:21:06 +0200
Message-Id: <20240610102113.20969-4-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_032132_076751_C4D3C021 
X-CRM114-Status: GOOD (  12.82  )
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
index ca20cc4e5826..963d51dcf0e6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -19,6 +19,9 @@
 #define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
+/* Version of the GHCB data structure */
+#define GHCB_VERSION		1
+
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
 
 struct boot_params;
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index f5717eddf75b..f63262a9c2a5 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -264,7 +264,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
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
