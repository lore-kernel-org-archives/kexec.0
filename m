Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1617F46458
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+3sWqaG5nn51dxLOt71Zd6vUvgXyqNk/HJIYLN7VT+A=; b=Vmtu4W2SfIm78l
	r1QyuiqCkFWZnEnOrSIan5K23IEqWCjdAhjO0EVfCLP55/DQSqGLWuApbC5KUoHkT3lzUHuNhV/om
	e77zm32m03pXRXcQbLuRy6vOIY7Kt/cMs2AShDM2ZQ59WfnrxODzODCJGqg6HK2v4Psg7T5lNXxAZ
	zHEL36J09sRTTEo8MYTD5l1o5F5O6FCuXcl5Sd1LHqgTT3ghtwALiiOW3g+optPjdgpA2FQk25ZPy
	5/V20gH863mA1+8r6duyIZrqdQBvfcZq2eEIBUl6u9kAmDNjG7i7ew0bAYeNNR6Ghz5DNtgJ+qIhx
	CrxCHvlYD4dtDNODPhxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26YX-00000003rwG-1zOf;
	Mon, 16 Mar 2026 11:56:21 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26YS-00000003ruh-0mSR
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 11:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=+3sWqaG5nn51dxLOt71Zd6vUvgXyqNk/HJIYLN7VT+A=; b=sZGSqH43BTch+mWz1rtg96XWBO
	x41dM0DqeFJK7wvzLiU9SgysU6I7zI6Vm3UGw/clQ80vpHXd6576ftEWiU6mlVI0b/+dfbAS2bO2z
	fSFzfZBRL19LaDBDbx3KyNjOxvIAY/8KPOoTkbOKSgCIHu6nTqk2q4ddklCVB5fxbtszuGQVO13tU
	C2qilsG6zQDBuv2T7ybpoJBy0Gj0RcWfkR3d2mee82bZuE2EMhRTMf103bdoLP2is3Uixuz/W0RGh
	vEQNtS6b77Cf85b36jnznIJY679jk/qx2EcJVP2KF7sRZyymatJHMPHVmSBsXlyN1RJmnZ6z/batZ
	N8ioLnPg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w26YI-0025yt-Hj; Mon, 16 Mar 2026 11:56:06 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v9 0/6] kho: history: track previous kernel version and
 kexec boot count
Date: Mon, 16 Mar 2026 04:54:30 -0700
Message-Id: <20260316-kho-v9-0-ed6dcd951988@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHjvt2kC/23Oy2rDMBAF0F8xWmfKjF4jZdX/KF3o5UQtxMFOT
 UvIvxdHLXVwlwP33DtXMZWxlknsu6sYy1ynOpzEvvO7TqRjOB0K1Cz2nZAoDUmF8H4cgBm5uCB
 LT0XsOnEeS18/7y0vr+2ePuJbSZeFLoljnS7D+HWfmWnJPTbOBAQ6szdB6hx8ec4l1nB6GsaDW
 Cpn+YssEsqGJCAQa44UVKBsN0itkWtIAUKkbCMH55WWG6RXSFJDGghMcn1hjtah3iCzRrYhAwi
 cMvbWhyj/QXaNuCELCMb2XnlrHaXte/yHFP4sMSBo1Jl0Iudi3CC3Rr4hBwhJhZh6HRIbfEC32
 +0brNMrQBwCAAA=
X-Change-ID: 20251230-kho-7707e8a2ef1e
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usama.arif@linux.dev, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5054; i=leitao@debian.org;
 h=from:subject:message-id; bh=ARvgIQy24NhYr5bkE3olZX6vfsQX4plYP9jziUj1kxM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpt+/QFnQikZZWlBAE+AfJ+O6pSuzsgCLMRSSkx
 4FIof3B+/eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCabfv0AAKCRA1o5Of/Hh3
 bXZJD/4pxZqo3ENUuwQa+oHyXClC7dYCX63gXiJkELp44LtVBrdjFuw+w03fMOeJ9jzx9AdABas
 aZ/dGvCNa2EBjEH3Lqo6EeANYPmCq29pQJF1AFCbfUFH7ZIWl02IwvTO7MCNf4V2UjOlTDv3POH
 ikHMvKAcemBGTGySTrYQz8+vilIrooCHOg4EUA7yXbhTLakzlRPActpa+wQBszCvSeKRPmmIzgJ
 nBBvbOq7HwN70/EHssoXrFWSzTS4RAzNKvOC8De9zIs/8JfEHhdAbiym5Tw3TV3UtG8Onhzm9Ap
 SDXnbn3f1FB24N7UXrYCBn+NvKArkhuhV0hTPRP6GpU3gG+1G+BiWsc7dKEAU4dIz4/QDfsQCNZ
 hA8FicKvzmew+L6ebw2r6AUWXGGOOO0wqDWl41bjFkhHVeqBMlcYyz4tysz1zw9leY9mUyZnY9R
 GqoKBXQLjoyhJFMWyd1TNcodB8ecVvOtJkSIrEXNjvsU0Woh0ied3UhFdLdakdzkL4ViaomH/lx
 mEM6Ud+UV6V5crm3SISgu6kUGLEVwZlQhWVnjMu52nX/REKhpqEyQ3woDmFsj44o4zIil2dMIF7
 oKBi1eeUoaNtOg9ddfAY/KSPPGzNjbvbCjQpERRnwFKxIFQljMNTTYf+WI602X9GcqCCtN3KAU4
 Vu0A3ZgmQAeUsCA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_045618_409322_6CDFA883 
X-CRM114-Status: GOOD (  18.12  )
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
Changes in v9:
- Rebase on top of new KHO changes
- Fail and ignore subtree in case size is invalid (Pratyush)
- Separate kexec_metadata into a new file (Pratyush)
- Link to v8: https://patch.msgid.link/20260309-kho-v8-0-c3abcf4ac750@debian.org

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

 Documentation/admin-guide/mm/kho.rst        |  41 +++++++-
 include/linux/kexec_handover.h              |  13 +--
 include/linux/kho/abi/kexec_handover.h      |  20 +++-
 include/linux/kho/abi/kexec_metadata.h      |  46 ++++++++
 kernel/liveupdate/kexec_handover.c          | 158 ++++++++++++++++++++++++----
 kernel/liveupdate/kexec_handover_debugfs.c  |  55 ++++++----
 kernel/liveupdate/kexec_handover_internal.h |  15 +--
 kernel/liveupdate/luo_core.c                |   5 +-
 lib/test_kho.c                              |   5 +-
 mm/memblock.c                               |   4 +-
 10 files changed, 298 insertions(+), 64 deletions(-)
---
base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
change-id: 20251230-kho-7707e8a2ef1e

Best regards,
--  
Breno Leitao <leitao@debian.org>


