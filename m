Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF30C55182
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 19:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rwuoYLIZuv5ApTNScLZwtjL2AQGWD4RWVJHiBkDbMFE=; b=L8f4zbutH5WwGjSbLN5NrFE5Va
	AOUmS51ChOjUhs/Q9Idl1Br7CfpgOuVkLjdJpY3JzN10nxa1nZgEwCBVpYy+90lcgCvcHcz+OLdzk
	gUXsh0m4pIqRy1smtn7vFwXBXZHtw6lfhd9nGU1uJyagIlF2AktMAPATD7EvEx7rVvKnh99TSReQY
	mCBlmLonLwYKPU3DKCMOT2p8/JgnLNbH7a1UnBcoDbuMxRsIz6OMzmyf4xtaehY8XymjrZzRO6gtq
	JeU+uJDvkXmUruT+nSJFQjZe5fMps+33z5byLfnurC6ibR9b9gT7nCqdxb5h0hL8qMqv95FVLuOo6
	10KoqWPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqyYw-00000000S48-3KDZ;
	Mon, 03 Aug 2026 19:43:02 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqyYu-00000000S3h-0FjE
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 19:43:01 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-92edb12cdf2so241999585a.3
        for <kexec@lists.infradead.org>; Mon, 03 Aug 2026 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785786178; x=1786390978; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwuoYLIZuv5ApTNScLZwtjL2AQGWD4RWVJHiBkDbMFE=;
        b=T/l4yP5cbTt0L0RN3Jympbxtz9napFAkZ6kpTAYoJ+mQQ5XUahrGEUDPR2cEbm/Wf9
         vGadVH5pZTyR3tTX583rDnfQlihKwmCKO7nQvR8+y7/Jh9esqzMF95lDZvOskco9YWEm
         /2E9OXqHxc7wcs8C4JT6DhdKoP7JciaWS9PzSnzsuvj+DqIoujFRjB9W2Hvos3n28iJp
         4qAGZr6fctn93snYdphIxX/PyeYfeFKAGP3w8YyrbTQ8e07Zw1lp4NBDXJi7/R6r4fuW
         WbGny9RbpX0qK/Hei4eNtP30xwc8puBQgyBkJbYIcR0L6P46DTRd+1jREsQvQKcFscBu
         4LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785786178; x=1786390978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwuoYLIZuv5ApTNScLZwtjL2AQGWD4RWVJHiBkDbMFE=;
        b=BpjKBDhHkmc0yVjtKEa8IGPQssRphcDPZNDQUT+NAnERnisuVCC8ypFyzbW0lyWV2G
         VjNcPoCHgvpu2d8t/X1y4255IS6/sb8OAN8aLGAKSpuOQ09Z/FMwG4rZz54icbinm65w
         SQFkkUKv09oBKRpbaFyqRTMfgZfTPPLA4xHDDs/R3cZAnuYE/E12TDHGQ4r/8kd1lFTl
         LMWyDjzb60a9+X9vUge39q2Bhq1lWw5Y7W3bCClXdxuNsRDdzTzu3s/Pr9gwjx3FxlHQ
         06K/E41uqs1wqoUjI+UNymVpyLetqQzHOs/en3lrEEA4D59qC6SQVrcE11Vv2tldanNk
         bFtA==
X-Forwarded-Encrypted: i=1; AHgh+RrMocBF/3eDZhlKbXmHNeaEig4b3V+b8qEx7k+LlTQinwNMQHBTBuF0sJgdwZpxq99S8OA17g==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywra9uC4U+bnQ/a2T5ThmxANwGyVFBupUxN+FAdDu8L7OsIBHLO
	rofN2r2AYe6TEtPN4xqYJAUCfDdyIANYC3yA9AERLBvHzxImhOlp4avS
