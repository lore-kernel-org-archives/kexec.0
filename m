Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6394C44500
	for <kexec@archiver.kernel.org>; Sun, 28 Jun 2026 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9wo+YX/Ag7ncd7bf256KRZ5DnnahmErnNNobKR7tPZM=; b=NoOUCau3wpfqkCrtQX77zB1FC2
	brb8FLHD3Duj8ZAGlxoRWhcSEToaIoL3XmLMuFPiqtomtzonjeWWWHHmE73oAZVGp6DDR0j8/xNQQ
	ljgGEKHRWLICHyjoZOba4+odqkO33+N0ZMplIN6Bj9uMXo2HXFC+dWcHRcw0flCFFlSwRvx46xaZJ
	ouxmXrnt9I84vNoevFqm1kH8bnuAyYJVlZBzi4eiDTKH56oEEpnj9FDK4TiAO/wenrEOKkll5YfPo
	4KSbv0YcmEm8Zkq59i8Bp+MPX16dlpcKpZihyrmVfbscsSh0mvZaRFXlPyved49BOHjzmdnBPYTgh
	6CunIpgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdd7M-0000000Cq9e-342y;
	Sun, 28 Jun 2026 00:11:24 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdd7I-0000000Cq86-1B1L
	for kexec@lists.infradead.org;
	Sun, 28 Jun 2026 00:11:21 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-695b677095eso2048328a12.0
        for <kexec@lists.infradead.org>; Sat, 27 Jun 2026 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782605478; x=1783210278; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wo+YX/Ag7ncd7bf256KRZ5DnnahmErnNNobKR7tPZM=;
        b=ABVcUKEo0jHC6+2zl4MMuf6UfKU9P07d2/WEh2rVH4Rwiy6W7L0LJIW4VotPbmz69Y
         ReTomZRCTAk7bIaz+Xzs3zmekPNa+F4H6XZyZsUh7hWsws4A2xvOd+ewW+h4HXxSGxdK
         n9iZMhwM1PPS1q72t4RiQtVnXexCzq5TJ5NscsRLdY8R4LJSxvRgr4obiJb8KAtx516u
         ZlfGdjhhErf5LHAqKo8+TRiQ+LeJHU2X0djzt1G28l+pl+aJeyTp+HKwmGNspVCAmnW7
         m/BnR6aLA5YeLEqp9Jlewx/rXMRIuy0a/OYTijAiluiDl/iFgDDjMN6HB4YVZfCPDhk2
         PriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782605478; x=1783210278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wo+YX/Ag7ncd7bf256KRZ5DnnahmErnNNobKR7tPZM=;
        b=UQZYhhxlM2VMLCYXpaDNlnLIyFQ1DwkxjsnMXHIkYFgq6ptLWj559HGsBZCb5FEAdt
         XME5yUq93PxwIJ4p2gyVuGlf0DSCM4DQapB6qcohRF3mNxFCRUj+BO5fLxedn2n5rSkn
         RXvE10oLkJoPFld8/ROZfMRmmagJRy/4Amo62vFUbc9+n+vX39w8TjaNiHDkxcDc6AKC
         0KuWjlSyeiy4+mPCk0OxVvGPSWK3i62oXXJn7T0o0PhaOIkKQXYRa1yFikxsvGDqOW4X
         WRYYilPqTfgQoNkk6x2dDKt5AkQwUY4pQXM5gJEp85H7JbzwGdr5OEN/HMGYUlBKeEmH
         2LCQ==
X-Gm-Message-State: AOJu0YxSolb0Olhg2r054ah54OOMrPWBI6dNWgqclMBOmLw6jpQ2BNUT
	s1NxnR6PcAOGxJgKcv/q3xp4vvWIqwkXAGJl/2+VY9JcF04tL+nFUq6Wtgh0e7oi4dbOoin7uvz
	J1T27ndD+NK4hai4Ttg==
X-Received: from edxb10.prod.google.com ([2002:a05:6402:2ca:b0:698:3b14:4ab9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:510a:b0:697:de29:c802 with SMTP id 4fb4d7f45d1cf-69810ab88f9mr4353570a12.18.1782605477536;
 Sat, 27 Jun 2026 17:11:17 -0700 (PDT)
Date: Sun, 28 Jun 2026 00:11:12 +0000
In-Reply-To: <20260628001114.1869564-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260628001114.1869564-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260628001114.1869564-2-tarunsahu@google.com>
Subject: [PATCH v6 1/3] mm/memfd_luo: validate serialized_data before conversion
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, skhawaja@google.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_171120_326947_02BB29A8 
X-CRM114-Status: GOOD (  12.17  )
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

In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
on args->serialized_data before checking if the physical address is valid.
Since physical address 0 does not map to virtual NULL (due to direct
mapping offsets), the subsequent check 'if (!ser)' was ineffective at
catching a missing serialized_data, leading to unsafe dereferences later.

Validate that args->serialized_data is non-zero before calling
phys_to_virt().

Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/memfd_luo.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..10f3983b0060 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (!args->serialized_data)
 		return;
 
+	ser = phys_to_virt(args->serialized_data);
+
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser)
@@ -522,10 +523,11 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	struct file *file;
 	int err;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (!args->serialized_data)
 		return -EINVAL;
 
+	ser = phys_to_virt(args->serialized_data);
+
 	/* Make sure the file only has seals supported by this version. */
 	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


