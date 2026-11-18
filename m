Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B160A260A
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=37fxj7w2;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=kse2xzMM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=RinnfRqFmJMbnCr6d3DXp7w2qk/BhwlH7a68zOSwViI=; b=37fxj7w2OY9uDHcw7+HCuogtuF
	qi2vHJLZl41/OkcTGq1BJQ3xRuF9A0Xy7Dw5bMhQqamjZkA947ZCx5/Zd/3fQUccCLUF2WSYT6p0U
	57YPEEGkp+gX87f/7yOOIhtWzgFK9ENRmOVCJJtyf1cOF/sGL3Zs0/LMrwDOp/pCDN0DFvoVZDLJm
	CdRAC0Le8Hwdpxoxen67AySFT7X0ediuytm/TFmLDZ3MkdNhwwZ/fkTLKCHQ+0m8JTZ6H/k2tVdVV
	pkufYuzQ/qHC8StftbLDaSxpIh+xE7cdmqf5RV8+k64Xr2z7FaWedGcV87B/aP/xTuX5xBemIKFoL
	uv6gfSiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD5-0000000AJbQ-3445;
	Wed, 18 Nov 2026 21:28:57 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD0-0000000AJaF-0Zqi
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:28:51 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-990703f817fso784784241.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 13:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795037329; x=1795642129; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RinnfRqFmJMbnCr6d3DXp7w2qk/BhwlH7a68zOSwViI=;
        b=kse2xzMM9DJK9Qu0g6f9Cnf+zDSxuzwd8Tv1TOJsxzXYTcd0Ka8FjHKuTMd0905PCE
         ZzFWRkotp8saiSaXh6GE4yYmDGNzwy9rPG58ERdyxbJKJ3HQNMUYTM6KTCLCAdyASQta
         TmZJwin266p+vEspRDhNHcTS6aWvD8XdeuUPUjoHll60SvEQWiCLxbS1tIQnUQ2KGVO1
         57r4xplk5bMc1EiHNxyufFMNAB/n3i4DvbDrO+DrK39JNfHwAG1bFE7zIC3dwWrAEItE
         7Ombm5398K+We9JnMGGssydgup0DRdtMMRtWuV9DrCnkZWmkEX+t8iS6CrDzIoGkeJoZ
         tNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037329; x=1795642129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RinnfRqFmJMbnCr6d3DXp7w2qk/BhwlH7a68zOSwViI=;
        b=i1zN2vhoNTh5nXeRQ6UDX3UxcgCsMlLE1EMl5TmTwmjT2xJmqB/Ggf+9QSSldBh64a
         KdVDKMrGXB9Dg15BK09fmXrypJo6MbipGmphSI2O9VbnirUORyWehkovWY46z3vMTRdh
         czOezB7M8XPeqkMKcksgYN6CYoK8QlhNqQZIHo7RMkrTuFcC1Ktgfd/bWdLqnom3wFBN
         xmZWZ1CIXz2MlGASicdWAOUd4jJwLEHBEqEnrWxdQsfj0IHDBtVqRBIVv8NKnhIQs2n8
         El5BBdTsZ/yK9ZWa5WeNycDzX4nGdis5bN9H373gpbCinZYXzj/sSbkuiOm1R7MYLPft
         AjZw==
X-Forwarded-Encrypted: i=1; AL+hErF2PUZuF9dBXzaJTI5hJZSvpMtjk6f3cMjVCcAmp5v7AJwxp1X2xkF6fYsy26sSGaMwxqfhmA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/fkHKJUaNtBd/CT8zDssqibo9AzNzLorO3o8X0IErQLvlE4Yt5
	UiCQnCbiKvwCrMEp7uoI+SdVppAOCAcOZAVp/GF0r246xG8IMPBTZekldr+JH4CLY5zkOuqKB/Z
	fmKUB
X-Gm-Gg: AYBFou0jC6rdIrX360vd/ChnT1T+1cgPyhBf3QGpBoK6eqpv7O2oG+xDztymwTnxm3B
	cd2TXLdMoh41n9qjbAaZGZoPDuwOVTSToS6xv5acOUjHbwUHc9NuYsSGyX1Lr/WDkTpcCymkF13
	JMf30qbTW4IOPjpyiEQa45t3Mm+X3CCG8rhtj18TnDxcM4LuLTe7b6IFeGCJBVtPw3bfmPKDWs6
	AfjBpVj+bDGxCukbHr/fH401agGe84VwpbNpwbhV8Ux6OGGatUd2QbYL5Xacx0CZ6Z/QalYj529
	YDMdGlf7hviiB6cRQ5bS32qB45q0NZfp73JgaYTVcCz76690xZ41rhewiXlDo3hlTteOFCIGRGm
	bcv45wdYy2U6ShBAYqf8M3eHc2QiiUomXbMyg5XoKVcnJ9wPFuqUlcvhNLaIeXEw74gwodeKJgu
	0/6nCaLX+TNTP9F8rwdHCzgHl/ndyUb7x1qSqbFuHchkyssRV+za303gUs1BOrX7sjtDOAaBI03
	GRJsaDRKh3jsQiJ2pgzgBvwZyfv2ud3uePk+rJFjjUypH1HRZ9ohyQswkLRlxkhTTQSahXxB+nq
	rP2r1D30IWcLnHGJMBfRrrYkqGtFRnQAc0TVnR9gLjiGKuUxnjKPlsZC3bjy0zGI7J1kC8uQzN4
	9rmcWMp17qChp5iCVawijkrp6M43FEy+t4qjZPalqTFn1FRvl6f0q
X-Received: by 2002:a05:6102:4455:b0:7cc:25bc:3b30 with SMTP id ada2fe7eead31-7d6ba438d36mr1283355137.21.1795037328579;
        Wed, 18 Nov 2026 13:28:48 -0800 (PST)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9185bc3sm2724635137.5.2026.11.18.13.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:28:48 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-api@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v6 0/7] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
