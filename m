Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180D9C43334
	for <kexec@archiver.kernel.org>; Sat,  2 Jul 2022 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Xbsbvp+peoXKdNi+JRSDWnCxDYaq+YtCjHnUmVwmRM=; b=kqGZap7CSPlBVT
	UZJ0QENKBYOyBEdlyd0buOLQrU+ZMVdH9fmB3rZXaTKW+wyM48Y7UDnXHDbMkhpJ9JAOSPCYUMLFF
	7QnVGy892GqeTaxkRPcFBVgGZInhsyU049u/ac9qdKQnXUmvk8xkSsMPd2OLjVXR6zOMYiYOH3ABE
	VAkNpchgye0R9fpnxprfLaXlxGaxZwY4c+5clGo4Bk/baq62dTpm/g47bf8IsZJFO9I6sCncwZgmf
	XhQZEqHV3K5YNjBXp79R/ERvDWK4vY9sG8KIM4/H7gU2QRh5Glzq7A6ave7nquTF9pfZNQFBrIzbv
	5eMiS3kdDcFt2VLTMHOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7bPQ-009IWY-EE; Sat, 02 Jul 2022 11:35:32 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7bPJ-009IV4-O0; Sat, 02 Jul 2022 11:35:27 +0000
Received: by mail-ot1-x32b.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so3853708otb.5;
        Sat, 02 Jul 2022 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RFiZUZZVdPzHI8JLiBXe+pUN/57tquJciO81AmMC/BA=;
        b=KN9aXvzietpOoqWtAuIT0/EzLMIFdo7EYJ/20eohQO81UE88xxD8ZynwS5k+eo/5SN
         dVTumsABhTmdi2CmOJdK74+S2kQgl3RZHRjK8aScYGcxEXdtrglRS87eTj7viWNzJpEh
         QnUgEHHfAxWjo+KqHLhaHX10e5sXWmzcWDgb82M0mj/OhB8tVmLsNcsV0HVfT+q5ajop
         8dlMEithwF8n6HlHSVvtLg7vXY61FyOBLwVd+i0oHumWidm87Unh98UmW7ioSbq1rr3A
         j+0eDVcwMHzDlpzoWZJ0GEs4kVw1nxjDXNYpQh6RJ8JxTo6Vuy9PNFgNHaHI3vTitvnl
         cc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RFiZUZZVdPzHI8JLiBXe+pUN/57tquJciO81AmMC/BA=;
        b=dluzE60e4S+Xe94BkArXdlBherDUOKQHY/C2O7YXOQ6Pd25aeoBXADMJOxBX5ttgJ7
         AUJAOfQVpV2fYWgItn8oLKzhgMzgP1VfnQH43hRJp29QYDAXVJvCrFhv2ZN47Ni0xEDq
         rPxFydOm0R2FwdnF41xUN6GtgeUDs97666dBH6hT97NYZKhKt780IV9EzpaKmIq+rIK9
         UGiYQJy4kJyY8WxP5GII+ZUMKpr1nZrLKfwCvFfSJSimNzxcguRv65EqG5/+n1pr2Eq7
         JmQXnv8LCv2UaaIYyqCH0qIXi/hZzNUlw38f0FbpyboYBq1rsKitkKnt2r60jK/vQU+/
         9xMA==
X-Gm-Message-State: AJIora+5di7WrHMqnckqnILB5v9jm/9+Ya6NLp/qBzpJU+ua6GIuJmxF
	/OctXUf8r21H38XKlLhhNjxYTmwVbd9vlhAsltY=
X-Google-Smtp-Source: AGRyM1uobC4dAaGgs7nDWylHgtCkJQNwSOTPhM+xTt0IrwNmqp6vfZopMuDjj62vnVBzuVqlh6hwKIyO9jvlBgEXOVU=
X-Received: by 2002:a05:6830:2692:b0:618:b992:cbc9 with SMTP id
 l18-20020a056830269200b00618b992cbc9mr5668496otu.117.1656761723858; Sat, 02
 Jul 2022 04:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr> <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
 <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr>
