Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0D0C54798
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FGdRPX0wHrUgry76knSoMCyjOVYn43PFMndCb+O5p2s=; b=mBdfIee388QMgS
	J4M0TxKpv9Lzq/7PgqGSWV7qcR3PvKsKEnoCnlAkLzgXcuRwmOLvNdXIul7DgMeaaI2dDRhHLhqTi
	FS62Nz6hBqDxZQtKsmCecF6GfEHMWL6NwEl9cFnFPB18sEB551dSK5qn/ndkBKFhsTwdUCjuXiXyZ
	el/UtMAXcn0T11v3v89114S51VyWM06ddZB+ZC6sJk59AzsgCcxNWsau9GhjHCwZGCbdzFsYiTI3v
	v7MvbvQijbVnMbSxiMbXbbWhlVqn5AexEYn/NReYt/lv2b6tDNVZ94edrDMMRDedAKGXqtpc74y0t
	9fNIvCz3MRP5tl9JMINg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdaBc-0000000AnYb-2LfW;
	Fri, 23 Feb 2024 18:22:16 +0000
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdaAC-0000000AnLQ-0HoA
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 18:20:52 +0000
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2d220e39907so17691981fa.1
        for <kexec@lists.infradead.org>; Fri, 23 Feb 2024 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708712432; x=1709317232; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=782AoGpCOecehLZVMZnBvSEhsvxprPEXEJFDkKEsL78=;
        b=AsM7GeE6dz+6YvKb8Zv6pfMi6BE21PtPDlvsXpHBdb/5XW7U0L0hKgKGTtYbM81hct
         X8k0NJfICdmKwCyqt2SGlfl3we9qdfZMmE31tw6QF1duYDoK87MhK96ZPZOsLgxd9xZM
         YN+/lD7QftU9zqainYn5I+0/sWs5K1OdoHQDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708712432; x=1709317232;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=782AoGpCOecehLZVMZnBvSEhsvxprPEXEJFDkKEsL78=;
        b=KJ95MyJHYkmdkSH1XM9ovjEV2OModLKzSp4wcB6cEY6PPVj8/jx+46x7amwerRL48F
         tQRcNSXe6Lzq0aV+Z+TUP7Y/PmpOtPGLbg9FHAewkaAoyGv+D6qHXLfYVWaB3oFG0JCU
         Q8w2bWYUjOvQCFVTfpzTsSnkh595vF1d6WTJg9aZt1oyfvz6nGbVYgu/G6/tvAh715m4
         Cs1NBAUfRJN+gIx/2jRYKBbpuyiFSr4bPAfz/re1+bCv2MCr9gOWjtK10v9II2GSux2c
         MqDALfitBCBupHxbh2ha39fgYtWo2ngQIYQhNisM3TuBEFDjBRnOxtDqxhBggUUVvRPU
         w4ag==
X-Forwarded-Encrypted: i=1; AJvYcCWZeq5kuzLNLAWumlWpyXY4DmMJehQK/H6sbtUgn4lvew6rXmMY0X7ME7726Dc+FDJYfvsM7gb62oBtSxZWen2YFD2w+xDs+12g
X-Gm-Message-State: AOJu0YxGFaFRBjEiXRIbgW38BnZ8NYyarxJTFmu5/rJcZYRMhQmOsy6x
	6JNX/2NTmMAjlTwcjaZ9ENoh1jIutrxJbPy/uRSQ5X0DtPLvl30MQU2P69mPZAQ=
X-Google-Smtp-Source: AGHT+IGKmGhyIU5gJMZF27bTWRBFQ/Y1UUW5pP7G5WcYyHm4U94/AXfI5Wnt6LhdlWi2bRhTqlu5sg==
X-Received: by 2002:a2e:9052:0:b0:2d2:6227:d30b with SMTP id n18-20020a2e9052000000b002d26227d30bmr404964ljg.47.1708712431810;
        Fri, 23 Feb 2024 10:20:31 -0800 (PST)
Received: from [10.80.67.149] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id p19-20020a05620a22f300b00785ccbb457esm1393327qki.81.2024.02.23.10.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 10:20:31 -0800 (PST)
Message-ID: <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com>
Date: Fri, 23 Feb 2024 18:20:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To: Eric Biggers <ebiggers@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com>
 <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
 <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
 <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
 <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>
 <20240223175449.GA1112@sol.localdomain>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240223175449.GA1112@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_102048_603145_4452D119 
