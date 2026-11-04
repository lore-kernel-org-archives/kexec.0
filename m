Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45961606A33A
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=B7cyDudp;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=U3bwWk8A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ufPIe0MNsaPL8q21bT+XXMgG6he7MqxkIOdgpkrKFhc=; b=B7cyDudpS46xXL
	lNXcuOxcBPA3Pvloy6oOidpqIn19KgqAXdaecXd/0YZ4uQZoz83DY63ZMm8Uj/f4WeC5iDOX842Sq
	h0nEdL3BuvWnAQVUmXdJI29vjmkSLiIMizQx2AfInM3OAh2eFMyHYk9chYE0ZBxbdde8FVPWrgOAd
	tuU8aLLmPF698O1Vo2goGrL+fa2TvzQ8v+L3M2yyGu4tjPT4PtXY0YOk9aAC42Se7CHSVY9nhZP9Y
	FHkewRhzC+KMtXcgsOJwvVi6jwdcvP7E5EzfkQmI/iMKXjlLwgZSL0Qtn7lF/iUqUbgdP24fojAwW
	FeBkQG9qh2nxsQ18sI/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOj86-000000077fc-0n2N;
	Wed, 04 Nov 2026 22:06:50 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOj83-000000077ep-0OpI
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:06:48 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-5eafb65e204so398730e0c.1
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793830006; x=1794434806; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ufPIe0MNsaPL8q21bT+XXMgG6he7MqxkIOdgpkrKFhc=;
        b=U3bwWk8AsV2hbL4H2kHPbZHC3FRd8yqLNT4hwpaIJIjJT4IADiAFf+FCgoQu0eyT2I
         IFvAzk9m8lvD/VpTIRo/C10aeP6b2ajmmr1x/HqJLg6YfojPb8FQFe4r4Dpy7cqE86FS
         UTKR2uS0p1bR7o4PHAzrek2uz+JTggUjFIp0Dxq8dCItc9aFfUl+pv55fLrAwNnYsL1V
         d56Fm7gs3X+ZTNL1eYHTFMsrCLZ2KmkTDOjkscqoGULqNGYPqSmyDU5TxKGeyQ2f7ZYd
         OqSpiLSz8hRoUVBYciw9rxqqQ223Yjkkm+kmEgZrrOcL/v5K4HbotjQjgAOk8mEQ7146
         pYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830006; x=1794434806;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufPIe0MNsaPL8q21bT+XXMgG6he7MqxkIOdgpkrKFhc=;
        b=wOn1X4O39o5KcOMfZmEuIe09srq8Jyhzb2eb/fbR53yO0apVPXzb4WF0M5PLVoAg0h
         iLTlXxu6bVZfRfCn4tBj1hyNdfDPE1kTC+IL1a15Qchjx67LPyXAoG7PpvnwgWXOv1FZ
         qcchdE9l9++HhLMcdVK7WfnJK5ib4tePxUMAnljsH2x62JSQ9EV3qxaU2oPuNx4/+ZGa
         5Rw9HG7+ceE0hkMWdhxMI821tRQ/dQ4NI3tcUO1xLA7v3Rs8+C1h6wP0g3trtAq5Ft8C
         3X252YHKVnbp1/yEXUtgU4ZTnJQB5lVoHT0W738HNhukbkBNSZoDVEkHqaX0tgYw0dqo
         F4Qg==
X-Gm-Message-State: APuU4Z90Cur4yOEDwNomNC6mBDHoTCGOTElia1iwd58ghthOy+wH5FUV
	+p+WDFXpqCLPCZt8xVxlQkQzVVKUsQUwFiMSzViBcaq8MewdjNjxgmgTUdB+18+oETw=
