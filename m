Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EA0C5AD05
	for <kexec@archiver.kernel.org>; Fri, 20 Feb 2026 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CZAtOD8ZRnarQucUHW7t2nY+Ut5JOEodfHGgZzqPkiE=; b=Zmxxo4TrtoRfaebz6Ue2SSfws7
	Fjo2Aw8Sa+YQiNYClRsuXrg/t88UppiifAMAwWz6X/hrVpCIVeVbrDguCa52cYCwpT4NLARvTrLih
	OncKFP+a/RnoRdvrXb9m2oZQ9WjQn8paFoivEENxRq6g97Khc0orziFTa7GtOfurkCVrA2iVyBj7Y
	FJiXQcJp1QIYyoMBDkaCHsFoNpzPekaVh3EKiS7ubCHY3t3Qu+u2IguRW+C0PNzWaE1H3tqE6lZEZ
	gZaN5sj/vYgZvpY9AFPiuxI0Uaz262/eFPcdi6Imhm6NvEExHSpAVliHeog7w/qUxtzEQD7QN9zIB
	7JBGCkeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTjh-0000000FKe8-0CjD;
	Fri, 20 Feb 2026 16:52:13 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTje-0000000FKdc-3yIh
	for kexec@lists.infradead.org;
	Fri, 20 Feb 2026 16:52:12 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4837cee2e9bso18295675e9.3
        for <kexec@lists.infradead.org>; Fri, 20 Feb 2026 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771606329; x=1772211129; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CZAtOD8ZRnarQucUHW7t2nY+Ut5JOEodfHGgZzqPkiE=;
        b=Fz3yRBDqDvnpGkew9ePpYSq03UVNOOAJh7ClVjqaEbC1Rai71/TLTyn+USFu6OYggk
         DYfewZFMOI14i2nEugGH0MJbzjE0+z8BXChGDl9wrmW0/jDGjZGhnw+Odr7Jq15i32hJ
         91XmQee4kR+QUowzVsUJtMErb6ux3eL45sukbTpI6J/1hiAP8NplCm55KwX3m9oe5TLO
         65pPESdOct5/UArg8l3nWCv1axF1oM0P9Sl8xCxUdLdg7NbCBauFaJIZxduuoE6gOzPk
         jJJ16d8ymCT6nrs/fWAW8fm2J8e2N31Bh8fK7VWpkV0CvBXggiaPo03OyfsAlLpkFkbu
         B6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606329; x=1772211129;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZAtOD8ZRnarQucUHW7t2nY+Ut5JOEodfHGgZzqPkiE=;
        b=tF5Tb6DeJec9zk7sgyYHtHqg3rBTh0KUABURge3oo7Q7tl4SOaQmuWaE5zG/6xU2EW
         okaoMlcoKmfW0k78H/d5nzogfJXKtq7/gXEQxkPs9qRVhHxQIzduzZKkllycuTCJ+UJd
         gn9Dl/hKwLgyWVgp8dUgMKu5hoMCh4FCJ9X8YkpGiTq6UDZjIU4qwY/ywDTuxjP48FWo
         JGrmauFLn9WRfTaeHCn3a69Bc0JTsK5Ms54uLGsP/PZe9ntVB8aYuPxFP1LkyYxGoJyk
         L1bzmSuixfqSXd+R9m19+/dilvQpGMW/LMMiecnIYDZ+wF6GQ63VEqPTig+kmUivjx7t
         uZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDdeU/CxEa6ewunXJEl2kD8DBBOQ6uRJ31X80u9Z5MJRRo01M7EzC5EUF1hJtP4Bv5zaP6VQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyghMkfGf7gfCsGWbswKYdl//fDeJwLdYB31taFGhcvmRUHEQMp
	Em6UWGMRLEV0e9Cz9oYFOFuGXTmSz2H7QfmrXTDFVOWKOe6mgFU3RlmPKQehfWPZOwIjhGgrj7x
	0YsaPs7zJe3ichvvC55nl/A==
X-Received: from wmog4.prod.google.com ([2002:a05:600c:3104:b0:483:6fcc:920])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5287:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-483a963c238mr2105545e9.33.1771606328737;
 Fri, 20 Feb 2026 08:52:08 -0800 (PST)
Date: Fri, 20 Feb 2026 17:52:01 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220165203.3213375-1-mclapinski@google.com>
Subject: [PATCH v4 0/2] kho: add support for deferred struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_085211_011713_A2AD370C 
X-CRM114-Status: UNSURE (   7.76  )
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

When CONFIG_DEFERRED_STRUCT_PAGE_INIT (hereinafter DEFERRED) is
enabled, struct page initialization is deferred to parallel kthreads
that run later in the boot process.

Currently, KHO is incompatible with DEFERRED.
This series fixes that incompatibility.
---
v4:
- added a new commit to fix deferred init of kho scratch
- switched to ulong when refering to pfn
v3:
- changed commit msg
- don't invoke early_pfn_to_nid if CONFIG_DEFERRED_STRUCT_PAGE_INIT=n
v2:
- updated a comment

Evangelos Petrongonas (1):
  kho: make preserved pages compatible with deferred struct page init

Michal Clapinski (1):
  kho: fix deferred init of kho scratch

 include/linux/memblock.h           |  2 -
 kernel/liveupdate/Kconfig          |  2 -
 kernel/liveupdate/kexec_handover.c | 70 ++++++++++++++++--------------
 mm/memblock.c                      | 22 ----------
 4 files changed, 37 insertions(+), 59 deletions(-)

-- 
2.53.0.345.g96ddfc5eaa-goog


