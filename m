Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CE1C4167D
	for <kexec@archiver.kernel.org>; Mon, 13 Nov 2023 23:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bcCUnGj44xWw1ydzuL2492rsW0lUPMrw7ZsOATQRl5s=; b=1USBSA95a+SVv2
	L6eOEYfSRdWmYfTQS+IyOUeQU6aB5KQnYRtE7b17ipD4vPnYVY4VOaFytc+UypCH4GYywIPbp+hPm
	4WgUfx2eY3bqKgAOfoVAZqeJcJHuRG92VHQ+wJx1pjM1yQ4m8365D1xNJNTSDKBpnhIHl+wN+/cse
	n+RWb6mJ7uTC6sAlUf/z/ReaNGIujgtuhQQdjDh8QBNeHqSM2UDObDFin3cpv7/pUxlaVtQfejkyl
	q+qcQY16iydVMg0iYCFUFmoOuYQbTZ/8vRJw47Ich0Nkz8D3Qd2roCmSWEt1KMUTWGXrJIA5UgaoB
	LW7xddzEhnSYpY2QOGWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2gFT-00Erxu-36;
	Mon, 13 Nov 2023 23:21:43 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2gFQ-00Erwz-3B
	for kexec@lists.infradead.org;
	Mon, 13 Nov 2023 23:21:42 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c788f5bf53so53944461fa.2
        for <kexec@lists.infradead.org>; Mon, 13 Nov 2023 15:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1699917698; x=1700522498; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16UHKTiJBBdygB3NDxQg1vSNAYLocg/Q+/o22+Gc4VM=;
        b=DX8xsnTHfLO3xDZdAiplwsPCpxrsFrwUVn/6L7mhI+6Ila4FEslYYo5oxbVr6oMNIi
         4qqfulecLq4TQqIaI1khAe2TGE0A3UAO6Jt1xjJR0bUC57fqf11Gg73/6ZPSHjSYBRVn
         vbQiyjeH0pADsc62XpaKY7ap4+ooDZedlyZUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699917698; x=1700522498;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16UHKTiJBBdygB3NDxQg1vSNAYLocg/Q+/o22+Gc4VM=;
        b=cox0tBmHblVMMGAWdY3dWR/zLTRPypcljg2n7rm/pdnMNw46QnDmZMHIj4t+p7GA9J
         5MOgPmDPs/4aTyyVDqg4WzawC9yUc+k2qt8Ilpj/jDyQTM6T6MapVZL/Om5Sc8DAB678
         BZn/9R+Vl1dh5l8POb+Uoq2Cm4ZFEmpZv6pTViAqf2n1OEKgdagkGYaqJm8xvyZsIKFe
         Ddp8MGalnOy67zwc5afD65E/dFdXM6KC4eLwNWvrk1/iqHbnxgjYETkyxahwgTjV1Yqc
         rs8TF67EhuuelQKYHQoxxzNc1ZSgF0YVVfJzF0QAfsydccykJCTplFk3PUEg8/XoMPCp
         95Aw==
X-Gm-Message-State: AOJu0YwXxnNNUd8c1vY55rO0UmP0vAnXhGJwiZpQQ0GoQavh0EStkOSD
	HUXwdPnr3V/s+/sZiKwZ55yw0w==
X-Google-Smtp-Source: AGHT+IEFbywTuiCM3Qsf46VdvQGP+jWzn8QiLDib6v40aY/R+2Y0qrS+3M5SUqyMVbx0tvNqsu2OdA==
X-Received: by 2002:a2e:3602:0:b0:2c5:623:aa01 with SMTP id d2-20020a2e3602000000b002c50623aa01mr436845lja.49.1699917697666;
        Mon, 13 Nov 2023 15:21:37 -0800 (PST)
