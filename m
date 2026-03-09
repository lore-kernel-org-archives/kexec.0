Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CD1F3C265
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kA1EryOehNm+a7EFry/ptsVIzbOSOAR5v3wv4RxFa2M=; b=BDuPpSN4aSeNsz
	jzncFxRc5QWNYkIbfy8dpR69C95vTT/6SSnCgHx31RSqhvnOSf2JPn2QS2+deGY1jKoMQBy8JXKa4
	kvbMcZm4gjrkMk+F89AsqpeCz0UkSkeAzOWoENV8aq4y1IM4Iof8wWF1BS9WrMqtS6uRLIefG7Jua
	Beaqi+UOOjKv4WJ63OmI2WdELiOTPFNzlYYUudNiugBmzhc3k24SxoIfpdTpEzR91rY4/e6hsMiHg
	cgDpTrY5cJSxfm7M9GaLYS/DGbzC7cQmqzMBFa3XnaZ6VPpOZ6UQCdlfVuPiIs9KCdgjOYXMYJgpH
	6EUTz9al5vMkB3ozDxzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzasM-00000007Q4x-41m3;
	Mon, 09 Mar 2026 13:42:26 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzasK-00000007Q4Z-3X76
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 13:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=kA1EryOehNm+a7EFry/ptsVIzbOSOAR5v3wv4RxFa2M=; b=cBy1WchnxLXmf55KnQhrgvGVzp
	8G7EGe9DOlhXMi3OrCYSbcdAA/I5tkX/UGU64CUjl0G19ELarMuSN/DxDTQ94//t1noPBzxKjS4Ey
	b4Xa1v0I/l6LngWo0/QS0QPDNVv08INi0miZ5g+Ae5RL8MNoYPiV+VZ42I6SPVsJGdJShwMJELuOa
	96/KJWN7WMkceCrlNo+Am+GIjISnrbWEl0YxddqA+/BTsnBu1/lnMRKJrcLVfwibR1k6jnrPW7T7x
	D8SMiGKcSJ85W8o+/ggOIgeDkUi3DuBcunCuzRM6KPwgbqLDvxb75kd4CT80aMa0KqJhRg5pepw5U
	tqBLQuhg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzasB-002G3B-8j; Mon, 09 Mar 2026 13:42:16 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v8 0/6] kho: history: track previous kernel version and
 kexec boot count
Date: Mon, 09 Mar 2026 06:41:43 -0700
Message-Id: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABnOrmkC/23OTW6DMBAF4KsgrzPVjG08Nqveo+rCfwS3EkSQo
 lYRd68IrUpElyO97725iSmPJU+iqW5izHOZytCLprKnSsTO9+cMJYmmEhJlTVIhvHcDMCNn62V
 uKYtTJS5jbsvnveXldbunj/CW43Wla6Ir03UYv+4zM625x8aZgEAndrWXOnmXn1MOxfdPw3gWa
 +Usf5FBQrkhCQjEmgN55SmZA1J7ZDekACFQMoG9dUrLA9I7JGlDGgjqaNvMHIxFfUD1HpkN1YD
 AMWFrnA/yH2T2iDdkAKE2rVPOGEvx+B7/IYU/SwwIGnUiHcnaEB7QsizfsuKRj+cBAAA=
X-Change-ID: 20251230-kho-7707e8a2ef1e
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, 
 Breno Leitao <leitao@debian.org>, SeongJae Park <sj@kernel.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4751; i=leitao@debian.org;
 h=from:subject:message-id; bh=JMa0EXK2ERazXwyedUlbDfUy2dFNns/iAuCHS3HSjQE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBprs4yriwTxSLkaVVSJDn1xLKlIr96i02KqYq90
 Ka8YJguSA6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaa7OMgAKCRA1o5Of/Hh3
 bVXkEACM6MC3wIDicNzzeOJ+b/Q1gpyCUbfiJo4/ykM/LwGsUDitQKvlE4Lm2daQ6/eqJZ5n06D
 +wwMuxZ0ma7hr3Oiuj8V/c2XclEcSbfv7eFC36+o0e4kzsFPxkvdu2Exd6m2KD2WMH8xdUVF8pb
 renj1SIN73Mjoy79fhnfaZCMs009cH6YUpQ90gub9B1OWkUpY/jKs5P3tmhyDhzzwkLe3QbtvSs
 L8jCouQyHfowuOpLvS2a/JBhPbfHe6ztKZPOpr3u7yme4WT/L4WhbozPxWDjfL2zN8AZTV1z+hZ
 acKygDcyG/M4eZRAufznz6alMhRAXcDVT5xGCmwo30K6WTekCa7TqcVG5KeTgGtogm1REuzBixK
 vi5Ndxec+y025325lA4V7RRiw0cwx+EIeXsU2xvyNAXPM+nON1ZQf4cCpuv3EtlAd0Opiev8cNE
 J9zOZ2lwVmm5Ss3/magls1out/suIYHy5pYLXaS6GUMe+SHsciqWalA0mc3JVzYDVuPWl+1LH4C
 Qpzd7jo5NojgmXPDD5RB7X846hjwfy2DijAAEN4ToDcr64I3eNYyECGtJictMMcWsFU22slM2nr
 SsyLTeZfCvhknMEhTnoOjMus3Mex8EOeok3v4yGC1dMrGXCld8EPXjf02zj2rUFDYRvT2Pw4eem
 Cyn8k1E677XY/IQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_064224_894016_2FD3F0A5 
