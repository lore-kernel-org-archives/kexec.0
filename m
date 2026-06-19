Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0175CD98F2
	for <kexec@archiver.kernel.org>; Fri, 19 Jun 2026 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4zyBOPLSXppiqrTp+HdNTK/PZioFQUjwQDpChdpG4r0=; b=SmhhgcIMajmZPIcTN9ybCp4P3Q
	792eR4pmePUYXGvXJflSey5/5VE2CDSKMCfH3OjgBJGsAj+8bQ4QjJkNJ+NF52mtlc005oEb2MFbn
	X7vSLxHjxu2+wHlOPH+4kvYjEQbJWwYuN+apvHMnCds1SFeBpZpCga8uqkHe5QRnuFprVQzjKipTR
	2Y4DpDjh82OG345m/6EYOgEr1KyKScj6CypdyRW2k/gBn7hdBrMUZDN2uH4HF+XgV9K0geDEyfjdJ
	+1uGv1yU2Z9oqT1m2gFyHLP4En2IAvP/5HPIEctHqXiqlR/Bf1eVCEEMVDe1VyFOZEehVxNccDZbz
	gws5EKdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waZlt-00000002WGc-0wXR;
	Fri, 19 Jun 2026 14:00:37 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waZlq-00000002WG8-3DpV;
	Fri, 19 Jun 2026 14:00:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 132382923;
	Fri, 19 Jun 2026 07:00:28 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B49D03F763;
	Fri, 19 Jun 2026 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781877632; bh=5OFQ9ATndI+CfKRhU1GLZ71nxhhjUHxiVn0+oHyd+Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKWENYr6DnwXdIkTUnV+13GaxlcORxcxDxA+ToU6J+hKo+VC7VpQvp9yx8p6Ob3Jb
	 ITB11Z6ChJMlTzZfJvXUe3zzrnMn+fhtH09Vovuzihv4AP7lOi/slveAZkttTVCkMk
	 ZbqHnQbbm/nbu7tNVta3+Rk56KurGsaz0TDOeUSM=
Date: Fri, 19 Jun 2026 15:00:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v4 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <ajVLeseWOZn0XXY2@arm.com>
References: <cover.1781709543.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781709543.git.kas@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_070034_852261_1E533D0D 
X-CRM114-Status: GOOD (  15.13  )
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

Hi Kiryl,

On Wed, Jun 17, 2026 at 08:20:01PM +0100, Kiryl Shutsemau wrote:
>   - GICv3 pseudo-NMI (interrupt priority masking). Its cost is on the
>     interrupt mask/unmask hot path: local_irq_enable() becomes an
>     ICC_PMR_EL1 write plus a synchronising barrier, and exception
>     entry/exit save and restore the PMR, paid on every CPU whether or not
>     an NMI is ever delivered. In our measurements, enabling pseudo-NMI
>     costs up to ~5% on real workloads, and ~66% on a syscall-in-a-loop
>     microbenchmark. A fleet-wide ~5% regression is not acceptable, so
>     these systems run with pseudo-NMI disabled.

Does your firmware set ICC_CTLR_EL1.PMHE? I'd be curious to see the
numbers if the DSB was omitted on the enable path.

> This series adds a third delivery backend that costs nothing on the hot
> path: SDEI. Firmware delivers an SDEI event into a CPU regardless of its
> DAIF state, so interrupt masking stays the cheap PSTATE.DAIF operation and
> the firmware round-trip is paid only at the rare moment a CPU must be
> interrupted.

The direction of travel is to deprecated SDEI. I wouldn't add more stuff
on top of this interface.

(I haven't looked at the patches yet; Marc/Mark/James are more
knowledgeable than me in this area)

-- 
Catalin

