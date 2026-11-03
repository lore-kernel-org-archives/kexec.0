Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A136082BD6
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yKyOy1Hj;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fq1rfYgK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=311d7n2dqnSPEAnLl6q87tl5I8DFqOkQSr5KKtyq8g8=; b=yKyOy1HjZgUVdnN8iwVT55z9ip
	LGk3kucv6oaJYjXk+vjagB/BwbyD9aBu9sVKLZXxICt+uxVcwSLHk/5tbEUKIHDjm6BAIWhmT+9te
	Nr1HvPcRNYNBNRSNt77REV+iwG1dGfmrPcjkXGjy6MaIFxELTrtUmyRl6v3rVfL1K0s3KC+udsreL
	AdMi79bY7fnURCKYGXH5zvUiBH/kSwEc1TH1jqhVmrWNrBZtPFjNe7T8dTrsrykBTIgxaLId8aqsk
	PwM2FuNN6lWk4nX2s7j9JKZ47ArXpihmCI9QuRqi4X8WJ1nH542QeUCtnMxOh/3C2WbYN/R7KhkTZ
	3wU7iFWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJ6X-00000003Osr-1YMz;
	Tue, 03 Nov 2026 18:19:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJ6W-00000003OsX-1Vxd
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 18:19:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D903C41625;
	Tue,  3 Nov 2026 18:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C0E1F00A22;
	Tue,  3 Nov 2026 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793729967;
	bh=311d7n2dqnSPEAnLl6q87tl5I8DFqOkQSr5KKtyq8g8=;
	h=From:To:Cc:Subject:Date;
	b=fq1rfYgKXk42I9ToJEzH73Q9X1IWBI2kJKuMUvrEQ77nSva0xnf9nltI88RY3onHu
	 K7iTQ/pcQotwqKX+7eB0AZvkGVaT3W0tjqSbV3FTb4Jt7iDPVp1GaHjPjOmSVXazRT
	 C+jVBJ++MckWwU4WdjJn1dxNX8WRr7TArZ027tWwy2SsBA4oOPMKHtsOoc8D5WYUhz
	 qHAKOWBsViGGU4HsnJKHMIyNaIlJNkLendDJJZE9U5OcNxan2CFopA3mLqgMUa7Kqz
	 G6FVmtWAeKYlO/H6YyJYIRAwQyFMwNvn/DkYO55naShWgbwsLnbCIEB9gfPUtMaR6w
	 g59g4NhKrEQlw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] memfd_luo: keep memfd frozen until finish
Date: Tue,  3 Nov 2026 19:19:12 +0100
Message-ID: <20261103181916.2462825-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
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

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (2):
  liveupdate: luo_file: allow keeping private_data from retrieve until
    finish
  mm/memfd_luo: keep memfd frozen until finish

 include/linux/liveupdate.h   |  8 ++--
 kernel/liveupdate/luo_file.c | 11 +++--
 mm/memfd_luo.c               | 87 ++++++++++++++++++++++++++++--------
 3 files changed, 81 insertions(+), 25 deletions(-)

-- 
2.56.0.385.gac671c819a-goog


