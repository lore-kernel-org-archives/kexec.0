Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D523EC83F26
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AcSpDz0SJaAH47J4wknP6NZAixD5O8lkZ2r+12RZXBM=; b=mMaGnTNP+6i4sJ
	Gv3c23QBR0unaGVkzaHWyRhWje0EeplWrTVn4hkQovffSnmNn+H4Ne7R2c3qD/udZq4CrCjbHQ1UE
	lb3dxWRAldshl3CYN++2vWQeLUnpSwMAKiKzqLJGyfHMc3gBYKWRi7OdH491urSaDrKmwsqsEYJRc
	X/tuWs6vivGnie9vnoPPvnzxKonwwFkKgNnepQmvAyGYLZCnTYdm02KtwsAHzlLkdynuxqrO0JqaZ
	NLJWhxjZiYwQoXlSlHg864+yn2ZLFO7xhmSrAkFpkJhCB/KupnqVY7mJniJRq3CVkef1BUznheWlN
	Z3EX/6Lnm8bJpklZZl1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjfst-00000002LDC-0Dm7;
	Thu, 29 Aug 2024 14:12:23 +0000
Received: from sender4-of-o51.zoho.com ([136.143.188.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjfsV-00000002L8A-1BiY
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 14:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1724940676; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E7EusWO6er6F2xI1Zxfssj17795cFIrBU9nS7H5PyLGs+6UWBCNXAkfV+JQpsvkn4X6QnDjZg59GcAbdwpZwp541+ugqTaxP6T/nv6M351s7VISQpTXJZegJ/QpLmHKW8PhIgd5ObyYNwREe1/OqSZxAHGA/WYAAlVOJLcXTMDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724940676; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HgDBKtReaNoT627XPwozc8cV/1MN4aAoTtHPOciy3pM=; 
	b=F8+Ieta99m9Sb6grjg5r5Hse1Vt8cQANARXzRz4E2JRoFdXjGYznYWVRmMvi/k0t3GJxjfgkNXCi7mbnz93mta8ovG1WRwOCa2szi73evgpHYzIgytv1sd3soamVZ71SpJYmuyZoaySGKcb25OExw2BJMSP43syvz3OmqKbf23o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724940676;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HgDBKtReaNoT627XPwozc8cV/1MN4aAoTtHPOciy3pM=;
	b=fRJYXpXL9J45pXy0RROxungza/op8PLpbcAgBCB2imI/b3vHv4nw02sEX8neAivz
	PPiCX2FneFCwIi7K74vsx1xZ2NcmUIkgDl+v3rZoRF1EkHBouBvTymaYqasGUoGZL83
	itV4OEfBmfm1uvXSAhidcGZMH/LIAtY/V/1UW3+4=
Received: by mx.zohomail.com with SMTPS id 1724940674239491.862092879441;
	Thu, 29 Aug 2024 07:11:14 -0700 (PDT)
Message-ID: <e3194ad1-e976-40a6-a8f3-98081b0b07ea@apertussolutions.com>
Date: Thu, 29 Aug 2024 10:11:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
To: Ard Biesheuvel <ardb@kernel.org>, Stuart Yoder <stuart.yoder@arm.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-2-ross.philipson@oracle.com>
 <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
 <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
 <CAMj1kXHn6xeAskWiDLvvA4oG3j9_tqx+iMYJXMqmgvyX4pMzgg@mail.gmail.com>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CAMj1kXHn6xeAskWiDLvvA4oG3j9_tqx+iMYJXMqmgvyX4pMzgg@mail.gmail.com>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_071159_476689_59D64347 
X-CRM114-Status: GOOD (  18.20  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 8/28/24 13:45, Ard Biesheuvel wrote:
> (cc Stuart)
> 
> On Thu, 21 Mar 2024 at 15:46, Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>> Hi Ard!
>>
>> On 2/15/24 02:56, Ard Biesheuvel wrote:
>>> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>>>>
>>>> From: Arvind Sankar <nivedita@alum.mit.edu>
>>>>
>>>> There are use cases for storing the offset of a symbol in kernel_info.
>>>> For example, the trenchboot series [0] needs to store the offset of the
>>>> Measured Launch Environment header in kernel_info.
>>>>
>>>
>>> Why? Is this information consumed by the bootloader?
>>
>> Yes, the bootloader needs a standardized means to find the offset of the
>> MLE header, which communicates a set of meta-data needed by the DCE in
>> order to set up for and start the loaded kernel. Arm will also need to
>> provide a similar metadata structure and alternative entry point (or a
>> complete rewrite of the existing entry point), as the current Arm entry
>> point is in direct conflict with Arm DRTM specification.
>>
> 
> Digging up an old thread here: could you elaborate on this? What do
> you mean by 'Arm entry point' and how does it conflict directly with
> the Arm DRTM specification? The Linux/arm64 port predates that spec by
> about 10 years, so I would expect the latter to take the former into
> account. If that failed to happen, we should fix the spec while we
> still can.

Yes, we have been working with Stuart regarding the specification and 
crafting a compliant implementation approach. It is still very early 
days, we are attempting to draft a plan around the specification with no 
physical implementation to validate against. After some discussion, the 
concern that a separate entry point may be needed has faded and in fact 
it likely will not be needed. As always, the devil is in the details, 
and until we have a hardware that has implemented the specification, and 
we attempt to light it up, we won't know what will be needed for the 
implementation.

In short, at this point it was determined no update to the DRTM spec is 
needed. As hardware becomes available, and we do battle with it, Stuart 
will be kept up to date. We will work with him to ensure any changes are 
captured that will help reduce chances that vendors and developers do 
not misinterpret the spec.

V/r,
Daniel P. Smith

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
