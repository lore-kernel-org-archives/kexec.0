Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86436606A324
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K64dw+mQ;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YPtYEnEo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=AN3Hjw/HZft2MXUgGNWgsqw3kkl3NUYJU0ViE8j1aeU=; b=K64dw+mQ2jEuHxM/WuGgvxtEni
	o5oT/sTrNerLW4b0bCCDXtytKBKkjFvFWOPgSjBV/5J29M9VyCEo90rxU9KzwaMRNh0l1Q4kzTSe8
	29N9cxVNbvzaaYVd/U6T0p9ktaYrbbSBqm1UobBSc3TdQigExgLnX+zdSszcjbl6JhzxK5SkqhGhN
	VJdRJDCqy69VyW/7NK4S+mBtVWpf9oXvtsKXH0H8BUQQRwh80mr7uVmCSX++X+EtlBF6u2aP4QYHK
	6OJkh11GtzO+CmnWn8TI+bTcs0wSiKldCzhpqQBxawNqOmavAkezv5CCHRZHxcPV/SUIzLRqcdY2a
	5ebuuZaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9qV-00000001a5y-0OaQ;
	Mon, 26 Oct 2026 01:49:55 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9qS-00000001a58-21Cx
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 01:49:53 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso925993e0c.0
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792979391; x=1793584191; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AN3Hjw/HZft2MXUgGNWgsqw3kkl3NUYJU0ViE8j1aeU=;
        b=YPtYEnEo9oPtEtRy4KM9+PGzaaqXGHZN0zwywe/xh+jMaD4Qq2vXibc9OJEaMKclX/
         yE8cZqDQ93zWDr+30mB1cW5WNFBQNakFlesj+THZD+6dWzWA5Nrws2+RPEYi4tY8x8/L
         J0nzSlaYP60XZIhvNf/5u0ljD7QMiE/AI3EL7fO4tmyYrJjemqUb7DTcrQfy2s/kiaqf
         +70a5KKA0KnpEEfjOAi9aKqlewjlEpcR/76ckOFYX9SK9j/dY+lo+lpQcOKuv0mZjPZK
         ZO8J3BwzzF1y7vMRqucnfkhavxm2aRVKjIVm4hP4n4vuA+hNfpPc1pPEIYwRcMdyfDQt
         XHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979391; x=1793584191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AN3Hjw/HZft2MXUgGNWgsqw3kkl3NUYJU0ViE8j1aeU=;
        b=193zjDDmP/HR8PdsrXU4XAZSKmx704h8vQSl1PBTFu1/VPblLptFSc8Nr52HPZkKli
         x/6p8fvinr/QXkBaNZsuYgL/tjfLUUEgWUtsTai0sqCdlNwlymnqSj0dbFBLrdjv3+sr
         zHrTmFiGIDbWI2v1kLi625CxAAH+KrcwrDOFDDJx8x9oPFqTJoTTiXeezxZFdqaIJh+g
         q6JVt0CPzEQR0HjZK+IEoZ3QcTzptevfgdcadAMCaZNehfeK6ZfPpJTVr2g8xrssJg76
         jhekzK6PqCvfZpTHsYzkW8LnjR2CgXci5dh+sWkR1I+VPMZF+GtvCYZAXGQjnI++k5Kf
         Tgfw==
X-Forwarded-Encrypted: i=1; AKwUvBwWYCz9zjiUhJsu0ek6IboVR6zBufJjRmhZqTQCbVsLCiT9kYpzrLrXW+lwT5jj9EvszMm2xw==@lists.infradead.org
X-Gm-Message-State: AFq9FYLf04ekEZ4ztxSMrKjwb9zI9W6Vb0YzORUtaKuWpLLE+lUOojtl
	8hlXzlVGVIrXOyn1r7/fwK6Nhq5GD5YXS4h8Pu4yMaTs/An+gRSYGZOxZUBL0h1qe3g=
