Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08640EB64D8
	for <kexec@archiver.kernel.org>; Fri, 16 Jun 2023 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZGmHsAKR+4aTPX/EUdKIOis/w4vAsILV71IXH/kaRe8=; b=vHZBdqAdIQ/ONp
	wrhUeAaZ3TWw4zlCUDDbZEwQHSt83xwUlrqB/MxoU99TWyckKMrgFnh7glTnCYHtp7FjiPZ8Osolb
	2BB7+0V4Jq/VP9CNXca6Ux/twrOt+/wUyXPuSB+nnGVaRZqa/jqq4mtIPFVb2meTabRVCRmF9hVz3
	NXylERXA6gAouIhb4SctOwO3dwQwQKuvkVhNFJbm69btazF7hO3L048oIqOsjPwDKV4iZzf1jBpjM
	NIKo6d9BoT4Mx/cs+iLJC+zVwmZvnTg4RRBDSniBrctoDw6h/Rmnz+MwUWgLHrYMP4Ti0T6U7oypQ
	c463u5oGrGnpE+CD85Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qACiP-001Bno-18;
	Fri, 16 Jun 2023 16:54:25 +0000
Received: from cavan.codon.org.uk ([176.126.240.207])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qACiK-001Blg-0u
	for kexec@lists.infradead.org;
	Fri, 16 Jun 2023 16:54:23 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 5E29440A72; Fri, 16 Jun 2023 17:54:15 +0100 (BST)
Date: Fri, 16 Jun 2023 17:54:15 +0100
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
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Message-ID: <20230616165415.GA28537@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
 <20230512104753.GA14461@srcf.ucam.org>
 <e7dcb85b-25bb-8d5a-3758-e4243bc6ffec@apertussolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e7dcb85b-25bb-8d5a-3758-e4243bc6ffec@apertussolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_095420_450314_7657E004 
X-CRM114-Status: GOOD (  24.77  )
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

On Fri, Jun 16, 2023 at 12:44:27PM -0400, Daniel P. Smith wrote:
> 
> On 5/12/23 06:47, Matthew Garrett wrote:
> > On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
> > > +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
> > > +built with KASLR disabled::
> > 
> > Why does Secure Launch not interoperate with KASLR?
> > 
> > Re: IOMMUs
> 
> Until the IOMMU driver comes online, memory is protected by the PMRs regions
> requested by the Preamble (pre-launch code) in accordance with Intel TXT
> specifications and configured by the ACM. The KASLR randomizer will run
> before the IOMMU driver is able to come online and ensure frames used by the
> kernel are protected as well as frames that a driver may registered in a BAR
> are not blocked.

This seems unfortunate. Presumably we're not able to modify the PMRs at 
this point? This also seems like a potential issue for IOMMU config in 
general - the presumption is that the firmware should be configuring the 
IOMMU in such a way that DMA-capable devices can't attack the firmware 
while we're in the boot environment, and if KASLR is leaving a window 
there then it seems like we'd need to fix that?
 
> > > +It is recommended that no other command line options should be set to override
> > > +the defaults above.
> > 
> > What happens if they are? Does doing so change the security posture of
> > the system? If so, will the measurements be different in a way that
> > demonstrates the system is in an insecure state?
> > 
> 
> In an early version of the patch series this was enforced when turning on
> Secure Launch, but concerns were raised over this approach and was asked to
> allow the user to be able to shoot themselves in the foot. Overriding these
> values could render either an insecure state and/or an unstable system.

If we're in an insecure state, is that something that would show up in 
the form of different measurements?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
