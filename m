Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AA8C25B74
	for <kexec@archiver.kernel.org>; Sat, 18 May 2024 03:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zOtDP0KBTCU3sm61laFxN/X54vpK25rGMdyvpdHF/oM=; b=N+WtQASXs4rc1F
	b1Vbb5ZCstuKTIbVnlqqj1KqkPKASzZcWC7zfeLaClHrT3zsaL5tQyxx4OfDwU8bZqF61fzmODzuv
	bMtdIIT/NpHjSL1xTPhh3ViwCTgoGRf8IZqfn13UrD1h1BZ5Z0R5lWinKfwFqeWRA7XwWw+WyluPt
	cQtJLrilUlAQqf3vx/UODVeojJnQDd+VYYzxrywqzxOXPGArqSZN11yN0umjonfGQtMQ8DMo1z8YW
	xwNG24yGytUruAcnPJafesxDuUymNbf8jzdZPDPiqhYcD2MYj6/T1QL2z1HwFKQOpBqNTHpeAwMMr
	LTKUpWsyLVXVzT758JEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8Auh-00000009VH1-1HRW;
	Sat, 18 May 2024 03:39:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8Aud-00000009VGJ-19rZ
	for kexec@lists.infradead.org;
	Sat, 18 May 2024 03:39:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716003541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOMsgTOZbTgZxLJbDJIWDfNoyTBDqh5fBHBDsSDqCYs=;
	b=KF5XwZfSOdSgWNMs+RVysgS4pQtRsK/UTyACUPMd2K4nW+NFbkNIVhpEvsJ8QzM7AGpCl+
	TQ3P395ru6SwvYmrhx4obE9uS1jeiNL/QdXZaXDVWkhRCQTb5Ot9rLdEsJdbQBcHtPV4Ny
	JH41x3betRZyp0ApGRt5dSP+I/E2kgM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-8JKNft9XPM6qhDHTqM3Lpg-1; Fri, 17 May 2024 23:38:59 -0400
X-MC-Unique: 8JKNft9XPM6qhDHTqM3Lpg-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36da84df784so6581405ab.0
        for <kexec@lists.infradead.org>; Fri, 17 May 2024 20:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716003539; x=1716608339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOMsgTOZbTgZxLJbDJIWDfNoyTBDqh5fBHBDsSDqCYs=;
        b=O1PO9d+cc06Psnu+KYXokRlcgtIpHIDfG6yG9GVbFpkHg2jqW5bc9yxbrntvCynKTo
         DIhlmqB5oq4kvRDkRPzPeH8JuKHUNxZaqHm9HbO1KeTLiozE1R3DwjERqMyojF2WDCrB
         mNrVxwuPgQ4T6LD9M4CTZ7vHdqIYmq1VYUzqRe+YeYHEt8CWQpYZc1YHVz0/mmu+gg0F
         LClTSHu4cJhhog+feQW6Qv3TcZ+AGfaKAbM6N0+5tV1Y510HBbfCUGaQJQ+JNGrfF762
         Db6YrVAUQB6xjegwoizX0Olc+51/klrymxE9RVAzqf+EF/toWGBsl8H2a+PzFc4+5XDO
         ke2g==
X-Forwarded-Encrypted: i=1; AJvYcCVt6DZ33f+/Sh6iwQKvDLAETXWoPuLWHdjV9WBLMFzFY8TwF+36CJ8LtrqagRkqNRLabon4kVQjtlCj7ljBBqU8fhHnDPQctyIW
X-Gm-Message-State: AOJu0Yw5kRA7Jcz3z6eVandS/BR76YmQbY/S61pmttgwFQ00hVM+veF2
	zWvQCJXmHgHEcMcLemzAQiParhC7wHrQ+36DJ5IlkvDb+qzhutvHcFQzuUS7zPzBIAijgnPSh7P
	23v+NuS/FrJw5GwoaVDWH+MYQcrDHLkFRCT5oP9D6AnVt1TYJCxSGZ9adsdphoaP6xoo95bOkQZ
	Ubyh+v+YpUkt5CnFOykjVW4jr5qH2RbTic
X-Received: by 2002:a92:d782:0:b0:36a:38bf:5fb2 with SMTP id e9e14a558f8ab-36cc14d041fmr229478675ab.2.1716003538753;
        Fri, 17 May 2024 20:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUkd2CrpO3LE8zFbBSWmdS0z76l2z28N5+kMZlwep2t+oioixkSxAPNKQwDuaKsK1DrtDbEoYwE/1mhpjq6tc=
