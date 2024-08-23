Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A2FC531DC
	for <kexec@archiver.kernel.org>; Fri, 23 Aug 2024 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iGFADEKLCiijzHY+3QX1baALD/6BLFSNjiqF/tQk2+U=; b=NV9z7H95C/qis6
	3EDceG7ghCsSeyARpREqeD/WsSrj5DVNsnd8AQxGJOFCeVWg1Bn8qXzzFnnM/j0lW7bnqAk+F5EJG
	Z8jRXAen20iagdMF4Dy9/yc9OrM7wUnQ7nU3LNHZbu/yDeSAXTIw3phsr6RSxF+8dRCStUU1z2WBO
	vZRckJ0bTw1EYPpdDpqT+32H3Qd0Lyf90LQNo6OiCKUOUoTeBeK5Jb0mA2Wu4V/MMsB8t+me1hiUV
	/zqk+7t2kfidDGZq+lozBBeWV5dXpmSDxNbPz1onpebIYkXyvUTXfeBjxrlVl7CAiF2PN6zyB5Csm
	LhyLiSp1pBVKNfYsGKQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shUVA-0000000GuEA-1nbV;
	Fri, 23 Aug 2024 13:38:52 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shUV7-0000000GuCx-0Grt;
	Fri, 23 Aug 2024 13:38:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 90296A426C3;
	Fri, 23 Aug 2024 13:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABFBC4AF09;
	Fri, 23 Aug 2024 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724420328;
	bh=dB0mTfCvDgSTO3JcUqKUWZ1+AcU5IS80RPGy27fBN60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gjk0vFXQG27UTeP4xLbfFFmvTaURku60g3BAidJvUrf4IPa7idaSUqVW0g5GfPzQm
	 n7TTlsV9Ne61NzS5Hv4fbn9MG/5yyDJ/sj9WqJiAUNLqx7kx/mXhqZcGNYAYked8If
	 NF46xcDbXxveTE81faPrBJxAzyzFQ0wnF6JBj4H69CJN5NRrZB2fNFTbtPDHS5tfEN
	 qgG5WbRu9Mu/bNdyXEUhpFacTPYYrohd+uqM3ejE/1drA8meIuMA47tD1VRpGhn5im
	 vQKSUfnpmmSP689tWktFN64OxkkTniuoIwAOS53OQVfGp+QgRm9Zne5SfYkq84/J+V
	 wjqKlxSqT/WdA==
Date: Fri, 23 Aug 2024 14:38:42 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, catalin.marinas@arm.com, rmikey@meta.com
Subject: Re: arm64: Kexec: Warning: virt_to_phys used for non-linear address
Message-ID: <20240823133842.GE32156@willie-the-truck>
References: <ZnFKEtqfqJkYflwL@gmail.com>
 <ZnFxI-jCoJcO8WPw@J2N7QTR9R3>
 <20240624113614.GA8361@willie-the-truck>
 <ZscEo8KJfn4xfm6X@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZscEo8KJfn4xfm6X@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_063849_188730_9A0EA1D0 
X-CRM114-Status: GOOD (  27.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Aug 22, 2024 at 02:28:03AM -0700, Breno Leitao wrote:
> On Mon, Jun 24, 2024 at 12:36:14PM +0100, Will Deacon wrote:
> > On Tue, Jun 18, 2024 at 12:36:03PM +0100, Mark Rutland wrote:
> > > On Tue, Jun 18, 2024 at 01:49:22AM -0700, Breno Leitao wrote:
> 
> > > > Since __pa() is a macro to __virt_to_phys():
> > > > 
> > > > 	#define __pa(x)                 __virt_to_phys((unsigned long)(x))
> > > > 
> > > > I am curious why this address is special that makes __virt_to_phys()
> > > > unhappy.
> > > 
> > > It's a fixmap address rather than a linear-map address. Confusingly
> > > 'virt' generally means the linear map rather than any virtual address,
> > > and usually virt_to_*() only work on linear map addresses.
> > > 
> > > I'm not sure how to fix this; the major reason we fixmap the FDT is so
> > > that it can be anywhere in memory (and e.g. may not be in the linear map
> > > at all), so we can't always generate a linear map VA.
> > > 
> > > We could stash the PA at boot time, and pass this as an argument to
> > > of_kexec_alloc_and_setup_fdt().
> > 
> > Yeah, if it was passed as an additional argument to early_init_dt_scan(),
> > then the core could could track it. Alternatively, we'd need a helper
> > macro to get the PA and have an arm64-variant for the fixmap (everybody
> > else could use __pa()).
> > 
> > > Rob, any thoughts? I couldn't see a neat way of doing this, but maybe we
> > > could initialise an initial_boot_params_phys at setup time, with a bit
> > > of churn to early_init_dt_verify() and friends?
> > 
> > Rob?
> 
> Hello, is there anything I can do or test to have this moving?

I've not seen anything from Rob, so the best bet is probably to see if
you can hack up a patch to fix it yourself and then cc the rest of us
when you post it.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
