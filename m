Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEB3C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jo6vG8Fck92Ec2ICF08h9HWgylgcmuoyS4qHd/4tb4k=; b=U2Rl4LdJ8wRCQjX0rRjdfngB1q
	uSEttkbgEKm0CJdWPj3iSpUdDnbUarHMK0FRVVOfK9y1nvnCBg0VbPrIs2HLQjQ0ftx0U97yI1aAG
	qIa3yEwfKJeXePnNeUQ7Nu5pb3y5eHi36JboRHINOWgGe8K0OvcMH3SBHP/vV8w8gNXs/1kV2BE3F
	5pe8/DkBBF2zp0ZC7J5yYNPA1P7G+ntmyYXHRCK0nKoiHbqqgzx8OEH5/QD36ymRBX1NCqWovHhVD
	mxlxYuLKdSMPvSiu//joN2rmjyKevdk9Qq9zFPCI9z05nub1yDiG/HPrpVNSbEsO57VBjKK5uwc3N
	bA7XvWcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsid-000000038g0-1sje;
	Thu, 09 Jul 2026 17:39:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsic-000000038eY-0jyK
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 17:39:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E8FAE42E1B;
	Thu,  9 Jul 2026 17:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70881F00A3D;
	Thu,  9 Jul 2026 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618765;
	bh=Jo6vG8Fck92Ec2ICF08h9HWgylgcmuoyS4qHd/4tb4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uc5holxavp4JQIp7OghW6d0zZ/963AZ+EpsBk1yFU1Od1tM2H46v8cfDKe5Y/1b7a
	 zPE+Jce/p0bDpwIpMAO+1TNlNXAM+3aOHUK6MvXSfJDwrqzKOh164kDbHktkLBbm+p
	 uRIeolRBn7n6PqIoyLDfxFWUWoJw4SCHffrXva6IJV314NFnGKEQ9r7jnm3SReA++R
	 He/+e8OXxBI5iiy5LFPHG5Rt4eb80rcmRcILB6xzCJY7T2/wZ7WVbVFLWFm8+btt2x
	 UXyNXG6EoAwJXHWTKr1OZEuEIbAL9+HY410UK9qfnlU7sC++R2yFAwiv8cu+cuYR3E
	 XQPAq4T1QQlAw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/21] kho: exclude hugetlb memory from scratch size calculation
Date: Thu,  9 Jul 2026 19:38:10 +0200
Message-ID: <20260709173821.429921-22-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260709173821.429921-1-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
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

HugeTLB pages can be preserved memory. So they are never allocated from
scratch. Instead, they are allocated from the memory blocks with no
preserved memory. These areas are detected at runtime on each boot.

But since they are allocated via memblock, they show up as RSRV_KERN,
and blow up the scratch size when scratch scale is in use.

All hugetlb pages are marked RSRV_HUGETLB. Subtract their size from
RSRV_KERN when calculating scratch sizes.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 2c4848874629..9dc79b7103bd 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -742,19 +742,24 @@ early_param("kho_scratch", kho_parse_scratch_size);
 static void __init scratch_size_update(void)
 {
 	/*
-	 * If fixed sizes are not provided via command line, calculate them
-	 * now.
+	 * If fixed sizes are not provided via command line, calculate them now.
+	 * Remove HugeTLB allocations from it because they never get allocated
+	 * from scratch.
 	 */
 	if (scratch_scale) {
 		phys_addr_t size;
 
 		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
 						   NUMA_NO_NODE);
+		size -= memblock_reserved_hugetlb_size(ARCH_LOW_ADDRESS_LIMIT,
+						       NUMA_NO_NODE);
 		size = size * scratch_scale / 100;
 		scratch_size_lowmem = size;
 
 		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
 						   NUMA_NO_NODE);
+		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
+						       NUMA_NO_NODE);
 		size = size * scratch_scale / 100 - scratch_size_lowmem;
 		scratch_size_global = size;
 	}
@@ -774,6 +779,9 @@ static phys_addr_t __init scratch_size_node(int nid)
 	if (scratch_scale) {
 		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
 						   nid);
+		/* Do not count HugeTLB pages. */
+		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
+						       nid);
 		size = size * scratch_scale / 100;
 	} else {
 		size = scratch_size_pernode;
-- 
2.55.0.141.g00534a21ce-goog


