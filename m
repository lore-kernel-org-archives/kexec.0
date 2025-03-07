Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50677C19F32
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 07:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xl3Bkss25PUY54rHOYqsRkz77bSckvoxfPXZPQfuFK0=; b=EUWlrLCAREz4KtAMzJd4wRX8um
	veowQyEl3QhkyW0iWIb2mGZ5DukOWMq23IJkQaeEnnhCJcStJppBwqbglU2FvViRvaqKSWBb+E6OD
	H9w9EHdNhwB3jZwTUrO8kFfVtUwro0MEm4ij3ULuQsXVRyf4Ue9+GR62Ik3jWrw2dUl/4I+spXsK+
	9E7cllCa/vVjCtYy8v81zPOqtr9tCmrPXRhBHugzawSdz1KyMXbDUzEeHn2ZsFJm21qU2TeZU4rAz
	o6YLi9gnEMMv+iCr7PHNGjhYvuDbeCaK+MUPiuc+Fst1VapTHN3uPcBk8bAwj1vgTGA7xeX+AG8t8
	gH4nC4Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRjP-0000000DO3z-05Gp;
	Fri, 07 Mar 2025 07:02:51 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRjL-0000000DO2X-3G4M
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 07:02:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 32A17A45523;
	Fri,  7 Mar 2025 06:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA20DC4CED1;
	Fri,  7 Mar 2025 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741330966;
	bh=s0Xv8Pqr7o4l7Qibu9DKl61p8Xb8wiCce4s4Bg4r9FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPSDzGD7e91W0D6L4Tgfev4YR5SWUrgerBvMAn7tOupWyz2kAf4MCvmp56Xh9hzQV
	 1pLDmmHhaU46Gq9bCNhUmmkDcyygILzhV6njDp51w2eziuPgLWl9WlYVyUEGpHeiH4
	 73e3/h5x2ME8DQz1wGETGpTu3kc2+e0jozf26h2uE7aMbYiXKZig5fQRJr4xuR9uM9
	 SnkoqolMUxLyyH++9gxmNZNmns/AIZjzSNq37GElrC4eWYTXfFTBrK9/Buh33gvQET
	 e+z7BZWeRUtFVTPYQEeiTxSgSt9QbQuPNUaDIcnEoqxyDE+oF29T9Haya1UerubN0w
	 O5T6knCM5r4Ww==
Date: Fri, 7 Mar 2025 09:02:41 +0200
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
Subject: Re: [PATCH v12 10/19] x86: Secure Launch kernel late boot stub
Message-ID: <Z8qaEdBD8wZLo-yb@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-11-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-11-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_230247_891204_FA0D9BF0 
X-CRM114-Status: UNSURE (   8.00  )
X-CRM114-Notice: Please train this message.
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

On Thu, Dec 19, 2024 at 11:42:07AM -0800, Ross Philipson wrote:
> The routine slaunch_setup is called out of the x86 specific setup_arch()
> routine during early kernel boot. After determining what platform is
> present, various operations specific to that platform occur. This
> includes finalizing setting for the platform late launch and verifying
> that memory protections are in place.
> 
> Intel VT-d/IOMMU hardware provides special registers called Protected
> Memory Regions (PMRs) that allow all memory to be protected from
> DMA during a TXT DRTM launch. This coverage is validated during the

Hair cutting again. Check through patch set:

1. D-RTM
2. DRTM

Pick one and use it consistently. Small details like this in the end
make the overall thing less exhausting to read.


BR, Jarkko

