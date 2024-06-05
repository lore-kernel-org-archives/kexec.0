Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B8EC25B76
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 04:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TXXMNkzLWYg26Uu0eadE85xhVgJ8CuIeLVeqJqZsvgo=; b=PtJ73Dp/wGPcY/
	QpSJeP0ZEd5QFTmzAiAT1yBxF1E9GtJiW2WWIHaw1CWo+SbKhmmNH8uK8KKHCOU6+2VOYYFr155+o
	cov41S4zfq+LLVCz09bztvcJTuC+SFCJx7KQ6YnuIfhWZ2o0ZEjEw2/luVUZyl20g5nYYm0ML+TnV
	DOsHZ+APE/v/ADy01tNYKRYODei2eaxrJtqIXeibGG2XS/KIoIzKTmwTFArWaXrREkK/5CbmbnSJc
	YDLppofIba+jG5Imwy0Ebkote1x/XN+YVnHhHdqNtk5wFxmRUWLRuFaKBC4xP4ZaztiAE2SdJEcNG
	W8YTJvNKUNFltBKnKB0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEhtU-00000004ZwQ-3g9D;
	Wed, 05 Jun 2024 04:05:00 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEhtQ-00000004Zua-2Bkb
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 04:04:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D5723CE138F;
	Wed,  5 Jun 2024 04:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DB9C32781;
	Wed,  5 Jun 2024 04:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717560291;
	bh=D7YS8tUT6zoxR7+gztQhZtUYQS3g8Jha1gq4gWlWSOY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=OLHBjXbjh6nagm8wzjsU74vNbjvZwzzPO+E00JnpPO6Tulhx7zlyZpBPqdWd6WPF1
	 0o02okbEIMvrN84g7B34RhAKA3TzXOzc9L4I4qoFW3GE5yp8iV3D161WZL+TKfivxp
	 KDrad0HF7ReV0kat6LU5tGwJfNFBlYhDTbQ1hupt6j2nlLT061/WeQYPx4hHMJfD+e
	 s3UlT8wgXGfl56Pk4WEwnn1M8Rxi7E20n92tqvzbrxiVE4UuJYp5DJeSWCzmnuQCx3
	 5EXyZTzK7B8tDsB+2fAwatEU+JWnzlEaTmd4BmcudlGhxXZFypidLPXm54h7rlf+l/
	 lF6g9OOk30l+w==
Mime-Version: 1.0
Date: Wed, 05 Jun 2024 07:04:44 +0300
Message-Id: <D1RSB1PB5XGS.2X032M0E1VMJW@kernel.org>
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
 <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
In-Reply-To: <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_210456_939187_31899457 
X-CRM114-Status: GOOD (  28.03  )
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

On Wed Jun 5, 2024 at 5:33 AM EEST,  wrote:
> On 6/4/24 5:22 PM, Jarkko Sakkinen wrote:
> > On Wed Jun 5, 2024 at 2:00 AM EEST,  wrote:
> >> On 6/4/24 3:36 PM, Jarkko Sakkinen wrote:
> >>> On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
> >>>> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
> >>>>> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >>>>>> Introduce the Secure Launch Resource Table which forms the formal
> >>>>>> interface between the pre and post launch code.
> >>>>>>
> >>>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >>>>>
> >>>>> If a uarch specific, I'd appreciate Intel SDM reference here so that I
> >>>>> can look it up and compare. Like in section granularity.
> >>>>
> >>>> This table is meant to not be architecture specific though it can
> >>>> contain architecture specific sub-entities. E.g. there is a TXT specific
> >>>> table and in the future there will be an AMD and ARM one (and hopefully
> >>>> some others). I hope that addresses what you are pointing out or maybe I
> >>>> don't fully understand what you mean here...
> >>>
> >>> At least Intel SDM has a definition of any possible architecture
> >>> specific data structure. It is handy to also have this available
> >>> in inline comment for any possible such structure pointing out the
> >>> section where it is defined.
> >>
> >> The TXT specific structure is not defined in the SDM or the TXT dev
> >> guide. Part of it is driven by requirements in the TXT dev guide but
> >> that guide does not contain implementation details.
> >>
> >> That said, if you would like links to relevant documents in the comments
> >> before arch specific structures, I can add them.
> > 
> > Vol. 2D 7-40, in the description of GETSEC[WAKEUP] there is in fact a
> > description of MLE JOINT structure at least:
> > 
> > 1. GDT limit (offset 0)
> > 2. GDT base (offset 4)
> > 3. Segment selector initializer (offset 8)
> > 4. EIP (offset 12)
> > 
> > So is this only exercised in protect mode, and not in long mode? Just
> > wondering whether I should make a bug report on this for SDM or not.
>
> I believe you can issue the SENTER instruction in long mode, compat mode 
> or protected mode. On the other side thought, you will pop out of the 
> TXT initialization in protected mode. The SDM outlines what registers 
> will hold what values and what is valid and not valid. The APs will also 
> vector through the join structure mentioned above to the location 
> specified in protected mode using the GDT information you provide.
>
> > 
> > Especially this puzzles me, given that x86s won't have protected
> > mode in the first place...
>
> My guess is the simplified x86 architecture will not support TXT. It is 
> not supported on a number of CPUs/chipsets as it stands today. Just a 
> guess but we know only vPro systems support TXT today.

I'm wondering could this bootstrap itself inside TDX or SNP, and that
way provide path forward? AFAIK, TDX can be nested straight of the bat
and SNP from 2nd generation EPYC's, which contain the feature.

I do buy the idea of attesting the host, not just the guests, even in
the "confidential world". That said, I'm not sure does it make sense
to add all this infrastructure for a technology with such a short
expiration date?

I would not want to say this at v9, and it is not really your fault
either, but for me this would make a lot more sense if the core of
Trenchboot was redesigned around these newer technologies with a
long-term future.

The idea itself is great!

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
