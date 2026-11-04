Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52156082BCF
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SnGCMKkZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8CZWTpF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ZclUos6zhiP0jw7ZtxiOvkyNi6042C1+3TQ0krAy9mA=; b=SnGCMKkZSM0UeGIhfKjyxPIU/R
	nFSYjJxIzUcIPnnHkHmsVEYvDg54LQRWCSsQF8KgKkxzq7EnOE0FcSfwJ6nENVvd80IZvbJkrtHcV
	sz62nn5dVxGRWkgvXILjyr28PBM+ijUiBd12XB0C7XEoV2aMwkA86G+E54G8/6TrhkI1jJp+WikEC
	PFq+pjsEWmzWlXDamFo1sieojZxVFD1SpVjvKWwk0CZeWJh60NK50B4uCgBelr7KfcRPDsHSKAMKH
	vi2a093QE2DpmzAWvqTaZH7HDOAdjf2qUnWUfheONLU5A7VA773mMqbcbUg4ZcC6867zSaRwADRzx
	HdFXl6JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBm-000000066Le-2665;
	Wed, 04 Nov 2026 16:50:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBl-000000066KT-1KEW
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:50:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BE5AF60A9B;
	Wed,  4 Nov 2026 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF50E1F00A15;
	Wed,  4 Nov 2026 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811016;
	bh=ZclUos6zhiP0jw7ZtxiOvkyNi6042C1+3TQ0krAy9mA=;
	h=From:Subject:Date:To:Cc;
	b=R8CZWTpFONfM8ysslHzZ230/S602fbk70oVCVRgZ/TvuOMeIQ7GI6vD87SIXI1mYQ
	 75iazJNg8/NLR9QBUP6Gsh1zib6hm0MCVmcPWkc6vw8AN2/G/sbDJW0SiBMR1FkBUq
	 o9ns2ushtc82dC8yPgrVyBoUTjBudAw//+BKY3NsXznyntZ/xrPyz3TYRMfLiBTuqP
	 DCmw77YRG5DScGSdnyc4fXIyGEjj/5KxcF1lLv1FcPQIdTblIBwgTJ0vhqrALjkeZ2
	 4UftRGr3Z5YeUBFQRB3YeSCLBIty49O0QBe5EkBpLRNKxqoHiz5VPfTvNiKdAAswH7
	 FNtyq+p0022Qw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 0/3] kho: fix bootmem sizing
Date: Wed, 04 Nov 2026 18:50:08 +0200
Message-Id: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ6CMBBFr0K6dpSWAurKexgWBQYYkdZMkaiEu
 0tx7/L9P/PyZ+GRCb04R7NgnMiTsyuoXSSqztgWgeqVhYpVJmWcQN85KJ0bBxzA04dsC2mdGax
 1bpROxPr4YGzotUmvxY/9s7xhNQZTuCiNRyjZ2KoLkWNqyR4G40fk0HfkR8fvbdUkg+fvgElCD
 Do1Jtfx6dgk+tIjW7zvHbeiWJblC3yt8dTnAAAA
X-Change-ID: 20261103-kho-bootmem-sizing-5d6aed47a243
To: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>, 
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There were several reports about issues with KHO bootmem sizing.

The bootmem areas are sized from overlapping views of the memory reserved
in memblock, so on NUMA systems memory allocated on a node is accounted
twice and with CONFIG_NUMA=n the lowmem and the global areas are accounted
once again in the area of node 0. Besides, the lowmem and the global areas
are reserved even when they are empty.

The first patch makes kexec walk the bootmem areas in address order.
Otherwise kexec on arm64 may fail if a small area at the top of the memory
is the first in the list, and with smaller bootmem areas this becomes more
likely.

The second patch skips empty bootmem areas and the third one makes the
lowmem, per-node and global areas cover separate parts of the reserved
memory.

---
Changes in v2:
- add a patch that walks bootmem areas in address order
- update kho_bootmem_cnt directly in kho_reserve_bootmem_area() (Pratyush)
- don't reserve the lowmem area if ARCH_LOW_ADDRESS_LIMIT covers all
  memory (Pratyush)
- extend the comment above bootmem_size_update() (Pratyush)
- Link to v1: https://patch.msgid.link/20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org

---
Mike Rapoport (Microsoft) (3):
      kho: walk bootmem areas in address order
      kho: skip zero-sized lowmem and global bootmem areas
      kho: fix bootmem sizing

 kernel/liveupdate/kexec_handover.c | 212 ++++++++++++++++++++++---------------
 1 file changed, 128 insertions(+), 84 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-kho-bootmem-sizing-5d6aed47a243

--
Sincerely yours,
Mike.


