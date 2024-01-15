Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F722C3DA79
	for <kexec@archiver.kernel.org>; Mon, 15 Jan 2024 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V5LovT7+VGosvagB61FB15jaM3w+hkf8pUInMPgVMlk=; b=aIRhAwVrQfZRZV
	7UQmqWmQRD0UaIcIdPKcgeYD2qaixSG2n7yE3pVypymJwR+o2L8qGFpreOD33MethkHMPRvsif+Xa
	yG8zeA1noPnWonOVMf9ImJymkCPlbfFFt0MeKhjvhuG1Vczvv7DlOv0SzajRdsIWDvmgH3Ry50+yC
	soLVWDjcIHhFZQQ2vK8KQtfImHo4WhDwcfHouA/Xe4MLgFBdJGvL40gHWXLDJCOa47/CsbpDspmEn
	GiDWFQRO3AIHUmoDj7zDU10CA4IiyF291EIZdqAyxFqbuKEwwx4RtMIkNj4lN6muyvkZaK8rA82xx
	8cLLxk+V/qXYJx3wnyrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMsY-00938K-1m;
	Mon, 15 Jan 2024 13:19:50 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMsU-00937I-1o
	for kexec@lists.infradead.org;
	Mon, 15 Jan 2024 13:19:48 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so100362835e9.0
        for <kexec@lists.infradead.org>; Mon, 15 Jan 2024 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705324785; x=1705929585; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0v/N0kXAbnUMy0XtXE3gHSioK80yxhIhWRK0FxbIKw=;
        b=DcOgyWGAjM3sdimbpiNe3Giy3LNmR9gL8JDvaUUWOkrFXgQaYT7ipHnl8Vo2tc9313
         09LIF7iRutRBconLBrQg/EZymKU9gQE0Hwzgug4cv9u0HOAPP72W+9AHcRMomZ7mWVP5
         ZlE8Lut/tsLhuE919FJLjgJJ8u9xAg6gWoIozx12GYaom+84D3piXcQDLAuUjsNe+KKh
         zk7GTuCICKJA227l8qAT6o53HxmQZ9J86kvM4TY903pd3U6Z4mn7W6lAcdh/FnG22XA6
         ZaXeDp9XvX6QZP/eZlr2RkXEIdnpdw7i8Y/rrqf7NxoGr4xkq+zMRfWyYS4MJqpIeZ9n
         MLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705324785; x=1705929585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0v/N0kXAbnUMy0XtXE3gHSioK80yxhIhWRK0FxbIKw=;
        b=rh7mac79mcVek4hDTwv8llHHc/cOp7pUDnioWB+yNruRhIKD/3AAPM+zFE+go5xZjD
         qlmPWWJrYQVCjpW77qr2BDcaOclGit75Sr8qdlSg2zLJizvRkYRUjkSko56WvNm6aaFv
         lnG0z4Tbq3PJ4jL/4DesW05ThtIHMXop93zG+TsWApZ5CZ7IxZ6z7zzpOUbGPBWkN9lB
         aRSkVCrvNdD2gEEUMgCcEC1RVm8yj5tVepfPfChfihWhtIskB6rS91LFf4YBoL3WJmKa
         SuScT12/sf1Gx7UgaKGG0vlLDJGaRCek3rjGMyrikxdWYOsDRz3KPw5T5emdRsI3T6Lq
         AvMA==
X-Gm-Message-State: AOJu0YycV7LWQKjXpSLcQKC4JZK4fsWceemA4QvtCAmjRBWiT+GI0FYD
	UO1H4pzwSdtX1GttfqmeM28WHOZhhfIb5w==
X-Google-Smtp-Source: AGHT+IEmfou+SJJzbucaZzJYGOu0aKAR3E1mpvl8rhNlPReIy38XcB//GKFyZHBfkSGj9VIw/SMfNQ==
X-Received: by 2002:a05:600c:295:b0:40e:5f22:3d1b with SMTP id 21-20020a05600c029500b0040e5f223d1bmr1871631wmk.72.1705324785015;
        Mon, 15 Jan 2024 05:19:45 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7588:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e5945307esm16032865wmo.40.2024.01.15.05.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 05:19:44 -0800 (PST)
Message-ID: <fa1e3873-6218-461b-85fa-1ff353380532@suse.com>
Date: Mon, 15 Jan 2024 15:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
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
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-17-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231222235209.32143-17-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_051946_621098_8150B557 
X-CRM114-Status: GOOD (  22.86  )
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

