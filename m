Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF55CA1010
	for <kexec@archiver.kernel.org>; Fri,  5 Sep 2025 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FyIIqegIx0wfHeURsTvCMPzANphZ+sLHWvGCD0oe4C4=; b=jhresEuZ7U4epWL4wWhcL6o0+n
	T/PZ8vfVgtWbUCEMrxFHc5EVceBhGLA7Z5HJ4y2WLt0Kh1Px6jEktMY/3OWUKiT4DFAQG1A7lJShn
	A7V0yoEevzsMKFByLkun+pVkQR+IAE4TVKnZcq3NOyoC8fOTldt0/MT4UVbFKs6u16SH6u2GuLlbk
	zfyvSTD1uOqWxZElLUEnJpxeRgMvOmA+mW89PGGH1n/8rBtFoPB/tIwDI9O4cHZIkK6o658NJEibE
	oIdd0wiLm+5VB4xdWLiy6E0nAwX0fzotGkxpHIzWt4p27KIseFEKS4iI6mPU4rLQTduPDby0FoZP1
	kyoL8V/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuZVf-00000003BE7-1M1o;
	Fri, 05 Sep 2025 16:41:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuWFa-00000001tiv-0Zet
	for kexec@lists.infradead.org;
	Fri, 05 Sep 2025 13:13:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 93B3243E60;
	Fri,  5 Sep 2025 13:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FB4C4CEF1;
	Fri,  5 Sep 2025 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757077989;
	bh=lAKGsfnUG4rgDzqjzr2gwTb62JFdmQhbLIaqo8Ydwj8=;
	h=From:To:Cc:Subject:Date:From;
	b=Qqjp4fTGmt1agJ5gkKDXDVoyGrBWy/+xs1oMAD+t8nIH8Wne+DsxUYs4uLh71rW4o
	 CkzGfZ+CFJZFEAjsuwqMOYzhZtYtjxTz3V0LXTgzxpipASA3L6qCJzPPSxuBCZFgnA
	 FH2NCGEyCRERVJ1wUthH9fmpESPTPQu/YHMIO6nGfxlWN0Ffxo3lTx2jWyoMlcQ/H3
	 oY1UkN6LddelAKES3d2dDxpEudIpgymD11FGtElL1NPFBYlLdF3KUEoui5ebcDzTe+
	 Sur1SvJ7GpsshAC5gaIuKSJ0HAN4lz374eMfLPyRfQ9HeI4sdzSJQ53f4aVUac6dPz
	 E2ydBOL4tqx3g==
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
Subject: [PATCH v2 0/2] kho: add support for preserving vmalloc allocations
Date: Fri,  5 Sep 2025 16:13:00 +0300
Message-ID: <20250905131302.3595582-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_061310_197534_D31ACF34 
X-CRM114-Status: UNSURE (   8.54  )
X-CRM114-Notice: Please train this message.
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

v2 changes:
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
 lib/test_kho.c                 |  30 +++--
 3 files changed, 235 insertions(+), 7 deletions(-)


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.50.1


