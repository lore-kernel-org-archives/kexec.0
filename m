Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52554C71150
	for <kexec@archiver.kernel.org>; Wed, 28 Aug 2024 23:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W+pL6+lMkHgCTTcVSFW+lpt9tWbZrf3nQ2pbcDIVVw4=; b=s191qamcbz0Uxg
	kifHYkrLK8aixXFu2yUa6ItEhBA6dDam2trVfOoqyB7LlalmG3wefOrRZf0Nmg9yUkDsqiHOzd2D9
	6a9MU5EImbyDePMrxN9n/osvqDmkO4abS5ZFdj0IB6qHxtk2EnwYCbB4Q2q3FATu9DLUDJx/FGDEH
	ygvav/0bXPYL8q4wE5zKZtjU0paNyhv5d6P8Rh6SQthIl+eVBFbMFxFUM7H3yu4SIhh4Ucc0OlVoA
	gWG6l0grO6e7QZs5PNT7txsFpk/aRwVCELW6Si7Uxvl5NcECazQIZvcX+8K3dv7829M7HRKz8yGVo
	cwNX1FmTXFf5LKzyn5Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjRrS-0000000HJBb-3GWY;
	Wed, 28 Aug 2024 23:13:58 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjRrO-0000000HJAP-3AfE
	for kexec@lists.infradead.org;
	Wed, 28 Aug 2024 23:13:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C7E77A43476;
	Wed, 28 Aug 2024 23:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E93BC4CEC0;
	Wed, 28 Aug 2024 23:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724886832;
	bh=QISJ42Va0eYxqFWZBmZo3tT+XOt9YziD/pQSoZRbBg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Igkl3X+YtPWt9lCblaUZzraFSdFxa54F4n2l+ehwjXqByzx1N8EEiLXby+Z8CfzZ8
	 7kzVqzb8dj1SXhUoZnGtY8B83J9xdiCwbXKuUdpBcevOBu7zDAdlF4il1Q5fte9o71
	 nmxNhsqDLPd36IPd35D5ImzYQ31N8WkReq8dF8zlJnD6n22lEPcHNNR/bxWxOYjj1Z
	 aFUyNy3WDAmPeW76D+8frUPREHFpIB07PDD9tNSXHzZMg6/+XpabrzvlGz742UtqW1
	 lM7HQIRrpnau/LYc6CLvEiTOSvR5JXx5Y5SdAfIwROoUCfXVwWxwhqEPETSQsl/I1G
	 qxqrLyHNPkFGA==
Date: Wed, 28 Aug 2024 23:13:50 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: ross.philipson@oracle.com
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
Message-ID: <20240828231350.GA558903@google.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <20240827181426.GC2049@sol.localdomain>
 <601646a2-46ac-47a0-a8b7-1d45a09172ab@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <601646a2-46ac-47a0-a8b7-1d45a09172ab@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_161354_947590_A40AE707 
X-CRM114-Status: GOOD (  30.99  )
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

On Wed, Aug 28, 2024 at 01:14:45PM -0700, ross.philipson@oracle.com wrote:
> On 8/27/24 11:14 AM, 'Eric Biggers' via trenchboot-devel wrote:
> > On Thu, May 30, 2024 at 07:16:56PM -0700, Eric Biggers wrote:
> > > On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
> > > > From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> > > > 
> > > > For better or worse, Secure Launch needs SHA-1 and SHA-256. The
> > > > choice of hashes used lie with the platform firmware, not with
> > > > software, and is often outside of the users control.
> > > > 
> > > > Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> > > > with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> > > > the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> > > > to safely use SHA-256 for everything else.
> > > > 
> > > > The SHA-1 code here has its origins in the code from the main kernel:
> > > > 
> > > > commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> > > > 
> > > > A modified version of this code was introduced to the lib/crypto/sha1.c
> > > > to bring it in line with the SHA-256 code and allow it to be pulled into the
> > > > setup kernel in the same manner as SHA-256 is.
> > > > 
> > > > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > > 
> > > Thanks.  This explanation doesn't seem to have made it into the actual code or
> > > documentation.  Can you please get it into a more permanent location?
> > 
> > I see that a new version of the patchset was sent out but this suggestion was
> > not taken.  Are you planning to address it?
> 
> Sorry we sort of overlooked that part of the request. We will take the
> latest commit message, clean it up a little and put it in
> boot/compressed/sha1.c file as a comment. I believe that is what you would
> like us to do.
> 

Do users of this feature need to make a decision about SHA-1?  If so there needs
to be guidance in Documentation/.  A comment in a .c file is not user facing.

- Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
