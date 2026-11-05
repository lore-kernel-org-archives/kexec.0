Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B2606D80D
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lsZELtF7;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=ZlCz2kDU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ehAwqn1JpFtE8NSK2eGRtzEx7P6AYMWxr9u3z+M2YhY=; b=lsZELtF7gxbxuYboyknlMlDeUP
	Az3oUXu8cK781I4HBqNxeqPG30RNkaub0BZbOBQX9G6Am8UaIRwZgAWeAhU68QhJ3hsOpNV+8QkBG
	F7PCG4KHW1Q6qLqZO+/hMzEflBZpKdYLotY9IgnezZQoKdzn2M3SFhO2oydUyxyn2lrMp02GfCU7G
	Vjtbkblsbnet5ejLRzVHLWKYBA44rfgZVzix3u0+bdiX8a93JFptlay2oTc5AfS7aYpF2MByUUleU
	Mkdwt50c2cu3XOz55ryYbMmYXFtXRFC1LBLE4gsDbFvJVsKJcOTcGyE6z3Nc04do6zxsYN+ZrLUSv
	IliC/KbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpav-00000007ppD-2foC;
	Thu, 05 Nov 2026 05:01:01 +0000
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpas-00000007po5-3DaZ
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 05:01:00 +0000
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1112349e0c.0
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 21:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793854857; x=1794459657; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ehAwqn1JpFtE8NSK2eGRtzEx7P6AYMWxr9u3z+M2YhY=;
        b=ZlCz2kDUCj8lrJM/C8mpfo4ibrymrD8dO2+9b5pxNZlON1GwbG27ge+QAYx15dKenz
         RV6918k8zs/PgpI26ZGK4H+dSU7OrRQlYp65OKEEkjNIwGunXSR4LQ0xkzm8NYRwrLQY
         rUuQS6tuBsOQp9BO9YnieAuBD8P2O2C/6EquoiA6gytLBQ8mCby3A6cqaRXLrT+mxppo
         xUCAXKzyDASrTiAHGpEB7ZvVWB3rSmSAjRO/ZvVaUGA+o6rWLiZqvXqhCHhjaMG9B7hX
         Z7zrMcYrs9io5rdQ+rAiaCIxXvBb7tuaA7F/70sYRjOqxZZ+bytapmKn8KIradFMmq+V
         Cx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854857; x=1794459657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ehAwqn1JpFtE8NSK2eGRtzEx7P6AYMWxr9u3z+M2YhY=;
        b=Fkb2uhtKFt7/blWpcVxlqpYDIpvQbaFW3eNEgjz2Y2naBL0kwkr7Zx5AFZjGk/uiuU
         scwqKmzMUZEA04N63G+hpRi9Xb8NiqMzoX9/UNh2HZwOqxaeh7Kr8Wg/uw/xFN5rbuQi
         lw1zaGyWkas+Stak6QMAoCvb6BTNcRizufDjzn1y1T0mI6NXq5bHv8TKEiaRfLfRNYzQ
         zf7vY41xeHJe86vqD1R8BLNdqaWcNubzFUuWA1by5cAoGCSqEiCgFZ9ZO991rphBW5J/
         zrdzKiXRcsYMefJwiS8DNNV2F/ydeFyhgYI7NGIk1dIfaEYyWrOot4MAif+VGFf/1xxo
         Obqw==
X-Forwarded-Encrypted: i=1; AKwUvBwqf4NCWvt+0bfidEFwLUFgeWpH+tDO3F6VW7XnWmMHQZFyDT1OKVQI6vvtVkYjMb+Lpcs66Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z9Fh6cwLwUbVJP/alMDVI8ZPPE4MZw2p6ZTv19cwc1AV83oSKHh
	s1E+rPCPWryAPPyFMU6jUsbgwMY73YlgpodjytyAjKWAQXxwQ4y3KBb1cWTzCjeNTTw=