Date: Wed, 18 Nov 2026 16:28:35 -0500
Message-ID: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_132850_235398_B9917D9E 
X-CRM114-Status: GOOD (  10.38  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds the LIVEUPDATE_SESSION_FREEZE ioctl on outgoing session
FDs. Once frozen, no additional files can be preserved in the session
and repeated freeze calls return -EBUSY.

Currently, LUO freezes sessions only during reboot(LINUX_REBOOT_CMD_KEXEC),
serially under global write locks. On hosts running multiple workloads
such as VMs, freezing sessions early under their per-session mutexes
lets workloads freeze in parallel as they pause ahead of kexec,
reducing blackout time.

By default, session lifetime remains tied to the session FD: closing
the FD before reboot unfreezes and unpreserves the session, while
keeping it open skips late auto-freeze at kexec.

Userspace can optionally set LIVEUPDATE_SESSION_FREEZE_COMMIT in flags
to serialize the frozen session and its FLBs into the outgoing KHO state
immediately and transfer ownership to LUO until reboot. Committed
sessions survive closing the session FD, allowing processes to hand off
preserved state and exit prior to kexec.

Overview:
- Patch 1 decouples luo_file_freeze()/unfreeze() from
  struct luo_file_set_ser.
- Patches 2-4 add lazy block linking in kho_block and incremental
  serialization for LUO sessions and outgoing FLBs, dropping the
  separate luo_flb_serialize() pass in liveupdate_reboot().
- Patch 5 adds LIVEUPDATE_SESSION_FREEZE and
  LIVEUPDATE_SESSION_FREEZE_COMMIT along with uAPI and core docs.
- Patches 6-7 add unit and multi-session kexec selftests.

This series is based on liveupdate/next commit 079c138d2b68 ("Merge
branch 'lu-pci-preservation' into next").

Changelog:
v6:
- Rebase onto latest liveupdate/next (079c138d2b68).
- Replace "publish" terminology with "serialize" across the series (Mike).
- Drop kho-ro concurrent-reader prep (ordering helpers and
  kho_block_set_it_append()), deferring them to the kho-ro series (Mike).
- Tighten commit messages, docs, and address remaining nits from Mike.
v5:
- Rebase onto latest liveupdate/next.
- Replace reserved field in struct liveupdate_session_freeze with flags
  and add LIVEUPDATE_SESSION_FREEZE_COMMIT.
- Add incremental KHO serialization support in kho_block, luo_session, and
  luo_flb so committed sessions and their FLB dependencies are serialized
  immediately on freeze, dropping the separate luo_flb_serialize() pass
  at reboot.
- Keep luo_session_freeze_one() / luo_session_unfreeze_one() in Patch 1.
- Update Documentation/userspace-api/liveupdate.rst and kernel-doc.
- Drop v4 Reviewed-by tag on the modified freeze and selftest patches,
  and expand selftests to cover both uncommitted and committed freezes.
v4:
- Split out a preparatory patch that drops struct luo_file_set_ser *
  from luo_file_freeze() / luo_file_unfreeze() and moves file_set_ser
  handling into session serialization helpers (Suggested by Mike
  Rapoport).
- Few more nits from Mike.
v3:
- Renamed session->frozen to session->user_frozen, - Pratyush
- Added Reviewed-by's
v2:
- Rebased onto liveupdate/next and split out early session freeze into a
  standalone series.
- Dropped struct luo_file_set_ser * from luo_file_freeze() /
  luo_file_unfreeze() (Suggested by Pratyush Yadav).
- Unfreeze the session's files if luo_ucmd_respond() fails in
  luo_session_freeze().
- Updated reboot-only wording in luo_file.c kernel-doc comments and
  added incoming session -EINVAL / invalid flag selftest checks.
Link: https://lore.kernel.org/all/20261105050053.3063001-1-pasha.tatashin@soleen.com/ # v5
Link: https://lore.kernel.org/all/20261015093816.2438942-1-pasha.tatashin@soleen.com/ # v1

Pasha Tatashin (7):
  liveupdate: Move file_set_ser handling to luo_session_serialize()
  kho: link outgoing blocks lazily in kho_block
  liveupdate: luo_session: support incremental session serialization
  liveupdate: luo_flb: serialize outgoing FLBs incrementally
  liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl to freeze sessions
    early
  selftests: liveupdate: Add unit tests for LIVEUPDATE_SESSION_FREEZE
  selftests: liveupdate: Test LIVEUPDATE_SESSION_FREEZE across kexec

 Documentation/userspace-api/liveupdate.rst    |  20 +++
 include/linux/liveupdate.h                    |   2 +-
 include/uapi/linux/liveupdate.h               |  38 +++++
 kernel/liveupdate/kho_block.c                 |  38 +++--
 kernel/liveupdate/luo_core.c                  |  10 +-
 kernel/liveupdate/luo_file.c                  |  76 +++++----
 kernel/liveupdate/luo_flb.c                   | 102 +++++++-----
 kernel/liveupdate/luo_internal.h              |  15 +-
 kernel/liveupdate/luo_session.c               | 151 +++++++++++++-----
 .../liveupdate/lib/include/libliveupdate.h    |   1 +
 .../selftests/liveupdate/lib/lu_utils.c       |  13 ++
 .../testing/selftests/liveupdate/liveupdate.c | 107 +++++++++++++
 .../selftests/liveupdate/luo_multi_session.c  |  36 ++++-
 13 files changed, 473 insertions(+), 136 deletions(-)


base-commit: 079c138d2b6870bb658b6e638077264aefc03833
-- 
2.56.1.708.g77570a6a1d-goog


