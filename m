Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F64CCDDE40
	for <kexec@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SafyOxliYtkzgU1mjnRktI4GfGt8B3+VIGGFEYwnuYg=; b=v950b7uKjsSbsK
	N0k988zMJ3NBJRzySwMZf3mbVBuRX2367tAwna9BaD887FdNUJYZx+zirjPzO0SHZqgWhWIUgxXgr
	kL3WEUb3/A4BOPilQRRwt+Z2duWzm3HH1JjeNQoGhdrnDIyGDzlvSQGGMKdMFIhpbZlvb7Ip+Qw7h
	WcUyyJJ5S+LFUUgbWF55Zk+4aIOXWbqvY3nQjxMmj5/psQTT34WvczUn6t0hZj2SyhMydGtLQ7LdO
	4IXX4KlQrmvRee3DccmWU/155EN4XY8zapKxl/tVKLoH0wJv938U021Rqi/cdJWCRxyq1jl3j2MY+
	9J51OjjZ+J0EyednUcwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YA5-0000000DtxY-3Asg;
	Wed, 23 Oct 2024 10:00:17 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Xoa-0000000DpS9-22OQ;
	Wed, 23 Oct 2024 09:39:50 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a99eb8b607aso712874366b.2;
        Wed, 23 Oct 2024 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729676282; x=1730281082; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xi//lmY3CDXLB22ZA8QT8BrT/DH2hEHxXLSW2RSdvf4=;
        b=i+bmpvdXGTbWSgKmqdo9P6aOD4D9QJcN2RqTigBHW1npylAkzfcTpiehNW4U6uMrwJ
         nGQLYBDiMGmiNVKqbQ3LJ/qUZDXO0zYbwy/RXhPBTt3oHyEn0RdAHzNuftdADWwjoznn
         cMYNT+1QQDbjyUGc4hJX5dZdjFsc5C6BwnbD+RYmzjMz33GvAECdfwzfvzTljGazwmdG
         4snS1kwoemdN9VZpXd1Hx/kEBoGnsfu6fKHA5v/rN1+VS/YUYGcWxemGV2Cm8xeCnzXc
         wBYjIfbh/9O/pzN0kvwuI+7QGCfe10PhnB+6i5B3kpbsE7e67Kva3V9WJ49NAlyALw4a
         DS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676282; x=1730281082;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi//lmY3CDXLB22ZA8QT8BrT/DH2hEHxXLSW2RSdvf4=;
        b=vP61h3otbny8/jlF9ACivOcMYGlHacQf/xMectt7Mqwi7/TY06ykD+FT8hK/lx2bNQ
         elSAHL+3CCs6bCPihG0P7hp0RC/nAcnqfQaDfOnrD+SV9sZ3KJK9VmCw/7/iJa7y0x9G
         xNQiv2U4js++MZ7oVWWRnD+LfUqA62RpNIScczIfY1O882Ii+8FD8g6VMj4KDz7iyAUc
         97qJ+Jjg912KU+EmiL6aZV+nd0lnKXzWuEsm34V72zz58LuSvaUqY/HbQgGNiOLMHPox
         XGOSDcSGhJpMDfvHqVQKS8GJhZLEoOX3wMP1FK7U2Y17yGI18ZWHUSEhZpaIJYqfkUCM
         mWsw==
X-Forwarded-Encrypted: i=1; AJvYcCVyIxHMl2OEI42EB9rfmFqJ8+jAeMSqdcruEhFfiWAehHARp29cOekIMTJPYzELWtEzvE7yNvQ02kjd/5i4cSYLOw==@lists.infradead.org, AJvYcCWBsqwzQhUOePR7zOo2X9HsNz0QJMYT2n7o3zOtQzgnpmO8mF0HYYGBGBnhah18Svb7X8Sfqw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9uKIqlNQJuVC7cNWIXWNGxQJc2VI7KuA2EHCFUenNMCD4y6CH
	5hlr00698Vev/ibMGehsx3DwllC0tzutEOImMmbidIfoc8wyv3qm124NqA==
X-Google-Smtp-Source: AGHT+IF2xpNDAMd7ETMVHrq0usZAhIAETenBmMVdyqyf3MuQ2dWpqhGHoIm9pnhbGW/M9Gz++KBoVA==
X-Received: by 2002:a17:906:c107:b0:a99:4261:e9f7 with SMTP id a640c23a62f3a-a9abf8d83damr180688066b.39.1729676282124;
        Wed, 23 Oct 2024 02:38:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91598f29sm451110266b.190.2024.10.23.02.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:38:01 -0700 (PDT)
