Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4E5C7EE2D
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lS5AeavMatl3Cj4r2viqo+qp5SFq5SJfhoWb8EjcOtc=; b=j76A1/+sg1yEql
	FmJGSmYoHIO0wTTigexC6s940ut2ErouMkNqNGDQGAncO9015hHpAvlMVU//OSyk/vEFrKBBTtRSq
	qxZSgLMZH9OPqRIpMu7LqBLVS20OrzjBDEcFggdB1xFeq3PU8Z2KEAXtKlQ1xEPlQRe15F56AgD2Y
	UXJSucJ7GNlOFa+jOkLJiLqnHjY/LqJ3IieIE+YnbKbAIGy83Eg0ePX7oN0t4mc5IgXqbQrwoe68Z
	kO+FRgfeYRRAkdW5va8oNBl7Vir27WM5h+GmMmAft9OzaKVZjHnCtSFocw2cRQ2oFCeCOE47Pn2WJ
	W7Ii90i7r3Xi4TiXlraQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxSkj-00C1HA-0e;
	Fri, 12 May 2023 13:24:09 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxSkg-00C1GY-22
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 13:24:07 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1683897845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EGpiykIbZrzhClWEawyzh/+46DdyV3m0l/aogql4GLM=;
	b=t4zuosmBFyYyCvcFt4CogxekyLnafjtx8UdgZrID9B7MkOZFFbFZUGHMqQ4w/49f+dprnT
	PlH4xsuf9SnZUOj7+doXTmxlro1g3dwnvALxgbiT8zqrKR4AJUen8DhiEMHG4VUhgD4slv
	C9X56nGsqINm+67cMkF7EU6EiQxHU/23YN7VvK9EXvyfvLTW68S7L4dUwXmA35Ei9TL036
	gu+4asg1Taks0CJq2S+2OB9lkYShGaLJrhnbaqnWk9mEnRuWFWa0Oz6nGQs8cOSPyCJwEi
	c2jvlBPs3mnLU2prsZbpx8tLhNGXy5wbGzwLrxlQo7WZLAontnM3cRvFOEMokA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1683897845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EGpiykIbZrzhClWEawyzh/+46DdyV3m0l/aogql4GLM=;
	b=R8wbDPOZoeZXva36wF885TESy/aZyCr3jMp5vxQyYINiluGTuOY4gRqy+MdP5jxH24QHtN
	tWf4/obwdQJm8xBQ==
To: Matthew Garrett <mjg59@srcf.ucam.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Ross Philipson
 <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org,
 dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, James.Bottomley@hansenpartnership.com, luto@amacapital.net,
 nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
In-Reply-To: <20230512112847.GF14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
Date: Fri, 12 May 2023 15:24:04 +0200
Message-ID: <87pm75bs3v.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_062406_827534_A0A165F8 
X-CRM114-Status: GOOD (  17.55  )
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

On Fri, May 12 2023 at 12:28, Matthew Garrett wrote:
> On Fri, May 12, 2023 at 01:18:45PM +0200, Ard Biesheuvel wrote:
>> On Fri, 12 May 2023 at 13:04, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> >
>> > On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:
>> >
>> > > SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
>> > > now?
>> >
>> > TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also
>> > at the whim of the firmware in terms of whether the SHA-2 banks are
>> > enabled. But even if the SHA-2 banks are enabled, if you suddenly stop
>> > extending the SHA-1 banks, a malicious actor can later turn up and
>> > extend whatever they want into them and present a SHA-1-only
>> > attestation. Ideally whatever is handling that attestation should know
>> > whether or not to expect an attestation with SHA-2, but the easiest way
>> > to maintain security is to always extend all banks.
>> >
>> 
>> Wouldn't it make more sense to measure some terminating event into the
>> SHA-1 banks instead?
>
> Unless we assert that SHA-1 events are unsupported, it seems a bit odd 
> to force a policy on people who have both banks enabled. People with 
> mixed fleets are potentially going to be dealing with SHA-1 measurements 
> for a while yet, and while there's obviously a security benefit in using 
> SHA-2 instead it'd be irritating to have to maintain two attestation 
> policies.

Why?

If you have a mixed fleet then it's not too much asked to provide two
data sets. On a TPM2 system you can enforce SHA-2 and only fallback to
SHA-1 on TPM 1.2 hardware. No?

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
