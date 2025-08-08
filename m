Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D4C87FDA
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bl43cLtacEaHV/RWtjYcg0CuQlsW0JyoL1eQ6Ei05H4=; b=PtvLuuktAEiyoSYievEapTFVUJ
	VKNjO+91i6mMm3LeBn6wJFJNkXyk0oXe09ElzUlzccyWC8MUXcmY4XPhxv0RLXeriO8i0ZelEep9e
	bjE1AejKcM2ts9D54wZP8f8mvikjum7fxda4XINJds96KNcnUfGeXTeCU10PXWylLga2zPWd4A7Vy
	8EjadJ7Yg5IOb1JNiyxCqxdJeER+q855OupFbODzQ6JQpGwQczQ6ntoGqqIQwEpdE8Wb9IfuUmaJC
	u58BpKo9dwNBWyUrBIrwMcv/OOwINooYyDxJFcNdel8p9/NS9RMOHbdVurgzWAABqW2NO9ogtf+pQ
	aJWyBGPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukTqK-00000003e0w-05DR;
	Fri, 08 Aug 2025 20:37:36 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukTXV-00000003bkn-18Hp
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 20:18:10 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4aeb5eb611bso24111571cf.1
        for <kexec@lists.infradead.org>; Fri, 08 Aug 2025 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684288; x=1755289088; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl43cLtacEaHV/RWtjYcg0CuQlsW0JyoL1eQ6Ei05H4=;
        b=JSoxZKiXBlwhW93+ulGV+8Vb2S7bz/xQ6pD78UeHD50nzHM/VxWhNa8u9rRNjeZaBc
         PgzLiajBMsSG3lRNdy8O1WmeMX+oI1f4SaUhTYNd+uMsWRs54HDL3X16uXsK71yL01kU
         tjmSOw001ZxZhHwA2U6ALQtPcivgD7Wo3gkZiF1A8mnZpVwMp8jMoJ6WTCBjAepxQVjO
         2dITYsYRpvJ5O5J7QYaDxrot9bYDDNmqFvu14QHeGbFHSzyKAmGlgrtun5ixt3cm+h01
         sIo8g3f6yv6pfd6dIOybvk0FF6zzEk0D+nDmBxF3FdtmELO+48k+SaEALHuUy4AMUKYu
         z0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684288; x=1755289088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl43cLtacEaHV/RWtjYcg0CuQlsW0JyoL1eQ6Ei05H4=;
        b=sW+gpT3TK53GSRkbJsYxqmPfB9njLB7wR4QKeadWNCN5ivNhdC+kzIsEz0LjhbKxGL
         2hPTB7sya8NccGYjcnapQS+0HecrSELN+2OOfPsjN1ogj0RuMJpjl6/6bEPPx+8qNkL+
         zNC7rmi/xW2RmYpPC9uoJ11Aj1sPpbBBxeLuUX7PmltySlMgfOvEU1gystimY1qLjc08
         dpVo/FaytehABzOc1Rqx+N9rnNRYQ9zhQqrJpX1h2U35w2fzLSdV1Kqm21XRs6FWsZg9
         l2sJygBgENoH4OaZRtzXWsPMmUbIi4rdXDgWyGWBbjWbhcZkIloLxWzqB1TQuqOuO79R
         ceDA==
X-Forwarded-Encrypted: i=1; AJvYcCX0t1ti0NV7tEig1owM71ovx1iet4hV8GyBZPFt1JJ9e1HWId4Yo9uQ9XA3MK5fX002N0Ldbg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwCRjLzjr+/4rRtYdZ1T+gpGC0wTJtLbcFu3VRE5x4RP9X4Y5bt
	N0B4zZV8miWiaeOArSq02uOKMEnwOrrdTuW6w0/DAe31Ee0zBgw/noHClWgdZaq+s6Y=
X-Gm-Gg: ASbGnctVhs9UuQ1v0s3rLK1+3gWEQg/jRF+OTs5BaBIIfjYI/9wy68zAb/irC4sYNx0
	K3ywnM9sf78Lj4aMbDQhryfsFUCLHymM3tTS7ovaSk0dK3w2slp2p9JO/HhoewQYcPT7157nSge
	axz6HEDvXWMSHrJr6DkNPbDZrV7BjzyWCPa27ZFXL+l53KYLf6DSPXX3qWfrg7Rs1xe2BaIS2ys
	CBKtqU84YRSWYHq75VzgDEnIS96mKzZhxSR1q4/LJfYxVGFfCytxv+OuVqjpnGsfCPMOSSV+7DB
	MakGPO2gyMvKjIzqN0KsyPq2iYyW2vRXBrHRrP/Wj3xP035FWTDUsKsBIOiG71zHXeKp1eU+Dnq
	lW/8Fa7cPkxUs8WFwyDP+JRiLiSXPHFTultVHYVycDKElo7PEfqQ+s60frcLQurzypHW77tiBrm
	v5eS4gW0O9nQAE
X-Google-Smtp-Source: AGHT+IEkycL5/Killw0PruH454l+HlYFvVCGLaFuncloU9u/TMGcBjOQJHVOoRlOgjZJOfGNFrwDZw==
X-Received: by 2002:ac8:6f1a:0:b0:4ab:cf30:1892 with SMTP id d75a77b69052e-4b0aec7c47amr80830561cf.22.1754684288169;
        Fri, 08 Aug 2025 13:18:08 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07c80ddbbsm59490131cf.57.2025.08.08.13.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:18:07 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] Several KHO Hotfixes
Date: Fri,  8 Aug 2025 20:18:01 +0000
Message-ID: <20250808201804.772010-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_131809_306993_2E21EEB6 
X-CRM114-Status: UNSURE (   6.38  )
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

These fixes are taken out from: LUO v3 patch series:
https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@soleen.com

Pasha Tatashin (3):
  kho: init new_physxa->phys_bits to fix lockdep
  kho: mm: Don't allow deferred struct page with KHO
  kho: warn if KHO is disabled due to an error

 kernel/Kconfig.kexec    |  1 +
 kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.50.1.703.g449372360f-goog


