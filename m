Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD77AC3DA4A
	for <kexec@archiver.kernel.org>; Fri, 16 Aug 2024 11:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=849iqZeWYKb/orKfmmLQzbvdjC7wSqi1ZqjxQu/JJs4=; b=fgKDbvNNzTU/td
	SnN0oJOen3WUk7H1yUKVoN0H/10WdfGlyXe0DUQ1SXrAr1gprvyUqnJpvypBD7yi8BIml2WrQixuu
	56jecXuUtuwQajHgNUqsw9/omSjwpRaCSDi9RHmdhftJnwLrvltH/B5mcAfP6XCw3+Yayu4Ij0Jw7
	BzPLJqSSya6AykgatHUb+l9/pvpkbo+y6ozWPYQNmdUg8fMOuGR17d/um5nNgEpi5nxHBju1DZDI9
	yvFj7TovMnUYJ4EepUGDkQs0HJm7qCgCb5VPXhGI5sXGyhXMhmD3g7TIvSuoJH98qETTsviNvd959
	fa0iD1S6Bh4Ie+sc8+Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sev24-0000000CkpK-0Cv7;
	Fri, 16 Aug 2024 11:22:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sev21-0000000CkoJ-0O1a
	for kexec@lists.infradead.org;
	Fri, 16 Aug 2024 11:22:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7960261DCF;
	Fri, 16 Aug 2024 11:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB10DC32782;
	Fri, 16 Aug 2024 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723807328;
	bh=gV2PqQerkGgy/+HK5ajdWorgprSPCXQyQAoB8oo88rk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Jveqprc1i1LHYV6qtBL08bsdgzXefjlh1drYspRjo3Pc7kIhjw730W/Iilznig37j
	 sq74l0Xoy31GXwIYvl7EKsDZAUsuczbJnDgPgKwDIhvExKHkFhvimJz5DX8cVHjHOn
	 u8WZojYei71O8DMGl0XY1Rx8fcPCZkZxSnURmusIwH2MP4BxFZrJuvT3wwmoIcnwE0
	 5HLzLypWYmiiTzxn02IS63nfb2IJCzOx/tyCeqBQFHcwTgUCt2N62+tqZKdTn/4t/q
	 XA0ADrVDyHSsZuS8Mskt+KlNGNbfliJV3QAz3l/mfwjyjpULNA6rRhMtBak9LNwx/1
	 DTzeAYYEHOMoQ==
Mime-Version: 1.0
Date: Fri, 16 Aug 2024 14:22:04 +0300
Message-Id: <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Andrew Cooper" <andrew.cooper3@citrix.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, "Eric Biggers"
 <ebiggers@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
In-Reply-To: <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_042209_366158_B37C7E60 
X-CRM114-Status: GOOD (  19.90  )
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

On Fri Aug 16, 2024 at 2:01 PM EEST, Andrew Cooper wrote:
> On 15/08/2024 8:10 pm, Thomas Gleixner wrote:
> > On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
> >> On 5/31/24 09:54, Eric W. Biederman wrote:
> >>> Eric Biggers <ebiggers@kernel.org> writes:
> >>>> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
> >>>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
> >>>> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
> >>>> but why would you not at least *prefer* SHA-256?
> >>> Yes.  Please prefer to use SHA-256.
> >>>
> >>> Have you considered implementing I think it is SHA1-DC (as git has) that
> >>> is compatible with SHA1 but blocks the known class of attacks where
> >>> sha1 is actively broken at this point?
> >> We are using the kernel's implementation, addressing what the kernel 
> >> provides is beyond our efforts. Perhaps someone who is interested in 
> >> improving the kernel's SHA1 could submit a patch implementing/replacing 
> >> it with SHA1-DC, as I am sure the maintainers would welcome the help.
> > Well, someone who is interested to get his "secure" code merged should
> > have a vested interested to have a non-broken SHA1 implementation if
> > there is a sensible requirement to use SHA1 in that new "secure" code,
> > no?
>
> No.
>
> The use of SHA-1 is necessary even on modern systems to avoid a
> vulnerability.
>
> It is the platform, not Linux, which decides which TPM PCR banks are active.
>
> Linux *must* have an algorithm for every active bank (which is the
> platform's choice), even if the single thing it intends to do is cap the
> bank and use better ones.

For (any) non-legacy features we can choose, which choices we choose to
support, and which we do not. This is not an oppositive view just saying
how it is, and platforms set of choices is not a selling argument.

>
> Capping a bank requires updating the TPM Log without corrupting it,
> which requires a hash calculation of the correct type for the bank.
>
> ~Andrew

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
