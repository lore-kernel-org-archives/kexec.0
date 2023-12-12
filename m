Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAC2C4332F
	for <kexec@archiver.kernel.org>; Tue, 12 Dec 2023 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ddj9htZXQ9nTw7cGZJYOqroaAGkJbJYoS4jWpLCVTws=; b=wt5VhkoUAsBqUu
	L6n8lZ/Y+PCzKn/lQStq4EVeDXVriUYfhKQ0yaqfOl2a7XvoDyuzUNx+HnesT+xl4t0uuR8eGXWUF
	GtldnIKIL1BwAAaGUllFoIxmcALfFhnlPI5QG9via+aHL1xXIhfznOiPdEOdnAyuGI7XsBUXL2glS
	OXUf5r/stRI04kBIZEeLf5iFglojK7nHLfKXmut7pBQrEkPqSG8nQ3nRvpXvgnoWNtPhY05DrbX38
	D3NKHzYkjmh1QG4FXDPKyMnux+WJh5V35oB4ULcPWaBisd9+YUKitwL6Ug3lkt+jcMdj1hPEqChK4
	//XAUFqoXfTpMltssgIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rD3jt-00Bu6K-1W;
	Tue, 12 Dec 2023 14:28:01 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rD3ji-00Bu1m-0c
	for kexec@lists.infradead.org;
	Tue, 12 Dec 2023 14:27:51 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28ad2f0b278so158656a91.0
        for <kexec@lists.infradead.org>; Tue, 12 Dec 2023 06:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702391267; x=1702996067; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5U/p6WhUwXmNbgop0UOPNRNBLfb2DEBWeLZPZx9Wi8=;
        b=UDasY2XCMhJ263p//EJid8UqLu3qJejDcteUC3YqiVwolaYPH5flwMWpgZRb7J9hHk
         M+F6BdhIP6NJonhmxOXnGom+ET80IqU4g/xg4R2Qbq6dx0y2eMkqDRpoMhXudtOUwwFR
         KliGPy/Ql5eSnZR/EZAbbJyNLS5aNMTUsfhcz4lo/4vGDlk5Cngi9o3Km3rfYAu3ldYK
         960QHdIZniWB57ALWgdrdPPEuSf3uBbqTx1kYGnbeOJC+DvNy5LAX6P1rvEePX3eJ0GG
         fy35UDXgcB73YjXzn9FitMAoATe8+nqhmI09WqFoMI55DhefgMTW8G4QEN5wYzlBFpSL
         t2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391267; x=1702996067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5U/p6WhUwXmNbgop0UOPNRNBLfb2DEBWeLZPZx9Wi8=;
        b=AT5kXJLJZ2PaH1W2NpdLjMfSDAc5lLhK2hYvR0ZkqFaaIYGQPmGzbKZJpdpvncYiDG
         boVNAIBYuDX1nr43a2ktANmqCBgxkroByhq1FVGAA+9Taa6FJ7pNW9vJaWlncYb3rBEB
         p6kCtC7arvJbNXk6mFlEWGvzYk+eQHWBe04MMzpquyQQ4c0OBT6xQbwR4Yxu6UWKSG9U
         7OXnIcZM/z5XIFsT4NkAAgUfCp+kgqc71W76xIWc22CfG9by0s85vhn4NDyPW4krXdIQ
         T9emv/tqGCOHFl2t+yX495qdKNkCcKlOKBzABLQe/NWu+nFbN0F0AThowugg0F4uVJDZ
         FZeA==
X-Gm-Message-State: AOJu0Yylji0XkZDhY9GAUpVLhiKRC/GsQq3MPAFrRWf01WlMm6YpMfud
	ObsdsjbBFH4UMrnuITOIeObHDtKy2k0=
X-Google-Smtp-Source: AGHT+IHBa3kIuZPelSkD9/RNYWORbOb6/US7qHeFSWFjPGdbc4L/YeZdicdSYjA1EL9AkBcTfez/3w==
X-Received: by 2002:a17:90a:702:b0:286:db1e:f8fc with SMTP id l2-20020a17090a070200b00286db1ef8fcmr2877105pjl.92.1702391266731;
        Tue, 12 Dec 2023 06:27:46 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id pq18-20020a17090b3d9200b00286dfa09e7asm9156648pjb.24.2023.12.12.06.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:27:46 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] kexec: Use ALIGN macro instead of open-coding it
Date: Tue, 12 Dec 2023 22:27:06 +0800
Message-ID: <20231212142706.25149-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_062750_227832_2CE10E43 
X-CRM114-Status: GOOD (  12.95  )
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

Use ALIGN macro instead of open-coding it to improve code readability.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/kexec_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..0113436e4a3a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -430,7 +430,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 
 	pages = NULL;
 	size = (1 << order) << PAGE_SHIFT;
-	hole_start = (image->control_page + (size - 1)) & ~(size - 1);
+	hole_start = ALIGN(image->control_page, size);
 	hole_end   = hole_start + size - 1;
 	while (hole_end <= crashk_res.end) {
 		unsigned long i;
@@ -447,7 +447,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 			mend   = mstart + image->segment[i].memsz - 1;
 			if ((hole_end >= mstart) && (hole_start <= mend)) {
 				/* Advance the hole to the end of the segment */
-				hole_start = (mend + (size - 1)) & ~(size - 1);
+				hole_start = ALIGN(mend, size);
 				hole_end   = hole_start + size - 1;
 				break;
 			}
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
