Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965AFC7EE23
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 07:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GvpNxNFOMNKMUwLUroLLH44agmJ1aQd94dIdx6qU6vY=; b=IEO/sWCLQps9bO
	szJxuoqyEcHKLNUE5qGpUSORqhn9rBVmv4GWVYKvL3/qQ2t1Bw8ij98m+jppuFi+mR8ARgGEaBfI+
	lMTMq+fk2U5YALPvwICw7/w+8sB62yT8/UuO8cAhGhUBV+vM9fbxaugqshu566NNvdwkBLIB2sUmD
	R/ck1ZXwOgaPINlVfd42Q6ED8GeKBcbD24mcdmbd+xsvNEMb+ZLs8EsID65bwbb6Jdsc6EggSPi0k
	mVQ1IOwzk6K56usrivovYzYfFpSPiO2TWlLTjAh9TxW4VqBlHxV78uusQPAdGMJY5fOKvWz8YG+6L
	d3JKTO5UP++sCZLUiT3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q79q8-008Mpx-1H;
	Thu, 08 Jun 2023 07:13:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q79q5-008Mp0-2x
	for kexec@lists.infradead.org;
	Thu, 08 Jun 2023 07:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686208423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MTFgS0bfVH2nGfESAvkTxktVtVLFoyF8Ahx8mYb1cE=;
	b=XlQjpwp0dCNQVIbAVT5EYo6jcPhTQsgkV+vTn3LznDh/0PQpog0E+3b7uXe0U3l6FSYOqv
	wt22uuvub8lZvy97qk/kwY3LC+rbbvErXBUUmPvbEDzYXge0eklctwglc+mX1CZhQM2o3X
	AOFsAhXRvlbMqWkbPDNkZOZd3bxLKec=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-iHyRDYhQOUWpggnN89M8lg-1; Thu, 08 Jun 2023 03:13:42 -0400
X-MC-Unique: iHyRDYhQOUWpggnN89M8lg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-97542592eb9so34214866b.2
        for <kexec@lists.infradead.org>; Thu, 08 Jun 2023 00:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686208421; x=1688800421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MTFgS0bfVH2nGfESAvkTxktVtVLFoyF8Ahx8mYb1cE=;
        b=kVq9mwOmNsMA5VXdM+CaN3xavdG/uTQIjW6c8WB3ZfdMoZ2m05o97MQyqwF2hqc/Eq
         xB4tj31Te2XTOYxwsoNphhKblrpe3B4Vue8AjpY36qmsWMdr09LFFTM2XVybbnfvaKSL
         EAgIgLT69SCpCH98DV7pG5Ev9afZhQs50p6inN4//d8Ov4ykqPUU7Sb6EbOcEiuhgpPC
         WdeOOahtXfzNMbMTRV3YJWn6NZcOh6DG3PdGqP+FZH/PEVvBIBhGWGmBjVtR2+w9ZyaO
         wZMUeb6xRknBJeW9t8k4EgkLs0YzsutaJZ37NSioZq0DiZIPmwtP+NAC3denxWfzG7a7
         gX8Q==
X-Gm-Message-State: AC+VfDwKP/w+kmYElJSVOgg1i8z46VrvNFabfYFP9ODD6TvdFfR9WzmI
	kmPL0gINS7DV+qWS5m1PWo36rouerwpUpE7FKcrqKzrT98itb/Kgu+W2BejJXT5L4d6IcS0mOKH
	pz5Jc+XWAuYwbEPfqCVEpO7QlH8U8IFdjdrFe
X-Received: by 2002:a17:907:1c9e:b0:974:20bd:6e15 with SMTP id nb30-20020a1709071c9e00b0097420bd6e15mr10496117ejc.4.1686208421468;
        Thu, 08 Jun 2023 00:13:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jNDz31rw69C6omnMTTnOHrlFLU3xY6l5ZLTlMK0yMtwTDQjWyUHEoaHnIzRr2/PF3ne/dqyv5G8R9NvxRM3U=
X-Received: by 2002:a17:907:1c9e:b0:974:20bd:6e15 with SMTP id
 nb30-20020a1709071c9e00b0097420bd6e15mr10496087ejc.4.1686208421105; Thu, 08
 Jun 2023 00:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <ZHhTDXpPqFL+3m5h@MiWiFi-R3L-srv>
 <CAO7dBbVXD+3tq_iQMKtX+Vw7csPfzPJdOWVduMENyO6i7p0b0w@mail.gmail.com>
