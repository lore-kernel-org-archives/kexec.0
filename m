Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36CAC43327
	for <kexec@archiver.kernel.org>; Sun, 28 Jun 2026 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hgM2C+2tmAHXCXi1Erw+RqOrmUTdjS2vF4qNTQXjKRc=; b=FDOJATFcvYjTWVf0FWj5R7Q9U+
	VWO5PaFNY1bifFogQT4h0ainlDxrMPPwcZuX4UZKQFSBqm7XsWsO41xKe4OvYxYO94KBZnmmq7C82
	83+m/8BAYEt+UTbiSvZN1rmjMgRMuZ5n331DDZWv563kGEN8XAJPm3px3BCFV0lFv1J9P0WlP+z1P
	dZgHCRWO7zbT6CkiuVeL7Tab+5ngkTjvW3okeHccih+O20yjldrE4f7QM1bEK7drjCdeMHZ9eoa6i
	JYoFYiQtKDG+OQf/fG3DRcf5dZbCJojzs/2WkCUv8sw+g49x8EOE+fDU2Nq0z4bvcJ+pCMXd4bnF7
	4+fVLNeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdd7J-0000000Cq8k-2f7G;
	Sun, 28 Jun 2026 00:11:21 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdd7H-0000000Cq85-1hwX
	for kexec@lists.infradead.org;
	Sun, 28 Jun 2026 00:11:20 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-c120f00e45fso210631266b.0
        for <kexec@lists.infradead.org>; Sat, 27 Jun 2026 17:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782605477; x=1783210277; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hgM2C+2tmAHXCXi1Erw+RqOrmUTdjS2vF4qNTQXjKRc=;
        b=AlcDmFsfJsWRan/H7phHBYPE4ca4OxbAcjAOkLDRApjoE2JsTrcRx/BgAtK5kQSEQX
         XI5aYdVnxsrZ0B21qiq7OCrK+U2d0vsHuOgCDKFui56K60qQkFe9ZmpQ3THbPD+GoUR6
         WfsQ0l4N9hg0yy9SQO7yNJDLzQX/VAsnBlSlvoQcFhBAaArwRvn2JYRBMYyueyuISReB
         sfMG7lLGyMWT7RROF21OCPa08mAF84/pZdh+XwgCvLVwHwPZSev9cw6MroBvJtmIjQhR
         caq6ec4yOOrEJaiJNWmbYzM+QnP3r5o6F/cV8eiOgUu2cXvTTYkMwKQGIikc6dG7lGv2
         Glzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782605477; x=1783210277;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgM2C+2tmAHXCXi1Erw+RqOrmUTdjS2vF4qNTQXjKRc=;
        b=ZmMJJVqS91uoorSDxyOu4eN+avKFtf7cfSAzF58JbYS/z6ZTfpzBDuExXRnXC5CXjD
         hHfTc8KzDECs4tkWzWlpBF+WvuqImV38s7JYDV9dXNv35ZNNrEv22LvriewcHaVOvjRW
         SeMmaj3pIPaijAZzwr+ybN4J8LpKUniO4//JP7g0QRxvjLBwF+74Yd3vmQkZ/xcHbkHH
         A8h4JOCDGYk8Nyt3BTBo4/oV1tcoPeMZaHQrn8KpPci7P28A+p01yEM6OXjvBjm74uNs
         C1YV6I9OBKErj8GtXuxlrdIs7DKiqbu3bsQy1jKhr9q8xphT+hWCNXpcIfaO+wqlBDGT
         Y5jg==
X-Gm-Message-State: AOJu0YztNLEEg5L9mfkHezqE/Qq2yGHIAEAT8JQ2ZydyfggGnxFZm3Pq
	M9dNhhCcSf+TCkmOP+LEi6urHMZSYWLQZmA1azx5ZliCaeoZeCcBLWOMk6yJD3LkQq2Vyfvt19w
	KeEks7VfB7NDAPQD4QQ==
X-Received: from edsk16.prod.google.com ([2002:aa7:d8d0:0:b0:698:4825:edc9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:22cb:b0:698:3b7c:be67 with SMTP id 4fb4d7f45d1cf-6983b7cc7e5mr1598424a12.35.1782605476512;
 Sat, 27 Jun 2026 17:11:16 -0700 (PDT)
Date: Sun, 28 Jun 2026 00:11:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260628001114.1869564-1-tarunsahu@google.com>
Subject: [PATCH v6 0/3] luo: convert serialized ptr to KHOSER_PTR
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, skhawaja@google.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_171119_484412_060A84B5 
X-CRM114-Status: UNSURE (   8.59  )
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

Convert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
This series also takes care of resolving the bug with memfd of using
phys_to_virt before checking the args->serialized_data value.

Tested ./luo_kexec_simple --stage 1 && 2

v6 <- v5
	-Compilation error fix
	-Nit comment fixes
v5 <- v4
	-separate the memfd_luo fix in a new commit to allow backport if
	needed.

v4 <- RESEND V3
	-use only KHOSER_COPY_PTR and have compiler time check for type
	excluding void * types. Remove TYPE(UN)SAFE variants.
RESEND V3:
	-Sent incorrect thread format earlier, this one is with correct
	one.
v3 <- v2
	-Rebased on top of liveupdate/next
v2 <- v1
	-Use KHOSER_PTR across liveupdate files instead of only memfd_luo

Tarun Sahu (3):
  mm/memfd_luo: validate serialized_data before conversion
  kho: add KHOSER_COPY_PTR to allow phys copy of serialized ptr
  luo: Update serialized data to use KHOSER_PTR

 include/linux/kho/abi/kexec_handover.h | 11 +++++++++++
 include/linux/kho/abi/luo.h            |  5 +++--
 include/linux/liveupdate.h             |  4 ++--
 kernel/liveupdate/luo_file.c           | 24 ++++++++++++------------
 mm/memfd_luo.c                         | 16 +++++++---------
 5 files changed, 35 insertions(+), 25 deletions(-)


base-commit: e98a9c61721c14bcd29f11f4802e52e908701f7a
-- 
2.55.0.rc0.799.gd6f94ed593-goog