Message-ID: <6ff25181-3df7-4edd-b55b-021b74c3b624@gmail.com>
Date: Wed, 23 Oct 2024 10:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
From: Usama Arif <usamaarif642@gmail.com>
To: Rob Herring <robh@kernel.org>, mark.rutland@arm.com, will@kernel.org
Cc: leitao@debian.org, catalin.marinas@arm.com, saravanak@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org>
 <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
 <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
 <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
Content-Language: en-US
In-Reply-To: <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_023804_722674_F75B1166 
X-CRM114-Status: GOOD (  29.60  )
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

CgpPbiAwNy8xMC8yMDI0IDE2OjMwLCBVc2FtYSBBcmlmIHdyb3RlOgo+IAo+IAo+IE9uIDA3LzEw
LzIwMjQgMTU6MzksIFJvYiBIZXJyaW5nIHdyb3RlOgo+PiBPbiBNb24sIE9jdCA3LCAyMDI0IGF0
IDk6MDbigK9BTSBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPiB3cm90ZToKPj4+
Cj4+Pgo+Pj4KPj4+IE9uIDA0LzEwLzIwMjQgMDE6MDMsIFJvYiBIZXJyaW5nIHdyb3RlOgo+Pj4+
IE9uIFRodSwgT2N0IDAzLCAyMDI0IGF0IDEyOjM4OjQwUE0gKzAxMDAsIFVzYW1hIEFyaWYgd3Jv
dGU6Cj4+Pj4+ICBfX3BhKCkgaXMgb25seSBpbnRlbmRlZCB0byBiZSB1c2VkIGZvciBsaW5lYXIg
bWFwIGFkZHJlc3NlcyBhbmQgdXNpbmcKPj4+Pj4gaXQgZm9yIGluaXRpYWxfYm9vdF9wYXJhbXMg
d2hpY2ggaXMgaW4gZml4bWFwIGZvciBhcm02NCB3aWxsIGdpdmUgYW4KPj4+Pj4gaW5jb3JyZWN0
IHZhbHVlLiBIZW5jZSBzdGFzaCB0aGUgcGh5c2ljYWwgYWRkcmVzcyB3aGVuIGl0IGlzIGtub3du
IGF0Cj4+Pj4+IGJvb3QgdGltZSBhbmQgdXNlIGl0IGF0IGtleGVjIHRpbWUgaW5zdGVhZCBvZiBj
b252ZXJ0aW5nIHRoZSB2aXJ0dWFsCj4+Pj4+IGFkZHJlc3MgdXNpbmcgX19wYSgpLgo+Pj4+Pgo+
Pj4+PiBSZXBvcnRlZC1ieTogQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4KPj4+Pj4g
U3VnZ2VzdGVkLWJ5OiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgo+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPgo+Pj4+PiBG
aXhlczogYWMxMGJlNWNkYmZhICgiYXJtNjQ6IFVzZSBjb21tb24gb2Zfa2V4ZWNfYWxsb2NfYW5k
X3NldHVwX2ZkdCgpIikKPj4+Pj4gLS0tCj4+Pj4+ICBhcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5j
IHwgOCArKysrKysrKwo+Pj4+PiAgZHJpdmVycy9vZi9mZHQuYyAgICAgICAgICB8IDYgKysrKysr
Cj4+Pj4+ICBkcml2ZXJzL29mL2tleGVjLmMgICAgICAgIHwgOCArKysrKystLQo+Pj4+PiAgaW5j
bHVkZS9saW51eC9vZl9mZHQuaCAgICB8IDIgKysKPj4+Pj4gIDQgZmlsZXMgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQva2VybmVsL3NldHVwLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4+Pj4+
IGluZGV4IGIyMmQyOGVjODAyOC4uYTRkOTZmNWUyZTA1IDEwMDY0NAo+Pj4+PiAtLS0gYS9hcmNo
L2FybTY0L2tlcm5lbC9zZXR1cC5jCj4+Pj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL3NldHVw
LmMKPj4+Pj4gQEAgLTE5NCw2ICsxOTQsMTQgQEAgc3RhdGljIHZvaWQgX19pbml0IHNldHVwX21h
Y2hpbmVfZmR0KHBoeXNfYWRkcl90IGR0X3BoeXMpCj4+Pj4+ICAgICAgLyogRWFybHkgZml4dXBz
IGFyZSBkb25lLCBtYXAgdGhlIEZEVCBhcyByZWFkLW9ubHkgbm93ICovCj4+Pj4+ICAgICAgZml4
bWFwX3JlbWFwX2ZkdChkdF9waHlzLCAmc2l6ZSwgUEFHRV9LRVJORUxfUk8pOwo+Pj4+Pgo+Pj4+
PiArICAgIC8qCj4+Pj4+ICsgICAgICogU2F2ZSBkdF9waHlzIGFkZHJlc3Mgc28gdGhhdCBpdCBj
YW4gYmUgdXNlZCBsYXRlciBmb3Iga2V4ZWMuIFRoaXMKPj4+Pj4gKyAgICAgKiBpcyBkb25lIGFz
IF9fcGEoKSBpcyBvbmx5IGludGVuZGVkIHRvIGJlIHVzZWQgZm9yIGxpbmVhciBtYXAgYWRkcmVz
c2VzCj4+Pj4+ICsgICAgICogYW5kIHVzaW5nIGl0IGZvciBpbml0aWFsX2Jvb3RfcGFyYW1zIHdo
aWNoIGlzIGluIGZpeG1hcCB3aWxsIGdpdmUgYW4KPj4+Pj4gKyAgICAgKiBpbmNvcnJlY3QgdmFs
dWUuCj4+Pj4+ICsgICAgICovCj4+Pj4+ICsgICAgc2V0X2luaXRpYWxfYm9vdF9wYXJhbXNfcGEo
ZHRfcGh5cyk7Cj4+Pj4KPj4+PiBObyBuZXcgYXJjaC0+ZHQgZnVuY3Rpb25zIHBsZWFzZS4gSWYg
d2UgbmVlZCB0byBzYXZlIG9mZiB0aGUgUEEsIHRoZW4gZG8KPj4+PiB0aGF0IHdoZW4gd2Ugc2V0
IGluaXRpYWxfYm9vdF9wYXJhbXMuCj4+Pj4KPj4+PiBSb2IKPj4+Cj4+Pgo+Pj4gaW5pdGlhbF9i
b290X3BhcmFtcyBpcyBzZXQgaW4gZWFybHlfaW5pdF9kdF92ZXJpZnksIGNhbGxlZCBieSBlYXJs
eV9pbml0X2R0X3NjYW4uCj4+PiBUaGlzIGlzIGRvbmUgaW4gc2V0dXBfbWFjaGluZV9mZHQgaW4g
YXJtNjQgd2hlcmUgdGhlIFBBIGlzIGF2YWlsYWJsZSwKPj4+IGJ1dCBpbiBvdGhlciBmdW5jdGlv
bnMgaW4gb3RoZXIgYXJjaGl0ZWN0dXJlcywgd2hlcmUgdGhlIFBBIGlzIG5vdCBhdmFpbGFibGUu
Cj4+Cj4+IERvZXNuJ3QgX19wYSgpIHdvcmsgZm9yIGFsbCB0aGUgb3RoZXIgYXJjaGl0ZWN0dXJl
cz8gVGhhdCdzIHdoYXQgeW91cgo+PiBwYXRjaCBpbmRpY2F0ZXMuCj4+Cj4gCj4gWWVzLCBfX3Bh
KCkgd29ya3MgZm9yIGFsbCBvdGhlciBhcmNoaXRlY3R1cmVzLgo+IAo+IEJ1dCB3ZSB3b3VsZCBu
ZWVkIHRvIGFkZCBpbml0aWFsX2Jvb3RfcGFyYW1zX3BhIG9mIHR5cGUgcGh5c19hZGRyX3QKPiBh
cyBhbiBhcmd1bWVudCBmb3IgZWFybHlfaW5pdF9kdF9zY2FuLCB3aGljaCBpcyBjYWxsZWQgYnkg
YWxsIG90aGVyIGFyY2hzLAo+IGFuZCB3ZSB0ZWNobmljYWxseSBjYW50IHVzZSAwIGFzIGFuIGlu
dmFsaWQgdmFsdWUuCj4gCj4gV2UgY291bGQgY29udmVydCBpbml0aWFsX2Jvb3RfcGFyYW1zX3Bh
IHRvIHZvaWQgKiwgYW5kIHBhc3MgTlVMTCBmb3IgYWxsCj4gb3RoZXIgYXJjaHMuIEJ1dCBhZ2Fp
biwgSSBkb24ndCByZWFsbHkgdGhpbmsgd2Ugc2hvdWxkIGJlIGNoYW5naW5nIHRoZQo+IGVhcmx5
X2luaXRfZHRfc2NhbihkdF92aXJ0KSBjYWxsIGluIGFsbCBvdGhlciBhcmNocyB0bwo+IGVhcmx5
X2luaXRfZHRfc2NhbihkdF92aXJ0LCBOVUxMKSBqdXN0IHRvIHNhdmUgaW5pdGlhbF9ib290X3Bh
cmFtc19wYQo+IGluIGFybTY0Pwo+IAo+Pj4gU28gaXQgbWFrZXMgaXQgcXVpdGUgbWVzc3kgdG8g
c2V0IGl0IGluIHRoZSBzYW1lIHBsYWNlIGFzIGluaXRpYWxfYm9vdF9wYXJhbXMuCj4+PiBJdHMg
b25seSBuZWVkZWQgZm9yIGFybTY0IGFuZCBtYWtpbmcgYSBjaGFuZ2UgaW4gYWxsIGFyY2hzIHBy
b2JhYmx5IGlzbnQgYSBnb29kIGlkZWE/Cj4+Pgo+Pj4gQW55IHJlYXNvbiB0byBub3QgYWRkIGEg
bmV3IGZ1bmN0aW9uIHRvIG1ha2UgYXJjaCAtPiBvZi9mZHQgY2FsbD8KPj4KPj4gWWVzLiBJdCBp
cyB0aGUgb3Bwb3NpdGUgZGlyZWN0aW9uIEkgaGF2ZSByZXdvcmtlZCB0aGUgaW50ZXJmYWNlcyB0
by4KPj4gV2UgZG9uJ3Qgd2FudCBlYWNoIGFyY2ggY2FsbGluZyB2YXJpb3VzIGVhcmx5IERUIGZ1
bmN0aW9ucyBhdCByYW5kb20KPj4gdGltZXMgYW5kIG9yZGVyLiBUaGF0J3MgZnJhZ2lsZSB3aGVu
IHRoZSBEVCBmdW5jdGlvbnMgbWFrZSBhc3N1bXB0aW9ucwo+PiBhYm91dCB3aGVuIHRoZXkgYXJl
IGNhbGxlZCBvciB3aGF0J3MgYmVlbiBpbml0aWFsaXplZCBhbHJlYWR5Lgo+Pgo+PiBBbm90aGVy
IG9wdGlvbiBpcyB0byBtYWtlIGFybTY0IGNvcHkgdGhlIERUIGFzIHNvbWUgYXJjaGVzIGRvLgo+
Pgo+PiBSb2IKPiAKPiBBaCBtYXliZSBJIGRpZG4ndCB1bmRlcnN0YW5kIHRoaXMgcHJvcGVybHks
IGJ1dCBpc250IGVhcmx5X2luaXRfZHRfc2NhbiBhbgo+IGFyY2ggLT4gb2YvZmR0IGludGVyZmFj
ZXMuIHNldF9pbml0aWFsX2Jvb3RfcGFyYW1zX3BhIGlzIGEgc2ltaWxhciBpbnRlcmZhY2UKPiB0
byBlYXJseV9pbml0X2R0X3NjYW4/CgpIaSwKCkp1c3Qgd2FudGVkIHRvIGNoZWNrIGluIG9uIGFi
b3ZlLiBJIGZlZWwgd2hhdCBJIGFtIGRvaW5nIGhlcmUgaXMgc2ltaWxhciB0bwplYXJseV9pbml0
X2R0X3NjYW4gc28gc2hvdWxkIGJlIG9rPyBUaGVyZSBpcyBqdXN0IGEgc21hbGwgY29tbWVudCBm
cm9tIFNhcmF2YW5hCnRoYXQgSSBuZWVkIHRvIGFkZHJlc3Mgd2hpY2ggSSBjYW4gaW4gdjIsIGJ1
dCB3YW50ZWQgdG8gY2hlY2sgb24gYWJvdmUgYmVmb3JlCnNlbmRpbmcgaXQuCgpUaGFua3MsClVz
YW1hCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
