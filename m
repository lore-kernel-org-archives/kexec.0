Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B35C531DD
	for <kexec@archiver.kernel.org>; Wed, 14 Aug 2024 09:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c6ZRHhU1enViFKLzc9SzJsiDzPAICS0oiCu6osRkalw=; b=FZjKxCoaaznPeZ
	1deXgCKVGJREw+tC9Whghhfi90q6t7eEnRMdAQvTAD22R3965aPp8iVXANzV/fGrfPHFGzT3iwxON
	bTutxPWBBBVZiaD0sY+b1mtm2/K2NGrh1v18d63KssSdZnUG36TS/x+mtYx5G5VaO44jqpLmn5k2Q
	WjLatZJ8TP78iJrC+riKjV/dvZEtSrnQXfGGxypUpkqkcHw2w7sADqCr/WG5zvplqzgrH5PXm5cVU
	8ks49XxE/b2oCG0/t0U4Zww1ZvrFm459ICWYSwidWT8PLVpTEcYSNy0hDdVmRe44z07PCSgm9bA7j
	1gF2DVt3FSs8on5/VEvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seAL6-00000006Obu-0gh8;
	Wed, 14 Aug 2024 09:30:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se9Jd-00000006EVU-2oxg
	for kexec@bombadil.infradead.org;
	Wed, 14 Aug 2024 08:25:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9vuF872nkPXL8K9WksdWFN226ObLiMYpHQpW24yj/t4=; b=LIsNy8yAdlrXbWXKFYDHAAwNv7
	hVnGOHsL9eYBbx2eBPCWVzjgMkBndVp5IhVZwPggrCIgzeOYJ+Kifgod4OV4eokr8Twg80jMDy1Ax
	cVSAgsVMS3Dy25A/SzSjH6KfU8pFVyt9GTTdBUvvNQa+ATiap0IqVBGmqRKcrPmeQv6Bjqmo7jvOI
	d0rbn60FsLdR/01UiLvs5LKbe3iPEo0F3gFrIzIAIyiSn7R49dVuYyUZTIJY3lb70Xp27wSd8kNmj
	MrYYqGRRdIlPHVgE5hRaygQnW+pr6awS7m79M18sygt8M6IN/6R3rULSxrkiZbxeLr7AXv7Kht2tZ
	EFpdI/Cg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se9JY-00000007xaI-3buI
	for kexec@lists.infradead.org;
	Wed, 14 Aug 2024 08:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723623900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vuF872nkPXL8K9WksdWFN226ObLiMYpHQpW24yj/t4=;
	b=fvtsU8x3J5UMyvQlRQoW524PT5SE599gSsDnsqJmYAMA5bq7kAT2dj84jH4WLnFmLcDdni
	ptIrGRWzNoEKGyy0WR0khX7hfOvxngDUQeUsr89Rb34LF22de1A6HwKoqcTWyz74L3xSS1
	gcasaCsoZ/65EOKHMxDk9OI3F8bGv1Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723623901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vuF872nkPXL8K9WksdWFN226ObLiMYpHQpW24yj/t4=;
	b=Gro3gsbuXPsj8NgdalCfZiI+0Se3LajW7MmUXPYIU1nt3onKCEp0Kyrdnjau4MRqr9lJlw
	i6kvy2JxyQz4Q9KvuBGj0dT7BbBLsd1zeOcnizdyb7n9OAqse+GqkGmQ9PepOo8/ZMvSk0
	Z27Bz1j2CdGWpyeT0uH701yPIm/1D/I=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-IqDY7q22PMysti78uEfo0A-1; Wed, 14 Aug 2024 04:22:52 -0400
