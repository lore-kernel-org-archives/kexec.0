Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F161AC02198
	for <kexec@archiver.kernel.org>; Wed, 12 Feb 2025 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nltTZzKoIJD8v8cI1Mbb1ugEPFMXVME2vX7W2rBS9Ho=; b=O40iuEz1IUeKy4yr2K0jomWzew
	yI/qfGOraeRsH0b8Jw8APTh12fNG5ozIlNlJvv2mSTUleMovfKeRBCCs262OIUErh2O1Ou4JSLlrB
	2ZAKypj0GFIvUE2vjQD6h5rKNN3pqfKVIlBIJai5uagHWuB0dap70SOcsJSwgry1TvQULSAxnLC/7
	6l05SrBJyy6UyYJNPC6dCM82+fSI1lXwAahIKTYGdLv7vsnW7vuCFFRrx37etZUSabCUUayVMZOw5
	wRvNOhojB77LW//nz3qoE2GDm4vEDsnwNCM2riQpr+obd6tHCRle1V/A8tmXkNb9nqfLNglgV0CmR
	d/gvPkpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiFXJ-0000000845l-2Oh8;
	Wed, 12 Feb 2025 16:24:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiFAK-00000007yel-1PIG;
	Wed, 12 Feb 2025 16:00:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B928E5C6084;
	Wed, 12 Feb 2025 16:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA975C4CEE4;
	Wed, 12 Feb 2025 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739376042;
	bh=P2PvM3qZ0BEUNG+xxCfwPu3336ksPgx0VFrUhWZNXA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCC36UzI5XBvCVDEyZmkpEjKTweo4lRn22Jcr57O8TYA4WG6yztDM7xUPMpbHXwPA
	 6ik2sjCWTK0Demi17AUvltnpwZJs4K21ZaxEOhIlLsoX2/gKsbDoao1B4LyUk3Gt+7
	 RLzMvpg1RTwslbWYmoqoSEp5phjfBi/bAWroTHzeNBMwQuhzqelFPR9Bth1s50o/Cu
	 t762+vVPiI4XQFx/Q36/eBPYLe9Se/7uXtevG82OKGZbPPnAfHpZVkE/pHCGPluycY
	 b0sJBqsOa66GQ2IOn3SvABlnQv2cQEWXragDbof3+ALbgRqjK+8gMM93Qrt5GFCJFb
	 P+dBLJrUeXXaw==
Date: Wed, 12 Feb 2025 18:00:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
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
Subject: Re: [PATCH v4 14/14] Documentation: KHO: Add memblock bindings
Message-ID: <Z6zFlKU3Cm3nHI74@kernel.org>
References: <20250206132754.2596694-15-rppt@kernel.org>
 <45df0d7a-622a-4268-9683-c5c6067483c3@kernel.org>
 <Z6jFZII5b-j7hzkj@kernel.org>
 <a3cca0ed-64ca-4921-bb4c-27c0e06b78c6@kernel.org>
 <Z6kTCvex3DGhB-3C@kernel.org>
 <18529b1f-dc79-4c85-a485-a0a2cdd48670@kernel.org>
 <aa4ec16a-b35f-41b0-92f7-40b3eb64124a@kernel.org>
 <20250210191539.GA3765641@nvidia.com>
 <2fe7a404-be2c-4ac8-8980-2b3d07a74bca@kernel.org>
 <20250210202040.GB3754072@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210202040.GB3754072@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_080044_481620_87D85990 
X-CRM114-Status: GOOD (  25.48  )
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

On Mon, Feb 10, 2025 at 04:20:40PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 10, 2025 at 08:27:34PM +0100, Krzysztof Kozlowski wrote:
> > On 10/02/2025 20:15, Jason Gunthorpe wrote:
> > > On Sun, Feb 09, 2025 at 09:50:37PM +0100, Krzysztof Kozlowski wrote:
> > >>> Ah, neat, that would almost solve the problem but you wrote:
> > >>>
> > >>> +$id: http://devicetree.org/schemas/memblock/reserve_mem.yaml#
> > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>>
> > >>> so no, this does not work like that. You use devicetree here namespace
> > >>> and ignore its rules.
> > >>
> > >> ... and that obviously is barely parseable, so maybe one more try:
> > >> "You use here devicetree namespace but ignore its rules."
> > > 
> > > It makes sense to me, there should be zero cross-over of the two
> > > specs, KHO should be completely self defined and stand alone.
> > > 
> > > There is some documentation missing, I think. This yaml describes one
> > > node type, but the entire overall structure of the fdt does not seem
> > > to have documentation?
> > 
> > A lot of ABI is missing there and undocumented like: node name (which
> > for every standard DT would be a NAK), few properties. This binding
> > describes only subset while skipping all the rest and effectively
> > introducing implied/undocumented ABI.
> 
> I agree, I think it can be easily adressed - the docs should have a
> sample of the overal DT from the root node and yaml for each of the
> blocks, laying out the purpose very much like the open dt spec..

I'll update the docs with more details about overall structure and will
make it clear that it's a different namespace.
 
> Jason

-- 
Sincerely yours,
Mike.

