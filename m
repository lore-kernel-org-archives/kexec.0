Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE203CD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fLKpx/jP4XiZTHLeIbQxXoF/roGoBMkQ9auwEVuefCU=; b=b/UZuWvJxSH7V/8JAYNzKapVcN
	TzZVqv1fzxhbNfYJQVkmCd99JptU3AL5GQYUdSHvxu4G2wulk6cVHW9ae9ArR/IryxocCjpEfy7Fe
	vCtR4F4zob6GKaFrfkEeMNBkCiP6ejo2TZMVhY60OX0rr8L9HWGYJqvG+aySDmrE/53UOJKcK03UQ
	DXXEBBUNsGDU6+Xv95s3dmAk/LNd/5mDDtkIj7mtiijMjx0yr+PJ6Ch5npJiAeGoXvQSB+2jLKry3
	VFwCA9qyZalxgnSlIC1I+fW+5/t5/Q858L1NFn4B913VQFpjYhkvX6wPPlU/bxWUjA+TAQNrw6z5A
	PSo2qiXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ704-0000000EG2i-1Ebp;
	Mon, 15 Jun 2026 13:05:12 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ702-0000000EG23-0LKw
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 13:05:11 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-68b479cb98bso3127129a12.1
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781528708; x=1782133508; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLKpx/jP4XiZTHLeIbQxXoF/roGoBMkQ9auwEVuefCU=;
        b=k4Fz3forNb7feS9mvsV7v8d1Q5r5m+pQBYEf/PnihOzZWOrPQQw+Ap3GRPg8v+coY2
         V7zdK0YnQvV1ObZarItsQFypN3RuHTqLxbeDTCEmImDsZDEPldh5aYO2RS96ksbiKPcK
         17ny/lEBfDhoXhGO2Xv85YSiSzEa7Di6xDA5Q0EVCEm0PMebteh5Nnp1lFlv/2L4jF09
         np/3BWJwLQ+NiUY32PHOG+jcKwDy5oNoHCGmc0mNpyS7Zkb/PWSkcFKFNyqrIzovZuzh
         sKU0badj3hB+458Rxe4SSAeVxhCN2JhB6yn6hSPTst8sFDa6WHq05g47yTyBJ4jQ9C62
         o4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781528708; x=1782133508;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLKpx/jP4XiZTHLeIbQxXoF/roGoBMkQ9auwEVuefCU=;
        b=YXqeKmNQGDYyhZ/t5o4L2m3hIhVJEaa2HAbRZ0espIdhrFvYir8aNH1t4x/Cut0+2A
         SNiUpjfjTi+91qmykDUbbt3cmdCkRJURtUMENF8F5qe3nRzSFcUt9zqxuZadIiPG9uv+
         bIHKHLC9Xh+uTXxP+uxIgsOMpoBHJPYaL2xmGyz5t2REVJz2BRgU+2hrhb52UcMWROre
         +R1mFqN+IR9plkHfAQnnS0V7ez+C9fBVqdHxZhrpXTy+czjntsAvxz2tJIIv/MB915PY
         q/q52qcdx5wZvJjM3KsmP4oFw6nDWVuvdPmMyhkwa4SmwVTIWJoh1HUPcrg5YpCwTQZY
         ERGg==
X-Forwarded-Encrypted: i=1; AFNElJ83gSUi25WmAAQzEek4qWjdTd64//7cGW41EMXCGDBmyzCMcpqgTa3ZHMIK6b6ZaU+bntkhOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YydecvcNLhVOUdYuwCXNIa3P8UMJboSw1XQF1l70BcVNUIZMXiW
	h386zyXJryUOd4fl6xRZOHeq0k7DOmuwpae2XiVW4nkBwukrgZB0YpA6LQ0uYnUcqPIbOWFhBWn
	kQL79M+ogSjE23B+dyA==
X-Received: from edo16.prod.google.com ([2002:a05:6402:52d0:b0:680:d43b:83b])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4493:b0:691:af08:a9fd with SMTP id 4fb4d7f45d1cf-69378a03b9cmr6248742a12.11.1781528707628;
 Mon, 15 Jun 2026 06:05:07 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:05:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <cover.1781528022.git.tarunsahu@google.com>
Subject: [PATCH 0/1] mm/memfd_luo: use KHOSER_PTR for serialized_data checks
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_060510_156976_002128D6 
X-CRM114-Status: UNSURE (   8.56  )
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

Use the KHOSER_PTR interface for serialized_data in memfd_luo to
perform type-safe pointer conversions and checks.

I have tried to keep the changes minimal. So only changed
the memfd_luo. Would love the suggestions for if we should be changing
struct liveupdate_file_op_args like the following.

@@ -46,7 +47,7 @@ struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
 	int retrieve_status;
 	struct file *file;
-	u64 serialized_data;
+	DECLARE_KHOSER_PTR(serialized_data, void *);
 	void *private_data;
 };

Ofcourse, it will require change in liveupdate and luo_file.

Tarun Sahu (1):
  mm/memfd_luo: use KHOSER_PTR for serialized_data checks

 mm/memfd_luo.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)


base-commit: 0e0611827f3349d0a2ac121c023a6d3260dcecdb
-- 
2.54.0.1136.gdb2ca164c4-goog


