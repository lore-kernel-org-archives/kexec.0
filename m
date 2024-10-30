Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F152DD6B6DA
	for <kexec@archiver.kernel.org>; Wed, 30 Oct 2024 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yevTgnf5h+ETHvWmrsfZbmwrXyDZ6jpF1UPIl2J1WsQ=; b=XkSpsZnIbV8Hmq
	Vs18gRgB6Tzxce9If1z9FMENDOZDVn3nKwJauK6shGr8j35tsHXa2EYbCFPZXmgGHZo4CjakUwqEX
	uwxYOWTbsS+rjK26rgl1O9ScEaIIJrT0nPFd7u0IX3zThUxtt2YFjmhBKJoWk2Cu4973FUY81clNw
	czqL0MgfJ9/l4tGj4BINpcETE/r+uFi9pdTO7uIiJ5TKLkLuczhLgJZwS5E/w54NElRdgNw20grP/
	PIYTb7c2ropSVa5jSgTD1tJwijukE2TDgcoDr2WvSo7boOiipjsHpIt8egalDveFUcyP+s7ghgZYv
	1AWmEWjUvYtHHsAw/9Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6HQE-00000001zfA-2W8H;
	Wed, 30 Oct 2024 22:44:14 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6HQB-00000001zeK-22Sk
	for kexec@lists.infradead.org;
	Wed, 30 Oct 2024 22:44:12 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4315a8cff85so52545e9.0
        for <kexec@lists.infradead.org>; Wed, 30 Oct 2024 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730328249; x=1730933049; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPnPpvMxjfs6ca/yrsKQ/ymzLSP4VWx+Z93efIfuEgg=;
        b=RBm9HDDwpNHEispnYbWq0Hi60n8Y0ckbJWnwdW+rbd7jZm/ZKYIfM5O905+VNrACuf
         N3O+G7OU4cJ3jh9vCK9o/SOyEdDKsY66z0RkEdVIJUnRo6DOM7An2MEtralVVWU9Dk7Z
         /FVly3mJoTVB0Gu1dU9e8RoW+uKEyl5cej32GqqaIsUxEIG4TZoVfgndeiujj+pHH80t
         vUzKpsbv/bUQPe+6AUZrVCFVf4HSZC2kKjdetgDJFonW2AomzQ4XP7OYlmXM9zsZb6GL
         JxdFFwjbgQgbMzRELiNeDrtyDsruF7hxA1QJL1UbJtmAOcavdLXN5VlWViMyjWiAQJTt
         jc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730328249; x=1730933049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPnPpvMxjfs6ca/yrsKQ/ymzLSP4VWx+Z93efIfuEgg=;
        b=Jck+nrlYOSY8Ntu+OnELmFG8bMWji1ZktMQhyqDSOClPgOUB+/CXPqO9WoBuOf56O4
         c/Nau6awn5e8eiJy4k/lWzNcNPPRkhMBClXACcCAhRNJNuJRw0yNH4RpSQWkXq9fT7/p
         GAdMWVihVLzZxe8FfHSgsLwxQEx/ntDvkKHWa/y6QvUD4dS310ztmHHGSo6FDuoVrWCC
         wzszk53f7SiYsQR6zh8C9Szipub6iF9NiqHN/cJkUgRuCWWs7Dzbrt8dCzLfhQFliAM6
         m1f8Fkm9rGjx/BxpLt6BmiOYEfBJsqibL1N2GWbnoQ0LZtyhG9uiMVVVfNZV9C+Uu9JR
         vssg==
X-Forwarded-Encrypted: i=1; AJvYcCX/wVDgqRVxLAj7pmu3tv7Ha52xnrwJ127KRZBkIY9kkTp+m/h/g7bXFw12cpXsgs3zLe3VxQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQH1IfQ+/tOh2UI08szgzLKcNj78UtpB6AEmXJMIcI86WthBV0
	Y+Gn0qpbJituZZ1YlsKGWtavilHLYW6XkgVYBOXPkeIZ7KE8hMnvFiWJagWXw8YAYK8JRPrH36c
	S4udpaMiDygWcpUdfOqzpLDJXXiiUWmBBy2oN
