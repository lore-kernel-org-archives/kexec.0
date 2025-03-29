Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8885C36011
	for <kexec@archiver.kernel.org>; Sat, 29 Mar 2025 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6P4YsRY1ch0agTiF7wOMTlqE3R3gg3J7QhzPCqtS0Lk=; b=DM2gKki0g/7QIBTGZ2O3ePfUB3
	YnlieNxhdtd5CGCFf5bTsWrh6Ga5KukeG/z1sqJIT66db3EKz82WNsKmq06H8acLaJ7O81Wq7cZ5j
	X9h/6iUBt7SwEVD5ZXPknEfbtj7GGlYZ7gLBY1mdqzuiW4U5mfX3R66o+08FV1xmBzVcwJ2h4J231
	J/PBEphjIJV0G3wbxIl1ICkKExd5He8qgbC3pUVMmRQ58saZW8q+XIrIhfR/Ewtl8ga2xEO8cy7XK
	VirYPgKuKXGFGoEIZXIEhus6E65AAXPPiv09PRfpOoUkNfK6J1xFA67pnts9/AqLArMHUgA0KNj8K
	1Ia/ocFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyUQI-0000000F4yQ-2uq3;
	Sat, 29 Mar 2025 11:32:22 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyUQG-0000000F4x3-1Dhm
	for kexec@lists.infradead.org;
	Sat, 29 Mar 2025 11:32:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ECF86A40F2F;
	Sat, 29 Mar 2025 11:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA013C4CEE2;
	Sat, 29 Mar 2025 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743247938;
	bh=9RzsQ0E7jdjbegvxUHbO7Zp0Kd0W8S0YBOdd9DVrMNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6G6IxKLKe9hJQRP5obm7C+Bsx6BjbjFbTN9ToLSW109SDDApPb39G5lt813QpmWy
	 mXGhYzBds4KV7JLlx1K4yg7gfzUkypFskWjvIAR/pg+65EqDEcHa2Zudc9FvGvDl+n
	 VapJdc3R+A4ZvWi9mdujrbAIWypcR6QH04SAszPTh8Qwnh08Z0YFUyWdp9rZHR+QFK
	 56/hgrPY0KF64o4KS/oV532kWBSClS0FI9mSWMQwh27o4YP7EaejfEsCfv8z3E67W/
	 lmCsLCu/fNFubXa8xUHT4OG0VeUtA69O0k3XeDvUGvZLvx24q3fNRl0z6SxEzMs2Aw
	 p47ZlCf1+qJcg==
Date: Sat, 29 Mar 2025 13:32:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v13 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
Message-ID: <Z-faPSIlZV91j_Z0@kernel.org>
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328230814.2210230-1-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250329_043220_467157_7DD72D6E 
X-CRM114-Status: GOOD (  19.93  )
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

On Fri, Mar 28, 2025 at 04:07:55PM -0700, Ross Philipson wrote:
> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity in a unified manner. The first area of
> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> Trust for Measurement). The project has been and continues to work on providing
> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
> cross-architecture (x86 and Arm), with our recent involvment in the upcoming
> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
> follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
> Technology (TXT) is present today and only requires a preamble loader, e.g. a
> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
> been present since the introduction of AMD-V but requires an additional
> component that is AMD specific and referred to in the specification as the
> Secure Loader, which the TrenchBoot project has an active prototype in
> development. Finally Arm's implementation is in specification development stage
> and the project is looking to support it when it becomes available.
> 
> This patchset provides detailed documentation of DRTM, the approach used for
> adding the capbility, and relevant API/ABI documentation. In addition to the
> documentation the patch set introduces Intel TXT support as the first platform
> for Linux Secure Launch.
> 
> A quick note on terminology. The larger open source project itself is called
> TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
> the use of Dynamic Launch technology is referred to as "Secure Launch" within
> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
> in the code. The stub code discussed above is referred to as the SL stub.

I did a quick recap of TPM patches and still looks good as far as I'm
concerned. Not actively reviewing these anymore but I'll do a sanity
check per patch set version.

BR, Jarkko

