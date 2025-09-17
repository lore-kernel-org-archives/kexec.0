Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51887CAC598
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 02:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QvfS0lbIl6nsb5SOfYP9Zx2VfhCPX5J5Iuo96LcGehc=; b=W4HYgkKKNo5omsH3jYSDQ0eixO
	5gKeGc0aFxGFV/D/pMeJZU0Mv0rO92l27FAwFxwwCTg4ts5eL0XIUYnNbLKOTwuDwvrXALPsN5gPZ
	hLpZe+9wGUFmBIbvL+ukt8MLNH0WG7xnvJ1jQ5eP2MhbRP5YI1f9dtysWFqnQ5K+EwoVSVzkCRLd4
	d2p+I1jLfF3yawBJ0md7pjvj/0INRZgC7O95qPBJgVjVs0Qq6dAjZ22jPrAaccXbiGmgfg65V9PV/
	7T+k1cW+MsGLRY+VAZBxj/1mJWzbl7+xZjoGE0n0pgJHtIdgnAk3ihiwmTGOYi+WzK3tuW4dnj8ju
	4p4qNDPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyiFe-0000000A0WJ-2mP9;
	Wed, 17 Sep 2025 02:50:34 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyiFb-0000000A0V1-1FiI
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 02:50:33 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-24458274406so119704745ad.3
        for <kexec@lists.infradead.org>; Tue, 16 Sep 2025 19:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758077430; x=1758682230; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QvfS0lbIl6nsb5SOfYP9Zx2VfhCPX5J5Iuo96LcGehc=;
        b=OkGBWK1YHosaZl067mHP4lY5/npL2EYkes37ZkdH8DmV/1vog8iLQSnHtVdrKiF9F0
         66v8nxR5yypTnZK/qD5Kfvk46FjTSvACX05PFW4KznfN/HYcbW2ZDFspA65KmiRcGC6t
         uqq0SfCfCyG+AXzCZfbWQYwNbiRy9wjNBsA0SQjo82CVuyMWEiz58AWdFx7JQ/hwC7jq
         Fl68Gu/3Gc8mPQw3fymI5mQsAtrCZ8JrxVu7j8aC4ztIDfiZsjkLlsJHqF8Cte9jbXAz
         6e8FDaXG8wtGFFIXPh7rqCkVhiEF3XVCmAUOuv3KSEuxFCP79ZKbOTRUTCSJDVUwO+T2
         mMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077430; x=1758682230;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvfS0lbIl6nsb5SOfYP9Zx2VfhCPX5J5Iuo96LcGehc=;
        b=Qts9NlrOrDeisof+Mb6+3nrpUDDOYCaRAPVoBOhxQP+q7XqBA2KuhkuKHlRNmjFvI9
         ON8qnxVvsi3wd+M5IT3SjwEnFaKCYDSzeBaO9BPLgNOMxJnEIW3d7Np5ij6G3sbxammy
         EgvuEyTM76xGmQXr3CVIIT/xFI8cnr0Powqqo4rBo90XdxU+RuDFK5CRyJmg7Yecx/e1
         Pb23f3jyEiKHV/6XHS+YIQEZpTcJpg/tYScOQspt/Nd1E4T/UEOoPdNlZA/OmAky/opt
         AgJDAYQbstkS1KuXTfNGmU8sGmX5OtZ369UqFZAmbeOExw+xSYI7qGCgTXZ/1V7lhWTC
         asZA==
X-Forwarded-Encrypted: i=1; AJvYcCWqwK2MR3RwMsPFBO9Tr8KMs3BFRISKHQ4D+vBEml9Zu5qMSO41XchBPxZtuUqC9oLQ1+3PJA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxhANs3Pm2bt5zY58LLImo1qigQFoT0QLDKjdYoj9HUYCvTTXJn
	jn83LhHLTFUW6wMtsCBNwYZoSCwp2FAUAmh46eJet2k5lyfjXmBkODb9aHbKGTVqJjTj4iiLqUj
	QitGB0wKASmqD8w==
X-Google-Smtp-Source: AGHT+IFsWd78Zl+0JpPchoff8A4M5Kb6apJ4WgYWtl1LRPz8f4ijmhz+IeY75j5Bme4PyrExdVwrt2ZA8lDSow==
X-Received: from plkv16.prod.google.com ([2002:a17:903:1a30:b0:267:ea8a:35da])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22c9:b0:250:1c22:e7b with SMTP id d9443c01a7336-26813aeee86mr8191395ad.43.1758077429969;
 Tue, 16 Sep 2025 19:50:29 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:50:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917025019.1585041-1-jasonmiu@google.com>
Subject: [RFC v1 0/4] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_195031_335219_15E8B70C 
X-CRM114-Status: UNSURE (   8.72  )
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

This series transitions KHO from an xarray-based metadata tracking
system with serialization to using page table like data structures
that can be passed directly to the next kernel.

The key motivations for this change are to:
- Eliminate the need for data serialization before kexec.
- Remove the former KHO state machine by deprecating the finalize
  and abort states.
- Pass preservation metadata more directly to the next kernel via the FDT.

The new approach uses a per-order page table structure (kho_order_table,
kho_page_table, kho_bitmap_table) to mark preserved pages. The physical
address of the root `kho_order_table` is passed in the FDT, allowing the
next kernel to reconstruct the preserved memory map.

The series includes the following changes:
1.  Introduce the KHO page table data structures.
2.  Adopt the KHO page tables, remove the xarray-based tracking and
    the serialization/finalization code.
3.  Update memblock to use direct KHO API calls, and adjust KHO FDT
    completion timing.
4.  Remove the KHO notifier system infrastructure.
        

Jason Miu (4):
  kho: Introduce KHO page table data structures
  kho: Adopt KHO page tables and remove serialization
  memblock: Remove KHO notifier usage
  kho: Remove notifier system infrastructure

 include/linux/kexec_handover.h |  44 +-
 kernel/kexec_core.c            |   4 +
 kernel/kexec_handover.c        | 821 ++++++++++++++++-----------------
 kernel/kexec_internal.h        |   2 +
 mm/memblock.c                  |  46 +-
 5 files changed, 404 insertions(+), 513 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


