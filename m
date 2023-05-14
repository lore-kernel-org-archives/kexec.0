Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE3AC77B7F
	for <kexec@archiver.kernel.org>; Sun, 14 May 2023 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aj4kU2WPrwjOYqAoB2IpW/0mr1/CIuobRP8WhB20wpk=; b=EUjmaC2JalMv4r
	8pwcXGaRQ6tal/MgNzxBOJpzLJyl7+is6Wj5osE1CN8oMYVz9R/w9WEl3MDdbGnjJJyyvTmOZq+nr
	exNcTlLHUTr6hpyzbOHvMVLEOPoov9fNLas4QjtXsXx0CE4m+rzIc4DYSdlpuUJbzDnXma7nz9npF
	Yufp8+L7XrpzbKVNBBaPMRnYLBsNpZAvyujIh0F2dO/zBZQRtATEARujwKfqUXSUYivdprsi6207a
	jPPcJM3PksiLzSD4KkgVjdrEErJkzdf7hqC2/jEiMFdGCy/CtVJyrC+PIYpvmhDNO8PUatqzuudVn
	vjQ4mGby6Th1JvpQImDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyH8W-000640-33;
	Sun, 14 May 2023 19:12:04 +0000
Received: from cavan.codon.org.uk ([176.126.240.207])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyH8R-00063O-1E
	for kexec@lists.infradead.org;
	Sun, 14 May 2023 19:12:03 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 9869140A84; Sun, 14 May 2023 20:11:50 +0100 (BST)
Date: Sun, 14 May 2023 20:11:50 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, James.Bottomley@hansenpartnership.com,
	luto@amacapital.net, nivedita@alum.mit.edu,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20230514191150.GA17168@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
 <CAMj1kXFUDUbH4avVs37uLkS=BfSFB1F60e5Ei5_m2aWxOYOGPw@mail.gmail.com>
 <4acf414e-67e7-c964-566b-a5e657e9d1bb@citrix.com>
 <20230514181817.GA9528@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230514181817.GA9528@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230514_121159_571848_7C033D16 
X-CRM114-Status: GOOD (  16.16  )
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

On Sun, May 14, 2023 at 11:18:17AM -0700, Eric Biggers wrote:
> On Fri, May 12, 2023 at 01:24:22PM +0100, Andrew Cooper wrote:
> > You're suggesting that because Linux has been slow to take D-RTM over
> > the past decade, you're going to intentionally break people with older
> > hardware just because you don't feel like using an older algorithm?
> > 
> > That's about the worst possible reason to not take support.
> > 
> > There really are people in the world with older TPM 1.2 systems where
> > this D-RTM using SHA1 only is an improvement over using the incumbent tboot.
> > 
> > ~Andrew
> 
> This patchset is proposing a new kernel feature.  So by definition, there are no
> existing users of it that can be broken.

The patchset reimplements a more extensible version of an existing 
feature which people already consume, and presumably people will be 
encouraged to transition to it. There is plenty of hardware that 
supports this feature that only implements SHA-1. If you want to propose 
that the kernel not implement any functionality that uses deprecated 
hash algorithms then that seems like a larger conversation rather than 
one that should focus on a single pachset.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
