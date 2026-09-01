Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A899DC624D6
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lAVN67JT5h8WIfFlQUOkXfv2BuxQF89IX1lkYdIpCWw=; b=yZDJIAC69J7dKpyIgyEnvg5e8u
	hF+wRQJXvZN88yUGKe/H88I1lXGqTcXFKuPkBCbyEtNf10VeZ1zhSuubIS4jvvhwyUfLIKbKNh3cf
	1GDwpmkhiRFTAv+1j6w9mBQxkmRIWwSfgS5Ng2maV/S5sdRL1oyv5DGB+Cw06zRxu95qHo9z4zAKQ
	q6ByQ2+FJsAiaeBMHOTXP2duG5Yvg4vv8GYQgqm6RCDasd1neaq+yZHFXwUS7ChwEPX/UKKrbXhqM
	hF1dU5peD8GQmlYVgtXePz7hhKqsd7+gIkIngSyxkz3kqXq2nrsdcjEZJCK7TqtyoO9vl9nAEcveA
	vpwEkl6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StU-0000000CuyI-2gO5;
	Tue, 01 Sep 2026 18:07:36 +0000
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StO-0000000CutH-2631
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 18:07:34 +0000
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-39533bb224cso159372a91.3
        for <kexec@lists.infradead.org>; Tue, 01 Sep 2026 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788286046; x=1788890846; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lAVN67JT5h8WIfFlQUOkXfv2BuxQF89IX1lkYdIpCWw=;
        b=vLpVEn7gRbC5rcmzOuSdXdSpAo+9yXgLImywQ7cr6NBoTN5DKt170jDYKWdOXcMNRK
         TVH5S//gyTIMmzP4eUA+j/462tbTHVB4xw2+sdslj5C4fxN1NssZe18r7lGOJgpNFCyU
         1azjv/dUBNA8KUH8Puu9/HpBBl81hhr4Xz0M/Kf9R2ZqmzrxMWpQFhTCNFqj1PYT7wNq
         fbs0Eh0+5vU/hRC/W362/gOZs5MCokSlWsFZDIJkoyvDhBqhS0BpLL8tP0dVXH7qIcXM
         zCZbS6LiwmQnqpQlgmc/qOH5s/r6yXBv6DwaLZO9l+v9MSZ8/sykI5QcbVSomKatot3a
         kYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788286046; x=1788890846;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lAVN67JT5h8WIfFlQUOkXfv2BuxQF89IX1lkYdIpCWw=;
        b=rHU7hhqDPfo1TdeIrxb6oVzSfH+E6/rt3g8kuCXeB/9CjcvfUEuS71pOnrY9SYi7ww
         LHKwoBRq90c68uGrxMesy9O1S+qKgPrs9kZH7R1g1ZgVxxeB1L1RQKBn3xero9JrtXUI
         vcfjSpMGFY9FNMJkqpggIasoYBzb0K6FPfeXGl3bsaRxgZkiPMq2hNWugC1zIEXqFsZh
         I1IXkFoQy2X3BKy5Ex1lA+3nLgIibGqFVGjUnDOt7G0aqKPXLkHL23atQlvASvGCXikX
         V/9Al/cXxkyp6jg4P4VRjFvI1/4SO5E5XDFqYEJi8qhAQXdmkX/fEBmQ4iJXzUcK+FX9
         QeIw==
X-Gm-Message-State: AFuF++nhiLZ+KBpxE8ocp/Xx6khOswbtOisCbBGQXoQSCR429X4SyEwy
	Ys0n0/iTx2bDzw9GwSLXzNN1Uox2Ie1PTat2KK71Ml80PGZQTdXwGiO0wFhN7n6MTd4t5NXTds9
	tqX2yMO4E3x1yuBCKMeXDfY656SGnqzwawSzGh6npAnqCRZmeP51ACoT/HJD81ws+DEjno779Po
	1SE6XXD/WUsLCNix2Yk392cGTtSgFXEsjyRbTXYIFpASrRwrBo5rI=
