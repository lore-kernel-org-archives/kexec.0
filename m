Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850B5CC6B3A
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0shlhRLFxXQ3R4nNuzOyegjpP8vI4RmInyPqxYDwsw8=; b=QQkByoMc3gY5NTFdIS7286ezTu
	eaQbJtyjx2Foi3kUCsaSGsWHmr2ssjQacs4bobtQ2Fn5QauAmTBGieXm5jn0I3kVWSibFf5wfW3HL
	wfp39m+Tv+904xyFSR9/+v235BD/13ExXU3wsGaVYid3qJKc00gbyTXBbz9WpHE6f4MhCZGGwanSG
	oskuNPDMZu/GezQEY7qVPpSbczjvkDkE6fjC1C+XGVmNAEHM0nMwhFRvxipjE66pTvG7ga0+io4Lj
	wlfsc8rgMu8MiHIhmIBuVgF9eEOmI2JUXR/eSrZdai6ExsHIr7py9kJR6Aa8WjDFLwnW+DCHP4TmU
	6azM6aFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHut-0000000HHy3-0odY;
	Thu, 15 Oct 2026 09:38:27 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHuq-0000000HHxP-2zhx
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:38:25 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-5e91e422859so2504342e0c.2
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792057103; x=1792661903; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0shlhRLFxXQ3R4nNuzOyegjpP8vI4RmInyPqxYDwsw8=;
        b=PCYoY6yrfDl/wgJ7ZQ31E3o46CcopJ/zEVOn/XpfEAPva9qzvl6Vhi/Ia6cVeD9tty
         cJpPZm5BAQvXcbpgrhn7g1JUB3rgXjbmGPwGbCrzuA7AKXsCDSlfioRDc4iSbHwMoZMp
         La5GewjQi4cnmR/2bXuSmEUpSxwEZyEtqtGxTrw7XZWht9e86rEPHAnTt4PXlz8PPqZD
         e8/XTP11PYGVO/FYjTeQ3Cl223ukbnuOVqrMmDPrAFcwvKsa+DC7kn84AQQv8oS8pjak
         QlgzYFr1Q7kn8VDIYvSvQAYgfhLmdKO1IZMKphUGTKoF0ZYm4PvPnCTjRvskcpXbN3tn
         5paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057103; x=1792661903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0shlhRLFxXQ3R4nNuzOyegjpP8vI4RmInyPqxYDwsw8=;
        b=UwrHDFzw4AD2vBjwfVoR+2OY7jqqr0CNCIANtBS50L6e4ZAoxaFweJjGrxmtPsBNpc
         Vrw7Ii3LkFwku18KRPsxoquZeelOPyMCBKwf1OandeGxsNFy3uQoTwy/EhMAHbH8pa30
         IlJs1FdfQD6kUxoTgfrYUFj0yvAiIG/vlMm3GUIDBt24+OSok8g1Y+n6C765evmNj9WG
         gBgy7c7gtM6WbyuHa8BqnKe7O7zw6G6fa/pEaBWl38KWJBYyAZ6uGstR2gHCW/xZmH2c
         LkGlG4HWgP+hPjm6XPTGJw3z5fTmBuuaAl6QvJbofNzWD0YRExqy4Hzl1CGcawsKfQLQ
         9gbA==
X-Forwarded-Encrypted: i=1; AKwUvBxGNJN+6y1wFgu9XY/MRt80s8abX6PqXMFWmB2Bvlr9e5fXYJd0Tf65a0ZXv6Nc6Nj4QrzVnQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYK4CBSPwGhRtRDev6dWPy+VuHT3sWagJr4rcNzUNxbtiozhKe6R
	SyGV3tAJMVVhzjIrGSib2o9A+MJ7rO4ExZ/UpWKyUnTeljtl8fO3VzdZJjplNFm6TxM=
X-Gm-Gg: AYBFou3/AGu/wvGRlf578j0980JSIsrwQC4GgzVbTOATwZiIL5c6WZV2/sGWTNVjOtL
	NRApeusQQrTeaKWC3TJ1/RWdlniFF9i2e9Dr5Vm14r29PYcC/P4fmLtSyS9xnbPd3mw86RxyfVD
	5+sN+f4e5aFRb+pWdAMZCmjOhxbgJZuy044DayI+M6wq7Zbu1DrJeqkV+QfzOghmlVWcVQemAfh
	1LYgOIuaFTzHqeNE6JvGyTykB6ld0fnr6ixwUKlvYmwprmRVLeLQnyf0L9NBYgOdaYMoZWaKTVZ
	gJzXVqYvWKFmo6TbkyKp6Ux7DktBth2dBR+3y5VFBdW0KJtJuF265x6vZrOiO6sXJvXDq7cIq0N
	rfPKBD4rqQSuL9NH9ktWaHHBHQo5S/aGIHwIim/qBQ0r29FWBBeBBb6Xwxf62phQ0hUb3CsuYAY
	0/dqQD4BMxCaBucOnu9PpJgzeFd0jVs/iY/0/6xSrvqYAuW1Hbz5bLoOC1opLf01YusFLfhCCHd
	RwZ55qOsGGylvM98sw+ECAc9MQgzCWfU347Qq6c1BU5v1eJ1IA5XIqeN/JCT5Hgv3zzvmysGvpR
	a2INa9Cb5/Ka30tuNlM=