X-Gm-Gg: AR+sD13wtBm2X/kmEGgXdFPv0aREu4xiTDdrhWMoaOS234eAHp6DOE8CWVUyN249mwj
	0Y2pn0TGVEM0Kv5EjM3QssBXjnipBqtBzC5AKwKas/8m0qRRsn2RadwqJtV6XpXuCn2sy78EB1A
	aZOWAMjShDJxvaYpeYt5YFDpB+BfcIky51e2kMfju/AaF3UvYe6bSECDWNJL+HvLWyxIFHhN4yQ
	ocMdFGgQ71vML96sje10ZVOK9hW/wgy51dch7inFc1MWJWm+/UOLV7cexqnVMfPjpVb/xH+UmDM
	LLvsoREdL506fFK4y7nWTaMZ2jBPTq/oI9a1BayMxRxu1ZP7XIX54Elx5cTK/wPoqp60egZNsGp
	76x0KvUcKCZu1sMYz7ucFBSpjgCihlZqtWAlBpQafvEPB9qq9fMPfec9q/z7h6iw2pri1WOSbH8
	Pzc/sKN2CjZ4KZ5Qtdsdi5mtIUou1slDM2xFmb3VgFmscs+0Hs3IOEuQrX/dx/L4MHFEqRY/u1l
	jAnQ+A4hF/NBW44jVxSOZ8L6/c0ECjLW1/dNpHKKvW6nypLiE962KP6A7CuI3bxpRDgpryJ
X-Received: by 2002:a05:620a:284e:b0:92e:db1f:185c with SMTP id af79cd13be357-934a0aaee08mr2254503585a.43.1785786177782;
        Mon, 03 Aug 2026 12:42:57 -0700 (PDT)
Received: from CW-D0XG2Q16P7-L (pool-173-68-111-115.nycmny.fios.verizon.net. [173.68.111.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349bc25410sm729451885a.7.2026.08.03.12.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:42:57 -0700 (PDT)
From: Maxi Saparov <maxi.saparov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sdimitropoulos@coreweave.com,
	Maxi Saparov <masaparov@coreweave.com>,
	stable@vger.kernel.org
Subject: [PATCH] kho: do not reserve scratch memory in the kdump kernel
Date: Mon,  3 Aug 2026 15:39:38 -0400
Message-ID: <20260803193938.8778-1-maxi.saparov@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_124300_111245_A81D54C3 
X-CRM114-Status: GOOD (  16.27  )
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

From: Maxi Saparov <masaparov@coreweave.com>

If a kernel with CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y (or kho=on)
does not receive a handover FDT, it reserves KHO scratch memory in
kho_reserve_scratch(). The function computes the sizes from the early
memblock reservations of the kernel. The default scratch_scale is
200%. The lowmem and global scratch areas each get twice the size of
the early reservations. Each NUMA node gets one more scratch area at
the same scale.

The kdump kernel always takes this path. Since commit a6715d7ec472
("kho: skip KHO for crash kernel"), the kernel does not add KHO
metadata to the crash kimage. As a result, the kdump kernel never
receives a handover FDT and always reserves scratch memory.

The kdump kernel boots in the small crashkernel= memory reservation.
On our x86 hosts, the kernel and initramfs make approximately 176 MB
of early reservations. The scratch areas then use approximately
650 MB more of the crashkernel memory. When a large early allocation
fails, the kdump kernel panics:

  bio: can't create integrity buf pool

A kdump kernel has nothing to hand over: its only task is to dump the
memory of the old kernel and reboot. Disable KHO in the kdump kernel
so that it does not reserve scratch memory.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Maxi Saparov <masaparov@coreweave.com>
---
 kernel/liveupdate/kexec_handover.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6fad9152387a..53b59edb5b36 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -12,6 +12,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
+#include <linux/crash_dump.h>
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kasan.h>
@@ -1636,6 +1637,9 @@ void __init kho_memory_init(void)
 
 		if (kho_mem_retrieve(kho_get_fdt()))
 			kho_in.fdt_phys = 0;
+	} else if (is_kdump_kernel()) {
+		kho_enable = false;
+		pr_info("disabled in the kdump kernel\n");
 	} else {
 		kho_reserve_scratch();
 	}

base-commit: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded
-- 
2.55.0


