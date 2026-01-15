Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEE3D4663B
	for <kexec@archiver.kernel.org>; Thu, 15 Jan 2026 23:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dgz1DtuTuOXgXInLnCBHEUta7LHhfgJVWxb17yQm2vY=; b=JRGSFjPml8AcvlOlqw4Tq1Argu
	AvleoICQ1JLNRflz4GA/0UeCSyyPLsZCZaaBXgbIALB8P2YrGXWAxv0FOUlVYsH9vKuwks6ieI3Xr
	Fwe7jBetUvyAMz1I6z1mjmovrmaHncid1G75A69KNMO/5KHe5QiUcH5TljzSjL4nbor9yt+FS08mL
	vl2EhnvLrwv0V3/k8v7TX4d/VBC+y3SjtXWHNDw/HAKHs7K3T51GTw08DpEM1PEAYG1TOAdikJD4U
	pF4grPwo4HKuCH8KX5Sae/d5IVK/DYDLgGRmMjXWuSBFXrFLUzRfKGHIzD7mDh72EX3OedY9gdvIR
	tke2psMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgWKp-0000000DIDd-0S5h;
	Thu, 15 Jan 2026 23:01:00 +0000
Received: from mail-dl1-x124a.google.com ([2607:f8b0:4864:20::124a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgWKi-0000000DID3-2knt
	for kexec@lists.infradead.org;
	Thu, 15 Jan 2026 23:00:53 +0000
Received: by mail-dl1-x124a.google.com with SMTP id a92af1059eb24-12339eea50bso7627043c88.1
        for <kexec@lists.infradead.org>; Thu, 15 Jan 2026 15:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768518050; x=1769122850; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dgz1DtuTuOXgXInLnCBHEUta7LHhfgJVWxb17yQm2vY=;
        b=Q4jo7dvwMZw1cnjXIpj4pAKBJi6NbtOZeACXgCaFj95OUF+imE3xxhJ6mngBl9ELRy
         AfRVcJUnByf8zQFyKj/5bThY5DHJf4N7WMeg1J4lCWEPYX+o0hjRuPgm8iz7TcYvm4sH
         j+ZCkm3ovFMb91sOOZMo2uRj0a1ZD+VKzMDYChEIU3iQufZLB9RJ+zi75PvH2tIKM56C
         +AcNXXOwTK2SmyOZge0Be0PUkafuEFpV5bjLv0yqaY6UZSQwn6H9aS1GG7M73F79c2Zj
         /tXd5EFBOHvsBs0/+WkSmJ70pG27TLLffu3DR5Y6F73Ca7rl1ipmTgB9yMRgVGn7FiqZ
         B+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768518050; x=1769122850;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgz1DtuTuOXgXInLnCBHEUta7LHhfgJVWxb17yQm2vY=;
        b=QsI16KCxZtsfQaZwW5PZahz7mnfnLFXrzMmye5mB12M2VyALmDpbmZA4yycO+cI4PW
         gbZWf/YeEqcScYfvZZ+E3WDPcbfT7AJYxC4Nc8PAey0c+xIPAOB7cAp7xU+PPveftDn4
         CKg/EeDZ+JDwvkdWeTpkF03QQnQfOrkHeRAgu/SIdkBVnO/+Q8g+UATTTUsBf23aTZU3
         ErDu7O2V9ysyIFrt1lkl3Sylj/XJs1upkGaYGHoFxYKYwQW1B8Y6WRwMU3EV0wr/E8EN
         tLeH9MDoKsftYCzXihK79+LJdDuE/nurdTm2Nji3EAYZDEdCKvY3kSnaNnmYLwHihjz0
         YOTA==
X-Forwarded-Encrypted: i=1; AJvYcCVXXr+r4+FHFez89VeiSu/m9JNbrw6s/QRSwBcnhOx1I7fWdTxgnDFH7Ebm6D0vQaIQQlSZQA==@lists.infradead.org
X-Gm-Message-State: AOJu0YysIHQ1iY9G6OB+I/Z5B3jmSfSuUh5+s91j6Ownp8qVZJICch1u
	jYPk49e1SbizVg1kOMyeaZzssqIOK9PJCPkiJUY4KB9fOuG4iARsZ/ugM7oeJxRDjct6CEWpHgc
	M+SfMnMW8mJc9pg==
X-Received: from dlbdt13.prod.google.com ([2002:a05:7022:258d:b0:121:7b2a:193d])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2397:b0:11b:9386:a3c5 with SMTP id a92af1059eb24-1244b395f25mr900028c88.48.1768518050280;
 Thu, 15 Jan 2026 15:00:50 -0800 (PST)
Date: Thu, 15 Jan 2026 15:00:45 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115230047.1220580-1-jasonmiu@google.com>
Subject: [PATCH v6 0/2] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_150052_696367_46267BFA 
X-CRM114-Status: GOOD (  11.74  )
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

Changelog since v5 [1]:
- Cleaned up header inclusions
- Rebased to the latest linux-next

[1] https://lore.kernel.org/lkml/20260113053524.84186-1-jasonmiu@google.com/

---

Jason Miu (2):
  kho: Adopt radix tree for preserved memory tracking
  kho: Remove finalize state and clients

 Documentation/admin-guide/mm/kho.rst        |  53 +-
 Documentation/core-api/kho/abi.rst          |   6 +
 Documentation/core-api/kho/index.rst        |  18 +-
 include/linux/kho/abi/kexec_handover.h      | 144 ++++-
 include/linux/kho_radix_tree.h              |  70 ++
 kernel/liveupdate/kexec_handover.c          | 682 ++++++++++----------
 kernel/liveupdate/kexec_handover_debugfs.c  |  23 -
 kernel/liveupdate/kexec_handover_internal.h |   3 -
 kernel/liveupdate/luo_core.c                |  12 +-
 kernel/liveupdate/luo_flb.c                 |   2 +-
 tools/testing/selftests/kho/init.c          |  20 -
 11 files changed, 560 insertions(+), 473 deletions(-)
 create mode 100644 include/linux/kho_radix_tree.h


base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
-- 
2.52.0.457.g6b5491de43-goog


