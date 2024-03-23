Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971BDC47DD9
	for <kexec@archiver.kernel.org>; Sat, 23 Mar 2024 01:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H0K0okCBx9QdFngf7wQBIgDJ9mL3r8WdGxd56ZNC39Y=; b=GjraDQurKKERit
	2R41snsLEz5HRisj0x2hWZRI+goGd+xmTVD9+rUboC+9MzXEiXdgMYd98Ri6u76/JdLpCyMRPzIso
	NHhCRsT/hW9+60fg9LB2sfS8h2I9DQyDTMBIOcYiNz5Xf1rF6A/MbGt78bTopQqQm5VPVlS/wcQxz
	4R+rUN6FlRZk2CS4fCR2z7G+uIfLVX3wn0NEjdsLZXzDOM2YBZ94gnRdz1wVnkucDo/VACHArAKrl
	EL+D8UeF3CCP4zyEnhtQZigXuxFtg//AqgOzR4/4rO+OInnYZdOqPJciwDH8He954rRo8CVpuAlMi
	vQpMEWktsuNzm8twMThA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnqGv-000000098pV-1zcZ;
	Sat, 23 Mar 2024 01:34:09 +0000
Received: from sender4-of-o51.zoho.com ([136.143.188.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnqGs-000000098oo-0cjF
	for kexec@lists.infradead.org;
	Sat, 23 Mar 2024 01:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711157626; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y0P/6LGXB6XbnIcWo4Qk8zcdc8Jw+lAadY5AVPmkdkTcjKL1xfq/phucxRZdbbNgfKSheA1gZ2TCgQmpSop9a93QySuKrHzUX9cA/llTHTSpSkXW+MnPVF1RuubNen2kklKjmr1fhdL+1VTSotCBBBygMpSAIKA4weDZR7NPjbo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1711157626; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zTwwKIN0GuMJg2NfAmR7tXmcZNVQ9X8RONWejAf+ILA=; 
	b=KDRxtlHCwaLfbAAuvARZF6Zb1Yd9S4Wk7hw94ajl31mDeFrjtRGKo03f3oU0hbeYXY+Twf6jhUzk66U3KG0HakCt85ulldco9lnwqTycdGJ/nGtzkdpct84+lOyaIr0+1VU+BLWyQm0sidgRu09Q3t6da3gTLqs77MzOejmgKmM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711157626;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zTwwKIN0GuMJg2NfAmR7tXmcZNVQ9X8RONWejAf+ILA=;
	b=V0YnjjmUHOoqSu0E6ecOozxCpL45ni+sdwedBmm/G4ETjsKhjJ9rjKO5YeE+1DyK
	8x6FH+Z/xHt3BdkK9FPNXFzVS1wE10LyGtbPUcYy13Uwzinw3iZREXxoO1pIcB+2Gnz
	gro6z8WYudke6koxfL07M5d2VG3TE55huGqNCVv0=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1711157624195513.236242023147; Fri, 22 Mar 2024 18:33:44 -0700 (PDT)
Message-ID: <e52bbf77-4a80-4ebd-88f2-39e9b4063044@apertussolutions.com>
Date: Fri, 22 Mar 2024 21:33:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-2-ross.philipson@oracle.com>
 <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
 <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
 <32FDA47A-C87F-406F-A0B9-3AA1BB2EBAFB@zytor.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <32FDA47A-C87F-406F-A0B9-3AA1BB2EBAFB@zytor.com>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_183406_259193_5882176D 
X-CRM114-Status: GOOD (  18.75  )
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

On 3/22/24 10:18, H. Peter Anvin wrote:
> On March 21, 2024 6:45:48 AM PDT, "Daniel P. Smith" <dpsmith@apertussolutions.com> wrote:
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
>> Yes, the bootloader needs a standardized means to find the offset of the MLE header, which communicates a set of meta-data needed by the DCE in order to set up for and start the loaded kernel. Arm will also need to provide a similar metadata structure and alternative entry point (or a complete rewrite of the existing entry point), as the current Arm entry point is in direct conflict with Arm DRTM specification.
>>
>>> I'd like to get away from x86 specific hacks for boot code and boot
>>> images, so I would like to explore if we can avoid kernel_info, or at
>>> least expose it in a generic way. We might just add a 32-bit offset
>>> somewhere in the first 64 bytes of the bootable image: this could
>>> co-exist with EFI bootable images, and can be implemented on arm64,
>>> RISC-V and LoongArch as well.
>>
>> With all due respect, I would not refer to boot params and the kern_info extension designed by the x86 maintainers as a hack. It is the well-defined boot protocol for x86, just as Arm has its own boot protocol around Device Tree.
>>
>> We would gladly adopt a cross arch/cross image type, zImage and bzImage, means to embedded meta-data about the kernel that can be discovered by a bootloader. Otherwise, we are relegated to doing a per arch/per image type discovery mechanism. If you have any suggestions that are cross arch/cross image type that we could explore, we would be grateful and willing to investigate how to adopt such a method.
>>
>> V/r,
>> Daniel
> 
> To be fair, the way things are going UEFI, i.e. PE/COFF, is becoming the new standard format. Yes, ELF would have been better, but...

Fully agree with the ELF sentiment. We started looking to see if PE/COFF 
has something similar to a ELF NOTE, but figured maybe this has been 
solved for other cases. If that is not the case or there are not any 
suggestions, then we can see what we can devise.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
