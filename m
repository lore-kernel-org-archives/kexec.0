Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6146C77B7F
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6vzUOTgk0e9GQQsjpS+7oozwv6ur4w72Qy6HY9BG5TE=; b=C1HuIu0QWHGh+c
	2o7b8g31cSYbXLU/8q9M2bYuj5cMtfq41pzhSAFUyklZcQvu5TXdEJMvwy6jD3hPgb2wbLT0I21Xy
	AWOlU1zvFkubm6hr6/MPnn/mDPry6R++ieoNhr/E8cwOv70AcjOC1kYV+T84HYyXs5OuKaoScyw2/
	9+UvF8Rgr8SGKisjnIpRUw7SHRu/et2H/EomgWTaKOR6lc+Ak25culsNYVpBn2S0YYoB/QbSKx50z
	w1UIF8YWNeGvR2HVYhn0PPnU5QQ023444uC+qNvocwYwMRlVMttxm0O53WHy0XOrV5oFd61Dzk2Ep
	Ch0AaIu2V3HumG8cb+9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQx9-00BpAI-2F;
	Fri, 12 May 2023 11:28:51 +0000
Received: from irc.codon.org.uk ([2a00:1098:84:22e::2] helo=cavan.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQx6-00Bp9P-2q
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 11:28:50 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 68D0D40A6F; Fri, 12 May 2023 12:28:47 +0100 (BST)
Date: Fri, 12 May 2023 12:28:47 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <20230512112847.GF14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_042849_047024_79ED9B11 
X-CRM114-Status: GOOD (  16.76  )
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

On Fri, May 12, 2023 at 01:18:45PM +0200, Ard Biesheuvel wrote:
> On Fri, 12 May 2023 at 13:04, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >
> > On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:
> >
> > > SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> > > now?
> >
> > TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also
> > at the whim of the firmware in terms of whether the SHA-2 banks are
> > enabled. But even if the SHA-2 banks are enabled, if you suddenly stop
> > extending the SHA-1 banks, a malicious actor can later turn up and
> > extend whatever they want into them and present a SHA-1-only
> > attestation. Ideally whatever is handling that attestation should know
> > whether or not to expect an attestation with SHA-2, but the easiest way
> > to maintain security is to always extend all banks.
> >
> 
> Wouldn't it make more sense to measure some terminating event into the
> SHA-1 banks instead?

Unless we assert that SHA-1 events are unsupported, it seems a bit odd 
to force a policy on people who have both banks enabled. People with 
mixed fleets are potentially going to be dealing with SHA-1 measurements 
for a while yet, and while there's obviously a security benefit in using 
SHA-2 instead it'd be irritating to have to maintain two attestation 
policies.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
