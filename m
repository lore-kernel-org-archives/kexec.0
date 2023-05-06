Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C09C77B7D
	for <kexec@archiver.kernel.org>; Sat,  6 May 2023 03:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2j9DkLPXvehPQ5b2t009hQT3NbBhHLBaG7cUl/s/0HA=; b=KrpCJDtdUc3eQD
	xCSv+feqoAYGkpwLDVJctHOT2GdFp/OORef/vyo37Umnvvsirv4zIjCqRAQrpAdTkTjIoj6FDbmoK
	bqLs8O8643CoYBKThs3mbhV0SiXBs9gcGg/I5l7GQny/YvAoJY/8C+PeLdOs0jlVlK8KXl7Z59nQI
	mhFOUsgPewh97pAf4bLO7SvMNjV16BUCsQyt57NkNT6W5paMCJPuaFzUARifuTC6B5JtmjZWUGcv5
	7grn0jtXcIbWYdtnvzdcONrUrOOlgEG0D7jm9nJ0+Jyby8HuQMxmK19Almd/kkVS2xaRLrr3PNe6Z
	D2Yf6otQ3RqhreqYzJ1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8NS-00CQU7-2o;
	Sat, 06 May 2023 03:14:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8NN-00CQTR-15
	for kexec@lists.infradead.org;
	Sat, 06 May 2023 03:14:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683342864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRLrWGdl3ICgUpIw3wrMz1/lK6OqIJksBXf9jQE3cR0=;
	b=U3erX1rotB6OG8NfzQ9MxegwoVrNUTQg4aYweb7BrtbxHu7yw5zjIC5TBGrMzEsdYGf7ar
	MBJm4H4bxuQDLwUBEB3G28ctEVe1Mnq9Jkg4G05/mdUL7D6Pp4uJYQDn2hCIM7DKa0Arad
	6SrNHtONNKUbYIpr8qS+noYHP/2NUFk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-VSnkQ8HMNqmyO4E-8l4F9w-1; Fri, 05 May 2023 23:14:23 -0400
X-MC-Unique: VSnkQ8HMNqmyO4E-8l4F9w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61a66010dd7so12917946d6.3
        for <kexec@lists.infradead.org>; Fri, 05 May 2023 20:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683342862; x=1685934862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRLrWGdl3ICgUpIw3wrMz1/lK6OqIJksBXf9jQE3cR0=;
        b=gMIKlFNW0sn/ZwrlqMD2/LSZWBYf0FO4PKNzi8tLTuoVPjHkAGGDNEXvZIBVsdjPOk
         y7iaRGfLH35r+iLl005OWE4TEF3ZHiaKkogz+IOLCS07yTO1iaHQZI4/0JK8fJV8OjPM
         v8xXzKi5rQP6NmClPx/ov7XH39R4b278SsxPBmC86VZcpaOnbxOrNKEtSnvlJ2IJInNY
         Lu3rtoFfPzzJs5tFGQBWWomj0cWrjxovOum2iIoPjMb8qzZ/gDvcy9zRosKOfnQ9N+oH
         7ILky0tJvMn0W5wgnJeaZIFa3YtoJBnCxQV/NnHCOQt+63KPns2AMG7rbAfKDg7lAfJK
         xTHw==
X-Gm-Message-State: AC+VfDzAFLu0MY9EqeeihXgZvzT5d54auuEzgmvE2xXOFEMW2ya/F33S
	dH7o/T3LYZC/j79dZbgwZHH10yfzOMt8Hz+nrOPyzIGsJI8WEe9bLR4n6MViRQ/oVtrT7tlLbnA
	BiULpJKVo9B2EhigVvQ6uipubdHS4DGbJ9bWGtRIqz7PHdth8cg==
