Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8FFCA1007
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 06:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x9VALCUu5PPY2af6wI6+9K/vJZQgbiXo+WV/pWMB534=; b=H65yx2WkgCcF4q7WFuyen2PKsJ
	9rF9eWfSVkgnCyj+SsfE5GBvE1p/RdrUm7sWzYuZctt2DY5XS/zvWuyJn0h/G4Y8BMUNzp+VhmfHS
	6WxPhkmR/hET+iNB0uJ2EvnYiyhFhsWsDYgQD9iVpl6u6sE9kPvA1SK4/5EKteg8BZyFyse3ZZaUo
	RVUfMl9y+o0aPve88vzCAnW1TygFEMCEnY2HB4PgIfhFNey1Goen/bsLZSj1x9YQm3KCNsUhm33UZ
	d+2TTdIXa5Lo5kHs4Z6ehUMSu4mr0LuW0f0uM3gxNn4pyqlErAS1lq4cXstDJO5V/CVb+awR4YE+t
	FksXjhuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uth6C-00000004h8z-03cv;
	Wed, 03 Sep 2025 06:36:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uth0k-00000004ecm-2ja2
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 06:30:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CCC1660239;
	Wed,  3 Sep 2025 06:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FC5C4CEF0;
	Wed,  3 Sep 2025 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756881025;
	bh=0BP7MTU7WtClcd5jUvnxmjOIUJ5oBGFWJ9RXidmD/b0=;
	h=From:To:Cc:Subject:Date:From;
	b=r8L5J+UpwsZFc6vxvw/oeG2L7/kI3GOXOPF1wkLa53P0zXa/EWSrxgEzwd7YgKQE9
	 ydDjrfNusiUWQwYgKKVHO0PosNWMB/PZmMN9tLVni5+5hRx8udYAnSqB6SYqDNV4pd
	 /FfuvmrZuh9EtDb3aev9j3WRR/o2+RmZNeZKMA+S6uw4+BXkw2F961clb3kXyG/v4A
	 oF/fqFlwj7ciQc6VI2sP/soaMg/0ReJ4Ymze8kKhGy0nwNoECivEoI4pjBNmzw1cck
	 zQoKoyfddujrP8rjmcowiXA3gThpuJZskxVpkE3NEMVdEryDcPKcclpQ52m1PZKsE7
	 Ie5WO9SfESaBw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kho: add support for preserving vmalloc allocations
Date: Wed,  3 Sep 2025 09:30:16 +0300
Message-ID: <20250903063018.3346652-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Following the discussion about preservation of memfd with LUO [1] these
patches add support for preserving vmalloc allocations.

Any KHO uses case presumes that there's a data structure that lists
physical addresses of preserved folios (and potentially some additional
metadata). Allowing vmalloc preservations with KHO allows scalable
preservation of such data structures.

For instance, instead of allocating array describing preserved folios in
the fdt, memfd preservation can use vmalloc:

        preserved_folios = vmalloc_array(nr_folios, sizeof(*preserved_folios));
        memfd_luo_preserve_folios(preserved_folios, folios, nr_folios);
        kho_preserve_vmalloc(preserved_folios, &folios_info);

[1] https://lore.kernel.org/all/20250807014442.3829950-30-pasha.tatashin@soleen.com

Mike Rapoport (Microsoft) (2):
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt

 include/linux/kexec_handover.h |  12 +++
 kernel/kexec_handover.c        | 140 +++++++++++++++++++++++++++++++++
 lib/test_kho.c                 |  30 +++++--
 3 files changed, 175 insertions(+), 7 deletions(-)


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
--
2.50.1

