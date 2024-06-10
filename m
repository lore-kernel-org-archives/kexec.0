Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED37C27C55
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iv41gsPoNqVfoHFdOfR7GAr7RNe0KvYExo3sTVgAzlg=; b=jsF0RxLShpLGon
	WRvAbxlCTvPZz4GqxZuMLBvMMhc8a8Rpfr5nVNHqZIL+m/eaaeeHyiLKDkLgrHN19bDhjXtAMgHvJ
	YH3m1Y0czR4u+mb7KKTlaQLjCM6+H7xyRy1TpsZTD23zoZdYbLABoUK4Bl45rP0onqhcRoOEp+7w5
	mD2MuGMn798qr9asiwmpRQzAHsA5lT8HhwDGH9sUHMUzb/ZoQaEnEu8O9inZkVDRM9MJBthkBl38X
	+uIbBu7MZ7iS4yWft1no025CuQYw73GbANZe6/RR5xs6rTYgMWo4qGz9iqpq598/bpHB/jkgp+ORq
	2fyMSyKBMNPZXlV+4eEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9x-00000004cZ2-3GSj;
	Mon, 10 Jun 2024 10:21:53 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9l-00000004cOF-3mjW
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 10:21:46 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a6f177b78dcso121953866b.1
        for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014900; x=1718619700; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1h9f1jusJiCVXI0HUFRIPuyM0FJ2eMb2RD0DEq0ZSug=;
        b=HUDO+y5Rq+xL+/gh9vZjcaEjn3/QzaaIKLu4y/2TgKHdiDyZeNh6iFqzKMnSIPFbf5
         Lezs6eud33YVpkVNsrcuu1Y62yg8nrL/ptOH6B6F34RmTYDHFMZrpFJ92D0fSpXartFg
         7+2VSOT44v/u8mrUB0Grq5/7B/BzcFuFS2zt7Sh5vXsTPXyPqoVznQPEuogYdBuIJovr
         0k7qI2YXnImJTD/lLPFv/M/8pxN20iW+/OjXtHOlJSO1hLry0sTqmqHm7b7y6fdD/72s
         b3IoEtRUJVTgsNa+A5AE04+XmICpkHrOFhWXtifXcyzJ37BlphGD06p6oB1KbxAVoeHK
         NhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014900; x=1718619700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h9f1jusJiCVXI0HUFRIPuyM0FJ2eMb2RD0DEq0ZSug=;
        b=lQzIM0nkhalNuwu2+OjUTgV9Y//TJ0ZBTMUoUanLzIE0Czc1kS16R0UVBCH6YsAHaH
         wbrPGgITjDriSjRCna3i2LFh+vqP7uez8fBcKBa2X/MLkK4VnmEjVX21fPovbIx0re04
         D+M55/s+Tt0BUzfK3AApdKzFg4Y7CoE1fJbRRhz4GUHRWz2FUzgImlN5h7MNqZevtw4a
         3vUfNbRdXkOLJabsIeawbCrisvH1HMncAxS7fXt9om4A/zyMdxYjRkXcMFARFEJBZ0z0
         e6yjrpdt9q7xE1swq/RJGAr+KOAX8lOGIf78O9nelm9Bzo8gwqKxjAp/JSv3MHb+W8td
         ZoZg==
X-Forwarded-Encrypted: i=1; AJvYcCWUTX3wowclvYSsAPSNhtkciJD5iL2+Qkl7V+aUWLp4yoc6Pc21Ek+/+622l+eLEC3qITrhSQbqkI4IljBlDDhm/umDvPnqLZMy
X-Gm-Message-State: AOJu0Yww04wOmxFbZkhJ4iqREX12v8FpHd5iVvstniTGnGlhOYwfBBxf
	JIOeei3r36gOSMLAW4PYn2acY1yMqO/mat0QjOAfXUNhc3STaV3r
X-Google-Smtp-Source: AGHT+IFJiw9+hjS8AaCE8xUhReVnHEw0PrrFH9cPzv9TZmB9phDv2ggpsMiBf14CXAFGLO+4Z9OVRQ==
X-Received: by 2002:a17:906:fe07:b0:a6d:b66f:7b21 with SMTP id a640c23a62f3a-a6db66f7e7emr709355566b.54.1718014899942;
        Mon, 10 Jun 2024 03:21:39 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:39 -0700 (PDT)
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
Subject: [PATCH v6 08/10] x86/sev: Handle CLFLUSH MMIO events
Date: Mon, 10 Jun 2024 12:21:11 +0200
Message-Id: <20240610102113.20969-9-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_032142_414193_02618FF3 
X-CRM114-Status: GOOD (  12.30  )
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
index 1b25a6cacec7..2a963ad84f10 100644
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
