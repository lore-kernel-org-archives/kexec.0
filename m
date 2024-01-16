Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB406C47077
	for <kexec@archiver.kernel.org>; Tue, 16 Jan 2024 08:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Ev3T87rafHFtU3NJYMvpMSPjc9V0Jn0LLmR4DmQONk=; b=t20VDFA3s5Sw/5
	vB7SLp5VTeLbNgIpKCUWYpEdqitVNsUBeA750MtztpUKlgalfK6mzGJWCSkfWMKJ6Vf3vU5V4pNQK
	0W6V2EUFOI4r/JLv1XbkCi2UAStWnDeqnnxB5IvUB5FsV6RiJySOBifHidv4VrTj3GWRA5hpcOB0Z
	mu/1Z10tAiE8JVAHBOn/4ZpZU7Yl8ul8Lwzym4DcQoVyHz7Zcdf5cVlu070iaddlOcFsBP3PXkIYX
	l4rMoKXBUou4f9SYCoPxoP8+n1kWmidk8ubrvUapQMtq5Vn1tRJjiuoROjDnHRXO5JFyMRd897aM1
	vfhah1GqdVQMw3vOjB/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPeOR-00BLFG-0C;
	Tue, 16 Jan 2024 08:01:55 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPeON-00BLD0-1q
	for kexec@lists.infradead.org;
	Tue, 16 Jan 2024 08:01:54 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40e866389feso77685e9.1
        for <kexec@lists.infradead.org>; Tue, 16 Jan 2024 00:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705392109; x=1705996909; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbsGWmQ361n86fqb5EvED9myRmOjNXMpdIrnq7x3pKk=;
        b=OfQKWh84Ndccuhrnu1COr/2Zk06cz4/IrGlRF1pJMpw5hM6HCWY9Z/kyQ9MdSe9N3C
         TNkLaSTsoms0p/fA9RT5hyl/NYOWl8RafQAkMqFZoEKC6IStIGb3n7v+5jKFqk8VUbRE
         +TvKVnUdN6N+9wbWF3HED5c7KPW2kJAcGK0SAy72zpWxHpVz5QcJ5/Q0QziuJqLxBNU/
         sGiIBuP7z+nnipR6659vEVstxIYUaShqgL89N41JcNl84aA5+8b58ChMA6Zcu/W9nySQ
         W1qBsGUUbELZWZ2a2phhwDkOyNX6lux56cwOrq6jqFiv5jYjeEKCKKgYBmj7Fb9snDE2
         KtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705392109; x=1705996909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbsGWmQ361n86fqb5EvED9myRmOjNXMpdIrnq7x3pKk=;
        b=HqyzMVbqZ2DD8a+vRBuzChIPHGHY7M+dhHjGLr3QDJOAZwnObT9yzkaVYZ67O612ZI
         Qx50gcm0ILxarbKskG+Kt69LLxiwP7bI55g36Xl1iYNmV5bQWokqtLsKwDuyFiaDJL8o
         obXv8+td+FsG+eGIdo5fFdpKwiWuA182qO2/QbaelBtHbr6qpGpKtu7xPLVvk/wYfs5g
         GBsMpWq1rvoalbzHn1X75wvhEuqoKyVHofxoEX9xjL+i/QXiQjWn5qWbwgP3XZitm3HK
         YgvhF9DtM/CP0ZrWkjqEO1AXecVBSNMEBeVgNDY3RZoT7W+ofDYFOf4EaqVphHl4rUor
         aTEw==
X-Gm-Message-State: AOJu0Yx6hdcOMwFBqMR4X5ARcRdy2gMhk2PVWW8sGMI1ZDFIqVjpdX7F
	fljsTShPY5nKZfu5HzIy4q80RQ4IQU6ZHQ==
X-Google-Smtp-Source: AGHT+IHEVDR57nCdsQnrgKWaiuwI6BrlBa+3Gafle4OC07B48/FwRJh/R2OQX6PrvQsuocnkYYxPDw==
X-Received: by 2002:a05:600c:2050:b0:40e:49c4:43c7 with SMTP id p16-20020a05600c205000b0040e49c443c7mr3396133wmg.159.1705392109407;
        Tue, 16 Jan 2024 00:01:49 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:4197:afbd:4d31:1a09? ([2a10:bac0:b000:7588:4197:afbd:4d31:1a09])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0040e6726befcsm14570130wms.10.2024.01.16.00.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 00:01:49 -0800 (PST)
Message-ID: <bad09d97-d99b-4231-a481-c14ed0f8d59d@suse.com>
Date: Tue, 16 Jan 2024 10:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
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
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
 <89e8722b-661b-4319-8018-06705b366c62@suse.com>
 <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_000151_659803_E13E7522 
X-CRM114-Status: GOOD (  18.90  )
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

