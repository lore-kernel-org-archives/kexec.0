Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68992EB64D7
	for <kexec@archiver.kernel.org>; Fri, 16 Jun 2023 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6LD843jT537jz5b22ssbEBlaEx6PK//xko7B3iqVC/4=; b=an9Mp9W/fUzmzr
	dVpHY2RyEfPwb/42tNaW6gEP5peFTydjZsaK7OAueEgsFdpkaPAR59qbyA3VO8io4B4RMLkqjwO0N
	OV5TT5jK4lkfDHfOjU5GYKDQ/1eBlT8J/fWkiljUhXdKrvxJHciWTBMkGaCXsqDeQu+TJpvwZYPSi
	kvIbjn+T463sIq3ZsNagCzV1WoHhQZvyqOZKN4oAjMXQa3MyPKZ7KtWXwAZexqIXbZg1dVW4AhBMK
	sa40/AaWjS9IRAkj2jvkAkLO+dWCJwl2pfnFutIZxum7z3zM11f8tOoXCBQO1Mp9ETquom38vu9gu
	ay4lg9uciXbpFJEHxv8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAE57-001Pxw-20;
	Fri, 16 Jun 2023 18:21:57 +0000
Received: from sender4-of-o50.zoho.com ([136.143.188.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAE55-001Pwk-0F
	for kexec@lists.infradead.org;
	Fri, 16 Jun 2023 18:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1686939697; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ffvSiDruYhLVJJGBcz4tQWNlfs6d5bauH+Ej2CpFSmpsU2USUfadAkTf61XiTUkuV/fwd6T4eN044PQ+mqv+bW8oGdYrENxv9+ZNEy4ZAHVgoGs/St8s/04QrDjVsEqiXT6OBT+HVzn9m0ylLfxZvopPb0cDCH30F5iNu5Ks9Tk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1686939697; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=8enOf0amLtvBhNkLA/XPa3bwYhCfY01qhBgRzZsYp4k=; 
	b=iWf2gamft5I1tQafDe+wzLXebNQzYgTsFca9wWHDHLlU6KpTO1qpzty8hZCqVyulR8PbWnlFxsQR8fJqa+E4Y+zRng39F8z0DpD35pHI66jgZ80xzygN7M8x2Pkuv75gqryEQ5wEkTUJy0yFlI6jKwZWMqj/W73Q/cmZIzFzfuo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686939697;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:From:From:Subject:Subject:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8enOf0amLtvBhNkLA/XPa3bwYhCfY01qhBgRzZsYp4k=;
	b=qHykneBd3W/uQb3DdBB6UMoKU5vU2hAHAgTWfpyu0VTnkeKUnav9pYS2Lv2cPAAr
	bEdoQSblbIGf34Wi35ucomsH+lyGq/exEwlUfLIru8FCcg0jLUx552Uf3IYYQESeI0f
	rstR4wkctcFvn8BMkk0jayWtDQUD04axkQJGtfZA=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1686939696166530.3719741366886; Fri, 16 Jun 2023 11:21:36 -0700 (PDT)
Message-ID: <81a0a2f3-e7b2-23e8-5c95-91c9a52df18a@apertussolutions.com>
Date: Fri, 16 Jun 2023 14:21:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 James.Bottomley@hansenpartnership.com, luto@amacapital.net,
 nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
 <20230512104753.GA14461@srcf.ucam.org>
 <e7dcb85b-25bb-8d5a-3758-e4243bc6ffec@apertussolutions.com>
 <20230616165415.GA28537@srcf.ucam.org>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
In-Reply-To: <20230616165415.GA28537@srcf.ucam.org>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_112155_137549_D6C10558 
X-CRM114-Status: GOOD (  27.85  )
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

On 6/16/23 12:54, Matthew Garrett wrote:
> On Fri, Jun 16, 2023 at 12:44:27PM -0400, Daniel P. Smith wrote:
>>
>> On 5/12/23 06:47, Matthew Garrett wrote:
>>> On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
>>>> +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
>>>> +built with KASLR disabled::
>>>
>>> Why does Secure Launch not interoperate with KASLR?
>>>
>>> Re: IOMMUs
>>
>> Until the IOMMU driver comes online, memory is protected by the PMRs regions
>> requested by the Preamble (pre-launch code) in accordance with Intel TXT
>> specifications and configured by the ACM. The KASLR randomizer will run
>> before the IOMMU driver is able to come online and ensure frames used by the
>> kernel are protected as well as frames that a driver may registered in a BAR
>> are not blocked.
> 
> This seems unfortunate. Presumably we're not able to modify the PMRs at
> this point? This also seems like a potential issue for IOMMU config in
> general - the presumption is that the firmware should be configuring the
> IOMMU in such a way that DMA-capable devices can't attack the firmware
> while we're in the boot environment, and if KASLR is leaving a window
> there then it seems like we'd need to fix that?

While unfortunate, it is a bit of the nature of the problem KASLR is 
attempting to address. If you know in advance where kernel pages are 
going to live and the frames that will be used for DMA, then have you 
not defeated the purpose of the randomization? As for the firmware use 
of the IOMMU, I am fairly certain those tables will get invalidated by 
the ACM when it is setting up the PMRs.

>>>> +It is recommended that no other command line options should be set to override
>>>> +the defaults above.
>>>
>>> What happens if they are? Does doing so change the security posture of
>>> the system? If so, will the measurements be different in a way that
>>> demonstrates the system is in an insecure state?
>>>
>>
>> In an early version of the patch series this was enforced when turning on
>> Secure Launch, but concerns were raised over this approach and was asked to
>> allow the user to be able to shoot themselves in the foot. Overriding these
>> values could render either an insecure state and/or an unstable system.
> 
> If we're in an insecure state, is that something that would show up in
> the form of different measurements?

Yes, you would get a different measurement for the commandline. If you 
are thinking in terms of attestation, I would expect that the 
attestation measurement db would have a record for an acceptable 
commandline and would determine the system to be in an unknown state if 
it did not match.

While the idea could be explored to create measurements based on 
configurations of kernel subsystems, this would likely entail 
instrumentation in those subsystems to assert a measurement to their 
configuration. Maybe IMA could cover something like this? It would 
definitely enable the ability to make deeper assessments about the state 
of a system, but I think this is out of the scope of what Secure Launch 
is attempting to do.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