X-MC-Unique: IqDY7q22PMysti78uEfo0A-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8224c9a44dfso74710539f.1
        for <kexec@lists.infradead.org>; Wed, 14 Aug 2024 01:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623772; x=1724228572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vuF872nkPXL8K9WksdWFN226ObLiMYpHQpW24yj/t4=;
        b=IxRCfdkA3pPc9UIuKmxYV6v6RNvtB2RBugFEiS8Q1L6LGzkP5R3JTEFYVjs2WyDJOa
         sdSeRwysLEIGb4qfsvPrx+02v+bM63c2rj8Ke2mM15F6iMj1H7YCR/7RwdIG7eCSivoB
         RLlwJLgOdKJNSJFZQoewiWYcm05kYwfIc84+XDR56Mf/7/B0H2rw87IsjSryDHAd9GID
         pJ6XK5WGgQXSgbJ93p2SnPvk2N9GJkCNJLJtF15ocqfd9k+3gd278D8inIPpI8pMcLx9
         D9NnIp1HhYiczWiaBRKltEpymzl0U60r4jaC+A9gOPeErdByIICYWug7CjazIEEIR8Vj
         7CYw==
X-Forwarded-Encrypted: i=1; AJvYcCW68L3bTyrqxarlxx2ZbelHN01xRLFwfC4GpfVTMQ9vbthlRjyPodvn6b3O6v5DP1moEJdmsym+4GND5D75PgrVyyqYtb6hkX+F
X-Gm-Message-State: AOJu0YzG+tQ8JWLdRODnGaKZRHHECylVuJkjz8eDV6YprG69hN6oqPqR
	QDnA7aaqqHXU+m6WTKZ+d2EgdhtUAkd1qLFawRdIfUHNF/7pu6ux6JL4GbVD+mM39z+ZkwSMfwk
	JUMc5MCX4a62Ox6tGGjoVbes+wbCTDKKkYiRgPbqYkoC0itRk4fOOftRKI3UqCzpc3BB1lckkOb
	xmYYJdsvuvHQ0ItyNij9NNBDJlWxDTx1TY
X-Received: by 2002:a92:cda6:0:b0:395:fa9a:3195 with SMTP id e9e14a558f8ab-39d1245d2d1mr16510925ab.2.1723623771949;
        Wed, 14 Aug 2024 01:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHQGQKFeDz98Jsq3cIvRwlcTqsmEmdZXwabAb3ypj6VAv2BjT5dEzpQw/6+YDW6IiroV+9rFnzD2LQvgmIODU=
X-Received: by 2002:a92:cda6:0:b0:395:fa9a:3195 with SMTP id
 e9e14a558f8ab-39d1245d2d1mr16510745ab.2.1723623771579; Wed, 14 Aug 2024
 01:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
 <20230920115634.GG224399@kernel.org> <DA84A55096BADE15+594e239a-ff6a-368f-ae92-b6cfebbf8dc0@tinylab.org>
 <CALu+AoSr+an7Ps-jhcSbvrq4E4FnqkiNZVH-2BhV_3=B+oDcFQ@mail.gmail.com>
 <20240518083304.GD475595@kernel.org> <20240812163633.098f8f07@mordecai.tesarici.cz>
In-Reply-To: <20240812163633.098f8f07@mordecai.tesarici.cz>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 14 Aug 2024 16:23:04 +0800
Message-ID: <CALu+AoSmG9eehL+udT2KHzn4H5Gq9eJ_t-C_H8mkJMhvB3VpPQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Kexec-tools: Improve RISC-V port
To: Petr Tesarik <ptesarik@suse.com>
Cc: Simon Horman <horms@kernel.org>, Song Shuai <songshuaishuai@tinylab.org>, mick@ics.forth.gr, 
	lizhengyu3@huawei.com, liaochang1@huawei.com, xianting.tian@linux.alibaba.com, 
	guoren@kernel.org, huanyi.xj@alibaba-inc.com, yixun.lan@gmail.com, 
	kexec@lists.infradead.org, hursand@fedoraproject.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240814_092505_251806_25926A8C 
X-CRM114-Status: GOOD (  39.21  )
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

