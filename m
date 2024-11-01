Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7646DE6F08E
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 21:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:Subject:Cc:
	To:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EJY0yqEyneAe8tneyKdaM4i2xA9LWK/BWFlZWkqlKZ8=; b=LAuvVV9oD7AB5q
	L6f5kV5cW0eh98B0yEdsVfpt5F2tC+mrSKFidv7CUefCzHW40qL+EbflCcLzwFoKZlXvujlgThs7U
	gUWktRAmuchz7N8l0O1fgA4qU1+2ouhD5CoutoJFFRmO6xjIbtHlzQpDrs0CXQrFz6suIbaaLN1td
	A+++tIjm3jTPKWb5Kb4u21sWhtK1TRcCYUrUDB5hKzt56jlFm8Lsn1GZI7j7mn4GuFpcqSURI5oq9
	MY/05NWwLC/HYUFQEqhsk6DN3SgktGiJKubtF3tdK2ykYc/vsC7wRsKvsJALxT5dQzc3Z6tPn7gP6
	FUaSxaJd61FeE1qygXWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6zd7-00000008Phy-3oFv;
	Fri, 01 Nov 2024 21:56:29 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6zd5-00000008Ph6-3aPf
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 21:56:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 30D8EA43CD1;
	Fri,  1 Nov 2024 21:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A074C4CECD;
	Fri,  1 Nov 2024 21:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730498186;
	bh=fziVethYd+NPhcx81IKT2ML+GpHUPixc+xtg0E2ky9o=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=P7xA/q3qow25TnX1KVFl60EAxmebWXU5zAOwQwJRnaUFpjfJc+7yjIoztedBfWpF9
	 9+2IATFc+NfSL6bu5gW9V2qdOQ/17jwvjeZrNUMek7y57fiGamkutcMRpmylyPhGuq
	 sNPfYAnYu/Ik+PshC2CkZCPrn3CkZrcGRemN9DNxDGGWc95FEG8yNLoIzsbP1Zq63a
	 smRkLu2/c41kaseVGbRe9Fd+e7moKcjBlp/e56O8XS997ZT6kjDWfCOHFDsc140bQB
	 Kjmhb6IsqpZcEV9m6Etr+Vf8uNsUlzqVRBZRyAtMyYfYtX8tvj3VcKr5/4ti6J6h3q
	 AJJcAUgOzYjdg==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 23:56:22 +0200
Message-Id: <D5B6EQ3BE8HC.2BZ3UDY70CGKG@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v11 18/20] tpm: Add sysfs interface to allow setting and
 querying the default locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-19-ross.philipson@oracle.com>
 <D5ARBBZU61YW.2SQ35HTOJ85F7@kernel.org>
 <D5B69X48SFO7.RMZ1I1926BPF@kernel.org>
In-Reply-To: <D5B69X48SFO7.RMZ1I1926BPF@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_145627_963541_341A3862 
X-CRM114-Status: GOOD (  14.37  )
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

On Fri Nov 1, 2024 at 11:50 PM EET, Jarkko Sakkinen wrote:
> On Fri Nov 1, 2024 at 12:06 PM EET, Jarkko Sakkinen wrote:
> > On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> > > Expose a sysfs interface to allow user mode to set and query the default
> > > locality set for the TPM chip.
> > >
> > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >
> > Must be read-only. Should be decided per power cycle.
>
> I'm throwing one incomplete idea not all things considered...
>
> So one idea is would be to apply set operation to /dev/tpm0 as ioctl
> (would not be available for /dev/tpmrm0).
>
> Then at least access control rules would apply.
>
> The open here is that the IMA etc. will use a different locality during
> boot-time, like it would also with sysfs attribute.

Looking at [1] this would become a problem if TPM2_PolicyLocality based
policy is ever used during boot-time.

We can make a choice of not allowing such policies for in-kernel clients
if agree so, but it is a choice that needs to be locked in. With quick
thinking I'm not sure if that is horrible limitation.

Also does not obviously affect clients communicating with /dev/tpm0.
With that constrain it would not matter if during boot-time different
locale is used.

With that constraint and "set" in ioctl instead of sysfs attributes
that might even work out... Open for feedback.

[1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-3-Commands.pdf

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
