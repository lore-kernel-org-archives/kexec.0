Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58667C3DA49
	for <kexec@archiver.kernel.org>; Tue, 23 Jul 2024 07:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uT6s2GWjl+0nX+deyE4g6YEln8JgOk8uRr3qnTQ7oWY=; b=axvWrwCBWJeWTA
	fZByZD/46kMh/LOKKc6bsQonJJDbku5VA90B46KLJ3w7fPPf6KP3eI20HblSp/Hxsvk142AJb6LD1
	CjHph9z00QO8IjnlmJapeZsDuHo+/OOgWWG11r90DvzD13vPcoinAR61EafwOVDRkR3V5UYcVHkYc
	/SQRRxgTclfWjgmtWXkM72zCw3XTld+kyz03fdRKkWv5seFuvpA3DY93MxZYcfHnWNg36YSeZMCPH
	n9PTVWvvpL4MM2Q8bQOa9yPDiUQaCKKaLOW+FqV5h5++2ekp3YC18bDZO6CmPAsaV3inGEeq7Z+lk
	UUzw7+rtMvHrOgw/8Rrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW9zq-0000000BjHr-18zX;
	Tue, 23 Jul 2024 07:31:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW9zn-0000000BjHN-3v7I
	for kexec@lists.infradead.org;
	Tue, 23 Jul 2024 07:31:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721719897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAqzETtnf7VVZAIJ8dtP3ov1yuWGTg8B3KyVNV5h8ac=;
	b=Ny6lnU/Cw+sg1pNyUlhvEL+GWeZBXRbbuidf1u05K9rLKXd5srmSNEAv/eoXMlslz1t342
	fvNR7JEWRPOpfu3uMWFVrCpozNT/jTxJXffR9VY6PGiimpNc4mbDhNobAKqJi6l9p/7yhO
	e2OVK+oe6jvul1ibrpNEhfpMRbJfhQc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-GICtfEH0N--c-2uJaR-svw-1; Tue, 23 Jul 2024 03:31:32 -0400
X-MC-Unique: GICtfEH0N--c-2uJaR-svw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fd774c3b8eso5826495ad.0
        for <kexec@lists.infradead.org>; Tue, 23 Jul 2024 00:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721719891; x=1722324691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAqzETtnf7VVZAIJ8dtP3ov1yuWGTg8B3KyVNV5h8ac=;
        b=m806kq0k3BIK7ViH8EX9YcXfs9P3vNyvnYI7Gc8Fmdca5tF7i+EUzLcKPdglL7rp7x
         /+vsMiE5foYoon2wgsjG9sszE8+J7XhuumY9Ifbq/kPXMJfti/O96CiJFnB2l0K/sEcx
         vmWo/QQMoZ/p9RHMCKKqh4SlbnlOQhszYjQJ+4No89DleikMstVS92xZysg71mCJYRW1
         5CtZ5g9tvXdj+/ogu4pHNfqFBtCT9Xsc3oHCiEZ5qmdshE1QyxRIbo38vUwSvRPTkpMI
         EAfIlGRPaeu3K9Vbet7zEr96Su88hh5KRnYMhJkQfbg1x3XtW4c7jXk9YPCtt1XoTT8s
         iEWw==
X-Gm-Message-State: AOJu0Yyw3PcEm1C5UPlMoj0PR1FHBi7kT0jnPFAlBEMlCxXz0RzWRlUu
	rGgL88x4xuPSRwMUEPANjsoXpuJQrtFPlkxSiwgVosiXG12BIVHsLq978j+Un61phakgqChnicK
	Z9WYyGNvCrNCQ4wPECyg/1t47swaNCQAPXVGpe0BsVA3B1fm0ZaIa+fOr1iidUqKhy3MdlnBKbZ
	4KyPTZdkzucmjvUECPEcBfU6werThG8dmkNhQplBqYRK4=
X-Received: by 2002:a17:90a:a10b:b0:2c9:6abd:ca64 with SMTP id 98e67ed59e1d1-2cd8cd52b82mr2107991a91.9.1721719891256;
        Tue, 23 Jul 2024 00:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnaxJrPoUuZcIaVGXcm87mdYUeQ2izZmMY8UicsEW/u9N3HtYcyUs1RONykysqURGMam1BlQVX2eJ975picWY=
