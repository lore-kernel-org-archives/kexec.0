Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D612C67861
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 07:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fd4E6TLvBHW8bk5C4trzNyAYypT4qRstatdhLeTOYdc=; b=gIj2i8MuRynhNh
	0mGmG/PUwPRzyqt1WFcXjA1pmRYhTy+Mm1ZOsjYuwyZ2r7srSBxlKAuHiRQasrZJ9F+GeGdmL6CTU
	qh/5DLoH7/6uNGkuik7uSCiBsghPjiTnCloYbQnZ6BH6qlD47P+9LIsIkphr7zeRHFOa8JFN3rccJ
	Fei/wtMO0fOj7n6O6QYg7mnFimQnwvoib/ZlYi5DyteY+pwEqQcy32o5GtTWCo2KVK+ccSNIb3UEv
	vZM/eQzcyDgDUZixERWA9Ic32ZMA/b8bFDKSqEj6KsV0ql6tJ6tPRzAIwk3omZOUZKInOJXDInlyo
	x744oeVzVjFYEUJsEcqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjdo-0000000Ei5I-2uNP;
	Mon, 08 Apr 2024 07:42:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjdD-0000000Ehjz-3Ts0
	for kexec@bombadil.infradead.org;
	Mon, 08 Apr 2024 07:41:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=AJPEklCzoS2DFb7f9ZXxyBC3nyK2AChPfFAIeZ8KZAI=; b=fSkge1l1KAjyC65LzbUk3MpHzE
	FgJb50oZ/ol8KKfk0cdIOiGK9x7M9c/BZlsde5tOBaX6MotaHxpxAt51XkHmiSTX4Iv18c6S7BFwS
	IP6i3OaYIw+93r+W5Cb1XLauhNmege+1q6pE6+Pk54SjqiweKc0u/pIftOfmiNucj6+xAvLgDH0lf
	saPAFX2Ry2SGX4PSSBWu/v6g0hmmTCOhI5Ee1slXvGuAVtno8chTEqaW5JfXuf9pn8Y+J/jvEgBBH
	6FxQfZYs4RC0wPVKPQvdkLTVGCtc3pWy2+TLOR3cLE/JcrZtHFaDZA/GzUTpLJ7nnCej89x6ZnuhN
	FIIKPGeg==;
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjd2-000000071to-0w9G
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 07:41:26 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so4220922e87.1
        for <kexec@lists.infradead.org>; Mon, 08 Apr 2024 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562078; x=1713166878; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJPEklCzoS2DFb7f9ZXxyBC3nyK2AChPfFAIeZ8KZAI=;
        b=LsU5Artu4QAZTAW7S32/gQMIIl2QRehTuC8fx9maXM7seLwD3tOSnJg/UzOiPJsN0I
         CBYjIqLJ4b94hXfN9mlRKlkwRbcgjBKp4+46n8slIH8z9Thhlcuh1wvFmkqwank8jBn7
         WOCupnegKoLq5iHzQ7+WMiW6le2w32KcaHXzToAjPLYPnt1IeQUUTt0/JQjZTZLU6eYb
         3WcsTwfhiouY8jadt23UOqSsa+EWB1rxeE8m/qtSoMYtf/TU8vOH41bed780hvE5Erwb
         zBjs0Tp9COG0/LV+uPXfm2SCuuDMi+cRnkVW13UDZ7/LGvSb9r5Og9akX3zeHZJA3QHI
         5kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562078; x=1713166878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJPEklCzoS2DFb7f9ZXxyBC3nyK2AChPfFAIeZ8KZAI=;
        b=LUoAX+uJ3qtFH/0TJnfV+1C8/UCcKefDLUg24/yb9MrK9PSBm0xMpyzlNt93xXbE6V
         wh0r2crhkxtMAA847z0fBI7Z8hBvOPM3vb8PHeriCLT3YQxwHp2bq5wziaIKLQBxl1Km
         h/cYw7qOBAChYZ3b4y/J5TXJIHMn+2geO2o3ezG+jVf3m9D3Dc+zBIC6HKahhRn+7M1J
         gvbo8SEf4mwYD8A0X2D3exHFHyy4vfsr3XH1x9/EJ7srQdawf58sNsq/aBR0DzYBdCKq
         xbL9YykwURnCX0brsU/mQxlbdoIkbatDUu5/Y1kVBEl1hKYnb8ShPwPttQeozLlcSXc7
         q8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI0d0TQHSVTVudAkQ4TTc0oCZ0/xSmKeP8ZTuWnGe6MirE9vU4OPb+IIKWywO27K54YEyIgrySioFQPYXHN6+t65NJgYaVyenY
X-Gm-Message-State: AOJu0YyutzPFJg0iNYzrb+8RpYwb9nqbw62Bc3U9ZF+8RjOlg23w26Gw
	krc8l5+VRsqU0Cpgxd8IBDFxkDUt2nLbKjCTs0YnveKxhfJN5Xos
X-Google-Smtp-Source: AGHT+IHpElUIChuykMsasXSoM3TJVl6Wfcb1bXJa6Q9tVjHiJv6DKDaFlFEqFX6ZTMlgVGGqgWRrag==
X-Received: by 2002:a05:6512:3618:b0:513:d5ea:1d21 with SMTP id f24-20020a056512361800b00513d5ea1d21mr5855791lfs.69.1712562077693;
        Mon, 08 Apr 2024 00:41:17 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:16 -0700 (PDT)
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
Subject: [PATCH v5 08/10] x86/sev: Handle CLFLUSH MMIO events
Date: Mon,  8 Apr 2024 09:40:47 +0200
Message-Id: <20240408074049.7049-9-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_084125_051457_2E0D82AA 
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

From: Joerg Roedel <jroedel@suse.de>

Handle CLFLUSH instruction to MMIO memory in the #VC handler. The
instruction is ignored by the handler, as the Hypervisor is
responsible for cache management of emulated MMIO memory.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/insn-eval.h | 1 +
 arch/x86/kernel/sev-shared.c     | 3 +++
 arch/x86/lib/insn-eval-shared.c  | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 54368a43abf6..3bcea641913a 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -40,6 +40,7 @@ enum insn_mmio_type {
 	INSN_MMIO_READ_ZERO_EXTEND,
 	INSN_MMIO_READ_SIGN_EXTEND,
 	INSN_MMIO_MOVS,
+	INSN_MMIO_IGNORE,
 };
 
 enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index d769f80d0264..1bffc2205480 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1171,6 +1171,9 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	if (mmio == INSN_MMIO_DECODE_FAILED)
 		return ES_DECODE_FAILED;
 
+	if (mmio == INSN_MMIO_IGNORE)
+		return ES_OK;
+
 	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
 		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
 		if (!reg_data)
diff --git a/arch/x86/lib/insn-eval-shared.c b/arch/x86/lib/insn-eval-shared.c
index 02acdc2921ff..27fd347d84ae 100644
--- a/arch/x86/lib/insn-eval-shared.c
+++ b/arch/x86/lib/insn-eval-shared.c
@@ -906,6 +906,13 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 				*bytes = 2;
 			type = INSN_MMIO_READ_SIGN_EXTEND;
 			break;
+		case 0xae: /* CLFLUSH */
+			/*
+			 * Ignore CLFLUSHes - those go to emulated MMIO anyway and the
+			 * hypervisor is responsible for cache management.
+			 */
+			type = INSN_MMIO_IGNORE;
+			break;
 		}
 		break;
 	}
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
