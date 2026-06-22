Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18993CDB471
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W0tMHlxfhNRj9OWJ2aLcf95z6Lv7ns1VwKEy9Zm5rfk=; b=njwszxA2nJGbUvKgfngd4fE4Ri
	dh9InNtr50tDshbkQKifqwOCRvZ1XgbgX2SmeYcPoLyrUlTDTdj6MvJ9BhuKpG2lS4uNT1OsyY7FJ
	t6TDGNdEZAdNavrEDdWWdZnIJblPIKTmcFP7utqPK/TOSMuh/p2rel7pYP5ENVQtEMkQbnXZETeQx
	ikoFrc+A4+886ZOifPchWY46/D859eScNSMIeuclTb6W08Pp1Nj2uGb0r0S1sSSP7QDnj9Z3lE5tV
	IrGMPw3vFQg18u6oP6MoRxH/X7a3FuweQYfjV+m1RMy5GwfVXhOaucFCz8KoSMpZ9t61uoUy4K4C+
	dkw6J5Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbbyZ-00000004q20-0bdD;
	Mon, 22 Jun 2026 10:33:59 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbbyU-00000004q0j-1oDK
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 10:33:56 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-c0bd2bf3ecfso226204866b.2
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782124429; x=1782729229; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0tMHlxfhNRj9OWJ2aLcf95z6Lv7ns1VwKEy9Zm5rfk=;
        b=FodTE0bXgopTDdLPDhsirz8eqlEpM3ZYJBn6uYlljlTQ5oubKKXAsxhQEgpHaWF3J1
         ZbDWUKFTjEogSUJC1uLhwBMNMtni1mxMM+7h2E61QXfoDrUoR0CQoreaGzQfZqZtxYzg
         +N9MCjixqviGizfVJqBSYqfqzul8B4pq/0Yb6hRgvoPAaoBt4kf1ZOCsMYq8/4t6rv/D
         /qeA5OFpdWZmdI/WYIjdghCj7ZO+Iqh1LbvhDsp2fEn2lyjEfL1aWkxx2Rloumk7NO3C
         CDiiAr47P4yZpPDKupowcfpyrWxIs+RLErLIDbsHlPCBZdDD58X7d/6CYVodUe/fCB1W
         eYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124429; x=1782729229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0tMHlxfhNRj9OWJ2aLcf95z6Lv7ns1VwKEy9Zm5rfk=;
        b=lALNkhHzjoEXpj8fjyI8A/At1DrWosw40Wmtgr26MuCX/J2z+M+KB7y+Ag+4MhePG5
         mIEYADW8BykkS35Zymg//l+bJVgxFl87K0fP/xRFE97MJvikL5txUFzn2GGUcusctQfJ
         3XUzVX2PeLPiVOjpMb94w0k7k0f50y6LCMxLR2nBYa3S6j0H69wBT+LOVhLRXrEdDj6E
         RMHG86InH/CJrAYtcPYHRJw4e7CxoOP8OJsGxHTaQup+aEBB1+uyKlL8bRS16/u9ptpO
         2OAi8+RETn8TbmReQLa1DgFmdMgtlBpaVtVabmOC5vJVlIu2TK2/ZoQ4bse7X0/jryXW
         daQA==
X-Forwarded-Encrypted: i=1; AFNElJ9fvuhnMSPtu/D3/Nc5SDguUHLdZufTRlLVkJBXBVL6LfJnBqMoGQzL6ChHt57RcDw2KbonQA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywb1bENSPxMOUOYiQWSTcqHwq+xHurZb7hB7ghMgSiypHG9nPLd
	H35PvZxxBkAzViMW4Q5oC/ffI8j3FGacTisnoS/u1pbtqze+vjGdYYEhSHXu7rDsOvTRFQc8tPT
	u+L7rS0ruOz/zbDcrVA==
X-Received: from ejcci24.prod.google.com ([2002:a17:907:2678:b0:bfa:ef9f:483c])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c13:b0:bee:e07:3f0e with SMTP id a640c23a62f3a-c0b601ea898mr640255266b.2.1782124428817;
 Mon, 22 Jun 2026 03:33:48 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:33:44 +0000
In-Reply-To: <cover.1781866575.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1781866575.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <85fb8f5a308203c4cb352189c6eb65b44c03bc49.1781866575.git.tarunsahu@google.com>
Subject: [PATCH v3 1/2] kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
From: Tarun Sahu <tarunsahu@google.com>
To: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_033354_475253_9B65695D 
X-CRM114-Status: GOOD (  10.21  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Adding KHOSER_COPY_TYPESAFE and KHOSER_COPY_TYPEUNSAFE to copy one
serializeable pointer to another. It basically allows copy of phys val
of the serializeable pointer.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/kexec_handover.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 5e2eb8519bda..618408fbe9c9 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -139,6 +139,18 @@
 		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
 	})
 
+/* Copies one serializable pointer to another of same type. */
+#define KHOSER_COPY_TYPESAFE(dest, src) \
+	({ \
+		typecheck(typeof((dest).ptr), (src).ptr); \
+		(dest).phys = (src).phys; \
+	})
+
+/* Copies one serializable pointer to another. */
+#define KHOSER_COPY_TYPEUNSAFE(dest, src) \
+	({ \
+		(dest).phys = (src).phys; \
+	})
 /*
  * This header is embedded at the beginning of each `kho_vmalloc_chunk`
  * and contains a pointer to the next chunk in the linked list,
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