X-Gm-Gg: AYBFou114ZThH1OoifVPbRffncTP1jaYhbBxf0pZsaDCXRBXXWQOzN+mXThVXmnmQQe
	NJPLBBzoIwtlGvkgjhw/+E0Z0/7UyAA8uiW2HosS1zEwoqk+fM0DzvBQab1cl9+CtuWKzuQqeCA
	I8PtZbhAd+BCXzMZ4tXjPF2CI5EUcBkcgzcvYvYxQaTMEeLOcpfdc1YgORx3Vcjljn5NLHhime1
	pyJk6p/IWhaa+b/mOLRY75h48oYpDPd8SYDjwRAuZ6MEHaVGxG3fTJpn8bll5modLZZFNVIaQMS
	60ava9u+Z9dMrD22SDpKxAJUBt1xM8O+5cZcHTf2F6a5/sJbs7AnypL2vRoU6wHUBntSYAH3Rb7
	M8p5bAyzZ7cQjy2+ZHtqEFiivGLrnPNrC7VYowF6xOUx6a/hrJ7Y5dWKZwvQn5SFhSvmz4xkAdl
	/Q0MSfRAjji1zgKaZaxDyWybDsDHiCJMUNdXkWxYzUc83JT+/iseLtWr97RkL7aELlWkj5fm8P1
	INGk9hW967mQGTEKbsevXzaubUCCD/s/brM2TrqUVIMA3ICi6n2PzqdMTpTp71v30HdtX5Xd57Y
	CGb2GDdFQR2nFqKm6lvO0C+yR+XIEkJrLcuEnDkAiVYmvuT9SOyB9zIvxlyYszl90V1f7sYrJ+/
	g
X-Received: by 2002:a05:6102:5ccc:b0:7cc:2a3c:9a33 with SMTP id ada2fe7eead31-7ce5ce4d7d4mr1365539137.34.1792979390767;
        Sun, 25 Oct 2026 18:49:50 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ce5df73970sm6099917137.1.2026.10.25.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:49:50 -0700 (PDT)
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
Subject: [PATCH v4 0/3] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
Date: Sun, 25 Oct 2026 21:49:43 -0400
Message-ID: <20261026014948.162559-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_184952_542025_C1055F76 
X-CRM114-Status: GOOD (  10.69  )
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, LUO sessions are frozen automatically only inside the
reboot(LINUX_REBOOT_CMD_KEXEC) path, where luo_session_serialize()
iterates through all outgoing sessions under global write locks and
freezes them serially during shutdown.

This series introduces the LIVEUPDATE_SESSION_FREEZE ioctl on session
file descriptors so userspace can freeze a session as soon as it is done
with it, rather than delaying until auto-freeze at kexec time. Because
luo_session_freeze() only acquires the per-session mutex, userspace can
also freeze multiple sessions concurrently in advance, reducing kexec
blackout time.

Once frozen, no further files can be preserved in the session and
subsequent freeze attempts return -EBUSY (or -EINVAL on incoming
sessions). During kexec, already-frozen sessions skip the late
auto-freeze step; if an early-frozen session is closed before kexec, its
files are rolled back via .unfreeze() before being unpreserved.

This series is based on liveupdate/next commit 27be83a12b24 ("Merge
branch 'lu-pci-preservation' into next").

Changelog:
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

Pasha Tatashin (3):
  liveupdate: Move file_set_ser handling to session serialization
    helpers
  liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl to freeze sessions
    early
  selftests: liveupdate: Add tests for LIVEUPDATE_SESSION_FREEZE

 include/linux/liveupdate.h                    |  3 +-
 include/uapi/linux/liveupdate.h               | 25 ++++++
 kernel/liveupdate/luo_file.c                  | 73 +++++++---------
 kernel/liveupdate/luo_internal.h              |  9 +-
 kernel/liveupdate/luo_session.c               | 87 +++++++++++++++----
 mm/memfd_luo.c                                |  5 +-
 .../liveupdate/lib/include/libliveupdate.h    |  1 +
 .../selftests/liveupdate/lib/lu_utils.c       | 10 +++
 .../testing/selftests/liveupdate/liveupdate.c | 45 ++++++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |  8 ++
 10 files changed, 203 insertions(+), 63 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog


