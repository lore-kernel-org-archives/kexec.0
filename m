Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB37C71133
	for <kexec@archiver.kernel.org>; Fri, 25 Aug 2023 06:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aKrQs2udpOJkt9XJlGeLMpZYpu3ucdr5VgVP4CvfMLo=; b=huV3BpdZxrVKlD
	OCJTh5aN7fgMjdmoSuoB7zPDa1yCd3kD68khWu8N731SswrAf7Q56/Zosbxm+q2pXbTBvVYxjrmzD
	nAq//p3ko4hSXq5LQ/xeTVGtqL43t78HP6jaJ4864E8tKhPf6IG60EJH2HKRo7ZlE1b2iYPrtUlEi
	SemBhIIk1gGCrVyid9uY+BfLkZU1B+eUKY7XzCC/GdTOTb8qr19d7DxrPNb/1oWTdvYlHpBWfAa2V
	9KFkaZRH6pwMav4VCiWoYu/4ehpK1foCQQ6CE34ZuLjYnHXuLiOoXABmeg6+Oar9O/YPoTnmiWZM+
	MPfGci2/+akIa59XmTYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZQ8F-004RNm-1C;
	Fri, 25 Aug 2023 06:17:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZQ8B-004RLU-0M
	for kexec@lists.infradead.org;
	Fri, 25 Aug 2023 06:17:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692944227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkHNK1cyrEAU1s5erkRmK0etxBFQmIyb9R4Nyi2CKtI=;
	b=B8vx0xBRsTUfIAMqKr3qsNw4ZNn5MnKtezdOhQNCSbxMjW7ifdhOYzGxQB1VUomODTFeYL
	gbTmry/eF+PnZg3KQW/RLNQf5/XDVJuF6APqqyp4kFdqRNDoJN3q55vZ+xYrPJrenwEnCF
	IbhLOHKhrTtEqem0j0JMnf5T3DjDdHQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-InT-SkQrPyWeSzibmJurOw-1; Fri, 25 Aug 2023 02:17:05 -0400
X-MC-Unique: InT-SkQrPyWeSzibmJurOw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-79a635bc4c7so225288241.2
        for <kexec@lists.infradead.org>; Thu, 24 Aug 2023 23:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692944225; x=1693549025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkHNK1cyrEAU1s5erkRmK0etxBFQmIyb9R4Nyi2CKtI=;
        b=hs9JLUDkk6imFanRC74AN/Oka1z1Jq3/TN100dKSmwpCczLM0qT/QxbgEO71rGkJfn
         AJxQFk2uds5KUTGYpUKhvZ7qKl7UVSFcuiIccxJ4+RsdMTdzAsjk7jnP32ZbdmjL2J/m
         1SN1SuHlGKnwylzwkwpb7+jenjKVi8nYI19Nv75McojF9eQHMDXqtjMgzkcOyVoMjuc5
         FZI2oc92S974MwevK1Cw/UUOKQVw9aAIt/qBcyZSeYrLbSCguR7S9wWaOI4mHTP3I3CT
         RU589TR5P3TEh4tUiGPqoURiyfePPPRB8f40ZjlfJ1/T47ILyoyIHFHL5KOBIVSn8wPd
         wlyQ==
X-Gm-Message-State: AOJu0YxMt3dzF25zK65fx/C2TQiU7uu0GIBTt8224uHJI/rML00OE2d5
	eHQJUOayGRSGexSGnm5j/G5gh43zLuyqXUKqwWa1Rscw6zZ5CpfCfUjAQTw/wGrTVyeLupa57q9
	YYjmCV4wxlFA0uhbKGrWkfQiNekX0MiHfp5UP
X-Received: by 2002:a67:e90d:0:b0:44e:9e6a:9c8e with SMTP id c13-20020a67e90d000000b0044e9e6a9c8emr2940140vso.9.1692944224967;
        Thu, 24 Aug 2023 23:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4L8aAax0dVbRh/ZQA0CMfnuDKutnNyHon0V/GrNc1Goumeygkeerlw7Nxmuof4eQRtHhJeiBwlmu1qcy4HeA=
X-Received: by 2002:a67:e90d:0:b0:44e:9e6a:9c8e with SMTP id
 c13-20020a67e90d000000b0044e9e6a9c8emr2940128vso.9.1692944224640; Thu, 24 Aug
 2023 23:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230819191119.975299-1-alexander.kamensky42@gmail.com>