X-Received: from pjbnu6.prod.google.com ([2002:a17:90b:1b06:b0:396:61d1:58c7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5544:b0:398:bd37:6a49 with SMTP id 98e67ed59e1d1-398bd376c65mr32646461a91.12.1788286043659;
 Tue, 01 Sep 2026 11:07:23 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:07:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901180713.4185641-1-dmatlack@google.com>
Subject: [RFC PATCH 0/5] liveupdate: LIVEUPDATE_SESSION_RETRIEVE_INTO_FD
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_110730_541984_64E245E3 
X-CRM114-Status: GOOD (  21.14  )
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

This series adds support for LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, a new
UAPI to enable preserved files to be restored into a userspace-provided
file instead of a kernel-allocated file, and uses this to support
preserving tmpfs files in-place without any changes to the LUO ABI.

The Live Update Orchestrator (LUO) API currently explicitly returns a
new struct file for every preserved file during retrieve() (e.g. via
memfd_alloc_file()). This then forces userspace to use anonymous memfds
for all in-memory files it wants to preserve. This works reasonably well
for VM guest memory but does not work well for other types of files that
userspace may want to preserve (e.g. in-memory logs, binaries,
configuration files, etc.).

Preserving entire tmpfs mounts in-place would require a large amount of
kernel support and would effectively make tmpfs an ABI, which is a
non-starter (or so I hear). Instead, we can delegate the reconstruction
of the tmpfs mounts (directory structure, permissions, etc.) post-kexec
to userspace. The kernel just needs to preserve the contents of tmpfs
files and provide userspace a mechanism to restore those contents back
into a specific file on the filesystem after the kexec. Hence,
LIVEUPDATE_SESSION_RETRIEVE_INTO_FD.

An alternative approach to restoring data to a named file would be
supporting a zero-copy sendfile() that can be used to convert named
tmpfs files to/from memfds across the kexec. But this poses significant
challenges on the *preserve* side since the preserved file might still
be actively in use. The benefit of the retrieve-into approach introduced
in this series is that it does not require dealing with two different
files. There is only ever one file that owns the preserved memory.

By leaving file and metadata allocation purely in the purview of
userspace, programs can create the target files where they want, with
the names and security permissions they desire, before directing the
kernel to restore the preserved folios into them.

Currently, only tmpfs shmem files are allowed as valid target receptors.
Attempting to target populated files, or anything other than an empty
shmem file, will trigger -EINVAL. HugeTLBfs files could be supported in
the future.

The coding work for this series was done with assistance from Gemini. I
am not sure what is the latest recommendation is with respect to adding
Assisted-by tags, but I can add them when I send out the real patches if
this RFC looks acceptable.

David Matlack (5):
  liveupdate: Extract luo_file token lookup logic into helper function
  liveupdate: Introduce SESSION_RETRIEVE_INTO_FD API and core support
  mm/memfd_luo: Implement retrieve_into callback for shmem folios
  mm/memfd_luo: Expand support beyond memfd to all generic shmem inodes
  selftests: liveupdate: Add multi-session test coverage for
    session_retrieve_into

 include/linux/liveupdate.h                    |  1 +
 include/uapi/linux/liveupdate.h               | 21 ++++++
 kernel/liveupdate/luo_file.c                  | 66 ++++++++++++++----
 kernel/liveupdate/luo_internal.h              |  2 +
 kernel/liveupdate/luo_session.c               | 30 ++++++++
 mm/memfd_luo.c                                | 68 ++++++++++++++++---
 .../liveupdate/lib/include/libliveupdate.h    |  1 +
 .../selftests/liveupdate/lib/lu_utils.c       | 33 +++++++++
 .../selftests/liveupdate/luo_multi_session.c  | 56 +++++++++++++--
 9 files changed, 249 insertions(+), 29 deletions(-)


base-commit: 4e1b74c6004371b046338325011a47cd7ab9dcc1
-- 
2.55.0.966.g6673acef38-goog


