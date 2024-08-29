Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815D5C7115D
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 03:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=usK5pXH0xeqsp5wPJEUxxfNX5HVKX+RSmu5juPWLImA=; b=FFCkeG5J8kyxRZ
	tD3/y5X40Nk8xJvYPkpiuE4ky3icmHxPKBKo4qT1W2Wzzrxuf3qpwApo4je2ZMPM+cTgZHkceeoLN
	TAj7fYRqKkfxUKCdgB+NB9XMF6V1lToe20VwZdit1tQG0ZySKNJFe13ZHNSmL9uIpQmLz5JFbJcvn
	fn898/xz8/4YA2WxZYBlDRQIUt0J2Tddo9SMy8RO9wnM2AsNfV4a8V9l8aCzHqTX0P1+bdBHdobqH
	2yZHHSWF+4+e0+366CnXoN+GMxpIUzFjd9ZCR0kUU4ss/QPS5KP3d3NpO0T+aTajn5+ahwQMJ3dnl
	hrefPSFr3SfaADgDqsHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjVmy-00000000LPx-3yxh;
	Thu, 29 Aug 2024 03:25:36 +0000
Received: from cavan.codon.org.uk ([176.126.240.207])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjVmt-00000000LNe-26f0
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 03:25:35 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 1FEBF407E6; Thu, 29 Aug 2024 04:25:26 +0100 (BST)
Date: Thu, 29 Aug 2024 04:25:26 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <Zs/qJsKu3StL3Wzt@srcf.ucam.org>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_202531_695345_A1E05E2D 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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

On Wed, Aug 28, 2024 at 08:17:05PM -0700, Andy Lutomirski wrote:

> Ross et al, can you confirm that your code actually, at least by
> default and with a monstrous warning to anyone who tries to change the
> default, caps SHA1 PCRs if SHA256 is available?  And then can we maybe
> all stop hassling the people trying to develop this series about the
> fact that they're doing their best with the obnoxious system that the
> TPM designers gave them?

Presumably this would be dependent upon non-SHA1 banks being enabled?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
