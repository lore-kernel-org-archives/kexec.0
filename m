Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B64CD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yVlCXZe8SHDSOJUkKVBaYBikNvs5G4Pkl6SfmcOaAr0=; b=H2q3Vayj6r6xExQbsrbws2bXcs
	MNNnjvysi+ezsoIxJM6/Jl6hjSZrv8Y9Xt5LDIJcrnCFNmJuYssqY4PCbeDmL6KipkSGMlI0WcykW
	1vVZcA0yocNFnmDzdc+ksOiKncfDixCC2JBjRk6oV01M4GLnYFsoVbsoW8lQQLP4BnMJ5MOOlX0Vw
	gAhlv+yX/q/LVYIhrUa0Vu0PQ7QdXLv7ixfpJD4KOGWoq1NqQFZboV3xQ52U6bC0LckiCrGajS0wi
	Qnsknnypm/7DtX5kqYwKQIGs3azOAOO1MhoOBj7KSAyu3JoUQFIkWSpcAMSU9gUXBd/aqngb29hG5
	Q0Tt4xsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnlT-0000000FRfv-1iZq;
	Wed, 03 Jun 2026 15:44:19 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnlR-0000000FRex-0uNl
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:44:18 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-9153e2708aeso526363685a.0
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780501456; x=1781106256; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVlCXZe8SHDSOJUkKVBaYBikNvs5G4Pkl6SfmcOaAr0=;
        b=fOkXih1+g5QHVyHqbQZ/YTgigvIoftJHtXm2oxfqH5A4ZIchjmdnPUUgMH/T2X/Vlq
         ugSKB18wQwthGV9OlP5Bz9rakBKNmHR4r33Q/2995qlKBfaf2iWzaQa8I9FbibT9nOFE
         ePOUklvtvBGs8jUtsGoYg3m1YyVTSJ6RWPIJD0rZgA9qP04LT2RhSEjfrN8LDDSlf/hc
         0CPayIrOYqOGj4C1xA03VodePuZGr+f0tjnyZfrJnPEglx55z8NEhc5AdP4uVWzalten
         FLeOekvl6cciDZOJ/S6JYi/G51ftXHknylJLpgC9Qv1MkDqeQ2zPuCjUIQ8z+V/9/dfA
         coZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501456; x=1781106256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yVlCXZe8SHDSOJUkKVBaYBikNvs5G4Pkl6SfmcOaAr0=;
        b=jusbxXyiVVBqFAbBkYzOlUYc1boKePJ1/sZRrBViTp2GVqOzhyNoY2BXGqILu48aAA
         SLU0C5E8/uD6wBY9OyCBNYfpnYt6QDM5Mfeavn9sngKq/B/4pUTvyZvEqfMxbd+0MTi8
         /zZO738xUdOd19u+J6amjqLpreIhzGtTt1uuVAkY+UH+YqlzUmrRkTJOz7XOTlAXXXgg
         FyWl11vc82fWcniK402p2DL/RFC4tVI5tYZXDi5trGnANqampvXm84y7XbHeGE8vYzYd
         UT0wQ1z0cwHqBkDLzsHn20iCJ0OV4mglKB8xwI2/ZwjnT4r9UsC+DktqDToLZoVPHkFY
         fo0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9OZiowOK6j+TkKEjp2dYAfpFj/eLYtxKQnQhLMBJ7SNPR40w44RhU6CiIwNcbMYgDI9A1jkA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwxcY97V0e2RFGB1mM1XNDx3nTYmOSv7wi0wUL1tO0uMSCWjc4z
	J5FlzDUDzVPmNtl+pB3qtH5c/G13Xv/IcpjOwI8mGHmePnT93L9gZcir0cXVpKxBuD0=
X-Gm-Gg: Acq92OETeQzxdWHv+I/qn1dtL2Ee2/GrUnIAcSBpyLGHzb3XHrjXqe8BT6kB/oIXBX2
	QMKPPgYjfwz55AZKOzVvT0NwgKmujrpHmZ8ItPA56wom8TzOY1WlgkOUawcL5SrNNBnjGR3fzz6
	Z3DNIaZEZkr3e006lMYRagTW+EBFfYukVVrmFLQhY1XdR8OPaGcNmVjAZs+dl1RO/sv/2YwiZEs
	iTTWjWyz07puJ0f+6Qfwffueu4wOXSvfp3isyo1raIAKv6Stino5r7TxkPSqAm2Nw9Q39Dt/YvZ
	6u2cYz0I63DdcyIQpsJePUEDUXc+RphsbVMY+KXn9/Ddzxb03mNGALsofJ+e0EhRRSizd/anR/O
	SU3uczOJVQ+A1gcuDI0uQ7TRyK65bR2fphgA9VF6XkZEeaZxWs5Gz/YgCADndROwFKk6vYMEGoe
	rC2q4UKYmA+PnSwnnNirllaMqx5KpcJlqHU1BzcYXlSPlDt1BAC1Ysdqr4hn7x2g==
X-Received: by 2002:a05:620a:2890:b0:915:6cab:768e with SMTP id af79cd13be357-9158a849a62mr658252485a.60.1780501455872;
        Wed, 03 Jun 2026 08:44:15 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a40d566sm266574585a.47.2026.06.03.08.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:44:15 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v7 01/13] liveupdate: change file_set->count type to u64 for type safety
Date: Wed,  3 Jun 2026 15:43:50 +0000
Message-ID: <20260603154402.468928-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603154402.468928-1-pasha.tatashin@soleen.com>
References: <20260603154402.468928-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_084417_252535_7CCCC637 
X-CRM114-Status: UNSURE (   9.67  )
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

This improves type safety and aligns the in-memory file_set->count with
the serialized count type. It avoids potential truncation or sign
conversion mismatch issues.

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dd53d4a7277e..ae58206f14ac 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -52,7 +52,7 @@ static inline int luo_ucmd_respond(struct luo_ucmd *ucmd,
 struct luo_file_set {
 	struct list_head files_list;
 	struct luo_file_ser *files;
-	long count;
+	u64 count;
 };
 
 /**
-- 
2.53.0


