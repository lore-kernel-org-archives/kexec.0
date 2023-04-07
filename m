Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBF8C76196
	for <kexec@archiver.kernel.org>; Fri,  7 Apr 2023 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Pdpep43lEVPzEBs2CrWvvekmBd3kqYOB9qkmAGSeCk=; b=KFcNSQd1g4+xc9
	ppNpfJ6UPwdRGFvuVrm22dqah668bBwPqBCfzMsc1C/eJyA/0rXZtc37ABBHD7epqIdbC8sSIOghP
	uUBFoZmuPLywkLJyE7lz82uUEXTegWVV8HaUZNJR5pZKjGizKrZsF8Bz+KETbmGOWPNJkOFFAEQYU
	38LrBrgYUSxn3Rd/mrOZUSTNsXqq31f9LkSITH+FRE8EakA1iWBM6AgmvUoNX3dxG/LHJHKvvnAnJ
	fgDmQEa/mTJnAa1bG7Kq7CkveNK+Y0MOnRG11j9f1TLro8r1Xff7MxC13J/onkAKGE9AVIpm7JjYT
	12NeBxsMZrESCYUaeSOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkhYX-009Vsa-04;
	Fri, 07 Apr 2023 08:34:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkhYU-009VrN-1U;
	Fri, 07 Apr 2023 08:34:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AB81264A15;
	Fri,  7 Apr 2023 08:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD7CC433A8;
	Fri,  7 Apr 2023 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680856484;
	bh=WJH5Kn+G+Mpn2d43oNBGeROdsHIA2VvrZQA7fMNx0lg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uGTYH2xcdt+o04q0JPEsqFu72dRr+q44w5Rkn+deddTQ6rGjATvbkJGoVKU2fVDn5
	 bwJ6FfevUOakhBnl4Fo/FetmziQumwa7nZFsxiLw2EpEyOY92XuJfPFancW08Svvby
	 zbMHwvR/cczv5V6T9Dsdrzno1rcg78Hm34knkrS84snfJHT0qk8iMXgDClykR719TI
	 yuVUHvC6ksIPpG0oy2gpaA0mYtiX+l7bpNezV03k1BiKYw/+Zpcli4SRe4wzABq4y0
	 IROpo1Gp5N6ZLaY5+qdyoOciD2/XYNAn6HtN+hpLbvITS2ioWl0zY+mjFkL25loysK
	 DEAHSB2chZt4A==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-4c025e10b32so1595715a12.0;
        Fri, 07 Apr 2023 01:34:44 -0700 (PDT)
X-Gm-Message-State: AAQBX9dUWgnJ0BTjOnkhGr7M9AC3qBpKJg5wozHVnTQ4IJKhGRB9GFC5
	to2mo/rdIwxf5ZFtDcx0nzAP9udo2DFIMEWo/nA=
X-Google-Smtp-Source: AKy350ZkAgTWHQwTncWH37YSTupT2jbEF7Bd7DZ3BElkwFqpJ5PRGZc35iYbOigftxmXdOqn0uQrzQtqlRb23I5eMlI=
X-Received: by 2002:aa7:dcc4:0:b0:4f9:deb4:b97f with SMTP id
 w4-20020aa7dcc4000000b004f9deb4b97fmr1942589edu.13.1680856482789; Fri, 07 Apr
 2023 01:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230406220206.3067006-1-chenjiahao16@huawei.com> <20230406220206.3067006-3-chenjiahao16@huawei.com>
In-Reply-To: <20230406220206.3067006-3-chenjiahao16@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 7 Apr 2023 16:34:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR-3a6X2_XPWzOaDdfMehQnQhU0aAxOXOPqOJ=CM5fFUw@mail.gmail.com>
Message-ID: <CAJF2gTR-3a6X2_XPWzOaDdfMehQnQhU0aAxOXOPqOJ=CM5fFUw@mail.gmail.com>
Subject: Re: [PATCH -next v3 2/2] docs: kdump: Update the crashkernel
 description for riscv
To: Chen Jiahao <chenjiahao16@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, conor.dooley@microchip.com, 
	heiko@sntech.de, bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org, 
	atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com, 
	horms@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_013446_575342_31D41F4D 
X-CRM114-Status: GOOD (  22.34  )
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