X-CRM114-Status: GOOD (  18.02  )
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

Use Kexec Handover (KHO) to pass the previous kernel's version string
and the number of kexec reboots since the last cold boot to the next
kernel, and print it at boot time.

Example
=======
	[    0.000000] Linux version 6.19.0-rc3-upstream-00047-ge5d992347849
	...
	[    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107upstream-00004-g3071b0dc4498 (count 1)

Motivation
==========

Bugs that only reproduce when kexecing from specific kernel versions
are difficult to diagnose. These issues occur when a buggy kernel
kexecs into a new kernel, with the bug manifesting only in the second
kernel.

Recent examples include:

 * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
 * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
 * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")

As kexec-based reboots become more common, these version-dependent bugs
are appearing more frequently. At scale, correlating crashes to the
previous kernel version is challenging, especially when issues only
occur in specific transition scenarios.

Some bugs manifest only after multiple consecutive kexec reboots.
Tracking the kexec count helps identify these cases (this metric is
already used by live update sub-system).

KHO provides a reliable mechanism to pass information between kernels.
By carrying the previous kernel's release string and kexec count
forward, we can print this context at boot time to aid debugging.

The goal of this feature is to have this information being printed in
early boot, so, users can trace back kernel releases in kexec. Systemd
is not helpful because we cannot assume that the previous kernel has
systemd or even write access to the disk (common when using Linux as
bootloaders)

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: SeongJae Park <sj@kernel.org>
---
Changes in v8:
- Removed an unnecessary size variable (Mike)
- Moved some renaming to the proper rename patch (Mike)
- Link to v7: https://patch.msgid.link/20260306-kho-v7-0-404d14c188bb@debian.org

Changes in v7:
- Persist blob size in KHO FDT as a "blob-size" property so the
  incoming kernel can determine blob sizes without assuming FDT
  format (Pratyush)
- Link to v6: https://patch.msgid.link/20260127-kho-v6-0-56f9396681c2@debian.org

Changes in v6:
- s/UAPI/uABI (Mike)
- Expanded the rename of s/fdt/blob to kho_debugfs_* calls also (Mike)
- Link to v5: https://patch.msgid.link/20260126-kho-v5-0-7cd0f69ab204@debian.org

Changes in v5:
- Add a patch to document the new feature.
- Change kho_add_subtree() to receive the size instad of guessing it.
- reworked some code path to make it more standard.
- Link to v4: https://patch.msgid.link/20260121-kho-v4-1-5c8fe77b6804@debian.org

Changes in v4:
- Squashed everything in a single commit
- Moved from FDT to C structs (Pratyush)
- Usage of subtress intead of FDT directly (Pratyush)
- Renamed a bunch of variables and functions.
- Link to v3: https://patch.msgid.link/20260108-kho-v3-0-b1d6b7a89342@debian.org

Changes in v3:
- Remove the extra CONFIG for this feature.
- Reworded some identifiers, properties and printks.
- Better documented the questions raised during v2.
- Link to v2: https://patch.msgid.link/20260102-kho-v2-0-1747b1a3a1d6@debian.org

Changes from v2 to v1 (RFC)
- Track the number of kexecs since cold boot (Pasha)
- Change the printk() order compared to KHO
- Rewording of the commit summary
- Link to RFC: https://patch.msgid.link/20251230-kho-v1-1-4d795a24da9e@debian.org

---
Breno Leitao (6):
      kho: add size parameter to kho_add_subtree()
      kho: rename fdt parameter to blob in kho_add/remove_subtree()
      kho: persist blob size in KHO FDT
      kho: fix kho_in_debugfs_init() to handle non-FDT blobs
      kho: kexec-metadata: track previous kernel chain
      kho: document kexec-metadata tracking feature

 Documentation/admin-guide/mm/kho.rst        |  41 ++++++++-
 include/linux/kexec_handover.h              |  13 +--
 include/linux/kho/abi/kexec_handover.h      |  51 ++++++++++-
 kernel/liveupdate/kexec_handover.c          | 134 +++++++++++++++++++++++-----
 kernel/liveupdate/kexec_handover_debugfs.c  |  56 +++++++-----
 kernel/liveupdate/kexec_handover_internal.h |  15 ++--
 kernel/liveupdate/luo_core.c                |   5 +-
 lib/test_kho.c                              |   5 +-
 mm/memblock.c                               |   4 +-
 9 files changed, 260 insertions(+), 64 deletions(-)
---
base-commit: 3f9cd19e764b782706dbaacc69e502099cb014ba
change-id: 20251230-kho-7707e8a2ef1e

Best regards,
--  
Breno Leitao <leitao@debian.org>


