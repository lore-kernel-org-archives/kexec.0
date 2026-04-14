Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CFBF9D0C8
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K8w0UbPsKgFPntpJSDcyPSMGyXgpJ9VXRNUC32rQB2s=; b=pHUtBcfIfQWXi1guqA2j2ASZsT
	dBWCrzFL2fbZDlvu2UWSf3THjQt33eYFIW67mUHpqR296TBodmemmOcJEfinTJsDbkyyGvYqFi+An
	P2g7hrSHwO/xNnrwKxNTjE0pPMOgKZvFUkq6fjnDEwvbr+pXUlYci+P1Gt2UB108XD9Po2KW8TihQ
	AkVKQ/r/ZnaYTp+Nla/LYgC6V6R1Esgz28hRJyULw2jZCmFfW+P7yoAHmnF8QylXrP4rI8NqTQ7wZ
	s8sQOwC3UDX6mMIo9kBv3vwxH0OGAw8I4bVFoNGuARoTyh4GEp2JWZhfTvoltAi+t63za320dxRkZ
	vrAgajlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCciT-0000000HHty-2aUy;
	Tue, 14 Apr 2026 12:18:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCciS-0000000HHts-2KYv
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 12:18:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A63C7600AD;
	Tue, 14 Apr 2026 12:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4659DC19425;
	Tue, 14 Apr 2026 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776169083;
	bh=CEduHNMB+bD8CU8dbS+YH2K40akHOotLIUiWGX/S4PM=;
	h=From:To:Cc:Subject:Date:From;
	b=VXQ8pWQfTRkHQEgHdDFbC/k4+PBPqOYgALtjJABuAKg7aZ8MEKcFmPs7o45HoD8Nx
	 y5c/gH2ENkCnmUsym6nrpHPMJF5aZQuFGbgYlB1XZC/cDWmVo5GBiJXvJ2zugYa2Qz
	 EkS3dHrmDbWQAtyTFQwkr6K3dcXt2z4wIBfDXRTdDWWop99PWAfiehUtbR7UUCL9/i
	 sBPoAFeJEF6vGkAqLbMFoUKevcmfY/yvsN7c9ijiBwmuYB/6iRIlT5CkD24Bnt5sMJ
	 qhDEfLZbQmAp4KFZyccsFTSfFER2VSa2+U1RhQJOvD68uOYrGlUu24x9LT2mGx4H5F
	 LAuD2RPNtbzKQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] MAINTAINERS: update KHO and LIVE UPDATE entries
Date: Tue, 14 Apr 2026 12:17:17 +0000
Message-ID: <20260414121752.1912847-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hi,

This series contains some updates for the Kexec Handover (KHO) and Live
update entries. Patch 1 updates the maintainers list and adds the
liveupdate tree. Patches 2 and 3 clean up stale files in the list.

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (3):
  MAINTAINERS: update KHO and LIVE UPDATE maintainers
  MAINTAINERS: drop include/linux/kho/abi/ from KHO
  MAINTAINERS: drop include/linux/liveupdate from LIVE UPDATE

 CREDITS     |  4 ++++
 MAINTAINERS | 10 +++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)


base-commit: 57a117e7a3b3b47ee89b4b937b999a21a2c6134b
-- 
2.54.0.rc0.605.g598a273b03-goog


