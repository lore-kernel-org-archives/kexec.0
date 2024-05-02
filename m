Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EBFC4345F
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4qTDH4t17RsBqheWXaoiaYGdANb/WMpNE7GFoEzz3lo=; b=gHc+TCmfdJ7hFA
	vQ4DRmH4o1m2HKQaUnqyNbGqZ5gvTn50jAA8G3bsJkiZGPo9HL/f6fHVjYSa1Et93yuBgiPF4IQgk
	T0wbLaxMStgVqMYSoSaXJv83slUf30BtkgwvC2DBiuqeKq1pQiwlXcDXogRbDxT9X6EvOovqG8y6O
	uFdjFjJz9JEGE6KMmuXISLWGtdmhcUKfJ6o5BLyEVb3Rf07JyE8ZsJKv4NpjCzPL9SbIn5kwp1dQp
	eio6O96uk+J7EA6t1TXUfy4mNPRBStMP3/0uqxnrH4OCuIGWfHV6yizCDCiDwTx96mZlPYDMpOyTP
	wt6sU1NQ7YInxR0h5tdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2dxK-0000000DxtH-3q5s;
	Thu, 02 May 2024 21:27:06 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2dxH-0000000DxoA-1BEE
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 21:27:04 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a51a7d4466bso975007266b.2
        for <kexec@lists.infradead.org>; Thu, 02 May 2024 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685219; x=1715290019; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxfLbDO1iQp9CdZDyWPw+FjwW6do8u7NB+ZNT2vfVBM=;
        b=dQV+nvUqjaNx+1V5aNJTUqxKS7Nt0L5R0wsupo2BI5TxfSn4ILabribyzpfkOVEW0/
         czXNPsXdxgxgQDNoW9LPwEbehOfmJZ3Eq1cWXY1Kt4bo5qw3JlTlK91rPTq2g9WdaqzY
         bDGoYGfLSFlZ9cxVfLji7qt8B46jQTm8Y4VnvdZPaTIHZ2x0f5PxhJNL2b+IcY9T2750
         uak1QPi7YGhl89xNVHRLLKD3igKmYofkBpO+h8Ok44lzPPRPF50Q/sZWkfrplOmhnuSc
         wMzXtCntmS4gcCebshbRTRny/RfHu49UhVKC+9VtP35Me/0SUQ3L2v5PlwOWrsaAUOur
         TRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685219; x=1715290019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxfLbDO1iQp9CdZDyWPw+FjwW6do8u7NB+ZNT2vfVBM=;
        b=X7rYqI35c6RWvJSrH+2LwLuEJKW/kxgfmeS1faJV+uCxZqmLgsUjdGJjRdptiN7g0Q
         wmTsU7dUA3G60Ev60btMc6Ij7LFenPgzDAfbDtfUdewuIBfTCyTzOQ12eQPTqWAnuzkB
         wIaq3qbPDybsorJjYd6qTr0264YVUeD3oan3QxhnwS3Cz/K1mFof/EHe66sY2WS5DcY0
         VvcICK2kxDvtiWjlJjrzlg+yRpeil7OFgfxIRdkn2WALm4CbkaAPIVvSi6oOsy+jDr+/
         inY6Ne4+2HUUF53UcUDHNuyo+kmN+BIVL3odC2k/rGgbmqJLLQkv2eCKyvVD47THXcIR
         sh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKe7HPrOPSmoH7rgIx+t0RI+CRPdzDCHCf7wHnjyjqRhZ/KOItt4Dtz+zK2Jxocnrop1ZdAaG8BRQvlEBGPGhUftJQLkyk6/Dg
X-Gm-Message-State: AOJu0Yz6ILRQLlx2IqEFNWrzt4IdAFNtm5CAp0w1lc8/nvhbqqFPbQBs
	/BS2xb5yIo9D5E5Gws5jwlUla5LrrAjxgvo588IlwiN6pDmI9XLN0Femy6+Hbz0=
X-Google-Smtp-Source: AGHT+IErvofVOlcBRqerAxB7KV24lTnlqlYfvQ1PtbkRzl2rNuYMLblHiMHF3fUAnpQqQn7VMD23ZA==
X-Received: by 2002:a17:906:8314:b0:a58:a1e3:a2cd with SMTP id j20-20020a170906831400b00a58a1e3a2cdmr379328ejx.55.1714685218619;
        Thu, 02 May 2024 14:26:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 2/4] fscache: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:29 +0200
Message-ID: <20240502212631.110175-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_142703_361157_B3844849 
X-CRM114-Status: UNSURE (   9.42  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Remove duplicate included header file linux/uio.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 43a651ed8264..7b1ad224956c 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
