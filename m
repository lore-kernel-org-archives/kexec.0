Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B92CC6B3A
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8axlsfso4k7syKxUcvyIg6Ym9y5kFkDYTWkZAR8ayk=; b=bzf2rquVn4iz9zy8H6W1wZioPY
	K6v+ty85o1iGHRfI6L8o7xMV34dTB2Wfzj5X+98GbRGmsBTkxJBT5/iDSVcfZw1T5Vtt5/+dfBHLR
	UO8n84JkEuol0v2h1MNNvdze3KzK26g8Wz+yJIhmKdzk8ghsUwYxovAjouwnW1nmaxp8VXTJhavNf
	LxWT3ZNa3CSkIJ2CIOqYdtQNL3IVHQ1XMCcy9BOOAeZWCwBIASvvenXLn5DEqFT3ImwTBkDR7L4/E
	c01zYbysicM4YGVWbHKCf8DkJthhX1Z/RtSezIiTOjpNFUvSq+C2Nr79SKKBqmIOwU3u516y2xbDA
	+Li6QUZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMiT-00000000Qof-24iC;
	Thu, 15 Oct 2026 14:45:57 +0000
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com ([34.218.115.239])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMiO-00000000QnF-3fCW
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 14:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792075552; x=1823611552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T8axlsfso4k7syKxUcvyIg6Ym9y5kFkDYTWkZAR8ayk=;
  b=VsonamoaVmQLZUb/izFyvG1lYijZSIaolt80M3CxlekaBAvq3wT+KxSd
   rCMhQ1p/civiNw8Yi4vIadn7AAItjbFwdyM7UuJK2TeRNVXgCNpdD6JYJ
   PgHRA6OVYGoFYnhUOVJyZa8iQ6dk9kDcKGNFQgm/TfVx3sYA01wL+tuan
   12U7ntQqWFiXIkqPnhAUp3In2FKBHyU1a5KiD3Iyg1xufwx4/+uja4ojv
   OTtXMI3dlWAyPEFuoFAWO5KpiE3xvff40ribFj7aaht0dgTqwmpOtmUbk
   zSlfIqa4hx5ADmh9NYI5L62CLI/uGsdtCI/M2sXaboRpEZRyhxgpgRnEs
   A==;
X-CSE-ConnectionGUID: opeVRcGqQHGuOktxkplgOg==
X-CSE-MsgGUID: aF+8dlOhT5+24Ki2k86dnw==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31124997"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 14:45:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:18197]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.38:2525] with esmtp (Farcaster)
 id f94577a4-6cf0-4788-b26f-4e1b3530fd63; Thu, 15 Oct 2026 14:45:46 +0000 (UTC)
X-Farcaster-Flow-ID: f94577a4-6cf0-4788-b26f-4e1b3530fd63
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 14:45:44 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 14:45:43 +0000
From: Federico Parola <fparola@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH 6.18.y 1/2] kho: free chunks using free_page() instead of kfree()
Date: Thu, 15 Oct 2026 14:45:28 +0000
Message-ID: <20261015144529.76911-2-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015144529.76911-1-fparola@amazon.de>
References: <20261015144529.76911-1-fparola@amazon.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.13.236.104]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_074553_799307_0C4C34FA 
X-CRM114-Status: GOOD (  11.88  )
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

From: Pratyush Yadav <pratyush@kernel.org>

[ Upstream commit b15515155af735a86e5bcd67ed739162f0de27f5 ]

Before commit fa759cd75bce5 ("kho: allocate metadata directly from the
buddy allocator"), the chunks were allocated from the slab allocator using
kzalloc().  Those were rightly freed using kfree().

When the commit switched to using the buddy allocator directly, it missed
updating kho_mem_ser_free() to use free_page() instead of kfree().

Link: https://lkml.kernel.org/r/20251118182218.63044-1-pratyush@kernel.org
Fixes: fa759cd75bce5 ("kho: allocate metadata directly from the buddy allocator")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Federico Parola <fparola@amazon.de>
---
 kernel/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ac9fa7727b5ff..9fe5d14f1ec54 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -365,7 +365,7 @@ static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
 		struct khoser_mem_chunk *tmp = chunk;
 
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		kfree(tmp);
+		free_page((unsigned long)tmp);
 	}
 }
 
-- 
2.47.3


