Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0BECD4F3D
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FX5A38o8AH4G2v4DkTNfg3+muDLC5WH3Of2OqjzAQuI=; b=owwgzlKP1jq89bo+5TDOB3auD9
	NbiN5zXxCD8ktMc6m5KGUxGVoo/lTCKKXtsKqndVPtaVXQxsuBMMUaLwflo4nFUMouBj6zq/Y5mSJ
	fMJfAL5MHAQTAPWrytQaiU39HFAny6iVpF9rL7OkEB4uXrWWj6a4IcmmFiMUHA14kGu+wEJ1Qq8jL
	gkkFzM/CJa7sKYzvnytgBu9EeXHBus/K6SV8te5epsbFm+4sibaBPPONW9D9BTNpYJOEdjCGSzCyg
	I/7fRMayy7q9jLwLULuxBHzUOZaGJamd9PkZEgNJ4rGCq9AhnaOgRPbUwy8rwk6MgMMWejaBxwDhK
	ZmZCPLYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYS-00000006vln-1adD;
	Fri, 15 May 2026 00:37:28 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYP-00000006vlA-2QBz
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 00:37:26 +0000
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-8b7f937ef44so49733646d6.0
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 17:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778805444; x=1779410244; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FX5A38o8AH4G2v4DkTNfg3+muDLC5WH3Of2OqjzAQuI=;
        b=Rjgbv6qDqIzU2dkxUAJSCylgZPycT3ns3xCNn8lqDHQ1A39KhbuwC71ygRasQFMYo7
         Nyv/5MCXPliIM5e4UggJ80cwKe8ZM+fjWAwYnCJnL4tiQxsS1ktlnUZ3cWfhXhx6PmC+
         UvFyFKz4blMxdLJpkXN/WBmYUL+hXDp9h47Bays4jjU+7HCFFk8CrujqzV8sHwaHJHsN
         0KQ9HKiwSrtqK0XUK5ke1fLR/mxFpEA2aFQNQgjh1dc4yChGqdkp/RTwVAl2CBMZz/pG
         yYKxNxFVARL7NMGL8wYlmWgkdotK/HFPIoMZu0S7a2T1EXJYtjr6Pl1f+eqvczFMf07B
         8kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805444; x=1779410244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX5A38o8AH4G2v4DkTNfg3+muDLC5WH3Of2OqjzAQuI=;
        b=CRje4FEApHz7QKI6PyFPWxaV06b8+5kpJYf6xRWJYv+1w0Am1OBH2wOBf1CXUFwj7o
         e8mUK164z0O9g4Etfeoq2j68vHVMO0c7Ouo39R0+QTsLK83+CdV4fI5wIOFY1Dchpm0Y
         hoJpcCgAJyL3nkUjEehuOAvTgBG1fw3VI0b/HpX21YqMw+jqEJiziAUcth3TjQYe0k0V
         PT237FZKuuo04x+mg7kHwO0mVxZKu8GGQgv00lKEl3oX92EesR++ZlT9O1pHTF/e7vie
         hrUqSCoVzLBVgxGecrwbU8PTIvSiTqmhl1bW1BCCCu9mf/yn8PUWuLwpnvbbBWX7BH3/
         iWiw==
X-Forwarded-Encrypted: i=1; AFNElJ9mHREcc5jlAz/0/s5boyk1Jo4JzEK+hQ9HVvg5N2Ujr6XlDX5Kn86oBCIKkd2hmOiaF35DnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzuyzygaucCRj/l9EPo3p5dcLRXiNj9tE70j7G4x4dqirxVr5Xj
	Fs5cIHTk5Xduz2kXz5wk/mxh8BAKZwgAFhIY5NrCp5mcslf/anA+QTrXKjzlDJZF+hk=
