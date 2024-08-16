Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247E2C3DA4A
	for <kexec@archiver.kernel.org>; Fri, 16 Aug 2024 18:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AuwuAjHGnV3Se2scomR8UiChK8UkiLoNW1wPxo6RYMw=; b=vQpYX4lORRtfdf
	YG4pUqeanoESIq8dXDT5Tvjlvkq5fubJ2B591ZZhdHQ8NhUwAE6J3HC8vxKW/dBgnhOBpVNuLWOuv
	mIqxVFRnisOrGxKvLu0ghQOZM7OcwMt7bxcoKYSxsKxDl/AjFmT7AcHQMwpLA0gBQKjWujFVoPoHt
	6zuKKlYfoyBapYxKycnK1OadFJ/CBb0wHCusvNZXXNDadB35qrhQ8Ejcd1FaoZiWWPtkbfPVqqw4n
	HhFAOnDDBKv98+2gi5sawu8qUtYdULjqQDs600iqD8VMdDyfKXPHVtRceVtTHK5rWOAyYTAdzVIwm
	b1qcylZj7d/Gv52wqrDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sf1t9-0000000DrVH-449O;
	Fri, 16 Aug 2024 18:41:27 +0000
Received: from cavan.codon.org.uk ([2a00:1098:84:22e::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sf1t3-0000000DrUQ-3zED
	for kexec@lists.infradead.org;
	Fri, 16 Aug 2024 18:41:26 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 61FBF40677; Fri, 16 Aug 2024 19:41:16 +0100 (BST)
Date: Fri, 16 Aug 2024 19:41:16 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <Zr+dTMYZNY1b9cRV@srcf.ucam.org>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
 <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_114122_141600_F74DE6B3 
X-CRM114-Status: UNSURE (   9.99  )
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

On Fri, Aug 16, 2024 at 02:22:04PM +0300, Jarkko Sakkinen wrote:

> For (any) non-legacy features we can choose, which choices we choose to
> support, and which we do not. This is not an oppositive view just saying
> how it is, and platforms set of choices is not a selling argument.

NIST still permits the use of SHA-1 until 2030, and the most significant 
demonstrated weaknesses in it don't seem applicable to the use case 
here. We certainly shouldn't encourage any new uses of it, and anyone 
who's able to use SHA-2 should be doing that instead, but it feels like 
people are arguing about not supporting hardware that exists in the real 
world for vibes reasons rather than it being a realistically attackable 
weakness (and if we really *are* that concerned about SHA-1, why are we 
still supporting TPM 1.2 at all?)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
