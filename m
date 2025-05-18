Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCB0C3ABC9
	for <kexec@archiver.kernel.org>; Sun, 18 May 2025 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O0JMFpfKRHkWz5dz61vT0gOU2nDX1kBA9SfAMIkNRs8=; b=UsLmjvfuMj6iROLvzOvMe2wFBh
	eqmoxrC8mUaEhwjedHa+f7/8rV2gK48eS8khpj9207M2lsKSL2hQM/i5f52oj+1Eyt98CFPXFes4m
	3dCbjvHqfS7v4JWbpeBRqCz+C7RWxEk9jTRlyqkZFVZ1kmGAOW8gkWFtTKYtamIcJHVM52CMzObGL
	zf2iTxA9Ns/lDBtpsYiDs8zMIh+x+PB0hdIJExDHFomquQuQsV1P9D7cxV0fh7HfqZmAbSIYDOuCX
	T152hJ87kDLzTVJNkuaEYswZYLxyMkU0k9BGSt7Cb+k0eHo//9Jlno1n+cyvyS2QowgRIvX0Z3gF9
	99SIEXbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGevG-00000007BWA-3syC;
	Sun, 18 May 2025 14:23:26 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGevD-00000007BVS-3YM8
	for kexec@lists.infradead.org;
	Sun, 18 May 2025 14:23:25 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-232340ba283so1967645ad.0
        for <kexec@lists.infradead.org>; Sun, 18 May 2025 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747578202; x=1748183002; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O0JMFpfKRHkWz5dz61vT0gOU2nDX1kBA9SfAMIkNRs8=;
        b=uMf5IuQACM9kP6YnTxRq6DY71TnAbRyERto7Dybwq17qZULfJEQfb1ufToFLpzeWFy
         StPH4GDxvR/V49Wn+flQ7WO/7v7cDozp2afisyas8CAR8kBcju3DxXH/ssWrU46mg5/5
         P+3WScNibWCM39rl9l0CyYWxFkIIa35Ger9ICIdFRUmb7Rq/8jhos+ccIyws+3IwTuMY
         Ku6gkFQL2LZlgoECFR2JcwPlTijqxpxnU12427Pw6ZHYHtFnG35TVpNhN3OiUYOIjAN6
         bnj5sY588ACZgeuvHkteK2ytkYeiilgVMsG8YBVNOn7lFXlrWm2Yn4QTZUCzkBWpuWx8
         GBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747578202; x=1748183002;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0JMFpfKRHkWz5dz61vT0gOU2nDX1kBA9SfAMIkNRs8=;
        b=R2430aMK7jhDVpcO/gTZ0Apa8HIj5figh8vXKEp0+W3KHaMffREdlyuDZnte5Du4jn
         TY27jSkccZW9FmPdNEScGo25JsWZbenFLfg7Jqs0L4JyxZzor/Zr5+Ag88twIS/c2n4N
         quWWtxq3+Z3o+Lb18buPU5ZnuTm3WgNpw4PzXdnjzEsMQ0UwXXxeQXpZ990y6yrUW6sY
         lKS4Cx1Giv5++h6750qXIDFRCpXX9C07xF097hMCHQWHW4JCx5OB68SASLDKc5TmTv6N
         IZSY56EtJHq+c/1CUUKnrx1xBFT8cyAzacwNbIbXV63+pS6LXz7PSU1Y7tkakkH2t+RD
         +EOw==
X-Forwarded-Encrypted: i=1; AJvYcCWcuyhuXN98ExCGYdc0SP+KJbMR+g5q+5lfvntCHh+sxq61Z/ttovzhEGYUlgkBZfs6GgbLRg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxIfgWbrnOElLmmqtagyqq6ron7ZwyMlHOqZtKWqLHVmE0/KA35
	hrSVDmBBg+NMd6NUIHDxQHi2FPxRot430CZxl3n2LuGXPdfRLz+yZcF/liXIN1xzE8WlrLx7QRS
	Hl8jzXbC1jitG180EyiwiOw==
X-Google-Smtp-Source: AGHT+IFhGGyS/qpB4ADRzCQh3Eoab9ep25ucby8TNS7Au1zgh1ezVTdpgmmqERacLD7ZZnseES6r62f7/FRo3P91
X-Received: from pllb4.prod.google.com ([2002:a17:902:e944:b0:223:432c:56d4])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5d1:b0:224:7a4:b31 with SMTP id d9443c01a7336-231d4b05b02mr95899675ad.6.1747578202235;
 Sun, 18 May 2025 07:23:22 -0700 (PDT)
Date: Sun, 18 May 2025 07:23:13 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250518142315.241670-1-changyuanl@google.com>
Subject: [PATCH 0/2] KHO Fixes
From: Changyuan Lyu <changyuanl@google.com>
To: rppt@kernel.org, akpm@linux-foundation.org
Cc: graf@amazon.com, bhe@redhat.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, chrisl@kernel.org, 
	pasha.tatashin@soleen.com, jasonmiu@google.com, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_072323_901445_816CE53B 
X-CRM114-Status: UNSURE (   6.87  )
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

Hi,

This patchset contains 2 fixes for the KHO series
(https://lore.kernel.org/all/20250509074635.3187114-1-changyuanl@google.com/).

Best,
Changyuan

Changyuan Lyu (1):
  memblock: show a warning if allocation in KHO scratch fails

Pasha Tatashin (1):
  KHO: init new_physxa->phys_bits to fix lockdep

 kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
 mm/memblock.c           |  3 +++
 2 files changed, 28 insertions(+), 4 deletions(-)


base-commit: 9e619cd4fefd19cdce16e169d5827bc64ae01aa1
--
2.49.0.1101.gccaa498523-goog

