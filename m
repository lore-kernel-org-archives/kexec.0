Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EECC77B7F
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 18:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lFJzs37h+aJYN4o+zqzFoWf0n6KTEkfuvvOEknjdTrA=; b=v1b07eljrNy6ti
	2hNRGEfN32Bw5HTtikmJtROPwTILsq1KdSlwl4KcVR9fqQNUBeMqfjGLej9KSS0iZSNO5NhljsMzK
	p6wq/Gd8gnwghD8ABV8k1wM2RTkJocc7FztAGNKDbtbfdNs7tFlieWqxrV+dg2+f2ZQHtuVa/25Mv
	MHxPaYMm0o4woxHJ8gHE8l/EM40fZbLiQZ8PhiingML8DdTaoYbGqX3ffR3efTucKwKc07x/ra+5f
	5vx79810VX39ZEXBfCAd/wtDta7T+QwVVyeYD0Cm7PaJ1QGOXC1JoruajPhQSD5Oy5mXDaSySShRY
	rD5ugD0WX3ETg4+6pvuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxXKY-00Cezb-33;
	Fri, 12 May 2023 18:17:26 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxXKW-00Ceyg-0F
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 18:17:25 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1683915442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrXy+JN0FIVOyWDkqWfN4fNFGJKhfjsBfYB8oPd1Irc=;
	b=Y1yV+uoB6fx9Yhns9dAWVlJGWQcpCyKUdFqEJpQFLS+uZwOmtwgY1IB7cCtCgtxfmPGM1E
	RHrqBI7OIhWNpaJ+CT1K/m6a4VffRvAuFtfHtrg7DktrfeG+F9YVJHF7UonTQXVwvcsBl6
	fwWaMINw9X4exjYSkh7wAm8lwsDrh0WOQX+mbJOdD265nOu21snUkPIxGI0rNIX+vxZ0tL
	X+l8YlFUwQAgRpK9HF7mCTycfV9zp1QIHWgo2bUoyfvj1OMI4jvyn6K01GFgbQtASecGVq
	79hQECeceglkJFJGCFpuG4MjTbxbTos+68fX3FuBrYHE2tg11v8+D1uwq2vfww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1683915442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrXy+JN0FIVOyWDkqWfN4fNFGJKhfjsBfYB8oPd1Irc=;
	b=jDQpibUvU/KTnZJH0KZt1sWuLoNTBcIE9OnnjHaZumYLz9yLuYhZiNO6B97Xnp9pWJX6Gc
	vTJozK43qwl7qIBw==
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, James.Bottomley@hansenpartnership.com,
 luto@amacapital.net, nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
In-Reply-To: <20230512161318.GA18400@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org> <87pm75bs3v.ffs@tglx>
 <20230512161318.GA18400@srcf.ucam.org>
Date: Fri, 12 May 2023 20:17:21 +0200
Message-ID: <873541bej2.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_111724_254863_36630831 
X-CRM114-Status: GOOD (  13.63  )
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

On Fri, May 12 2023 at 17:13, Matthew Garrett wrote:
> On Fri, May 12, 2023 at 03:24:04PM +0200, Thomas Gleixner wrote:
>> On Fri, May 12 2023 at 12:28, Matthew Garrett wrote:
>> > Unless we assert that SHA-1 events are unsupported, it seems a bit odd 
>> > to force a policy on people who have both banks enabled. People with 
>> > mixed fleets are potentially going to be dealing with SHA-1 measurements 
>> > for a while yet, and while there's obviously a security benefit in using 
>> > SHA-2 instead it'd be irritating to have to maintain two attestation 
>> > policies.
>> 
>> Why?
>> 
>> If you have a mixed fleet then it's not too much asked to provide two
>> data sets. On a TPM2 system you can enforce SHA-2 and only fallback to
>> SHA-1 on TPM 1.2 hardware. No?
>
> No, beause having TPM2 hardware doesn't guarantee that your firmware 
> enables SHA-2 (which also means this is something that could change with 
> firmware updates, which means that refusing to support SHA-1 if the 
> SHA-2 banks are enabled could result in an entirely different policy 
> being required (and plausibly one that isn't implemented in their 
> existing tooling)

It's not rocket science to have both variants supported in tooling,
really.

What a mess.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
