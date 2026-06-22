Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99BACDB477
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 11:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W0tMHlxfhNRj9OWJ2aLcf95z6Lv7ns1VwKEy9Zm5rfk=; b=M4S1o6ZxOm/jBa/F29OVLRQW0O
	m2PgAKD+ug9tmCI4zeHv8xdfp3KHsBufU6uIUEelbT07nxjsGqrHIUC+lbK2RXXsyVipM3VXHWia8
	Cnh0GgwJZecCaenmndMnrfXCvco3jFtR9QGG41B5annfmk2wyo5dA8qgGw9wgUlbom5RzqLKk5bwn
	J9aIf3dcqZ9Pv2Jb3HDDc+lmPaUan15CtYgCp3iKIAKs1yqV4FCNxCI18dIGTFUiwePAxhu6E8nGs
	keZKlPO/vj5I3FlPJIM2WdDUSfGkwyzZyJIN3oVw3n3Ofy9rAgXeIm83M8Gok/b2xA+12DMPeH5wO
	liIatsRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbcZk-00000004saR-2UvT;
	Mon, 22 Jun 2026 11:12:24 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbcZg-00000004sYk-49Pm
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 11:12:22 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-6960fb32b73so3802106a12.3
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782126739; x=1782731539; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0tMHlxfhNRj9OWJ2aLcf95z6Lv7ns1VwKEy9Zm5rfk=;
        b=BsPvrxsu9LLmvvJ7s9XpxY4AjqUYgSwn7eShBMX7S7hbtUyWjNIibQYsi8+V+bSZu0
         xupcPl94djw6gB6mcrL+mHq4PrmoUQ7TWT67l0QhnsnRvqyurO6hWL7BiX7I7AhIqAXS
         MMxVudyHnZKqv3GrvPZw9vDRqU2Jh6QEL4GOqGe9J+xJ+jtPllBSD0Nd3F6hf/EHl4Qf
         T3vE/lTJ3q5mK9kAMo3UTDwAmHgsyQCjGzVs8lc7Op2EOpJXRB05WXka9JhuflzWCgmL
         umi/E5ilCeEYj1ugq5q7vDM+q1HvA16m7/0cZZ9Gkm16HExR6lE+GwdVgRag8JtzYGs4
         Vacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782126739; x=1782731539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0tMHlxfhNRj9OWJ2aLcf95z6Lv7ns1VwKEy9Zm5rfk=;
        b=o564TxSrkeMDFCUqMHHTL82oG+LkJav9Qfp2/HjdEBt78IDejrRoT+olYwJoK6X763
         FxbNxgFCFCMgWroFC2XKMsi67a0bPZIaIfgzT9y6I/lN3guiDl30i+4HjdnDV9gul81S
         Mbn+NTy7SihbqDTssLLBXE11bdlHfRUQHm1fEc1kgrCQRdhFgjKZJNGyXZiJeBnJLDvG
         pH/dOoompwZ51kuVQXWPOerQmu1334mlvBd9d6Ez4p+VRKlKvSlhrgVxb4Vk+oY9ouf0
         4awOIPEb3xPQtAMILcXOq76jMlHoFY0/bDRYFDh7kOzXjB9rSZ3dVUo6pq0wTb7CON7d
         jKfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8sVM+S45TwTaoLWptaZkN6rrC1IuCM5KciFyx5UwqSncRQeCUod6F782/ctn344lDO0CqY9A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxrKJOtveHS50aYAnoQ5GkdjD/kWebiLGNy35rzIo1G/LQLCaq7
	ZTdPfRJb0/THwWWAgIxcF6CUeZKPC4Iamm1kOXqChPywZNlip93BYuqDgdGEQZbnLHAZaz7Hzpa
	W6N6h/vcy5L3WEVoPgg==
X-Received: from edti7.prod.google.com ([2002:aa7:c9c7:0:b0:695:8ee5:960f])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a295:10b0:697:6415:1186 with SMTP id 4fb4d7f45d1cf-697641513cfmr3638026a12.26.1782126738554;
 Mon, 22 Jun 2026 04:12:18 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:12:14 +0000
In-Reply-To: <20260622111215.4157974-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260622111215.4157974-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260622111215.4157974-2-tarunsahu@google.com>
Subject: [RESEND PATCH v3 1/2] kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_041221_025880_0302AA70 
X-CRM114-Status: UNSURE (   9.99  )
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


