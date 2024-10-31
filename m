Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BF0E6B27C
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 14:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=76+1EbUx2bUOPjOJQeMZv1Qf4b2HD41PO5qrfY/AeCc=; b=mJSsXtLxTehY8J
	YQx6rs4mTvp03B+RK0iXGah2TMZ6qasVQ6noJNr0XuKFVLxrPuEIbMBq11QpINtLXH0tzL5dvIe+D
	Ik6jPP+ExQnuwWw6vegaas73WDkbJtBCu89SdEKVkLzpULqIJBQOX01q2VeCTsDFWI8beBp3uX+1h
	GLvserTpdXMnBSQ9QL4slu86/GITt80EmAX9Ke1ZH5ex6NWqgV2IpbjVlM32ke0CzCDt6IhOk/i1Z
	1PUf+qi1o6bvtGA+L4EtUtm/5LYgUv6+byPe02KhQIyk3jA3i3DNRqlIQFZTKfMqPRXxAvz1WZqgs
	vNtEeh4J5eeJ5mRAbdQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sG6-00000007Gj4-118L;
	Fri, 01 Nov 2024 14:04:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s5z-00000007F6I-0PAx
	for kexec@bombadil.infradead.org;
	Fri, 01 Nov 2024 13:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:References:To:From:Subject
	:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=X9xZeLK5UwcmYaEmE29YjHzyiIdH+Qq0jPUQJmq0BVU=; b=lsP+WTcwS5LDXLSctSkYOxyTdR
	flFmtdc2KkQd89XbtbIr04eOsxikFk4BQD8e0i4DwGLdV/PhitOSSmcUykDN+mVdP/Y/r9YkMo+r+
	VgQjkNqh5QsPK5ZIGQYvKlAoxRgHnkZKGfUs+jUlcw3BPq4UiG+BXMy2+xGnjGLTnW8o3z6Zp8TZd
	g3oyjHLOw4RlgEEouErg1UoHykk2bNcXhNJY05vgeVGIoau3CuTxMcFpojZwzR28FbZ9oA+8e5YKC
	sbGq21YrH10bNAe5Pm7Y3G2PhhYBeeJI2BQko1MdDcwlT5nsMC2oO0bVb9n+MI/P4N9C6Grs+CkH7
	TdGUcazg==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s5u-0000000Ahjq-2pby
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 13:53:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4FF895CA49D;
	Thu, 31 Oct 2024 22:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DBCC4CEC3;
	Thu, 31 Oct 2024 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730414251;
	bh=HfxuReQImXwvhpLuPipg5vqXGCC5//yJ2cqMYklD4uE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HkpDpmu7UAbaJtrXnkkFcec2474fvBoqy1ujDdyxLJNxpkcAbhiAXS1i+Za5t54bZ
	 GVwE5D/p4jdo5We7G5n3MMQRMeZt1O4PwIEk3Q8dSYOvRJp80k8RjogGFcur/qZ9A4
	 65A4DQPqRNeJPryDCd7dZX/z2M2Qj8ilUSZb90Qw15sK2bj1m9OGio2DHx9qbloBzI
	 03SnuZRNrUzggGH9xeKrEfxS8fiBmLPxUjVP6p1J98HwOansT2wUsTL+V9wzx6AmkH
	 IK4e9kIEtrcKNkxVSuQU1G4u+Vdbl9KNU2pocO2pR1bDSBN1vVB/WbCKXWURZsDZGW
	 fsY12541kUjOQ==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 00:37:27 +0200
Message-Id: <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <mingo@redhat.com>, <bp@alien8.de>,
 <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <ardb@kernel.org>,
 <mjg59@srcf.ucam.org>, <James.Bottomley@hansenpartnership.com>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <luto@amacapital.net>,
 <nivedita@alum.mit.edu>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>, <corbet@lwn.net>, <ebiederm@xmission.com>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx>
In-Reply-To: <87wmhoulb9.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_135343_137631_F0D061AA 
X-CRM114-Status: GOOD (  25.93  )
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

On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
> On Fri, Sep 13 2024 at 13:04, Ross Philipson wrote:
> > The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
> > enhance the boot security and integrity in a unified manner. The first area of
> > focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> > a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> > Trust for Measurement). The project has been and continues to work on providing
> > a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
> > cross-architecture (x86 and Arm), with our recent involvment in the upcoming
> > Arm DRTM specification. The order of introducing DRTM to the Linux kernel
> > follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
> > Technology (TXT) is present today and only requires a preamble loader, e.g. a
> > boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
> > been present since the introduction of AMD-V but requires an additional
> > component that is AMD specific and referred to in the specification as the
> > Secure Loader, which the TrenchBoot project has an active prototype in
> > development. Finally Arm's implementation is in specification development stage
> > and the project is looking to support it when it becomes available.
> >
> > This patchset provides detailed documentation of DRTM, the approach used for
> > adding the capbility, and relevant API/ABI documentation. In addition to the
> > documentation the patch set introduces Intel TXT support as the first platform
> > for Linux Secure Launch.
>
> So this looks pretty reasonable to me by now and I'm inclined to take it
> through the tip x86 tree, but that needs reviewed/acked-by's from the
> crypto and TPM folks. EFI has been reviewed already.
>
> Can we make progress on this please?

So TPM patches do have bunch of glitches:

- 15/20: I don't get this. There is nothing to report unless tree
  is falling. The reported-by tag literally meaningless. Maybe this
  is something that makes sense with this feature. Explain from that
  angle.
- 16/20: Is this actually a bug fix? If it is should be before 15/20.
- 17/20: the commit message could do a better job explaining how the
  locality can vary. I'm not sure how this will be used by rest of
  the patch set.
- 18/20: I'm not confident we want to give privilege to set locality
  to the user space. The commit message neither makes a case of this.
  Has this been tested to together with bus encryption (just checking)?

>
> Thanks,
>
>         tglx

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
