Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C47ACD1296
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 07:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fqRogRoYlLAmubeAHN7rWkak1k+j2aRi5MTGWS1ieFA=; b=wjSoNVBqqC1wlO
	e2Vz0fapfgQTBWwk6ybAFxlJj19KV66s++r/APKasPQgmEH6IPZhN03sVw8LFnN4LXmhaqnVuvmRO
	xiJwTIz29IwZ3t6KrrUAJNszSF4cb+6+aKwEjCvztCvh39UpffYC78Qq2UORRT/9/YxpYR3c6JuHb
	5GnDqUouB7dwf476j/L8jNbi8IctnW69Y2dzHXr1fy6EuBRvgrpiMd0Ak1Xo2CbB2oPRbvXcbyI35
	Vn4fIc8O/anRSxB1Jf42R/3g1OOaHcs0gJ2h13+curIVtOrPRbq2nFhK0qYpCkHUIPk1Cg3IQ9Pwg
	JLWsQh8B9nx8216Uz3DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjdl-0000000Ei2q-20A4;
	Mon, 08 Apr 2024 07:42:05 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjd6-0000000EheO-4AHK
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 07:41:29 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343eb6cc46bso1779574f8f.2
        for <kexec@lists.infradead.org>; Mon, 08 Apr 2024 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562082; x=1713166882; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vffWxrDfGUfj6Dj40L1W41htTqoat8lNT1P/loOuIyQ=;
        b=dJXZ8inQ9pe7MJrh53N7nil6wcsJagptlOyy61jcuT38eyL8w6cNRnD7xnMv646g/y
         kyTpzOm5ffGtpRvrmbDEX969UtlfGFyMgeoBY0yhOXieLugWqGev4VtYAtl3PX3Fjlst
         fJ7cqM0UAYtEKcsPJa9PNeJ4dAU3yk3rN2H2xy8SBg4ZAzdXsze2b4v6bW80yWbIu429
         2x8psiaogjMp9QpuNZpdD/7Bzg+HGMPS09X2r86AURVXGkI1QVYMRZ4drKOgv7vmhdYy
         sqsUokZNKuFOJOwXzwX185PMIPBKK9hNqHXFcGPlR+/SHkr7WO81f05NxgDJxULtxnDZ
         fxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562082; x=1713166882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vffWxrDfGUfj6Dj40L1W41htTqoat8lNT1P/loOuIyQ=;
        b=cB7LL4y8e2/ZQB3iadlFURQBikvCt/OAo/WijpidnZR3ocpfic9l6EldxFZsnr5XLA
         xHBtxeAfBeZXJbuwW+MuqThWaapaKl6DYWAfdjwy1fI1LLG81LhXYvXejZk0mD3pdy1Y
         UGA/SFlmLymfRyBahfm7+wET1TBDZjkrU/T3OVzGyjmhtWV6IpMntrCfXkTdddSH9mTx
         T+phSVsncZGZ6Kn5MfHAR4PxvifK7hDOEutH/sdXacGRjqJGIZVI4HIj8R5czAH19Tf5
         6gAvKwNx58321EtxI6OWoA3GxIg/fZT/wWY97K2FO+X07g7xmlYy2Fe1z+6T9d70/3HG
         eM0g==
X-Forwarded-Encrypted: i=1; AJvYcCVF8rBsb/zXnlLvYnaUQTqQsPV26lMlMSk/MstFvsliE/wsRNCkufaE9tYOtseLOinsEf493LinxuS9JuWJlohdAfVKTIlEvkiA
X-Gm-Message-State: AOJu0YwGzl/v+rT/SpIvkwHNkKh8uLApZyj1I+IrwT35pBbe9ujUonzp
	mkrV7fIl/f9wurugiUBW60d9zL0UgsxZ97igsismN6LBHGk2t2bX
X-Google-Smtp-Source: AGHT+IFJ4+QJwRhaWOkJ+xi/SDRYHJSS+dNKUjJlrOrr+g4LrjWQZtOQ6FOdPmbvQsUHzg88XvrMoA==
X-Received: by 2002:a5d:64a2:0:b0:345:b238:534d with SMTP id m2-20020a5d64a2000000b00345b238534dmr1768262wrp.28.1712562081667;
        Mon, 08 Apr 2024 00:41:21 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:20 -0700 (PDT)
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
Subject: [PATCH v5 10/10] x86/sev: Exclude AP jump table related code for SEV-SNP guests
Date: Mon,  8 Apr 2024 09:40:49 +0200
Message-Id: <20240408074049.7049-11-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004126_153575_0864B07F 
X-CRM114-Status: GOOD (  14.21  )
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

From: Vasant Karasulli <vkarasulli@suse.de>

Unlike SEV-ES, AP jump table technique is not used in SEV-SNP
when transitioning from one layer of code to another
(e.g. when going from UEFI to the OS).

Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/sev.c    | 6 +++++-
 arch/x86/realmode/init.c | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index aa53e8eb4cd5..d915d9158926 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1392,7 +1392,8 @@ STACK_FRAME_NON_STANDARD(sev_jumptable_ap_park);
 void sev_es_stop_this_cpu(void)
 {
 	if (!(cc_vendor == CC_VENDOR_AMD) ||
-	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) ||
+	     cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;

 	/* Only park in the AP jump table when the code has been installed */
@@ -1468,6 +1469,9 @@ bool sev_kexec_supported(void)
 	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return true;

+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return false;
+
 	/*
 	 * KEXEC with SEV-ES and more than one CPU is only supported
 	 * when the AP jump table is installed.
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index f9bc444a3064..ed798939be5d 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -80,8 +80,9 @@ static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
 		 */
 		th->start = (u64) secondary_startup_64_no_verify;

-		if (sev_es_setup_ap_jump_table(real_mode_header))
-			panic("Failed to get/update SEV-ES AP Jump Table");
+		if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+			if (sev_es_setup_ap_jump_table(real_mode_header))
+				panic("Failed to get/update SEV-ES AP Jump Table");
 	}
 #endif
 }
--
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
