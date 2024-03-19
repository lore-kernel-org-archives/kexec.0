Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448D6C54E71
	for <kexec@archiver.kernel.org>; Tue, 19 Mar 2024 22:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2+24qq71IAD/PlqTlMQ+dwmQPfYWsMnUIkD80oLf1w0=; b=Is1iLqnaxB9CO3
	+56Cfsk7QjD5EngZtIosCEdJrASD00DW0abBmbmx09FmBHSmCSeI7o1qUztihbRhGKesUJ80T39ov
	YMGVEE7VvSecACiLSGt7oyU/BGv6txvC2tMhQRL//WQmhKdhQcZWuTtU3ptC0LopgnqZUBI1cmDL2
	yKV8u2k+iCYGbTvEZspa8ojh74p6TxsJlyKSc16xQnEcon4oWRl+SKbrsP7D/d2MdWr/kuKoDF/bX
	st+pMSW28bTCl2Jme1cmpXK7GSEhIgaeqGiZ8/Jiw9ammvCnfT6PP4QwB6CyPjOc78RjwLppzAnIx
	wAz2PI4byI0KnCkNA/7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmiO4-0000000EXTU-3hJe;
	Tue, 19 Mar 2024 22:56:52 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmiO1-0000000EXT2-3OFO
	for kexec@lists.infradead.org;
	Tue, 19 Mar 2024 22:56:51 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6e6b54a28ebso5937974b3a.2
        for <kexec@lists.infradead.org>; Tue, 19 Mar 2024 15:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710889009; x=1711493809; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvO758sYJ265RgjuIZmeyvFMHfbZZ7P9VeWdx+/M7QM=;
        b=WbQzbQ7mPnkbRVgKNG3Ar1dp9VuGUVVfFyqp7UG/ByfXQQZQEuWBS0mWyIbbvtiu7o
         eWzmeV5vpxmfnxeZYVfG5sHy3R+1CLlIatVXyVigRek6NA9UoTQfsB7SlGprdFOyILPj
         Me2MocffpmcHGonUXHwdULHks1MzebSCsvNJ9IaCTf2oUj2nZKqy5JijIITNsmNcfJs4
         xqYvJDmLSx7riTCSZmYbk87L+3orZmkJoRO45TiU2NIAvBU5pwH+ZBuix7+DJQsMlhmI
         J4WkeSlbJItPunpQe57NtBn2hDh81+vpqRydt2twKztspEYMm30CsHa7BD82Gz+okCZq
         XFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889009; x=1711493809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvO758sYJ265RgjuIZmeyvFMHfbZZ7P9VeWdx+/M7QM=;
        b=wqtayvZsfRZMhb7CTyfpDGeFKyHubXfP4pFiwwt9IBT+dT6LZuovwTuBmO8afDj6qp
         oCu4mUuym9yecE/eYVvElDUKlWxUjKU6lrExrr0tOM9/OP9gu3KtkJutxVIdt5ldbZll
         WR7PK7m3kcY07z6u4bcaOXEJQmRlbv4jv3yeMQQGau+tjJ/egc3Cu86vVwzXwqQz6Hea
         P5URyARgPrm+1jF0DFV5OgtlDyuzJt0ZPecHS80HFGmG7Z7mjT+AG35A1NUnLfxVTVxS
         BFga5KdFrq8H/8vZNABQi4qcGGzeZsZNn459goAUHCPY1qFLWpejQAhWNanTV3Fu4Ayz
         5Nsw==
X-Forwarded-Encrypted: i=1; AJvYcCUwHF9B5qfhi5Auj1V9eoK5coa2om3sHtp+x0pmJFHNG6pTWatkIfG/YDEL2AkeTmNEIleFTWOsgfv87QeZXz5EUB5eGvMkduzG
X-Gm-Message-State: AOJu0YyRGLpWyBEw0ypQd24yBQ2PKk6glVNM/Dkqug9U4TH9foApWWG0
	sOHUnVNCOJPojtCBt3l8l/W3XX4IY/W2ViZuQ9QpOSDijE4eQ0gITeST0ID5KBpB8VZ52IFgf5e
	3q8PWJmxrN0bEClmItSpwp8hrWD0=
X-Google-Smtp-Source: AGHT+IE4DY2oqCVLCQ9+J6jao44dthxa6ZatakgOPWtooqTRmh4LclgtjSwNT28qWOJ1gd5/jy5lxNTaZs8Yt7fbAa4=
X-Received: by 2002:a05:6a00:9388:b0:6e6:a9ff:b0b2 with SMTP id
 ka8-20020a056a00938800b006e6a9ffb0b2mr18557347pfb.22.1710889008689; Tue, 19
 Mar 2024 15:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240319080152.36987-1-hbathini@linux.ibm.com>
In-Reply-To: <20240319080152.36987-1-hbathini@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 15:56:36 -0700
Message-ID: <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: fix warning for crash_kexec
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_155649_879925_473D26D3 
X-CRM114-Status: GOOD (  18.07  )
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