Received: from [172.25.82.51] ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id v4-20020ac87284000000b0041eef6cacf4sm2262161qto.81.2023.11.13.15.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 15:21:37 -0800 (PST)
Message-ID: <8703f1a9-5d4d-4c5a-b9aa-3b31ad2dcd41@citrix.com>
Date: Mon, 13 Nov 2023 23:21:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org,
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 luto@amacapital.net, nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20231110222751.219836-1-ross.philipson@oracle.com>
 <20231110222751.219836-7-ross.philipson@oracle.com>
 <20231111174435.GA998@sol.localdomain>
 <a16d44c5-2e1a-4e9a-8ca1-c7ca564f61cd@citrix.com>
 <87f56530b85ea894036a74be1824d6f2716f70de.camel@HansenPartnership.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <87f56530b85ea894036a74be1824d6f2716f70de.camel@HansenPartnership.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231113_152141_236847_DC2D63EB 
X-CRM114-Status: GOOD (  16.69  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMTEvMTEvMjAyMyA4OjM2IHBtLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6Cj4gT24gU2F0LCAy
MDIzLTExLTExIGF0IDE4OjE5ICswMDAwLCBBbmRyZXcgQ29vcGVyIHdyb3RlOgo+PiBPbiAxMS8x
MS8yMDIzIDU6NDQgcG0sIEVyaWMgQmlnZ2VycyB3cm90ZToKPj4+IE9uIEZyaSwgTm92IDEwLCAy
MDIzIGF0IDA1OjI3OjQ0UE0gLTA1MDAsIFJvc3MgUGhpbGlwc29uIHdyb3RlOgo+Pj4+IMKgYXJj
aC94ODYvYm9vdC9jb21wcmVzc2VkL2Vhcmx5X3NoYTEuY8KgwqAgfCAxMiArKysrCj4+Pj4gwqBs
aWIvY3J5cHRvL3NoYTEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgODEKPj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiBJdCdzIHN1cnByaXNp
bmcgdG8gc3RpbGwgc2VlIHRoaXMgbmV3IHVzZSBvZiBTSEEtMSBhZnRlciBzbyBtYW55Cj4+PiBw
ZW9wbGUgb2JqZWN0ZWQgdG8gaXQgaW4gdGhlIHY2IHBhdGNoc2V0LsKgIEl0J3MgYWxzbyBmcnVz
dHJhdGluZwo+Pj4gdGhhdCB0aGUgU0hBLTEgc3VwcG9ydCBpcyBzdGlsbCBiZWluZyBvYmZ1c2Nh
dGVkIGJ5IGJlaW5nIGNvbWJpbmVkCj4+PiBpbiBvbmUgcGF0Y2ggd2l0aCBTSEEtMiBzdXBwb3J0
LCBwZXJoYXBzIGluIGFuIGF0dGVtcHQgdG8gY29uZmxhdGUKPj4+IHRoZSB0d28gYWxnb3JpdGht
cyBhbmQgYXZvaWQgaGF2aW5nIHRvIGdpdmUgYSByYXRpb25hbGUgZm9yIHRoZQo+Pj4gaW5jbHVz
aW9uIG9mIFNIQS0xLsKgIEZpbmFsbHksIG5ldyBmdW5jdGlvbnMgc2hvdWxkIG5vdCBiZSBhZGRl
ZCB0bwo+Pj4gbGliL2NyeXB0by9zaGExLmMgdW5sZXNzIHRob3NlIGZ1bmN0aW9ucyBoYXZlIG11
bHRpcGxlIHVzZXJzLgo+PiBUaGUgcmF0aW9uYWwgd2FzIGdpdmVuLsKgIExldCBtZSByZWl0ZXJh
dGUgaXQuCj4+Cj4+IFRoZXJlIGFyZSByZWFsIFRQTXMgaW4gdGhlIHdvcmxkIHRoYXQgY2FuJ3Qg
dXNlIFNIQS0yLsKgIFRoZSB1c2Ugb2YKPj4gU0hBLTEgaXMgbmVjZXNzYXJ5IHRvIHN1cHBvcnQg
RFJUTSBvbiBzdWNoIHN5c3RlbXMsIGFuZCB0aGVyZSBhcmUKPj4gcmVhbCB1c2VycyBvZiBzdWNo
IGNvbmZpZ3VyYXRpb25zLgo+IEdpdmVuIHRoYXQgVFBNIDIuMCBoYXMgYmVlbiBzaGlwcGluZyBp
biBidWxrIHNpbmNlIFdpbmRvd3MgMTAgKDIwMTUpCj4gYW5kIGlzIHJlcXVpcmVkIGZvciBXaW5k
b3dzIDExICgyMDIxKSwgYXJlIHRoZXJlIHJlYWxseSBzdWNoIGh1Z2UKPiBudW1iZXJzIG9mIFRQ
TSAxLjIgc3lzdGVtcyBpbnZvbHZlZCBpbiBzZWN1cml0eSBmdW5jdGlvbnM/CgpZZXMuCgpBcyBl
dmVyLCBpdCdzIG5vdCBhcyBzaW1wbGUgYXMgYSBzdHJhaWdodCBUUE0gdmVyc2lvbiBpc3N1ZS4K
CkFNRCdzIGZpcm13YXJlLVRQTTIgaXNuJ3QgY29tcGF0aWJsZSB3aXRoIHRoZWlyIERSVE0gaW1w
bGVtZW50YXRpb24uwqAKVXNlcnMgYXJlIGxpbWl0ZWQgdG8gd2hhdGV2ZXIgaGVhZGVycyBhcmUg
YXZhaWxhYmxlIG9uIHRoZSBtb3RoZXJib2FyZC4KCkZ1cnRoZXJtb3JlLCBldmVuIHdpdGggYSBU
UE0yLCBpdCBpcyB0aGUgZmlybXdhcmUgKEludGVsIFRYVCBBQ00pIG9yCmhhcmR3YXJlIChBTUQg
U0tJTklUKSB3aGljaCBjaG9vc2VzIHRoZSBoYXNoIGFsZ29yaXRobXMgdG8gdXNlLCBhbmQgaW4g
YQpsb3Qgb2YgY2FzZXMgdGhlIGVuZCB1c2VyIGRvZXNuJ3QgZ2V0IGEgY2hvaWNlLgoKU28geWVz
IC0gdGhlcmUgcmVhbGx5IGFyZSBtb2Rlcm4gc3lzdGVtcyB3aGljaCB5b3UgY2FuJ3QgdXNlIFNI
QS0yLW9ubHkKd2l0aC4KCj4+IERSVE0gd2l0aCBTSEEtMS1vbmx5IGlzIGEgZGFtbnNpZ2h0IGJl
dHRlciB0aGFuIG5vIERUUk0sIGV2ZW4gaWYgU0hBLQo+PiAxIGlzIGdldHRpbmcgYSBsaXR0bGUg
bG9uZyBpbiB0aGUgdG9vdGguCj4gVGhhdCdzIG5vdCB0aGUgcHJvYmxlbS4gIFRoZSBwcm9ibGVt
IGlzIHRoYXQgc2hhMSBpcyBzZWVuIGFzIGEKPiBjb21wcm9taXNlZCBhbGdvcml0aG0gYnkgTklT
VCB3aGljaCBiZWdhbiBkZXByZWNhdGluZyBpdCBpbiAyMDExIGFuZCBpcwo+IG5vdyByZXF1aXJp
bmcgaXQgdG8gYmUgcmVtb3ZlZCBmcm9tIGFsbCBzeXN0ZW1zIHN1cHBsaWVkIHRvIHRoZSBVUwo+
IGdvdmVybm1lbnQgYnkgMjAzMAoKVGhpcyBpcyBhIG5vbi1pc3N1ZS4KClBlb3BsZSB3aG8gY2Fy
ZSBhYm91dCBoYXZpbmcgbm8gU0hBLTEgY2FuIG5vdCBjb21waWxlIGluIERSVE0gc3VwcG9ydC4K
CkJ1dCB0aGVyZSBhcmUgcGVvcGxlIHdobyB3aWxsIHRvbGVyYXRlIFNIQS0xIGNvZGUgdG8gZ2V0
IERUUk0gc3VwcG9ydC4KCn5BbmRyZXcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
