Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E36C001DE
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 09:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ufy2ehcB3D+EISQltH447uyVZVls13j1hjzwwiGP5qU=; b=AfuImdsmSaMnMf
	jmZWurLyRAnRv3/LbWu0r1xAACsJcZCQiJRuLJxaFQ6rre0D8E9UwW9YFxyqZlh1Iro1XkkoOD+wX
	N1G2KWnlfos5zuUQlCEN9Ri6iRba1t6CxZlBKIJ9coVXQhKKCntzpeBtXSe/gzbzlgXpEAArPLr9Y
	dmNQBl2cf7UTYxe1eVRybAc8d6z9Fz+//YhSCMxB7k+5Kog7tsGsqk6KW4xt5rbtbLlVMs/0xs6aZ
	ja4jHHjCmiue9p7qOYsStfgdvK20lp14SXd0BLGADOPeF34KcvUAwTBAYTInRsb+ZXxGlJXSWequZ
	hJLnjYHOs/LagC89L66w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qR8Yb-004XIR-2z;
	Wed, 02 Aug 2023 09:54:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qR8YY-004XHo-1r
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 09:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690970052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGAkBV+zxWpYO5VE8HRlKmcYiDBzHga2UFMcXCYQuLs=;
	b=CMn7HCM61LTzSkUHLJ14PMv/3we84Uw9N4syBiB595h3pqBXLGJwh10h7APxZtZUTPNpzH
	XRgsMxSbTRzPgxI4mBGvFKojosw5Iy8A/q4xPSsZFs1iyQFusY+ldlk5yjmPLuLFVs7+so
	qKB1BV6bS+LWvYdpalm7JstP5tZ1fRk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-h_x4EL74Nfm_9VsQnRqpUQ-1; Wed, 02 Aug 2023 05:54:10 -0400
X-MC-Unique: h_x4EL74Nfm_9VsQnRqpUQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63d245b67abso80417436d6.3
        for <kexec@lists.infradead.org>; Wed, 02 Aug 2023 02:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690970050; x=1691574850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGAkBV+zxWpYO5VE8HRlKmcYiDBzHga2UFMcXCYQuLs=;
        b=RXFYDOI0+0DxRFfxkydG/L1HkmSKtVIW3cKcZZfrPxITz+EABpd4cIeEud8MtUSp7E
         6YYmKbNTlgSURSiKux4rumrKkTc6xSBUNP1WRilhE1pXyBKznHWpQ7peIZXJ2mNVJkXC
         b7wUzRPR6gdwE83TUUL3PD/R8UQx2ydvpol50VJkAoscFA+3CdOZX57EUm7m/uW16TU3
         xv09I5H1N6GBx1Fxd0XvQOSaT35zlJba+a+OTSHhVz9DhS2FlhPvxr9OpXepHoYenQ2r
         3Guh1V7uN+rkPgtAXWzvzZ5EDoIcawVPwONvFVoor3XA9GQ88z+qXuGLjnu0E/1SPe5h
         JW1Q==
X-Gm-Message-State: ABy/qLbHiQ5Pv3hF/OgZ7/o3uifddhxX2VVLznq8/A37auDdIWKH/Kek
	NNIm1tHs5SQ0UpmJRnppz89F90LHNQ6v1avHkU1vOIyA0wvZgPkXaBHn4g+lR+whKGeOYdHqwiI
	yy/5Y48QL0X3xf+UhnjvOyMOOzNdrq7iLlhIZ
X-Received: by 2002:a0c:f14a:0:b0:63d:e49:e693 with SMTP id y10-20020a0cf14a000000b0063d0e49e693mr15402962qvl.59.1690970050368;
        Wed, 02 Aug 2023 02:54:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGjS7YwQw5R9tAxNWxNgwYlxFjPln7a7OmqG7nAphE7xUCRZWhCQhl3XJ31/WUCTtqP2exXVtMUdwdp8FlCwkE=
X-Received: by 2002:a0c:f14a:0:b0:63d:e49:e693 with SMTP id
 y10-20020a0cf14a000000b0063d0e49e693mr15402949qvl.59.1690970050123; Wed, 02
 Aug 2023 02:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230724022142.6425-1-piliu@redhat.com> <20230724022142.6425-4-piliu@redhat.com>
 <ZMitmSZPqnH+/70s@kernel.org>
In-Reply-To: <ZMitmSZPqnH+/70s@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 2 Aug 2023 17:53:59 +0800
Message-ID: <CAF+s44QBMgsT7Q2ro9obVvHYCrKYTQoeCnOVOMzhfexQS+_6Sw@mail.gmail.com>
Subject: Re: [PATCHv6 3/5] kexec/zboot: Add arch independent zboot support
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>, horms@verge.net.au, 
	ardb@kernel.org
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_025414_708892_A0B6A8E1 
X-CRM114-Status: GOOD (  20.87  )
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

