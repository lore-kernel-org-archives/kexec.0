Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF20EB64D7
	for <kexec@archiver.kernel.org>; Fri, 16 Jun 2023 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ekua2TJ7GbAanciO5nCsaN5eOtmwWb35m6PMBD+5pcc=; b=x8tB5axzz15A6A
	eVVT+f8kM3npEq3ZrM5MLN4jlHYDC9uT2+8nDGPmFDQe2fZvSmLBdsaHFFsQf4iA5yxuvMtyvMeKW
	mPFdgJLBnNmY5U/zPfped9x2xU2N89QnjM0fXx0FluPosyEitMOUc9+DsnijTSMDZeljD14ugLDaB
	CcIcPGIzt2trVo65I5j+EhTqirJz+xVbRPVpbhh4J7ADL6kRfSOzTZgYzKVKlbNXxTo6yc9B3RGoO
	eX0cFWoWSeMO4Mh+22p6vYtg3HB8YUBG4uNauiEh97soPXR86AWBuV79QSjrm3LtmNnLhqAoSn/ID
	KDsjtImSqmXJifGE8cOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAFqq-001l3Q-15;
	Fri, 16 Jun 2023 20:15:20 +0000
Received: from cavan.codon.org.uk ([176.126.240.207])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAFqm-001l1m-0D
	for kexec@lists.infradead.org;
	Fri, 16 Jun 2023 20:15:18 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 74F3540A72; Fri, 16 Jun 2023 21:15:13 +0100 (BST)
Date: Fri, 16 Jun 2023 21:15:13 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	ardb@kernel.org, James.Bottomley@hansenpartnership.com,
	luto@amacapital.net, nivedita@alum.mit.edu,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Message-ID: <20230616201513.GA30963@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
 <20230512105554.GB14461@srcf.ucam.org>
 <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
 <20230515212206.GA2162@srcf.ucam.org>
 <df9d1260-41dd-034b-9dc6-14173c6c0d25@apertussolutions.com>
 <20230516014310.GA5403@srcf.ucam.org>
 <eda6da3a-00fe-21c5-5a3d-3e06d21179f4@apertussolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eda6da3a-00fe-21c5-5a3d-3e06d21179f4@apertussolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_131516_230372_4B3B090B 
X-CRM114-Status: GOOD (  25.65  )
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

On Fri, Jun 16, 2023 at 04:01:09PM -0400, Daniel P. Smith wrote:
> On 5/15/23 21:43, Matthew Garrett wrote:
> > On Mon, May 15, 2023 at 08:41:00PM -0400, Daniel P. Smith wrote:
> > > On 5/15/23 17:22, Matthew Garrett wrote:
> > > > What if I don't use grub, but use something that behaves equivalently?
> > > > Which value should be used here?
> > > 
> > > Generally we would request that the bootloader submit a request to register
> > > for a value to be reserved in the spec. That aside, the intent here is to
> > > allow for the possibility for the DLE handler to be independent from the
> > > bootloader, but this does not have to be this way. If a non-open entity
> > > decides to produce their own implementation, they can freely use a
> > > unallocated value at their own risk that it could be allocated to another
> > > bootloader in the future. Though in this scenario it likely would not matter
> > > as the non-open DLE handler would only be present when the non-open
> > > bootloader was present.
> > 
> > Is the expectation that the DLE will always be shipped with the
> > bootloader? I think I'm not entirely clear on what's consuming this and
> > why.
> > 
> 
> No, in fact, an early idea proposed by a pair of us in the TrenchBoot
> community was to have it live either as a Runtime Service that was loaded by
> a UEFI app or in the coreboot UEFI payload.

Ok, then I think I'm still confused. If I want to write a new bootloader 
but make use of the existing DLE, what contract am I establishing and 
what value should I be putting in here?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
