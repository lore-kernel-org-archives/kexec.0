Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406E9C54731
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=saOmIpoWIWd9X8MjCTiqWo7eXqsvi8ETMDdlBnC+NqU=; b=C4zXqHlteHKPuU
	sIHsNnHj7NKsY6IeBdiSTwhQW2CYqHCsInayqecPoth9Y1yQrc/zbGkx0se/cl1bTchqi+6HjBvL4
	lFf1tNjk4oXNgE7xcU8P5grbBb0hT+DjsU7PqDmrmuKyyNPHDnR89/tViPZ3rUclIxY/NMTuQjXH+
	M6IJS4Zkm1OkdcDHCqcLbCZs8wtDJ1WUonqljoKCHkqvlSPA69JBHlK47ibvhPia1Vsgd9HOUT2WE
	UTXYK91D+k+L8tXmqeIZD7hUpDfMwW9cz8DtUpX8cBuJzCr1YVoTSUVFaKWdGzELY/i23iaZ1yd0n
	H5DDLEcGWC8a6uRirH/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj0pp-0000000CTjp-3IQS;
	Tue, 27 Aug 2024 18:22:29 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj0pm-0000000CTiK-1wDc
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 18:22:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1C3B2CE13FD;
	Tue, 27 Aug 2024 18:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B41C55DE1;
	Tue, 27 Aug 2024 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782469;
	bh=m0KhuixhE94LpmqoQsm4UAltH48GcF8i8IXdiG38ZPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NO9wZXRK+c5+9o1RgEUXTMlPsLUkraQbJNjNWgnaiIsMVAj7HTDpigo1IKFqPjQSC
	 72aYl4ts3jLiWhPoHr5B+0XONuilwh2rVswBam14Vp2U84t+uzxlVMX80qsuYTUwMd
	 B03rCcpX2T0+wlO1mryM4OumGNDr3k3Oj8NO3Dc94a7lzqt6Vqdane7FRLa1U8xvd6
	 QIqoXi5N9u8S8mhS9/gA5VAQP+xy8shOYuVsU9PJsQmze3QJq57qFJCtarRBhpyAya
	 VTsHjCBQprW7P/+6l5j3vMcsypMc9D0XOKJ+pnsn9wnsg3+pJxbeIeF38mRpoBFf7O
	 XwDFH+Dkzul/A==
Date: Tue, 27 Aug 2024 11:14:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <20240827181426.GC2049@sol.localdomain>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240531021656.GA1502@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_112226_703257_B4757900 
X-CRM114-Status: GOOD (  22.64  )
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

On Thu, May 30, 2024 at 07:16:56PM -0700, Eric Biggers wrote:
> On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
> > From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> > 
> > For better or worse, Secure Launch needs SHA-1 and SHA-256. The
> > choice of hashes used lie with the platform firmware, not with
> > software, and is often outside of the users control.
> > 
> > Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> > with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> > the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> > to safely use SHA-256 for everything else.
> > 
> > The SHA-1 code here has its origins in the code from the main kernel:
> > 
> > commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> > 
> > A modified version of this code was introduced to the lib/crypto/sha1.c
> > to bring it in line with the SHA-256 code and allow it to be pulled into the
> > setup kernel in the same manner as SHA-256 is.
> > 
> > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Thanks.  This explanation doesn't seem to have made it into the actual code or
> documentation.  Can you please get it into a more permanent location?

I see that a new version of the patchset was sent out but this suggestion was
not taken.  Are you planning to address it?

- Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