In-Reply-To: <20230819191119.975299-1-alexander.kamensky42@gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 25 Aug 2023 14:16:53 +0800
Message-ID: <CAF+s44THuTneZr3ny1_FeB8b1+rytySadU4HMLEthnfxzF_F1A@mail.gmail.com>
Subject: Re: [PATCH] aarch64: kern_paddr_start calculation makes more accurate
 legacy check
To: Alexander Kamensky <alexander.kamensky42@gmail.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_231715_225721_7855F50F 
X-CRM114-Status: GOOD (  31.48  )
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

T24gU3VuLCBBdWcgMjAsIDIwMjMgYXQgMzoxNuKAr0FNIEFsZXhhbmRlciBLYW1lbnNreQo8YWxl
eGFuZGVyLmthbWVuc2t5NDJAZ21haWwuY29tPiB3cm90ZToKPgo+IEluIHRoZSBsYXRlc3Qgb3Bl
bmVtYmVkZGVkIHdpdGggYWFyY2g2NCBpbWFnZSB0aGF0IHVzZXMgNi40LjMga2VybmVsIG9uIHFl
bXUgSQo+IHRyaWVkIHRvIHJ1biBtYWtlZHVtcGZpbGUgaW4gc2Vjb25kYXJ5IGtlcm5lbCB3aXRo
IC9wcm9jL3ZtY29yZS4gSXQgZmFpbGVkIGFzCj4gZm9sbG93czoKPgo+ID4gcm9vdEBxZW11YXJt
NjQ6fiMgbWFrZWR1bXBmaWxlIC1jIC1GIC9wcm9jL3ZtY29yZSA+IC9kZXYvbnVsbAo+ID4gcmVh
ZF9mcm9tX3ZtY29yZTogQ2FuJ3Qgc2VlayB0aGUgZHVtcCBtZW1vcnkoL3Byb2Mvdm1jb3JlKS4g
KG9mZnNldDogZmZmZmZmYzAxMjNmYTAwMCkgSW52YWxpZCBhcmd1bWVudAo+ID4gcmVhZHBhZ2Vf
ZWxmOiBDYW4ndCByZWFkIHRoZSBkdW1wIG1lbW9yeSgvcHJvYy92bWNvcmUpLgo+ID4gPHNuaXA+
Cj4KPiBJdCB0dXJucyBvdXQgdGhhdCBub3QgYWxsIHBhcnRzIGZvciAvcHJvYy92bWNvcmUgYXJl
IHJlYWRhYmxlOgo+Cj4gPiByb290QHFlbXVhcm02NDp+IyBjYXQgL3Byb2Mvdm1jb3JlID4gL2Rl
di9udWxsCj4gPiBbICAxMzYuMzk0OTMxXSBJbnRlcm5hbCBlcnJvcjogc3luY2hyb25vdXMgZXh0
ZXJuYWwgYWJvcnQ6IDAwMDAwMDAwOTYwMDAwMTAgWyMxXSBQUkVFTVBUIFNNUAo+ID4gWyAgMTM2
LjQyMjQzNF0gTW9kdWxlcyBsaW5rZWQgaW46Cj4gPiA8c25pcD4KPgo+IEJpbmFyeSBzZWFyY2gg
b2YgZGlmZmVyZW50IGtlcm5lbCB2ZXJzaW9ucyBJIGZvdW5kIHRoYXQgdGhlIGlzc3VlIGdvZXMg
YmFjayB0bwo+IDUuMTEuIEl0IHdvcmtzIGZpbmUgd2l0aCA1LjEwIHZlcnNpb24gb2YgdGhlIGtl
cm5lbC4KPgo+IEFmdGVyIHJ1bm5pbmcgc2Vjb25kYXJ5IGtlcm5lbCB1bmRlciBxZW11IGdkYiwg
SSd2ZSBmb3VuZCB0aGF0IHRoZSBwcmltYXJ5IGtlcm5lbAo+IG1haW4gbWVtb3J5IHNlZ21lbnQg
aW4gZWxmY29yZWhkciBoYXMgd3JvbmcgYWRkcmVzcyBhbmQgc2l6ZS4KPgo+IExvb2tpbmcgYXQg
a2V4ZWMgb3V0cHV0IHdpdGggZGVidWcgZW5hYmxlZCBhdCB0aGUgdGltZSB3aGVuIGl0IGxvYWRz
IHNlY29uZGFyeQo+IGNyYXNoIGtlcm5lbCBJIHNhdyB0aGUgZm9sbG93aW5nOgo+Cj4gPiBLZXJu
ZWwgdGV4dCBFbGYgaGVhZGVyOiBwX3R5cGUgPSAxLCBwX29mZnNldCA9IDB4NDAzMDIwMDAwMCBw
X3BhZGRyID0gMHg0MDMwMjAwMDAwIHBfdmFkZHIgPSAweGZmZmZmZmZmZmZmZmZmZmYgcF9maWxl
c3ogPSAweGZmZmZmZmMwMTE0MTAwMDAgcF9tZW1zeiA9IDB4ZmZmZmZmYzAxMTQxMDAwMAo+Cj4g
VGhlc2UgdmFsdWVzIGNvbWUgZnJvbSBlbGZfaW5mbyB2YXJpYWJsZSBhbmQgYXJlIHNldCBpbiBp
b21lbV9yYW5nZV9jYWxsYmFjawo+IGZ1bmN0aW9uLiBUaGUgZnVuY3Rpb24gZ2V0cyB0aGUgZm9s
bG93aW5nIGlucHV0IG9uIG15IHN5c3RlbToKPgo+IHJvb3RAcWVtdWFybTY0On4jIGNhdCAvcHJv
Yy9pb21lbSB8IGdyZXAgIktlcm5lbCBjb2RlIgo+ICAgNDAyMTAwMDAtNDBmZWZmZmYgOiBLZXJu
ZWwgY29kZQo+IHJvb3RAcWVtdWFybTY0On4jIGNhdCAvcHJvYy9rYWxsc3ltcyB8IGdyZXAgLWUg
JyBfdGV4dCQnCgpUaGlzIGlzIHRoZSBjcnV4IG9mIHRoZSBwcm9ibGVtLiBDb3VsZCB5b3Ugc2F5
IHNvbWV0aGluZyBhYm91dCBob3cgaXQKZGlzYXBwZWFyZWQ/CgpPbiBteSBzaWRlLCBJIGNhbiBz
ZWUgdGhpcyBpbmZvIG9uIDYuMi4xNC0zMDAuZmMzOC5hYXJjaDY0CgpncmVwIC13IF90ZXh0IC9w
cm9jL2thbGxzeW1zCmZmZmZjNzA1ZDg1MDAwMDAgVCBfdGV4dAoKVGhhbmtzLAoKUGluZ2Zhbgo+
IHJvb3RAcWVtdWFybTY0On4jIGNhdCAvcHJvYy9rYWxsc3ltcyB8IGdyZXAgLWUgJyBfc3RleHQk
Jwo+IGZmZmZmZmMwMTAwMTAwMDAgVCBfc3RleHQKPiByb290QHFlbXVhcm02NDp+IyBjYXQgL3By
b2Mva2FsbHN5bXMgfCBncmVwIC1lICcgX19pbml0X2JlZ2luJCcKPiBmZmZmZmZjMDEwZGYwMDAw
IFQgX19pbml0X2JlZ2luCj4KPiB0aGUgZnVuY3Rpb24gY2FsY3VsYXRlcyBlbGZfaW5mby5rZXJu
X3BhZGRyX3N0YXJ0IGFkZHJlc3Mgc2ltaWxhciB0bwo+IHRoZXNlIG1hbnVhbCBzdGVwczoKPgo+
IGJhc2UgPSAweDQwMjEwMDAwCj4gbGVuZ3RoID0gMHg0MGZlZmZmZiAtIDB4NDAyMTAwMDAgKyAw
eDEgPSAweGRlMDAwMAo+IGt2YV90ZXh0X2VuZCAtIGt2YV9zdGV4dCA9IDB4ZmZmZmZmYzAxMGRm
MDAwMCAtIDB4ZmZmZmZmYzAxMDAxMDAwMCA9IDB4ZGUwMDAwCj4KPiBlbGZfaW5mby5rZXJuX3Bh
ZGRyX3N0YXJ0ID0gYmFzZSAtIChrdmFfc3RleHQgLSBrdmFfdGV4dCkgPQo+ICAgICAgICAgICAg
ICAgICAgICAgICAweDQwMjEwMDAwIC0gMHhmZmZmZmZjMDEwMDEwMDAwID0gMHg0MDMwMjAwMDAw
Cj4KPiBzaW5jZSAnbGVuZ3RoJyBhbmQgJ2t2YV90ZXh0X2VuZCAtIGt2YV9zdGV4dCcgYXJlIGVx
dWFsIHRoZSBmdW5jdGlvbiBjYWxjdWxhdGUKPiBlbGZfaW5mby5rZXJuX3BhZGRyX3N0YXJ0IGFz
IGluIGxlZ2FjeSBjYXNlOgo+Cj4gICBpZiAoa3ZhX3RleHRfZW5kIC0ga3ZhX3N0ZXh0ID09IGxl
bmd0aCkKPiAgICAgIGVsZl9pbmZvLmtlcm5fcGFkZHJfc3RhcnQgPSBiYXNlIC0gKGt2YV9zdGV4
dCAtIGt2YV90ZXh0KTsgLy8gPC0tLS0tLS0tLQo+ICAgZWxzZQo+ICAgICAgZWxmX2luZm8ua2Vy
bl9wYWRkcl9zdGFydCA9IGJhc2U7Cj4KPiBidXQgbXkga2VybmVsIGlzIG5vdCBsZWdhY3kgYW5k
IGt2YV90ZXh0IGlzIHplcm8uCj4KPiBUaGUgZml4IGlzIGp1c3QgdG8gYWRkIGEgY2hlY2sgZm9y
IGt2YV90ZXh0IG5vdCBiZWluZyB6ZXJvIGJlZm9yZSBmb2xsb3dpbmcgdGhlCj4gbGVnYWN5IGNh
c2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgS2FtZW5za3kgPGFsZXhhbmRlci5rYW1l
bnNreTQyQGdtYWlsLmNvbT4KPiAtLS0KPiAga2V4ZWMvYXJjaC9hcm02NC9jcmFzaGR1bXAtYXJt
NjQuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEva2V4ZWMvYXJjaC9hcm02NC9jcmFzaGR1bXAtYXJtNjQuYyBi
L2tleGVjL2FyY2gvYXJtNjQvY3Jhc2hkdW1wLWFybTY0LmMKPiBpbmRleCAzMDk4MzE1Li42Mzlj
ODJhIDEwMDY0NAo+IC0tLSBhL2tleGVjL2FyY2gvYXJtNjQvY3Jhc2hkdW1wLWFybTY0LmMKPiAr
KysgYi9rZXhlYy9hcmNoL2FybTY0L2NyYXNoZHVtcC1hcm02NC5jCj4gQEAgLTgyLDcgKzgyLDcg
QEAgc3RhdGljIGludCBpb21lbV9yYW5nZV9jYWxsYmFjayh2b2lkICpVTlVTRUQoZGF0YSksIGlu
dCBVTlVTRUQobnIpLAo+ICAgICAgICAgICAgICAgICAgKiBGb3IgY29tcGF0aWJpbGl0eSwgZGVk
dWNlIGJ5IGNvbXBhcmluZyB0aGUgZ2FwICJfX2luaXRfYmVnaW4gLSBfc3RleHQiCj4gICAgICAg
ICAgICAgICAgICAqIGFuZCB0aGUgcmVzIHNpemUgb2YgIktlcm5lbCBjb2RlIiBpbiAvcHJvYy9p
b21lbQo+ICAgICAgICAgICAgICAgICAgKi8KPiAtICAgICAgICAgICAgICAgaWYgKGt2YV90ZXh0
X2VuZCAtIGt2YV9zdGV4dCA9PSBsZW5ndGgpCj4gKyAgICAgICAgICAgICAgIGlmICgoa3ZhX3Rl
eHRfZW5kIC0ga3ZhX3N0ZXh0ID09IGxlbmd0aCkgJiYgKGt2YV90ZXh0ICE9IDApKQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGVsZl9pbmZvLmtlcm5fcGFkZHJfc3RhcnQgPSBiYXNlIC0gKGt2
YV9zdGV4dCAtIGt2YV90ZXh0KTsKPiAgICAgICAgICAgICAgICAgZWxzZQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGVsZl9pbmZvLmtlcm5fcGFkZHJfc3RhcnQgPSBiYXNlOwo+IC0tCj4gMi40
MS4wCj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4ga2V4ZWMgbWFpbGluZyBsaXN0Cj4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMKPgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
