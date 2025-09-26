Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C49CAC5B9
	for <kexec@archiver.kernel.org>; Fri, 26 Sep 2025 09:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1gAmHQm9uWAyxumfLUr6FGzFWyjSxL56uS3VHpLy/kU=; b=EOcOIKj3FhbtC7YVMm0pOtQErA
	n1WPEoWPMSO76X1ZK9DkaKsjbp70zRdPRJrdhTeMwLKiZR3NTBDeISoa5e069W1WB1gJ7WxGdiiUf
	/cnetkA5H39a8LODcmJEqHsEsELrjWCth70DzJUIMf/CHv679qGalWH8vIBkZS6K9YIiaCiLWoymq
	ctIooTaep1b2bcxK+3ZL0cHs/e1iBGNmfprY99m5eoVdo7eLAejT/NoHicbj1E0u+lmYX56n4ZNE5
	ylvX/JikIlWkmTmNkQVr2WeNY+fc+h2cXB7pOp4P7RY0rvU8I/0W+1FCfBVTxyqitOxhfgS1dm9NR
	zOJFDPFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v24KC-0000000HN19-2VXP;
	Fri, 26 Sep 2025 09:01:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v24K8-0000000HN02-43rg
	for kexec@lists.infradead.org;
	Fri, 26 Sep 2025 09:01:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 51F4A61C5D;
	Fri, 26 Sep 2025 09:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D609C4CEF7;
	Fri, 26 Sep 2025 09:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758877264;
	bh=aoHwYNOokXAGRoK1jVhoOEMXZxjxQdbdW4MEf+flVRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYXlLIddG5o643w4XSILB/DoVovDl52dYTyTwheDRkfqFKsWIjSGiO1YNg/QQF2DF
	 Yy3+XfHgVG7ufU9kDESkrPZtZ6d/r8e83/Aj5zIqDus2HtsWqRFwB9E0CxVP8MKee2
	 59c7jKvWqAeGCPutnOJk6ZvBchzEXqTLA3H+kihwDIrfq00kEMsqu6qC+xkBL2o175
	 kBmYzKALzV+ZE6VrCqMcG2Lv1rU3A3JU+Yacg3ihF6q+O2+LyoeI2zBr1XyYSxfrQb
	 O5V93ifpDrkxRLTFW/Zx4by2jpfsBs5VFWTN2ctdyNRWtKWc+c7oNeRitDnaHZehYI
	 3YYdR/mFK1Ayw==
Date: Fri, 26 Sep 2025 12:01:00 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <aNZWTB_AbK1qtacy@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
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

On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> This patch series introduces multikernel architecture support, enabling
> multiple independent kernel instances to coexist and communicate on a
> single physical machine. Each kernel instance can run on dedicated CPU
> cores while sharing the underlying hardware resources.
> 
> The multikernel architecture provides several key benefits:
> - Improved fault isolation between different workloads
> - Enhanced security through kernel-level separation
> - Better resource utilization than traditional VM (KVM, Xen etc.)
> - Potential zero-down kernel update with KHO (Kernel Hand Over)

This list is like asking AI to list benefits, or like the whole cover
letter has that type of feel.

I'd probably work on benchmarks and other types of tests that can
deliver comparative figures, and show data that addresses workloads
with KVM, namespaces/cgroups and this, reflecting these qualities.

E.g. consider "Enhanced security through kernel-level separation".
It's a pre-existing feature probably since dawn of time. Any new layer
makes obviously more complex version "kernel-level separation". You'd
had to prove that this even more complex version is more secure than
pre-existing science.

kexec and its various corner cases and how this patch set addresses
them is the part where I'm most lost.

If I look at one of multikernel distros (I don't know any other
tbh) that I know it's really VT-d and that type of hardware
enforcement that make Qubes shine:

https://www.qubes-os.org/

That said, I did not look how/if this is using CPU virtualization
features as part of the solution, so correct me if I'm wrong.

I'm not entirely sure whether this is aimed to be alternative to
namespaces/cgroups or vms but more in the direction of Solaris Zones
would be imho better alternative at least for containers because
it saves the overhead of an extra kernel. There's also a patch set
for this:

https://lwn.net/Articles/780364/?ref=alian.info

VM barrier combined with IOMMU is pretty strong and hardware
enforced, and with polished configuration it can be fairly
performant (e.g. via page cache bypass and stuff like that)
so really the overhead that this is fighting against is 
context switch overhead.

In security I don't believe this has any realistic chances to
win over VMs and IOMMU...

BR, Jarkko

