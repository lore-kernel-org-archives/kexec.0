Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14F7CDB47D
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AwBhzOQmDvof4o67YNkTf38WRniNdVc8sUDs+ORB3x0=; b=4gY0Nl+Eym0hCP0z+mfodW0rww
	eRfP7AX8u7QCWTUsucl7E3Q11nQ1Ro4jMSz3UAiYjnuRKsDNekMhU5cUhQDvd6JxENazTtCfTBTLv
	/ojpYBv9Y4hbpA+jLz7sQvRFHZylO6OpzDmF8m3Zrue8mBBcjSh86ZLIJF6dVxM34t0y9idoKDkpx
	upKlGo/vKcGh1YSrbzDdbd1fC3DWSZEwRVp2U0WKkCB54/V9If6Hp69qkdONd56Z3/rVIZqGXFFxy
	0ve97MYUB8QEKX7/HqK5/k4SoXlPsD4Qop/YjYTZIYCvQgcvSsYBJjK+WuwJkONM32b9q/tjIQlTw
	qOyMYR+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbyjk-0000000670X-0aom;
	Tue, 23 Jun 2026 10:52:12 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbyjf-000000066yd-3sPb
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 10:52:09 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-697df3655d8so396194a12.2
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782211926; x=1782816726; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwBhzOQmDvof4o67YNkTf38WRniNdVc8sUDs+ORB3x0=;
        b=phqtWIfdQcawzxJ7hgx4aZD+uN3HeEm2S/9ziBaDHSlpTezIjpex+vJgJ/A5veuA+p
         /yHXIGSoJA/QE1wchb1ZJaUL658DFCqX29J5hN6KreM89hNbihH2z8mLZdtLEC+EuhR+
         h4uGHO61b7+4LmCyyf0QwVH8GXjap/dEyd2C8nrlRPdqChMQQRZAeEQzeU3rKIsdvSNw
         t14QhRDbn0janCacsyTAgZdV9fpmZq5NPqV3zr2yu+2C0RIJ0ARjXAssqqYUXjJSJXHX
         d3QTHp/o4f0gv7ncD9d2QQqtrnPPZn5lh9v+0cArBR9yGI9kBHU73FSFs49eYyGUmcrg
         7o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782211926; x=1782816726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwBhzOQmDvof4o67YNkTf38WRniNdVc8sUDs+ORB3x0=;
        b=A9CbkiYq6Tes306yBxV0uHY64kh0GZNU+avWOxzIwHFZjne/SZZaTnWlEx+7XMDVen
         5LIeufTzzoGmDc54sqNYUCnvDTX0KfGL5usZA4CmQvv0+ZuJhye458OBUD1z0bKsGKbs
         /hsROzrdQRhOedoYtY+cwKUY9p/rDFsqNhBOciGbG7Wyb3f9MoqV5wwz/xNKQB8ll7zE
         2rfcl+GumqG2RBPZGg+EhAxexU6/4lP2w7sCKbL5Ey0Cz69Cuv4QpixE/9C3GjelPk7Z
         +vU2Q4KX/1KKEPiWE9qZ72TeIDPT9bPckykK859xm3XzD+UbVjgLv6Ho8IH5+s9k1hQx
         Td5Q==
X-Gm-Message-State: AOJu0Yy/DqwA1ftLoFptdb/7SudcmAnFwDwC9RHlkMw/2j0zqlSDFFAg
	tS5qVDKaQEgIFhBK8eoQwCaDxke8GUe/LZfGEAFPc3ikEzfXkjctPfBHeOPjIElxUmJm5Q6xj/D
	1zmEdkxBDto0dddYOzg==
X-Received: from edds5.prod.google.com ([2002:a05:6402:5205:b0:697:9ff1:9f21])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4598:b0:697:b75d:fa86 with SMTP id 4fb4d7f45d1cf-697dbac90a4mr1031248a12.19.1782211925395;
 Tue, 23 Jun 2026 03:52:05 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:52:00 +0000
In-Reply-To: <20260623105201.3724592-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260623105201.3724592-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623105201.3724592-3-tarunsahu@google.com>
Subject: [PATCH v5 2/3] kho: add KHOSER_COPY_PTR to allow phys copy of
 serialized ptr
From: Tarun Sahu <tarunsahu@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_035207_971072_11AE3B38 
X-CRM114-Status: GOOD (  10.01  )
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

Adding KHOSER_COPY_PTR to copy one serializeable pointer to
another. It basically allows copy of phys val of the
serializeable pointer.

It ignores the typecheck if any of the argument is of void *

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/kexec_handover.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 5e2eb8519bda..c1b61d875dcc 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -139,6 +139,17 @@
 		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
 	})
 
+/* Copies one serializable pointer to another. */
+#define KHOSER_COPY_PTR(dest, src) \
+	({ \
+		static_assert( \
+			__builtin_types_compatible_p(typeof((dest).ptr), typeof((src).ptr)) || \
+			__builtin_types_compatible_p(typeof((dest).ptr), void *) || \
+			__builtin_types_compatible_p(typeof((src).ptr), void *), \
+			"pointer type mismatch in KHOSER_COPY_PTR" \
+		); \
+		(dest).phys = (src).phys; \
+	})
 /*
  * This header is embedded at the beginning of each `kho_vmalloc_chunk`
  * and contains a pointer to the next chunk in the linked list,
-- 
2.55.0.rc0.786.g65d90a0328-goog