X-Gm-Gg: ASbGncvupZ/fHEuoZeI4thBftIJBDZ7v7OhqiTeavGoq1Jo4uudAqWVlYqvLWBx2/Gz
	cVXuU7NTCF+gJCBWyPFqugr4fm/oP
X-Google-Smtp-Source: AGHT+IGiDK/Yh78ucrdpGaMeQexkQNAiQJjBQAsjPXA1SS/EAbGjme0Q880vLm7UFXTyXv9x83UBq70x1u0XbwYFdhg=
X-Received: by 2002:a05:600c:4e45:b0:431:3baa:2508 with SMTP id
 5b1f17b1804b1-4327d9039cemr759015e9.3.1730328248598; Wed, 30 Oct 2024
 15:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <f44f317a-2dcb-cfe2-013c-7508907ce3df@google.com>
 <5b6613bc-beef-79e6-62ed-23de4dfafe51@google.com> <ZyEO0rFGTGAs-d_N@kernel.org>
In-Reply-To: <ZyEO0rFGTGAs-d_N@kernel.org>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 30 Oct 2024 15:43:57 -0700
Message-ID: <CAPTztWZ26YQmtDbXowUzrRUSb2mmbQksztHfbRYYTgDm9Gc_og@mail.gmail.com>
Subject: Re: Pmemfs/guestmemfs discussion recap and open questions
To: Mike Rapoport <rppt@kernel.org>
Cc: David Rientjes <rientjes@google.com>, James Gowans <jgowans@amazon.com>, 
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Pasha Tatashin <tatashin@google.com>, Peter Xu <peterx@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, Steve Rutherford <srutherford@google.com>, 
	Erdem Aktas <erdemaktas@google.com>, Alper Gun <alpergun@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Sagi Shahar <sagis@google.com>, linux-mm@kvack.org, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_154411_551782_7BAFAAC8 
X-CRM114-Status: GOOD (  28.86  )
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

