Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2017DD6A225
	for <kexec@archiver.kernel.org>; Fri, 15 Nov 2024 01:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MuBQEpSeYrVW5P897dVbSdSSTy2uYjy7xShRezu7W2k=; b=l/H3emFckPyShxJINr4m5hTFjT
	sBg24M94/m8jxDYbOQs+hvHF7pXGZcBp5kYiirn02J14BQqZFwQA29TMBjvYoSK60/VCFOAeVySEV
	+ghcshUB0CwSKsHYb+vBCITWqxPyGbnYVlmm/vChCmaKSxi3jTfksYVrV6ZBXE1At0iNbhdrsX+Xj
	TyWQMCXWEpoym3wGH0zAIeieodg+X7faZIbU2arg4muQVUFyldqHsdRmce6b7A2JIlbrnL/kcz/M3
	JAy5uUoPKV0qbb6jfsTk3hblKz+q39XtYuac773GUrLggYEV1Au/PUSY/jioV4w82lHk9mV1Dxj0W
	LguXo/MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBkyp-00000001HhQ-2tym;
	Fri, 15 Nov 2024 01:18:35 +0000
Received: from sender4-of-o51.zoho.com ([136.143.188.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBky9-00000001Ha5-3eXy
	for kexec@lists.infradead.org;
	Fri, 15 Nov 2024 01:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1731633431; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HApsMMSmRc9YCIaxMUkJe0zltVO0dOBTierobYTK3H1mctcHyww8DwqrhC8w5GdZf6NC6DwbwZDAJuMEzTVPRXUDUItxS4QJ17p/tV6kz7j1fgbEhr8ZBdLd8f9rsImU1GTYB1rvqkSEOIBYrchHSHD98NeO+p2CChpRfgw9q+0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731633431; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MuBQEpSeYrVW5P897dVbSdSSTy2uYjy7xShRezu7W2k=; 
	b=NpTuHv2RsFDLRF/2wLyPkQne8P5SbtKMElKK6Mr5iJgBiuu2V4yPF9Z9chpk5y9Yvy8MDQ1Pa+WqJm05Zpoq80TqWZz9rvgv17S6yueVCyrfcfBfvdFXBCYpIw8BcQJ6BwJRUuiTQOscs6oC/s5UJQEOrazWXDEjNLfVjQQF5lY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731633431;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MuBQEpSeYrVW5P897dVbSdSSTy2uYjy7xShRezu7W2k=;
	b=mhpPy1pkZZfw9Xv4SsFNA73xYZM58AZ6T6tnXjLz41i0gpDvH/DTN0MVOimmT0jg
	EcAnCMDvMFWGfBpMmBnd8Y0PXCoNXN70fIVZFTLqOQzvtCt9J8vlcAhAJn3RJvwzjba
	YugFNZ3m4CvIQbbEqIXJl+Kd1FYcuZb6NcWxOiz0=
Received: by mx.zohomail.com with SMTPS id 173163342863043.69850969601737;
	Thu, 14 Nov 2024 17:17:08 -0800 (PST)
Message-ID: <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
Date: Thu, 14 Nov 2024 20:17:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Andy Lutomirski <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
 davem@davemloft.net, corbet@lwn.net, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
Content-Language: en-US
In-Reply-To: <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_171754_030198_7EABC3F9 
X-CRM114-Status: GOOD (  25.94  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/2/24 12:04, James Bottomley wrote:
> On Sat, 2024-11-02 at 10:53 -0400, Daniel P. Smith wrote:
>> Hi Luto,
>>
>> My apologies, I missed this response and the active on v11 cause me
>> to
>> get an inquiry why I hadn't responded.
>>
>> On 9/21/24 18:40, Andy Lutomirski wrote:
> [...]
>>> I assumed that "deliberately cap" meant that there was an actual
>>> feature where you write something to the event log (if applicable)
>>> and extend the PCR in a special way that *turns that PCR off*.
>>> That is, it does something such that later-loaded software *can't*
>>> use that PCR to attest or unseal anything, etc.
>>>
>>> But it sounds like you're saying that no such feature exists.  And
>>> a quick skim of the specs doesn't come up with anything.  And the
>>> SHA1 banks may well be susceptible to a collision attack.
>>
>> Correct, the only entity that can disable PCR banks is the firmware.
> 
> No, that's not correct.  Any user can use TPM_PCR_Allocate to activate
> or deactivate individual banks.  The caveat is the change is not
> implemented until the next TPM reset (which should involve a reboot).
> BIOS also gets to the TPM before the kernel does, so it can, in theory,
> check what banks a TPM has and call TPM_PCR_Allocate to change them.
> In practice, because this requires a reboot, this is usually only done
> from the BIOS menus not on a direct boot ... so you can be reasonably
> sure that whatever changes were made will stick.

Okay, since there is a desire for exactness. Any system software can 
send the TPM_PCR_Allocate command, specifying which PCRs should be 
activated on next _TPM_init. There are restrictions such that if 
DRTM_PCR is defined, then at least one bank must have a D-RTM PCR 
allocation. In agreement with my statement, this is the mechanism used 
by firmware to select the banks. Depending on the firmware 
implementation, the firmware request will likely override the request 
sent by the system software.

This brings us back to an earlier point, if one disables the SHA1 banks 
in BIOS menu, then TXT will not use them and thus neither will Secure 
Launch. Secure Launch will only use the algorithms used by the CPU and 
the ACM.

>> When it initializes the TPM, it can disable banks/algorithms. After
>> that, when an extend operation is done, the TPM is expecting an entry
>> for all active PCR banks and the TPM itself does the extend hash that
>> is stored into the PCRs.
> 
> This, also, is not quite correct: an extend is allowed to specify banks
> that don't exist (in which case nothing happens and no error is
> reported) and miss banks that do (in which case no extend is done to
> that bank).  In the early days of TPM2, some BIOS implementations only
> extended sha1 for instance, meaning the sha256 banks were all zero when
> the kernel started.
> 
> Even today, if you activate a bank the BIOS doesn't know about, it
> likely won't extend it.  You can see this in VM boots with OVMF and
> software TPMs having esoteric banks like SM3.

Let me correct myself here and again be extremely precise. When an 
extend operation is done, the TPM driver expects to receive an array of 
digests that is the same size as the number of allocated/active banks. 
Specifically, it loops from 0 to chip->nr_allocated_banks, filling 
TPML_DIGEST_VALUES with an entry for all the active banks, to include 
SHA1 if it is active. Coming back to my response to Luto, we can either 
populate it with 0 or a well-known value for each extend we send. 
Regardless of what the value is, the TPM will use its implementation of 
SHA1 to calculate the resulting extend value.

Even with these clarifications, the conclusion does not change. If the 
firmware enables SHA1, there is nothing that can be done to disable or 
block its usage from the user. Linux Secure Launch sending measurements 
to all the banks that the hardware used to start the DRTM chain does not 
create a vulnerability in and of itself. The user is free to leverage 
the SHA1 bank in any of the TPM's Integrity Collection suite of 
operations, regardless of what Secure Launch sends for the SHA1 hash. 
Whereas, neutering the solution of SHA1 breaks the ability for it to 
support any hardware that has a TPM1.2, of which there are still many in 
use.

V/r,
Daniel P. Smith



