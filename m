Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DB6C67861
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HuMFOmAg7YjCYZaEKHQEpsSBLJ6agHfUYGG0rMDB7X0=; b=uUcLLM/byZmWB+
	zgRI2IppPiY+Rqn4WTEJainKYK6nFlcv55fKeTRaXBhcLjsNT3QChhp3V1/Kx3YRsRAYJxtSOQFJa
	2hw6dcailr8Zuqn3FL1Oe+WGaUZZ2ykx7U0F+m0U0M8p1xOZhSmzyE8LGK+09B+CW0l2wsol6XqJj
	gzamCz4pMAY7G0eQWFv71IVz4F/Wjp+VSovLUUcU4xI6uLodFOzk++CaqlJzIpvBt5J6i/O3CCN0T
	w5Gc8hvsW5E0QwBkM0ZGI2NmOH+TpPVeMo1j64qSUfsw+n5BzBaR4UwspUBhIZQXVGbxLeag6SR+v
	1tFPN/dQuISb9gn0bS5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjdA-0000000Ehhc-2fvG;
	Mon, 08 Apr 2024 07:41:28 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjcs-0000000EhUC-0tat
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 07:41:13 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso2725555f8f.2
        for <kexec@lists.infradead.org>; Mon, 08 Apr 2024 00:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562067; x=1713166867; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lm8IoXJe0WYSRwtdxW3X+Cv5dkEchtxnhEW0S0YWJc=;
        b=bgHmTpjrxgcRAx3z3wjKXEl7LNmv7GG8ecHvgMAUufneCfBq1DrRpKp3s34qMApLVu
         hh4mesYXUUQe5Dl9aU0s2YnfZxzeOQzRQPkMZg1//plmKl+R0LQoUeH/R5MQvqUnlW9c
         lAKWtPW52a4mQ2Jsprjh2lx+BnGuar150DsB1B7c1+LKgrjIO2YDVFZzT6AhZriSJTzW
         HgjOoSNH27OFFAhOq9SqQq4PYSFcmVMsTeWbeC8+O92E0zZcxYlTEC/FMfv9ymHmzB0D
         hdCE0MUNAlFFgFLw42q/8O+CrckFzR8m8CmBtTmnFxWegl4xKxeDq7auLWegrnVuqXk2
         43Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562067; x=1713166867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lm8IoXJe0WYSRwtdxW3X+Cv5dkEchtxnhEW0S0YWJc=;
        b=OHPFtiSfhFJm8da/kyv8uS8h2FYf6DckpN/3iKM3WBy8KU1SmeXdMoC0a2u77/6tyR
         +NPtqtj+mS9PXrdHO46Hkv3sVK03Fae7ZcFOMcK+ZcCccp4rL2dQ95RCRgBkskwVd/4d
         nzRxs2E4jJ+rHYG0tJxg02CTB+HLGgh6PZqMV6V17BkdiqjS7sm5lsHWqXHYbyiAvYJs
         avdGxjPlHPLyeLl7CauapsE6rf7Foxyuesb0niRwr6K4JtPrBAbsr8L6IQ7BTh7HeijB
         Aijm1Ag8CP2+Xf/AtvaMplococ12zIGWEbtwrVwiz3Uz8bwkaM8UIB20XviBRhClYNiz
         cEyA==
X-Forwarded-Encrypted: i=1; AJvYcCU71QsD5NNOATgvjgRACJgF7Vs9n+Rwl2wh5DtOl7VNyJ+vSmzv5v6/Gu5V6kZDgFKdDpfrH8Aa1J/fU+VLC2OOs7ToSkTcBC/U
X-Gm-Message-State: AOJu0YwLu6uqMw7OZ2X+N77CjsFbGXQYqfrtZ41ZF2qfu0CN2lBPQIz4
	DKVQnmQKq833bRXe6ubrfd3FtS8+WB14d0oxKguz1nDSQugZSkbq
X-Google-Smtp-Source: AGHT+IHsw0MqJncrkEsTav8GeBQKVLnnHHhYYl9/Fi+5JZD1076agLCl079JWImEZPXFh0LSDyynKw==
X-Received: by 2002:adf:e44c:0:b0:343:d06e:51cc with SMTP id t12-20020adfe44c000000b00343d06e51ccmr5136276wrm.66.1712562067341;
        Mon, 08 Apr 2024 00:41:07 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:06 -0700 (PDT)
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
Subject: [PATCH v5 03/10] x86/sev: Set GHCB data structure version
Date: Mon,  8 Apr 2024 09:40:42 +0200
Message-Id: <20240408074049.7049-4-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004110_375716_C41CA8EE 
X-CRM114-Status: GOOD (  12.94  )
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
index 07e125f32528..829650bdd455 100644
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
index ba51005ddde2..fb62e1582703 100644
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
