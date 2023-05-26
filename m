Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EC2C7EE23
	for <kexec@archiver.kernel.org>; Fri, 26 May 2023 09:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2IZXfeg7oADjOshQYvTtjBYVLuPk/L+kNyLgMUUm8GI=; b=y/QhZG0Qf57F5N
	onlhCpqSQ3YuyIxuC8XcpGFAodVZXRUcgl20dlfXltWopHyssbiKjYjVIYFYQUHpVwyc4j1t+3LKI
	kGopYd0atxTvv/RymxWwYNfq/Qvv2HPHtInPaePcaprghIHwhH/275w7NDTQAOFY2Dqr+9ZcuelCu
	+ZoQ4I1LB0hGiamaqmK8pmUjQ2oVYPZQzcmVphRdA+1rukAcDI56Kxx5eJa78KJCqs1hVZCfvHhQm
	lXZ4uEC3CGc59mVglwHyLVE7GOa4c4CDIKqh1or0fDuJwNCG6UhiAUjV+lWq+bZAs7v/S+BV04Tcz
	oWEOxuArjF5bH8r5vV9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2UAu-001uuu-1n;
	Fri, 26 May 2023 09:55:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2UAr-001utg-2T
	for kexec@lists.infradead.org;
	Fri, 26 May 2023 09:55:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685094951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYCtA4RZQ08M+9pUkzTh3dY/9or9x6h7PoJOQ6GY4XM=;
	b=V9Zx2JtCp7kzl4w1w5garNMv1MM8OeF5kLpP2O7LHPLCON1B15OhaB6KWQhXvzWr/ynSRK
	NL1AjYMrqwunbtnB5mEF07Op89txSUHE1KrMUuuVEdtxK1JOJXZvJdrFdqAAWzKhnpfEQO
	19jdzkU3Wz7G2qr7CZ8NR2LMKttzyLQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-rms_c5TVMX6UMMCk_Ku-Vg-1; Fri, 26 May 2023 05:55:47 -0400
X-MC-Unique: rms_c5TVMX6UMMCk_Ku-Vg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-96f46e5897eso68482166b.3
        for <kexec@lists.infradead.org>; Fri, 26 May 2023 02:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685094946; x=1687686946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYCtA4RZQ08M+9pUkzTh3dY/9or9x6h7PoJOQ6GY4XM=;
        b=SUHq1CaDanBuK6fGIuK9wSvVLqEm9m7qRFCy0mqndSanu7T0Y6zrQpEPdSExw8Jzi3
         ta0F96xajBdfxTdoTzpJBJs4HtEZrVEuDY//slcVa0QUmVP7JL2vaJzmK1U99nxNugiU
         j6B/pJfu9k/MjvXOYZ2CH1KUZAfSnyPBeng10y1EPHB5iBBTkgCa7w8Mx9A56x9Nqa2d
         SROs4D8gURE+uFx8UlHVny6QQ35KuS/4sDzZduLTGqRKhbEgKhxJr5cJVyRPXCOOJ8fx
         YLYFXHqEDYzmQDw8BVi3f861HNKjcTLoaEa+vWZJlt6wiDU45bK4pmsfyBlud/apcAn0
         zvyQ==
X-Gm-Message-State: AC+VfDxYaA/UvVFV80mDh5eKHqpPA+rRPDAuAeNnO/LXt4LPi03u63x5
	WvXcmpVhGFH7Aus1fgXKFSzeO6sfF5OL/u++lBdaBs0p2oHYk9gpJlzbSpCinjdgfvS8IJRAUsy
	gWIithIw21/O5uwoMwq9ipY73jIHqh0g++4Me
X-Received: by 2002:a17:906:58d3:b0:973:9522:c678 with SMTP id e19-20020a17090658d300b009739522c678mr1369556ejs.44.1685094946042;
        Fri, 26 May 2023 02:55:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zyHI44awmTn8JJhvOigbX6gmkA/LYXh0At/QzSDwuoAqvtAV8YEuh0jwMPf9fYx86u8OL8wESu6iTQJ2/QyM=
X-Received: by 2002:a17:906:58d3:b0:973:9522:c678 with SMTP id
 e19-20020a17090658d300b009739522c678mr1369536ejs.44.1685094945667; Fri, 26
 May 2023 02:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230525094914.23420-1-ltao@redhat.com> <ZHAwpL3wbKX9sWep@MiWiFi-R3L-srv>
In-Reply-To: <ZHAwpL3wbKX9sWep@MiWiFi-R3L-srv>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 26 May 2023 17:55:09 +0800
Message-ID: <CAO7dBbWhE3yqGk1szKF-7rH1Gk6uAEnLuMVCqqCwwctcrvpiNw@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Baoquan He <bhe@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, dyoung@redhat.com, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_025553_876618_AEF42BB4 
X-CRM114-Status: GOOD (  33.08  )
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