SGkgU2ltb24sCgpUaGFua3MgZm9yIHRoZSB0cnkuIFBsZWFzZSBzZWUgdGhlIGNvbW1lbnQgYmVs
b3cuCgpPbiBUdWUsIEF1ZyAxLCAyMDIzIGF0IDM6MDDigK9QTSBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMTA6MjE6NDBB
TSArMDgwMCwgUGluZ2ZhbiBMaXUgd3JvdGU6Cj4gPiBGcm9tOiBKZXJlbXkgTGludG9uIDxqZXJl
bXkubGludG9uQGFybS5jb20+Cj4gPgo+ID4gVGhlIGxpbnV4IGtlcm5lbCBDT05GSUdfWkJPT1Qg
b3B0aW9uIGNyZWF0ZXMKPiA+IHNlbGYgZGVjb21wcmVzc2luZyBQRSBrZXJuZWwgaW1hZ2VzLiBT
byB0aGlzIG1lYW5zCj4gPiB0aGF0IGtleGVjIHNob3VsZCBoYXZlIGEgZ2VuZXJpYyB1bmRlcnN0
YW5kaW5nIG9mCj4gPiB0aGUgZm9ybWF0IHdoaWNoIG1heSBiZSB1c2VkIGJ5IG11bHRpcGxlIGFy
Y2hlcy4KPiA+Cj4gPiBTbyBsZXRzIGFkZCBhbiBhcmNoIGluZGVwZW5kZW50IHZhbGlkYXRpb24K
PiA+IGFuZCBkZWNvbXByZXNzaW9uIHJvdXRpbmUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmVy
ZW15IExpbnRvbiA8amVyZW15LmxpbnRvbkBhcm0uY29tPgo+ID4gW01vZGlmaWVkIGJ5IFBpbmdm
YW4gdG8gZXhwb3J0IGtlcm5lbCBmZF0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmdmYW4gTGl1IDxw
aWxpdUByZWRoYXQuY29tPgo+Cj4gSGkgUGluZ2ZhbiwKPgo+IHVuZm9ydHVuYXRlbHkgdGhpcyBj
YXVzZXMgYSBidWlsZCBmYWlsdXJlIG9uIGhwcGEuCj4KPiAuLi8uLi9rZXhlYy9rZXhlYy1wZS16
Ym9vdC5jOjMxOjEwOiBmYXRhbCBlcnJvcjoga2V4ZWMtcGUtemJvb3QuaDogTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeQo+ICAgIDMxIHwgI2luY2x1ZGUgPGtleGVjLXBlLXpib290Lmg+Cj4gICAg
ICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4KPgo+IExpbms6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9ob3Jtcy9rZXhlYy10b29scy9hY3Rpb25zL3J1bnMvNTcyMzU4MDUyMy9qb2IvMTU1MDg0
MjU3OTAKPgoKSXQgaXMgbm90IHJlbGF0ZWQgdG8gY3Jvc3MtY29tcGlsaW5nLiBBY3R1YWxseSwg
SSBoYXZlIHRyaWVkIHRvCnNpbXBsaWZ5IHRoZSB0ZXN0IG1hdHJpeCwgd2hpY2ggbGltaXRzIHRo
ZSBjb21waWxhdGlvbiBvbmx5IG9uIHg4Nl82NC4KQW5kIEkgZ290IHRoZSBzaW1pbGFyIGVycm9y
IFsxXQoKVGhlIHdvcmtmbG93IGNvbnRyb2wgZmlsZSBpcyBbMl0sIHdoaWNoIGNsaXBzIG91dCBh
bGwgYXJjaGVzIGV4Y2VwdAp4ODZfNjQuICBCdXQgSSBjYW4gc3VjY2Vzc2Z1bGx5IGJ1aWxkIGl0
IG9uIHRoZSBGZWRvcmEgc3lzdGVtIHdpdGggdGhlCmZvbGxvd2luZyBiYXNoIHNjcmlwdCwgd2hp
Y2ggaXMgYmFzZWQgb24gdGhlIGdpdGh1YidzIGJ1aWxkIGxvZy4gIFNvCm1heWJlIGl0IGlzIGEg
YnVnIHdpdGggdGhlIGNvbXBpbGluZyB0b29scz8KCmtleGVjX3Rvb2xzX2Rpcj0iLi8iCgpta2Rp
ciAka2V4ZWNfdG9vbHNfZGlyL19idWlsZCBcCiAgICAgICAgICRrZXhlY190b29sc19kaXIvX2J1
aWxkL3N1YiBcCiAgICAgICAgICRrZXhlY190b29sc19kaXIvX2luc3QgXAogICAgICAgICAka2V4
ZWNfdG9vbHNfZGlyL19kZXN0CmNobW9kIGEtdyAka2V4ZWNfdG9vbHNfZGlyCnRlc3QgLWQgJGtl
eGVjX3Rvb2xzX2Rpci9fYnVpbGQKSU5TVEFMTF9CQVNFPSQoY2QgJGtleGVjX3Rvb2xzX2Rpci9f
aW5zdCAmJiBwd2QgfCBzZWQgLWUKJ3MsXlteOlxcL106W1xcL10sLywnKSAmJlwKICAgICAgICBE
RVNURElSPSIka2V4ZWNfdG9vbHNfZGlyL19kZXN0IiAmJiBcCiAgICAgICAgY2QgJGtleGVjX3Rv
b2xzX2Rpci9fYnVpbGQvc3ViICYmIFwKICAgICAgICAgICAgICAgIC4uLy4uL2NvbmZpZ3VyZSBc
CiAgICAgICAgICAgICAgICAgXAogICAgICAgICAgICAgICAgLS1zcmNkaXI9Li4vLi4gLS1wcmVm
aXg9IiRJTlNUQUxMX0JBU0UiICYmIFwKICAgICAgICBtYWtlICAtajgKCgpbMV06IGh0dHBzOi8v
Z2l0aHViLmNvbS9wZmxpdS9rZXhlYy10b29scy9hY3Rpb25zL3J1bnMvNTczNzI1NDEwOS9qb2Iv
MTU1NDg1MjA4NjMKWzJdOiBodHRwczovL2dpdGh1Yi5jb20vcGZsaXUva2V4ZWMtdG9vbHMvYmxv
Yi96Ym9vdFY2Ly5naXRodWIvd29ya2Zsb3dzL21haW4ueW1sCgoKVGhhbmtzLAoKUGluZ2ZhbgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
