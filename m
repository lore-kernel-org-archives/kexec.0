Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9BEF9D0CB
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fPezp2ITcZkdDANmMAapdSgeqRrrkiq9XkdWx7o6Opw=; b=PcqRNWtc7Ol4V2DeQjIH0y8KKk
	zk6kSf0MzgzsPpP7HT52GCjkBkSCbDrPu3+KiuNuucbE3TptIyklexln6C8xkTwIPJWIQP5GpanMf
	9JKK9Ri8DpfQ4tsE5j7HUYWasA9YkOBLkj/260geEIsQk9KdvyJ5fuesu7odlB/ebrFOCZGe8hN2B
	/ryAz5wT4V3kBWOw6SkoW6Fpf4k/EtbP/jpk3c3En9dYPa+MJ1V30VVfwzAFHeMPnenrw8/VIqQyj
	AJKSBWuA02c2ujJ9Dzco8uTrD1kYhdhfFY32fffxudM0HXpWacLsmnofS3Zt7dCM2BakzkUPszoSV
	eJxt6WXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCciX-0000000HHvY-1SlP;
	Tue, 14 Apr 2026 12:18:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCciU-0000000HHu5-32Ht
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 12:18:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E9E5C409D3;
	Tue, 14 Apr 2026 12:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D58C2BCB5;
	Tue, 14 Apr 2026 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776169085;
	bh=C8aNWw0AbQoUzlLKddK8Zjdqea5+Y0/v3eZoxdIwDQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0M98o8dweNBxTJhaWK3u8rQ7z1SfMNuA+rueB7kiH1oylkCUSsbU62eSYn7jdXss
	 YwaRpyX8FuP6VObBMD0F6PtzT90BP1PEMoGDIWM8YfcRZAUnudMZfSwElHMGArXPbO
	 PascLPYk7Q0dge1QUCe+kOYmE8+tvEEe3ohH369SHT6KxFcJeCm2sG6KQQlpydJiJt
	 uRS7L+fWk3ehBDzwWK4OaTFEp+DxiPpwlpqBHMbWIx5stKVouGnzhhk3/VXVl0Ajot
	 2F9grHKy/5Asws7FOmiplUxPrka4eW1DRWOxc4cfYcUZAX8TNTTVF+uK9MnnEBlpu7
	 jeMqz87u/FxAw==
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
Subject: [PATCH 1/3] MAINTAINERS: update KHO and LIVE UPDATE maintainers
Date: Tue, 14 Apr 2026 12:17:18 +0000
Message-ID: <20260414121752.1912847-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
In-Reply-To: <20260414121752.1912847-1-pratyush@kernel.org>
References: <20260414121752.1912847-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_051806_792536_102ADFC9 
X-CRM114-Status: UNSURE (   9.90  )
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

I have been helping out with reviewing and developing KHO. I would also
like to help maintain it. Change my entry from R to M for KHO and live
update. Alex has been inactive for a while, so to avoid over-crowding
the KHO entry and to keep the information up-to-date, move his entry
from M to R.

We also now have a tree for KHO and live update at liveupdate/linux.git
where we plan to start maintaining those subsystems and start queuing
the patches. List that in the entries as well.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 9091bac3d2da..9173508b4e03 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1456,6 +1456,10 @@ N: Andy Gospodarek
 E: andy@greyhouse.net
 D: Maintenance and contributions to the network interface bonding driver.
 
+N: Alexander Graf
+E: graf@amazon.com
+D: Kexec Handover (KHO)
+
 N: Wolfgang Grandegger
 E: wg@grandegger.com
 D: Controller Area Network (device drivers)
diff --git a/MAINTAINERS b/MAINTAINERS
index 915f074c3577..97820188a600 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14109,13 +14109,14 @@ F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
 
 KEXEC HANDOVER (KHO)
-M:	Alexander Graf <graf@amazon.com>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
-R:	Pratyush Yadav <pratyush@kernel.org>
+M:	Pratyush Yadav <pratyush@kernel.org>
+R:	Alexander Graf <graf@amazon.com>
 L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
@@ -14802,9 +14803,10 @@ F:	tools/testing/selftests/livepatch/
 LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 M:	Mike Rapoport <rppt@kernel.org>
-R:	Pratyush Yadav <pratyush@kernel.org>
+M:	Pratyush Yadav <pratyush@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	Documentation/core-api/liveupdate.rst
 F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
-- 
2.54.0.rc0.605.g598a273b03-goog


