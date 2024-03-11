Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED55DC54E58
	for <kexec@archiver.kernel.org>; Mon, 11 Mar 2024 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BKcrlbLLyPgOBmrwRqnwzNqiEiDEPCowmYCNd9lZ7nQ=; b=kLNk914aSVFoE+
	buGilgGgNJ351PivfVfejExQ3oQECt9WaqsKjT4NIi4Ldv2uxNuVyOyUwB2Z8f+p9aytaAHmbyLOV
	iry4I8nZxKpuVhbuDo/NzlybBa6HRQQJeKtNQ25a5MEm+xWfFpJbW33+M76uz6tuJO9FNdHQDffVG
	YqHJ6x0JEFOKz1rwQIrxe0eWoALaCdIZLgS3x8QofF2YPjG64Wn/ulTJ0nybIlHHiMQy+S3qImnEw
	ss6gIwMWVRKZemlivbjw1V6mv5W1w71pAMMo9rsBomz22Zt9/jlynl06IY2xq7OlA7/Q7ZnB5mU37
	9Xj6N1kNXQBsQ0AxDE1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLk-00000002Gvu-10zu;
	Mon, 11 Mar 2024 16:18:04 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLU-00000002Ghb-0g9q
	for kexec@lists.infradead.org;
	Mon, 11 Mar 2024 16:17:53 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33e8e9a4edaso2234865f8f.2
        for <kexec@lists.infradead.org>; Mon, 11 Mar 2024 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173864; x=1710778664; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD+5e2rjcMTAqm1lLiHG9HKUMBAWFA80T0od8hhMD6s=;
        b=K7opvAGm5BTNXmg9f/bDPt1JzZeLkOLlNuMiIPLGpNj4v1441ToC9acluJG5ROSRyj
         xywXGAWJz2lH+5CjOCSaxqpfD3s0PvcyvRN/rNktCVkLBx71gFzfbvx1PC3fl9UekNNR
         K3DV1HbGqtZhvWjtZoV9zIzJbLDMm4X+0+ZAksOmcwpxKLfw5iCo0x1MFbE4zSz8SYia
         4//DIPby2H1uZCbfFe3GpWgNZXYtpCtPHdxrqB7WMS0oakeWv4UVgDKCSoWpOxq9HN1M
         VC0KmaO7vJrtbEU/PBrNnLuWDpno+l0mqzFcoNySBQrOuVvCTPKXZYG1iLTaSps8llpf
         4KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173864; x=1710778664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD+5e2rjcMTAqm1lLiHG9HKUMBAWFA80T0od8hhMD6s=;
        b=o47fO8saQHWcRtUgdTr6YcbmSw5gKNgy4STZWsuoElOXe6WyVBffFmMIYCgWeo6KlP
         BkbVd+98Ese9xNwfcJW8zLYSzgBAE8ULyXiIvtttxBF9YGDh2k0W6Io5L2jo/dHn9+dt
         Pwz/j8mgUWlBle9FVoY8G4mMMd6JlHO92w5Vv5xuatweEq4IrR3V0k2PhyRDRdTSP3Oh
         +EkC6s3KEl7snvOhrvuIY4DYnR5CE/Ck7NW6+pOoUtvWJweTQgHddwKKIMlGqdihYPC+
         pTDjMTIGLs3Wd925CkZjyAg9zTuUcbykPBpmMKL7bKqqBnctnju4vPk8a5EZ5HR4TS4l
         ZO7g==
X-Forwarded-Encrypted: i=1; AJvYcCXYP/e9S4AwQd1uAzFMDEiduSzDMzQyoc+bAHKTrBTYojIQccEvi8++VV0j63H5N6pvMHhz7u0Vytnp0jiUPu1cqG2s/9TDjJZ7
X-Gm-Message-State: AOJu0YzBuNKEWtfH8Hn0TA7LXfVIYJYT0RrX5Wfd0VNUUhyg/CAdyzvm
	I54IMnY1ecwKRG3S5Ot3xSvBKsH2zzLjJESkEoAOHoRKM0GaV/NA
X-Google-Smtp-Source: AGHT+IHYTDHzYrXzvp4OecC7PPYjSNE0zn/Q41wyIcFJBRWeQZQzaCiAotWHf7DRRVcFdGjRxY3S1Q==
X-Received: by 2002:a05:6000:cd2:b0:33e:82b9:5cc7 with SMTP id dq18-20020a0560000cd200b0033e82b95cc7mr603908wrb.6.1710173864253;
        Mon, 11 Mar 2024 09:17:44 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:43 -0700 (PDT)
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
Subject: [PATCH v4 8/9] x86/sev: Handle CLFLUSH MMIO events
Date: Mon, 11 Mar 2024 17:17:26 +0100
Message-Id: <20240311161727.14916-9-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311161727.14916-1-vsntk18@gmail.com>
References: <20240311161727.14916-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_091748_527541_D9C8EEEA 
X-CRM114-Status: GOOD (  12.03  )
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
index e9a959c1c11d..ac0704055d58 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1164,6 +1164,9 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	if (mmio == INSN_MMIO_DECODE_FAILED)
 		return ES_DECODE_FAILED;

+	if (mmio == INSN_MMIO_IGNORE)
+		return ES_OK;
+
 	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
 		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
 		if (!reg_data)
diff --git a/arch/x86/lib/insn-eval-shared.c b/arch/x86/lib/insn-eval-shared.c
index efc9755573db..3d71a947e562 100644
--- a/arch/x86/lib/insn-eval-shared.c
+++ b/arch/x86/lib/insn-eval-shared.c
@@ -897,6 +897,13 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
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
