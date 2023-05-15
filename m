Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73909C77B7D
	for <kexec@archiver.kernel.org>; Mon, 15 May 2023 21:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rB+lbetGU0mWRA0vj/J33yD5OT76MUPX1PrRQlO+ceA=; b=xhb5MfYC2NHXxU
	/JNSytcOMM2Wr3+30pXzoA46SoqnzXwvORvvrsZ1xZxZ0MecAaFlGvA3ICnT/3I0AXRzv5T39j0Oy
	bk/o549VgeeHroqX+MP/kAQno7vgVetpyIytvjsvYM1jpnkNJhAW0z7bOes561cYtEk1zrh1b0DaF
	Jb11+9x9JZpsNuDlwdK03RfnxKG94WYcEgzOUDPh0bQQTS9JRKlMJC5kKIB/0T/2vj65JxZvHuG18
	J674YVCW/pI6M3P49ZPxMUM/bWe3Y+5mCWJZydzDM36beJE8JPohSLKGYXHJtfwZOjKbxGvoLbhP7
	uplsAV7Iwgs0ddohxB1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyffy-003XfI-0g;
	Mon, 15 May 2023 21:24:14 +0000
Received: from sender4-of-o50.zoho.com ([136.143.188.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyffw-003Xek-0S
	for kexec@lists.infradead.org;
	Mon, 15 May 2023 21:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1684185838; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZIiZUK8CbsCjiTqifI36HGbNwdFEP03mJGK5C8Kha6tVgBHP7kTeDgac2+tm/3XKsbDwlkOFJ/4w8cRPeVL3VnzwjCti5eH0DCyA7nRLJ2JNfQf3waGrN8Im9OQOKRHiOK1HYANwB1hR+/nL++Mh9g4UH04TowwykuQggdzSLmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1684185838; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=J3jOAuTNmPzCg2cyhMylK3GtU6TzEwrGngq9Y/KQJiQ=; 
	b=cnbHjhH3F53ydRLRJExkPQrkix1xEpSDV/QLM4ZhENvB8JWNC30Qi41n8QwfXr1lfHGN/YmMLLMNwyQsTv98sg/0V4f3O+tHQDqhjAIoHYJZ/thkTLADCVHMRTTvyki4fJ4V30mYXdS1uR0cpUEo47jhgIfqJnxd1do0v+cYM9w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684185838;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=J3jOAuTNmPzCg2cyhMylK3GtU6TzEwrGngq9Y/KQJiQ=;
	b=XF+jDcK+OfGZgLIcK5u+YeWep9XEHHVW3HEudShXbrPiGjD416u8N3ktwtum2gO8
	xSPKV0oxzwGtK22V0BdbpwSgPx1tr1Qoh2O3kC8eLgIaZyoZg/aGR/nx+B+DzAORE+R
	bVNcnaWzhPNJytg3mqqDi8s/XkcQS8WIaNwB+E+c=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1684185838046320.453113662738; Mon, 15 May 2023 14:23:58 -0700 (PDT)
Message-ID: <9f0db589-e7b4-09c0-aed2-588b2a2e1bf5@apertussolutions.com>
Date: Mon, 15 May 2023 17:23:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 luto@amacapital.net, nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <20230510012144.GA1851@quark.localdomain>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_142412_226008_74810447 
X-CRM114-Status: GOOD (  16.55  )
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

On 5/9/23 21:21, Eric Biggers wrote:
> On Thu, May 04, 2023 at 02:50:15PM +0000, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The SHA algorithms are necessary to measure configuration information into
>> the TPM as early as possible before using the values. This implementation
>> uses the established approach of #including the SHA libraries directly in
>> the code since the compressed kernel is not uncompressed at this point.
>>
>> The SHA code here has its origins in the code from the main kernel:
>>
>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>>
>> That code could not be pulled directly into the setup portion of the
>> compressed kernel because of other dependencies it pulls in. The result
>> is this is a modified copy of that code that still leverages the core
>> SHA algorithms.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> now?

I think others have commented as to why SHA-1 is provided.

> And if you absolutely MUST use SHA-1 despite it being insecure, please at least
> don't obfuscate it by calling it simply "SHA".

Apologies that it appears that way to you. Typically when referring to 
the family or a subset of the SHA algorithms, SHA-0, SHA-1, SHA-2, and 
SHA-3, it is generally accepted to refer to them as the "SHA 
algorithms". And this is contrasted to the SM algorithms which the TCG 
spec provides for which we have no intentions to support ourselves, 
though others are welcome to contribute.

Again, apologies for misunderstanding and thank you for taking the time 
to review the series.

v/r,
dps


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