X-Received: by 2002:ad4:5ae2:0:b0:5f1:6a35:60be with SMTP id c2-20020ad45ae2000000b005f16a3560bemr7215290qvh.23.1683342862515;
        Fri, 05 May 2023 20:14:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PIOFqJq4vsxT3CNxNdaGiQ1TLAgJp/sLyd0vu5/zjL+/Bc/T+ee08EnxeT/Omkf9v+ZExvFMI996ZWELpwNY=
X-Received: by 2002:ad4:5ae2:0:b0:5f1:6a35:60be with SMTP id
 c2-20020ad45ae2000000b005f16a3560bemr7215276qvh.23.1683342862308; Fri, 05 May
 2023 20:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230505025438.11943-1-piliu@redhat.com> <20230505025438.11943-4-piliu@redhat.com>
 <ZFUjzEwHZ6o+C9NO@kernel.org>
In-Reply-To: <ZFUjzEwHZ6o+C9NO@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Sat, 6 May 2023 11:14:11 +0800
Message-ID: <CAF+s44TuVKPOPKcSP6SagJBaOL6W0zc6HM7n=BZC4OwQmNvbPw@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: change the prototype of image probe function
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_201425_466321_77B500C3 
X-CRM114-Status: GOOD (  22.22  )
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

T24gRnJpLCBNYXkgNSwgMjAyMyBhdCAxMTo0MuKAr1BNIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBGcmksIE1heSAwNSwgMjAyMyBhdCAxMDo1NDozNUFNICsw
ODAwLCBQaW5nZmFuIExpdSB3cm90ZToKPiA+IENoYW5naW5nIHRoZSBhYXJjaDY0IHByb2JlJ3Mg
cHJvdG90eXBlICBmcm9tCj4gPiAgICAgICB0eXBlZGVmIGludCAocHJvYmVfdCkoY29uc3QgY2hh
ciAqa2VybmVsX2J1Ziwgb2ZmX3Qga2VybmVsX3NpemUpOwo+ID4gdG8KPiA+ICAgICAgIHR5cGVk
ZWYgaW50IChwcm9iZV90KShjb25zdCBjaGFyICprZXJuZWxfYnVmLCBvZmZfdCBrZXJuZWxfc2l6
ZSwgc3RydWN0IGtleGVjX2luZm8gKmluZm8pOwo+ID4KPiA+IExhdGVyLCBpbmZvIGNhbiBiZSB1
c2VkIHRvIHJldHVybiBib3RoIHRoZSBmaWxlIGRlc2NyaXB0b3IgYW5kIHBhcnNlZCBrZXJuZWwK
PiA+IGJ1ZmZlci4gVGhlIGZkIGlzIHBhc3NlZCB0byBzeXNfa2V4ZWNfZmlsZV9sb2FkLCBhbmQg
dGhlIHBhcnNlZCBrZXJuZWwKPiA+IGJ1ZmZlciBpcyB1c2VkIGJ5IGltYWdlJ3MgbG9hZCBmdW5j
dGlvbi4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nZmFuIExpdSA8cGlsaXVAcmVkaGF0LmNv
bT4KPgo+IEhpIFBpbmdmYW4sCj4KPiBJIGFtIHNlZWluZyBhIGJ1aWxkIGZhaWx1cmUgb24gQVJN
ICgzMmJpdCkuCj4KPiAgIDEzOCB8IGludCB6SW1hZ2VfYXJtX3Byb2JlKGNvbnN0IGNoYXIgKlVO
VVNFRChidWYpLCBvZmZfdCBVTlVTRUQobGVuKSkKPiAgICAgICB8ICAgICBefn5+fn5+fn5+fn5+
fn5+Cj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uL2tleGVjL2FyY2gvYXJtL2tleGVjLXpJ
bWFnZS1hcm0uYzoyMToKPiAuLi8uLi9rZXhlYy9hcmNoL2FybS9rZXhlYy1hcm0uaDoxMjo1OiBu
b3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJh6SW1hZ2VfYXJtX3Byb2Jl4oCZIHdhcyBo
ZXJlCj4gICAgMTIgfCBpbnQgekltYWdlX2FybV9wcm9iZShjb25zdCBjaGFyICpidWYsIG9mZl90
IGxlbiwgc3RydWN0IGtleGVjX2luZm8gKmluZm8pOwo+ICAgICAgIHwgICAgIF5+fn5+fn5+fn5+
fn5+fn4KPiBtYWtlWzFdOiAqKiogW01ha2VmaWxlOjEyNDoga2V4ZWMvYXJjaC9hcm0va2V4ZWMt
ekltYWdlLWFybS5vXSBFcnJvciAxCj4gbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNo
ZWQgam9icy4uLi4KPiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvcnVubmVyL3dv
cmsva2V4ZWMtdG9vbHMva2V4ZWMtdG9vbHMva2V4ZWMtdG9vbHMtMi4wLjI2LmdpdC9fYnVpbGQv
c3ViJwo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6Mjc2OiBkaXN0Y2hlY2tdIEVycm9yIDIKPiBFcnJv
cjogUHJvY2VzcyBjb21wbGV0ZWQgd2l0aCBleGl0IGNvZGUgMi4KPgoKT29wcy4gSSBqdXN0IHRl
c3RlZCBvbiB4ODZfNjQgYW5kIGFhcmNoNjQsIGFuZCBkaWQgbm90IGRldGVjdCB0aGlzIGJ1Zy4K
Cj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL2hvcm1zL2tleGVjLXRvb2xzL2FjdGlvbnMvcnVu
cy80ODk1MTI0NzE5L2pvYnMvODc0MDI3MjEwMwo+Cj4gLi4uCj4KPiA+IGRpZmYgLS1naXQgYS9r
ZXhlYy9rZXhlYy5oIGIva2V4ZWMva2V4ZWMuaAo+ID4gaW5kZXggMGQ4MjBhZC4uNmU4NDMwZSAx
MDA2NDQKPiA+IC0tLSBhL2tleGVjL2tleGVjLmgKPiA+ICsrKyBiL2tleGVjL2tleGVjLmgKPiA+
IEBAIC0xOTEsNyArMTkxLDEzIEBAIHVuc2lnbmVkIGxvbmcgbG9jYXRlX2hvbGUoc3RydWN0IGtl
eGVjX2luZm8gKmluZm8sCj4gPiAgICAgICB1bnNpZ25lZCBsb25nIGhvbGVfbWluLCB1bnNpZ25l
ZCBsb25nIGhvbGVfbWF4LAo+ID4gICAgICAgaW50IGhvbGVfZW5kKTsKPiA+Cj4gPiArI2lmbmRl
ZiBfX2FhcmNoNjRfXwo+ID4gIHR5cGVkZWYgaW50IChwcm9iZV90KShjb25zdCBjaGFyICprZXJu
ZWxfYnVmLCBvZmZfdCBrZXJuZWxfc2l6ZSk7Cj4gPiArI2Vsc2UKPiA+ICt0eXBlZGVmIGludCAo
cHJvYmVfdCkoY29uc3QgY2hhciAqa2Vybl9mbmFtZSwgb2ZmX3Qga2VybmVsX3NpemUsCj4gPiAr
ICAgICBzdHJ1Y3Qga2V4ZWNfaW5mbyAqaW5mbyk7Cj4gPiArI2VuZGlmCj4gPiArCj4KPiBUaGlz
IHNlZW1zIGtpbmQgb2YgdW5mb3J0dW5hdGUuCj4gQ291bGQgd2UgdXBkYXRlIHRoZSBwcm90b3R5
cGUgZm9yIGFsbCBhcmNoaXRlY3R1cmVzPwo+CgpJIHdpbGwgaGF2ZSBhIHRyeSB3aXRoIGNvY2Np
bmVsbGUuCgpUaGFua3MgZm9yIHlvdXIgaGVscC4KClJlZ2FyZHMsCgogICAgUGluZ2ZhbgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
