Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68614606A31F
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PQBjm6Ir;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+sgLxGr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=03p8gBbwhN0/a1fezsMSRz0eiTfq9c/8Q3jeu/5CZkI=; b=PQBjm6IrsgLWlEtD6zjPTSo3bB
	ING9uOaswvjmoPaMnUV8kBrlT19syMSl32sAffpSC0HobI2V19yYLasKPax/squ3j+pVMWej0Ln0y
	xFLkiNn5HwhJHL2peKNHS5Fc2yKUl7rL/t6Jr9QCGlhETvwFBcjFl5l/femJ88iCDXJpQym7ht9Vz
	dGby2trS9lZ3kEeuNaMcgfOrO8bakymhqjrJcqCgewhou6jh+Iddu+Wu15yeq+X+VXIlSKZF7/vd7
	PIHNk04TiDkCjrTZE39ovPDylt6b0L5wXM3zc56ozBK7v4lXdqf9gJF8D+Zr5If9CR3OJ0IyRSbIp
	uTyCiOnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTjr-00000003W5r-0509;
	Mon, 23 Nov 2026 13:05:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTjP-00000003VzK-2XS2
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 13:05:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 461D640095;
	Mon, 23 Nov 2026 13:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5931F000E0;
	Mon, 23 Nov 2026 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795439115;
	bh=03p8gBbwhN0/a1fezsMSRz0eiTfq9c/8Q3jeu/5CZkI=;
	h=From:To:Cc:Subject:Date;
	b=n+sgLxGrJanpQVxingJTfafcfka71+Qt6nGUufSLEbqSb8C5hi48hikcgRmCcSd3R
	 2kmX2JgAD1IGTwpsTWrPfBv6v4IpXO05T5zqSnAS/pZQOabGGJkZS9ZiI3i0qKqVs5
	 OG1b3WshJW1LJRFvij2gwPuRrC5hNDjs/Wn8iCL13dEhLSjMW6SPIOv8QM/SkKOuWz
	 4JyDkcf9S4Qx6LEb/ZpQSXuvzixR9rKeOC1ilXXmzEoWXWp8yhDqI5JRf1f11stOVQ
	 nx8INvW5yPVLHf8Ydp3Upb0cXzEvVOdEgUAK7lsfHS51kFANZaOI7IoMDmcTMItyaF
	 hepOP/5C7Ff7g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Chris Down <chris@chrisdown.name>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/2] memfd_luo: keep memfd frozen until finish
Date: Mon, 23 Nov 2026 13:05:06 +0000
Message-ID: <20261123130509.4032642-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hi,

This series keeps a retrieved memfd frozen until finish. The main
motivation is to let dependents like iommufd have a chance to acquire a
reference. It also fits conceptually: finish is the point when the file
should be back to "normal".

Patch 1 allows keeping private_data from retrieve to finish. This is
needed by memfd to keep hold of folios_ser, which it uses to give up its
pins.

Patch 2 does the main change.

The series is based on
https://lore.kernel.org/kexec/20261123130115.4021199-1-pratyush@kernel.org/T/#u

Changes in v3:
- Patch 2: Document in the Restrictions section that fallocate() fails
  in all modes while the memfd is frozen, and that adding F_SEAL_WRITE
  fails with -EBUSY until finish.
- Collect tags.

Changes in v2:
- Replace the stale reference to the 'data' field in the struct
liveupdate_file_op_args kerneldoc with 'file', 'serialized_data' and
'private_data'. (Pasha)
- Collect Reviewed-by tags from Pasha.
- Rebase on the latest liveupdate/next.

v1: https://lore.kernel.org/all/20261103181916.2462825-1-pratyush@kernel.org/
v2: https://lore.kernel.org/kexec/20261103172251.2348370-1-pratyush@kernel.org/

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (2):
  liveupdate: luo_file: allow keeping private_data from retrieve until
    finish
  mm/memfd_luo: keep memfd frozen until finish

 include/linux/liveupdate.h   | 11 +++--
 kernel/liveupdate/luo_file.c | 11 +++--
 mm/memfd_luo.c               | 91 ++++++++++++++++++++++++++++--------
 3 files changed, 87 insertions(+), 26 deletions(-)


base-commit: 4209b08181c75ea02164832cd8f47526de28d40c
prerequisite-patch-id: e225259e2b7bb6664d8efdf9ca0bdfae24616fee
-- 
2.56.1.750.gf70dc682cf-goog


