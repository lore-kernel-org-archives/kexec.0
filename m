Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8657C61DB9
	for <kexec@archiver.kernel.org>; Thu, 27 Aug 2026 09:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=a1NsHoqwbDOf48Qmm21dp9rJ0H89tollm0qcEOxhzWM=; b=s5yT2M7uAsZYZ6yYbX3SGs0jiY
	eU21T0VXuFnQmMk17BEfYD7zD3r9wTsr4BJnrGoNskWbWLdLuo/gqzqy9J2u+MH+O8bfwnw/Fk1eK
	LP0xi/oQ7Dmn9HgydLxWIB3vetG9IWEf/x6gC9wcbWjnjcA5iK5tLhDms0qjB80SBUgB77M9+Lbzx
	pv3zWZX2wXpNti1OS44VfH9KbnUEbPfvgwr7VdBXG8B8ddIwNEwNridfl2QgrhlyAHthwOfzns5+x
	3jBOoRdbdh3KSS6vl0fNcLZ+cpZXT9a+WjLL3Sf4ukC3sQoUrv31GICmeGYe59wbUroLu3ZaZ2L/p
	56V/4uvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzWoo-00000003msb-3sX1;
	Thu, 27 Aug 2026 09:54:46 +0000
Received: from mail.mainlining.org ([5.75.144.95])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzWoh-00000003mrt-2IQt
	for kexec@lists.infradead.org;
	Thu, 27 Aug 2026 09:54:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787824072; bh=a1NsHoqwbDOf48Qmm21dp9r
	J0H89tollm0qcEOxhzWM=; b=ChZPJSFJXKedFrS2dCvs9xTrBJTq5wR1u/PmZC6LNICzwxOYc2
	c0QH39imkm2Li+4rJzayDWY/I392VpOK3lyJ3DZvGFVC0V8OT4GuQBXj9T2qujm5beELGplfLOs
	6rQAEjSjUjPmwx6ouCdNPmK5nNrxDCqZXTP38KAs81Rgp1TML4xKIwFNpWo4B8nWCww2FGYh4qQ
	i+j4q/jwqfq8gI29u7GzKxNWnCP7vY9mAjF4dvAV+fhia6f0x4fSogiY3OnFc5yhmRm8kreZDko
	kIUCmsM1k4IKIgM73gvQWGsOyl2mjkU6RdcCuv9MqubgfDm2eXiEklPFjI2+Bl9x/Tw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787824072; bh=a1NsHoqwbDOf48Qmm21dp9r
	J0H89tollm0qcEOxhzWM=; b=iJwlMI4OvVcbA7FgcUhslQFpHiuFB5m53LDjRiUXyw2J9R0pB5
	lMjr5EE723fxp+05u10rOBDTvZ6DVialeHBw==;
Date: Thu, 27 Aug 2026 10:47:52 +0100
From: Bradley Morgan <brads@mainlining.org>
To: ionut.nechita@windriver.com
CC: akpm@linux-foundation.org, baoquan.he@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, eric.devolder@oracle.com,
 hbathini@linux.ibm.com, hpa@zytor.com, include@grrlz.net,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, rppt@kernel.org,
 ruanjinjie@huawei.com, ruirui.yang@linux.dev, sourabhjain@linux.ibm.com,
 tglx@kernel.org, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_0/2=5D_x86/crash=3A_size_th?=
 =?US-ASCII?Q?e_elfcorehdr_reservation_with_NR=5FCPUS?=
In-Reply-To: <20260827070822.12651-1-ionut.nechita@windriver.com>
Message-ID: <6755A837-E429-499E-B9E1-6679C595F717@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_025439_741216_1F0A1153 
X-CRM114-Status: GOOD (  13.90  )
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

On 27 August 2026 08:08:20 BST, "Ionut Nechita (Wind River)"
<ionut.nechita@windriver.com> wrote:
>From: Ionut Nechita <ionut.nechita@windriver.com>
>
>Hi,
>
>The x86 crash code sizes the elfcorehdr reservation with
>CONFIG_NR_CPUS_DEFAULT, which is a Kconfig default and not an upper
>bound.  The header itself carries one phdr per possible CPU, so the
>reservation is too small whenever NR_CPUS exceeds NR_CPUS_DEFAULT.
>
>Patch 1 sizes it with CONFIG_NR_CPUS instead.  Patch 2 fixes the two
>comments that still name NR_CPUS_DEFAULT.
>
>Based on linux-next (next-20260826, base-commit f82a5da2f0496).
>
>Changes since v3:
>- Patch 1/2: cut the changelog down to what Dave Hansen suggested.  I
>  kept one sentence he had dropped - that kexec_file_load(2) fails with
>  -EINVAL - because that is the failure this was reported for and what
>  the Fixes: tag addresses; the silent kexec_load(2) truncation is the
>  other half.  Happy to trim further if that is still too much.
>- Patch 2/2: changelog trimmed the same way.
>- No code changes; the diff is byte-identical to v2 and v3.
>- Rebased from next-20260825 onto next-20260826.
>
>Reviewers: the code has not moved since v2, so I carried the tags again.
>
>Reproducer, for the archive - single-socket Xeon 6776P, PREEMPT_RT, with
>CONFIG_NR_CPUS_DEFAULT=64, CONFIG_NR_CPUS=256, CONFIG_MAXSMP and
>CONFIG_MEMORY_HOTPLUG off, CONFIG_CRASH_MAX_MEMORY_RANGES=8192:
>
>- 144 possible CPUs: the buffer overshoots the reservation by
>  (144 - 64) * 56 = 4480 bytes, more than the 4096 bytes of page
>  padding, and 'kexec -p -s' fails with
>  "kexec_file_load failed: Invalid argument"
>- 72 possible CPUs (reduced via firmware): the overshoot is
>  (72 - 64) * 56 = 448 bytes, still absorbed by the page rounding, and
>  the load succeeds
>
>The two follow-ups Sourabh Jain raised on the v2 thread - the
>add_segment_phys_virt() bufsz truncation in kexec-tools, and having
>crash_load_segments() skip the kbuf.memsz update when the prepared
>buffer is already larger - are still deliberately out of scope here.
>
>v1: https://lore.kernel.org/lkml/20260812170433.533845-1-ionut.nechita@windriver.com/
>v2: https://lore.kernel.org/lkml/20260825075043.42041-1-ionut.nechita@windriver.com/
>v3: https://lore.kernel.org/lkml/20260826073527.21487-1-ionut.nechita@windriver.com/
>
>Ionut Nechita (2):
>  x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not
>    CONFIG_NR_CPUS_DEFAULT
>  crash: update stale NR_CPUS_DEFAULT references in elfcorehdr sizing
>    docs
>
> arch/x86/kernel/crash.c | 6 +++---
> kernel/Kconfig.kexec    | 2 +-
> kernel/crash_core.c     | 2 +-
> 3 files changed, 5 insertions(+), 5 deletions(-)
>
>
>base-commit: f82a5da2f04960df9fb57489992d03dd5e64ec6f
>--
>2.55.0
>
>
>
Mergers, could you use my new email (brads@mainlining.org) instead of my
old one
(include@grrlz.net) for This?
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

