Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD894C021B2
	for <kexec@archiver.kernel.org>; Tue, 25 Feb 2025 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a+nNbrVcpzRfg0cVt9oM4NlAg5n7LMGEi6yC9l2ygE4=; b=eK8bFyIPGlr0w+ZXgdba3rPpHo
	BvRDNahu5xWZVPRIF44AisJwWVBv+yRS7/lpf5RsRmlBLgL7nobVVy4gj7P3S5znPpQzBVeIegBdo
	QeigEZdBZDHD43VnzrLK65ooSV7MvmO1maqZAiV/Y/QYnlGM3vA2MI4PC0Ep2W/PO33+Cton3ht/Q
	HowHfH5Bi/B9p+lKorK94VmRYQBmMiQpLvSLL2Us2bwsb/IwlRZiKuJzPvL6gPybQvEHiCiqL8e6+
	tKg0iNNZEmitzCIWuf/DRKmVme1I7JzkNU2LykUxkTKa4I7q5mivNS96FVH9qskCmacWC58gCxJPb
	F3gRejpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmphR-0000000GGEm-1hPN;
	Tue, 25 Feb 2025 07:49:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmpfi-0000000GFsj-0f1E;
	Tue, 25 Feb 2025 07:48:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F0F7C6122F;
	Tue, 25 Feb 2025 07:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7196C4CEDD;
	Tue, 25 Feb 2025 07:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740469685;
	bh=eClZUkFpGoFoPisFcTGx3FOMVVxAN549qNzYuXDaN6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfehpgzAULJOLOZKi9leXW7NoihGeIwZGfgqqDeu5KiV1mGWrDwPVnYfTRgxdvz/x
	 eUEiMbxM3XxYo/gmkSSg4xx8xTFkRQppUlh3HUxKONPfFFg/CDnfnacUmmTxgJ/Nl0
	 p03c6jGvE33coM+dHriSIwpAGcEALD6rf9GR0yiK3xOwkPBH/7Aw7fEccJA5pPsujz
	 ioZNQPMfXKd7AoR2Kqkh+jT67yt7GirH7eFeS9NW11qqcNBhAVIKkRdeHuNLA4FcsI
	 VWFcsDgf2SamOyzaQaxOBPvKzWILeKBO0pYTSGt//hRXbLnUc8avjE5frZYFP0WbVU
	 ypiGxCjITbKtg==
Date: Tue, 25 Feb 2025 09:47:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 03/14] memblock: Add support for scratch memory
Message-ID: <Z711oEMpogAHohs8@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-4-rppt@kernel.org>
 <20250224025034.g4htzqgm3r3ja4yy@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224025034.g4htzqgm3r3ja4yy@master>
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

On Mon, Feb 24, 2025 at 02:50:34AM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:43PM +0200, Mike Rapoport wrote:
> >From: Alexander Graf <graf@amazon.com>
> >
> >With KHO (Kexec HandOver), we need a way to ensure that the new kernel
> >does not allocate memory on top of any memory regions that the previous
> >kernel was handing over. But to know where those are, we need to include
> >them in the memblock.reserved array which may not be big enough to hold
> >all ranges that need to be persisted across kexec. To resize the array,
> >we need to allocate memory. That brings us into a catch 22 situation.
> >
> >The solution to that is limit memblock allocations to the scratch regions:
> >safe regions to operate in the case when there is memory that should remain
> >intact across kexec.
> >
> >KHO provides several "scratch regions" as part of its metadata. These
> >scratch regions are contiguous memory blocks that known not to contain any
> >memory that should be persisted across kexec. These regions should be large
> >enough to accommodate all memblock allocations done by the kexeced kernel.
> >
> >We introduce a new memblock_set_scratch_only() function that allows KHO to
> 
> memblock_set_kho_scratch_only?
> 
> >indicate that any memblock allocation must happen from the scratch regions.
> >
> >Later, we may want to perform another KHO kexec. For that, we reuse the
> >same scratch regions. To ensure that no eventually handed over data gets
> >allocated inside a scratch region, we flip the semantics of the scratch
> >region with memblock_clear_scratch_only(): After that call, no allocations
> 
> memblock_clear_kho_scratch_only?

Right, I missed those in the commit message.
 
> >may happen from scratch memblock regions. We will lift that restriction
> >in the next patch.
> >
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