CgpPbiAyMy4xMi4yMyDQsy4gMTo1MiDRhy4sIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToKPiBN
QURUIE11bHRpcHJvY2Vzc29yIFdha2V1cCBzdHJ1Y3R1cmUgdmVyc2lvbiAxIGJyaW5ncyBzdXBw
b3J0IG9mIENQVQo+IG9mZmxpbmluZzogQklPUyBwcm92aWRlcyBhIHJlc2V0IHZlY3RvciB3aGVy
ZSB0aGUgQ1BVIGhhcyB0byBqdW1wIHRvCj4gZm9yIG9mZmxpbmluZyBpdHNlbGYuIFRoZSBuZXcg
VEVTVCBtYWlsYm94IGNvbW1hbmQgY2FuIGJlIHVzZWQgdG8gdGVzdAo+IHdoZXRoZXIgdGhlIENQ
VSBvZmZsaW5lZCBpdHNlbGYgd2hpY2ggbWVhbnMgdGhlIEJJT1MgaGFzIGNvbnRyb2wgb3Zlcgo+
IHRoZSBDUFUgYW5kIGNhbiBvbmxpbmUgaXQgYWdhaW4gdmlhIHRoZSBBQ1BJIE1BRFQgd2FrZXVw
IG1ldGhvZC4KPiAKPiBBZGQgQ1BVIG9mZmxpbmcgc3VwcG9ydCBmb3IgdGhlIEFDUEkgTUFEVCB3
YWtldXAgbWV0aG9kIGJ5IGltcGxlbWVudGluZwo+IGN1c3RvbSBjcHVfZGllKCksIHBsYXlfZGVh
ZCgpIGFuZCBzdG9wX3RoaXNfY3B1KCkgU01QIG9wZXJhdGlvbnMuCj4gCj4gQ1BVIG9mZmxpbmlu
ZyBtYWtlcyBpcyBwb3NzaWJsZSB0byBoYW5kIG92ZXIgc2Vjb25kYXJ5IENQVXMgb3ZlciBrZXhl
YywKPiBub3QgbGltaXRpbmcgdGhlIHNlY29uZCBrZXJuZWwgdG8gYSBzaW5nbGUgQ1BVLgo+IAo+
IFRoZSBjaGFuZ2UgY29uZm9ybXMgdG8gdGhlIGFwcHJvdmVkIEFDUEkgc3BlYyBjaGFuZ2UgcHJv
cG9zYWwuIFNlZSB0aGUKPiBMaW5rLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0
ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4KPiBMaW5rOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMTMzNTYyNTEudUxaV0duS21oZUBrcmVhY2hlcgo+IC0tLQo+ICAg
YXJjaC94ODYvaW5jbHVkZS9hc20vYWNwaS5oICAgICAgICAgIHwgICAyICsKPiAgIGFyY2gveDg2
L2tlcm5lbC9hY3BpL01ha2VmaWxlICAgICAgICB8ICAgMiArLQo+ICAgYXJjaC94ODYva2VybmVs
L2FjcGkvbWFkdF9wbGF5ZGVhZC5TIHwgIDI5ICsrKysrCj4gICBhcmNoL3g4Ni9rZXJuZWwvYWNw
aS9tYWR0X3dha2V1cC5jICAgfCAxODQgKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gICBp
bmNsdWRlL2FjcGkvYWN0YmwyLmggICAgICAgICAgICAgICAgfCAgMTUgKystCj4gICA1IGZpbGVz
IGNoYW5nZWQsIDIyOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gveDg2L2tlcm5lbC9hY3BpL21hZHRfcGxheWRlYWQuUwo+IAo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hY3BpLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9hY3BpLmgKPiBpbmRleCAyNjI1YjkxNWFlN2YuLjAyMWNhZmEyMTRjMiAxMDA2NDQKPiAtLS0g
YS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hY3BpLmgKPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9hY3BpLmgKPiBAQCAtODEsNiArODEsOCBAQCB1bmlvbiBhY3BpX3N1YnRhYmxlX2hlYWRlcnM7
Cj4gICBpbnQgX19pbml0IGFjcGlfcGFyc2VfbXBfd2FrZSh1bmlvbiBhY3BpX3N1YnRhYmxlX2hl
YWRlcnMgKmhlYWRlciwKPiAgIAkJCSAgICAgIGNvbnN0IHVuc2lnbmVkIGxvbmcgZW5kKTsKPiAg
IAo+ICt2b2lkIGFzbV9hY3BpX21wX3BsYXlfZGVhZCh1NjQgcmVzZXRfdmVjdG9yLCB1NjQgcGdk
X3BhKTsKPiArCj4gICAvKgo+ICAgICogQ2hlY2sgaWYgdGhlIENQVSBjYW4gaGFuZGxlIEMyIGFu
ZCBkZWVwZXIKPiAgICAqLwo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9NYWtl
ZmlsZSBiL2FyY2gveDg2L2tlcm5lbC9hY3BpL01ha2VmaWxlCj4gaW5kZXggOGM3MzI5Yzg4YTc1
Li4zN2IxZjI4ODQ2ZGUgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2FjcGkvTWFrZWZp
bGUKPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9NYWtlZmlsZQo+IEBAIC00LDcgKzQsNyBA
QCBvYmotJChDT05GSUdfQUNQSSkJCQkrPSBib290Lm8KPiAgIG9iai0kKENPTkZJR19BQ1BJX1NM
RUVQKQkJKz0gc2xlZXAubyB3YWtldXBfJChCSVRTKS5vCj4gICBvYmotJChDT05GSUdfQUNQSV9B
UEVJKQkJCSs9IGFwZWkubwo+ICAgb2JqLSQoQ09ORklHX0FDUElfQ1BQQ19MSUIpCQkrPSBjcHBj
Lm8KPiAtb2JqLSQoQ09ORklHX1g4Nl9BQ1BJX01BRFRfV0FLRVVQKQkrPSBtYWR0X3dha2V1cC5v
Cj4gK29iai0kKENPTkZJR19YODZfQUNQSV9NQURUX1dBS0VVUCkJKz0gbWFkdF93YWtldXAubyBt
YWR0X3BsYXlkZWFkLm8KPiAgIAo+ICAgaWZuZXEgKCQoQ09ORklHX0FDUElfUFJPQ0VTU09SKSwp
Cj4gICBvYmoteQkJCQkJKz0gY3N0YXRlLm8KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L2FjcGkvbWFkdF9wbGF5ZGVhZC5TIGIvYXJjaC94ODYva2VybmVsL2FjcGkvbWFkdF9wbGF5ZGVh
ZC5TCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLmU0ODA0OTk1
OTUxMwo+IC0tLSAvZGV2L251bGwKPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9tYWR0X3Bs
YXlkZWFkLlMKPiBAQCAtMCwwICsxLDI5IEBACj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wICovCj4gKyNpbmNsdWRlIDxsaW51eC9saW5rYWdlLmg+Cj4gKyNpbmNsdWRlIDxh
c20vbm9zcGVjLWJyYW5jaC5oPgo+ICsjaW5jbHVkZSA8YXNtL3BhZ2VfdHlwZXMuaD4KPiArI2lu
Y2x1ZGUgPGFzbS9wcm9jZXNzb3ItZmxhZ3MuaD4KPiArCj4gKwkudGV4dAo+ICsJLmFsaWduIFBB
R0VfU0laRQo+ICsKPiArLyoKPiArICogYXNtX2FjcGlfbXBfcGxheV9kZWFkKCkgLSBIYW5kIG92
ZXIgY29udHJvbCBvZiB0aGUgQ1BVIHRvIHRoZSBCSU9TCj4gKyAqCj4gKyAqIHJkaTogQWRkcmVz
cyBvZiB0aGUgQUNQSSBNQURUIE1QV0sgUmVzZXRWZWN0b3IKPiArICogcnNpOiBQR0Qgb2YgdGhl
IGlkZW50aXR5IG1hcHBpbmcKPiArICovCj4gK1NZTV9GVU5DX1NUQVJUKGFzbV9hY3BpX21wX3Bs
YXlfZGVhZCkKPiArCS8qIFR1cm4gb2ZmIGdsb2JhbCBlbnRyaWVzLiBGb2xsb3dpbmcgQ1IzIHdy
aXRlIHdpbGwgZmx1c2ggdGhlbS4gKi8KPiArCW1vdnEJJWNyNCwgJXJkeAo+ICsJYW5kcQkkfihY
ODZfQ1I0X1BHRSksICVyZHgKPiArCW1vdnEJJXJkeCwgJWNyNAo+ICsKPiArCS8qIFN3aXRjaCB0
byBpZGVudGl0eSBtYXBwaW5nICovCj4gKwltb3ZxCSVyc2ksICVyYXgKPiArCW1vdnEJJXJheCwg
JWNyMwoKbml0OiBDYW4ndCB5b3UgbW92ZSBkaXJlY3RseSB0byBjcjMKCj4gKwo+ICsJLyogSnVt
cCB0byByZXNldCB2ZWN0b3IgKi8KPiArCUFOTk9UQVRFX1JFVFBPTElORV9TQUZFCj4gKwlqbXAJ
KiVyZGkKPiArU1lNX0ZVTkNfRU5EKGFzbV9hY3BpX21wX3BsYXlfZGVhZCkKCjxzbmlwPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
