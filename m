Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8F9CD98DA
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jd6aM+E7kwCHb8eK+55ADMe/nKQDxUMiF45qEHRKNGs=; b=lWzo4gYKAeMXgEdPURwXUMgfFt
	XVlSHVpOBaLoJGtdKXf51iZCZ/bdp87KWbNayUprvSyXy9XIk8VOFqnOpyEIs1NZaDmznz33Cn9Mw
	EDScczV8/y4JbRmTh9+vmmMBAiXjW3rm00BjKGVh9S8DqfYUSrUQlzuiTT9XWJGpDkpfG6rh93VQO
	S1AReTkybazX7kdgCXtZDsgrAhEp5KzVWd7Dn0GGkayOWivNpCHy2nXCeE9/Ic6VyGfJuhc9c2n+H
	yMby2Eetj3s89IpuYV3kn2MTjvFD2b3N5a+hpaAQn2dcxwj6LhVJZuXXMGrrKWYzpuxCFVl6GiXqS
	osGjaT4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZTlo-0000000Fphe-1l6H;
	Tue, 16 Jun 2026 13:24:00 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZTll-0000000Fpfd-40hh
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 13:23:59 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-68b6f4f3c06so3907157a12.0
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781616235; x=1782221035; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jd6aM+E7kwCHb8eK+55ADMe/nKQDxUMiF45qEHRKNGs=;
        b=NoLKHH/Uy5705tT4hvCnT5IV+nTArFPVNeSbU3CqvuRyFt1aLQJ2Sw6C6GyYJNVOa+
         mLm71eVl0ZKm1dcqMUQaH9MCM6AUyGyGHdU4Y3nkiylhU/PSIxk5r9ny5/FZjMepGy/x
         OgH52TI+o51fU1185mLr/JNhaHNUntEcJ1gwAlURY2gsWcvRPiVyKKMSmMt+819fs1VA
         yCq0oi5nnIn5VLdRacdynpHVnpaglOWP0ePfG6Ub/Un/kCid7L75N8wj4iGvBvwMCcwG
         F6mOms57T9RUKe/UANtmXGVgI2kE2bCTySi+wrKTMeu11p9dOWeXfWmIAXc9KtjL1DNx
         O7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616235; x=1782221035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jd6aM+E7kwCHb8eK+55ADMe/nKQDxUMiF45qEHRKNGs=;
        b=bi0FdzEZsOBQ2XKZAYr+sFVOSxwuDm2LYMitzLcrswEHVj6d0MCoiGheCfIgXM9r0z
         DPycpvBPSUuPMTN4QsnhwqJnQ6pJu6vebb4OqdclByiMHNMr1pYrzg12ZifD+v2TVEbh
         YnnYWf679PfJbhlzsbrUwGZKQLjNzrX/NjIte3to+bJEfZKcD0Ei6OLZERRTAFiLu4V4
         2z/ENKR5cjGrWWr/NSsTeYabQjxQozYuxdkPtesCURW3HZ0U8NZ8sI0Jtv1iqi5icbim
         aD7OdG1AY0VYj7cTwtmVeEcd/TQSpra798KjgBlbkM9HNpDePSYkkKZZESj1q4y/yBz0
         kpKA==
X-Forwarded-Encrypted: i=1; AFNElJ/a6rFtw+DZ35j7gsq8gkHoYd6Gb5ukzT4aRosJPTT+MXS/hI2f+ONzSYvcUtJ3RIgzVnNRTA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxWSThuLoTlvCV8NlMhz5AgMMq3Eg9Tk3GmYzlKW4DXh29Manos
	FLweSdTp2rrEXtAwcRAX2gbAwNIBK1rsWmcntDwTGN6aTJhTcJINN1xptpYrrf8k4hSO1YzVOH7
	kV99UNZ3CPuezPRILdg==
X-Received: from edf28.prod.google.com ([2002:a05:6402:21dc:b0:692:3d87:5b0d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3707:b0:68f:c63f:1ed5 with SMTP id 4fb4d7f45d1cf-693c6a9351bmr6482036a12.28.1781616234872;
 Tue, 16 Jun 2026 06:23:54 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:23:50 +0000
In-Reply-To: <cover.1781615759.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1781615759.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <242340780dcbace523a7460953ad754cc0016217.1781615759.git.tarunsahu@google.com>
Subject: [PATCH v2 1/2] kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
From: Tarun Sahu <tarunsahu@google.com>
To: Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_062357_996583_448A53AB 
X-CRM114-Status: UNSURE (   9.86  )
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

Adding KHOSER_COPY_TYPESAFE and KHOSER_COPY_TYPEUNSAFE to copy one
serializeable pointer to another. It basically allows copy of phys val
of the serializeable pointer.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/kexec_handover.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index db9bda6dd310..1606369dc1ec 100644
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
2.54.0.1136.gdb2ca164c4-goog


