Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0B606A334
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k8ZfNiSK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6KcfDPv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=UdWoH3rxAMjJSmiMO2Z1kLng6PSZrZDHaGMrDeYLQBM=; b=k8ZfNiSKhDzVbGMZBkSbZ9KU3o
	S3PGXF97BdtJg2q6MkJehcXj2tWdxYYzoA9DvkA/dqqcR+0RNmpWLP6M38zMTiVReVTC2jJJVRbdi
	IUrNTFqeHZWB84Yu6tTlE9a62ljekU0uw8bzXDo/drc1mbGSfeebD1ISWZqoOIoMxW+Ly0GbsoSCb
	fyScuHAlpicwCjQSzAq2YHbhbCee5WqCkgSlROiM4GiETLCR98y8bRWo731zYz4olgE2Txb/7uOoM
	UMVHT8lOwAHYsVjsVTifaEpiv3abqqYquXSzUC9h5nS3Rte51OZuMNbUUO/NCJqb4uCRVj8TncKSj
	TH9oouAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQq7e-00000004kIm-37G1;
	Tue, 10 Nov 2026 17:59:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQq7d-00000004kI7-336w
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 17:59:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EDC3E63ABF;
	Tue, 10 Nov 2026 17:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4101E1F0089F;
	Tue, 10 Nov 2026 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333544;
	bh=UdWoH3rxAMjJSmiMO2Z1kLng6PSZrZDHaGMrDeYLQBM=;
	h=From:To:Cc:Subject:Date;
	b=T6KcfDPvuvhcTh5izdDR0sRVp1z64wkzniIfscq3Bjhm8Xpamtaq1jCi92FDfB945
	 U9Fn9MGufVqP1b3mA5j4TaX3UcqvQVa+PmVM/elB57keiEcmVGrmFPefDWP8V/My/+
	 LNqjiNLKRInYv5ofbJ8G4HO5WgsGAAKoN0HsixJRw1zSfWthS5OEojSb7BOOwXRoYZ
	 QU7QMW11vn7ZPWqk39nQqauKgvlzzoD3p92E73oVIq1Hds6Z9C5kdsRaBDTT1hJh8D
	 AZHDC4uUgeZbI4K2M0OmYN+5wyVW3NwVI8oGHCgGa5ZETSEpNij4PTIR3RDPYY8iiJ
	 PvFbFJ2F8krxA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/2] memfd_luo: keep memfd frozen until finish
Date: Tue, 10 Nov 2026 18:58:51 +0100
Message-ID: <20261110175855.2437084-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
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
https://lore.kernel.org/kexec/20261103172251.2348370-1-pratyush@kernel.org/T/#u.

Changes in v2:
- Replace the stale reference to the 'data' field in the struct
liveupdate_file_op_args kerneldoc with 'file', 'serialized_data' and
'private_data'. (Pasha)
- Collect Reviewed-by tags from Pasha.
- Rebase on the latest liveupdate/next.

v1: https://lore.kernel.org/all/20261103181916.2462825-1-pratyush@kernel.org/

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (2):
  liveupdate: luo_file: allow keeping private_data from retrieve until
    finish
  mm/memfd_luo: keep memfd frozen until finish

 include/linux/liveupdate.h   | 11 +++--
 kernel/liveupdate/luo_file.c | 11 +++--
 mm/memfd_luo.c               | 87 ++++++++++++++++++++++++++++--------
 3 files changed, 83 insertions(+), 26 deletions(-)

-- 
2.56.0.542.g3ef89b7020-goog