X-Gm-Gg: AYBFou0m3/vCnB8AqvhgJBMe0Eb3Rr4dRyMLGgOAET8foErbiAP5V/GbyohFVC88MLh
	Os/rcMFkjTD8vD9bzDZzp7sSOUYhEKTcA8V9f2Wec/0BRmrAoE9xY+v37Zy2uEUF0p0Rrn2rtY5
	dpnJ6Ukc800fVQCvQqBYxUb49gVSrBRi9nGvXIugvkdWGmn/Yk6v8geiQto8F9xc0pCXOIJyGgE
	hhBbixUuz67dFfTsw41Xs/KAwZ01vG4wbke/LtLlf7FcocX9dpNc5cVJidLcdKwERmql5NJSDGU
	9AWcgOqMsitvEjZ19rknJUwSCkqbFVNqaN9hedH9Tmw1Sx7UoDX0qmV+JBCOqmFytQtEYF1P5VR
	m0r2oW2JciCIm9D75RyZ0W6qQJOfFPyFcsk0+WVIdhvgUTxAJOX+kaQCxtjOQbYylJ5vlHGGGnl
	OZgFSzFfwGpFvVzWND6OldgcaCeZHxufBktV9gY4czg3iLI3vunNQWscmvVpv6zeN8GwvOqOMlg
	oVeOl9Mdhi8hVHrYfAKKBq9t/7iPswdRMooPYBKjKkL0zseDpMxAzSKnbfpKgQW/Up+yL6/IfI1
	DWbpTdxd0ywGigz2fL407J50+FpwhgLnW0n85ZJDGIUV3pDwsafaougP4bIRFJ8H8pI2hvoH7qN
	42Yd2VbLdxD2vwAdvOXJjW5Z2MLs86UkRIehJwGQQR+24ohfUhg==
X-Received: by 2002:a05:6122:6984:b0:5c9:a60b:e5a6 with SMTP id 71dfb90a1353d-5ec689bbc49mr8844831e0c.17.1793854857202;
        Wed, 04 Nov 2026 21:00:57 -0800 (PST)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm3305282e0c.8.2026.11.04.21.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:00:56 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v5 0/6] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
Date: Thu,  5 Nov 2026 00:00:46 -0500
Message-ID: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_210058_854422_F971F546 
X-CRM114-Status: GOOD (  14.80  )
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, LUO freezes outgoing sessions only inside the
reboot(LINUX_REBOOT_CMD_KEXEC) syscall path, serially under global write
locks, and binds every outgoing session's lifetime strictly to an open
session FD until reboot.

On hosts running many workloads (such as VMs or stateful daemons),
workloads do not all pause simultaneously inside reboot(): they quiesce
one by one ahead of the host kexec. Userspace needs an explicit
per-session freeze point to snapshot final file state (.freeze()) as
each workload pauses -- concurrently across sessions under per-session
locks -- along with a way to commit a frozen session into KHO so it
survives closing the session FD.

This series introduces LIVEUPDATE_SESSION_FREEZE on session FDs:

1. Freeze (flags == 0):
   Freezes all preserved files in the session under the per-session
   mutex while keeping session lifetime tied to the session FD. The
   session stays frozen as long as the FD remains open; closing the
   session FD before reboot (for example, to abort the session or on
   process exit/crash) runs .unfreeze() and .unpreserve() and reclaims
   all resources. At kexec time, already-frozen sessions skip the late
   auto-freeze step and are published into the outgoing KHO subtree.

2. Freeze and commit (LIVEUPDATE_SESSION_FREEZE_COMMIT):
   Freezes preserved files, immediately inserts the session and its FLB
   dependencies into the outgoing KHO subtree in O(1), and commits the
   session so it survives close() with full ownership retained by LUO
   until reboot. Once committed, closing the session FD (or another
   session failing to freeze during reboot) never unfreezes or
   unpreserves it. This allows processes to hand off preserved state to
   LUO and exit prior to kexec, and makes committed sessions immediately
   visible in the outgoing KHO subtree before the host reboots.

Overview of the series:
- Patch 1 decouples luo_file_freeze()/unfreeze() from
  struct luo_file_set_ser.
- Patches 2-4 add incremental KHO publication helpers for kho_block
  (kho_block_set_it_append()), LUO sessions (luo_session_publish_one()),
  and outgoing FLBs (luo_flb_ser_publish_one(), replacing the late
  luo_flb_serialize() reboot pass).
- Patch 5 introduces LIVEUPDATE_SESSION_FREEZE and
  LIVEUPDATE_SESSION_FREEZE_COMMIT and updates the LUO core and uAPI
  documentation.
- Patch 6 adds selftests covering both uncommitted and committed session
  freezes across unit and multi-session kexec tests.

