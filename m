Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FF0C77B75
	for <kexec@archiver.kernel.org>; Mon, 15 May 2023 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nVwIEhmSpZnN/m5Ub2OWqJB2pxaKmgzkO2z8O4etBiM=; b=GD4jmCBxX3BBG5
	hiJH8uYzYX9fSS3drTzKSQN5u221tDaJEDUA+jHiditYAmh4g8hJPVjiLsagbpHyKb0hY36AvAwjs
	RUZya6A4CKa2pbUlWEnD0QgIY1tlPSJsi+eHJPtBXKeuSqAw7NwifJIS/FlI0/uOFIku0JbrXPMzo
	5jhhFC556FiLBBGh4eJlmf68vMZR2Zsq3xLFvZA8u4dz4muDfr2VBNMafQj91J5PLAhpGdVWRzsVa
	i1fWoSAgD8fU89kTUuKAhrOpdsgbqwg7vfFlsrwMmM9LdQpBJpvgBMHPoD7h5VejdXYG7eRmy9KAg
	+VY/8NZKaTndoT/KzdJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyfe5-003XLu-2P;
	Mon, 15 May 2023 21:22:17 +0000
Received: from irc.codon.org.uk ([2a00:1098:84:22e::2] helo=cavan.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyfe0-003XKf-2b
	for kexec@lists.infradead.org;
	Mon, 15 May 2023 21:22:16 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id AA4624252A; Mon, 15 May 2023 22:22:06 +0100 (BST)
Date: Mon, 15 May 2023 22:22:06 +0100
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
Message-ID: <20230515212206.GA2162@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
 <20230512105554.GB14461@srcf.ucam.org>
 <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_142212_997483_3A1F0C98 
X-CRM114-Status: GOOD (  23.64  )
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

On Mon, May 15, 2023 at 05:15:15PM -0400, Daniel P. Smith wrote:
> On 5/12/23 06:55, Matthew Garrett wrote:
> > On Thu, May 04, 2023 at 02:50:13PM +0000, Ross Philipson wrote:
> > 
> > > +#define SLR_TABLE_MAGIC		0x4452544d
> > 
> >  From convention I'd expect this to be 0x534c5254, but not really an
> > issue.
> 
> Apologies, but which convention?

Tables in ACPI and UEFI tend to have magic that corresponds to their 
name, so a table called SLRT would tend to have magic that matches the 
ASCII values for that. In this case the SLRT has DRTM as its magic, 
which is a touch unexpected.

> > Oof. Having the kernel know about bootloaders has not worked out super
> > well for us in the past. If someone writes a new bootloader, are they
> > unable to Secure Launch any existing kernels? The pragmatic thing for
> > them to do would be to just pretend they're grub, which kind of defeats
> > the point of having this definition...
> 
> Actually, this is not for making the kernel know about bootloaders. This is
> dealing with the challenge created when the preamble was split for efi-stub,
> and similar use cases, where what sets up the preamble, ie. the bootloader,
> is separate from what invokes the dynamic launch, ie. the DLE handler. The
> reality is that even in the simplest implementation of the DLE handler, a
> remnant of GRUB for call back from efi-stub, there is information that is
> needed to cross the gap.

What if I don't use grub, but use something that behaves equivalently? 
Which value should be used here?

> We wrote the TrenchBoot Secure Launch general spec [1] with as much
> forethought as possible for the target environments. Specifically, the
> desire is to have a common approach for x86 (Intel and AMD), Arm, and
> perhaps down the road the POWER arch. In particular, I do not believe there
> is anything in the Arm DRTM beta spec that prohibits a mixed 32/64 bit
> environment. In the end it is better to for the spec to be safe for those
> environments then having to make changes to the spec later down the road.

Ok.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
