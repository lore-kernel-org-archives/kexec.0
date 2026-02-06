Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3BFECD9BC
	for <kexec@archiver.kernel.org>; Fri,  6 Feb 2026 02:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wOMvatFmTNuXEwXOvg3h5CBCiVV90WJG1wSdmd/lsBo=; b=ppaTbmeyUiyztZ+GXhUVUkLBac
	q3x6Dv/y5YuH29V2IyTIeLOjEof0aowYyBqPrYdQmXQmyWEfypLJgSPNRGr8nQYnLmmxTaIYfVwZH
	eUkkPN0FtpjzjdY/ugl7vmiQ4JhA0wqjPksu9c8F7+KziIHE1ciEOJnGgCvv5tZ2zZKQ4HmQYgRWi
	uA8q29+ipX2hAiNo3zPzOFEMIOr/o1hxDOA30iHCgv7CbW5jYI06FgXNXRNwszaddsJ3Y6z/zgDGh
	mAN6Owt5swpV3n3pj8NG7IXLTDEqDWPA1qiHWvTnqHbLzm+KM/IEqB4eazRgx1Ga28OT8jzbL34KV
	AkWjc18A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voBMk-0000000AkBx-3E1E;
	Fri, 06 Feb 2026 02:14:38 +0000
Received: from mail-dy1-x134a.google.com ([2607:f8b0:4864:20::134a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voBMf-0000000AkBH-2Jzh
	for kexec@lists.infradead.org;
	Fri, 06 Feb 2026 02:14:34 +0000
Received: by mail-dy1-x134a.google.com with SMTP id 5a478bee46e88-2b8335e64e0so1446919eec.1
        for <kexec@lists.infradead.org>; Thu, 05 Feb 2026 18:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770344071; x=1770948871; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wOMvatFmTNuXEwXOvg3h5CBCiVV90WJG1wSdmd/lsBo=;
        b=zujmlJKvoWeo3LFuToweViNqGqGY+Tu5F60Ydpg4yvC7RgqzVonZxeSDB5LMzf8wja
         q96EogmxTbCCpSd9b21CWE2lJzEJT2/LKRKDH++dsk5CShRU3Cd+xoR4cCdfXyZ5xcUc
         Yv+w3pMvpcOap795vyacwGDojeNdKEiQ+mXiZIIekJclJ8JYAsKTRnoKVmDoDvnPuyz/
         oELV9UJTdDHBrKrDZ3INbVVKl4m74UOvhw8Y5zTIFJRxmI/hJGvHaCzmbCrbcfnrRQN9
         4DoZp/FTjDPk8ZeEH6kg3fAHic20etMqmebCPmWnbQAfPqUZO0hsFxYBa8IBdFRqYJnW
         POkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770344071; x=1770948871;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOMvatFmTNuXEwXOvg3h5CBCiVV90WJG1wSdmd/lsBo=;
        b=cYsb1VKcoMgoEdQDSGrd+HlEdZtpG3rAkRCTr8e+x52LKKzn7lXwvErcJu8uouJ+NR
         XluLe806Lo0MR/mqWOoU5u8WaQSQxpc/iefiND4kJ5Xn6bWLDgESf3c543+JhyPPM03G
         K2nIUchQ4m2XwL1VtoU2i8gNiRTI3zgUmCNg5O95Haa3Is8yNJuBKFogjX0vtNAfYhlg
         c0VAGMgNxb6LmG7kJMCyVYwDUmZTSQJDwY25migyMNjJ/8ta367Bv9+XuGEEMJ4rrsut
         krGNQnnRjyP4WYk7U2iUzRtcAdP+Ne3Rde60zF+xhAQSH2U8FtNYdlDSLSr22pufGrPV
         tTuw==
X-Forwarded-Encrypted: i=1; AJvYcCUTcFt+4JlLUpN0aV49QJ2tS2ebW/QT3PWO+aPnt2URlORnIap17F5x077JM/2/sexBavZjMQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxt2CxrGwF5tgvt9OGrDz+Nu+6csLDMyPFik/NTJdFxsO7+g+c0
	Z3/5vum7WRhO6Q/bwYRoi6zQonMXzrUlRLm3jIIutpuTVHO+tpOb1vsfLOYi+jq0oyJOwaE9XOG
	UV0J0jYQ9s4EkBA==
X-Received: from dybgu5.prod.google.com ([2002:a05:7301:2285:b0:2ae:51e3:c162])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:2d8c:b0:2b7:1c58:dca6 with SMTP id 5a478bee46e88-2b85646d9c4mr658234eec.6.1770344071405;
 Thu, 05 Feb 2026 18:14:31 -0800 (PST)
Date: Thu,  5 Feb 2026 18:14:26 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206021428.3386442-1-jasonmiu@google.com>
Subject: [PATCH v9 0/2] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_181433_595539_BB9EAFD3 
X-CRM114-Status: GOOD (  10.06  )
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

This series transitions KHO from an xarray-based metadata tracking system
with serialization to a radix tree data structure that can be passed
directly to the next kernel.

The key motivations for this change are to:
- Eliminate the need for data serialization before kexec.
- Remove the KHO finalize state.
- Pass preservation metadata more directly to the next kernel via the FDT.

The new approach uses a radix tree to mark preserved pages. A page's
physical address and its order are encoded into a single value. The tree
is composed of multiple levels of page-sized tables, with leaf nodes
being bitmaps where each set bit represents a preserved page. The
physical address of the radix tree's root is passed in the FDT, allowing
the next kernel to reconstruct the preserved memory map.

This series is broken down into the following patches:

1.  kho: Adopt radix tree for preserved memory tracking:    
    Replaces the xarray-based tracker with the new radix tree
    implementation and increments the ABI version.

2.  kho: Remove finalize state and clients:
    Removes the now-obsolete kho_finalize() function and its usage
    from client code and debugfs.

---

Changelog since v8 [1]:
- A small refactoring of __kho_radix_walk_tree().

[1] https://lore.kernel.org/lkml/20260130005739.3163049-1-jasonmiu@google.com/

---

Jason Miu (2):
  kho: Adopt radix tree for preserved memory tracking
  kho: Remove finalize state and clients

 Documentation/admin-guide/mm/kho.rst        |  53 +-
 Documentation/core-api/kho/abi.rst          |   6 +
 Documentation/core-api/kho/index.rst        |  18 +-
 include/linux/kho/abi/kexec_handover.h      | 144 ++++-
 include/linux/kho_radix_tree.h              |  70 ++
 kernel/liveupdate/kexec_handover.c          | 672 ++++++++++----------
 kernel/liveupdate/kexec_handover_debugfs.c  |  23 -
 kernel/liveupdate/kexec_handover_internal.h |   3 -
 kernel/liveupdate/luo_core.c                |  12 +-
 tools/testing/selftests/kho/init.c          |  20 -
 10 files changed, 571 insertions(+), 450 deletions(-)
 create mode 100644 include/linux/kho_radix_tree.h


base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
-- 
2.53.0.rc2.204.g2597b5adb4-goog


