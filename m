Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16DFFA3752
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fsMs/AbVOowjNRNxn0Ki17k90jR/IkzF8PcKdqkkE2E=; b=Jaaxcd4cqnY7Sxm8PnQ46wVRC9
	chjFd0CTPXW8Udb99NL9CncJFVA4h5dUrFIJXTFf2FSLtwXysy16peB7tsw+eb4m81L3R1aTeJ5tZ
	zkCnahyy7nv5pvguA30G19mykPLGZf4lI3aekjEgsk7Sw9Yei8rPhcASQmDun16pd4rbIYB4gTP/y
	Xq6vKn9xHOO2xi1WZMP2Dn961snBTUqeanVpWl8pGzFWVXvqDdKYEErPS/I5giMJ1uWZ0zQcX07eZ
	/Fj6n5OV35YvcaD4t43H0mFq47VZfXC29gTq/V+KwCTe9k/L5YBsTeknQoA++tlklHySlyLmOENeW
	qwr37gWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgrB-00000008Q1X-20jI;
	Fri, 02 Jan 2026 15:14:25 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgr9-00000008Q17-3im4
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 15:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fsMs/AbVOowjNRNxn0Ki17k90jR/IkzF8PcKdqkkE2E=; b=WeGY8daE2/Lrj9EhBZvneJjFAD
	EvyJXA/NWTiTuZiuzCVVY4jX3BBlfm+66hCRtP6/aD88000k2Bfg2TGa4TKiE5H3fql4v70GMVLsK
	B/PO7zOTDIWwQ0I3wZyg9lHE5u4N6gULreaY2dDUk3Y5G1Vb95ipEvIWRM8UKB3xQ3K3KHfpA6lXt
	P56r/CxbiwmbcpctCj4DHviLLcpZaT2IaUF6cQHblaYbnEqrCrGDJGhC4i2SVMckxn29Y1HwRsW3M
	7SJ6fNjcuB1GeiVHNoXxJKQNltzFMbtoU6caJoZve3fjcnNtjS0baiog41RumgypAWy0dJwrDyXIM
	rVNn4FKg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vbgqw-00EXc4-A9; Fri, 02 Jan 2026 15:14:10 +0000
Date: Fri, 2 Jan 2026 07:14:05 -0800
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, rmikey@meta.com, 
	clm@fb.com, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] kexec: history: track previous kernel version
Message-ID: <dc7x5xq2ufanc5vesvs6ccvulfiddqjcf74r7pp3tr4bfiomib@akskveejglww>
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
 <20260102-kho-v2-1-1747b1a3a1d6@debian.org>
 <2b315095-2393-45d5-b0bf-ea9fbecd2607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b315095-2393-45d5-b0bf-ea9fbecd2607@gmail.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_071423_926161_C84ED9E6 
X-CRM114-Status: GOOD (  11.72  )
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

Hello Usama,

On Fri, Jan 02, 2026 at 06:02:39PM +0300, Usama Arif wrote:
> On 02/01/2026 17:53, Breno Leitao wrote:
> I think we should make this default if KHO is enabled, i.e. not have a Kconfig
> option for this. The cost of storing the char array is negligable.

Sure, I can get it enabled by default once KHO gets enabled. Thanks for
the feedback.

> > +	pr_info("This kernel was kexec'ed from kernel release: %s\n",
> > +		kho_in.previous_release);
> 
> Maybe s/release/version everywhere? It might not be a release, but no strong opinion.

As I understand, in the kernel parlance, "version" is something
different from "release", and what we want here is "release". Here is an
example of uname, which also matches with kernel source code and UTS.

  # uname --kernel-version
  #1 SMP Mon Nov 17 07:00:42 PST 2025

  # uname --kernel-release
  6.16.1-0_gc0739ee5037a

Thanks for the review,
--breno