T24gTW9uLCAxMiBBdWcgMjAyNCBhdCAyMjozNiwgUGV0ciBUZXNhcmlrIDxwdGVzYXJpa0BzdXNl
LmNvbT4gd3JvdGU6Cj4KPiBIaSwKPgo+IE9uIFNhdCwgMTggTWF5IDIwMjQgMDk6MzM6MDQgKzAx
MDAKPiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gPiBPbiBTYXQs
IE1heSAxOCwgMjAyNCBhdCAxMTozOToxOEFNICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+ID4g
PiBPbiBXZWQsIDExIE9jdCAyMDIzIGF0IDEzOjI0LCBTb25nIFNodWFpIDxzb25nc2h1YWlzaHVh
aUB0aW55bGFiLm9yZz4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g5Zyo
IDIwMjMvOS8yMCAxOTo1NiwgU2ltb24gSG9ybWFuIOWGmemBkzoKPiA+ID4gPiA+IE9uIEZyaSwg
U2VwIDE1LCAyMDIzIGF0IDExOjUwOjA2QU0gKzA4MDAsIFNvbmcgU2h1YWkgd3JvdGU6Cj4gPiA+
ID4gPj4gSGksCj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBUaGlzIHNlcmllcyBpcyBjcmVhdGVkIHRv
IGltcHJvdmUgUklTQy1WIHBvcnQgb2Yga2V4ZWMtdG9vbHMsCj4gPiA+ID4gPj4gYW5kIGlzIGJh
c2VkIG9uIHRoZSBob3Jtcy9rZXhlYy10b29sczpidWlsZC10ZXN0LXJpc2N2LXYyIGJyYW5jaC4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBJbiBteSBtaW5kIHRoZSBiaWcgcXVlc3Rpb24gaXMgaG93IHRv
IG1vdmUgUklTQy1WIHN1cHBvcnQKPiA+ID4gPiA+IGZyb20gdGhhdCBicmFuY2gsIHRvIGJlaW5n
IG1lcmdlZCBpbnRvIG1haW4uCj4gPiA+ID4gPgo+ID4gPiA+ID4gSUlSQyB0aGVyZSB3ZXJlIHNv
bWUgaXNzdWVzIHRoYXQgbmVlZGVkIHRvIGJlIGFkZHJlc3NlZC4KPiA+ID4gPiA+IFBlcmhhcHMg
dGhleSBhcmUgYWxsIGFkZHJlc3NlZCBieSB0aGlzIHNlcmllcywgYW5kIHdpdGgKPiA+ID4gPiA+
IHNvbWUgYXBwcm9wcmlhdGUgc3F1YXNoaW5nIHdlIGNhbiBtb3ZlIGZvcndhcmRzIHdpdGggYSBz
ZXJpZXMKPiA+ID4gPiA+IGJhc2VkIG9uIG1haW4/Cj4gPiA+ID4KPiA+ID4gPiBIaSwgU2ltb24g
YW5kIE5pY2s6Cj4gPiA+ID4KPiA+ID4gPiBJIHNxdWFzaGVkIHRoZSBmaXJzdCBmb3VyIHBhdGNo
ZXMgYXMgYSAiUklTQy1WOiBTb21lIGZpeGVzIGZvciByaXNjdgo+ID4gPiA+IHBvcnQiIHBhdGNo
IGFuZCB0aGVuIHRvb2sgdGhlIGhvcm1zL21haW4gYXMgdGhlIGJhc2UgdG8gY29sbGVjdCB0aGUg
Mgo+ID4gPiA+IHBhdGNoZXMgZnJvbSBob3Jtcy9idWlsZC10ZXN0LXJpc2N2LXYyIGJyYW5jaCBh
bmQgdGhpcyBzZXJpZXMgdG9nb3RoZXIuCj4gPiA+ID4gVGhlc2UgYXJlIHRoZSBHaXRodWIgbGlu
ayBhbmQgYWxsIGNvbW1pdHMgZm9yIFJJU0MtVi4KPiA+ID4gPgo+ID4gPiA+IGh0dHBzOi8vZ2l0
aHViLmNvbS9zdWdhcmZpbGxldC9rZXhlYy10b29scy9jb21taXRzL21haW5fcnYKPiA+ID4gPgo+
ID4gPiA+IDVkYzEzM2UgUklTQy1WOiBTdXBwb3J0IGxvYWRpbmcgSW1hZ2UgYmluYXJ5IGZpbGUK
PiA+ID4gPiBiMDQyZjZkIFJJU0MtVjogU2VwYXJhdGUgZWxmX3Jpc2N2X2ZpbmRfcGJhc2Ugb3V0
Cj4gPiA+ID4gOGYzNDRjNyBSSVNDLVY6IEVuYWJsZSBrZXhlY19maWxlX2xvYWQgc3lzY2FsbAo+
ID4gPiA+IDdkNGI5ODIgUklTQy1WOiBTb21lIGZpeGVzIGZvciByaXNjdiBwb3J0Cj4gPiA+ID4g
MzIwNWMxYyBsb2NhbDogUklTQy1WOiBkaXN0cmlidXRlIHB1cmdhdG9yeS9yaXNjdi9NYWtlZmls
ZQo+ID4gPiA+IDU0ZjlkYWYgUklTQy1WOiBBZGQgc3VwcG9ydCBmb3IgcmlzY3Yga2V4ZWMva2R1
bXAgb24ga2V4ZWMtdG9vbHMKPiA+ID4gPgo+ID4gPiA+IFNpbmNlIEkgZGlkbid0IGZvdW5kIHRo
ZSBpc3N1ZXMvZml4ZXMgYXMgTmljayBtZW50aW9uZWQgd2l0aCB0aGVzZQo+ID4gPiA+IGNvbW1p
dHMsIEkgcHJlZmVyIHRvIG1lcmdlIHRoZW0gaW50byBob3Jtcy9tYWluIGFuZCBsZXQgbW9yZSBr
ZXhlYy9rZHVtcAo+ID4gPiA+IHVzZXJzIHRvIGhlbHAgaW1wcm92ZS9maXh1cCBSSVNDLVYgcG9y
dC4KPiA+ID4KPiA+ID4gSGksICBJIG5vdGljZWQgYW5vdGhlciBwciBmb3IgRmVkb3JhIGtleGVj
LXRvb2xzOgo+ID4gPiBodHRwczovL3NyYy5mZWRvcmFwcm9qZWN0Lm9yZy9ycG1zL2tleGVjLXRv
b2xzL3B1bGwtcmVxdWVzdC8yNAo+ID4gPgo+ID4gPiBJdCBpcyBiYWQgdG8gdGFrZSBpdCBhcyBG
ZWRvcmEgb25seSwgICBJIHdvdWxkIHN1Z2dlc3QgcG9zdGluZyBhbGwgdGhlCj4gPiA+IHJlZnJl
c2hlZCBwYXRjaGVzIHRvZ2V0aGVyIGhlcmUgYWdhaW4gZm9yIHJldmlldy4KPiA+ID4KPiA+ID4g
SWYgbm8gZW5vdWdoIHJldmlld2VycyBjYW4gcmV2aWV3IHRoZW0gbXkgYW5vdGhlciBzdWdnZXN0
aW9uIGlzIHRvCj4gPiA+IGRyb3AgdGhlIGtleGVjX2xvYWQgc3VwcG9ydCBjb2RlIGZvciB0aGUg
dGltZSBiZWluZywgYW5kIG9ubHkgZW5hYmxlCj4gPiA+IHRoZSBrZXhlY19maWxlX2xvYWQgc3Vw
cG9ydCBjb2RlIGluIGtleGVjLXRvb2xzLCBhbmQgSSBhc3N1bWUgYmVsb3cKPiA+ID4ga2VybmVs
IGNvbW1pdCBtYWtlIHRoZSBrZXhlY19maWxlX2xvYWQga2VybmVsIHBpZWNlIG9mIHdvcmsgZG9u
ZS4KPiA+ID4gVGhlbiBpdCB3aWxsIGJlIGVhc2llciB0byByZXZpZXcgYW5kIG1ha2Ugc29tZXRo
aW5nIHdvcmtpbmcgYXQgbGVhc3QuCj4gPiA+IGNvbW1pdCA2MjYxNTg2ZTBjOTFkYjE0YzM0Zjg5
NGY0YmM0OGYyMzAwY2ZmMWQ0Cj4gPiA+IEF1dGhvcjogTGlhbyBDaGFuZyA8bGlhb2NoYW5nMUBo
dWF3ZWkuY29tPgo+ID4gPiBEYXRlOiAgIEZyaSBBcHIgOCAxODowOToxMSAyMDIyICswODAwCj4g
PiA+Cj4gPiA+ICAgICBSSVNDLVY6IEFkZCBrZXhlY19maWxlIHN1cHBvcnQKPiA+Cj4gPiBIaSwK
PiA+Cj4gPiBJIHdvdWxkIGdsYWRseSB0YWtlIGEgcGF0Y2hzZXQgZm9yIGtleGVjLXRvb2xzIHRo
YXQgYWRkcyBSSVNDLVYgc3VwcG9ydCBpbgo+ID4gYSBjb2hlcmVudCBtYW5uZXIuCj4KPiBIYXZl
IEkgbWlzc2VkIHNvbWUgcHJvZ3Jlc3Mgb24gdGhpcyB0b3BpYz8gRldJVyBJIGNhbiB0YWtlIGNh
cmUgb2YKPiBSSVNDLVYgc3VwcG9ydCBpbiBrZXhlYy10b29scywgSSBldmVuIHJlY2VpdmVkIGEg
VmlzaW9uRml2ZSAyIGJvYXJkCj4gZnJvbSBSVkkgbGFzdCB5ZWFyIHNwZWNpZmljYWxseSB0byBo
ZWxwIHdpdGgga2V4ZWMuCj4KPiBJIG1lcmVseSBkb24ndCB3YW50IHRvIGR1cGxpY2F0ZSBlZmZv
cnRzIG9yICJzdGVhbCIgc29tZW9uZSBlbHNlJ3MKPiBwcm9qZWN0LiBJcyBSSVNDLVYgc3VwcG9y
dCBpbiBrZXhlYy10b29scyBhbiBvcnBoYW5lZCBwcm9qZWN0IG5vdz8KPgoKSSB0aG91Z2h0IGFi
b3V0IGEgc2ltcGxlIGtleGVjX2ZpbGVfbG9hZCBvbmx5IGFwcHJvYWNoIHByZXZpb3VzbHkgYnV0
CkkgaGF2ZSBubyB0aW1lIHRvIHdvcmsgb24gaXQgYWN0dWFsbHkuICBJbiB0aGVvcnkgSSB0aGlu
ayBhIHNpbXBsZQprZXhlY19maWxlX2xvYWQgaW1wbGVtZW50YXRpb24gc2hvdWxkIG9ubHkgc2hh
cmUgc29tZSBjb21tb24gZnVuY3Rpb25zCmVnLiBhcmd1bWVudHMgcGFyc2luZywgZmlsZSByZWFk
aW5nIGV0Yy4gYW5kIGxvYWQgdGhlIGtlcm5lbCBhbmQKaW5pdHJkIGludG8gbWVtb3J5LCBwYXNz
IHRoZSBmZHMgYW5kIGNtZGxpbmUgYnVmZmVyIGludG8ga2VybmVsLAp0aGF0J3MgYWxsLCAgRXZl
biBubyBuZWVkIHRvIGhhdmUgdGhlIGFyY2ggc3BlY2lmaWMgZmlsZSBmb3JtYXQKY2hlY2tpbmcg
YXMgdGhleSBzaG91bGQgaGF2ZSBiZWVuIGRvbmUgaW4gdGhlIHJlbGF0ZWQga2VybmVsIGNvZGUu
CkJ1dCBsb29raW5nIGF0IHRoZSBjb2RlIGl0IGlzIG5vdCBlYXN5LiAgQ3VycmVudGx5IHRoZSBr
ZXhlY19sb2FkIGFuZAprZXhlY19maWxlX2xvYWQgaW1wbGVtZW50YXRpb25zIGFyZSBub3QgbG9n
aWNhbGx5IHNlcGFyYXRlIGluIHRoZSBjb2RlCmFuZCB0aGUgY2xlYW51cCBpcyBoYXJkLgoKVGhh
bmtzCkRhdmUKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