This series is based on liveupdate/next commit d80a5528df4c ("Merge
branch 'lu-pci-preservation' into next").

Changelog:
v5:
- Rebase onto latest liveupdate/next.
- Replace reserved field in struct liveupdate_session_freeze with flags
  and add LIVEUPDATE_SESSION_FREEZE_COMMIT so userspace can either
  freeze a session while keeping it bound to its FD (rolled back on
  close()) or commit the frozen session (inserted immediately into KHO
  and retained by LUO across close() until reboot).
- Add incremental KHO publication helpers in kho_block, luo_session, and
  luo_flb so committed sessions and their FLB dependencies are inserted
  into the outgoing KHO subtree immediately on freeze, dropping the
  separate luo_flb_serialize() pass at reboot.
- Keep luo_session_freeze_one() / luo_session_unfreeze_one() in Patch 1
  rather than renaming them to luo_session_serialize_one() /
  luo_session_unserialize_one() and back once luo_session_publish_one()
  is introduced.
- Update Documentation/userspace-api/liveupdate.rst and kernel-doc
  across kho_block, luo_flb, luo_file, and luo_session.
- Drop v4 Reviewed-by tag on the modified freeze and selftest patches,
  and expand selftests to cover both uncommitted and committed freezes.
v4:
- Split out a preparatory patch that drops struct luo_file_set_ser *
  from luo_file_freeze() / luo_file_unfreeze() and moves file_set_ser
  handling into luo_session_serialize_one() /
  luo_session_unserialize_one() (Suggested by Mike Rapoport).
- Few more nits from Mike.
v3:
- Renamed session->frozen to session->user_frozen, - Pratyush
- Added Reviewed-by's
v2:
- Rebased onto liveupdate/next (commit 27be83a12b24 ("Merge branch
  'lu-pci-preservation' into next")) and split out early session freeze
  into a standalone series (tmpfs preservation and its per-file user
  argument plumbing were spun out into a separate series).
- Patch 1:
  - Drop struct luo_file_set_ser * from luo_file_freeze() and
    luo_file_unfreeze(), and rename the session helpers to
    luo_session_serialize_one() / luo_session_unserialize_one() so all
    of struct luo_session_ser is populated and cleared in one place
    (Suggested by Pratyush Yadav).
  - Unfreeze the session's files if luo_ucmd_respond() fails in
    luo_session_freeze().
  - Update remaining reboot-only wording in luo_file.c kernel-doc
    comments.
- Patch 2:
  - Add checks verifying that non-zero reserved bits and freezing an
    incoming post-kexec session fail with -EINVAL.
Link: https://lore.kernel.org/all/20261015093816.2438942-1-pasha.tatashin@soleen.com/ # v1

Pasha Tatashin (6):
  liveupdate: Move file_set_ser handling to luo_session_serialize()
  kho: support incremental entry publication in kho_block
  liveupdate: luo: serialize sessions via per-session publish helper
  liveupdate: luo_flb: support incremental outgoing FLB publication
  liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl to freeze sessions
    early
  selftests: liveupdate: Add tests for LIVEUPDATE_SESSION_FREEZE

 Documentation/userspace-api/liveupdate.rst    |  30 +++
 include/linux/kho_block.h                     |   1 +
 include/linux/liveupdate.h                    |   3 +-
 include/uapi/linux/liveupdate.h               |  46 +++++
 kernel/liveupdate/kho_block.c                 |  86 ++++++++-
 kernel/liveupdate/luo_core.c                  |  10 +-
 kernel/liveupdate/luo_file.c                  |  94 ++++-----
 kernel/liveupdate/luo_flb.c                   | 111 +++++++----
 kernel/liveupdate/luo_internal.h              |  16 +-
 kernel/liveupdate/luo_session.c               | 178 ++++++++++++++----
 .../liveupdate/lib/include/libliveupdate.h    |   5 +-
 .../selftests/liveupdate/lib/lu_utils.c       |  21 ++-
 .../testing/selftests/liveupdate/liveupdate.c | 107 +++++++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |  22 ++-
 .../selftests/liveupdate/luo_multi_session.c  |  33 +++-
 15 files changed, 612 insertions(+), 151 deletions(-)


base-commit: d80a5528df4cdee5871243e392da08c2d5c92e43
-- 
2.56.0.398.g882cbad275-goog


