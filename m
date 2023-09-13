Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED98EEB596
	for <kexec@archiver.kernel.org>; Wed, 13 Sep 2023 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2lczFIO8RhcUaAv7VvA8cgn1FzfiLugVvXcddwBSMJc=; b=4oX3+3PBsYYCW1
	cDwaIEmcbpkO4TAJxuTXMO1FQ3rzCpxdytEtPMwHm8dOwn9e3UsVRNe+auub+unAuB6Jqm6+MCYAT
	5rUnSqLa1OrtbmGPof7oiFZh8MnYOqXKGMKD31bkKLw+fVmZzdg8xAGaTVGlxBYu0pB/lyBTUUQQx
	1diIQan+wOnPz5tTQDy46L6ff0f8VGYAzH7Byh+VYJ57KpPWZWhbZoHp8k3N1D6Z9mIrBX8Zi9yuX
	gtxHZQzFo/U5VmST6h8BXxViolzkQ9y2n1H+I6zX45CZcslFbGf3fedy48rM1yu0dihi93BOS/jB+
	kZ7ZWDzbyRCL4fQPo/vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgJgL-004qjm-1X;
	Wed, 13 Sep 2023 06:49:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgJgJ-004qj3-08
	for kexec@lists.infradead.org;
	Wed, 13 Sep 2023 06:49:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694587735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdVvU3SNnTLpMrdtNFEvk2mhgciFpysClKW6uVACeFM=;
	b=GcA5zX8/pON235NLqPjy+JinHSFL5nZ8ndhsu1VAq90I696jEtj0DXg0ab/UAuSfLEvKyk
	UTVo/Grpzg67Ec4MWmdbNfL15lvDWEWZ8sCJmPdqf5roWaQU3GVEEqZYsFDUkceRJfU2a1
	T/qoJ1NiJJo8pmIPJi7TB5qQiLF20aY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-39e1reCtOUWtFjxJeGwSJQ-1; Wed, 13 Sep 2023 02:48:53 -0400
X-MC-Unique: 39e1reCtOUWtFjxJeGwSJQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-760c7603014so92080639f.1
        for <kexec@lists.infradead.org>; Tue, 12 Sep 2023 23:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694587733; x=1695192533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdVvU3SNnTLpMrdtNFEvk2mhgciFpysClKW6uVACeFM=;
        b=EQPox1whGJ86q/qWzpfiHiZavn0ZAl4aY2thdMS1k26TzqnXjeQo2ZU66snN+iP5/a
         pP3TSolcSv2Ds5vJQny4h5w6GHfn1mx/4/ksT7cLwEsso56a+ntkXlH7ivkxzKmsGLcS
         0/who/9sMqnZ4pmUcEQwrJj2eQH++yDx81yHJw/JRDBHNZrXHlAz0Ity10g9cAOKBceq
         eslZaI4lFQheOD2oo+ufeGFedAbgDvr0glO9X+AgA006l9/h7ogR+ZP8cVrTABsxi1yT
         Yvng0PL7fgPifypPZFjThM0ORQl+e96vk2dwRnpUYpsot1ekL+1Og1xpoSS8uRrsVslv
         R2sA==
X-Gm-Message-State: AOJu0YxxU3ZArmczGYqZ5o7McDTGGjAgKcL7XhJZkf69HAtP2mM5qMmB
	YKFRJVy/iag0eq8QZjv/11KP3NoHqWd6RsqF0Ealq0r9XV8kNY0WhV5GgFYaA5+vW+bInuuQLbj
	iXXT2sXeKUROUr9ebPVv8LwaiA1sw0AR39rML
X-Received: by 2002:a92:ce4d:0:b0:346:1919:7cb1 with SMTP id a13-20020a92ce4d000000b0034619197cb1mr1811852ilr.2.1694587732950;
        Tue, 12 Sep 2023 23:48:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6MflOYVfTwe895KYt8UhY9zWETq6ySGSFOwVHVnyWOZ3Nl4VsikJ428/FHQ70n8eKfTq8pExwgaDCqJj8jo4=
