Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8913C001B0
	for <kexec@archiver.kernel.org>; Tue, 15 Aug 2023 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YnnKXmoTNFWPkXPmjCb3FxBxNfottXNs0yB5B6l83fQ=; b=KlOS1vN6iuBCNh
	DfFvRAwvieCMGp9/zRvMpg4fOS+RVZKE12tyYPcBJlIt7707OnKe+/i+ZrCrpepgfYW9AMFREQ+WC
	4ujoAhc21LrJJdApd1Ps74vz9RVtKh+cmgVHcebsaQ4dGny6Wnqs/MEUMrAKNbM3oQznXT3ceb6j6
	s/Sm+pbqSsKwxW4YhbowpMCXBwU2WBp25T1DF3VNkaZjnGAfQ48efdUu6z0CJIztrDggWBJ03KwQO
	eLWWVMcs06CPFvhdDSFFLceqUfhFcOowqeZhE2Qcnv4RQOJtYDUS5dAu4LFtrbb8Ey5wGUfCv+vml
	ZsupXCiuW8YZwr11b1fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVrT5-001J7d-2Q;
	Tue, 15 Aug 2023 10:40:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVrT2-001J6e-1E
	for kexec@lists.infradead.org;
	Tue, 15 Aug 2023 10:40:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9C64265498;
	Tue, 15 Aug 2023 10:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1DEC433C7;
	Tue, 15 Aug 2023 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692096000;
	bh=LpDuDmXwtvKKiIAQ3I9sznNgGjycDIKymnYyZz1F9Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGRam2aMHip6R8asnMjxFw+qs1Xa0zprS3nWIuPIuRQDCcM0SxCNYykmBgWtZvpEO
	 wg1bFZsjsAtGh6N+Jtk6LQh9ROztOAUAaBSgoF/Oy8sFzZub6SHIJerudPMwxJrxjT
	 Ef7smVOji2ktmHivCX65DaLFRxTENch3NIKkWWzO/2jtSTelT3GslAc+6QDknNI0ct
	 B0nOlJTY+o5nvb7bow6zphfZhgb8xXNVS4d9x2MgSnOVxj1wjaZ3MyLKpwCBt2iur7
	 SBerkMTDX85h2C60hrl4msdN8EQqhKAUN3j6OjizOv8kIMyaf34vtO4dRadehQ92xQ
	 mGUhFfJg4+Y1g==
Date: Tue, 15 Aug 2023 12:39:56 +0200
From: Simon Horman <horms@kernel.org>
To: Coiby Xu <coxu@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, kexec@lists.infradead.org
Subject: Re: [ANNOUNCE] kexec-tools v2.0.27 preparation
Message-ID: <ZNtV/P4fPCrMevQZ@vergenet.net>
References: <ZNXjs19UOvGEl/5K@vergenet.net>
 <d92decbb-768c-27e7-8c0b-eea662a86670@linux.ibm.com>
 <ymdn754ihzovgpgoikjnpwueqx6zzmgcempvlr6bsn5rx3mwrw@62dmgvygv4eo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ymdn754ihzovgpgoikjnpwueqx6zzmgcempvlr6bsn5rx3mwrw@62dmgvygv4eo>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_034004_464329_13D47D42 
X-CRM114-Status: GOOD (  16.62  )
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

On Mon, Aug 14, 2023 at 11:19:07AM +0800, Coiby Xu wrote:
> Hi Sourabh,
> 
> On Mon, Aug 14, 2023 at 08:17:34AM +0530, Sourabh Jain wrote:
> > Hello Simon,
> > 
> > Can we include below fix?
> > https://lists.fedoraproject.org/archives/list/kexec@lists.fedoraproject.org/thread/O3W4SLVVFT6J25U5YSXNZ3URZ4QY6SRU/
> 
> I'll review your patch! Note the patch is against Fedora's kexec-tools
> so it doesn't apply to this upstream kexec-tools. The relationship
> between Fedora's kexec-tools and this upstream kexec-tools can be
> described as follows,
> 1. Fedora's kexec-tools packages the kexec binary which is provides by upstream
> kexec-tools; 2. The kexec binary is used for loading the kdump kernel and
> initrd but
> it's not responsible for building the kdump initrd. Fedora's kexec-tools
> is used to build the kdump initrd instead.
> 
> Currrently it's WIP to split current Fedora kexec-tools into
> kexec-tools, kdump-utils, makedumpfile and eppic. Hopefully after it's
> done, you and other uses will no longer be confused by the relationship
> between Fedora's kexec-tools and this upstream kexec-tools.

Thanks for the clarification, I'm assuming no action is needed on my part
at this time. Let me know if I am mistaken.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