In-Reply-To: <CAO7dBbVXD+3tq_iQMKtX+Vw7csPfzPJdOWVduMENyO6i7p0b0w@mail.gmail.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 8 Jun 2023 15:13:04 +0800
Message-ID: <CAO7dBbVjD=2=2bqV5LP7PQqDRnw1sfLb-+=6255Gf_6vEx=Zcg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, bp@alien8.de, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, hpa@zytor.com, 
	ardb@kernel.org
Cc: linux-kernel@vger.kernel.org, dyoung@redhat.com, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, Baoquan He <bhe@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_001346_044778_6BD9C9C3 
X-CRM114-Status: GOOD (  39.39  )
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

SGVsbG8gbWFpbnRhaW5lcnMsCgpTb3JyeSB0byBpbnRlcnJ1cHQuIEN1cnJlbnRseSBJJ20gaG9s
ZGluZyBhIG1hY2hpbmUgd2hpY2ggY2FuIGJlIHVzZWQKdG8gcmVwcm9kdWNlIHRoZSBvcmlnaW5h
bCBpc3N1ZSBhbmQgdGVzdCB0aGUgcGF0Y2guIEhvd2V2ZXIgSSBtYXkgbmVlZAp0byByZXR1cm4g
dGhlIG1hY2hpbmUgaW4gYSBzaG9ydCB0aW1lLiBTbyBpZiBhbnkgdXBkYXRpbmcgYW5kIHRlc3Rp
bmcKbmVlZGVkIGZvciBwYXRjaCB2MywgcGxlYXNlIGxldCBtZSBrbm93LiBUaGFua3MgaW4gYWR2
YW5jZSEKClRoYW5rcywKVGFvIExpdQoKT24gVGh1LCBKdW4gMSwgMjAyMyBhdCA0OjI14oCvUE0g
VGFvIExpdSA8bHRhb0ByZWRoYXQuY29tPiB3cm90ZToKPgo+IEhpIEJhb3F1YW4sCj4KPiBPbiBU
aHUsIEp1biAxLCAyMDIzIGF0IDQ6MTPigK9QTSBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPgo+ID4gT24gMDYvMDEvMjMgYXQgMDM6MjBwbSwgVGFvIExpdSB3cm90ZToKPiA+
ID4gQSBrZXhlYyBrZXJuZWwgYm9vdHVwIGhhbmcgaXMgb2JzZXJ2ZWQgb24gSW50ZWwgQXRvbSBj
cHUgZHVlIHRvIHVubWFwcGVkCj4gPiA+IEVGSSBjb25maWcgdGFibGUuCj4gPiA+Cj4gPiA+IEN1
cnJlbnRseSBFRkkgc3lzdGVtIHRhYmxlIGlzIGlkZW50aXR5LW1hcHBlZCBmb3IgdGhlIGtleGVj
IGtlcm5lbCwgYnV0IEVGSQo+ID4gPiBjb25maWcgdGFibGUgaXMgbm90IG1hcHBlZCBleHBsaWNp
dGx5Ogo+ID4gPgo+ID4gPiAgICAgY29tbWl0IDZiYmViMjc2YjcxZiAoIng4Ni9rZXhlYzogQWRk
IHRoZSBFRkkgc3lzdGVtIHRhYmxlcyBhbmQgQUNQSQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHRhYmxlcyB0byB0aGUgaWRlbnQgbWFwIikKPiA+ID4KPiA+ID4gTGF0ZXIgaW4gdGhl
IGZvbGxvd2luZyAyIGNvbW1pdHMsIEVGSSBjb25maWcgdGFibGUgd2lsbCBiZSBhY2Nlc3NlZCB3
aGVuCj4gPiA+IGVuYWJsaW5nIHNldiBhdCBrZXJuZWwgc3RhcnR1cC4gVGhpcyBtYXkgcmVzdWx0
IGluIGEgcGFnZSBmYXVsdCBkdWUgdG8gRUZJCj4gPiA+IGNvbmZpZyB0YWJsZSdzIHVubWFwcGVk
IGFkZHJlc3MuIFNpbmNlIHRoZSBwYWdlIGZhdWx0IG9jY3VycyBhdCBhbiBlYXJseQo+ID4gPiBz
dGFnZSwgaXQgaXMgdW5yZWNvdmVyYWJsZSBhbmQga2VybmVsIGhhbmdzLgo+ID4gPgo+ID4gPiAg
ICAgY29tbWl0IGVjMWM2NmFmM2EzMCAoIng4Ni9jb21wcmVzc2VkLzY0OiBEZXRlY3Qvc2V0dXAg
U0VWL1NNRSBmZWF0dXJlcwo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIGVhcmxpZXIg
ZHVyaW5nIGJvb3QiKQo+ID4gPiAgICAgY29tbWl0IGMwMWZjZTljZWY4NCAoIng4Ni9jb21wcmVz
c2VkOiBBZGQgU0VWLVNOUCBmZWF0dXJlCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGV0ZWN0aW9uL3NldHVwIikKPiA+ID4KPiA+ID4gSW4gYWRkaXRpb24sIHRoZSBpc3N1ZSBkb2Vz
bid0IGFwcGVhciBvbiBhbGwgc3lzdGVtcywgYmVjYXVzZSB0aGUga2V4ZWMKPiA+ID4ga2VybmVs
IHVzZXMgUGFnZSBTaXplIEV4dGVuc2lvbiAoUFNFKSBmb3IgaWRlbnRpdHkgbWFwcGluZy4gSW4g
bW9zdCBjYXNlcywKPiA+ID4gRUZJIGNvbmZpZyB0YWJsZSBjYW4gZW5kIHVwIHRvIGJlIG1hcHBl
ZCBpbnRvIGR1ZSB0byAxIEdCIHBhZ2Ugc2l6ZS4KPiA+ID4gSG93ZXZlciBpZiBub2dicGFnZXMg
aXMgc2V0LCBvciBjcHUgZG9lc24ndCBzdXBwb3J0IHBkcGUxZ2IgZmVhdHVyZQo+ID4gPiAoZS5n
IEludGVsIEF0b20geDY0MjVSRSBjcHUpLCBFRkkgY29uZmlnIHRhYmxlIG1heSBub3QgYmUgbWFw
cGVkIGludG8KPiA+ID4gZHVlIHRvIDIgTUIgcGFnZSBzaXplLCB0aHVzIGEgcGFnZSBmYXVsdCBo
YW5nIGlzIG1vcmUgbGlrZWx5IHRvIGhhcHBlbi4KPiA+ID4KPiA+ID4gVGhpcyBwYXRjaCB3aWxs
IG1ha2Ugc3VyZSB0aGUgRUZJIGNvbmZpZyB0YWJsZSBpcyBhbHdheXMgbWFwcGVkLgo+ID4gPgo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBUYW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+Cj4gPiA+IC0tLQo+
ID4gPiBDaGFuZ2VzIGluIHYyOgo+ID4gPiAtIFJlcGhyYXNlIHRoZSBjaGFuZ2UgbG9nIGJhc2Vk
IG9uIEJhb3F1YW4ncyBzdWdnZXN0aW9uLgo+ID4gPiAtIFJlbmFtZSBtYXBfZWZpX3N5c19jZmdf
dGFiKCkgdG8gbWFwX2VmaV90YWJsZXMoKS4KPiA+ID4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9rZXhlYy8yMDIzMDUyNTA5NDkxNC4yMzQyMC0xLWx0YW9AcmVkaGF0LmNv
bS8KPiA+ID4gLS0tCj4gPiA+ICBhcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jIHwg
MzUgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MzEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvbWFj
aGluZV9rZXhlY182NC5jCj4gPiA+IGluZGV4IDFhM2UyYzA1YThhNS4uNjY0YWVmYTZlODk2IDEw
MDY0NAo+ID4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jCj4gPiA+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMKPiA+ID4gQEAgLTI4LDYg
KzI4LDcgQEAKPiA+ID4gICNpbmNsdWRlIDxhc20vc2V0dXAuaD4KPiA+ID4gICNpbmNsdWRlIDxh
c20vc2V0X21lbW9yeS5oPgo+ID4gPiAgI2luY2x1ZGUgPGFzbS9jcHUuaD4KPiA+ID4gKyNpbmNs
dWRlIDxhc20vZWZpLmg+Cj4gPiA+Cj4gPiA+ICAjaWZkZWYgQ09ORklHX0FDUEkKPiA+ID4gIC8q
Cj4gPiA+IEBAIC04NiwxMCArODcsMTIgQEAgY29uc3Qgc3RydWN0IGtleGVjX2ZpbGVfb3BzICog
Y29uc3Qga2V4ZWNfZmlsZV9sb2FkZXJzW10gPSB7Cj4gPiA+ICAjZW5kaWYKPiA+ID4KPiA+ID4g
IHN0YXRpYyBpbnQKPiA+ID4gLW1hcF9lZmlfc3lzdGFiKHN0cnVjdCB4ODZfbWFwcGluZ19pbmZv
ICppbmZvLCBwZ2RfdCAqbGV2ZWw0cCkKPiA+ID4gK21hcF9lZmlfdGFibGVzKHN0cnVjdCB4ODZf
bWFwcGluZ19pbmZvICppbmZvLCBwZ2RfdCAqbGV2ZWw0cCkKPiA+ID4gIHsKPiA+ID4gICNpZmRl
ZiBDT05GSUdfRUZJCj4gPiA+ICAgICAgIHVuc2lnbmVkIGxvbmcgbXN0YXJ0LCBtZW5kOwo+ID4g
PiArICAgICB2b2lkICprYWRkcjsKPiA+ID4gKyAgICAgaW50IHJldDsKPiA+ID4KPiA+ID4gICAg
ICAgaWYgKCFlZmlfZW5hYmxlZChFRklfQk9PVCkpCj4gPiA+ICAgICAgICAgICAgICAgcmV0dXJu
IDA7Cj4gPiA+IEBAIC0xMDUsNiArMTA4LDMwIEBAIG1hcF9lZmlfc3lzdGFiKHN0cnVjdCB4ODZf
bWFwcGluZ19pbmZvICppbmZvLCBwZ2RfdCAqbGV2ZWw0cCkKPiA+ID4gICAgICAgaWYgKCFtc3Rh
cnQpCj4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiA+Cj4gPiA+ICsgICAgIHJldCA9
IGtlcm5lbF9pZGVudF9tYXBwaW5nX2luaXQoaW5mbywgbGV2ZWw0cCwgbXN0YXJ0LCBtZW5kKTsK
PiA+ID4gKyAgICAgaWYgKHJldCkKPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4g
PiArCj4gPiA+ICsgICAgIGthZGRyID0gbWVtcmVtYXAobXN0YXJ0LCBtZW5kIC0gbXN0YXJ0LCBN
RU1SRU1BUF9XQik7Cj4gPiA+ICsgICAgIGlmICgha2FkZHIpIHsKPiA+ID4gKyAgICAgICAgICAg
ICBwcl9lcnIoIkNvdWxkIG5vdCBtYXAgVUVGSSBzeXN0ZW0gdGFibGVcbiIpOwo+ID4gPiArICAg
ICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+ID4gPiArICAgICB9Cj4gPiA+ICsKPiA+ID4gKyAg
ICAgbXN0YXJ0ID0gZWZpX2NvbmZpZ190YWJsZTsKPiA+ID4gKwo+ID4gPiArICAgICBpZiAoZWZp
X2VuYWJsZWQoRUZJXzY0QklUKSkgewo+ID4gPiArICAgICAgICAgICAgIGVmaV9zeXN0ZW1fdGFi
bGVfNjRfdCAqc3RibCA9IChlZmlfc3lzdGVtX3RhYmxlXzY0X3QgKilrYWRkcjsKPiA+ID4gKwo+
ID4gPiArICAgICAgICAgICAgIG1lbmQgPSBtc3RhcnQgKyBzaXplb2YoZWZpX2NvbmZpZ190YWJs
ZV82NF90KSAqIHN0YmwtPm5yX3RhYmxlczsKPiA+ID4gKyAgICAgfSBlbHNlIHsKPiA+ID4gKyAg
ICAgICAgICAgICBlZmlfc3lzdGVtX3RhYmxlXzMyX3QgKnN0YmwgPSAoZWZpX3N5c3RlbV90YWJs
ZV8zMl90ICopa2FkZHI7Cj4gPiA+ICsKPiA+ID4gKyAgICAgICAgICAgICBtZW5kID0gbXN0YXJ0
ICsgc2l6ZW9mKGVmaV9jb25maWdfdGFibGVfMzJfdCkgKiBzdGJsLT5ucl90YWJsZXM7Cj4gPiA+
ICsgICAgIH0KPiA+ID4gKwo+ID4gPiArICAgICBtZW11bm1hcChrYWRkcik7Cj4gPiA+ICsKPiA+
ID4gICAgICAgcmV0dXJuIGtlcm5lbF9pZGVudF9tYXBwaW5nX2luaXQoaW5mbywgbGV2ZWw0cCwg
bXN0YXJ0LCBtZW5kKTsKPiA+ID4gICNlbmRpZgo+ID4gPiAgICAgICByZXR1cm4gMDsKPiA+ID4g
QEAgLTI0NCwxMCArMjcxLDEwIEBAIHN0YXRpYyBpbnQgaW5pdF9wZ3RhYmxlKHN0cnVjdCBraW1h
Z2UgKmltYWdlLCB1bnNpZ25lZCBsb25nIHN0YXJ0X3BndGFibGUpCj4gPiA+ICAgICAgIH0KPiA+
ID4KPiA+ID4gICAgICAgLyoKPiA+ID4gLSAgICAgICogUHJlcGFyZSBFRkkgc3lzdGFiIGFuZCBB
Q1BJIHRhYmxlcyBmb3Iga2V4ZWMga2VybmVsIHNpbmNlIHRoZXkgYXJlCj4gPiA+IC0gICAgICAq
IG5vdCBjb3ZlcmVkIGJ5IHBmbl9tYXBwZWQuCj4gPiA+ICsgICAgICAqIFByZXBhcmUgRUZJIHN5
c3RhYiwgY29uZmlnIHRhYmxlIGFuZCBBQ1BJIHRhYmxlcyBmb3Iga2V4ZWMga2VybmVsCj4gPgo+
ID4gVGhlIGNvZGUgY29tbWVudCBuZWVkIGJlIHVwZGF0ZWQgdG9vPwo+ID4KPiA+ICAgICAgICAg
ICogUHJlcGFyZSBFRkkgdGFibGVzIGFuZCBBQ1BJIHRhYmxlcyBmb3Iga2V4ZWMga2VybmVsIHNp
bmNlIHRoZXkgYXJlCj4gPiAgICAgICAgICAqIG5vdCBjb3ZlcmVkIGJ5IHBmbl9tYXBwZWQuCj4g
Pgo+ID4gT3RoZXIgdGhhbiB0aGlzIG5pdCwgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLCB0
aGFua3MuCj4gPgo+Cj4gVGhhbmtzIGZvciB0aGUgcGF0Y2ggcmV2aWV3ISBJJ20gT0sgd2l0aCB0
aGUgY29tbWVudCB1cGRhdGUsIGJ1dCBJCj4gcHJlZmVyIHRvIGxlYXZlIGl0IGFzIGl0IGlzLiBT
aW5jZSB0aGUgY29tbWVudCBwcm92aWRlcyBtb3JlIGRldGFpbHM6Cj4gdGhlcmUgYXJlIHN5c3Rh
YiBhbmQgY29uZmlnIHRhYmxlcyBtYXBwZWQgaW5zdGVhZCBvZiBhbGwgZWZpIHRhYmxlcy4KPgo+
IFRoYW5rcywKPiBUYW8gTGl1Cj4KPiA+IEFja2VkLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0
LmNvbT4KPiA+Cj4gPgo+ID4gPiArICAgICAgKiBzaW5jZSB0aGV5IGFyZSBub3QgY292ZXJlZCBi
eSBwZm5fbWFwcGVkLgo+ID4gPiAgICAgICAgKi8KPiA+ID4gLSAgICAgcmVzdWx0ID0gbWFwX2Vm
aV9zeXN0YWIoJmluZm8sIGxldmVsNHApOwo+ID4gPiArICAgICByZXN1bHQgPSBtYXBfZWZpX3Rh
YmxlcygmaW5mbywgbGV2ZWw0cCk7Cj4gPiA+ICAgICAgIGlmIChyZXN1bHQpCj4gPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIHJlc3VsdDsKPiA+ID4KPiA+ID4gLS0KPiA+ID4gMi4zMy4xCj4gPiA+
Cj4gPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
