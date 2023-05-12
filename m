Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953DAC77B75
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9zSvb6vzPUg++/NGMJc79HoVruxfgS+Jk62s7vzgbgM=; b=bLLsHSOGu0Tfw1
	tT/P6V/SqDZ47Yyohjh8bpLgLBa+Lm7v7AAAenRwZdLSS19+lXcGd80+fk8HLijp2bAdWiu/c7+Zo
	/LN2g9NfeDXaTznHqApL2peQABNpEzrjvLJHE5jv/JSOwajGcG6czNv1s0G6RKShpxzAJL5NWezqf
	3hPA2jlfA5fduA1T3KTgQRBrWeSjK93trhYquW0J+FTm8+Ion7wLFZZPXTH58RwQnI1ZoOmp4IEdS
	BhO/coeGW38q7IvdZN+g55H81i38cv434fmz8IJCTL8rb2XQ3DApHSL9DuFT+27wtz6kOglQ81map
	jsWlM4GPeORttIPELAzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxYBc-00CmWa-27;
	Fri, 12 May 2023 19:12:16 +0000
Received: from irc.codon.org.uk ([2a00:1098:84:22e::2] helo=cavan.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxYBX-00CmUn-0q
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 19:12:14 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id C748140A6F; Fri, 12 May 2023 20:12:03 +0100 (BST)
Date: Fri, 12 May 2023 20:12:03 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
	hpa@zytor.com, James.Bottomley@hansenpartnership.com,
	luto@amacapital.net, nivedita@alum.mit.edu,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20230512191203.GA21013@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
 <87pm75bs3v.ffs@tglx>
 <20230512161318.GA18400@srcf.ucam.org>
 <873541bej2.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <873541bej2.ffs@tglx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_121211_426550_49B776E5 
X-CRM114-Status: GOOD (  21.47  )
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

On Fri, May 12, 2023 at 08:17:21PM +0200, Thomas Gleixner wrote:
> On Fri, May 12 2023 at 17:13, Matthew Garrett wrote:
> > On Fri, May 12, 2023 at 03:24:04PM +0200, Thomas Gleixner wrote:
> >> On Fri, May 12 2023 at 12:28, Matthew Garrett wrote:
> >> > Unless we assert that SHA-1 events are unsupported, it seems a bit odd 
> >> > to force a policy on people who have both banks enabled. People with 
> >> > mixed fleets are potentially going to be dealing with SHA-1 measurements 
> >> > for a while yet, and while there's obviously a security benefit in using 
> >> > SHA-2 instead it'd be irritating to have to maintain two attestation 
> >> > policies.
> >> 
> >> Why?
> >> 
> >> If you have a mixed fleet then it's not too much asked to provide two
> >> data sets. On a TPM2 system you can enforce SHA-2 and only fallback to
> >> SHA-1 on TPM 1.2 hardware. No?
> >
> > No, beause having TPM2 hardware doesn't guarantee that your firmware 
> > enables SHA-2 (which also means this is something that could change with 
> > firmware updates, which means that refusing to support SHA-1 if the 
> > SHA-2 banks are enabled could result in an entirely different policy 
> > being required (and plausibly one that isn't implemented in their 
> > existing tooling)
> 
> It's not rocket science to have both variants supported in tooling,
> really.

People who are currently using tboot are only getting SHA-1, so there's 
no obvious reason for them to have added support yet. *My* tooling all 
supports SHA-2 so I'm completely fine here, but either we refuse to 
support a bunch of hardware or we have to support SHA-1 anyway, and if 
we have to support it the only reason not to implement it even in the 
"SHA-2 is supported" case is because we have opinions about how other 
people implement their security.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