SGkgQmFvcXVhbiwKCk9uIEZyaSwgTWF5IDI2LCAyMDIzIGF0IDEyOjA44oCvUE0gQmFvcXVhbiBI
ZSA8YmhlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gSGkgVGFvLAo+Cj4gT24gMDUvMjUvMjMgYXQg
MDU6NDlwbSwgVGFvIExpdSB3cm90ZToKPiA+IEEga2V4ZWMga2VybmVsIGJvb3R1cCBoYW5nIGlz
IG9ic2VydmVkIG9uIEludGVsIEF0b20gY3B1IGR1ZSB0byB1bm1hcHBlZAo+ID4gRUZJIGNvbmZp
ZyB0YWJsZS4KPiA+Cj4gPiBDdXJyZW50bHkgRUZJIHN5c3RlbSB0YWJsZSBpcyBpZGVudGl0eS1t
YXBwZWQgZm9yIHRoZSBrZXhlYyBrZXJuZWwsIGJ1dCBFRkkKPiA+IGNvbmZpZyB0YWJsZSBpcyBu
b3QgbWFwcGVkIGV4cGxpY2l0bHk6Cj4gPgo+ID4gICAgIGNvbW1pdCA2YmJlYjI3NmI3MWYgKCJ4
ODYva2V4ZWM6IEFkZCB0aGUgRUZJIHN5c3RlbSB0YWJsZXMgYW5kIEFDUEkKPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdGFibGVzIHRvIHRoZSBpZGVudCBtYXAiKQo+ID4KPiA+IExhdGVy
IGluIHRoZSBmb2xsb3dpbmcgMiBjb21taXRzLCBFRkkgY29uZmlnIHRhYmxlIHdpbGwgYmUgYWNj
ZXNzZWQgd2hlbgo+ID4gZW5hYmxpbmcgc2V2IGF0IGtlcm5lbCBzdGFydHVwLiBUaGlzIG1heSBy
ZXN1bHQgaW4gYSBwYWdlIGZhdWx0IGR1ZSB0byBFRkkKPiA+IGNvbmZpZyB0YWJsZSdzIHVubWFw
cGVkIGFkZHJlc3MuIFNpbmNlIHRoZSBwYWdlIGZhdWx0IG9jY3VycyBhdCBhbiBlYXJseQo+ID4g
c3RhZ2UsIGl0IGlzIHVucmVjb3ZlcmFibGUgYW5kIGtlcm5lbCBoYW5ncy4KPiA+Cj4gPiAgICAg
Y29tbWl0IGVjMWM2NmFmM2EzMCAoIng4Ni9jb21wcmVzc2VkLzY0OiBEZXRlY3Qvc2V0dXAgU0VW
L1NNRSBmZWF0dXJlcwo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBlYXJsaWVyIGR1cmlu
ZyBib290IikKPiA+ICAgICBjb21taXQgYzAxZmNlOWNlZjg0ICgieDg2L2NvbXByZXNzZWQ6IEFk
ZCBTRVYtU05QIGZlYXR1cmUKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV0ZWN0aW9u
L3NldHVwIikKPiA+Cj4gPiBJbiBhZGRpdGlvbiwgdGhlIGlzc3VlIGRvZXNuJ3QgYXBwZWFyIG9u
IGFsbCBzeXN0ZW1zLCBiZWNhdXNlIHRoZSBrZXhlYwo+ID4ga2VybmVsIHVzZXMgUGFnZSBTaXpl
IEV4dGVuc2lvbiAoUFNFKSBmb3IgaWRlbnRpdHkgbWFwcGluZy4gSW4gbW9zdCBjYXNlcywKPiA+
IEVGSSBjb25maWcgdGFibGUgY2FuIGVuZCB1cCB0byBiZSBtYXBwZWQgaW50byBkdWUgdG8gMSBH
QiBwYWdlIHNpemUuCj4gPiBIb3dldmVyIGlmIG5vZ2JwYWdlcyBpcyBzZXQsIG9yIGNwdSBkb2Vz
bid0IHN1cHBvcnQgcGRwZTFnYiBmZWF0dXJlCj4gPiAoZS5nIEludGVsIEF0b20geDY0MjVSRSBj
cHUpLCBFRkkgY29uZmlnIHRhYmxlIG1heSBub3QgYmUgbWFwcGVkIGludG8KPiA+IGR1ZSB0byAy
IE1CIHBhZ2Ugc2l6ZSwgdGh1cyBhIHBhZ2UgZmF1bHQgaGFuZyBpcyBtb3JlIGxpa2VseSB0byBo
YXBwZW4uCj4gPgo+ID4gSW4gdGhpcyBwYXRjaCwgd2Ugd2lsbCBtYWtlIHN1cmUgdGhlIEVGSSBj
b25maWcgdGFibGUgaXMgYWx3YXlzIG1hcHBlZC4KPgo+IE5pY2Ugd29yay4gV2hpbGUgeW91IG1h
eSBuZWVkIHRvIHJlcGhyYXNlIGFib3ZlIHNlbnRlbmNlLCB4ODYKPiBtYWludGFpbmVycyBkb24n
dCBsaWtlIGxvZyB3aXRoIHRoZSAndGhpcyBwYXRjaCwnIG9yICd3ZScuIFBsZWFzZSByZWZlcgo+
IHRvICdDaGFuZ2Vsb2cnIHBhcnQgb2YgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL21haW50YWluZXIt
dGlwLnJzdCBhbmQKPiBpbXByb3ZlIGl0LgoKT0ssIFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24h
IEkgd2lsbCBnZXQgdGhlIHNlbnRlbmNlIHJlcGhyYXNlZCBpbiB2Mi4KCj4KPiA+Cj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBUYW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICBhcmNoL3g4
Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jCj4gPiBpbmRleCAxYTNlMmMw
NWE4YTUuLjc1NWFhMTJmNTgzZiAxMDA2NDQKPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9tYWNo
aW5lX2tleGVjXzY0LmMKPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0
LmMKPiA+IEBAIC0yOCw2ICsyOCw3IEBACj4gPiAgI2luY2x1ZGUgPGFzbS9zZXR1cC5oPgo+ID4g
ICNpbmNsdWRlIDxhc20vc2V0X21lbW9yeS5oPgo+ID4gICNpbmNsdWRlIDxhc20vY3B1Lmg+Cj4g
PiArI2luY2x1ZGUgPGFzbS9lZmkuaD4KPiA+Cj4gPiAgI2lmZGVmIENPTkZJR19BQ1BJCj4gPiAg
LyoKPiA+IEBAIC04NiwxMCArODcsMTIgQEAgY29uc3Qgc3RydWN0IGtleGVjX2ZpbGVfb3BzICog
Y29uc3Qga2V4ZWNfZmlsZV9sb2FkZXJzW10gPSB7Cj4gPiAgI2VuZGlmCj4gPgo+ID4gIHN0YXRp
YyBpbnQKPiA+IC1tYXBfZWZpX3N5c3RhYihzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5mbywg
cGdkX3QgKmxldmVsNHApCj4gPiArbWFwX2VmaV9zeXNfY2ZnX3RhYihzdHJ1Y3QgeDg2X21hcHBp
bmdfaW5mbyAqaW5mbywgcGdkX3QgKmxldmVsNHApCj4KPiBDYW4gd2UgY2FsbCB0aGUgZnVuY3Rp
b24gbWFwX2VmaV90YWJsZXMoKSBzaW5jZSB3ZSB3aWxsIG1hcCBlZmkgc3lzdGVtCj4gdGFibGUs
IHN5c3RlbSBjb25maWcgdGFibGUuIElmIHlvdSBuZWVkIGFkZCBhbm90aGVyIHRhYmxlIG1hcHBp
bmcgaGVyZSwKPiB3aGF0IHdvdWxkIHlvdSBjYWxsIGl0LCBtYXBfZWZpX3N5c19jZmdfeHh4X3Rh
YigpPwo+CgpZZWFoLCBtYXBfZWZpX3N5c19jZmdfeHh4X3RhYigpIGlzIHN1cmVseSBhIGJhZCBu
YW1lLiBJIGFncmVlIHdpdGggdGhlCm1hcF9lZmlfdGFibGVzKCkgbmFtZS4KClRoYW5rcywKVGFv
IExpdQoKPiBBbnl3YXksIG5vdCB2ZXJ5IHN0cm9uZyBvcGluaW9uIGFzIGxvbmcgYXMgeDg2IG1h
aW50YWluZXIgbGlrZXMgaXQuCj4KPiA+ICB7Cj4gPiAgI2lmZGVmIENPTkZJR19FRkkKPiA+ICAg
ICAgIHVuc2lnbmVkIGxvbmcgbXN0YXJ0LCBtZW5kOwo+ID4gKyAgICAgdm9pZCAqa2FkZHI7Cj4g
PiArICAgICBpbnQgcmV0Owo+ID4KPiA+ICAgICAgIGlmICghZWZpX2VuYWJsZWQoRUZJX0JPT1Qp
KQo+ID4gICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+IEBAIC0xMDUsNiArMTA4LDMwIEBAIG1h
cF9lZmlfc3lzdGFiKHN0cnVjdCB4ODZfbWFwcGluZ19pbmZvICppbmZvLCBwZ2RfdCAqbGV2ZWw0
cCkKPiA+ICAgICAgIGlmICghbXN0YXJ0KQo+ID4gICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+
Cj4gPiArICAgICByZXQgPSBrZXJuZWxfaWRlbnRfbWFwcGluZ19pbml0KGluZm8sIGxldmVsNHAs
IG1zdGFydCwgbWVuZCk7Cj4gPiArICAgICBpZiAocmV0KQo+ID4gKyAgICAgICAgICAgICByZXR1
cm4gcmV0Owo+ID4gKwo+ID4gKyAgICAga2FkZHIgPSBtZW1yZW1hcChtc3RhcnQsIG1lbmQgLSBt
c3RhcnQsIE1FTVJFTUFQX1dCKTsKPiA+ICsgICAgIGlmICgha2FkZHIpIHsKPiA+ICsgICAgICAg
ICAgICAgcHJfZXJyKCJDb3VsZCBub3QgbWFwIFVFRkkgc3lzdGVtIHRhYmxlXG4iKTsKPiA+ICsg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4gPiArICAgICB9Cj4gPiArCj4gPiArICAgICBt
c3RhcnQgPSBlZmlfY29uZmlnX3RhYmxlOwo+ID4gKwo+ID4gKyAgICAgaWYgKGVmaV9lbmFibGVk
KEVGSV82NEJJVCkpIHsKPiA+ICsgICAgICAgICAgICAgZWZpX3N5c3RlbV90YWJsZV82NF90ICpz
dGJsID0gKGVmaV9zeXN0ZW1fdGFibGVfNjRfdCAqKWthZGRyOwo+ID4gKwo+ID4gKyAgICAgICAg
ICAgICBtZW5kID0gbXN0YXJ0ICsgc2l6ZW9mKGVmaV9jb25maWdfdGFibGVfNjRfdCkgKiBzdGJs
LT5ucl90YWJsZXM7Cj4gPiArICAgICB9IGVsc2Ugewo+ID4gKyAgICAgICAgICAgICBlZmlfc3lz
dGVtX3RhYmxlXzMyX3QgKnN0YmwgPSAoZWZpX3N5c3RlbV90YWJsZV8zMl90ICopa2FkZHI7Cj4g
PiArCj4gPiArICAgICAgICAgICAgIG1lbmQgPSBtc3RhcnQgKyBzaXplb2YoZWZpX2NvbmZpZ190
YWJsZV8zMl90KSAqIHN0YmwtPm5yX3RhYmxlczsKPiA+ICsgICAgIH0KPiA+ICsKPiA+ICsgICAg
IG1lbXVubWFwKGthZGRyKTsKPiA+ICsKPiA+ICAgICAgIHJldHVybiBrZXJuZWxfaWRlbnRfbWFw
cGluZ19pbml0KGluZm8sIGxldmVsNHAsIG1zdGFydCwgbWVuZCk7Cj4gPiAgI2VuZGlmCj4gPiAg
ICAgICByZXR1cm4gMDsKPiA+IEBAIC0yNDQsMTAgKzI3MSwxMCBAQCBzdGF0aWMgaW50IGluaXRf
cGd0YWJsZShzdHJ1Y3Qga2ltYWdlICppbWFnZSwgdW5zaWduZWQgbG9uZyBzdGFydF9wZ3RhYmxl
KQo+ID4gICAgICAgfQo+ID4KPiA+ICAgICAgIC8qCj4gPiAtICAgICAgKiBQcmVwYXJlIEVGSSBz
eXN0YWIgYW5kIEFDUEkgdGFibGVzIGZvciBrZXhlYyBrZXJuZWwgc2luY2UgdGhleSBhcmUKPiA+
IC0gICAgICAqIG5vdCBjb3ZlcmVkIGJ5IHBmbl9tYXBwZWQuCj4gPiArICAgICAgKiBQcmVwYXJl
IEVGSSBzeXN0YWIsIGNvbmZpZyB0YWJsZSBhbmQgQUNQSSB0YWJsZXMgZm9yIGtleGVjIGtlcm5l
bAo+ID4gKyAgICAgICogc2luY2UgdGhleSBhcmUgbm90IGNvdmVyZWQgYnkgcGZuX21hcHBlZC4K
PiA+ICAgICAgICAqLwo+ID4gLSAgICAgcmVzdWx0ID0gbWFwX2VmaV9zeXN0YWIoJmluZm8sIGxl
dmVsNHApOwo+ID4gKyAgICAgcmVzdWx0ID0gbWFwX2VmaV9zeXNfY2ZnX3RhYigmaW5mbywgbGV2
ZWw0cCk7Cj4gPiAgICAgICBpZiAocmVzdWx0KQo+ID4gICAgICAgICAgICAgICByZXR1cm4gcmVz
dWx0Owo+ID4KPiA+IC0tCj4gPiAyLjMzLjEKPiA+Cj4KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