X-Gm-Gg: Acq92OGYZEhnoEItP7dl3CykENFMNWpNoos+v/p7noRMncZWDrP3fEVeXm5rqJaa9dr
	Ry1eJZ2OT+rGZJtlOmrR0fVL49vQVhXBRvOSMYzDpcK3sCS2X3/b4jXo9uB0vhKNBer5MysMGJ9
	tEPPmZkhEH+lmqxSBnHcr3c3u1oIgVEkXkZ5A3F1/LKUiHdc+Pn4gI+kKVs9qNfMpxjEIi2FHno
	gv7Kjm5vjnOxQHHRg/XwhHSBprcIHMyX9pBseS5pqQVmZvibDaUcNEEXafR6mmm+2QhUUMe6M2/
	ROhsBgtLaEyToHTkqMSuW53d0WiWe6lpuQ3bYIO2amIXrxBhtNjKW/2TY62De55fIg56JgPWIor
	a0wylaUM8gqEffP+iA1lv1rWtyTXxbIBT4U0pZcGnPO0qHnyl769j6OtH7IIDHfoNc+r+/8m/OA
	MIVCIcH6HyLf4wz7mERb4i1O3384T3/S0lewfedrFSgjpfPLPRZLQ=
X-Received: by 2002:a05:6214:4c92:b0:8ba:dfad:2889 with SMTP id 6a1803df08f44-8ca0f69c37cmr31156296d6.48.1778805444248;
        Thu, 14 May 2026 17:37:24 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c16366csm36918236d6.40.2026.05.14.17.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:37:23 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kees@kernel.org,
	rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v3 0/5] liveupdate: serialization safety and race fixes
Date: Fri, 15 May 2026 00:37:17 +0000
Message-ID: <20260515003722.938123-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_173725_622819_65830FE4 
X-CRM114-Status: UNSURE (   9.81  )
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

Changes in v3:
- Refined the session mutation blocking to use a dedicated global
  rwsem (luo_session_serialize_rwsem) instead of pinning individual
  mutexes.
- Fixed a use-after-free race in luo_file_unpreserve_files() where
  a module could be released before its file handler ID was erased.
- Fixed a TOCTOU race in luo_session_retrieve() by extending the
  lock scope to overlap with session mutex acquisition.
- Removed an unused 'ser' field from struct luo_session.
- Dropped the KHO skip patch as it was not needed.

1. Skip LUO serialization for context-preserving kexec: A
preserve_context kexec returns to the current kernel, which is unrelated
to live update where state is passed to the next kernel. Skipping
serialization avoids unnecessary work and prevents sessions from being
left in a frozen state upon return.

2. Block session mutations during reboot: During the reboot() syscall,
user processes may still be running concurrently and attempting to
mutate sessions. To prevent this, we introduce luo_session_serialize_rwsem.
All mutation operations (create, retrieve, release, ioctl) hold the
read lock. The serialization process holds the write lock indefinitely
on success, effectively freezing the subsystem.

3. Fix use-after-free in luo_file_unpreserve_files(): Reorder module_put()
to ensure the file handler module remains pinned while its operations
are being accessed during cleanup.

4. Fix TOCTOU race in luo_session_retrieve(): Extend the rwsem lock
scope to prevent a session from being released between lookup and
mutex acquisition.

5. Remove unused ser field from struct luo_session: Clean up the
session structure by removing a field that was never utilized.

Tree: git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git Branch:
luo-reboot-sync/v3

Pasha Tatashin (5):
  liveupdate: skip serialization for context-preserving kexec
  liveupdate: block session mutations during reboot
  liveupdate: fix u-a-f in luo_file_unpreserve_files() and
    luo_file_finish()
  liveupdate: fix TOCTOU race in luo_session_retrieve()
  liveupdate: Remove unused ser field from struct luo_session

 kernel/kexec_core.c              |  8 +++++---
 kernel/liveupdate/luo_file.c     |  5 +++--
 kernel/liveupdate/luo_internal.h |  2 --
 kernel/liveupdate/luo_session.c  | 27 ++++++++++++++++++++-------
 4 files changed, 28 insertions(+), 14 deletions(-)


base-commit: 7b0b68b2b95606e65594958686833e53423f58f2
-- 
2.53.0


