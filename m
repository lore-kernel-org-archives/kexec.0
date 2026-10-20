Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7B60A2600
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ina8HKg8;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=S6FSJc/M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mML0rlUQf2leT75dFk0AVhURG3XCgO5T9MI2E8M1gKk=; b=Ina8HKg84X9rp1qAUXNdpKAcvR
	3e4n/jn1Vf+XnaA1a8GGMRAAXWzohSbEs/F5R3RxB+Irp6d9q2lwB0HyahtL1DzrSKkWATAiuyB6P
	JQ3zhAjvXTRGWfEIFj0RMuH11RoSf/UfnXhtAP1kD1K4n4yzyyHOSGh9KyskYm51b2NQxRzpc+E7I
	5DpySaE7A738I0szBCRbmEhOzslU40/Ms79KofgHAMKpvciK5wBckgsm37KbPTS6mdwSOWB67d5k/
	6blxqJkOBH7wfhnUDmQ7emohuFxmaK3mdot7BEoaOWgecREv8hMjr6vldjyRD6LXgOdfZEAVR3Rh6
	RYiSTxnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJB7f-00000009zAm-3qR4;
	Tue, 20 Oct 2026 14:47:27 +0000
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJB7c-00000009z9e-3pHX
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 14:47:26 +0000
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so648302e0c.1
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792507643; x=1793112443; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mML0rlUQf2leT75dFk0AVhURG3XCgO5T9MI2E8M1gKk=;
        b=S6FSJc/MNP5/ne4isKD5DBFFgTIcV4wf/W0CB4Jl/HcOZX2kkES2HJBl5ztur4c35P
         rZIQM+aIvq4te5Oj1Wjg0Ja5Cu7rx4GOQZWbr3st8yoz+vKkn6MK+6PXzMGQT28mVPdV
         36FLI+2uRitMMlaBcKx9mHfdeXY7Ht6CXqxUeZI1jBc0VJeVEevmxRDPl25JmPbVbZ7s
         0JleVJ+WrLMpHJ+jLSMhLkcm0Xcpj3vuP9FPtdVbQUnZXA1OWuU9Yb1fOk2tC8K7R6Xn
         MRrVXYbsjCRHWzj5QqDYQG2cbGRxcrxx3aQ/n17V3T56Jn82IfCyJe7MtoP9+oI3zD5L
         Q4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507643; x=1793112443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mML0rlUQf2leT75dFk0AVhURG3XCgO5T9MI2E8M1gKk=;
        b=lnKYFYFg1ATdmbTGdCH2fKVihFyIdMr209OQFNI5RQGzyYoDhr8w8Pvp8c6vW8XNBg
         PBpsXhPY/SRLjJbJpCbzVKxo0OXU4OU65kUoiq2eALW7cprHCYnLabyPxZ4Tgzd7aeF5
         WOgBH7s/kGMmUD1rabEJjIcvKzNDIoSlowsHnmA8uhcnQoDvnYxLOc8KU451MTuy/TbU
         dPxaCp3F3+iM2DPUx/sGS/eEh1qTEvb0cHBnvJkC60NtXyVnhl9v2XpL2bLNa/SvEXR+
         zouociyiP1R17Wlqeh1ybL9fHnVF2sKAC14JEghpr6aMbAAtjexsHNtP+XsXEP00fFON
         Ofaw==
X-Forwarded-Encrypted: i=1; AKwUvBx59/to5YcUHjnotPNLE8tweEK3Sf1r0eubhRXDPjIzm0AkLEWoYnx/y26fDdX3G5c8u6lgbA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJvrjeMJx+ZcdCFl9W/BKhEUZfJ7qtw3U+BoeigojnkHcLIyEL7
	SfOdAje+2l6RiBvT3DMZ8XPTVz111DJm4yKHKuiQLwblAKTMPvR+PfYa1Ec64jSTl3M=
X-Gm-Gg: AYBFou0KrdKdzgJkH7tD9IwtQd4PPipGUTc7u44LCgLZSjSAW2ljg8HhES8riiYgJb6
	HSLqzWR0WsrEZuzu2LJbKVlI+GsFCE77BwFu3Dfu7AVa4jbrkTjqctG4duw+evDEetAd0gm6CN4
	U+oWzBoGozk/3M3IM0o4LD5p5oL37X2V0a2E5WzGfB1pvSf/H68iVpIVAtBs/8r8AeeNsy1fkPn
	4AzP+5VH1O75JjW+mhTDUaxab/hcbQFsuBNQfLrd34C0Fhpg6VzTcwE5mnUTVH3qItA3+INCU0t
	74dnDjL8X1f2QvOL+EPEdwsT/olFVqBXVO9ZqAK8a4HWk8stDJm/oiMHW2UEPPRZvVwtb7kVw2x
	B//ozm1jdt2MuKgxDNMdAVMGUK1lcduF+LXQch9pFdpIly/Q8s8Q/OTR3f4J8a9Bgwuj9CQzL0H
	DMqiARhE/b7wJxa07hP49GOClG0hKjebUyA6SZFeSFMuAof0Fj7wVXsyZ51nmLGIP00HayjACVB
	kcxr5SmZDF7tTAbElwo++nR3objRNS7K4eCCgCTT2AXI97s4EA8jEjMryOGTzKUSU7RvYwRYEly
	VrWu1xxm4bYgDnJCwcAi0kMTARlHxXTHWF55Am3FK1yMyhEowDYa+fsZ3lV0gGsDil8G5Ujif2T
	J
X-Received: by 2002:a05:6122:1790:b0:5e9:5e79:aa5 with SMTP id 71dfb90a1353d-5eadcb1713cmr603117e0c.7.1792507643385;
        Tue, 20 Oct 2026 07:47:23 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b536ccdsm12920421e0c.13.2026.10.20.07.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:47:20 -0700 (PDT)
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
Subject: [PATCH v2 0/2] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
Date: Tue, 20 Oct 2026 10:47:02 -0400
Message-ID: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_074724_960192_8341CB19 
X-CRM114-Status: GOOD (  10.87  )
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
 kernel/liveupdate/luo_file.c                  | 73 ++++++++---------
 kernel/liveupdate/luo_internal.h              |  9 +-
 kernel/liveupdate/luo_session.c               | 82 +++++++++++++++----
 mm/memfd_luo.c                                |  5 +-
 .../liveupdate/lib/include/libliveupdate.h    |  1 +
 .../selftests/liveupdate/lib/lu_utils.c       | 10 +++
 .../testing/selftests/liveupdate/liveupdate.c | 49 +++++++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |  8 ++
 10 files changed, 202 insertions(+), 63 deletions(-)


base-commit: 27be83a12b246b6b3783e7d3ac5c378ff7520f25
-- 
2.56.0.212.g129ede20d9-goog


