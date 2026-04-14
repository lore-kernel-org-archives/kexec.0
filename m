Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC83F9D0C8
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tlpYa+npWK67wu3fERr4rFjUXk6//B5ou/GHEgHbvRs=; b=O+67rWVnf0O/eOVkFknZNBEdOf
	K4MEugrHfltucUQwoQZJ9bhzBrJIg2b+j86wR/I3PPF/21Ihu7tg/Cn2mcNHBeNE5Af/2j+zL1r25
	2U3uMy+ZnROM9OkD4iNAiOFcRgnndmwXG3SFFx0F3jyD0ODehOH/JXw1yCt13CtHhFpziuByMh0RR
	k0Jwekg9ZVl8/6fM3dKmVeptmPNSBcrnV8hAaD+lIuQpKx1n2SC9M1GEefsqusZW4JS+DB0KL2W60
	LsX8uan3rwXjT8OO17x6lR+tF96amgmVyh/N49DR+arLuAMWp8Q0cDrtCPVYOtU//kEJcA2r3pXQl
	Xn1f8BUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCcia-0000000HHxa-3wJs;
	Tue, 14 Apr 2026 12:18:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCciZ-0000000HHwc-3ujx
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 12:18:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DF2F6012B;
	Tue, 14 Apr 2026 12:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB242C19425;
	Tue, 14 Apr 2026 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776169090;
	bh=YNjBFynSiYepy00+I6db/urO7I1hBrfVj/khQB19l1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3zXDr5j1rSJQN6toL3I54tNohQfqxRv+hW0/rWKHKA0bLXHFIbj9IgaAMIVFX31r
	 T91EZt+9pUl23IvZybUc/4WG4ycVX9PHSrV8Cwdnns48sBq85uvhRXJsFRddSCHlgD
	 SAxHWzJwnVlbesq0LXF4/C9PHuLu7GNpivAJyErPzuZXMm/7S/tgyssDVh5v4c9lgK
	 pkysQFh+CBSJU2fyKxGHBblbhHTbVNds3x87UAZHpA2wAk3UyPaYvN3KO/VAI7jyHB
	 4MULX+QMgY9RHEECrszZ2KhKgayn30bINuhpXf43iFQyWWyHT4utf1yNNbxmHVE7id
	 duUYJT3fhZNgw==
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
Subject: [PATCH 3/3] MAINTAINERS: drop include/linux/liveupdate from LIVE UPDATE
Date: Tue, 14 Apr 2026 12:17:20 +0000
Message-ID: <20260414121752.1912847-4-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
In-Reply-To: <20260414121752.1912847-1-pratyush@kernel.org>
References: <20260414121752.1912847-1-pratyush@kernel.org>
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

The directory does not exist any more.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c1e2cefb4493..bb588928533f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14811,7 +14811,6 @@ F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/kho/abi/
 F:	include/linux/liveupdate.h
-F:	include/linux/liveupdate/
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
 F:	lib/tests/liveupdate.c
-- 
2.54.0.rc0.605.g598a273b03-goog