In-Reply-To: <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr>
From: Yixun Lan <yixun.lan@gmail.com>
Date: Sat, 2 Jul 2022 11:35:12 +0000
Message-ID: <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To: Nick Kossifidis <mick@ics.forth.gr>
Cc: Alexandre Ghiti <alexandre.ghiti@canonical.com>, ebiederm@xmission.com, 
	kexec@lists.infradead.org, linux-riscv <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Alexandre ghiti <alex@ghiti.fr>, 
	Mike Rapoport <rppt@kernel.org>, geert+renesas@glider.be, 
	Stephano Cetola <scetola@linuxfoundation.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup.patel@wdc.com>, 
	Atish Patra <atish.patra@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220702_043525_848180_7BCE3F83 
X-CRM114-Status: GOOD (  39.40  )
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

aGkgTmljawoKT24gVGh1LCBOb3YgMjUsIDIwMjEgYXQgMTE6NDUgUE0gTmljayBLb3NzaWZpZGlz
IDxtaWNrQGljcy5mb3J0aC5ncj4gd3JvdGU6Cj4KPiDOo8+EzrnPgiAyMDIxLTEwLTE1IDEwOjA3
LCBBbGV4YW5kcmUgR2hpdGkgzq3Os8+BzrHPiM61Ogo+ID4gT24gU2F0LCBPY3QgOSwgMjAyMSBh
dCAzOjI1IFBNIE5pY2sgS29zc2lmaWRpcyA8bWlja0BpY3MuZm9ydGguZ3I+Cj4gPiB3cm90ZToK
PiA+Pgo+ID4+IM6jz4TOuc+CIDIwMjEtMTAtMDYgMTQ6MTAsIEFsZXhhbmRyZSBHaGl0aSDOrc6z
z4HOsc+IzrU6Cj4gPj4gPgo+ID4+ID4gU28gSSBmb2xsb3dlZCB0aGUgaW5zdHJ1Y3Rpb25zIGhl
cmU6Cj4gPj4gPiBodHRwczovL2RvY3VtZW50YXRpb24uc3VzZS5jb20vZnItZnIvc2xlcy8xMi1T
UDMvaHRtbC9TTEVTLWFsbC9jaGEtdHVuaW5nLWtleGVjLmh0bWwjY2hhLXR1bmluZy1rZXhlYy1i
YXNpYy11c2FnZSwKPiA+PiA+IGJlbG93IHRoZSBvdXRwdXQgb24gYW4gVW5tYXRjaGVkIGJvYXJk
IHVzaW5nIGEgdm1saW51eCBzdG9yZWQgb24gYSBzZAo+ID4+ID4gY2FyZDoKPiA+PiA+Cj4gPj4g
PiB1YnVudHVAdWJ1bnR1On4kIHN1ZG8gc2Jpbi9rZXhlYyAtbCB2bWxpbnV4IC0tYXBwZW5kPSIk
KGNhdAo+ID4+ID4gL3Byb2MvY21kbGluZSkiIC0taW5pdHJkPS9ib290L2luaXRyZC5pbWcKPiA+
PiA+IFdhcm5pbmc6IE5vIGNtZGxpbmUgcHJvdmlkZWQsIHVzaW5nIGFwcGVuZCBzdHJpbmcgYXMg
Y21kbGluZQo+ID4+ID4gV2FybmluZzogTm8gZHRiIHByb3ZpZGVkLCB1c2luZyAvc3lzL2Zpcm13
YXJlL2ZkdAo+ID4+ID4gWyAxODEzLjQ3MjY3MV0gSU5GTzogdGFzayBrd29ya2VyLzE6MDo5ODgg
YmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMAo+ID4+ID4gc2Vjb25kcy4KPiA+PiA+IFsgMTgxMy40
Nzg3NTFdICAgICAgIE5vdCB0YWludGVkIDUuMTUuMC1yYzErICMxNQo+ID4+ID4gWyAxODEzLjQ4
MzExMF0gImVjaG8gMCA+IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIK
PiA+PiA+IGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KPiA+PiA+IENvdWxkIG5vdCBmaW5kIGEgZnJl
ZSBhcmVhIG9mIG1lbW9yeSBvZiAweDMwMDAgYnl0ZXMuLi4KPiA+PiA+IGxvY2F0ZV9ob2xlIGZh
aWxlZAo+ID4+ID4KPiA+PiA+IEkgdXNlZCB0aGUgVWJ1bnR1IGtlcm5lbCwgc28gdGhpcyBpcyBw
cmV0dHkgbGFyZ2U6Cj4gPj4gPiAtcnd4cnd4ci14IDEgdWJ1bnR1IHVidW50dSAyNzdNIE9jdCAg
NSAxNTo0NyB2bWxpbnV4Cj4gPj4gPiAtcnctci0tci0tIDEgcm9vdCByb290IDk4TSBTZXAgMjEg
MDM6MjUgL2Jvb3QvaW5pdHJkLmltZwo+ID4+ID4KPiA+Pgo+ID4+IEFDSywgSSBoYXZlbid0IHRl
c3RlZCBpbml0cmQgbXVjaCBUQkgsIEkgdXN1YWxseSBkb24ndCB1c2UgYW4gaW5pdHJkLAo+ID4+
IGFuZCB3aGVuIEkgZG8gaXQncyBhIHNtYWxsIGJ1c3lib3gtYmFzZWQgcm9vdGZzLgo+ID4+Cj4g
Pj4gPiBUaGVuIGlmIEkgZG9uJ3QgbG9hZCB0aGUgaW5pdHJkIChJIHNvbWV0aW1lcyBoYXZlIHRo
ZSBzYW1lIHdhcm5pbmcgYXMKPiA+PiA+IGFib3ZlKSBJIGNhbiBhdCBsZWFzdCBrZXhlYyB0aGUg
bmV3IGtlcm5lbCBidXQgaXQgZmFpbHMgdG8gYm9vdDoKPiA+PiA+Cj4gPj4gPiB1YnVudHVAdWJ1
bnR1On4kIHN1ZG8gLi9zYmluL2tleGVjIC1lCj4gPj4gPiBXYXJuaW5nOiBObyBjbWRsaW5lIG9y
IGFwcGVuZCBzdHJpbmcgcHJvdmlkZWQKPiA+PiA+IFdhcm5pbmc6IE5vIGR0YiBwcm92aWRlZCwg
dXNpbmcgL3N5cy9maXJtd2FyZS9mZHQKPiA+PiA+IFsuLi5dCj4gPj4gPiBbICAgIDAuMDAwMDAw
XSBTQkkgdjAuMiBIU00gZXh0ZW5zaW9uIGRldGVjdGVkCj4gPj4gPiBbICAgIDAuMDAwMDAwXSBD
UFUgd2l0aCBoYXJ0aWQ9MCBpcyBub3QgYXZhaWxhYmxlCj4gPj4gPiBbICAgIDAuMDAwMDAwXSAt
LS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KPiA+PiA+IFsgICAgMC4wMDAwMDBd
IGtlcm5lbCBCVUcgYXQgYXJjaC9yaXNjdi9rZXJuZWwvc21wYm9vdC5jOjEwNyEKPiA+PiA+IFsg
ICAgMC4wMDAwMDBdIEtlcm5lbCBCVUcgWyMxXQo+ID4+ID4gWyAgICAwLjAwMDAwMF0gTW9kdWxl
cyBsaW5rZWQgaW46Cj4gPj4gPiBbICAgIDAuMDAwMDAwXSBDUFU6IDAgUElEOiAwIENvbW06IHN3
YXBwZXIgTm90IHRhaW50ZWQgNS4xNS4wLXJjMSsgIzE1Cj4gPj4gPiBbICAgIDAuMDAwMDAwXSBI
YXJkd2FyZSBuYW1lOiBTaUZpdmUgSGlGaXZlIFVubWF0Y2hlZCBBMDAgKERUKQo+ID4+ID4gWyAg
ICAwLjAwMDAwMF0gZXBjIDogc2V0dXBfc21wKzB4Y2MvMHgxNDIKPiA+PiA+IFsgICAgMC4wMDAw
MDBdICByYSA6IHNldHVwX3NtcCsweGM0LzB4MTQyCj4gPj4gPiBbICAgIDAuMDAwMDAwXSBlcGMg
OiBmZmZmZmZmZjgwYTA0MDgwIHJhIDogZmZmZmZmZmY4MGEwNDA3OCBzcCA6Cj4gPj4gPiBmZmZm
ZmZmZjgxODAzZWMwCj4gPj4gPiBbICAgIDAuMDAwMDAwXSAgZ3AgOiBmZmZmZmZmZjgxYTIzMjIw
IHRwIDogZmZmZmZmZmY4MTgxMDUwMCB0MCA6Cj4gPj4gPiBmZmZmZmZmZjgxYTM1NTFmCj4gPj4g
PiBbICAgIDAuMDAwMDAwXSAgdDEgOiBmZmZmZmZmZmZmZmZmZmZmIHQyIDogMDAwMDAwMDAwMDAw
MDAwMCBzMCA6Cj4gPj4gPiBmZmZmZmZmZjgxODAzZjAwCj4gPj4gPiBbICAgIDAuMDAwMDAwXSAg
czEgOiAwMDAwMDAwMDAwMDAwMDAwIGEwIDogMDAwMDAwMDAwMDAwMDAwMCBhMSA6Cj4gPj4gPiAw
MDAwMDAwMDAwMDAwMDAwCj4gPj4gPiBbICAgIDAuMDAwMDAwXSAgYTIgOiAwMDAwMDAwMDAwMDAw
MDAwIGEzIDogMDAwMDAwMDAwMDAwMDAwMSBhNCA6Cj4gPj4gPiAwMDAwMDAwMDAwMDAwMDAwCj4g
Pj4gPiBbICAgIDAuMDAwMDAwXSAgYTUgOiBmZmZmZmZmZjgwYzY0NTAwIGE2IDogMDAwMDAwMDAw
MDAwMDAwNCBhNyA6Cj4gPj4gPiAwMDAwMDAwMDAwMDBmZjAwCj4gPj4gPiBbICAgIDAuMDAwMDAw
XSAgczIgOiAwMDAwMDAwMDAwMDAwMDA1IHMzIDogMDAwMDAwMDAwMDAwMDAwMCBzNCA6Cj4gPj4g
PiBmZmZmZmZmZjgxMThmOWE4Cj4gPj4gPiBbICAgIDAuMDAwMDAwXSAgczUgOiAwMDAwMDAwMDAw
MDAwMDA3IHM2IDogZmZmZmZmZmY4MGMwYjc5MCBzNyA6Cj4gPj4gPiAwMDAwMDAwMDgwMDAwMjAw
Cj4gPj4gPiBbICAgIDAuMDAwMDAwXSAgczggOiAwMDAwMDAwMDAwMDAwZmZmIHM5IDogMDAwMDAw
MDA4MTAwMDIwMCBzMTA6Cj4gPj4gPiAwMDAwMDAwMDAwMDAwMDE4Cj4gPj4gPiBbICAgIDAuMDAw
MDAwXSAgczExOiAwMDAwMDAwMDAwMDAwMDBiIHQzIDogMDAwMDAwMDAwMGZmMDAwMCB0NCA6Cj4g
Pj4gPiBmZmZmZmZmZmZmZmZmZmZmCj4gPj4gPiBbICAgIDAuMDAwMDAwXSAgdDUgOiBmZmZmZmZm
ZjgwYzBiN2EwIHQ2IDogZmZmZmZmZmY4MTgwM2JkOAo+ID4+ID4gWyAgICAwLjAwMDAwMF0gc3Rh
dHVzOiAwMDAwMDAwMjAwMDAwMTAwIGJhZGFkZHI6IDAwMDAwMDAwMDAwMDAwMDAKPiA+PiA+IGNh
dXNlOiAwMDAwMDAwMDAwMDAwMDAzCj4gPj4gPiBbICAgIDAuMDAwMDAwXSBbPGZmZmZmZmZmODBh
MDQwODA+XSBzZXR1cF9zbXArMHhjYy8weDE0Mgo+ID4+ID4gWyAgICAwLjAwMDAwMF0gWzxmZmZm
ZmZmZjgwYTAzZDg4Pl0gc2V0dXBfYXJjaCsweDU2YS8weDU5MAo+ID4+ID4gWyAgICAwLjAwMDAw
MF0gWzxmZmZmZmZmZjgwYTAwYWEyPl0gc3RhcnRfa2VybmVsKzB4YWEvMHhhNWMKPiA+PiA+IFsg
ICAgMC4wMDAwMDBdIHJhbmRvbTogZ2V0X3JhbmRvbV9ieXRlcyBjYWxsZWQgZnJvbQo+ID4+ID4g
b29wc19leGl0KzB4NDQvMHg3MCB3aXRoIGNybmdfaW5pdD0wCj4gPj4gPiBbICAgIDAuMDAwMDAw
XSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0KPiA+PiA+IFsgICAgMC4wMDAw
MDBdIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQgdG8ga2lsbCB0aGUgaWRs
ZQo+ID4+ID4gdGFzayEKPiA+PiA+IFsgICAgMC4wMDAwMDBdIC0tLVsgZW5kIEtlcm5lbCBwYW5p
YyAtIG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQgdG8ga2lsbAo+ID4+ID4gdGhlIGlkbGUgdGFzayEg
XS0tLQo+ID4+ID4KPiA+PiA+IFRoaXMgcmVsaWFibHkgZmFpbHMgaGVyZS4KPiA+PiA+Cj4gPj4K
PiA+PiBUaGlzIGxvb2tzIHdlaXJkLCBJJ2xsIGNoZWNrIGl0IG91dCAod2UgaGF2ZSBhbiB1bm1h
dGNoZWQgaGVyZSBzbyBJJ2xsCj4gPj4gdHJ5IHRvIGdldCBteSBoYW5kcyBvbiBpdCBzb21ldGlt
ZSBuZXh0IHdlZWspLgo+ID4+Cj4gPj4gRGlkIHlvdSB0cnkga2R1bXAgPyBEbyB5b3UgZ2V0IHRo
ZSBzYW1lIGVycm9yID8KPiA+Cj4gPiBrZHVtcCB3b3JrcyBmaW5lLCBpdCBmYWlscyB0byBmaW5k
IHRoZSByb290ZnMgYnV0IEkgdGhpbmsgbXkgc2V0dXAgaXMKPiA+IGZhdWx0eSBoZXJlLgo+ID4g
SSB0b29rIGEgcXVpY2sgbG9vayBhdCBrZXhlY19yZWxvY2F0ZS5TLCBhbmQgdGhlIHVzZSBvZiB2
YV9wYV9vZmZzZXQKPiA+IGlzIGFsc28gd3JvbmcgaGVyZSwgd2Ugc2hvdWxkIHVzZSB2YV9rZXJu
ZWxfcGFfb2Zmc2V0IGFzIGl0IGlzIHVzZWQgdG8KPiA+IG1vZGlmeSBhIHRleHQgYWRkcmVzcyBC
dXQgZml4aW5nIHRoYXQgZGlkIG5vdCB3b3JrIGVpdGhlci4KPiA+Cj4gPiBBbGV4Cj4gPgo+Cj4g
U29ycnkgZm9yIHRoZSBkZWxheSwgSSBmaW5hbGx5IGdvdCBzb21lIHRpbWUgdG8gd29yayBvbiB0
aGlzLiBBcyBpdAo+IHR1cm5zIG91dCBJJ20gcGFzc2luZyBjcHUgaWQgaW5zdGVhZCBvZiBoYXJ0
IGlkIHRvIHRoZSBuZXh0IGtlcm5lbCAodGhhdAo+IGNvbW1lbnQgb24gc21wLmggY2xhaW1pbmcg
dGhhdCByYXdfc21wX3Byb2Nlc3Nvcl9pZCByZXR1cm5zIHRoZSBoYXJ0IGlkCj4gZGlkbid0IGhl
bHAgbXVjaCkgYW5kIGludGVyZXN0aW5nbHkgZW5vdWdoIGNwdSBpZCBhbmQgaGFydCBpZCBtYXRj
aCBvbgo+IHFlbXUgYW5kIGFsc28gc29tZXRpbWVzIG1hdGNoIG9uIHRoZSB1bm1hdGNoZWQgLyB1
bmxlYXNoZWQgYm9hcmQuIEFsc28KPiBvbiB1bm1hdGNoZWQgLyB1bmxlYXNoZWQsIGhhcnQgaWQg
MCBpcyB1c2VkIGJ5IHRoZSBub24tbGludXggaGFydCBzbyBpZgo+IHdlIHBhc3MgdGhlIGNwdSBp
ZCBvZiB0aGUgYm9vdCBjcHUgdGhhdCdzIGFsd2F5cyBnb2luZyB0byBiZSAwIGl0J2xsIGJlCj4g
aW52YWxpZCwgYnV0IHRoYXQncyBub3QgYWx3YXlzIHRoZSBjYXNlLCBlc3BlY2lhbGx5IGZvciBr
ZHVtcC4gSSdtIGFsc28KPiBnZXR0aW5nIGFuIGVycm9yIHdoZW4gdHJ5aW5nIHRvIG1vdW50IHRo
ZSByb290ZnMgb24ga2R1bXAgb24gdGhlCj4gdW5tYXRjaGVkIGJvYXJkLCBiZWNhdXNlIHN3aW90
bGIgY2FuJ3QgYWxsb2NhdGUgYm91bmNlIGJ1ZmZlcnMgYW5kIHRoZQo+IHBjaWUgZHJpdmVyIGRv
ZXNuJ3Qgd29yaywgc28gbm8gbnZtZSBhY2Nlc3MuIEknbSBsb29raW5nIGZvciBhIHdheSB0bwo+
IG1ha2UgdGhpcyB3b3JrIHdpdGhvdXQgbWVzc2luZyB0aGluZ3MgdXAsIGluIGFueSBjYXNlIEkn
bGwgc2VuZCBzb21lCj4gcGF0Y2hlcyBvdmVyIHRoZSB3ZWVrZW5kLiBGb3IgdGhlIGluaXRyZCBp
c3N1ZSBJIG5lZWQgdG8gcGF0Y2gKPiBrZXhlYy10b29scy4KPgo+IFJlZ2FyZHMsCj4gTmljawo+
CgpwaW5nLCBhbnkgdXBkYXRlIGZvciB0aGlzPyBhbnkgbmV3IHBhdGNoIGZvciBrZXhlYy10b29s
cz8KCkknZCBhbHNvIGxpa2UgdG8gdHJ5IGtleGVjIG9uIHVubWF0Y2hlZCBib2FyZCwgYW5kIGVu
Y291bnRlciB0aGUgc2FtZSBlcnJvcgphcyBBbGV4YW5kcmUgR2hpdGkgcmVwb3J0ZWQsIGdlbmVy
YWxseSBJJ20gdXNpbmcgYWxtb3N0IHNhbWUgY21kbGluZQoKWWl4dW4gTGFuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
