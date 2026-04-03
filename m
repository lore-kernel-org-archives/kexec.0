Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F07EE7E377
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KzZY8L8j+iM3cPq/I7dLv2ptABG2XRsTCwTxzvY2IeA=; b=JOEabicu43Y+dXqHbxUzDEANbl
	eQlBJ5ub9gZnEO+JKiSUk6toTiZLAN5m5xA4MWBsSM4EFP/jKI8ilcVNso/Jialn4wxmAO1/NOADI
	cA6nlAnaL3ipKz5ynyTdpUe+QD7cBn8DvXl2hv16Epr7m9OWJ9qjWr3rYlg0hkFht4niIolTVHDfD
	yQXYTz+Rt7ql+FpQU5EYsBoT5E58raABOKtomGcS4U6DdagoaK/LtNC+A2UCEYse3OIWyBqcDOltp
	AVEc9sXO1ccm4ZK424q67DCFVy4voMYCj9F5YCyp8URqJ+82OWVcDFl+9Rgbvn5uB9+3LCd0A1sBN
	PeKhYdrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ciA-00000001xTD-3nno;
	Fri, 03 Apr 2026 11:29:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ci9-00000001xT6-1snz
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 11:29:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A79D260008;
	Fri,  3 Apr 2026 11:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20139C4CEF7;
	Fri,  3 Apr 2026 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215752;
	bh=iE9kV0f3BkfaTSJVskz3DMLc2zztbYk8PO5i/0ZBG9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gU5ih5qsMO7SmY/P80P2pCZSA3Ljhr1wgGtOkuXRGDoq+rIz+QcjTSlK/sPrEsKCm
	 oUL1goaNVxqbB4MMLX6uhuNJZfpz6RzoX3T5bn4RqecI2ztDVlbm9faKl3jI+Pdp1s
	 eC1QyUQOoK9P3iGg7daPKtkTPBmsX4p6HZwM93ETSmtNunlKFMB+4TP1u6mkuFVyIk
	 e9xcN65pIQFA3w+isBLRUffhruy8GD2yLh9kdmTEJyI+0odbknXoz6nNhaii8KOtjj
	 Zq7R9XrNn4LTkoGTTBbB+bDTaBRT0QYPk4ZB3QNlqmyenTSj2bf1sEpBJS67MaPF3a
	 Y8RhyYHey0ZlA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usama.arif@linux.dev,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v9 5/6] kho: kexec-metadata: track previous kernel chain
In-Reply-To: <20260316-kho-v9-5-ed6dcd951988@debian.org> (Breno Leitao's
	message of "Mon, 16 Mar 2026 04:54:35 -0700")
References: <20260316-kho-v9-0-ed6dcd951988@debian.org>
	<20260316-kho-v9-5-ed6dcd951988@debian.org>
Date: Fri, 03 Apr 2026 11:29:08 +0000
Message-ID: <2vxzika8cmez.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Mar 16 2026, Breno Leitao wrote:

> Use Kexec Handover (KHO) to pass the previous kernel's version string
> and the number of kexec reboots since the last cold boot to the next
> kernel, and print it at boot time.
>
> Example output:
>     [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107 (count 1)
>
> Motivation
> ==========
>
> Bugs that only reproduce when kexecing from specific kernel versions
> are difficult to diagnose. These issues occur when a buggy kernel
> kexecs into a new kernel, with the bug manifesting only in the second
> kernel.
>
> Recent examples include the following commits:
>
>  * commit eb2266312507 ("x86/boot: Fix page table access in
>    5-level to 4-level paging transition")
>  * commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory
>    for event log to avoid corruption")
>  * commit 64b45dd46e15 ("x86/efi: skip memattr table on kexec
>    boot")
>
> As kexec-based reboots become more common, these version-dependent bugs
> are appearing more frequently. At scale, correlating crashes to the
> previous kernel version is challenging, especially when issues only
> occur in specific transition scenarios.
>
> Implementation
> ==============
>
> The kexec metadata is stored as a plain C struct (struct kho_kexec_metadata)
> rather than FDT format, for simplicity and direct field access. It is
> registered via kho_add_subtree() as a separate subtree, keeping it
> independent from the core KHO ABI. This design choice:
>
>  - Keeps the core KHO ABI minimal and stable
>  - Allows the metadata format to evolve independently
>  - Avoids requiring version bumps for all KHO consumers (LUO, etc.)
>    when the metadata format changes
>
> The struct kho_kexec_metadata contains two fields:
>  - previous_release: The kernel version that initiated the kexec
>  - kexec_count: Number of kexec boots since last cold boot
>
> On cold boot, kexec_count starts at 0 and increments with each kexec.
> The count helps identify issues that only manifest after multiple
> consecutive kexec reboots.
>
> Acked-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

