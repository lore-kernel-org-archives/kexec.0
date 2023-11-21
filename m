Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C84BC5ACB3
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s6b/TUVPy/5bGW6WmG0zBhgHv/rdKAUSeKcFd0YbtGc=; b=KJaMJh029yj4v1
	nRRV7FG2BbRw57zryoI0UAToyrmngstXqRSRunqK5sy7nWNiQutu12sGTfMfGnWQpcetUd63DROv8
	Lb1KHGFgipGutCoPQqsZ7Kjizozm+o/FDSwFQZ2/BP1r4kTeRO20EQfdRmpEei7e04/zfrN9RQpSK
	5BxrWL6obwMR9BQRb6f6HvvPgoEmfE1ecq+afQY8Ig1z240qyTtQZR8Zo2j7S4i5vPWdw7+R8e8aZ
	LRTLA+vTG6HQgdtWOpp4M1wJOmer7289fP39S1jJA87TDaAmqaL1NzaSKvaq8iIYF4JeVorCpM9PD
	0vOAx7G2TnNnU+iAu65Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Mnm-00G5u4-1j;
	Tue, 21 Nov 2023 09:12:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Mnj-00G5tW-1d
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 09:12:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700557929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8VqgPmAQ7EIQTV/xERi+bscdvu2asecBTlQhyi8tn8=;
	b=ZZDsdcCiSCHa310C7vsab6l2ybxOTm7J0ztodOZOAAKxLcFWc0KTkgJcROLQYk+H502tqC
	CAXaoIhauZU0jGKrApw51cMhwwHYWRWBG3+SsjqpzV0sSYyN56lUbFg7CRiyl3CrN+fTPe
	nVG8BLu5fg+jxhRqJGT+sfzODfd1Tok=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-puYq54aEMYWnDny1mJUo0Q-1; Tue, 21 Nov 2023 04:10:39 -0500
X-MC-Unique: puYq54aEMYWnDny1mJUo0Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a01991968f5so42411666b.2
        for <kexec@lists.infradead.org>; Tue, 21 Nov 2023 01:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700557838; x=1701162638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8VqgPmAQ7EIQTV/xERi+bscdvu2asecBTlQhyi8tn8=;
        b=jgmeMWNyK/biAB+QHUm+hOD6m6Q1kRF+h0szhri0Re7rpC45qlmJYKNKYriZKVUCFh
         4nBWRry1ErWzJrFnvCRVSb3UEp/MhuYK410LJXBDQOv2fXKRmvAQAHDxAKsC//2Ac99K
         ohZyqx6cFRwyRfqAc8UImLdFvIPgu9U9zDCKEdXnBMn/g7kc1VRqnjou/ZGSkJmHxB1z
         8ggEsoihrqTAZG+dgtRD+fiUznpW50uOxtYt99d/zBHDESyZIpfzTiNCn1XnUBF9yjts
         ef3+j7ycTPfDzMPxWOoEgboP8kgc9A9Z7RdV+nRlHNaqFQx9PVqVgtrv5Mej+8hCE3iN
         fFeA==
X-Gm-Message-State: AOJu0Yxb3Jeu+hwXnIgrS58ll1vVasZSRtVIXYzLR6tnT/LiGZktxAtr
	IvLJlF9Vr3SbR1GtCDiS+sA3acsCNmivzqzEACkm4yy2hDAtdPcRgPgbU8HE7ggTD4iJhTX6o09
	ZS4UGxeXQaasAKjAX68cZlBPy0ctc6NiJMYbg
X-Received: by 2002:a50:8d11:0:b0:548:4f16:ecfc with SMTP id s17-20020a508d11000000b005484f16ecfcmr1597930eds.0.1700557838116;
        Tue, 21 Nov 2023 01:10:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHVgvgj/1BJKpcUGeJXQN3MkvUneS3BEt5tns8r5WTn76N6o3GvUesVzThqilYiqkw7YjUG83i+KTKDSln3uA=