UmV2aWV3ZWQtYnk6IEd1byBSZW4gPGd1b3JlbkBrZXJuZWwub3JnPgoKT24gVGh1LCBBcHIgNiwg
MjAyMyBhdCAxMDowNeKAr1BNIENoZW4gSmlhaGFvIDxjaGVuamlhaGFvMTZAaHVhd2VpLmNvbT4g
d3JvdGU6Cj4KPiBOb3cgImNyYXNoa2VybmVsPSIgcGFyYW1ldGVyIG9uIHJpc2N2IGhhcyBiZWVu
IHVwZGF0ZWQgdG8gc3VwcG9ydAo+IGNyYXNoa2VybmVsPVgsW2hpZ2gsbG93XS4gVGhyb3VnaCB3
aGljaCB3ZSBjYW4gcmVzZXJ2ZSBtZW1vcnkgcmVnaW9uCj4gYWJvdmUvd2l0aGluIDMyYml0IGFk
ZHJlc3NpYmxlIERNQSB6b25lLgo+Cj4gSGVyZSB1cGRhdGUgdGhlIHBhcmFtZXRlciBkZXNjcmlw
dGlvbiBhY2NvcmRpbmdseS4KPgo+IFNpZ25lZC1vZmYtYnk6IENoZW4gSmlhaGFvIDxjaGVuamlh
aGFvMTZAaHVhd2VpLmNvbT4KPiAtLS0KPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJu
ZWwtcGFyYW1ldGVycy50eHQgfCAxNSArKysrKysrKy0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0RvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0Cj4gaW5kZXggNTQ3MDJiZDQ4OGViLi40
MTg2NWFhZTllYWEgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJu
ZWwtcGFyYW1ldGVycy50eHQKPiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5l
bC1wYXJhbWV0ZXJzLnR4dAo+IEBAIC04NjYsNyArODY2LDcgQEAKPiAgICAgICAgICAgICAgICAg
ICAgICAgICBtZW1vcnkgcmVnaW9uIFtvZmZzZXQsIG9mZnNldCArIHNpemVdIGZvciB0aGF0IGtl
cm5lbAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGltYWdlLiBJZiAnQG9mZnNldCcgaXMgb21p
dHRlZCwgdGhlbiBhIHN1aXRhYmxlIG9mZnNldAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlz
IHNlbGVjdGVkIGF1dG9tYXRpY2FsbHkuCj4gLSAgICAgICAgICAgICAgICAgICAgICAgW0tOTCwg
WDg2LTY0LCBBUk02NF0gU2VsZWN0IGEgcmVnaW9uIHVuZGVyIDRHIGZpcnN0LCBhbmQKPiArICAg
ICAgICAgICAgICAgICAgICAgICBbS05MLCBYODYtNjQsIEFSTTY0LCBSSVNDVl0gU2VsZWN0IGEg
cmVnaW9uIHVuZGVyIDRHIGZpcnN0LCBhbmQKPiAgICAgICAgICAgICAgICAgICAgICAgICBmYWxs
IGJhY2sgdG8gcmVzZXJ2ZSByZWdpb24gYWJvdmUgNEcgd2hlbiAnQG9mZnNldCcKPiAgICAgICAg
ICAgICAgICAgICAgICAgICBoYXNuJ3QgYmVlbiBzcGVjaWZpZWQuCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgU2VlIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2R1bXAva2R1bXAucnN0IGZv
ciBmdXJ0aGVyIGRldGFpbHMuCj4gQEAgLTg3OSwxNCArODc5LDE0IEBACj4gICAgICAgICAgICAg
ICAgICAgICAgICAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC9rZHVtcC5yc3QgZm9y
IGFuIGV4YW1wbGUuCj4KPiAgICAgICAgIGNyYXNoa2VybmVsPXNpemVbS01HXSxoaWdoCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgW0tOTCwgWDg2LTY0LCBBUk02NF0gcmFuZ2UgY291bGQgYmUg
YWJvdmUgNEcuIEFsbG93IGtlcm5lbAo+IC0gICAgICAgICAgICAgICAgICAgICAgIHRvIGFsbG9j
YXRlIHBoeXNpY2FsIG1lbW9yeSByZWdpb24gZnJvbSB0b3AsIHNvIGNvdWxkCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgYmUgYWJvdmUgNEcgaWYgc3lzdGVtIGhhdmUgbW9yZSB0aGFuIDRHIHJh
bSBpbnN0YWxsZWQuCj4gLSAgICAgICAgICAgICAgICAgICAgICAgT3RoZXJ3aXNlIG1lbW9yeSBy
ZWdpb24gd2lsbCBiZSBhbGxvY2F0ZWQgYmVsb3cgNEcsIGlmCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgYXZhaWxhYmxlLgo+ICsgICAgICAgICAgICAgICAgICAgICAgIFtLTkwsIFg4Ni02NCwg
QVJNNjQsIFJJU0NWXSByYW5nZSBjb3VsZCBiZSBhYm92ZSA0Ry4KPiArICAgICAgICAgICAgICAg
ICAgICAgICBBbGxvdyBrZXJuZWwgdG8gYWxsb2NhdGUgcGh5c2ljYWwgbWVtb3J5IHJlZ2lvbiBm
cm9tIHRvcCwKPiArICAgICAgICAgICAgICAgICAgICAgICBzbyBjb3VsZCBiZSBhYm92ZSA0RyBp
ZiBzeXN0ZW0gaGF2ZSBtb3JlIHRoYW4gNEcgcmFtCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
aW5zdGFsbGVkLiBPdGhlcndpc2UgbWVtb3J5IHJlZ2lvbiB3aWxsIGJlIGFsbG9jYXRlZAo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGJlbG93IDRHLCBpZiBhdmFpbGFibGUuCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgSXQgd2lsbCBiZSBpZ25vcmVkIGlmIGNyYXNoa2VybmVsPVggaXMgc3Bl
Y2lmaWVkLgo+ICAgICAgICAgY3Jhc2hrZXJuZWw9c2l6ZVtLTUddLGxvdwo+IC0gICAgICAgICAg
ICAgICAgICAgICAgIFtLTkwsIFg4Ni02NCwgQVJNNjRdIHJhbmdlIHVuZGVyIDRHLiBXaGVuIGNy
YXNoa2VybmVsPVgsaGlnaAo+ICsgICAgICAgICAgICAgICAgICAgICAgIFtLTkwsIFg4Ni02NCwg
QVJNNjQsIFJJU0NWXSByYW5nZSB1bmRlciA0Ry4gV2hlbiBjcmFzaGtlcm5lbD1YLGhpZ2gKPiAg
ICAgICAgICAgICAgICAgICAgICAgICBpcyBwYXNzZWQsIGtlcm5lbCBjb3VsZCBhbGxvY2F0ZSBw
aHlzaWNhbCBtZW1vcnkgcmVnaW9uCj4gICAgICAgICAgICAgICAgICAgICAgICAgYWJvdmUgNEcs
IHRoYXQgY2F1c2Ugc2Vjb25kIGtlcm5lbCBjcmFzaCBvbiBzeXN0ZW0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICB0aGF0IHJlcXVpcmUgc29tZSBhbW91bnQgb2YgbG93IG1lbW9yeSwgZS5nLiBz
d2lvdGxiCj4gQEAgLTg5Nyw2ICs4OTcsNyBAQAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNp
emUgaXMgcGxhdGZvcm0gZGVwZW5kZW50Lgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0+
IHg4NjogbWF4KHN3aW90bGJfc2l6ZV9vcl9kZWZhdWx0KCkgKyA4TWlCLCAyNTZNaUIpCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAtLT4gYXJtNjQ6IDEyOE1pQgo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgLS0+IHJpc2N2OiAxMjhNaUIKPiAgICAgICAgICAgICAgICAgICAgICAgICBU
aGlzIG9uZSBsZXRzIHRoZSB1c2VyIHNwZWNpZnkgb3duIGxvdyByYW5nZSB1bmRlciA0Rwo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGZvciBzZWNvbmQga2VybmVsIGluc3RlYWQuCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgMDogdG8gZGlzYWJsZSBsb3cgYWxsb2NhdGlvbi4KPiAtLQo+IDIu
MzEuMQo+CgoKLS0gCkJlc3QgUmVnYXJkcwogR3VvIFJlbgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