T24gVHVlLCBNYXIgMTksIDIwMjQgYXQgMTowMuKAr0FNIEhhcmkgQmF0aGluaSA8aGJhdGhpbmlA
bGludXguaWJtLmNvbT4gd3JvdGU6Cj4KPiBXaXRoIFsxXSwgY3Jhc2ggZHVtcCBzcGVjaWZpYyBj
b2RlIGlzIG1vdmVkIG91dCBvZiBDT05GSUdfS0VYRUNfQ09SRQo+IGFuZCBwbGFjZWQgdW5kZXIg
Q09ORklHX0NSQVNIX0RVTVAsIHdoZXJlIGl0IGlzIG1vcmUgYXBwcm9wcmlhdGUuCj4gQW5kIHNp
bmNlIENPTkZJR19LRVhFQyAmICFDT05GSUdfQ1JBU0hfRFVNUCBidWlsZCBvcHRpb24gaXMgc3Vw
cG9ydGVkCj4gd2l0aCB0aGF0LCBpdCBsZWQgdG8gdGhlIGJlbG93IHdhcm5pbmc6Cj4KPiAgICJX
QVJOOiByZXNvbHZlX2J0ZmlkczogdW5yZXNvbHZlZCBzeW1ib2wgY3Jhc2hfa2V4ZWMiCj4KPiBG
aXggaXQgYnkgdXNpbmcgdGhlIGFwcHJvcHJpYXRlICNpZmRlZi4KPgo+IFsxXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNDAxMjQwNTEyNTQuNjcxMDUtMS1iaGVAcmVkaGF0LmNvbS8K
Pgo+IEFja2VkLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KPiBGaXhlczogMjlmZDlh
ZTYyOTEwICgiY3Jhc2g6IHNwbGl0IGNyYXNoIGR1bXBpbmcgY29kZSBvdXQgZnJvbSBrZXhlY19j
b3JlLmMiKQoKSSBkb24ndCB0aGluayBlaXRoZXIgYnBmIG9yIGJwZi1uZXh0IGhhdmUgdGhpcyBj
b21taXQganVzdCB5ZXQsIHNvCmxhbmRpbmcgaXQgaW4gdGhlIGJwZi9icGYtbmV4dCB0cmVlIGRv
ZXNuJ3QgbWFrZSBtdWNoIHNlbnNlLiBJdApwcm9iYWJseSB3b3VsZCBiZSBiZXN0IHRvIGxhbmQg
aXQgdGhyb3VnaCB0aGUgdHJlZSB3aGljaCBkb2VzIHRoZQpDT05GSUdfS0VYRUNfQ09SRSAtPiBD
T05GSUdfQ1JBU0hfRFVNUCBjaGFuZ2UgaW4ga2VybmVsL01ha2VmaWxlLgoKcHctYm90OiBjcgoK
PiBBY2tlZC1ieTogSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPgo+IEFja2VkLWJ5OiBTdGFu
aXNsYXYgRm9taWNoZXYgPHNkZkBnb29nbGUuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEhhcmkgQmF0
aGluaSA8aGJhdGhpbmlAbGludXguaWJtLmNvbT4KPiAtLS0KPgo+IENoYW5nZXMgaW4gdjI6Cj4g
KiBVcGRhdGVkIGNoYW5nZWxvZy4KPiAqIEFkZGVkIEZpeGVzIGFuZCBBY2tlZC1ieSB0YWdzLgo+
Cj4KPiAga2VybmVsL2JwZi9oZWxwZXJzLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvaGVs
cGVycy5jIGIva2VybmVsL2JwZi9oZWxwZXJzLmMKPiBpbmRleCBhODk1ODc4NTk1NzEuLjQ0OWI5
YTVkM2ZlMyAxMDA2NDQKPiAtLS0gYS9rZXJuZWwvYnBmL2hlbHBlcnMuYwo+ICsrKyBiL2tlcm5l
bC9icGYvaGVscGVycy5jCj4gQEAgLTI1NDgsNyArMjU0OCw3IEBAIF9fYnBmX2tmdW5jIHZvaWQg
YnBmX3Rocm93KHU2NCBjb29raWUpCj4gIF9fYnBmX2tmdW5jX2VuZF9kZWZzKCk7Cj4KPiAgQlRG
X0tGVU5DU19TVEFSVChnZW5lcmljX2J0Zl9pZHMpCj4gLSNpZmRlZiBDT05GSUdfS0VYRUNfQ09S
RQo+ICsjaWZkZWYgQ09ORklHX0NSQVNIX0RVTVAKPiAgQlRGX0lEX0ZMQUdTKGZ1bmMsIGNyYXNo
X2tleGVjLCBLRl9ERVNUUlVDVElWRSkKPiAgI2VuZGlmCj4gIEJURl9JRF9GTEFHUyhmdW5jLCBi
cGZfb2JqX25ld19pbXBsLCBLRl9BQ1FVSVJFIHwgS0ZfUkVUX05VTEwpCj4gLS0KPiAyLjQ0LjAK
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
