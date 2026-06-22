Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8A1CDB470
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 11:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m10nbWcXsn2fy3EJyAc5wf96aflhFz5y+USLpvcgRX8=; b=yVlkOFUGT6kgAKdjSqTsiwGVPK
	qHbC1A+KA9rShqPc0DJrWKKTmAyfVUojZEFdjwS49ut0kq3IRFyFdDemRQmoo08Jh4okVPErNb663
	dP3C9DTXdL9BnFqAQamZPtf6qqT9TBZ+ehyoNYJ+zV1XHE1lVX3fPZDrEKQ8LbRvNAZMExESe8YYZ
	zwi667aNiVXHmJlFt++JLZiAoaYqI2zJ6nQqffzsJMLE8W5ZSR6ItG5njFtWQL6tATnfya9XjU1tE
	rsDxFOHR24bVd/evmTiXAEAO0t2gBGIQtfeeZB9wJLNwmof9u/CifuZBVPPC0u6xaSrousK/MXHjm
	5cfINO7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbcZh-00000004sZL-2CTM;
	Mon, 22 Jun 2026 11:12:21 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbcZg-00000004sYf-0zsb
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 11:12:21 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-695837464bcso4315118a12.3
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782126738; x=1782731538; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m10nbWcXsn2fy3EJyAc5wf96aflhFz5y+USLpvcgRX8=;
        b=p3/LyDYCZrevFzcqQvugc2rzp2dB28jd6Ih5wDaG7r/e+RArLmYgdpK3bkXgg6gOxo
         i/Pc7PFxojgb2IXMuCjKXi0yuMxxpxPpAG2hnwt+a77rOriQ/py3YcfIlz2YM+RuujBp
         9dNPmN1CpdIEqEIE8RdajeDbBMRUkAqaoM55ht1bHZO+KSxDWSc62mSefhtNgOglxhu4
         +c8FC1L8esCfJBXx1c6u2AEnx/9c+vhuRLZKJ8ymHHWev9/IuKuELQ4yR8RUc9PPpl8I
         SGJJ0FDBZ8eK39+5o0QpoLRqJa8hhtXCkQ097piSLMFH0yB0LG2Zx/kTmQ3Zk2Q7Cn8S
         0zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782126738; x=1782731538;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m10nbWcXsn2fy3EJyAc5wf96aflhFz5y+USLpvcgRX8=;
        b=AAKtnB9H4bFj5sGSyLvBBWIFj/0EWijJ/39xol/TbJMtn0ZS7ih4jwA33FNQ1B9slR
         8CrXI+UiobysExP5djKJpqjo+Blj2jWbVCBikTWXQb87rpE4Vh3CiOMzKxAkmAiO20FC
         OQ4CWdxqC12vxfnPkB7NCjZDmST8anr4dyCmlTtRq2+UgUeyqUAbYxzJHCiaIrMvHMjD
         cSLatuiy0JuGRsM9GYar9QP9pCgf2jd0txGGf+iRB2KQwz3LJyD1cU6XRn72We7Zcu6I
         48sJJiWD15wx1gz4Y5EJ3hHjk6OfVSLVq3uN0C0QuB2kGriM67zKUUmptWfWb8umk17W
         21ng==
X-Forwarded-Encrypted: i=1; AFNElJ/N5bjtzLZ/dEsaj6hbI2/70l4b3NXYvmelPCDX2c5Q7YhtESIFgI2vx3TEKf25ZCHl2q9asA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1GIzzP7Wedbge6YcB57ZqidEJEBJmVC64OIwEElGcp1QB4Gci
	jTXnL3YF3MGK7dd7EF5MOhtc4t/SOz6wNeV/WA0FOeETO0dJWf5OX+zX3yuCTX/Tu8/b0kcEwmu
	b4gwuOg7OKLc9jFF2Bg==
X-Received: from edqz7.prod.google.com ([2002:aa7:d407:0:b0:696:5e7:d0af])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5215:b0:696:8f45:4ae7 with SMTP id 4fb4d7f45d1cf-696e5211777mr6088791a12.13.1782126737649;
 Mon, 22 Jun 2026 04:12:17 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:12:13 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260622111215.4157974-1-tarunsahu@google.com>
Subject: [RESEND PATCH v3 0/2] luo: convert serialized ptr to KHOSER_PTR
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_041220_280592_9C72302F 
X-CRM114-Status: UNSURE (   7.38  )
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

RESEND V3:
	Sent incorrect thread format earlier, this one is with correct
	one.
v3 <- v2
	Rebased on top of liveupdate/next
v2 <- v1
	Use KHOSER_PTR across liveupdate files instead of only memfd_luo
Tarun Sahu (2):
  kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
  luo: Update serialized data to use KHOSER_PTR

 include/linux/kho/abi/kexec_handover.h | 12 ++++++++++++
 include/linux/kho/abi/luo.h            |  5 +++--
 include/linux/liveupdate.h             |  4 ++--
 kernel/liveupdate/luo_file.c           | 24 ++++++++++++------------
 mm/memfd_luo.c                         | 18 +++++++++---------
 5 files changed, 38 insertions(+), 25 deletions(-)


base-commit: e98a9c61721c14bcd29f11f4802e52e908701f7a
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