CgpPbiAxNi4wMS4yNCDQsy4gOToyOCDRhy4sIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToKCjxz
bmlwPgoKPj4+IEBAIC00MSw2ICs0NCw5IEBACj4+PiAgICBzdGF0aWMgYXRvbWljX2xvbmdfdCBu
cl9zaGFyZWQ7Cj4+PiArc3RhdGljIGF0b21pY190IGNvbnZlcnNpb25zX2luX3Byb2dyZXNzOwo+
Pj4gK3N0YXRpYyBib29sIGNvbnZlcnNpb25fYWxsb3dlZCA9IHRydWU7Cj4+Cj4+IEdpdmVuIHRo
ZSB1c2FnZSBtb2RlbCBvZiB0aGlzIHZhcmlhYmxlLCBzaG91bGRuJ3QgaXQgYmUgc2ltcGx5IGFj
Y2Vzc2VkIHZpYQo+PiBSRUFEL1dSSVRFX09OQ0UgbWFjcm9zPwo+IAo+IFdoYXQgZG8geW91IHNl
ZSBpdCBjaGFuZ2luZz8KCgpTZXJ2aW5nIGFzIGRvY3VtZW50YXRpb24gdGhhdCB5b3UgYXJlIGFj
Y2Vzc2luZyBhIHNoYXJlZCB2YXJpYWJsZSAKd2l0aG91dCBhbiBleHBsaWNpdCBsb2NrICh1bmxl
c3MgSSdtIG1pc3Npbmcgc29tZXRoaW5nKS4gCmNvbnZlcnNpb25fYWxsb3dlZCBjYW4gYmUgcmVh
ZCBieSBtdWx0aXBsZSB0aHJlYWRzLCBubyA/IEFuZCBpdCdzIAp3cml0dGVuIGJ5IGEgc2luZ2xl
IHRocmVhZD8KCgo+IAoKPHNuaXA+Cgo+Pj4gK3N0YXRpYyB2b2lkIHRkeF9rZXhlY19zdG9wX2Nv
bnZlcnNpb24oYm9vbCBjcmFzaCkKPj4+ICt7Cj4+PiArCS8qIFN0b3AgbmV3IHByaXZhdGU8LT5z
aGFyZWQgY29udmVyc2lvbnMgKi8KPj4+ICsJY29udmVyc2lvbl9hbGxvd2VkID0gZmFsc2U7Cj4+
Cj4+IFdoYXQncyB0aGUgbG9naWMgYmVoaW5kIHRoaXMgY29tcGlsZXIgYmFycmllcj8KPiAKPiBE
aXNhbGxvdyBjb21waWxlciB0byBwdXNoIHRoZSBhc3NpZ25tZW50IHBhc3QgYXRvbWljX3JlYWQo
KSBsb29wIGJlbG93Lgo+IE5vdCBzdXJlIGlmIGFueXRoaW5nIGVsc2UgcHJldmVudHMgc3VjaCBy
ZW9yZGVyIHdpdGhvdXQgdGhlIGJhcnJpZXIuCj4gCj4gQW5kIEkgZG9uJ3QgdGhpbmsgV1JJVEVf
T05DRSgpIHdpbGwgZG8gdGhlIHRyaWNrLiBJdCBvbmx5IHByZXZlbnRzCj4gbXVsdGlwbGUgd3Jp
dGVzLCBidXQgZG9lc24ndCBwcmV2ZW50IHJlb3JkZXJzIGFnYWlucyBhY2Nlc3Nlcwo+IG5vbi1S
RUFEX09OQ0UoKS9XUklURV9PTkNFKCkgYWNjZXNzZXMuCj4gCj4+PiArCWJhcnJpZXIoKTsKPj4+
ICsKPj4+ICsJLyoKPj4+ICsJICogQ3Jhc2gga2VybmVsIHJlYWNoZXMgaGVyZSB3aXRoIGludGVy
cnVwdHMgZGlzYWJsZWQ6IGNhbid0IHdhaXQgZm9yCj4+PiArCSAqIGNvbnZlcnNpb25zIHRvIGZp
bmlzaC4KPj4+ICsJICoKPj4+ICsJICogSWYgcmFjZSBoYXBwZW5lZCwganVzdCByZXBvcnQgYW5k
IHByb2NlZWQuCj4+PiArCSAqLwo+Pj4gKwlpZiAoIWNyYXNoKSB7Cj4+PiArCQl1bnNpZ25lZCBs
b25nIHRpbWVvdXQ7Cj4+PiArCj4+PiArCQkvKgo+Pj4gKwkJICogV2FpdCBmb3IgaW4tZmxpZ2h0
IGNvbnZlcnNpb25zIHRvIGNvbXBsZXRlLgo+Pj4gKwkJICoKPj4+ICsJCSAqIERvIG5vdCB3YWl0
IG1vcmUgdGhhbiAzMCBzZWNvbmRzLgo+Pj4gKwkJICovCj4+PiArCQl0aW1lb3V0ID0gMzAgKiBV
U0VDX1BFUl9TRUM7Cj4+PiArCQl3aGlsZSAoYXRvbWljX3JlYWQoJmNvbnZlcnNpb25zX2luX3By
b2dyZXNzKSAmJiB0aW1lb3V0LS0pCj4+PiArCQkJdWRlbGF5KDEpOwo+Pj4gKwl9Cj4+PiArCj4+
PiArCWlmIChhdG9taWNfcmVhZCgmY29udmVyc2lvbnNfaW5fcHJvZ3Jlc3MpKQo+Pj4gKwkJcHJf
d2FybigiRmFpbGVkIHRvIGZpbmlzaCBzaGFyZWQ8LT5wcml2YXRlIGNvbnZlcnNpb25zXG4iKTsK
Pj4+ICt9Cj4+PiArCj4+Cj4+IDxzbmlwPgo+Pgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3g4Nl9pbml0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS94ODZfaW5pdC5oCj4+
PiBpbmRleCBjOTUwM2ZlMmQxM2EuLjMxOTZmZjIwYTI5ZSAxMDA2NDQKPj4+IC0tLSBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3g4Nl9pbml0LmgKPj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3g4Nl9pbml0LmgKPj4+IEBAIC0xNTQsNiArMTU0LDggQEAgc3RydWN0IHg4Nl9ndWVzdCB7Cj4+
PiAgICAJaW50ICgqZW5jX3N0YXR1c19jaGFuZ2VfZmluaXNoKSh1bnNpZ25lZCBsb25nIHZhZGRy
LCBpbnQgbnBhZ2VzLCBib29sIGVuYyk7Cj4+PiAgICAJYm9vbCAoKmVuY190bGJfZmx1c2hfcmVx
dWlyZWQpKGJvb2wgZW5jKTsKPj4+ICAgIAlib29sICgqZW5jX2NhY2hlX2ZsdXNoX3JlcXVpcmVk
KSh2b2lkKTsKPj4+ICsJdm9pZCAoKmVuY19rZXhlY19zdG9wX2NvbnZlcnNpb24pKGJvb2wgY3Jh
c2gpOwo+Pj4gKwl2b2lkICgqZW5jX2tleGVjX3Vuc2hhcmVfbWVtKSh2b2lkKTsKPj4KPj4gVGhl
c2UgYXJlIG9ubHkgYmVpbmcgaW5pdGlhbGl6ZWQgaW4gdGhlIFREWCBjYXNlLCBidXQgY2FsbGVk
IGluIGFsbCBjYXNlcwo+PiB3aGVuIENDX0FUVFJfR1VFU1RfTUVNX0VOQ1JZUFQgaXMgdHJ1ZSwg
d2hpY2ggaW5jbHVkZXMgQU1ELiBTbyBpdCB3b3VsZAo+PiBjYXVzZSBhIGNyYXNoLCBubyA/IFNo
b3VsZG4ndCB5b3UgYWxzbyBpbnRyb2R1Y2Ugbm9vcCBoYW5kbGVycyBpbml0aWFsaXplZAo+PiBp
biB0aGUgZGVmYXVsdCB4ODZfcGxhdGZvcm0gc3RydWN0IGluIGFyY2gveDg2L2tlcm5lbC94ODZf
aW5pdC5jID8KPiAKPiBrZXhlYyBvbiBBTUQgd2lsbCBub3Qgd29yayB3aXRob3V0IHRoZW0sIEkg
dGhpbmsuIEJ1dCBub29wcyBtYWtlcyBzZW5zZQo+IGFueXdheS4gV2lsbCBmaXguCgpJJ20gbm90
IGRpc3B1dGluZyB3aGV0aGVyIHRob3NlIGFyZSBuZWVkZWQgZm9yIEFNRCBvciBub3QsIHRoYXQg
d2F5IEkgCnNlZSBpdCB5b3UgbWFrZSB0aG9zZSBjYWxsYmFja3MgbWFuZGF0b3J5IGluIHRoZSBj
YXNlIG9mIApDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBUIGJlaW5nIHByZXNlbnQsIHlldCBvbmx5
IGltcGxlbWVudCB0aGVtIGZvciAKVERYLiBTbyBpbiB0aGUgY2FzZSBvZiBBTUQgdGhleSB3aWxs
IGJlIE5VTEwgYW5kIHNvIEFNRCB3aXRoIGtleGVjIAplbmFibGVkIChhbGJlaXQgZXJyb25lb3Vz
bHkpIHdpbGwgY3Jhc2gsIG5vID8KCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