X-Gm-Gg: AYBFou2nil1kbqW6t874U21UrT9gFXDCHu593jY4ExkHi4DcbmwK/23ggXEhn+Trm7q
	py9UBzJyBcAr/YIky/B5K815GxMPkOSutf/6Jswr4TIE9T4NH0Bm5Z8TX8uuvO2EYT4ql0QCPGw
	MHMXB/YRRJTyKFsQja+BVu5UybfHR32SEy7KDPZ/6i34XpK253lQxgXxME08ybCHhaqMQpOaABY
	yTpjbs86RjT11RyP6NXF9PtInmsajakhsdjlur8AOvhElYgVEHSEM0mSF1Sq5alCzM6TQgFRMtX
	zWCX47zjFl3NlmB4hlzSqI4tkJmx9E67Xqh360/pvtHLXwOfADnBmLFYupw63z4e0jEgzJk+mGp
	jSbqGwWSVgaHsjyPALKvQtUDSizpservs5co+cl+sI8gqJHE6dXzIHXDMstl67PtpWRvAR9qtxA
	SXhZt2WETm0DABNm2kb8Ta/PA7G2ZIpMgagBbuVLoYu4Xj6GqyV5yjOlJ1N7jBZ3AD+Ds/7wli+
	EW/H8zwrWOnnQfYS+wM5OFNmPCWcMVCuF9tOW5Xs7Yu2sHzubxTOGceNyLxLNk0n24rHhtUx4Ch
	8hqyYYgcx/us4m4IlKzy4BD/OBJ3uDrIwSw11B/Gv7U7bi7T0cUTWfbcFjIBYNHq7lgdHQL19yA
	b3/HBHsq2KdCzjLjy+BEItWDXBmriyrhSu6QUyceHLiyT
X-Received: by 2002:a05:6122:310b:b0:5ea:cd4f:8494 with SMTP id 71dfb90a1353d-5ec6897bcc7mr7448416e0c.16.1793830005585;
        Wed, 04 Nov 2026 14:06:45 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d774dcsm2714498e0c.5.2026.11.04.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:06:44 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Alexander Graf <graf@amazon.com>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Changyuan Lyu <changyuanl@google.com>, Thorsten Blum <blum@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261104162352.140836-3-blum@kernel.org>
References: <20261104162352.140836-3-blum@kernel.org>
Subject: Re: [PATCH v2] kho: Remove redundant 0x prefixes
Message-Id: <179382998668.2089669.366825701461081981.b4-ty@b4>
Date: Wed, 04 Nov 2026 17:06:26 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=328;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=bxNUDneQzMXPopJ3U7vhIU7tZ6OZ2ltQlUaSDgbGkI4=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq66xzJBj4jQ6s4ffhsZHum0EOCVZkmEy4vpG9A
 nhdhvRi5laJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCauuscwAKCRC7dyhM23N6
 3rRdEACF+wDzWW99SGiwMwtuFbYT4Xc8ZvesuZt8wZB/qXnZR9gyJwdjXVibGieISJj+fl6WUDX
 UkzUEhuFemIAteJft5JUXzw5Jhe3JgGpnAFYg0SU8H0T4dPbInWmAilKZelqYn7D9BVgYBSG7GA
 aQvPIffpelgiK7WaCG4gGC0xpfVgmXtRU9RaflFlCkz5aEI12rB0FvrBr7gvroAMK+ubgFt0iEO
 pGIdUFoo7xToZiowASNJVpJ/KswWmLvCUVQ2XGnZWcxnh7K9dFerjGsHUFUs26hTErZkHs1QXFj
 zEFKgGKkpNzboYk3Tw5iU4ZglLYChRoinFSHoW/bWDPRBGaoHQCy+aATI0bCZI+YxHprqo2bBO7
 z/KwoFQkgLKzRangEXnpWYPbbKiEmgt2zCBymSqriEKoDo2QTGLQKtal4UgAaxzigcB86bXF2sz
 qVBocvbZh2yO2ZEGxVtinU78W8oDexbm2Qfsg7/xyEmsdJZtg+6ngxT4nOApFfDxFe3SM4P5F42
 Weyraqc+tx3+G1m+sE87IjwSdxaaFy4H7+lRgvydBx08IeYpmySIeBSZ/LhUniQK4a5EDN+B8Y9
 DBVRDKSi47qHOkrchgjFCQfrs4o0kHLVu5NzS1dXnv74ycFcrz0ru53V5iM9nJsd/HVLzr/hfYX
 A+FxXGiWAnGQceQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_140647_143742_422477C8 
X-CRM114-Status: UNSURE (   4.32  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 17:23:53 +0100, Thorsten Blum wrote:
> kho: Remove redundant 0x prefixes

Applied, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=fixes

[1/1] kho: Remove redundant 0x prefixes
      commit: 3cf66b39f560257e77f422d9fc73525ee2c29275

Best regards,
-- 
Pasha



