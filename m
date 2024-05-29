Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C51C27C43
	for <kexec@archiver.kernel.org>; Wed, 29 May 2024 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZIlZRzVLAjdoVx5RZ3V6CEuZZqkjfS2TTlKPJZ7DChQ=; b=Jj+IjV/415MMNC
	X+EiY3gk7CiC2Ga9Z3Poi6sbJK8cFaZu60qiiV9aDv4//+FQymiR6ASCsN7WQXi+5jdFMpvQPJx5o
	HyGuFGNTkCF/zpbx5LbEjrXz8HoQTXt/X3dvaggXXlx3Ca7TkubLCtlRO3T46zt86U6CC9BhfiU/c
	Cof0s9WY9CFQFHw/vrM499yifIFXAE4IASG6rEIXmLt4XDQOU4xP8XRSYu2WyHTq2iFgGqRUmtet4
	LCbCpAqLU8tU47oE9kMp3I9Jn/gOLOhFQ/ybXOqdGYrHUv5wnf+DhDKUZUjHZyB7F9ml/hjcSQ85k
	MisrpmaBDmIjemzWi+Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCHeg-00000003ylL-0XJN;
	Wed, 29 May 2024 11:39:42 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCHed-00000003yk5-0pKV
	for kexec@lists.infradead.org;
	Wed, 29 May 2024 11:39:40 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-420180b5922so22936425e9.2
        for <kexec@lists.infradead.org>; Wed, 29 May 2024 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716982776; x=1717587576; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EdFeXZ0iZQwHyJpJ9sEUFEvxz5pnqM5Lhk7k33g54Ts=;
        b=UDt41plNiWO/yHBEuqTsflMRJRBfudMhCHnnoyVegkA06ViNyQjgQH8lnYaoF9VvfQ
         mPasxD48TUWjDy8pMq33lFgRBSWF+pH3VNaufqW/agXLxagveMF39JmFDCE0tePgKVsu
         vQsmAuwETEgqmElnNUprSY6sVzAlTbIu0XGyKdPFH5d0nxzCuAycrzaB/XrG6Hskr4eg
         SXBO8oWx8mu96nf50FuZGM1i5XrqS72p0B7XUm1UH7Bl6YjQylXasjmULVEPefm+2yu4
         6OCNYXADYk2EHvluvqwZaJnRjcoD+qJQc0KnAQJE2xTSgJpqjFIpRnFF0LYl6Hx6aTVD
         AooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716982776; x=1717587576;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdFeXZ0iZQwHyJpJ9sEUFEvxz5pnqM5Lhk7k33g54Ts=;
        b=IRf/iiSOG5CrdeJtX846dGPdhiJd1wJS5iPLjd/z2N5uIxRGqfdCvozR62Z7m9Bvkg
         IoZC4sLDng0URTq6Fk0+AVY3r4LK/sZ7VSF6+TXVzeQXgNHVjBRHcGlHuyTG+Ig1gD/g
         LqBpk5q/lIaL9nnwCkAF3MjGLg4B7oE5iwtkqMIvrC2mK0UpZXyWug6OA1Ee+OCHih2N
         1mpNP7qx8qCDaN2oulhzO4FmFTFtO3OOG24xaIM/5q6HR1UcltfbHHNFUgHlBjo7mNVS
         fQ9EqhMKLhOelTzBh67N6hJcsECaX854zFUFa+xgAeBlc2M86j73Q0TYfiar0jwNV1PX
         mLNA==
X-Forwarded-Encrypted: i=1; AJvYcCWIR+2D8UlTMNuY45lDPX8HrWs+d8olllO6eXFmF0J2IT5DAc/fnfGcIfaWN0DfRjKuxUROp98bR/M+TTKzIt3SigA5pXhM+VfJ
X-Gm-Message-State: AOJu0YysTq0NOAziikCUJrNf5eoyz7dyRdUIB+tXwG8+6m8OlA/kveB1
	xwrKVM2yb3WpxbyfK5C3M+WX0zhoWmVjacbNZfmr4H3zR021VH5LwTjsDMCn8Oo=
X-Google-Smtp-Source: AGHT+IGhbyPCV7mhFEb+wa2zxVQsRfFFyIuyAeyXPnnporhcsU+et7sVZoAC9sjK3Qz8qHTU2qJsiQ==
X-Received: by 2002:a5d:62cc:0:b0:354:d098:8d67 with SMTP id ffacd0b85a97d-3552fe179a1mr12680946f8f.57.1716982776439;
        Wed, 29 May 2024 04:39:36 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:ca17:8dd8:7313:d6fd? ([2a10:bac0:b000:5de0:ca17:8dd8:7313:d6fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c93a5sm14633282f8f.70.2024.05.29.04.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 04:39:36 -0700 (PDT)
Message-ID: <46ddc54e-f7bb-4de3-b311-faee12e5a6b9@suse.com>
Date: Wed, 29 May 2024 14:39:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-7-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240528095522.509667-7-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_043939_324004_96875190 
X-CRM114-Status: UNSURE (   8.77  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiAyOC4wNS4yNCDQsy4gMTI6NTUg0YcuLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6Cj4g
VERYIGd1ZXN0cyBydW4gd2l0aCBNQ0EgZW5hYmxlZCAoQ1I0Lk1DRT0xYikgZnJvbSB0aGUgdmVy
eSBzdGFydC4gSWYKPiB0aGF0IGJpdCBpcyBjbGVhcmVkIGR1cmluZyBDUjQgcmVnaXN0ZXIgcmVw
cm9ncmFtbWluZyBkdXJpbmcgYm9vdCBvcgo+IGtleGVjIGZsb3dzLCBhICNWRSBleGNlcHRpb24g
d2lsbCBiZSByYWlzZWQgd2hpY2ggdGhlIGd1ZXN0IGtlcm5lbAo+IGNhbm5vdCBoYW5kbGUgaXQu
Cj4gCj4gVGhlcmVmb3JlLCBtYWtlIHN1cmUgdGhlIENSNC5NQ0Ugc2V0dGluZyBpcyBwcmVzZXJ2
ZWQgb3ZlciBrZXhlYyB0b28gYW5kCj4gYXZvaWQgcmFpc2luZyBhbnkgI1ZFcy4KPiAKPiBUaGUg
Y2hhbmdlIGRvZXNuJ3QgYWZmZWN0IG5vbi1URFgtZ3Vlc3QgZW52aXJvbm1lbnRzLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4Lmlu
dGVsLmNvbT4KClJldmlld2VkLWJ5OiBOaWtvbGF5IEJvcmlzb3YgPG5pay5ib3Jpc292QHN1c2Uu
Y29tPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
