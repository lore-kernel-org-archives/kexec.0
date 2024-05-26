Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A1AC25B75
	for <kexec@archiver.kernel.org>; Sun, 26 May 2024 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SVO/UEaZvqoceZ7oE8Uu/66sELEYVcjyFWXLxyEKdxY=; b=O/EOlRJC/zaLsS
	57tsrgCTm6r0ZuVEoPTsgW6dYEnMx5c8CzAN9alDFzzhUwZ4lRb8msDnn/fgs8oLru1TK5n0zZsgL
	EvSIgbx1AeiaEXdoj8nKCOXpIvpT3o6scXCpNmbePtbLrV70JxviKQqMl4DhgteDP2U2OhHHkOeOW
	FBSWwkn4ocOIg6Fze3pLEsN511yblDhYejTiUON7OzwsKHOYSo/3yg7cLvNsnfo+ZXIVJeWYdjMTb
	TXYAKWowPh0gUMGQUaFGlZlkdVV11PGGfCxJAzfhCGe9aKPlvexohxA5tgmPwW+4QibEy7ssNQLYx
	Vv2DWnkx7+8jjKLf3tiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBLJM-0000000DHck-1p2N;
	Sun, 26 May 2024 21:21:48 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBLJG-0000000DHbo-3qCZ
	for kexec@lists.infradead.org;
	Sun, 26 May 2024 21:21:44 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4210c9d1df6so13522635e9.2
        for <kexec@lists.infradead.org>; Sun, 26 May 2024 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716758497; x=1717363297; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrZS6a+2WmF7PbI/Eek9PooMML2FIBwy4rVSyH7zOdU=;
        b=obVIwBEzcDCwOvt/QzG1ou5AAeSxeZ4MCKG4SajiipdHjor1mo6AjZH0oCv1PlBO2I
         ItP7Aw108YbTbcHHa4FZn1oDK+zM2w5A2aWTtFCQ9mMH7DkqGI2psPd7+d7KHjkKVdw+
         XnNZM/XEIycvybfO1skUCNI1fDVV6TruyNEIwEMpOIw1PgQyVOojbEIaznl08dzMM1ci
         KlxykTYHm9Phd3cKYmt0Ac/bSbjwCs7NpCOQckFuAFrN2ZNPQA2E279sCcTtWn5lyFJ8
         wBuhgAAqdmcqLionoYmqbSfklRZMUyrvEVHeexPsAJe1jbo/DjN39W6efYSxwHjgtYQC
         ElOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758497; x=1717363297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrZS6a+2WmF7PbI/Eek9PooMML2FIBwy4rVSyH7zOdU=;
        b=poFkb8f/DWA5A0p0p6wsMCePF4pFRdx+JZjj7OHMPELZPJti5ksiS+3z3AQEhlqLSW
         4vL3sxy3pDTbR/Ehgt5FJWsSYBrFVhGQnG9cWadbD8riX1LCpMVS3+I2oubNVPIP2ABA
         oZh0ZEAPeG87VVHr3KM8OKvNineSkdn1ELIrZYIxUet/vvU6pSbc+jKEa6vinRY3ZfnK
         hDz+PQB7THGO0RI44eoeYIQ/YO5G2jjdAEbUnqDi/NW6YGJ3gUB6/PNRCDFvPuSpHUSV
         OQkI4FdnwV7GFITPIUDENTTwMOjwgi9JvmxSPDk3X3B6ZI0ldkBrVExdyIdZ4kbn0CUP
         M9gg==
X-Forwarded-Encrypted: i=1; AJvYcCU5wxhxEys/GymM79FPwT0zHi2Zq86XIXm+/8nB4WmrkbTav3bGkElDYH938nMeg5lAeiGVpAZNabFaEWDk8tjB1IICJVjXfUeL
X-Gm-Message-State: AOJu0YzCnsKLKep/YpxW2kj4uoWMgWEhdfjQUaJcI06OmVlV4stiMO29
	cE6BH0uYBXStcs2BPgSOMmlM0NCXUqxlMZtVrJQze3pejJBKUqGTQx+0jUwL5wUuB5m8VtyV+Ef
	qQ1I=
X-Google-Smtp-Source: AGHT+IHW4ae7lxNWn2WaLCNzfX0cTLfvfU9RcG3UisSM/eMD5CFFw81oCKu+GmqWICgbek/bKosQUg==
X-Received: by 2002:a05:600c:6a93:b0:41b:f359:2b53 with SMTP id 5b1f17b1804b1-42108a14eaemr57525155e9.37.1716758497510;
        Sun, 26 May 2024 14:21:37 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ccf32sm87534245e9.48.2024.05.26.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:21:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: amir73il@gmail.com,
	bhe@redhat.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dyoung@redhat.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	netfs@lists.linux.dev,
	vgoyal@redhat.com
Subject: [RESEND PATCH 2/4] fscache: Remove duplicate included header
Date: Sun, 26 May 2024 23:21:09 +0200
Message-ID: <20240526212108.1462-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240502212631.110175-2-thorsten.blum@toblux.com>
References: <20240502212631.110175-2-thorsten.blum@toblux.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_142143_022805_7C69EB06 
X-CRM114-Status: UNSURE (   7.92  )
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
index 38637e5c9b57..b1722a82c03d 100644
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
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
