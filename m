Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A443C3DA4A
	for <kexec@archiver.kernel.org>; Fri, 16 Aug 2024 10:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iWBjHJ1BON0X0Gvf4pben5xhyMXV+VqswkkzGq4TOqg=; b=AU0molIJ7e7Gu+
	NFPT/OqfpvNG7YMmRyxHgu+vP/2Bv/H2rrxYUmPXCtZL8DL6WcfGo+nJmmAa8mCOiP/GseYiaHrTT
	RugoGr2b9Xja5J0vBjwVe/bVceAtUu2EZUGJzIBN7HKTcbDQo513UHN0tpXYWQOQHm+Mk8TR0ZCaW
	OUo8IEQJMzw1aHXse4l6OSFOXh4LMHALvI91o05qzG820/GQU/Q+4paIALyfsQLlfd1XIbkUqqwf5
	M7r7fpfMSGQQAKL/I86cRvZ/QbFz5tNjSZglxyn7n5d/6p+4CkREoGalbfBmfs4YuauiBfVQs6Dbh
	xwJbLEO6h5lesbYRXy4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seuPW-0000000CcFg-2KLm;
	Fri, 16 Aug 2024 10:42:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seuPR-0000000CcEZ-384E
	for kexec@lists.infradead.org;
	Fri, 16 Aug 2024 10:42:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ECAD461DCF;
	Fri, 16 Aug 2024 10:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C679C32782;
	Fri, 16 Aug 2024 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723804936;
	bh=zg3dRit0opyHfuuTVglW5AtRP4DAPWyWCTz/Rq9Op8U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NB193JTXK3JRQ7RSKkOV16g8BU8FoDpFZ9LrZZP3Mr/3BsNpE4kWT2iUeatduZZUe
	 42iqfmX+LeVxQUsdm8vSGspHkZbszI5FZ3EPXdHy9uQPwn8HkZlPSmKdcwx8DF+wtm
	 nFt0M7aq8L1mzCPQPuZUhVBGGOjDBOkbMum9ikJr/AVq3DkDb/koO8d8n6IgkN9f59
	 BexA35uQhGZv4ph6LKZoSbT0wspZgo7Ff6avGvl0r8QC8Apl3M1iwrQYf4L1yhr7W4
	 bYYTtbhcN8kgzIAFe1rQAe/rM0UYJS0HEr2bRTvySuQwtTKcLGMqksaTknDYo3S8qi
	 6uwqFaJIb34bw==
Mime-Version: 1.0
Date: Fri, 16 Aug 2024 13:42:13 +0300
Message-Id: <D3H9ULV1NH4M.1A8EKXWZFTEF2@kernel.org>
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
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
In-Reply-To: <87ttflli09.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_034217_896304_A09D6E97 
X-CRM114-Status: GOOD (  20.17  )
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

On Thu Aug 15, 2024 at 10:10 PM EEST, Thomas Gleixner wrote:
> On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
> > On 5/31/24 09:54, Eric W. Biederman wrote:
> >> Eric Biggers <ebiggers@kernel.org> writes:
> >>> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
> >>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
> >>> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
> >>> but why would you not at least *prefer* SHA-256?
> >> 
> >> Yes.  Please prefer to use SHA-256.
> >> 
> >> Have you considered implementing I think it is SHA1-DC (as git has) that
> >> is compatible with SHA1 but blocks the known class of attacks where
> >> sha1 is actively broken at this point?
> >
> > We are using the kernel's implementation, addressing what the kernel 
> > provides is beyond our efforts. Perhaps someone who is interested in 
> > improving the kernel's SHA1 could submit a patch implementing/replacing 
> > it with SHA1-DC, as I am sure the maintainers would welcome the help.

Git also has a bit more wide than secure launch, and the timeline is
also completely different. Git maintains legacy, while has also
introduced SHA-256 support in 2018. This as a new feature in the kernel
stack.

The purpose of SHA1-DC has obviously been to extend the lifespan, not
fix SHA-1.

Linux will be better of not adding anything new related to SHA-1 or
TPM 1.2. They still have a maintenance cost and I think that time
would be better spent of for almost anything else (starting from
taking your trashes out or boiling coffee) ;-)

>
> Well, someone who is interested to get his "secure" code merged should
> have a vested interested to have a non-broken SHA1 implementation if
> there is a sensible requirement to use SHA1 in that new "secure" code,
> no?
>
> Just for the record. The related maintainers can rightfully decide to
> reject known broken "secure" code on a purely technical argument.
>
> Thanks,
>
>         tglx

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