X-Received: by 2002:a92:ce4d:0:b0:346:1919:7cb1 with SMTP id
 a13-20020a92ce4d000000b0034619197cb1mr1811849ilr.2.1694587732685; Tue, 12 Sep
 2023 23:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230911183722.11173-1-dyoung@redhat.com> <CAF+s44Tm8MgbcHg=Uea8JULv=-jpe6P7dYRuGY1WGSwTNp93cg@mail.gmail.com>
In-Reply-To: <CAF+s44Tm8MgbcHg=Uea8JULv=-jpe6P7dYRuGY1WGSwTNp93cg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 13 Sep 2023 14:48:34 +0800
Message-ID: <CALu+AoTgH+UQ0JA+wO+r5ZEkex--Svfq=C5PypqSvVh3hU4mmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] zboot: enable arm64 kexec_load for zboot image
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_234859_160024_182E42E1 
X-CRM114-Status: GOOD (  28.24  )
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

SGksCgpPbiBXZWQsIDEzIFNlcHQgMjAyMyBhdCAwODo1NCwgUGluZ2ZhbiBMaXUgPHBpbGl1QHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgNjozN+KAr1BNIERh
dmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBrZXhlY19maWxlX2xv
YWQgc3VwcG9ydCBvZiB6Ym9vdCBrZXJuZWwgaW1hZ2UgZGVjb21wcmVzc2VkIHRoZSB2bWxpbnV6
LAo+ID4gc28gaW4ga2V4ZWNfbG9hZCBjb2RlIGp1c3QgbG9hZCB0aGUga2VybmVsIHdpdGggcmVh
ZGluZyB0aGUgZGVjb21wcmVzc2VkCj4gPiBrZXJuZWwgZmQgaW50byBhIG5ldyBidWZmZXIgYW5k
IHVzZSBpdCBkaXJlY3RseS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIFlvdW5nIDxkeW91
bmdAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIGluY2x1ZGUva2V4ZWMtcGUtemJvb3QuaCAgICAg
ICAgICAgICAgIHwgIDMgKystCj4gPiAga2V4ZWMvYXJjaC9hcm02NC9rZXhlYy12bWxpbnV6LWFy
bTY0LmMgfCAyMCArKysrKysrKysrKysrKysrKystLQo+ID4gIGtleGVjL2tleGVjLXBlLXpib290
LmMgICAgICAgICAgICAgICAgIHwgIDQgKysrLQo+ID4gIGtleGVjL2tleGVjLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKy0KPiA+ICBrZXhlYy9rZXhlYy5oICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAxICsKPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUva2V4ZWMtcGUtemJv
b3QuaCBiL2luY2x1ZGUva2V4ZWMtcGUtemJvb3QuaAo+ID4gaW5kZXggZTJlMDQ0OGE4MWYyLi4z
NzQ5MTZjYmU4ODMgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2tleGVjLXBlLXpib290LmgKPiA+
ICsrKyBiL2luY2x1ZGUva2V4ZWMtcGUtemJvb3QuaAo+ID4gQEAgLTExLDUgKzExLDYgQEAgc3Ry
dWN0IGxpbnV4X3BlX3pib290X2hlYWRlciB7Cj4gPiAgICAgICAgIHVpbnQzMl90IGNvbXByZXNz
X3R5cGU7Cj4gPiAgfTsKPiA+Cj4gPiAtaW50IHBlel9wcmVwYXJlKGNvbnN0IGNoYXIgKmNydWRl
X2J1Ziwgb2ZmX3QgYnVmX3N6LCBpbnQgKmtlcm5lbF9mZCk7Cj4gPiAraW50IHBlel9wcmVwYXJl
KGNvbnN0IGNoYXIgKmNydWRlX2J1Ziwgb2ZmX3QgYnVmX3N6LCBpbnQgKmtlcm5lbF9mZCwKPiA+
ICsgICAgICAgICAgICAgICBvZmZfdCAqa2VybmVsX3NpemUpOwo+ID4gICNlbmRpZgo+ID4gZGlm
ZiAtLWdpdCBhL2tleGVjL2FyY2gvYXJtNjQva2V4ZWMtdm1saW51ei1hcm02NC5jIGIva2V4ZWMv
YXJjaC9hcm02NC9rZXhlYy12bWxpbnV6LWFybTY0LmMKPiA+IGluZGV4IGMwZWU0N2M4ZjUwYS4u
OGYzNzhkOGZhNmQwIDEwMDY0NAo+ID4gLS0tIGEva2V4ZWMvYXJjaC9hcm02NC9rZXhlYy12bWxp
bnV6LWFybTY0LmMKPiA+ICsrKyBiL2tleGVjL2FyY2gvYXJtNjQva2V4ZWMtdm1saW51ei1hcm02
NC5jCj4gPiBAQCAtMzQsNiArMzQsNyBAQAo+ID4gICNpbmNsdWRlICJhcmNoL29wdGlvbnMuaCIK
PiA+Cj4gPiAgc3RhdGljIGludCBrZXJuZWxfZmQgPSAtMTsKPiA+ICtzdGF0aWMgb2ZmX3QgZGVj
b21wcmVzc2VkX3NpemU7Cj4gPgo+ID4gIC8qIFJldHVybnM6Cj4gPiAgICogLTEgOiBpbiBjYXNl
IG9mIGVycm9yL2ludmFsaWQgZm9ybWF0IChub3QgYSB2YWxpZCBQRStjb21wcmVzc2VkIFpCT09U
IGZvcm1hdC4KPiA+IEBAIC03Miw3ICs3Myw3IEBAIGludCBwZXpfYXJtNjRfcHJvYmUoY29uc3Qg
Y2hhciAqa2VybmVsX2J1Ziwgb2ZmX3Qga2VybmVsX3NpemUpCj4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuIC0xOwo+ID4gICAgICAgICB9Cj4gPgo+ID4gLSAgICAgICByZXQgPSBwZXpfcHJlcGFy
ZShidWYsIGJ1Zl9zeiwgJmtlcm5lbF9mZCk7Cj4gPiArICAgICAgIHJldCA9IHBlel9wcmVwYXJl
KGJ1ZiwgYnVmX3N6LCAma2VybmVsX2ZkLCAmZGVjb21wcmVzc2VkX3NpemUpOwo+ID4KPiA+ICAg
ICAgICAgaWYgKCFyZXQpIHsKPiA+ICAgICAgICAgICAgIC8qIHZhbGlkYXRlIHRoZSBhcm02NCBz
cGVjaWZpYyBoZWFkZXIgKi8KPiA+IEBAIC05OCw4ICs5OSwyMyBAQCBiYWRfaGVhZGVyOgo+ID4g
IGludCBwZXpfYXJtNjRfbG9hZChpbnQgYXJnYywgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKmJ1
Ziwgb2ZmX3QgbGVuLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGtleGVjX2lu
Zm8gKmluZm8pCj4gPiAgewo+ID4gKyAgICAgICBjaGFyICprYnVmOwo+ID4gKwo+ID4gICAgICAg
ICBpbmZvLT5rZXJuZWxfZmQgPSBrZXJuZWxfZmQ7Cj4gPiAtICAgICAgIHJldHVybiBpbWFnZV9h
cm02NF9sb2FkKGFyZ2MsIGFyZ3YsIGJ1ZiwgbGVuLCBpbmZvKTsKPiA+ICsgICAgICAgaWYgKGtl
cm5lbF9mZCA+IDAgJiYgZGVjb21wcmVzc2VkX3NpemUgPiAwKSB7Cj4gPiArICAgICAgICAgICAg
ICAgb2ZmX3QgbnJlYWQ7Cj4gPiArCj4gPiArICAgICAgICAgICAgICAga2J1ZiA9IHNsdXJwX2Zk
KGtlcm5lbF9mZCwgTlVMTCwgZGVjb21wcmVzc2VkX3NpemUsICZucmVhZCk7Cj4gPiArICAgICAg
ICAgICAgICAgaWYgKCFrYnVmIHx8IG5yZWFkICE9IGRlY29tcHJlc3NlZF9zaXplKSB7CgpUb2Rh
eSBpbiBhbm90aGVyIHRlc3QgSSBmb3VuZCB0aGF0IHRoaXMgYnJlYWtzIHRoZSBrZXhlY19maWxl
X2xvYWQKYmVjYXVzZSB0aGUgc2x1cnBfZmQoKSBjbG9zZWQgdGhlIGtlcm5lbF9mZCBhZnRlciBy
ZWFkZGluZyBvdXQgdGhlCmJ1ZmZlciwgIEkgd2lsbCBzZW5kIGFub3RoZXIgdmVyc2lvbiBzb29u
LCBhbHNvIGNsZWFudXAgYSBiaXQgYWJvdXQKdGhpcyBmdW5jdGlvbi4KClRoYW5rcyBmb3IgcmV2
aWV3aW5nLgoKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRiZ3ByaW50ZigiJXM6IGZhaWxl
ZC5cbiIsIF9fZnVuY19fKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsK
PiA+ICsgICAgICAgICAgICAgICB9Cj4gPiArICAgICAgIH0gZWxzZSB7Cj4gPiArICAgICAgICAg
ICAgICAgZGJncHJpbnRmKCIlczogd3JvbmcgZmlsZSBkZXNjcmlwdG9yLlxuIiwgX19mdW5jX18p
Owo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtMTsKPiA+ICsgICAgICAgfQo+ID4gKwo+ID4g
KyAgICAgICByZXR1cm4gaW1hZ2VfYXJtNjRfbG9hZChhcmdjLCBhcmd2LCBrYnVmLCBkZWNvbXBy
ZXNzZWRfc2l6ZSwgaW5mbyk7Cj4gPiAgfQo+ID4KPiA+ICB2b2lkIHBlel9hcm02NF91c2FnZSh2
b2lkKQo+ID4gZGlmZiAtLWdpdCBhL2tleGVjL2tleGVjLXBlLXpib290LmMgYi9rZXhlYy9rZXhl
Yy1wZS16Ym9vdC5jCj4gPiBpbmRleCAyZjJlMDUyYjc2YzUuLjNhYmQxN2Q5ZmU1OSAxMDA2NDQK
PiA+IC0tLSBhL2tleGVjL2tleGVjLXBlLXpib290LmMKPiA+ICsrKyBiL2tleGVjL2tleGVjLXBl
LXpib290LmMKPiA+IEBAIC0zNyw3ICszNyw4IEBACj4gPiAgICoKPiA+ICAgKiBjcnVkZV9idWY6
IHRoZSBjb250ZW50LCB3aGljaCBpcyByZWFkIGZyb20gdGhlIGtlcm5lbCBmaWxlIHdpdGhvdXQg
YW55IHByb2Nlc3NpbmcKPiA+ICAgKi8KPiA+IC1pbnQgcGV6X3ByZXBhcmUoY29uc3QgY2hhciAq
Y3J1ZGVfYnVmLCBvZmZfdCBidWZfc3osIGludCAqa2VybmVsX2ZkKQo+ID4gK2ludCBwZXpfcHJl
cGFyZShjb25zdCBjaGFyICpjcnVkZV9idWYsIG9mZl90IGJ1Zl9zeiwgaW50ICprZXJuZWxfZmQs
Cj4gPiArICAgICAgICAgICAgICAgb2ZmX3QgKmtlcm5lbF9zaXplKQo+ID4gIHsKPiA+ICAgICAg
ICAgaW50IHJldCA9IC0xOwo+ID4gICAgICAgICBpbnQgZmQgPSAwOwo+ID4gQEAgLTExMCw2ICsx
MTEsNyBAQCBpbnQgcGV6X3ByZXBhcmUoY29uc3QgY2hhciAqY3J1ZGVfYnVmLCBvZmZfdCBidWZf
c3osIGludCAqa2VybmVsX2ZkKQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZmFpbF9iYWRfaGVh
ZGVyOwo+ID4gICAgICAgICB9Cj4gPgo+ID4gKyAgICAgICAqa2VybmVsX3NpemUgPSBkZWNvbXBy
ZXNzZWRfc2l6ZTsKPiA+ICAgICAgICAgZGJncHJpbnRmKCIlczogZG9uZVxuIiwgX19mdW5jX18p
Owo+ID4KPiA+ICAgICAgICAgcmV0ID0gMDsKPiA+IGRpZmYgLS1naXQgYS9rZXhlYy9rZXhlYy5j
IGIva2V4ZWMva2V4ZWMuYwo+ID4gaW5kZXggYzNiMTgyZTI1NGUwLi4xZWRiZDM0OWM4NmQgMTAw
NjQ0Cj4gPiAtLS0gYS9rZXhlYy9rZXhlYy5jCj4gPiArKysgYi9rZXhlYy9rZXhlYy5jCj4gPiBA
QCAtNDg5LDcgKzQ4OSw3IEBAIHN0YXRpYyBpbnQgYWRkX2JhY2t1cF9zZWdtZW50cyhzdHJ1Y3Qg
a2V4ZWNfaW5mbyAqaW5mbywKPiA+ICAgICAgICAgcmV0dXJuIDA7Cj4gPiAgfQo+ID4KPiA+IC1z
dGF0aWMgY2hhciAqc2x1cnBfZmQoaW50IGZkLCBjb25zdCBjaGFyICpmaWxlbmFtZSwgb2ZmX3Qg
c2l6ZSwgb2ZmX3QgKm5yZWFkKQo+ID4gK2NoYXIgKnNsdXJwX2ZkKGludCBmZCwgY29uc3QgY2hh
ciAqZmlsZW5hbWUsIG9mZl90IHNpemUsIG9mZl90ICpucmVhZCkKPiA+ICB7Cj4gPiAgICAgICAg
IGNoYXIgKmJ1ZjsKPiA+ICAgICAgICAgb2ZmX3QgcHJvZ3Jlc3M7Cj4gPiBkaWZmIC0tZ2l0IGEv
a2V4ZWMva2V4ZWMuaCBiL2tleGVjL2tleGVjLmgKPiA+IGluZGV4IGVkM2I0OTlhODBmMi4uMDkz
MzM4OTY5YzU3IDEwMDY0NAo+ID4gLS0tIGEva2V4ZWMva2V4ZWMuaAo+ID4gKysrIGIva2V4ZWMv
a2V4ZWMuaAo+ID4gQEAgLTI2Nyw2ICsyNjcsNyBAQCBleHRlcm4gdm9pZCBkaWUoY29uc3QgY2hh
ciAqZm10LCAuLi4pCj4gPiAgICAgICAgIF9fYXR0cmlidXRlX18gKChmb3JtYXQgKHByaW50Ziwg
MSwgMikpKTsKPiA+ICBleHRlcm4gdm9pZCAqeG1hbGxvYyhzaXplX3Qgc2l6ZSk7Cj4gPiAgZXh0
ZXJuIHZvaWQgKnhyZWFsbG9jKHZvaWQgKnB0ciwgc2l6ZV90IHNpemUpOwo+ID4gK2V4dGVybiBj
aGFyICpzbHVycF9mZChpbnQgZmQsIGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBvZmZfdCBzaXplLCBv
ZmZfdCAqbnJlYWQpOwo+ID4gIGV4dGVybiBjaGFyICpzbHVycF9maWxlKGNvbnN0IGNoYXIgKmZp
bGVuYW1lLCBvZmZfdCAqcl9zaXplKTsKPiA+ICBleHRlcm4gY2hhciAqc2x1cnBfZmlsZV9tbWFw
KGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBvZmZfdCAqcl9zaXplKTsKPiA+ICBleHRlcm4gY2hhciAq
c2x1cnBfZmlsZV9sZW4oY29uc3QgY2hhciAqZmlsZW5hbWUsIG9mZl90IHNpemUsIG9mZl90ICpu
cmVhZCk7Cj4gPiAtLQo+ID4gMi4zNy4yCj4gPgo+Cj4gTEdUTSwKPiBSZXZpZXdlZC1ieTogUGlu
Z2ZhbiBMaXUgPHBpbGl1QHJlZGhhdC5jb20+Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
