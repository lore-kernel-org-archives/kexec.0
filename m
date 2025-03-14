Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AE4C35FF1
	for <kexec@archiver.kernel.org>; Fri, 14 Mar 2025 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGwTGMhDA72u3HpHurZoSeTcMRlb1EK2JgRtQTCU0lI=; b=V3v6ffS4CI8nPLqJctGlCbiol/
	VJ96CzgnBDY/1Q58aEpK2GC0T4epukGl3Qdki1BSxNpuA2QXm3oSfr5HKsuk1DtgFskUtxtYz+FsL
	Yx7oIG/hW4Tkd3ED1Vr0hRZnk6t1RIljn334eUuf7C6n9UgXW/fLnUwr1LSyu17Hy6lcQuxadv77M
	FbsUhuQj5xVmPVNuGdG6Mye691pdaNGw3aODltaPq6yD2MgpLx2UeuBpTHDVVd2scAKCGMzup7sH6
	Sif2sbMqMXU3RUgG6EMhkvh6A/HcRFvc/jbM0V08SzWgJYBjBnWt0axO9en104f1ZgQ+qSn+wDzu9
	H1lm2XLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt7dO-0000000EhIu-3mCB;
	Fri, 14 Mar 2025 16:11:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt7Zr-0000000Eg5L-0qfn
	for kexec@lists.infradead.org;
	Fri, 14 Mar 2025 16:08:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DB60EA47770;
	Fri, 14 Mar 2025 16:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AD9C4CEEB;
	Fri, 14 Mar 2025 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968481;
	bh=UJQfc8Sd9y6RluPNY5HI8byThwwXEJliQ6skToVHEQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyDl8W3ejOR1+FfyMJEb0SXtm/sgaDZ25kdhv/gwuvWyq15x1/OnjUoI4viQC7eae
	 GKwEP0b9beV5Rtp5WqBCgWcKTr3qwg0fJrLdEDAKBGNpQfkW5nCWVCP1xBe9sJePpH
	 O8tYYyTMcKOx/n1vWK2mCPdHnpKJuyicNYodw+cPDxj20k+I73iksJ98bdXDmyiqcJ
	 SRUPjsRsda8A29NSG5iqSzLy3e7zsK/F49h0WwoSqZ0FOyUlb4ke4yESMg9vabx1RN
	 M14EUPBZbuppRdoJclxct+Qb91PW67j2qLkfxt9BJayPJUG33sGFfH7xT6Xn5DMTB8
	 gIg4azQ4sRhLw==
Date: Fri, 14 Mar 2025 09:07:58 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Subject: Re: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type
 information to relocate_kernel()
Message-ID: <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312144257.2348250-9-dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_090803_307755_ABA62E65 
X-CRM114-Status: GOOD (  13.76  )
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

On Wed, Mar 12, 2025 at 02:34:20PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> A previous commit added __nocfi to machine_kexec() because it makes an
> indirect call to relocate_kernel() which lacked CFI type information,
> and caused the system to crash.
> 
> Use SYM_TYPED_FUNC_START() to ensure that the type information is
> present, and remove the __nocfi tag.
> 
> I still can't make objtool happy with this in both GCC and Clang builds
> at the same time, so not yet for merging; only included in this series
> to nerd-snipe the objtool maintainers.

Again, I'd recommend just compiling the code in .data..relocate_kernel.
Then objtool doesn't need to care.

Otherwise it would help to know what warnings you're getting with this
patch, and the corresponding .config.

-- 
Josh