X-Received: by 2002:a17:90a:a10b:b0:2c9:6abd:ca64 with SMTP id
 98e67ed59e1d1-2cd8cd52b82mr2107966a91.9.1721719890874; Tue, 23 Jul 2024
 00:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240625015712.3266086-1-lichliu@redhat.com> <bcdaf3b8-599d-4af1-af92-188e4072d143@nec.com>
 <CAPmSd0Pd3afnTZGog3pXEY_mh093WDW27HJLUGN2QYDwk8RHyQ@mail.gmail.com> <072f683a-e16d-45a7-9f4c-b59e75a8d05e@nec.com>
In-Reply-To: <072f683a-e16d-45a7-9f4c-b59e75a8d05e@nec.com>
From: Lichen Liu <lichliu@redhat.com>
Date: Tue, 23 Jul 2024 15:31:19 +0800
Message-ID: <CAPmSd0NoDT8=kOm=aDBb=uAfdSno9YWs6JMh2-_cPWV6juGEQg@mail.gmail.com>
Subject: Re: [PATCH] makedumpfile: call initial before use cache
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_003140_068522_D8EF8069 
X-CRM114-Status: GOOD (  27.67  )
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

WWVzLCBpdCB3b3JrcyEKVGhhbmsgeW91IHNvIG11Y2ghCgpPbiBNb24sIEp1bCAyMiwgMjAyNCBh
dCAyOjQ24oCvUE0gSEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQo8ay1oYWdpby1hYkBu
ZWMuY29tPiB3cm90ZToKPgo+IE9uIDIwMjQvMDcvMjAgMTY6MzgsIExpY2hlbiBMaXUgd3JvdGU6
Cj4KPiA+PiBUaGlzIHdpbGwgd29yayBvbmx5IGZvciA0LjE5IGFuZCBsYXRlciBrZXJuZWxzLCBi
dXQgbWlnaHQgcmVkdWNlIHVzZXJzCj4gPj4gdGhhdCBoaXQgdGhlIGlzc3VlLiAgRG9lcyB0aGlz
IHdvcmsgZm9yIHlvdT8KPiA+IFRoYXQgd29ya3MgZm9yIG1lIGJlY2F1c2UgSSdtIHRlc3Rpbmcg
Zm9yIHRoZSA2Lngga2VybmVsLgo+Cj4gVGhhbmtzIGZvciB0aGUgY2hlY2suICBJcyB0aGUgaXNz
dWUgYSBzZWdtZW50YXRpb24gZmF1bHQ/Cj4gSSd2ZSBtYWRlIGEgcGF0Y2ggYmVsb3csIGlzIHRo
aXMgT0s/Cj4KPgo+ICBGcm9tIDA4NDc0MmNiYTViODFkYTU2MzA3NDQ1NGFiOGM4NzllOGU0MTFj
YjAgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCj4gRnJvbTogS2F6dWhpdG8gSGFnaW8gPGstaGFn
aW8tYWJAbmVjLmNvbT4KPiBEYXRlOiBNb24sIDIyIEp1bCAyMDI0IDE0OjMxOjQzICswOTAwCj4g
U3ViamVjdDogW1BBVENIXSBXb3JrYXJvdW5kIGZvciBzZWdmYXVsdCBieSAibWFrZWR1bXBmaWxl
IC0tbWVtLXVzYWdlIiBvbiBQUEM2NAo+Cj4gIm1ha2VkdW1wZmlsZSAtLW1lbS11c2FnZSAvcHJv
Yy9rY29yZSIgY2FuIGNhdXNlIGEgc2VnbWVudGF0aW9uIGZhdWx0IG9uCj4gUFBDNjQsIGJlY2F1
c2UgdGhlIHJlYWRtZW0oKSBvZiB0aGUgZm9sbG93aW5nIGNvZGUgcGF0aCB1c2VzIGNhY2hlCj4g
YmVmb3JlIGl0J3MgaW5pdGlhbGl6ZWQgaW4gaW5pdGlhbCgpLgo+Cj4gICAgc2hvd19tZW1fdXNh
Z2UKPiAgICAgIGdldF9wYWdlX29mZnNldAo+ICAgICAgICBnZXRfdmVyc2lvbmRlcF9pbmZvX3Bw
YzY0Cj4gICAgICAgICAgcmVhZG1lbQo+ICAgICAgLi4uCj4gICAgICBpbml0aWFsCj4gICAgICAg
ICAgY2FjaGVfaW5pdAo+Cj4gVGhlIGdldF9wYWdlX29mZnNldCgpIGlzIG5lZWRlZCB0byBnZXQg
dm1jb3JlaW5mbyBmcm9tIC9wcm9jL2tjb3JlIGRhdGEsCj4gc28gd2UgY2FuIGF2b2lkIGNhbGxp
bmcgaXQgd2hlbiBhIHZtY29yZWluZm8gZXhpc3RzIGluIHRoZSBFTEYgTk9URQo+IHNlZ21lbnQg
b2YgL3Byb2Mva2NvcmUsIGkuZS4gb24gTGludXggNC4xOSBhbmQgbGF0ZXIuCj4KPiAoTm90ZTog
Zm9yIG9sZGVyIGtlcm5lbHMsIHdlIHdpbGwgbmVlZCBhbm90aGVyIHdheSB0byBmaXggaXQuKQo+
Cj4gUmVwb3J0ZWQtYnk6IExpY2hlbiBMaXUgPGxpY2hsaXVAcmVkaGF0LmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBLYXp1aGl0byBIYWdpbyA8ay1oYWdpby1hYkBuZWMuY29tPgo+IC0tLQo+ICAgbWFr
ZWR1bXBmaWxlLmMgfCAxMiArKysrKystLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbWFrZWR1bXBmaWxlLmMg
Yi9tYWtlZHVtcGZpbGUuYwo+IGluZGV4IDViMzQ3MTI2ZGI3Ni4uN2QxZGZjY2E1MGQ4IDEwMDY0
NAo+IC0tLSBhL21ha2VkdW1wZmlsZS5jCj4gKysrIGIvbWFrZWR1bXBmaWxlLmMKPiBAQCAtMTIw
MTksMTQgKzEyMDE5LDE0IEBAIGludCBzaG93X21lbV91c2FnZSh2b2lkKQo+ICAgICAgICAgICAg
ICAgICBERUJVR19NU0coIlJlYWQgdm1jb3JlaW5mbyBmcm9tIE5PVEUgc2VnbWVudDogJWRcbiIs
IHZtY29yZWluZm8pOwo+ICAgICAgICAgfQo+Cj4gLSAgICAgICBpZiAoIWdldF9wYWdlX29mZnNl
dCgpKQo+IC0gICAgICAgICAgICAgICByZXR1cm4gRkFMU0U7Cj4gKyAgICAgICBpZiAoIXZtY29y
ZWluZm8pIHsKPiArICAgICAgICAgICAgICAgaWYgKCFnZXRfcGFnZV9vZmZzZXQoKSkKPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gRkFMU0U7Cj4KPiAtICAgICAgIC8qIHBhZGRyX3Rv
X3ZhZGRyKCkgb24gYXJtNjQgbmVlZHMgcGh5c19iYXNlLiAqLwo+IC0gICAgICAgaWYgKCFnZXRf
cGh5c19iYXNlKCkpCj4gLSAgICAgICAgICAgICAgIHJldHVybiBGQUxTRTsKPiArICAgICAgICAg
ICAgICAgLyogcGFkZHJfdG9fdmFkZHIoKSBvbiBhcm02NCBuZWVkcyBwaHlzX2Jhc2UuICovCj4g
KyAgICAgICAgICAgICAgIGlmICghZ2V0X3BoeXNfYmFzZSgpKQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBGQUxTRTsKPgo+IC0gICAgICAgaWYgKCF2bWNvcmVpbmZvKSB7Cj4gICAg
ICAgICAgICAgICAgIGlmICghZ2V0X3N5c19rZXJuZWxfdm1jb3JlaW5mbygmdm1jb3JlaW5mb19h
ZGRyLCAmdm1jb3JlaW5mb19sZW4pKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBG
QUxTRTsKPgo+IC0tCj4gMi4zMS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
