Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B425D232C7
	for <kexec@archiver.kernel.org>; Fri,  9 Jan 2026 01:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQ8DFNoN9le9TZBMx4B8fIsPgTjdjheXyeIfiKr7Al4=; b=OA5pFrnH3W18Si31bpgwTsx08W
	Pn3bO1/SeNR3wHxuzaqmLI4ZBw0Iq2HQ9GviU6FQXPpGIruAT+AX4MA4YThRRIXU7A4wMF51bEqSg
	S+BwbQ/Y9XH5GYHO0GfIHc66l/N64Ua4zf2nYz5vRuSTuk6irFRSfulXOea1XQ3tGFZE/ILUj6xKD
	9MNY/op70QR6e0VMw8m0cExGF+XCWIS1wWT3uP80PSIFWIw5BXBdGpNvvrl/c70sTPqRYxTyjL5vz
	/na/eCao7sdhTD9RyaiikTSwb5pXqaVfykSDwHqDchciK3h6WDCR6aOw1lnvhQ5pGlMRSwkfKlgNG
	nkgju1QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve1Zm-000000015Od-3CMt;
	Fri, 09 Jan 2026 01:46:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve1Zl-000000015OW-1NTK
	for kexec@lists.infradead.org;
	Fri, 09 Jan 2026 01:46:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EFBD860136;
	Fri,  9 Jan 2026 01:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFD7C116C6;
	Fri,  9 Jan 2026 01:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767923163;
	bh=HR7001FSUS5rNpOFxSI1vceayRCNk4N5sG9dhwwS6vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwWxfoMuiV6/C2hFWNgALJYvXsfScorunRS6oK52CCl42zDB95MWS2FvpJBCSBh3X
	 JSK5+NjEGrXvmRaM4tSHZq3UdNIoLi1mxkz/8SHQ4ZOxgjMx+Fxp9Dh9Ud6imI3xAB
	 4Fuhl/beerswmv41LYYfITUoF1omTgiYbvWMvH4EUZwcEPYE4YF1xONhcvhcTWG+Z+
	 vNguh6jxQXkQxwc90HnI/Knqc/WdM7P6LfLG8g/ETM194Co8WEwECe35g5Gqj/2eaB
	 M4EI9Jyt5P3UtthKyXBwYjkTOTeL16Zx8RvRwSX133kkwS/atZX+4kO0ER8MWLldJ8
	 QH3ZMjNsWSBYg==
From: SeongJae Park <sj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: SeongJae Park <sj@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	usamaarif642@gmail.com,
	rmikey@meta.com,
	clm@fb.com,
	riel@surriel.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] kho: history: track previous kernel version and kexec boot count
Date: Thu,  8 Jan 2026 17:45:58 -0800
Message-ID: <20260109014559.68677-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, 08 Jan 2026 08:40:57 -0800 Breno Leitao <leitao@debian.org> wrote:

> Use Kexec Handover (KHO) to pass the previous kernel's version string
> and the number of kexec reboots since the last cold boot to the next
> kernel, and print it at boot time.
> 
> Example
> =======
> 	[    0.000000] Linux version 6.19.0-rc3-upstream-00047-ge5d992347849
> 	...
>         [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107upstream-00004-g3071b0dc4498 (count 1)

Nit.  The above snippet uses tabs for first two lines, while the third line
uses spaces.  I don't really mind this of course, please feel free to ignore.
I just wanted to prove I did read your cover letter ;)

> 
> Motivation
> ==========
> 
> Bugs that only reproduce when kexecing from specific kernel versions
> are difficult to diagnose. These issues occur when a buggy kernel
> kexecs into a new kernel, with the bug manifesting only in the second
> kernel.
> 
> Recent examples include:
> 
>  * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
>  * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
>  * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")
> 
> As kexec-based reboots become more common, these version-dependent bugs
> are appearing more frequently. At scale, correlating crashes to the
> previous kernel version is challenging, especially when issues only
> occur in specific transition scenarios.
> 
> Some bugs manifest only after multiple consecutive kexec reboots.
> Tracking the kexec count helps identify these cases (this metric is
> already used by live update sub-system).
> 
> KHO provides a reliable mechanism to pass information between kernels.
> By carrying the previous kernel's release string and kexec count
> forward, we can print this context at boot time to aid debugging.
> 
> The goal of this feature is to have this information being printed in
> early boot, so, users can trace back kernel releases in kexec. Systemd
> is not helpful because we cannot assume that the previous kernel has
> systemd or even write access to the disk (common when using Linux as
> bootloaders)

Sounds this feature will be useful!  Thank you for detailed cover letter.

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

The patches also look good to me.  For the series,

Acked-by: SeongJae Park <sj@kernel.org>

> ---
> Changes from v1 to RFC

Nit.  You mean "from RFC (v1) to v2"?  Again, I don't really mind this trivial
thing, so please feel free to ignore.

> - Track the number of kexecs since cold boot (Pasha)
> - Change the printk() order compared to KHO
> - Rewording of the commit summary
> - Link to RFC: https://patch.msgid.link/20251230-kho-v1-1-4d795a24da9e@debian.org
> 
> ---
> Changes in v3:
> - Remove the extra CONFIG for this feature.
> - Reworded some identifiers, properties and printks.
> - Better documented the questions raised during v2.
> - Link to v2: https://patch.msgid.link/20260102-kho-v2-0-1747b1a3a1d6@debian.org


Thanks,
SJ

[...]

