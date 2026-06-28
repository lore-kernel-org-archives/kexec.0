Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80CAC44501
	for <kexec@archiver.kernel.org>; Sun, 28 Jun 2026 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R1hMKkHTx9eCvHpWXu0wJEWn2SvHnzVGjd97/dJhuHc=; b=x/lzVFw1YJetwWcntgoEswLp67
	h5xe6z61vUh5u/IsW4DP2TyP6PoXpWCMKP8RcVVYiOQHXAYtddhhoSq0Px8V+CMOC1kLhFq8JjJjO
	539T3W0faMhUEVEvf/d7dvG6ftrC5wUqN+lqZPYaoQI3r2AKvWMPLcF0GOTdL+rybf3hsBN4JoTQA
	zhH316AVcphtGcU8KGuI1RY8P7DxJ6ZCBnbXJdJSDJRbUkUj3cgeQae8Xg4LEAHRFXF12fKpwAxIU
	Tk8mikaklS9DQXpR+hthqZHbWKpsPtCJGikYpOFnXwB+32x8D5Nb7YOvdxd7rDlb0/oDE+u8NNCTQ
	fFwjQUVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdd7M-0000000Cq9o-3Olf;
	Sun, 28 Jun 2026 00:11:24 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdd7J-0000000Cq8J-2aFl
	for kexec@lists.infradead.org;
	Sun, 28 Jun 2026 00:11:22 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-69842d5e6bdso448096a12.3
        for <kexec@lists.infradead.org>; Sat, 27 Jun 2026 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782605479; x=1783210279; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1hMKkHTx9eCvHpWXu0wJEWn2SvHnzVGjd97/dJhuHc=;
        b=q+DZKdxj02ZmpXPilQ4SndyrBvTmE/KDBqQvchRsPJsYCCL6cabtzD99o5bGmtyn1I
         y6UFGMHEcJ5LKaOIwEG2eMLyogS6Gmyfq20nM7GZtGJNsdmnbf8e6HqDudjJakFv4YXa
         WWXdo7FkunCoT1m3cakCT7D+HKAcHwCLBVuMGvTavB+UN2jSw5alAmYbpntryrYLQCaE
         8J+hX8zikxTysh0Qhb6s+/uBd3JCvLdb5/UeSY6iGXDCCWAwI9rGsMg4YT/SSYEKUSnI
         tTK4gCoisD7zARtGppupZtYrHzR8RKtgpS/WcarZjoIDdRPsMsiBufbfWvp9sv1wzuSC
         aTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782605479; x=1783210279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1hMKkHTx9eCvHpWXu0wJEWn2SvHnzVGjd97/dJhuHc=;
        b=fWNbrJDG8GRuTH/i1ZP0qsuc9mAPicNGVdERXEV1jG4CgpzMPi8aO9b2kxsVSFYMUx
         0JkBkicsGy26xGcW6lyNeqnqNieEej5NxEbG3gPytyJtApQPUoCsup4rnDSfLUXmXj0h
         Rbs71djYo/ytd7Ywr0sPCg/IxetEuDvCo27WTU6LQMdLZnCSAFmGMo2FIkp2PaGNG+M8
         dzQW9XKXj96g9b6Zf23FZIcIdJEdSgzxdGZ/cNd0EJsE/zdbXgMQkatC+J68G4fhyXK3
         631zPeKqyQb52hGdXetuWYzbFJJlCOO7xxDrJ5/rXo9pSubYA1oJXpRn8KwTNUGAZf3x
         HkgQ==
X-Gm-Message-State: AOJu0YzXW30OmO2FYKsjJKnGlnAwOaq+FrRhXocSB7zPT7ZWNYuZ7OE0
	UA7h1x/P0rJFpVwPGuCBHbe3Om8+ncMcVyZkD2c0RzI7XWMhB0sVAoXjCfNilpszhYMqCI/Q8Lf
	Ymf6eAA7pAYCnIx9WBQ==
X-Received: from edbbf28.prod.google.com ([2002:a05:6402:1a5c:b0:698:48be:f3ac])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3591:b0:698:4831:f9aa with SMTP id 4fb4d7f45d1cf-6984831fc61mr973106a12.12.1782605478597;
 Sat, 27 Jun 2026 17:11:18 -0700 (PDT)
Date: Sun, 28 Jun 2026 00:11:13 +0000
In-Reply-To: <20260628001114.1869564-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260628001114.1869564-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260628001114.1869564-3-tarunsahu@google.com>
Subject: [PATCH v6 2/3] kho: add KHOSER_COPY_PTR to allow phys copy of
 serialized ptr
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, skhawaja@google.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_171121_664919_EAEFEED2 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/kexec_handover.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 5e2eb8519bda..a5a518e881fd 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -139,6 +139,17 @@
 		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
 	})
 
+#define KHOSER_COPY_PTR(dest, src)							  \
+	({										  \
+		static_assert(								  \
+			__builtin_types_compatible_p(typeof(dest.ptr), typeof(src.ptr)) ||\
+			__builtin_types_compatible_p(typeof(dest.ptr), void *) ||	  \
+			__builtin_types_compatible_p(typeof(src.ptr), void *),		  \
+			"pointer type mismatch in KHOSER_COPY_PTR"			  \
+		);									  \
+		(dest).phys = (src).phys;						  \
+	})
+
 /*
  * This header is embedded at the beginning of each `kho_vmalloc_chunk`
  * and contains a pointer to the next chunk in the linked list,
-- 
2.55.0.rc0.799.gd6f94ed593-goog


