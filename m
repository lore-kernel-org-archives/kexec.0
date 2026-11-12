Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC7606A33A
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HeLDuVr4;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUCJ/Hji
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=oTUZWvCTLZ0AEWIKU42P0/UyH3jve/9SVlOYQoSE1jA=; b=HeLDuVr4aOrf1pYvz1o9KWWydM
	efE6xWpzn7MzUSfQcQnhD+hA0npFAerqyvmtcRtPw9fg/wqR+X9VTRxkCLDOKo1m0TZZQrUfRLoc1
	T+k4GS/TNKQfzJ6oXmXuw6BYigF7vjRuAKY3AleC6ohCIB0EHbFByEhnS3/QnGYLhrHav1aFJzy1p
	cF8l48YrpAOHLqNuPR34dVEaeWTTOhj4qbyI+74ztbSiXDMvY5DY50O3BVyLSzacEYHAgzmI4i54w
	YilSppQt99xF7dwMgHB1H3UsTMAY22ZkYKDPE1wzmwMRQsn3uZsFmkMHObiFeZ1m9y+4nmPOXWxwV
	LENMInfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSCv-00000009YF8-1Ax1;
	Thu, 12 Nov 2026 10:39:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSCu-00000009YEk-1aEt
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 10:39:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CF4EF63832;
	Thu, 12 Nov 2026 10:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2DA1F00A05;
	Thu, 12 Nov 2026 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479943;
	bh=oTUZWvCTLZ0AEWIKU42P0/UyH3jve/9SVlOYQoSE1jA=;
	h=From:Subject:Date:To:Cc;
	b=RUCJ/Hji6vJbi9GeyfPR/yScaM67RJyJ07c4TUAVyvtrt157ri2exqt7V6+EpyBGm
	 YU6yajCa1XYY1SVCLwHTnTFhR8d6f40hLZptj1bimg8BWaMH0AVK4JO/8vERHtPPwl
	 cwdvYENODncQKxL5+xSw8Srk5YhxX5kNoO/2QEp3JKINk0mOc7D6ps84RBtRjDhwz/
	 MTUReUGmjGn2BUh1muigy0WSxMy0MwVS4aCCIO9Bpz+auqEJAQd0vgrh75IYkxaow+
	 0hXzLguDFgM+3DqRUU+WVo4qFXX+MwHn9A95thaTcg8gdaKIrwMyYSPplI43YZq2Gn
	 cBva28lqN3/tQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v3 0/5] kho: fix bootmem sizing
Date: Thu, 12 Nov 2026 12:38:52 +0200
Message-Id: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OSY7CMBAF0KsgrzF4gqR7xT0Qi3JSSQqIjcohY
 lDuTkxvuqUWy1/D03+KhEyYxPfiKRhHShTDHOxyIaoOQouS6jkLo8xWa2XlqYvSxzj02MtEDwq
 t3NRbwNoVYJwV8+OFsaHbG90ffnK6+iNWQ5byhYeE0jOEqsujyNRSWPeQBuS87ygNke/vVqPOz
 scCo5ZKug1A4dRX2Vi3OyEHPK8ityI3GM1vw/1rmNnwqtZQWleUqvljTNP0AjBX9RkrAQAA
X-Change-ID: 20261103-kho-bootmem-sizing-5d6aed47a243
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>, 
 Kexin Liu <liukexin@kylinos.cn>, Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Mukesh Pilaniya <mpilaniy@redhat.com>
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

The first patch rejects kho_bootmem=0% that leaves KHO enabled without
usable bootmem.

The second patch makes kexec walk the bootmem areas in address order.
Otherwise kexec on arm64 may fail if a small area at the top of the memory
is the first in the list, and with smaller bootmem areas this becomes more
likely.

The third patch skips empty bootmem areas, the fourth one makes the
lowmem, per-node and global areas cover separate parts of the reserved
memory and the last one updates the documentation.

---
Changes in v3:
- add a patch that rejects kho_bootmem=0%
- set exact_nid in kho_reserve_bootmem_area() only for a valid node
  (Mukesh)
- free bootmem areas in forward order on error
- add braces around multi-line for_each_node_state() body (Pasha)
- add a patch that updates the bootmem documentation (Mukesh)
- Link to v2: https://patch.msgid.link/20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org

Changes in v2:
- add a patch that walks bootmem areas in address order
- update kho_bootmem_cnt directly in kho_reserve_bootmem_area() (Pratyush)
- don't reserve the lowmem area if ARCH_LOW_ADDRESS_LIMIT covers all
  memory (Pratyush)
- extend the comment above bootmem_size_update() (Pratyush)
- Link to v1: https://patch.msgid.link/20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org

---
Mike Rapoport (Microsoft) (5):
      kho: reject zero bootmem scale
      kho: walk bootmem areas in address order
      kho: skip zero-sized lowmem and global bootmem areas
      kho: fix bootmem sizing
      kho: docs: update description of bootmem regions

 Documentation/core-api/kho/index.rst |  31 +++--
 kernel/liveupdate/kexec_handover.c   | 225 +++++++++++++++++++++--------------
 2 files changed, 158 insertions(+), 98 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-kho-bootmem-sizing-5d6aed47a243

--
Sincerely yours,
Mike.


