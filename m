Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8957C282D0
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 07:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ae3I5hJCFWDRlnI79wVrynyU35Oa2m+ZOXf7nOvXgEM=; b=rBhddLvOdCof4j9H0DePkif0Ds
	9i1iGkPAt+1O93mYVjzkaW+JNSB0YW9kdOlk+CuOZq+XS9Twtk44PpPaPU9rTN7UhXJ3LEuwLvUDi
	JDPrqTKa7rBEDb4GpdP2Xrg9qy4ZSww9gWnU761Rlkp5ZGwUDLrHqZ7kkT6k/r1teJfRIlXruRSSQ
	Z3mlgN7Fffhhj5/gdecpsXM9LRF+mVx81F3qYKmTicjMLTgxiu94HUo0EfpADJ0XFjChD97rM+ChC
	wEYyQcabfQtJnGqVAdtrxaMg0Yjptt9E/8cFgWfsT80jJJ//FlJ6yjgCzpsqmmH+cXIL2pZCZCZ7D
	AgXXUadw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRhT-0000000DNjg-3UL6;
	Fri, 07 Mar 2025 07:00:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRhP-0000000DNiT-2AN3
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 07:00:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8BD8E5C5C09;
	Fri,  7 Mar 2025 06:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255A1C4CED1;
	Fri,  7 Mar 2025 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741330846;
	bh=LonDAILnsW0FisfkrmXT+YWTMRZbfLb6bNdSOs+YmcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJcamyGRemF0nmD8ymN/7Y76ADOIlDMzFsQvf/RbLxCFkNDBbwzLL7gwQSzQYhz/b
	 DuH0/iIzKBIk6ldssluyh22o9Bb7ULvWEeRIVSIV8wNcAjSrNCabfw1LD4fcDs/F+4
	 gP1lDV4rmDl2fxdGD8+FpVL8ZdzEVHV6qLkfZVRtTaFc7+AIR59RTTYyuEO0ia1yWV
	 n1FhoeoRAS976Ien+z3ar3FBpDMz1SZLtXbf+L1BxwI6oEbFp07NmTP5kimS/7JwUI
	 AZDvPvRvpWX2K6SPkp5ah1aDgdrGthBUgPOhCgIQeo8krlHtZZn/VJG59ONJceYdL6
	 NnLoSgYOr+vMA==
Date: Fri, 7 Mar 2025 09:00:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 09/19] x86: Secure Launch kernel early boot stub
Message-ID: <Z8qZmWhSdxCCU_Fm@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-10-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-10-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_230047_607018_C742C8E4 
X-CRM114-Status: GOOD (  13.34  )
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

On Thu, Dec 19, 2024 at 11:42:06AM -0800, Ross Philipson wrote:
> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> later AMD SKINIT) to vector to during the late launch. The symbol

Does "to vector to" translate into to jump into during late launch? :-)

Given the complicated topic in the first place I'd use as down to
earth language as I possibly could where it can be used.



> sl_stub_entry is that entry point and its offset into the kernel is
> conveyed to the launching code using the MLE (Measured Launch
> Environment) header in the structure named mle_header. The offset of the
> MLE header is set in the kernel_info. The routine sl_stub contains the
> very early late launch setup code responsible for setting up the basic
> environment to allow the normal kernel startup_32 code to proceed. It is
> also responsible for properly waking and handling the APs on Intel
> platforms. The routine sl_main which runs after entering 64b mode is
> responsible for measuring configuration and module information before
> it is used like the boot params, the kernel command line, the TXT heap,
> an external initramfs, etc.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Otherwise this is looking somewhat decent!

BR, Jarkko

