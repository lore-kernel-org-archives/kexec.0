Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9726BCA1013
	for <kexec@archiver.kernel.org>; Sun,  7 Sep 2025 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIyksWTmF+WPRQfDWNQ3wfYCg86aJi793lKO/e/geg0=; b=RCDlK7+FbkreLnbUmkqbyGdy0q
	fJlwSHTVxKfX4AHdf6niInNqfRVMgyZkEYtrX0ot2PZwZPRKNaMUSv6gH4EYGc8y3IP1w8hyPTxlv
	hYQ6oiokNWc3pg7dgp3bvN++NpdgvuE0+Qfsz9I0pQHfFTPtv7l3ptxT75qnZIdEZSsbnAMe0Z7YU
	u/4a/I2rtB2RZDTrgv4kMXAluPlpV37D6edrk66Yt//6EqgU2MqHDpchfeKe9PlFc/whsZkIpiqfJ
	45jaL1IM/LMNqq1uLwOUlDCc7hHI8N+Q8UvqYbQ9iZ8Q7+5a7FRKRGg2Nz8fwYxvDjlwKIfLberg3
	d30uQHrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uv9OE-00000009tiP-427L;
	Sun, 07 Sep 2025 07:00:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uv9OD-00000009tgn-3c6m
	for kexec@lists.infradead.org;
	Sun, 07 Sep 2025 07:00:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 334E3601F2;
	Sun,  7 Sep 2025 07:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA2AC4CEFA;
	Sun,  7 Sep 2025 07:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757228439;
	bh=Y+6NT7qGhfiYpIQPVV4I0mtOFqnghk5yu59oPQEuT2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgDPUEr+nACQDYmwMPpNxXvHoZoDdvANiaJUMpLW4tS3GcSp1/k3Pr84+5Ir1abd2
	 ckZUS8wUb1PmH7Dx0xqG/nfAHPjouj3pTAUA+haMisAuuWYnFQ1wT2/AYWvB2v26KE
	 S35V+vdyN78ZZe3plraMPrn6JsR9rgbvow7wUihUmt+3HHQGhsbsChl2udCBjwI5dd
	 /l5RZd25dlfVBMJavzboaaOCj3jon6FeaLKNVqUMP9RaK/GsX/uEfjs6Fwx1VR5Owq
	 kI9qX3VN3ikWNkolazVK/3V3iS/3skSqXIEyYpb2IozltdgiFhmHQERtPw+wqhB18Q
	 r/2XppbwT6uGQ==
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
Subject: [PATCH v3 0/2] kho: add support for preserving vmalloc allocations
Date: Sun,  7 Sep 2025 10:00:20 +0300
Message-ID: <20250907070022.2177974-4-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250907070022.2177974-1-rppt@kernel.org>
References: <20250907070022.2177974-1-rppt@kernel.org>
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

v3 changes:
* rebase on mm-unstable

v2: https://lore.kernel.org/all/20250905131302.3595582-1-rppt@kernel.org
* support preservation of vmalloc backed by large pages
* add check for supported vmalloc flags and preserve the flags to be
  able to identify incompatible preservations
* don't use kho_preserve_phys()
* add kernel-doc

v1: https://lore.kernel.org/all/20250903063018.3346652-1-rppt@kernel.org

Mike Rapoport (Microsoft) (2):
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt

 include/linux/kexec_handover.h |  12 ++
 kernel/kexec_handover.c        | 200 +++++++++++++++++++++++++++++++++
 lib/test_kho.c                 |  41 +++++--
 3 files changed, 241 insertions(+), 12 deletions(-)


base-commit: b024763926d2726978dff6588b81877d000159c1
-- 
2.50.1


