Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47507C77B75
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 01:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HDSMeIm5ux1GEll/mIO4x8sSs7uJTTfkkw1ghBbayNs=; b=HDcAZVbNN5uD4Y
	mpm22Apa5O9/ZO3AJ8DIbRmSbMmW5vuiGyuTga1F+clBxNwB66VnjWR0/UrAOIpAKsC7nY+C45fWi
	rnvk/64drmeT34KicvKug8AaSs+kGppOe9E1LfqD5PEPL3VBXQUW78cmwX5x2CtS5xo/mrgtOD2Xy
	39cULPHrDVIwwm4mGVykMxjiS+Qsm9BzbGRZIvuf9TM9s3TY+F281g7nBrhM7scVhUWlOmYmmbt43
	vw4u1198aygVUJ4mK/t4eABsGuCNcRm9AMgjillWGeOfuDGzT1bkYC4KU+sl5pghZcMYlKmWa6eSs
	ZuQvAAm10fRcc3ITdy5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyjcz-0043Yv-2V;
	Tue, 16 May 2023 01:37:25 +0000
Received: from sender3-of-o59.zoho.com ([136.143.184.59])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyjcw-0043Y0-12
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 01:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1684201030; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Yy0QRZ+oR6Hkd+NT/e8HezEouC/r9cI7fIZTIsfsE3AFLWeFTMshlyssYg0GSmMgLvk93s7Dq8nc4WCxEsN2hk9ZkKRYyM/MkGIVO1qPQN4mqtwqViu309itBnJukr3weenNa4pyBnxlTVEUhaTjnLKPkpPv8r2imImUxPWJgt0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1684201030; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=wPx0XuyYch603FQA0x9PPV+o+o1oV0OxjQn+1y5kW1M=; 
	b=X1PFro26OTZHUqTL45decbzBsZ+/MB9mIMeQD0OljOyRdC2VRMGnF1PstQGH9tNnPZuUW9eXSU6sRQLsXBz6JcRR0STbaeX9hHGw1X5rUll5ZwokkRB/0ENry6FGDjjxvfNR/2ISgNQN5EmWx19TMgaLKnxxs/e+YHJ3uFP7F/0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684201030;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wPx0XuyYch603FQA0x9PPV+o+o1oV0OxjQn+1y5kW1M=;
	b=o5ZjTAXLWXJ5TM6YTFoBYPVzf3IFYDZpzH9a0iCG0ZQ63u9v9GzlPiHBelHWBLbP
	1eeiQDTZpmj0nDwXAuMSpdeNTyWHwblSvSkwk8NzVPF18qapT/Wc4R+N3iQV2m7Vx2Y
	W45lSSSOjvLJKg4cC0Jo3VSQO+Ya9n6WR7yzO36o=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1684201029480598.0811292109397; Mon, 15 May 2023 18:37:09 -0700 (PDT)
Message-ID: <b8c96c6b-f50d-1eca-ce6a-8460276c3a13@apertussolutions.com>
Date: Mon, 15 May 2023 21:37:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 13/14] tpm: Allow locality 2 to be set when
 initializing the TPM for Secure Launch
Content-Language: en-US
To: Ross Philipson <ross.philipson@oracle.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 James.Bottomley@hansenpartnership.com, luto@amacapital.net,
 nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-14-ross.philipson@oracle.com>
 <20230512114349.GH14461@srcf.ucam.org>
 <1c17d8e8-1f34-8f11-4265-ddf5e77e3647@oracle.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <1c17d8e8-1f34-8f11-4265-ddf5e77e3647@oracle.com>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_183722_425385_6847C336 
X-CRM114-Status: GOOD (  17.04  )
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

On 5/12/23 12:22, Ross Philipson wrote:
> On 5/12/23 07:43, Matthew Garrett wrote:
>> On Thu, May 04, 2023 at 02:50:22PM +0000, Ross Philipson wrote:
>>> The Secure Launch MLE environment uses PCRs that are only accessible 
>>> from
>>> the DRTM locality 2. By default the TPM drivers always initialize the
>>> locality to 0. When a Secure Launch is in progress, initialize the
>>> locality to 2.
>>
>> This looks correct in itself, but looking at the CRB driver code I don't
>> think locality support is actually implemented. Are there any SL systems
>> using CRB?
> 
> We have never seen a system that supports CRB other than some firmware 
> TPMs that don't work with TXT in the first place. CRB is unexplored 
> territory at this point.

So there is often confusion over the CRB interface. If you ask an ARM 
person, they will describe a door-bell, general purpose memory interface 
that has no support for locality. That interface is described in the 
TCG's Mobile TPM interface. Though there is work in progress to address 
this. Now if you speak with an x86 person, they will describe a 
state-based command-response mechanism using MMIO registers which has 
locality support. That interface is described in the TCG PC Client 
specification.

As to whether there are devices with CRB and TXT. I have seen talk on 
the tboot mailing list that there exist an Intel client devices that has 
an Intel-PTT fTPM using the PC Client CRB interface and Intel-TXT. I 
myself have never seen one, so I could not point you at a SKU/Part No. 
for such a device. If someone has such a device and willing to help, 
drop me a line and I would be glad to work with them to get this tested.

v/r,
dps

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