X-Received: by 2002:a05:6102:14aa:b0:7bb:81de:ebaf with SMTP id ada2fe7eead31-7cb372b60a2mr4935421137.15.1792057103138;
        Thu, 15 Oct 2026 02:38:23 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003d37009sm12275672241.2.2026.10.15.02.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:38:21 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [PATCH v1 0/7] liveupdate: tmpfs preservation and early freeze
Date: Thu, 15 Oct 2026 05:38:09 -0400
Message-ID: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_023824_785304_BB868C13 
X-CRM114-Status: GOOD (  10.85  )
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

This series allows preserving files in tmpfs via LUO to survive across a
live update, and allows userspace to decide when to freeze a session
instead of delaying until auto-freeze at kexec time. Once userspace is
done with a session, it can freeze the session immediately (and across
multiple sessions in parallel), reducing blackout time by not postponing
this operation to kexec shutdown where all sessions are frozen serially:

1. Early session freeze (LIVEUPDATE_SESSION_FREEZE):
   Currently, LUO sessions are frozen automatically only inside the
   reboot(LINUX_REBOOT_CMD_KEXEC) path, where luo_session_serialize()
   iterates through all outgoing sessions under global write locks and
   freezes them serially during shutdown.

   Add the LIVEUPDATE_SESSION_FREEZE ioctl on session file descriptors so
   userspace can freeze a session as soon as it is done with it (and freeze
   multiple sessions concurrently, since luo_session_freeze() only acquires
   the per-session mutex). During kexec, already-frozen sessions skip the
   late auto-freeze step; if an early-frozen session is closed before
   kexec, its files are rolled back via .unfreeze() before being
   unpreserved.

2. Per-file user argument on preserve and retrieve:
   File handlers may need handler-specific context when preserving or
   retrieving a file descriptor without introducing custom session ioctls
   for each file type. Whether the argument is required, optional, or
   unused depends on the file handler.

   Extend struct liveupdate_session_preserve_fd and
   struct liveupdate_session_retrieve_fd with a 64-bit 'arg' field pointing
   to a handler-defined argument structure that begins with a 32-bit 'size'
   field. Because IOCTL_OP validates a minimum struct size up to 'token',
   existing userspace callers passing the 16-byte structure remain
   backward-compatible and have 'arg' zero-filled by
   copy_struct_from_user().

   Add parg and rarg (struct liveupdate_arg_spec) to
   struct liveupdate_file_ops, initialized via LIVEUPDATE_ARG(_struct,
   _min_last), which records the full struct size and minimum required
   size while enforcing at compile time that the argument structure begins
   with a 32-bit 'size' field. Core LUO validates the minimum size and
   copies non-zero user arguments via copy_struct_from_user() up to the
   handler's expected size (or rejects them with -EOPNOTSUPP when the
   handler does not accept an argument) and passes the kernel copy to
   .preserve() and .retrieve() in struct liveupdate_file_op_args. Also
   allow .retrieve() callbacks to mark early argument/target validation
   failures as retryable so userspace can retry
   LIVEUPDATE_SESSION_RETRIEVE_FD without losing preserved KHO state.

3. Tmpfs file preservation and retrieval:
   Using the file handler retrieve argument, extend mm/memfd_luo to allow
   preserving generic shmem-backed tmpfs files (not just unlinked memfd
   pseudofiles), recording MEMFD_LUO_FLAG_TMPFS in
   struct memfd_luo_ser.flags so that preserved tmpfs files must be
   retrieved as tmpfs files and preserved memfd files must be retrieved as
   memfd files. Introduce struct liveupdate_memfd_retrieve_arg so
   userspace can pass a writable, empty, linked tmpfs file descriptor via
   the retrieve argument and have the kernel populate its address space
   with the preserved folios.

David Matlack (2):
  mm/memfd_luo: Support tmpfs preservation and retrieval
  selftests: liveupdate: Add test coverage for tmpfs preservation and
    retrieval

Pasha Tatashin (5):
  liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl to freeze sessions
    early
  selftests: liveupdate: Add tests for LIVEUPDATE_SESSION_FREEZE
  liveupdate: Pass user argument to file preserve and retrieve
  selftests: liveupdate: Add tests for preserve and retrieve user
    argument
  liveupdate: Allow file handlers to mark retrieve failures as retryable

 include/linux/kho/abi/memfd.h                 |  13 +-
 include/linux/liveupdate.h                    |  74 ++++++++-
 include/uapi/linux/liveupdate.h               |  59 ++++++-
 kernel/liveupdate/luo_file.c                  | 152 ++++++++++++++----
 kernel/liveupdate/luo_internal.h              |   8 +-
 kernel/liveupdate/luo_session.c               |  58 ++++++-
 mm/memfd_luo.c                                | 144 +++++++++++++----
 .../liveupdate/lib/include/libliveupdate.h    |   6 +
 .../selftests/liveupdate/lib/lu_utils.c       |  71 +++++++-
 .../testing/selftests/liveupdate/liveupdate.c |  84 ++++++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |   5 +
 .../selftests/liveupdate/luo_multi_session.c  | 110 +++++++++++--
 12 files changed, 695 insertions(+), 89 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.56.0.385.gd3acb90ef8-goog


