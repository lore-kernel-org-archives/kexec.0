Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6633CA0EC1
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fSz15bnga4zoRgDp622ci0X5CLrX1Thjc1ekKQAUr6g=; b=w5swMxOGRO9MvpQErfSW5Q0vt1
	8unUHC5spw+IYr5FhAsdHAaGghL66GN9HbGjjxtyJJDdML4ZETERa1M6ITdPPRcN5WnWLxhytadzV
	5v6Y/Awp3k3LMvjDHxx7Mw+CivbnPrXYaI0/GNXxYTXvOI2ivMqvFjuUWdLaq/3ZJ5FLtkHDtu+77
	ZT3rdF3bOw3wvSiEPlIdyt605JZJUqq2t0waeBgb7WYktedw00Zl04Ud/hmIEokzxqWf6vzWQVxuc
	f90Fe+1Jk2KHs8m425e6ZE38q/v8Sh/u6151ftwvH3NrJErqozJY1TF1UwswwRoEYR4PeDY9RwTY4
	08z25zaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOHO-00000006utC-2ZV2;
	Mon, 11 Aug 2025 08:53:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulNqU-00000006qU9-1D1j
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 08:25:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A17DF5C5BF9;
	Mon, 11 Aug 2025 08:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC748C4CEF7;
	Mon, 11 Aug 2025 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754900729;
	bh=GD0CZJPipj/scvOiwO86D4QvWu2bhvyPoPfEPeM7R1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVk5V2vX3KTa6TTrst2P85RRH05lSqF0XHkEtbdHC7XoprqtDZ1clLzEoeeQ8KLuR
	 U6PvynDjMIG3Eo9QnHWbTT+EKN9IVGPnwNaBEfjSi/uckjWPQn7KJFqgA4CacMTKw6
	 9wUZQVsVqwXh5eewwvehW8hxHCT52OMZG72LMZ8T9+490eIS1WoY9Rp1p+4OcK6hqn
	 Mzc/g6UG3olKoudsttAg9N2gc/ZMiXq445iE0fnbZLPRIy/im7Pd+LUShSAu+DHdfu
	 ep2YrMSWxgbIEqnKPB/RMVav5E7YKyX8IPyz7mVX+c1mKshftSmB3rxoI1wNbJ3ddY
	 PWpdlLQJ294vw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=DFschuh?= <linux@weissschuh.net>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] kho: allow scratch areas with zero size
Date: Mon, 11 Aug 2025 11:25:08 +0300
Message-ID: <20250811082510.4154080-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811082510.4154080-1-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_012530_372521_76F006B3 
X-CRM114-Status: GOOD (  11.68  )
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

Parsing of kho_scratch parameter treats zero size as an invalid value,
although it should be fine for user to request zero sized scratch area
for some types if scratch memory, when for example there is no need to
create scratch area in the low memory.

Treat zero as a valid value for a scratch area size but reject
kho_scratch parameter that defines no scratch memory at all.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/kexec_handover.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e49743ae52c5..c6ac5a5e51cb 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -385,6 +385,7 @@ static int __init kho_parse_scratch_size(char *p)
 {
 	size_t len;
 	unsigned long sizes[3];
+	size_t total_size = 0;
 	int i;
 
 	if (!p)
@@ -421,11 +422,15 @@ static int __init kho_parse_scratch_size(char *p)
 		}
 
 		sizes[i] = memparse(p, &endp);
-		if (!sizes[i] || endp == p)
+		if (endp == p)
 			return -EINVAL;
 		p = endp;
+		total_size += sizes[i];
 	}
 
+	if (!total_size)
+		return -EINVAL;
+
 	scratch_size_lowmem = sizes[0];
 	scratch_size_global = sizes[1];
 	scratch_size_pernode = sizes[2];
-- 
2.47.2


