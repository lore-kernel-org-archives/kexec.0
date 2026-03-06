Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7E7F0182F
	for <kexec@archiver.kernel.org>; Fri,  6 Mar 2026 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7fWIWTImvNF71LxdmXyLO15hWAJaM+X+968gLMH/VM8=; b=c7D82SgYYyppRL
	kkABKWtTz1V63m1ictT79ThD8W7GPAw57Zt179BNanOx7Pw04g4dAGmC619yxaE7D6P/JQaiaMtrs
	wj2m3GQr7iELRC+S5DHDIkK7qsBRDVvJ1JbB0Ozd8qxLcG7HTGBZCgyBM0jPoZQKBrTGPEJRzWx4g
	OxrGy1ZfJ0io0DvP4uZE3s6FrwDjJmavgm5/9TZLRopepd9yI3Tb9SgLs4sMmXYXLXnLM7n7QStQj
	oFxhgckoDVlmTWAneEgwTJPMQLxHjd+TbBCirWmYE++Of3uEkBtb4o/e40wTunzO2kH2Aql2IHkHd
	lspAdf/LM0O11uiOM/Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyUT5-00000003ex7-40jK;
	Fri, 06 Mar 2026 12:39:47 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyUT2-00000003ewQ-2J27
	for kexec@lists.infradead.org;
	Fri, 06 Mar 2026 12:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7fWIWTImvNF71LxdmXyLO15hWAJaM+X+968gLMH/VM8=; b=tQTiC2Y4ZmJ8kiKYz6tfF7kE9Z
	gFy4ay+bnzXyIJfcUkc0mcoNjaCRe2cMG+xedSH/tnPlvkDKFnGRVw5KWIksbph89DJ7tY9sFuaBZ
	yK6qubmZ7j+vzZd0/MaBTO9hQ6nmFxQoiPgYqzGvrYbauEG8AcZDzS/VFGvkSHTn/2uboemFoYonY
	XpVPnbLUpV/3T/OOODN+aKlNTPnmELCoECm0HgAojgWos0hJwUaC8XHkO2wWwrDBo8hjwiO2IXMsQ
	84SgLzjkttenem/F4r+k3PEE5T8xuvA90CSPd4Vx3mMRBjm3cEyMCQhmhbRlwOHTUkGhfpKLu5IqJ
	GEAmdkWw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vyUSw-00HVQm-PP; Fri, 06 Mar 2026 12:39:39 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v7 0/6] kho: history: track previous kernel version and
 kexec boot count
Date: Fri, 06 Mar 2026 04:39:19 -0800
Message-Id: <20260306-kho-v7-0-404d14c188bb@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjKqmkC/23OTWrDMBAF4KsYrTNFo7+RvOo9SheSNY7VQhzs1
 LQE3704ouDgLgfe997cxcxT4Vm0zV1MvJS5jBfRNnRqRDfEy5mhZNE2QkllUWkJn8MIRJLYR8U
 9sjg14jpxX74fLW/v9Z6/0gd3t41uiaHMt3H6ecwsuOWeGxcEBJMp2KhMjoFfM6cSLy/jdBZb5
 aL+kJMoVUUKJCAZShh1xOwOSO+Rr0iDhITZJYo+aKMOyOyQwooMINjO90yUnJfmgOweuYosSKA
 uy96FmNQ/yO0RVeRAgnV90ME5j93ze+u6/gJ5BD4dsgEAAA==
X-Change-ID: 20251230-kho-7707e8a2ef1e
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, 
 Breno Leitao <leitao@debian.org>, SeongJae Park <sj@kernel.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4547; i=leitao@debian.org;
 h=from:subject:message-id; bh=lTSkdOOL0IoKlvxUJCVsNH211AcVUPEFFdVll3QRwhk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpqssGyQFqpuiPB8uN92ofZ0vEKSUVyN8mNuaON
 p6Y25NedrWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaarLBgAKCRA1o5Of/Hh3
 bQFvEACVRR+fFIXeg0+fxkMt9oRmqo0Bn84nlxAybPAOtx/V9XkqaZVQqjfR64aE4rbXY8odIqX
 u5HN5qDDj9rgZJxRbUrv1evtrFzHa+ilV2/zbLvSSKGg6Yywtt9KdClmnc20AZcqnoynjKTNHjC
 s0rzEhZtmxApEyQ+fZ2EQrFjm5jExDI4eFe9ng2QHE4COx1+7tr7Ln84hPDV0peGcNCbe9cCX4q
 N/5pBNRjRXzkOSNA6nafIhM6d4iy0Wv2fKKE3WkOXLWrGSozgDF08+vcbuiPLOWMzBbkg7rvqgW
 R/jsoqjplddVK6I7Zu0MzE0NDdC1brv2tmwV2yIuc9PAX2X9NhTDe7X9680GbIIahcNb+lM/CVr
 03xD+7MYRrJp5mXZyfmAEGEZI+kZ9NzzL6jAmX3eXPuFCmRUIZef9sK4GLN1l/y4JQmXDy8lBuZ
 c56EZJDVwewl3r7IY7w7Rc80nyyIsbTHd5BcDW/oxmhyk9HIrgpFz9XqhuXdQVQlSvl3T7BKI29
 IGYmW6TI7fr1U6gs1rQxlLgsiGeszwIvInDFXekkQtHWqaixZbiiuk8yAGmih8QCmt2mYb30h1R
 MXDBvLtcF6KVCCW930pQ43JF1G9Z6y4Mak3S2M5Et7QItNCw8Bqu8DMWv360DzvTrERe95gz+tH
 boPMl0AzFNHwtqQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_043944_638409_C45EA4E9 
X-CRM114-Status: GOOD (  16.35  )
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

 Documentation/admin-guide/mm/kho.rst        |  39 +++++++++
 include/linux/kexec_handover.h              |  13 +--
 include/linux/kho/abi/kexec_handover.h      |  43 ++++++++++
 kernel/liveupdate/kexec_handover.c          | 128 ++++++++++++++++++++++++----
 kernel/liveupdate/kexec_handover_debugfs.c  |  60 ++++++++-----
 kernel/liveupdate/kexec_handover_internal.h |  15 ++--
 kernel/liveupdate/luo_core.c                |   5 +-
 lib/test_kho.c                              |   5 +-
 mm/memblock.c                               |   4 +-
 9 files changed, 255 insertions(+), 57 deletions(-)
---
base-commit: 3f9cd19e764b782706dbaacc69e502099cb014ba
change-id: 20251230-kho-7707e8a2ef1e

Best regards,
--  
Breno Leitao <leitao@debian.org>


