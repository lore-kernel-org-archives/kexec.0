Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D720CF65EE
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZW3LbSobBIE/Z2jyZt9UDCEFz8BsV1FxKWKSGSxyUDY=; b=Gh+mnGVKN3PEQB
	yL0RdbH3a4r1VRdVSTJs5ndxcQ/mX0sWgoSyVeAccwXPZedL/GqKhLfjYf/7xTVwt3ALrJ/kHZsDh
	p8cxMhJeJx2Fh4ArQnFExGXoNbAp7xdVf4/StNuvJx24kQIvf3xMpOwPtLUzh3/RplOZbayDNgtQs
	1Rbcq4khKVfwzV+bLBSRKLHc1mXEjRCKM2HOXtiVjAGPogEkNWKveEfCzGlj+DqK2DOIHrL0wft8E
	NI9a2UOkZX5wP51zovwAhrBaTC6SZS6wkyfahH3uboYk+zulw6Fo+liEL7Db7piOHR4J1j81Ytf83
	0cicLDOcgXPVVICiM7/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkP8A-0000000CpZA-1T8Y;
	Mon, 26 Jan 2026 16:07:58 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkP86-0000000CpYB-2iRV
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 16:07:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZW3LbSobBIE/Z2jyZt9UDCEFz8BsV1FxKWKSGSxyUDY=; b=bjOAzm9vtMP4ZEvMIyGT7p/ZhZ
	PUYSRaZMfuRvucznOxAUu+r681bLgJy/lNIaR2sWRxecSiry1S5qz2dd0A3xFPeXGZwWihg+qYxLu
	/SZYN27qRIVAoiI344B5c88grbzkFucPeH6bw7+Tm8YHuN8xDMoHn11/NQ9fqNrEu+UwMkQCESpBb
	QTKZcNAtXhJPAai/MScpmksAWbMh/WA4DFYyBpVRWdNAwgKMpOpMDMVqbpPoUCaCBQk75aqDmXDZD
	eq4ugJonxrY/MbajRrAjtDhMjg7soNyF2/d+VY9hsx1WaN6OIDZkfM1bjrCMTBnCnCyjDjl2lRpKX
	N32Vcdzg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkP7y-00GI7A-Gp; Mon, 26 Jan 2026 16:07:47 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v5 0/4] kho: history: track previous kernel version and
 kexec boot count
Date: Mon, 26 Jan 2026 08:07:22 -0800
Message-Id: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADuRd2kC/2XNwWrDMAzG8VcxOlfDkp3YyWnvMXawY6XxBsmwu
 7BR8u4jDYOWHgXf768rVClZKvTqCkXWXPMyQ6+ak4JhCvNZMCfoFbDmhtho/JwWdE478YFlJIG
 Tgq8iY/65Vd7ej7t+xw8ZLjvdF1Oul6X83t6stO8eiyshoU2uawLbFDp5TRJzmF+WcoY9ufI/a
 jVpPhCjRnLWRQomUGqfkLlH/kAGNUZKbXTBd8byE7J3iOlAFgmbwY/iXGy9tg9o27Y/TIt1Z0g
 BAAA=
X-Change-ID: 20251230-kho-7707e8a2ef1e
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3984; i=leitao@debian.org;
 h=from:subject:message-id; bh=JWdN5ALVSvxCTZbbbffDLUHfmxM4JPZ0+lFI+jYhOZ4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd5FNHy0h/eLhMvXQCGWmb1NJbB7x3fo6neNCf
 8MoHIQ4O8CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXeRTQAKCRA1o5Of/Hh3
 bZ3BD/oCW6ztbhlFifriebt2pOEFjOqQAlQE72skmOP+bELWcyV2ekcnoA47N/lKLa+38GAZKoz
 M1PceiHLa7+u0CMdNQB748zGAmRaan3JkEaCohbf4t92peLFxxiEpp0mhvH91ORLANMlLTqZUrd
 B8tUobTUWtfdnPkNwJRz0Q/O7r+vG4VWpDLUUKxcGftFtmyFlfLLGT6IfuFLud2NNb+pkEVQXLA
 OZYqKvvTHCTALkoK0Wf9eqxVAAZhYVRkeZzEKXGjH0Q8B4+TRNINyDf8HBD2QOMueHLCqzEVHug
 SPDVOrZtAtV+VAWdKdn1EO792tu51g+nJc2V84ws5PNFZWQHGDCLXAZXgq71vDhy/ARx+fZ1jB1
 lT3CWLtkipozqTvBHXZqK7Pu/26Chn+krcrs5dRLJLo50Wb06NCJJUQbB8vnynILtSpC76chEwR
 aNA2DbqgOLZi2IBURmEUjnzNhJfbc6YmtwmE40C+zBL6vzjaYFUTccD2y1L47BBmU+gQ940aQRF
 J2ZDA6OhYV6m3d3yYoqChrUiUb7rfTuP1o/jVcachXeRdckn2f7VN1WL1MaBxb2pAKgCHh6PxeE
 ApWGp+CvRlOSkIwwsp/8wiGU01P6bmPP2Z4d9N3QnydqcGatXEcQTmsll5byCDSIKH5qcyQPj5B
 GDfBkwWURN9TyLg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_080754_695331_21863451 
X-CRM114-Status: GOOD (  17.82  )
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
Breno Leitao (4):
      kho: add size parameter to kho_add_subtree()
      kho: rename fdt parameter to blob in kho_add/remove_subtree()
      kho: kexec-metadata: track previous kernel chain
      kho: document kexec-metadata tracking feature

 Documentation/admin-guide/mm/kho.rst        | 39 ++++++++++++
 include/linux/kexec_handover.h              |  8 +--
 include/linux/kho/abi/kexec_handover.h      | 31 ++++++++++
 kernel/liveupdate/kexec_handover.c          | 96 ++++++++++++++++++++++++++---
 kernel/liveupdate/kexec_handover_debugfs.c  | 15 +++--
 kernel/liveupdate/kexec_handover_internal.h |  5 +-
 kernel/liveupdate/luo_core.c                |  3 +-
 lib/test_kho.c                              |  3 +-
 mm/memblock.c                               |  2 +-
 9 files changed, 177 insertions(+), 25 deletions(-)
---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20251230-kho-7707e8a2ef1e

Best regards,
--  
Breno Leitao <leitao@debian.org>