X-Received: by 2002:a92:d782:0:b0:36a:38bf:5fb2 with SMTP id
 e9e14a558f8ab-36cc14d041fmr229478565ab.2.1716003538396; Fri, 17 May 2024
 20:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
 <20230920115634.GG224399@kernel.org> <DA84A55096BADE15+594e239a-ff6a-368f-ae92-b6cfebbf8dc0@tinylab.org>
In-Reply-To: <DA84A55096BADE15+594e239a-ff6a-368f-ae92-b6cfebbf8dc0@tinylab.org>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 18 May 2024 11:39:18 +0800
Message-ID: <CALu+AoSr+an7Ps-jhcSbvrq4E4FnqkiNZVH-2BhV_3=B+oDcFQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Kexec-tools: Improve RISC-V port
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: Simon Horman <horms@kernel.org>, mick@ics.forth.gr, lizhengyu3@huawei.com, 
	liaochang1@huawei.com, xianting.tian@linux.alibaba.com, guoren@kernel.org, 
	huanyi.xj@alibaba-inc.com, yixun.lan@gmail.com, kexec@lists.infradead.org, 
	hursand@fedoraproject.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240517_203911_419964_09091A4E 
X-CRM114-Status: GOOD (  24.80  )
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

T24gV2VkLCAxMSBPY3QgMjAyMyBhdCAxMzoyNCwgU29uZyBTaHVhaSA8c29uZ3NodWFpc2h1YWlA
dGlueWxhYi5vcmc+IHdyb3RlOgo+Cj4KPgo+IOWcqCAyMDIzLzkvMjAgMTk6NTYsIFNpbW9uIEhv
cm1hbiDlhpnpgZM6Cj4gPiBPbiBGcmksIFNlcCAxNSwgMjAyMyBhdCAxMTo1MDowNkFNICswODAw
LCBTb25nIFNodWFpIHdyb3RlOgo+ID4+IEhpLAo+ID4+Cj4gPj4gVGhpcyBzZXJpZXMgaXMgY3Jl
YXRlZCB0byBpbXByb3ZlIFJJU0MtViBwb3J0IG9mIGtleGVjLXRvb2xzLAo+ID4+IGFuZCBpcyBi
YXNlZCBvbiB0aGUgaG9ybXMva2V4ZWMtdG9vbHM6YnVpbGQtdGVzdC1yaXNjdi12MiBicmFuY2gu
Cj4gPgo+ID4gSW4gbXkgbWluZCB0aGUgYmlnIHF1ZXN0aW9uIGlzIGhvdyB0byBtb3ZlIFJJU0Mt
ViBzdXBwb3J0Cj4gPiBmcm9tIHRoYXQgYnJhbmNoLCB0byBiZWluZyBtZXJnZWQgaW50byBtYWlu
Lgo+ID4KPiA+IElJUkMgdGhlcmUgd2VyZSBzb21lIGlzc3VlcyB0aGF0IG5lZWRlZCB0byBiZSBh
ZGRyZXNzZWQuCj4gPiBQZXJoYXBzIHRoZXkgYXJlIGFsbCBhZGRyZXNzZWQgYnkgdGhpcyBzZXJp
ZXMsIGFuZCB3aXRoCj4gPiBzb21lIGFwcHJvcHJpYXRlIHNxdWFzaGluZyB3ZSBjYW4gbW92ZSBm
b3J3YXJkcyB3aXRoIGEgc2VyaWVzCj4gPiBiYXNlZCBvbiBtYWluPwo+Cj4gSGksIFNpbW9uIGFu
ZCBOaWNrOgo+Cj4gSSBzcXVhc2hlZCB0aGUgZmlyc3QgZm91ciBwYXRjaGVzIGFzIGEgIlJJU0Mt
VjogU29tZSBmaXhlcyBmb3IgcmlzY3YKPiBwb3J0IiBwYXRjaCBhbmQgdGhlbiB0b29rIHRoZSBo
b3Jtcy9tYWluIGFzIHRoZSBiYXNlIHRvIGNvbGxlY3QgdGhlIDIKPiBwYXRjaGVzIGZyb20gaG9y
bXMvYnVpbGQtdGVzdC1yaXNjdi12MiBicmFuY2ggYW5kIHRoaXMgc2VyaWVzIHRvZ290aGVyLgo+
IFRoZXNlIGFyZSB0aGUgR2l0aHViIGxpbmsgYW5kIGFsbCBjb21taXRzIGZvciBSSVNDLVYuCj4K
PiBodHRwczovL2dpdGh1Yi5jb20vc3VnYXJmaWxsZXQva2V4ZWMtdG9vbHMvY29tbWl0cy9tYWlu
X3J2Cj4KPiA1ZGMxMzNlIFJJU0MtVjogU3VwcG9ydCBsb2FkaW5nIEltYWdlIGJpbmFyeSBmaWxl
Cj4gYjA0MmY2ZCBSSVNDLVY6IFNlcGFyYXRlIGVsZl9yaXNjdl9maW5kX3BiYXNlIG91dAo+IDhm
MzQ0YzcgUklTQy1WOiBFbmFibGUga2V4ZWNfZmlsZV9sb2FkIHN5c2NhbGwKPiA3ZDRiOTgyIFJJ
U0MtVjogU29tZSBmaXhlcyBmb3IgcmlzY3YgcG9ydAo+IDMyMDVjMWMgbG9jYWw6IFJJU0MtVjog
ZGlzdHJpYnV0ZSBwdXJnYXRvcnkvcmlzY3YvTWFrZWZpbGUKPiA1NGY5ZGFmIFJJU0MtVjogQWRk
IHN1cHBvcnQgZm9yIHJpc2N2IGtleGVjL2tkdW1wIG9uIGtleGVjLXRvb2xzCj4KPiBTaW5jZSBJ
IGRpZG4ndCBmb3VuZCB0aGUgaXNzdWVzL2ZpeGVzIGFzIE5pY2sgbWVudGlvbmVkIHdpdGggdGhl
c2UKPiBjb21taXRzLCBJIHByZWZlciB0byBtZXJnZSB0aGVtIGludG8gaG9ybXMvbWFpbiBhbmQg
bGV0IG1vcmUga2V4ZWMva2R1bXAKPiB1c2VycyB0byBoZWxwIGltcHJvdmUvZml4dXAgUklTQy1W
IHBvcnQuCgpIaSwgIEkgbm90aWNlZCBhbm90aGVyIHByIGZvciBGZWRvcmEga2V4ZWMtdG9vbHM6
Cmh0dHBzOi8vc3JjLmZlZG9yYXByb2plY3Qub3JnL3JwbXMva2V4ZWMtdG9vbHMvcHVsbC1yZXF1
ZXN0LzI0CgpJdCBpcyBiYWQgdG8gdGFrZSBpdCBhcyBGZWRvcmEgb25seSwgICBJIHdvdWxkIHN1
Z2dlc3QgcG9zdGluZyBhbGwgdGhlCnJlZnJlc2hlZCBwYXRjaGVzIHRvZ2V0aGVyIGhlcmUgYWdh
aW4gZm9yIHJldmlldy4KCklmIG5vIGVub3VnaCByZXZpZXdlcnMgY2FuIHJldmlldyB0aGVtIG15
IGFub3RoZXIgc3VnZ2VzdGlvbiBpcyB0bwpkcm9wIHRoZSBrZXhlY19sb2FkIHN1cHBvcnQgY29k
ZSBmb3IgdGhlIHRpbWUgYmVpbmcsIGFuZCBvbmx5IGVuYWJsZQp0aGUga2V4ZWNfZmlsZV9sb2Fk
IHN1cHBvcnQgY29kZSBpbiBrZXhlYy10b29scywgYW5kIEkgYXNzdW1lIGJlbG93Cmtlcm5lbCBj
b21taXQgbWFrZSB0aGUga2V4ZWNfZmlsZV9sb2FkIGtlcm5lbCBwaWVjZSBvZiB3b3JrIGRvbmUu
ClRoZW4gaXQgd2lsbCBiZSBlYXNpZXIgdG8gcmV2aWV3IGFuZCBtYWtlIHNvbWV0aGluZyB3b3Jr
aW5nIGF0IGxlYXN0Lgpjb21taXQgNjI2MTU4NmUwYzkxZGIxNGMzNGY4OTRmNGJjNDhmMjMwMGNm
ZjFkNApBdXRob3I6IExpYW8gQ2hhbmcgPGxpYW9jaGFuZzFAaHVhd2VpLmNvbT4KRGF0ZTogICBG
cmkgQXByIDggMTg6MDk6MTEgMjAyMiArMDgwMAoKICAgIFJJU0MtVjogQWRkIGtleGVjX2ZpbGUg
c3VwcG9ydAoKVGhhbmtzCkRhdmUKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
