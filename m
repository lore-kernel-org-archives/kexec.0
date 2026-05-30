Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D57ACD6E49
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=087/smJrDH1Ri/FmSC9bbtTtLl+ESvDrae9U9V2wtSI=; b=uRIwBuyRc8t6i6src1Q+A5X26U
	gQQn/GvAo/jWyEI+6Az6JmEj8AI7F9TVO7quoiq/ZinAzJ6fbVYX/cQV/QYkVejVNE3hKqutfLjSM
	+9smyXqTPa51605DgohM2qCHAkNdya3dw6iQoZLChMj2LbyV/JVquQwpgoEMwltMeAJd42bvTVbaE
	Ax8dz2KGiaKs7u0U7l7Rng3WcHF3wfGlyzzARzzgHuTrinl3eICb5F/goQbjyrMYmvTyxm8Wu65ln
	KFcrpqZFNZYLsgPbxhQ8cHAV7os6zBD46DN3M9qB7Xty+jZQYj2Wuu5P8U+ue1c/JSSRRe+3ptfRP
	CtcZb01g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS1z-000000095ic-0e0p;
	Sat, 30 May 2026 22:19:47 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS1x-000000095iA-1Q1w
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:19:46 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-91550dda53cso32268985a.1
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179584; x=1780784384; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=087/smJrDH1Ri/FmSC9bbtTtLl+ESvDrae9U9V2wtSI=;
        b=EOTK0q6naDxTdQNiTYA14tB7djbH8uA2w/tNby92NrhQ7k4az93B+AlosivZBC4C84
         YO/iZVw36spvxu702r1v1XUo4nLGmTLBFFnSvhsxTl25NwSvSJwjNLtqVa97s8TjYTVk
         wvSCpGwb5pe2x2GV6OjEFyqYEP0fIHEStPU3S7loavLw3Mxyh+9Lp/erkhz4ZUno32KI
         P83vhgG/mlA5vCOnIJeumsz5qEPGhc+zlSOmXo7TC7lfuVYOe+9Utm88aMxlM/cWVamD
         y4AXwe+mTzSmquTl9drz5wpp5qgUlDnpVgOafFFst/Oji1vF+ekw/Pc0V2+T3FbhfbP/
         axsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179584; x=1780784384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=087/smJrDH1Ri/FmSC9bbtTtLl+ESvDrae9U9V2wtSI=;
        b=ZTv/gPcoa83UJiyNCDj///tVtASSjhhBuU9Y9F1bc2ZGxI4BS94ijXEf+xOn4hvLMW
         OIt1BMTiNsWrrymiP3C+gWnn1lfVrLOrKtmr/vo6W8EtReXnBSRM6MThVukhb9dEWCAn
         oNye3rCxw04TQ8EHbF+WcqLdn16hv6dlTshYYGZAWYArqsPkGNkaZsgWdCROpJ0yUhpy
         JJrzhWQVN8Qi394h2fRT/h1C+5ynFhkPtObWEks/fwKvT/VYiyBQ6jcsmWMq0m2VPVrM
         yfCyQr2VeIt6zQ1jNu8W0m+Y5JB4VZNxWxaSpd7A0euGmMomfqJhVYU8YoPxWWI3yrnq
         89ww==
X-Forwarded-Encrypted: i=1; AFNElJ9QLg5EJAPMoFvMlNG0MxQoS/np98pS+UmzrC4zS3kdQ5Ed3IDJGkFSV4BtJ7qUxsYmM48x+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyYhY26/JwhYMBu99lnv0XNnM5e1CwkC8C1MiDTIvYrr/JbEGxx
	6LcZJcZ0Wavdvx633xUE4Qi7UQr7uxtPAvoVwuaKJLaI4sQXauQEHOa+6ur6lyBtCw4=
X-Gm-Gg: Acq92OFIjsjGEH4H4LgWMIQfWktT8tbVSslizotaUCAB6tb8ZfCrsfJbDip7xd0JTIi
	dzaS6AUSsOH4oSH2pG57dxXO+Fsc10lzNp43I6aGSs+ezefU5D6WBNFjEKvne0xgm0ZyNn2Dy09
	9GspXyf49bb0p1BMrjdR8SlEOt2j8qNrOmEbm7/OYkR/ezcxlBBm9kkcCMPxhWJ9pbnjkvPkA6L
	arilPcQ9KSGIBu5MNo5XqxgmEiHqJT6zbZRQW02W9828920KWIK78dirOPXP/NBRLX1FCfGn17M
	WGXUDYjHLzPN/mdnazxos3x4JMsYP6hPahXzr62EbXi14+ni4u1zs37h1PUhjrq8mnI/FvJccHL
	bOU099Sw1vKKgVY5hj1IY4b+NHsu3I5oNSu3ko4UVwUBgDPQUQV6K6f8YILea7+DyYUrtgPN83q
	puUwl8Z8s4WSugftOdCeyuMm28cz9WE0gUPTvH5sok6CGcBUtJgxd5u/Z+wwAPPA==
X-Received: by 2002:a05:620a:4053:b0:911:449d:98c0 with SMTP id af79cd13be357-9153d9cb08emr793370385a.7.1780179584086;
        Sat, 30 May 2026 15:19:44 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:19:42 -0700 (PDT)
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
Subject: [PATCH v4 01/13] liveupdate: change file_set->count type to u64 for type safety
Date: Sat, 30 May 2026 22:19:26 +0000
Message-ID: <20260530221938.115978-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530221938.115978-1-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_151945_379189_5890536A 
X-CRM114-Status: UNSURE (   9.53  )
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


