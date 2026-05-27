Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FB0CD4F54
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XfG74yb7m7iVSF1OU8kZWQGRNxCvzlkYkbl7fdZoHYs=; b=w72oM2mOCJWlC5v3Set6jQrID9
	Cu63jEYSHQ0h0+/nSeBszA4jpqwOGFFz0XebBlqtD3H9DXKHjNtptbJwMdwKDtcf8hYF7THJIJFqy
	O6RexgPiN6WS7gMBeUbv3UOEjaB2YfGu9pa7ov5duid/W16xzZv+PlcZZKiuGtHKj6KOfx6Wv5FV0
	NWtL7ZLtbvypgDfsevsvHRZHoxHOVRNF5e6nEonqEP4Cv3Ceu7v3/g0JvDDBeMxL3ZCsFcoaYaNyy
	q6/QDBCxHm7YWRQagiBsiyAnaAJftKRgVyWidgXQ08nL6bSgQVGzjVH0C3KsavRy2AlkPjje5wG3U
	jM0f2gJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqt-00000004iZH-46PM;
	Wed, 27 May 2026 20:27:43 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqs-00000004iYg-16f9
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 20:27:43 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-516cc597842so33945341cf.0
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779913661; x=1780518461; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfG74yb7m7iVSF1OU8kZWQGRNxCvzlkYkbl7fdZoHYs=;
        b=AM08FX0eOn81cqASHSLsIbDJlCyFjkUiWtSXlwgB10bAyfc0t4lREeGybNn635dRty
         6I0WPPLy6YLdoDk13k2AIRi7QDS5bSVjRoUXOYiMVDGQEmDUnyfghzA+6CU2ONSnff1M
         e6pdHqtNICxfACibZWYdKe6L8erX6Ivedx7yYzNFx6G2kXz5Y2+3QrLaLIq0wrtxvyYd
         NrMa50CQ8sF2BcseUSDj1jwDaEUMS+fccoFVwCwTFODR3nEN6S+fJUjAAw93nJ81+XrX
         f0rlArvlKVsTg881RZKEjvK7BQ6BGit5bWO1HTtOVJ1bBqxWNUEu10H2et1ItMP6zS4K
         n3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913661; x=1780518461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfG74yb7m7iVSF1OU8kZWQGRNxCvzlkYkbl7fdZoHYs=;
        b=r/Zavtbm9ZzMBXZxIOFY9ph1h+ozImu/ldkoQJlyzuYIWf8kVQEos+16LNqyt+rPy5
         YGu4I3/fTsyQAitll0Y73P/7Wim6i5H8gUDbxOyHgOcYHJ9lmbnO1CXZbbubqkszSSMq
         0bCD7+tkygMwq9t2s4aUj/dmd4L6FDnTIWlio2Xd10YbYmeb7Pjc6wB/bHbWINMOoQKk
         X5wSFe1nFx+RnmJvJkVjZHK3GwJVKtVOfD03p/7ZpE7rZsMR0zZ5yjIhMjCGABGL1UuE
         40IlQuPJFVYLT1HxvaZ5RiccHg568om9UvgJLz2AxMkW3uprf1uhMA4YF7R7lNeMuTCY
         +eWg==
X-Forwarded-Encrypted: i=1; AFNElJ/qCnz8uj78J6uOKvEH8XQgALjzSdBZ56hyzZ1f4pmkEOyEIyGhM7JZm65wwKEsTz+cOTtUdA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz8/Z2J/l1uxd494ZoC/NlUM0MEix75s6m7AgRs9Dxg2u0QONcE
	f7XfWH1a5nVRnfgER5nCD43WpyCZ0OzNk7PMR+rHdWwQxHD1eYHA5sz4D5tpN7yxn1U=
X-Gm-Gg: Acq92OGYqwVePjKn2HuUo/VPQdtWE0kouPQ1L/BozDu1lgxPZ+uYeCvZfO4JrM4hIb3
	snKfrnD249+wb5Nt0xka/U5+Nq6Px/+6h5fWVc3KnN0kafamYh1JDyuV5ReVebEpULfTOR32gz4
	BCTjKjnbvxKFYzhMPvy5Bl0DlKHtG0QbLfc+xftnCQb6kf7KCMRJmwzZiiHloVjCVwy0+UNKfD4
	l6ocvxa2QrEx6bv495soshgbM680gRFqD9R8zhYNTlQiJfhLfO0zDMS+LxZnEvvEGXplo3vGZf9
	N0Vy9ZC3XjVvTW/7jm9IVtL5sK4n+KYYlhOL/F/pp72QbMYhIgW2jAuL59pvAcBzgVFx6MUWEI+
	yU8qqTwP/V4dYJaxpS3DQw5wCLW/CROp4c+mur9tCkfCyVRC93FOuR9l/nUzKhRA4v7VDV5p2dL
	zWWSBZobLhyYNPJxLal+dcSI+Ap1DtRx4r4kIVC+nkXmA4rPQy1CB7nkNsTNcSnA==
X-Received: by 2002:a05:622a:1343:b0:516:cee1:4727 with SMTP id d75a77b69052e-516d42d9774mr334556231cf.14.1779913660472;
        Wed, 27 May 2026 13:27:40 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069ecb93sm58632971cf.4.2026.05.27.13.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:27:39 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	error27@gmail.com,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v6 0/5] liveupdate: serialization safety and race fixes
Date: Wed, 27 May 2026 20:27:32 +0000
Message-ID: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_132742_309916_300E153A 
X-CRM114-Status: UNSURE (   8.68  )
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

This series addresses several issues related to the synchronization
between the reboot process and LUO session management.

1. Skip LUO serialization for context-preserving kexec: A
preserve_context kexec returns to the current kernel, which is unrelated
to live update where state is passed to the next kernel. Skipping
serialization avoids unnecessary work and prevents sessions from being
left in a frozen state upon return.

2. Fix TOCTOU race in luo_session_retrieve(): Extend the rwsem lock
scope to prevent a session from being released between lookup and
mutex acquisition.

3. Block session mutations during reboot: During the reboot() syscall,
user processes may still be running concurrently and attempting to
mutate sessions. To prevent this, we introduce luo_session_serialize_rwsem.
All mutation operations (create, retrieve, release, ioctl) hold the
read lock. The serialization process holds the write lock indefinitely
on success, effectively freezing the subsystem.

4. Fix use-after-free in luo_file_unpreserve_files(): Reorder module_put()
to ensure the file handler module remains pinned while its operations
are being accessed during cleanup.

5. Remove unused ser field from struct luo_session: Clean up the
session structure by removing a field that was never utilized.

Tree: git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git Branch:
luo-reboot-sync/v6

Changes in v6:
- Added lock hierarchy documentation (Pratyush)
- Collected Reviewed-by from Pratyush Yadav for patches #2, #4, and #5.

Pasha Tatashin (5):
  liveupdate: skip serialization for context-preserving kexec
  liveupdate: fix TOCTOU race in luo_session_retrieve()
  liveupdate: block session mutations during reboot
  liveupdate: fix u-a-f in luo_file_unpreserve_files() and
    luo_file_finish()
  liveupdate: Remove unused ser field from struct luo_session

 kernel/kexec_core.c              |  8 ++--
 kernel/liveupdate/luo_file.c     |  5 ++-
 kernel/liveupdate/luo_internal.h |  2 -
 kernel/liveupdate/luo_session.c  | 67 +++++++++++++++++++++++++++-----
 4 files changed, 66 insertions(+), 16 deletions(-)


base-commit: 3a29a9841f4bfb79840f7d1f8115cc7b25e744e3
-- 
2.53.0


