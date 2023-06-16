Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE72CEB64D8
	for <kexec@archiver.kernel.org>; Fri, 16 Jun 2023 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QVU4q4ZOQHPcLWoNYdk+rlhBtIIFuYsvR/zulNx2ZJs=; b=4+ao0ogoi7uJkd
	+ttEeXHTplm2/XkJHVzE3bH5Bu3AxcF0AWa5ndJMtw60p79Q4EP0xPJySNf23Exd1stciE98JyEDS
	QEDjZ3xkjOcuP2ifzvPUY/z8JNHZlAKR0LzpNCP5g+MXtEfVqO0xBQi8UWYNPgaA9f2EGdj26GcDT
	0ifprqSb3UwG4ANAUim1zzzEyyjlBztkUUcOPzrwehOXPkO5EPEIPKcJUAplbHlU+EBTunbsSFXeh
	knHx5NqI0ut+11JboyvkOq0Cvqn0KuaG8+Ege0NClh9VEr60XiA7DKO9M/RPZDBIlto7fX2A+GVMo
	IbsT9t+cqFFwREHk5XWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAFdY-001iaW-04;
	Fri, 16 Jun 2023 20:01:36 +0000
Received: from sender4-of-o50.zoho.com ([136.143.188.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAFdV-001iYz-0J
	for kexec@lists.infradead.org;
	Fri, 16 Jun 2023 20:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1686945673; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Aed/zMdm/a0Ego3xS007SykTRZ1uBPGmfiR7ovHozkZZfpquuf+SBMRqy0CxSSJHOQEfehym8UJ2ullyI82ueLw/Oh4CR256DpM6aq0wCm1WwUcsDwqox2LG0Gllruhumjw/bJxYWWjHOFjFCLWcqqdLw9C3jY7RCO8+wOD+TMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1686945673; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=d4POYnDYEYq4KXRMXuAAYuuj2EQrVKJPKhALdERs4yU=; 
	b=NHlsO1vZcYl3mvWCl4Pyt9EfBxVkHNq0gAhH0L1VTcpCDMNuF+WJgaY2UKhzh/8OjM+cnTJzqt80HBwlOv4Y/SzCYMeRcKdGcHHP6CRRaE52mQK7/K115rZlNgfhGMyS7s0QaVcAAHarZFvBrrVXSwyHlE9vs1btcT9/JlvIDis=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686945673;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:From:From:Subject:Subject:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=d4POYnDYEYq4KXRMXuAAYuuj2EQrVKJPKhALdERs4yU=;
	b=sZPVrW+DORFJNiWvzg6tCQUEvK3+up5RgGCEt9nURrHbNLlrQiX+pUzJYY4ks5pX
	ZYV9s/f5b3ylUKE3Iv/VyAP444QANslTUmNgrdHR1il51QR6H3AncpxviBh0b40wTGP
	WGIy1byLFzuekBVvpFoLZM8TVOS4aUfW7Cfbz+a8=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1686945672512692.7552950489951; Fri, 16 Jun 2023 13:01:12 -0700 (PDT)
Message-ID: <eda6da3a-00fe-21c5-5a3d-3e06d21179f4@apertussolutions.com>
Date: Fri, 16 Jun 2023 16:01:09 -0400
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
 <20230504145023.835096-5-ross.philipson@oracle.com>
 <20230512105554.GB14461@srcf.ucam.org>
 <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
 <20230515212206.GA2162@srcf.ucam.org>
 <df9d1260-41dd-034b-9dc6-14173c6c0d25@apertussolutions.com>
 <20230516014310.GA5403@srcf.ucam.org>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
In-Reply-To: <20230516014310.GA5403@srcf.ucam.org>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_130133_183978_0DA7306C 
X-CRM114-Status: GOOD (  15.47  )
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

On 5/15/23 21:43, Matthew Garrett wrote:
> On Mon, May 15, 2023 at 08:41:00PM -0400, Daniel P. Smith wrote:
>> On 5/15/23 17:22, Matthew Garrett wrote:
>>> What if I don't use grub, but use something that behaves equivalently?
>>> Which value should be used here?
>>
>> Generally we would request that the bootloader submit a request to register
>> for a value to be reserved in the spec. That aside, the intent here is to
>> allow for the possibility for the DLE handler to be independent from the
>> bootloader, but this does not have to be this way. If a non-open entity
>> decides to produce their own implementation, they can freely use a
>> unallocated value at their own risk that it could be allocated to another
>> bootloader in the future. Though in this scenario it likely would not matter
>> as the non-open DLE handler would only be present when the non-open
>> bootloader was present.
> 
> Is the expectation that the DLE will always be shipped with the
> bootloader? I think I'm not entirely clear on what's consuming this and
> why.
> 

No, in fact, an early idea proposed by a pair of us in the TrenchBoot 
community was to have it live either as a Runtime Service that was 
loaded by a UEFI app or in the coreboot UEFI payload.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
