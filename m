Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CEEC47422
	for <kexec@archiver.kernel.org>; Mon, 29 Jan 2024 07:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z+ayNgeswuuatl6J6YoAq3Zdo2GD4Uvw/szvH7rFus0=; b=MTyu/iNN1YzQi8
	UZ4qBiNDsF+z1joPfndGQpKNThuT7sUh/tNrItca6pM1V/D7OXqhTUyVVExGVg97/rfORrNMCakSB
	kBHB5nj//t3O7VoksoKf9r0L06/wCOzIL0PW03VNQlfzPkMknquPOcPq4nqdm/qZz+2ceLyapqets
	+CGbtHx+Isj7vQ802fWkY9adG6Skvw2mbKBSgmvPAY/pl6KCFAVwf0c0nmnKZJ9U0NXvIJLK1M80v
	XMuAyL1kcaQmDUdKXUbVJ7SGb/vi//gDTfDTMfUKI1Llj4Xc65w/lh+Pg/33y1pqdq8YTa+/RJ/wB
	LHDPc3GE97Q8Nyvy1ksg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULyI-0000000BbfK-2s8O;
	Mon, 29 Jan 2024 07:22:22 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULyE-0000000BbeI-3g08
	for kexec@lists.infradead.org;
	Mon, 29 Jan 2024 07:22:21 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40ef6c471d5so4944355e9.0
        for <kexec@lists.infradead.org>; Sun, 28 Jan 2024 23:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706512936; x=1707117736; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrgnZOGulcP9tuVmCHC1ajU+ERsd9Badipl3nQjKaNo=;
        b=TWxJcNDS+2PQQRXyjko+uHWG3TypfUoEqsCDh3Av3b7NxtDaajPoPPsTARZycap9uK
         Oq+V2pN0kold8xUdSNpAw+yDnkrMXGeIdB3EeH3GHRxLoVlh+S+98g4idxOCrmSyX7q5
         pyXr8Q5UL/pLviRxK5xM0oHO5C9450oHXK+bIwGL8afQ6s63jt9Z/v/Toezq07VxHyg3
         VIkHB+2tk/ofd16CuDvTAeLXbuzXi27JCOQsKOwyGWNrlyDW54QqvTjyhRvRUdPdbyg+
         dS6DLeIoPt9TkHMmO6v+d5dlzGTnO89Bgpv8wpfZyai1npRm9Y5KrfDh90MrjpFJKe8B
         FwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706512936; x=1707117736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrgnZOGulcP9tuVmCHC1ajU+ERsd9Badipl3nQjKaNo=;
        b=CdMk4Dw89a9RLohk/3Og6ytMxf72RuYrcM2BxKnW78/Vv6FwDdte/lBx4SzOmvKNUP
         GB2MF7kWIdoeV8u+2r3g1H5Y5RVqv54pPWehOChJXXEck8g5CJGnh/zIeGjIOByxxFNP
         xDYl7u2w3AMa2sb8rOx8mCooEB6mYlUeNiLjmzFkk6wYfsUR86HXzkhv1Le31wdSBSMR
         BhDW48+I2svp0K2cuiPLtOt7/yfTaBWCWgEpGT7Cjjin95E+wCtKnmvC3k6LrH8pdRTs
         J6kBCJW0ikGVciF7aResMqZ1x72ba2iahXbXiZJr4u7LRGHX9+FSKuT+xd3A+zAqybhA
         SCmQ==
X-Gm-Message-State: AOJu0Yzd4WrKEUL3ZDdlN7yN2/U7X149sf0+7XAUxutUmS6ER+HLlRov
	DEMKm3Cn+MXDpMrK3AeRd4aisd5nEg6eTCU424wqSF9Jeow8lpbPwDVJv8BzJXs=
X-Google-Smtp-Source: AGHT+IHZDgIWhUn6PpGqUdNjpy0qgdACWGR/C6o14VWBOR70fiJGdJK2I9E3loxNce3mWT4UwH+kIg==
X-Received: by 2002:a05:600c:4f50:b0:40e:93b4:25ef with SMTP id m16-20020a05600c4f5000b0040e93b425efmr5101615wmq.26.1706512935752;
        Sun, 28 Jan 2024 23:22:15 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:cd6b:e8a3:8a4d:4601? ([2a10:bac0:b000:7588:cd6b:e8a3:8a4d:4601])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d69d2000000b003393457afc2sm7224289wrw.95.2024.01.28.23.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 23:22:15 -0800 (PST)
Message-ID: <fed13d3d-c87c-4e5c-9451-779200c35a1c@suse.com>
Date: Mon, 29 Jan 2024 09:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 09/16] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Content-Language: en-US
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
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-10-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240124125557.493675-10-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_232218_962465_0DAD2546 
X-CRM114-Status: GOOD (  10.29  )
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

CgpPbiAyNC4wMS4yNCDQsy4gMTQ6NTUg0YcuLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6Cj4g
QU1EIFNFViBhbmQgSW50ZWwgVERYIGd1ZXN0cyBhbGxvY2F0ZSBzaGFyZWQgYnVmZmVycyBmb3Ig
cGVyZm9ybWluZyBJL08uCj4gVGhpcyBpcyBkb25lIGJ5IGFsbG9jYXRpbmcgcGFnZXMgbm9ybWFs
bHkgZnJvbSB0aGUgYnVkZHkgYWxsb2NhdG9yIGFuZAo+IHRoZW4gY29udmVydGluZyB0aGVtIHRv
IHNoYXJlZCB1c2luZyBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpLgo+IAo+IE9uIGtleGVjLCB0aGUg
c2Vjb25kIGtlcm5lbCBpcyB1bmF3YXJlIG9mIHdoaWNoIG1lbW9yeSBoYXMgYmVlbgo+IGNvbnZl
cnRlZCBpbiB0aGlzIG1hbm5lci4gSXQgb25seSBzZWVzIEU4MjBfVFlQRV9SQU0uIEFjY2Vzc2lu
ZyBzaGFyZWQKPiBtZW1vcnkgYXMgcHJpdmF0ZSBpcyBmYXRhbC4KPiAKPiBUaGVyZWZvcmUsIHRo
ZSBtZW1vcnkgc3RhdGUgbXVzdCBiZSByZXNldCB0byBpdHMgb3JpZ2luYWwgc3RhdGUgYmVmb3Jl
Cj4gc3RhcnRpbmcgdGhlIG5ldyBrZXJuZWwgd2l0aCBrZXhlYy4KPiAKPiBUaGUgcHJvY2VzcyBv
ZiBjb252ZXJ0aW5nIHNoYXJlZCBtZW1vcnkgYmFjayB0byBwcml2YXRlIG9jY3VycyBpbiB0d28K
PiBzdGVwczoKPiAKPiAtIGVuY19rZXhlY19zdG9wX2NvbnZlcnNpb24oKSBzdG9wcyBuZXcgY29u
dmVyc2lvbnMuCj4gCj4gLSBlbmNfa2V4ZWNfdW5zaGFyZV9tZW0oKSB1bnNoYXJlcyBhbGwgZXhp
c3Rpbmcgc2hhcmVkIG1lbW9yeSwgcmV2ZXJ0aW5nCj4gICAgaXQgYmFjayB0byBwcml2YXRlLgo+
IAo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxp
bnV4LmludGVsLmNvbT4KClJldmlld2VkLWJ5OiBOaWtvbGF5IEJvcmlzb3YgPG5pay5ib3Jpc292
QHN1c2UuY29tPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
