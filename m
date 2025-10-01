Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9895ECAC5B8
	for <kexec@archiver.kernel.org>; Wed,  1 Oct 2025 01:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ifegM91VMNYCdV3RhGc/5AKOzdvQHyhQ3tKlNLE40ko=; b=w/WUZXXoqJ+6BMZZcH9FVrJCFh
	D2S2g/fZSOG78CrduAx7PA0Ll5G9nlnG/Ohj+/wG4l7UuJPtLppGnCWI26PUa7lVv4vHqsqgc5m2T
	/UicHnPvmAY0O+PPiPGmD+Puc5awTpBIp22IK4hvRgiYWpYLqfxdrxvG9i6qEprfsYr46B7E8KoYt
	erk+h5DB5s9eHX92j3i9E4Mr1ZH/wQmQb+YoJAnrukXhrkOhVxQopwCuL2wWA05PIWgT0+H2wXGzm
	aFk/785heMly36aILTPBzqMvp9xujZ21bkcKmPq8DnfpodtrgWKWqwZRLwdkK22zKFiHcN5O1RWJO
	u55VRvHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3lVZ-00000006Vc2-2c9x;
	Wed, 01 Oct 2025 01:19:53 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3lVU-00000006VbB-09tu
	for kexec@lists.infradead.org;
	Wed, 01 Oct 2025 01:19:49 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-76c0ad16289so66197127b3.3
        for <kexec@lists.infradead.org>; Tue, 30 Sep 2025 18:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759281586; x=1759886386; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifegM91VMNYCdV3RhGc/5AKOzdvQHyhQ3tKlNLE40ko=;
        b=Wyritz3/HmNQhixc//EVLdTJoRdg0hUS9x5YGXA+fib5hEtwqhdFckrlQriTdMeKPR
         lyaJYuDZDffnTjiVaHHJ71IsbL/KbXXowWZi/PmoUplkbLWegKPMAaWnIsCRMVdIYbQW
         cktwJtgDaQTP9Bl13IhMp50fWv396u/lSK3RcyLqYqEuTXs5BrTeqtuoqW+Rb0xBHlfH
         dWY8jgQi1OGguU5fmKfMKB7h2Gizw9odI2OR3ytqjhvkoYt3RIrRzRHtmX3bZbu+S+it
         Zk9citFYnPf7xinWltugUip/aCDLdtqZTD63L0nwcYmP2Ma/uK2JkDk4xQXkrkTNQe+y
         /voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759281586; x=1759886386;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifegM91VMNYCdV3RhGc/5AKOzdvQHyhQ3tKlNLE40ko=;
        b=odkR13OzALHSqk1j+RoXIDouaGAAAXP1jcChcHdEiy6kanG6b5YwOJeL2a+wCSLxFP
         0RIeTCuUssfFZFV5AkH3IL7IFRSJY6Fd2VQ/LV+qnlZg81nmKDkQSJTfpWsVjfWTdSnL
         hpGcZIZhzCibn8B3poT/HjOy5DviwDkdT9lSyDLLmmanCof1iZI3nminceKknwIAmpC+
         DT953uZXMKq9MLHlKXh+4QiLy4XUNyT/9jzstZLWji2FeZDZ38CGZT1xHQ/A1caISsYj
         DXMX8Tk6QSDPPR1ZuQqcx67kcYfX+XMsLM1lPtPk3+Ct91ys1sAsQ4oQhYC8cWyyJOTQ
         lafw==
X-Forwarded-Encrypted: i=1; AJvYcCVVhmoX+TOGQrwXDIj+Zharv5cwAr8rUMHnSSnntG9u5XkkWRDuxW8WdmjarXBXit6M9yZf6g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz8rBDvarfh9mTVtiN/7SkocEV8uAs3YB8Y45KmumsbDtR9519P
	JJYAF33TwBbLbPZ5kfqxyc0o/Oe6tZTuhDUVTI5lQTOn7bgp92Bj2LImYwXb7w5nN2qDloQJ3to
	77ZEiFaFPMUEKbA==
X-Google-Smtp-Source: AGHT+IHnDLAnHU4+42jOPdelDKDAAM8AUpJw1mxLW7+QMrPN8GTOVoPsFzFmqWP34QTuhqqEfQMVQ6uv+qBPag==
X-Received: from ywbjd11.prod.google.com ([2002:a05:690c:6f0b:b0:775:154c:72c])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:360b:b0:735:8634:be49 with SMTP id 00721157ae682-77f6f117fcemr28154297b3.21.1759281585803;
 Tue, 30 Sep 2025 18:19:45 -0700 (PDT)
Date: Tue, 30 Sep 2025 18:19:38 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001011941.1513050-1-jasonmiu@google.com>
Subject: [PATCH v1 0/3] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_181948_100435_1FEEB5FC 
X-CRM114-Status: UNSURE (   9.47  )
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

This series transitions KHO from an xarray-based metadata tracking system
with serialization to using a radix tree data structure that can be
passed directly to the next kernel.

The key motivations for this change are to:
- Eliminate the need for data serialization before kexec.
- Remove the former KHO state machine by deprecating the finalize
  and abort states.
- Pass preservation metadata more directly to the next kernel via the FDT.

The new approach uses a radix tree to mark preserved pages. A page's
physical address and its order are encoded into a single value. The tree
is composed of multiple levels of page-sized tables, with leaf nodes
being bitmap tables where each set bit represents a preserved page. The
physical address of the radix tree's root is passed in the FDT, allowing
the next kernel to reconstruct the preserved memory map.

The series includes the following changes:

1.  kho: Adopt KHO radix tree data structures: Replaces the xarray-based
    tracker with the new radix tree implementation and removes the
    serialization/finalization code, thereby eliminating the KHO finalize
    and abort states.
2.  memblock: Remove KHO notifier usage: Decouples the memblock subsystem
    from the KHO notifier system, switching it to use direct KHO API calls
    and adjusting KHO FDT completion timing.
3.  kho: Remove notifier system infrastructure: Removes the now-unused
    notifier infrastructure from the KHO core.


Jason Miu (3):
  kho: Adopt KHO radix tree data structures
  memblock: Remove KHO notifier usage
  kho: Remove notifier system infrastructure

 include/linux/kexec_handover.h |  44 +-
 kernel/kexec_handover.c        | 788 +++++++++++++++------------------
 mm/memblock.c                  |  45 +-
 3 files changed, 362 insertions(+), 515 deletions(-)

-- 
2.51.0.618.g983fd99d29-goog