X-Received: by 2002:a50:8d11:0:b0:548:4f16:ecfc with SMTP id
 s17-20020a508d11000000b005484f16ecfcmr1597896eds.0.1700557837682; Tue, 21 Nov
 2023 01:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv> <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv> <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name> <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box> <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv> <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
In-Reply-To: <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 21 Nov 2023 17:10:01 +0800
Message-ID: <CAO7dBbWb2UWJRm1LLXOq7MM1K6BxDetL8tTmW93H589FGz8n9g@mail.gmail.com>
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_011211_636099_4FD5ACF9 
X-CRM114-Status: GOOD (  29.51  )
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

SGkgS2lyaWxsLAoKT24gVHVlLCBOb3YgMjEsIDIwMjMgYXQgNDo0M+KAr1BNIEtpcmlsbCBBLiBT
aHV0ZW1vdgo8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4KPiBPbiBU
dWUsIE5vdiAyMSwgMjAyMyBhdCAwMjo0MTowOFBNICswODAwLCBCYW9xdWFuIEhlIHdyb3RlOgo+
ID4gPiA+Cj4gPiA+ID4gU3RpbGwgZmFpbGVkLiBBbmQgSSBmb3VuZCB0aGUgbm9ybWFsIHJlYm9v
dCBkb2VzJ3Qgd29yayBlaXRoZXIuIEkgd2lsbAo+ID4gPiA+IGRvIG1vcmUgdGVzdGluZyB0b21v
cnJvdywgZS5nIHVzZSB0aGUgdGR4LXRvb2xzJ3Mgb3duIHJoZWw5IGtlcm5lbAo+ID4gPiA+IGNv
bmZpZyBhbmQgcmVidWlsZCwgYW5kIHVwZGF0ZSBob3N0IGtlcm5lbCB0b28uCj4gPgo+ID4gSSBk
aWQgbW9yZSB0ZXN0cywgcmVzdWxzIGFyZSBzdW1tYXJpemVkIGFzIGJlbG93Ogo+ID4KPiA+IDEp
IGtleGVjIHJlYm9vdCB3b3JrcywgYnV0IGFsd2F5cyBmYWxsYmFjayB0byAxIGNwdSBldmVuIHRo
b3VnaCBtdWx0aXBsZQo+ID4gY3B1cyBhcmUgc3BlY2lmaWVkOwo+Cj4gVGhhdCdzIGV4cGVjdGVk
LiBVbnRpbCB5b3UgaGF2ZSBuZXcgQklPUy4gU2VlIGJlbG93Lgo+Cj4gPiAyKSBrZHVtcCBrZXJu
ZWwgbmVlZCBtb3JlIGNyYXNoa2VybmVsIG1lbW9yeSB0byBib290IHVwLAo+ID4gICAgY3Jhc2hr
ZXJuZWw9NTEyTSB3b3JrcyB3ZWxsIGluIG91ciBjYXNlLgo+Cj4gSSBndWVzcyBpdCBpcyBkdWUg
dG8gU1dJT1RMQiBtZW1vcnkgd2hpY2ggcmVxdXJlcyBhdCBsZWFzdCA2NE0uCj4KPiA+ICBCdXQg
aXQgZmFpbGVkIGluIHZtY29yZQo+ID4gICAgc2F2aW5nIHByb2Nlc3MsIGVpdGhlciBtYWtlZHVt
cGZpbGUgb3IgY3AgY2FuJ3QgYWNjZXNzIHRoZSAxc3QKPiA+ICAgIGtlcm5lbCdzIG9sZCBtZW1v
cnk7Cj4KPiBXaWxsIGxvb2sgaW50byBpdC4KPgo+ID4gMykgTm9ybWFsIHJlYm9vdCBhbHdheXMg
ZmFpbGVkOwo+Cj4gSXQgaXMgZXhwZWN0ZWQuIFREIHZDUFVzIGFyZSBub3QgcmVzZXR0YWJsZS4g
U28gd2UgbmVlZCB0byBkZXN0cm95IFREIGFuZAo+IGNvbnN0cnVjdCBhIG5ldyBvbmUgdG8gZW11
bGF0ZSAicmVib290Ii4KPgo+IEkgZ3Vlc3Mgd2UgY2FuIHRyeSB0byBhZGQgc29tZSBnbHVlIG9u
IFFFTVUgc2lkZSB0byBtYWtlIHJlYm9vdCBtb3JlCj4gc2VhbWxlc3MuCj4KPiA+IE15IGNvbGxl
YWd1ZSBUYW8gaGVscGVkIHRvIGRvdWJsZSBjaGVjayB0aGlzLCBoZSBnb3QgdGhlIHNhbWUgdGVz
dGluZyByZXN1bHQuCj4gPiBQbGVzYWUKPiA+IDEpIHdoYXQgY2FuIHdlIGRvIHRvIGVuYWJsZSB0
aGUgbXVsdGlwbGUgY3B1IHN1cHBvcnQgZm9yIGtleGVjIHJlYm9vdD8KPgo+IFlvdSB3b3VsZCBu
ZWVkIGEgcGF0Y2hlZCBCSU9TIGltYWdlLiBJJ3ZlIGhhY2tlZCBvbmVbMV0gZm9yIG15IHRlc3Rp
bmcuCj4gQnV0IGl0IG9ubHkgd29ya3MgaWYga2VybmVsIHJ1bnMgaW4gNC1sZXZlbCBwYWdpbmcg
bW9kZSAoc3BlY2lmeSBubzVsdmwgaW4KPiBrZXJuZWwgY29tbWFuZCBsaW5lKS4KPgo+IEJJT1Mg
Zm9sa3Mgd29yayBvbiBwcm9wZXIgcGF0Y2gsIGJ1dCBpdCBpcyBub3QgcmVhZHkgeWV0Lgo+Cj4g
WzFdIGh0dHBzOi8vZ2lzdC5naXRodWIuY29tL2tpcnlsL2UxZGMxNzE5ZTBjOTkwYjNjZWVlNWQ4
ZGU4ZGJmMzMyCj4KVGhhbmtzIGEgbG90IGZvciBwcm92aWRpbmcgdGhlIEJJT1MgcGF0Y2guIE9u
ZSBtb3JlIHF1ZXN0aW9uLCBpcyB0aGUKcGF0Y2hlZCBCSU9TIGltYWdlIGZvciB0aGUgaG9zdCBw
aHlzaWNhbCBtYWNoaW5lIG9yIGZvciB0aGUgdGR4IGd1ZXN0CnZtPwoKVGhhbmtzLApUYW8gTGl1
Cgo+ID4gMikgYW55dGhpbmcgbWlzc2luZyB0byBhbGxvdyBtYWtlZHVtcGZpbGUvY3AgYWNjZXNz
IDFzdCBrZXJuZWwncyBtZW1vcnk/Cj4KPiBJdCB3b3JrZWQgYmVmb3JlIGZvciB1cywgYnV0IEkg
aGF2ZSBub3QgY2hlY2tlZCBmb3IgYSB3aGlsZS4KPgo+IEkgZXhwZWN0ZWQgeW91J3ZlIGRyb3Bw
ZWQgbXkgImlmIChjcmFzaCkgcmV0dXJuOyIgZGVidWcgcGF0Y2ggSSBhc2tlZCB5b3UKPiB0byB0
ZXN0ZWQgYmVmb3JlLCByaWdodD8gSWYgbm90LCBmYWlsdXJlIGlzIGV4cGVjdGVkLgo+Cj4gPiAz
KSBub3Qgc3VyZSBpZiB0aGlzIGlzIHBhcnRpY3VsYXIgY2FzZSBvbiB0aGUgc3lzdGVtIHdlIHRl
c3RlZCBvbi4KPgo+IC0tCj4gICBLaXJ5bCBTaHV0c2VtYXUgLyBLaXJpbGwgQS4gU2h1dGVtb3YK
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4ga2V4
ZWMgbWFpbGluZyBsaXN0Cj4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMKPgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
