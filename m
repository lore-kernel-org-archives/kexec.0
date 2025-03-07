Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D98C19F32
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ivCwMCpUuYFHdzC0sDMElhcKvPn5C7igEBXS1CLQtK4=; b=c1arAeBxUWJU43J+MMqaYNCZoZ
	ymjPPtU7cu1rGfFep3ytYjIknCumRh0vFwdD7088LIfdZQMFNOsZszOVFvUIROHqlCbAZD8aFqe9E
	wfojbOe/SOL0/deCPNP4NZ+hD7eIcqstFg+wziIyM0igUQm8VaTMdR/RnvIMQNgO5pCg3jV9v9eMs
	8XODwoQpsyeF56S+BRyuQe3xVeLW/Zy82/kmqII90ZPkA7KQLp+XwLPv/m8UoGxiN6NzYhy40+e0G
	k1cgI3u0yLwQrPmAaxCzLrolRNMigm+euDLyU2zrBGBk6YaSxe1gA/rxMpmLVoCFicZi+hmEvnYFV
	4VWpvzOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdPJ-0000000FLoZ-2A9P;
	Fri, 07 Mar 2025 19:30:53 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdPG-0000000FLmh-2cn8
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 19:30:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 09D61A4517D;
	Fri,  7 Mar 2025 19:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F2DC4CED1;
	Fri,  7 Mar 2025 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741375849;
	bh=Mm9dkH53vQFmbsvTLUOCgmTJngIQCXH0JJidFARo+KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBHdUwuMqbFRLDoTflKN+B3coXembP6ABjnuxzjaoQgyuW4Cyav/rS7U8CckTWGfg
	 lHvXLlXLguS8WmCOy5pTEJAbs5TWKQOAkwFu0wbXyaHcIQgcCzazWZjUWt2x3m5G2y
	 1q+cpdjKTUDPxuKjK7/c828rrUMfNZ/y9sRvHQAVhABFzusm97WiuUV486m/XIZqJg
	 aRKWpaZeucqLbvfUDT3M1aA2H0PDK9XF9N1rGxl/f4IVRqTk4CwaWffBJXefXrmZ84
	 lRgM0mrIpXkbvA1h7YMjTslrtbDi5l4/abLdXxwOP10/Gf847iDF/nBwKDFIR27zsV
	 mbQMHH2ypOmHQ==
Date: Fri, 7 Mar 2025 21:30:44 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ross.philipson@oracle.com
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
Subject: Re: [PATCH v12 03/19] x86: Secure Launch Resource Table header file
Message-ID: <Z8tJZBl2Nh4RJGDS@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-4-ross.philipson@oracle.com>
 <Z8qE1B47InxE7n-v@kernel.org>
 <de143ab2-44b3-4609-a575-63c47d99ea09@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de143ab2-44b3-4609-a575-63c47d99ea09@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_113050_740767_A8DD6E7A 
X-CRM114-Status: GOOD (  14.61  )
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

On Fri, Mar 07, 2025 at 11:22:02AM -0800, ross.philipson@oracle.com wrote:
> On 3/6/25 9:32 PM, Jarkko Sakkinen wrote:
> > On Thu, Dec 19, 2024 at 11:42:00AM -0800, Ross Philipson wrote:
> > > Introduce the Secure Launch Resource Table which forms the formal
> > > interface between the pre and post launch code.
> > > 
> > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > 
> > Is this interface kernel specific or uarch specific? I'd just
> > explicitly state the context of the formal interface, that's
> > all.
> 
> It is specific to our DRTM solution (i.e. Secure Launch). It is meant to be
> extensible to accommodate future architectures that have DRTM support
> available. Not sure if I am getting at your specific question.

OK so:

1. It's software defined set of data structures with no ties to
   the hardware architecture.
2. It's essentially an API maintining backwards compatibility.

I have nothing against that definition. It is just that speaking about
formal interface between pre and post launch code does not provide
explanation on what are the constraints of the interface.

So what I was not getting was the specific definition (i.e. *the*
specific formalism under discussion).

BR, Jarkko


