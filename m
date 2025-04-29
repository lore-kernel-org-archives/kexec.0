Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69062C369CB
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iGig1JI54KemODVxGfaJgsaqsZGPE/6V6CkkITKo4rQ=; b=gVmiWxpdnvDBelkipTRkmijZof
	QVNYQvhLCdw3exSSLjJKkRq1MabL/XD1s2PQMO6uJjmZVhXVR6ssspRMbOIAxeJ8Tx33ax0Cz1//F
	up+YbDqb2CZYkZcZH9ZNkiUojIK+hArvnwxkilGJov7ZMPK6vAf95yiohqG6XsGI6YSlfP2EINCmg
	vsXsjfsdPt7VOsdlwSUHdtY7D172UfzGEVLZWArHJ8hx891gHJlCjTFT/MpqPYEzASx+C2qHDyx9s
	aja1JCQdHL28Jf3DzF2D2dQ7VaFakUeKtqMET1vW8reBKKtgCoyf81PxxIfKO0OSpyPa25SBXX2dX
	yM9jVv3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9ft0-00000008qSp-22FQ;
	Tue, 29 Apr 2025 08:00:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9fsz-00000008qSf-2Eyl
	for kexec@lists.infradead.org;
	Tue, 29 Apr 2025 08:00:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3E1EF61120;
	Tue, 29 Apr 2025 07:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A301C4CEE3;
	Tue, 29 Apr 2025 08:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745913612;
	bh=5oCFwF0Xr4nHFTfMM2oRVPH/AlXCf2DmeqL2UB+IeqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uh6R5dPacY/L3/s9YwwUL2+q2rt6fZJDJ0HT1A3+AvBAVWEaxk2rWkNeYW6qoZg1f
	 u2AfIlpuPxgylzd/PejxTridyCE33nkOpw9o4vV1GHnwtluicKJSnIUUSmSra+Cb6A
	 5v1Qet43r43B3qrZOpVFYhfOtIKCnp1uPHMvEl2UZcSq9Xqe21OoeJiylb+rdbpMfq
	 dZjRpHJlPXe0oxQcvGa0KFygzYxMDZSdrPd0CpixElOYIWOlaNnLI++4+2Ei4eWEpO
	 TBxEnR66LNerk1+VmfJI2cCldVRGLuzApkoNtTUSYK9gU1SYaJi/iY0XL8XtFxba8U
	 NhEZqhp/x98xg==
Date: Tue, 29 Apr 2025 11:00:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: David Rientjes <rientjes@google.com>, Alexander Graf <graf@amazon.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Frank van der Linden <fvdl@google.com>,
	James Gowans <jgowans@amazon.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Junaid Shahid <junaids@google.com>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Pasha Tatashin <tatashin@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: Re: [Hypervisor Live Update] Notes from April 21, 2025
Message-ID: <aBCHA_ZeQpqvVo_m@kernel.org>
References: <e03d2bdb-29b2-a0ba-1b7f-1f924dc47285@google.com>
 <087a7b3b-a2d4-4596-af53-d0f850ea6aa2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087a7b3b-a2d4-4596-af53-d0f850ea6aa2@intel.com>
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

On Mon, Apr 28, 2025 at 05:35:07PM -0700, Dave Hansen wrote:
> On 4/27/25 23:20, David Rientjes wrote:
> > KHO v6 is now staged in Andrew's mm-new tree.  We discussed what it will
> > take for this series to be pushed to Linus, specifically around
> > Reviewed-by tags.  There is not a ton of x86 specific code, but it would
> > likely be useful to have Reviewed-bys from some x86 maintainers.  Dave
> > Hansen, would you be the right person to take a look at this from an x86
> > perspective?
> 
> It looks mostly OK.
> 
> The one worry is the scratch reservation sizing, how folks will get that
> right, and the implications if they get it wrong.

For engineered cloud systems folks will get it right most of the time with
explicit setting of the scrach size in the command line.
There's also a way to let kernel estimate the scratch size by scaling early
memory usage by user defined percentage (with 150% as the default).

> If it's undersized because newer kernels need more space, what ends up
> happening? Is it just an OOM during boot?

It will OOM and panic during boot, yes.
Potentially we can skip KHO if the scratch is undersized and continue to
boot without restoring any of the previous state, but to start with OOM and
panic are much simpler.

-- 
Sincerely yours,
Mike.

