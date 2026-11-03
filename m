Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F297606D822
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A37y/5RV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyzLButy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=twt8xyp/PjuLOlMXlHAivsnx0jkVr0LdLW19Gs2AtO0=; b=A37y/5RVOXM8uZMapHpI4InbZu
	nmYnc4mFbEZ0XHp+B093nejWrZbZRnmHY/xW4DoYsgaQqGcMAniJN1UvHXQjIQ5LAMVQC8wppFK9j
	Pqa3KHIOCLRxaKe0thsLm62YlB2RlIJlXdwu3zTIAUBWiyKv+VQXNBwJAz8JfD5lO4J9xEGYoyZ03
	Fo1XXdm7e50haidNMy1q0Uk8Z4MV+C5GbdH535cGzr3wzZ15l4RU2ObBunJ9DDXpH93ulN7fn9lf8
	uyLpORwVLMq/ycv+pOrw7S/sOGdb3nmGdznoP1HsizBxKz+pCSKInMOvc42LyWCHOb878grUdPU2M
	uT/TPSYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOD1Z-00000002H5m-35oO;
	Tue, 03 Nov 2026 11:49:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOD1Y-00000002H5E-1vX8
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 11:49:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC2C643B5F;
	Tue,  3 Nov 2026 11:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A851F00919;
	Tue,  3 Nov 2026 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706595;
	bh=twt8xyp/PjuLOlMXlHAivsnx0jkVr0LdLW19Gs2AtO0=;
	h=From:Subject:Date:To:Cc;
	b=PyzLButyVIP9s2N73x/7CD4RsthvVm0yhg9NB9mJIJEVW3AC9qYF3D/4UL63y2P5n
	 SqKTUVJkDulKszJ1WG+cseu48umKgXQlidqY/+KJJGYHbD/d2D1jvVzDpm1Cer33CB
	 zKqRyxEaYi1x/V8LAj5hMl0pnkvdIMaZF3nZZQLBUFsUYmsOlJYZJ0R53/gLx7AgM2
	 V77gJB6YkslcOQtrjBZ/ow2B6qUGcS9QSgD3NAAX8KWREIOfVh+7GoiwHFF3WJUB0z
	 yo3Jb0IJjP7nD4PF0LXi6OdCzoRjj1y3losd2DhClyZlw237SXIIcxRR5vy+bz/ZfM
	 w1TZmK2lIDKKQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/2] kho: fix bootmem sizing
Date: Tue, 03 Nov 2026 13:49:48 +0200
Message-Id: <20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw7CIBBFf6WZtcRCa038FeOCxwijAQyDxtj03
 wVdnpt7zgqMhZDhNKxQ8EVMOTWQuwFs0MmjINcY1KgWKcdJ3EMWJucaMQqmDyUvDm7R6OajVvM
 ETXwUvNL7Fz1f/sxPc0Nbe6k/jGYUpuhkQ59yIU9pHzVXLLBtXzJtQn6WAAAA
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

The first patch skips empty bootmem areas and the second one makes the
lowmem, per-node and global areas cover separate parts of the reserved
memory.

---
Mike Rapoport (Microsoft) (2):
      kho: skip zero-sized lowmem and global bootmem areas
      kho: fix bootmem sizing

 kernel/liveupdate/kexec_handover.c | 142 +++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 70 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-kho-bootmem-sizing-5d6aed47a243

--
Sincerely yours,
Mike.