X-CRM114-Status: GOOD (  12.41  )
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

T24gMjMvMDIvMjAyNCA1OjU0IHBtLCBFcmljIEJpZ2dlcnMgd3JvdGU6Cj4gT24gRnJpLCBGZWIg
MjMsIDIwMjQgYXQgMDQ6NDI6MTFQTSArMDAwMCwgQW5kcmV3IENvb3BlciB3cm90ZToKPj4gWWVz
LCBhbmQgSSBhZ3JlZS7CoCBXZSdyZSBub3QgbG9va2luZyB0byB0cnkgYW5kIGZvcmNlIHRoaXMg
aW4gd2l0aAo+PiB1bmRlcmhhbmQgdGFjdGljcy4KPj4KPj4gQnV0IGEgYmxpbmQgIm5hY2sgdG8g
YW55IFNIQS0xIiBpcyBzaW1pbGFybHkgZGFtYWdpbmcgaW4gdGhlIG9wcG9zaXRlCj4+IGRpcmVj
dGlvbi4KPj4KPiBXZWxsLCByZXZpZXdlcnMgaGF2ZSBzYWlkIHRoZXknZCBwcmVmZXIgdGhhdCBT
SEEtMSBub3QgYmUgaW5jbHVkZWQgYW5kIGdpdmVuCj4gc29tZSB0aG91Z2h0ZnVsIHJlYXNvbnMg
Zm9yIHRoYXQuICBCdXQgYWxzbyB0aGV5J3ZlIGdpdmVuIHN1Z2dlc3Rpb25zIG9uIGhvdyB0bwo+
IG1ha2UgdGhlIFNIQS0xIHN1cHBvcnQgbW9yZSBwYWxhdGFibGUsIHN1Y2ggYXMgc3BsaXR0aW5n
IGl0IGludG8gYSBzZXBhcmF0ZQo+IHBhdGNoIGFuZCBnaXZpbmcgaXQgYSBwcm9wZXIganVzdGlm
aWNhdGlvbi4KPgo+IEFsbCBzdWdnZXN0aW9ucyBoYXZlIGJlZW4gaWdub3JlZC4KClRoZSBwdWJs
aWMgcmVjb3JkIGRlbW9uc3RyYXRlcyBvdGhlcndpc2UuCgpCdXQgYXJlIHlvdSBzYXlpbmcgdGhh
dCB5b3UnZCBiZSBoYXBweSBpZiB0aGUgY29tbWl0IG1lc3NhZ2UgcmVhZApzb21ldGhpbmcgbW9y
ZSBsaWtlOgoKLS0tODwtLS0KRm9yIGJldHRlciBvciB3b3JzZSwgU2VjdXJlIExhdW5jaCBuZWVk
cyBTSEEtMSBhbmQgU0hBLTI1Ni4KClRoZSBjaG9pY2Ugb2YgaGFzaGVzIHVzZWQgbGllIHdpdGgg
dGhlIHBsYXRmb3JtIGZpcm13YXJlLCBub3Qgd2l0aApzb2Z0d2FyZSwgYW5kIGlzIG9mdGVuIG91
dHNpZGUgb2YgdGhlIHVzZXJzIGNvbnRyb2wuCgpFdmVuIGlmIHdlJ2QgcHJlZmVyIHRvIHVzZSBT
SEEtMjU2LW9ubHksIGlmIGZpcm13YXJlIGVsZWN0ZWQgdG8gc3RhcnQgdXMKd2l0aCB0aGUgU0hB
LTEgYW5kIFNIQS0yNTYgYmFja3MgYWN0aXZlLCB3ZSBzdGlsbCBuZWVkIFNIQS0xIHRvIHBhcnNl
CnRoZSBUUE0gZXZlbnQgbG9nIHRodXMgZmFyLCBhbmQgZGVsaWJlcmF0ZWx5IGNhcCB0aGUgU0hB
LTEgUENScyBpbiBvcmRlcgp0byBzYWZlbHkgdXNlIFNIQS0yNTYgZm9yIGV2ZXJ5dGhpbmcgZWxz
ZS4KLS0tCgo/Cgp+QW5kcmV3CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
