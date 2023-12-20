Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D42C46CD3
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 15:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eDo013NMqDChQNC7zvAnuXB8DPSoIMW9rQD9iS4nAB8=; b=ZsdN8VI7eCor0d
	AHvqPFKG9HjiDM68varqlKBYT/Qa5tj/Ay7hKz9WGNUK8N1VNc7dE4xivv/wqftYC3acSDma/cbDC
	En5fZgaaDKKPfvLcBlt0JOMjMa+mx6PJF5ZpGjI1o95wmMw4E2FHRhBztdWz5lgwq7vswOytUPO6c
	HNHeF6nAHsdJoTh9um72qELNsxdzCupROqTxVlLJIE4zH248P7bsH1QiNJbypHa18FlArvsC0oR2g
	NdjXXWakvsuoq1dOfyZUe/iex1/q9prbIQTl6o/SNXDzpyS4zXM4MaL690odSYLIXGncUvTgLNtCS
	mXyfoyImKwj937U1lS5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFyhf-000HhK-0O;
	Wed, 20 Dec 2023 15:41:47 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFyha-000Hgx-2d
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 15:41:44 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so28478825ad.1
        for <kexec@lists.infradead.org>; Wed, 20 Dec 2023 07:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703086902; x=1703691702; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9mFvLLx7lZ73kFF3I62j/aGFgf0ra8eVik2ke1j8Zo=;
        b=OAqsGYUr0Ux4H8gym10Hr6r2nZf8B/t3v86YWHqkZH7SI6TBYtW+VIBbykD6ursPqt
         tNwO79Jxvz+pH5IOcFLpHMwuKfLUZTZ2VDrX+msDbBwB7A9tGMLlz2LqmeTAtjAE/gTA
         qctINPx9eWaXerK8RR55aMVWwom3xwTXhDSYmxJWpX8fEk60McBmdSn8OU0oLVHwh2Sz
         fj5Q5ScM0RDoFvYrDp7/z03UXe9FG7vEC4NPDqcwBd1n19dmJKrPGrKCoOjPW1jUqsi4
         XhZ23JLkJr8vUpbudAA+bHO+4yCu0pn3HZxfaJH7f9T6J1f6FHZyoscdMci6IJrTiMFH
         hnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086902; x=1703691702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9mFvLLx7lZ73kFF3I62j/aGFgf0ra8eVik2ke1j8Zo=;
        b=ZzrpUsoukuUM8aK8WUxSBjfxiqANizAT5Dit2okjKXaQB0ln1nHZ2XhfkS7QtWKkRJ
         VKsem+JyGv3GqMKrTZsp8/EwYfvTc0HiveUzr4S93yvIQ1hHQR3N1BYNhzpTqWxO/tyh
         n7i0zATVoQ0LZ++ZfiqYZGaI4crx0QfxfbqOf/sd8gF1MVIQ2kB50lcOR2Wuwziemb5g
         CerIdkS8cgLYGAKPH+g1eRodKruc29dcg379fqTc/EmI6ulkKlkDiAuvh5pvRM6X36r8
         UQR0pURmtF9gHsVmw9NTl3ySnS+YmBBGR9xDY8wIisGrSYVpgVZjYb5rkQnJS3dSA9nu
         iKNA==
X-Gm-Message-State: AOJu0Yz74kBJ16+TmSkUexfX7+giFrGmObjCrr7Uh26bwnAzYJ4MrvVm
	ihMxNu1cbNbuu/QF4e2taWw=
X-Google-Smtp-Source: AGHT+IE9NTARvHnxZGa80VQ2zRnWB2AD5Je+ZSkuhee+chKhEHjXud7Dv94+MDUssChXgrMhzO7Gsg==
X-Received: by 2002:a17:902:f689:b0:1d3:b35e:7b16 with SMTP id l9-20020a170902f68900b001d3b35e7b16mr4559002plg.86.1703086901632;
        Wed, 20 Dec 2023 07:41:41 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b001d07ebef623sm8790083pla.69.2023.12.20.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:41:40 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/kexec: fix incorrect argument passed to kexec_dprintk()
Date: Wed, 20 Dec 2023 23:41:05 +0800
Message-ID: <20231220154105.215610-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_074142_851949_F166237E 
X-CRM114-Status: GOOD (  12.84  )
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

kexec_dprintk() expects the last argument to be kbuf.memsz, but the actual
argument being passed is kbuf.bufsz.

Although these two values are currently equal, it is better to pass the
correct one, in case these two values become different in the future.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index e9ae0eac6bf9..114cb690ec0b 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -496,7 +496,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		goto out_free_params;
 	bootparam_load_addr = kbuf.mem;
 	kexec_dprintk("Loaded boot_param, command line and misc at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		      bootparam_load_addr, kbuf.bufsz, kbuf.bufsz);
+		      bootparam_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	/* Load kernel */
 	kbuf.buffer = kernel + kern16_size;
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