T24gVHVlLCBPY3QgMjksIDIwMjQgYXQgOTozOeKAr0FNIE1pa2UgUmFwb3BvcnQgPHJwcHRAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBIaSBEYXZpZCwKPgo+IE9uIEZyaSwgT2N0IDI1LCAyMDI0IGF0
IDExOjA3OjI3UE0gLTA3MDAsIERhdmlkIFJpZW50amVzIHdyb3RlOgo+ID4gT24gV2VkLCAxNiBP
Y3QgMjAyNCwgRGF2aWQgUmllbnRqZXMgd3JvdGU6Cj4gPgo+ID4gPiAtLS0tLT5vLS0tLS0KPiA+
ID4gTXkgdGFrZWF3YXk6IGJhc2VkIG9uIHRoZSBmZWVkYmFjayB0aGF0IHdhcyBwcm92aWRlZCBp
biB0aGUgZGlzY3Vzc2lvbjoKPiA+ID4KPiA+ID4gIC0gd2UgbmVlZCBhbiBhbGxvY2F0b3IgYWJz
dHJhY3Rpb24gZm9yIHBlcnNpc3RlbnQgbWVtb3J5IHRoYXQgY2FuIHJldHVybgo+ID4gPiAgICBt
ZW1vcnkgd2l0aCB2YXJpb3VzIGNoYXJhY3RlcmlzdGljczogMUdCIG9yIG5vdCwga2VybmVsIGRp
cmVjdCBtYXAgb3IKPiA+ID4gICAgbm90LCBIVk8gb3Igbm90LCBldGMuCj4gPiA+Cj4gPiA+ICAt
IGJ1aWx0IG9uIHRvcCBvZiB0aGF0LCB3ZSBuZWVkIHRoZSBhYmlsaXR5IHRvIGNhcnZlIG91dCB2
ZXJ5IGxhcmdlCj4gPiA+ICAgIHJhbmdlcyBvZiBtZW1vcnkgKGNsb3VkIHByb3ZpZGVyIHVzZSBj
YXNlKSB3aXRoIE5VTUEgYXdhcmVuZXNzIG9uIHRoZQo+ID4gPiAgICBrZXJuZWwgY29tbWFuZCBs
aW5lCj4gPiA+Cj4gPgo+ID4gRm9sbG93aW5nIHVwIG9uIHRoaXMsIEkgdGhpbmsgdGhpcyBwaHlz
aWNhbCBtZW1vcnkgYWxsb2NhdG9yIHdvdWxkIGFsc28gYmUKPiA+IHBvc3NpYmxlIHRvIHVzZSBh
cyBhIGJhY2tlbmQgZm9yIGh1Z2V0bGIuICBIb3BlZnVsbHkgdGhpcyB3b3VsZCBiZSBhbgo+ID4g
YWxsb2NhdG9yIHRoYXQgd291bGQgYmUgZ2VuZXJhbGx5IHVzZWZ1bCBmb3IgbXVsdGlwbGUgcHVy
cG9zZXMsIHNvbWV0aGluZwo+ID4gbGlrZSBhIG1tL3BoeXNfYWxsb2MuYy4KPgo+IENhbiB5b3Ug
ZWxhYm9yYXRlIG9uIHRoaXM/IG1tL3BhZ2VfYWxsb2MuYyBhbHJlYWR5IGFsbG9jYXRlcyBwaHlz
aWNhbAo+IG1lbW9yeSA6KQo+Cj4gT3IgeW91IG1lYW4gYW4gYWxsb2NhdG9yIHRoYXQgd2lsbCBk
ZWFsIHdpdGggbWVtb3J5IGNhcnZlZCBvdXQgZnJvbSB3aGF0IHBhZ2UKPiBhbGxvY2F0b3IgbWFu
YWdlcz8KPgo+ID4gRnJhbmsgdmFuIGRlciBMaW5kZW4gbWF5IGFsc28gaGF2ZSB0aG91Z2h0cyBv
biB0aGUgYWJvdmU/CgpZZWFoICdwaHlzaWNhbCBhbGxvY2F0b3InIGlzIGEgYml0IG9mIGEgbWlz
bm9tZXIuIFlvdSdyZSByaWdodCwgYW4KYWxsb2NhdG9yIHRoYXQgZGVhbHMgd2l0aCBtZW1vcnkg
bm90IHVuZGVyIHBhZ2UgYWxsb2NhdG9yIGNvbnRyb2wgaXMgYQpiZXR0ZXIgZGVzY3JpcHRpb24u
CgpUbyBlbGFib3JhdGUgYSBiaXQ6IHRoZXJlIGFyZSB2YXJpb3VzIHNjZW5hcmlvcyB3aGVyZSBh
bGxvY2F0aW5nCmNvbnRpZ3VvdXMgc3RyZXRjaGVzIG9mIHBoeXNpY2FsIG1lbW9yeSBpcyB1c2Vm
dWwuIEh1Z2VUTEIsIFZNIGd1ZXN0Cm1lbW9yeS4gT3Igd2hlcmUgeW91IGFyZSBwcmVzZW50ZWQg
d2l0aCBhbiBleHRlcm5hbCByYW5nZSBvZiBWTV9QRk5NQVAKbWVtb3J5IGFuZCBuZWVkIHRvIG1h
bmFnZSBpdCBpbiBhIHNpbXBsZSB3YXkgYW5kIGhhbmQgaXQgb3V0IGZvciBndWVzdAptZW1vcnkg
c3VwcG9ydCAoc2VlIE5WaWRpYSdzIGdpdGh1YiBmb3IgbnZncmFjZS1lZ20pLiBIb3dldmVyLCBh
bGwgb2YKdGhlc2UgY2FzZXMgbWF5IGNvbWUgd2l0aCBzbGlnaHRseSBkaWZmZXJlbnQgcmVxdWly
ZW1lbnRzOiBpcyB0aGUKbWVtb3J5IHB1cmVseSBleHRlcm5hbD8gRG9lcyBpdCBoYXZlIHN0cnVj
dCBwYWdlcz8gSWYgc28sIGlzIGl0IGluIHRoZQpkaXJlY3QgbWFwPyBJcyB0aGUgbWVtbWFwIGZv
ciB0aGUgbWVtb3J5IG9wdGltaXplZCAoSFZPLXN0eWxlKT8gRG9lcwppdCBuZWVkIHRvIGJlIHBl
cnNpc3RlbnQ/IFdoZW4gZG9lcyBpdCBuZWVkIHRvIGJlIHplcm9lZCBvdXQ/CgpTbyB0aGF0J3Mg
d2h5IGl0IHNlZW1zIGxpa2UgYSBnb29kIGlkZWEgdG8gY29tZSB1cCB3aXRoIGEgc2xpZ2h0bHkK
bW9yZSBnZW5lcmFsaXplZCB2ZXJzaW9uIG9mIHBvb2wgYWxsb2NhdG9yIC0gc29tZXRoaW5nIHRo
YXQgbWFuYWdlcywKdXN1YWxseSBsYXJnZXIsIGNodW5rcyBvZiBwaHlzaWNhbGx5IGNvbnRpZ3Vv
dXMgbWVtb3J5LiBBIGlzCmluaXRpYWxpemVkIHdpdGggY2VydGFpbiBwcm9wZXJ0aWVzIChwZXJz
aXN0ZW5jZSwgZXRjKS4gSXQgaGFzIG1ldGhvZHMKdG8gZ3JvdyBhbmQgc2hyaW5rIHRoZSBwb29s
IGlmIG5lZWRlZC4gSXQncyBpbiBubyB3YXkgbWVhbnQgdG8gYmUKYW55d2hlcmUgbmVhciBhcyBz
b3BoaXN0aWNhdGVkIGFzIHRoZSBwYWdlIGFsbG9jYXRvciwgdGhhdCB3b3VsZCBub3QKYmUgdXNl
ZnVsIChhbmQgcG9pbnRsZXNzIGNvZGUgZHVwbGljYXRpb24pLiBBIHNpbXBsZSBmaXhlZC1zaXpl
IGNodW5rCnBvb2wgd2lsbCBzYXRpc2Z5IGEgbG90IG9mIHRoZXNlIGNhc2VzLgoKQSBudW1iZXIg
b2YgdGhlIGJ1aWxkaW5nIGJsb2NrcyBhcmUgYWxyZWFkeSB0aGVyZTogdGhlcmUncyBDTUEsCnRo
ZXJlJ3MgWk9ORV9ERVZJQ0Ugd2hpY2ggaGFzIHRvb2xzIHRvIG1hbmlwdWxhdGUgc29tZSBvZiB0
aGVzZQpwcm9wZXJ0aWVzIChieSBnb2luZyB0aHJvdWdoIGEgaG90cmVtb3ZlIC8gaG90cGx1ZyBj
eWNsZSkuIEkgY3JlYXRlZCBhCnNpbXBsZSBwcm90b3R5cGUgdGhhdCBlc3NlbnRpYWxseSB1c2Vz
IENNQSBhcyBhIHBvb2wgcHJvdmlkZXIsIGFuZAp1c2VzIHNvbWUgWk9ORV9ERVZJQ0UgdG9vbHMg
dG8gaW5pdGlhbGl6ZSBtZW1vcnkgaG93ZXZlciB5b3Ugd2FudCBpdAp3aGVuIGl0J3MgYWRkZWQg
dG8gdGhlIHBvb2wuIEkgYWxzbyBhZGRlZCBzb21lIG5ldyBpbml0IGNvZGUgdG8gdG8KYXZvaWQg
dGhpbmdzIGxpa2UgdW5uZWVkZWQgbWVtbWFwIGFsbG9jYXRpb24gYXQgYm9vdCBmb3IgaHVnZXRs
YmZzCnBhZ2VzLiBJIHB1dCBodWdldGxiZnMgb24gdG9wIG9mIGl0IC0gYnV0IGluIGEgcmVzdHJp
Y3RlZCB3YXkgZm9yCnByb3RvdHlwaW5nIHB1cnBvc2VzIChubyByZXNlcnZhdGlvbnMsIG5vIGRl
bW90aW9uKS4KCkFueXdheSwgdGhpcyBpcyB0aGUgYmFzaWMgaWRlYS4KCi0gRnJhbmsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
