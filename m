Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578DAC79FAB
	for <kexec@archiver.kernel.org>; Mon,  5 Jan 2026 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GKwM90KQEG2zxvRr1BMvVFG24XC9eNp4dSSf5Hwu0wA=; b=HoA1dlEZj5rdSmprSeMM09fWUR
	W/qE0BZk+bMGlOUFs/mK48qs5I1uKFlXTjIe90IciLWW4GtahXKvqe8Fv+nOwDr1Oi0uJ/9L1eH6F
	/rUzpWfCILtENystX2q8Qjp/Z/nrVWQLN6udN6GY/ow8RnX3xEANws/uUZymCESAFtc3x2ZfCVyX0
	DbdAWivqF4J8nuLRlstUPIS5eJ5S+ROh7t55IVWuaOwWDqW9egolKenYzwaCJ9ZmCgnDrjU9e0eiv
	9fjPqi9VoiTaqgdiG9Yl/pa55U86036aJfpR0a5AvVC+MI2wfRGaFiMk1iyuolZOi6Sltts8T4J90
	KafmVA8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnux-0000000Blod-39uT;
	Mon, 05 Jan 2026 16:58:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnuv-0000000BlnE-0ovN
	for kexec@lists.infradead.org;
	Mon, 05 Jan 2026 16:58:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B9AA443E95;
	Mon,  5 Jan 2026 16:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0300C19422;
	Mon,  5 Jan 2026 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767632332;
	bh=YLscpyQU8GuaEXJSiTDfKmikNlUhxBYvvwRwG0MmlKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTjPzASm/+SxsMK/4cdlJp5wMwOcjzLhry0vYrO7oo8nmmQbKe6vtidLorCIDj0XP
	 jvjkjfDzKc2sumECtl8YMH/QWq5/4/OgSK6L7LAAcpMwWM2TltyYa+xiiv7pbh2G5c
	 +k3Ib2OYQ2BsKcI+K4WMGg3+0XWR6cDbIDzea2Q3nh0QgciFy16dP31NXHFZ9C4tiV
	 iUUg0RXmxz6umgW2Psmy1ja5JCvwSfkqsZSUH1yjWFNbA7DBS7QZhQlDbVlRtiNRco
	 M/8IZZ3mjrlpq0XlYhvJuvT0jpIDpcFmXING8tRX1bHhPEtErNESHsudsN8b1MXe07
	 wBL3GGOFJihNQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] kho/abi: memfd: make generated documentation more coherent
Date: Mon,  5 Jan 2026 18:58:35 +0200
Message-ID: <20260105165839.285270-3-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105165839.285270-1-rppt@kernel.org>
References: <20260105165839.285270-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_085853_399351_9116644D 
X-CRM114-Status: GOOD (  13.13  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

memfd preservation ABI description starts with "This header defines"
which is fine in the header but reads weird in the generated html
documentation.

Update it to make the generated documentation coherent.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kho/abi/memfd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index da7d063474a1..c211c31334a3 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -17,8 +17,8 @@
 /**
  * DOC: memfd Live Update ABI
  *
- * This header defines the ABI for preserving the state of a memfd across a
- * kexec reboot using the LUO.
+ * memfd uses the ABI defined below for preserving its state across a kexec
+ * reboot using the LUO.
  *
  * The state is serialized into a packed structure `struct memfd_luo_ser`
  * which is handed over to the next kernel via the KHO mechanism.
-- 
2.51.0


