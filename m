Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03792606A32C
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dJedjxBP;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=gzMcHubQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HijCuOpDuAK6PXX4hhiO509M0K5rwPq4Jmik4wLwBWg=; b=dJedjxBPs3olWAyOZfVkjyCLdt
	rT90T4VAPT6cgb8o7rhe1kxZniiFIiNfeE9ZmL6UlCaKpeycTB6We3hZSok6cYDq4x2YssW7LFViF
	gZTKXwBDy+N/B3wq8IMhP71e1QKwIWj3aMT1mBlZPy/nODplJjeree8GyXeL3xlzRZ81BB+IudGV3
	QVlU8JCys1UXfFwKclhIJ5PINQ4Og71CUqzaldUGY8cdElN5Qpvnw8L4wa8Tr4MwFcXeUu4m88yH8
	zM6xY/VthlARCvm8LWLut7rei30OPtwNEKh/8oHD2+WsA0XDJyVQuRRQOwcj3dCtxtkHehxsmqg5n
	9fS0AG9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJi50-0000000DAN3-33Ma;
	Thu, 22 Oct 2026 01:58:54 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJi4v-0000000DALe-1DhA
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 01:58:50 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-93f259cdc86so131529085a.3
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792634328; x=1793239128; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HijCuOpDuAK6PXX4hhiO509M0K5rwPq4Jmik4wLwBWg=;
        b=gzMcHubQ0QUgtrjjsJ+MSzz7xh2OsINzitGSd7ZKnTAsYYSZ0jmWK4lCh/XN+qrWy5
         or9sHV4hYhQaWUdcC6yfI7KmCnyQJIMlJSeI+d5EApXa/s6jaH97InYheskTawB4/CAP
         6WAMCghkbJKWY0WCOPpfPL4doaA7mQCa8Gh9E6NbXQ3d80/ZxkSwa1TbL0M5klq2qXp3
         JxXkL00yhxp9kEXLbJPm/sw6Xm/R/F4El/mnQ/PE+IsiO3t/YtK2T5TcfPXGSJRjkNOB
         GSUsgjbGrk84tB1xgneuu5hM8lpoCLpqNr1aGJY5vUB7Yiiqe2FZOfMQE38gYnKgcUXm
         uwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634328; x=1793239128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HijCuOpDuAK6PXX4hhiO509M0K5rwPq4Jmik4wLwBWg=;
        b=kniv8zIFz23UrcI8FAoBrdP96daQYd3l3GB2/ANZ7yP5OrWaEN8X+5v+kPwMcGQ0wR
         d1l2ZBFsdUlnmsBXBFt1cvwjlVuVCaTMt2FL15FQLJlUhWX3uCEcRjQ698bAj8elWyzq
         oaAOqnVzU49IQFv8U1eAe2Xgx6ptc8unOyRPbG7qF1FWk6hdyccLsJXoL9mEumt8Mmn1
         qoW1NVYofBtzbgw9LcNpyvxf+hrYXhBe1hnPz3CuZWc6b0NtMVhDvsUFwpFpeXKYMTg7
         b8vUI7Rk7+AarHA6RDvDK5LAf8enI4cxHELvBjrJv6/O7XtxhDbrU8Klqxk+F6Gb2tcI
         Drpg==
X-Forwarded-Encrypted: i=1; AKwUvBybhivohWBMLFHi8lJMzbRmSe56KW4hLkOxwHdAX7NuFNCiOO11zwwzk2I9Cox7KjXzq7DZYg==@lists.infradead.org
X-Gm-Message-State: AFq9FYIsBozoCV+vWfpX7d6otaxrssO7kpTTv/xW38OgkFWUPopbkABO
	tTxPYfF+QqdQJCGTYYlqozU2Hvb7FtceE0MWpujnr3fELAT8iJ06BtO6W9meQv6dozw=
X-Gm-Gg: AYBFou2luzZRpJhf0hYiN9je3k/5TFSHWZYPdaDRJ+B22K6U4DComyRQXBZDyRwMdp+
	JgkFWMyi8r9FKJkwiTR9CTss/Fts72PfFE+90WXTd9rsx+DYZ1l52GDrIc0eGJYEQHr2NQlwBoJ
	HJdEe803j4A49caOBPqFr7kYqafO1rJlxpwhxjsZjAvTj+LPJs6E/nYuLlrYj9i7Ta0k38V0r9y
	LwvM3ji2QbUivFOlP07MBrgzhVd2BrQIbmH0qtMm/KC/ABcUoSy0rmCH+OVMslN35Eok6xkoTel
	618kNBpFx7OHkqr3yPBGzEntTxKWN96JV/3eKoz7SmfXOzaBF7ELdjtXWiiur0rvZqKh91AQjXA
	3SMlyGe42Sl1BKU8PL9HyxkZEwmhNstmN9pcL5QzixOqC+QDMrnucHozafpQkVpsOAbrPj7ujFg
	EsPWe8CBaArTIytwWFb84je2EG9u7QuU+PfvvjWtnaTjDnrKA3tv1wS51ufkVhCM44iJkHGYMz0
	PPDJjRlBG3dWY5AdRROeHG23B/dQ74RifPXD4gHzqxGlN93/D+X1qw7vbz3bTwncbOMbz8PxkIQ
	RcDBcKW+d7qIyvgzTDOhRbmeUQH3bo8vrsiHDjNFI1dhxT7tfrN4SlVZy+cOXIIkjKBJMHtB2tJ
	z
X-Received: by 2002:a05:620a:2989:b0:93e:e4d1:797b with SMTP id af79cd13be357-93f57fac2a1mr783266085a.56.1792634327158;
        Wed, 21 Oct 2026 18:58:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e247ffsm397383285a.39.2026.10.21.18.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:58:46 -0700 (PDT)
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
Subject: [PATCH v3 0/2] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
Date: Wed, 21 Oct 2026 21:58:38 -0400
Message-ID: <20261022015844.2795816-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_185849_648712_C20A7CAD 
X-CRM114-Status: GOOD (  11.10  )
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

Pasha Tatashin (2):
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
 .../testing/selftests/liveupdate/liveupdate.c | 49 +++++++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |  8 ++
 10 files changed, 207 insertions(+), 63 deletions(-)

-- 
2.56.0.218.g1ec904b173-goog


