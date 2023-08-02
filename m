Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96693C001DF
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7TZsT9TsEGUU3JtWGeXzp0ufntGOJZDg2djPNLH7fS0=; b=c7wgx2C98V+kkN
	vi2ZvUhhfVVlwr9/8n4UfbpNG1gHPnx1xBsCaXfi3QaPDMpH7MbiqLh30TExNEjzAoa87gXTKYBXe
	AhjhfQMx8jRNfzUY4DzZiYJDBkwojc4fu3Rdpp4QJU+y6EwiMmHIj7xzO8Vg3Z+FhbBUETOVKJ4ch
	UYUxUIveCYezjOufLzTYVC33U6GXAVndJH/K4kGEYuEBNawQv2jaTyt73SJhb5Oo3U+ATiSbHeEoR
	elsGRGMr7sK59ASW7FIuenW5HJecXlTk1uYZqK06n3IIFMzWiMFS3u+ZjUyi+VJgbzVHXliN6uWNp
	mKfVxM0o+taf5x6tkZug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAni-004se4-1A;
	Wed, 02 Aug 2023 12:18:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAne-004sdd-38
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 12:18:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4A761935;
	Wed,  2 Aug 2023 12:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC95C43391;
	Wed,  2 Aug 2023 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690978677;
	bh=s4GMxk6o+8Eb+wMqbhkQrsY3JLt2aYFYLRORLQAXjAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIiQPzAhrFBQiKLsexNW2WDmVoxqcumkQCiPktVZIYnBIXD5XabOG/zfwmNcixSNd
	 HAmg8TZ6GIyzvSPX1v5/f/Q/iHRrpDg00asCmBetFA3AGV09gxA0kVCu9oYqRF/09Y
	 XKtgEMKIS+05ZUHLLk0tz7A2FDtIZTZL5pp98lZUhz0l232XCs3DzXB/0DHse1Cen5
	 Ss4JA7YJrW9pSTNvKVelVJddm97t3T6M1QHSlcytAW0WHUGEwCsLjyeKs1U8tE7yPM
	 bAR8QziiN/xkMBokJ7AbgkgwPxSPi8doQo39IRPv2DpfE8yYVONXzNb+y2kkqgj353
	 v7OQYm7M/MF7A==
Date: Wed, 2 Aug 2023 14:17:54 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>,
	horms@verge.net.au, ardb@kernel.org
Subject: Re: [PATCHv6 3/5] kexec/zboot: Add arch independent zboot support
Message-ID: <ZMpJcgeGeYhcuGfe@kernel.org>
References: <20230724022142.6425-1-piliu@redhat.com>
 <20230724022142.6425-4-piliu@redhat.com>
 <ZMitmSZPqnH+/70s@kernel.org>
 <CAF+s44QBMgsT7Q2ro9obVvHYCrKYTQoeCnOVOMzhfexQS+_6Sw@mail.gmail.com>
 <ZMpJIZ18ynQLln8W@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZMpJIZ18ynQLln8W@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_051759_097606_45F0B345 
X-CRM114-Status: GOOD (  33.25  )
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

T24gV2VkLCBBdWcgMDIsIDIwMjMgYXQgMDI6MTY6MzNQTSArMDIwMCwgU2ltb24gSG9ybWFuIHdy
b3RlOgo+IE9uIFdlZCwgQXVnIDAyLCAyMDIzIGF0IDA1OjUzOjU5UE0gKzA4MDAsIFBpbmdmYW4g
TGl1IHdyb3RlOgo+ID4gSGkgU2ltb24sCj4gPiAKPiA+IFRoYW5rcyBmb3IgdGhlIHRyeS4gUGxl
YXNlIHNlZSB0aGUgY29tbWVudCBiZWxvdy4KPiA+IAo+ID4gT24gVHVlLCBBdWcgMSwgMjAyMyBh
dCAzOjAw4oCvUE0gU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMTA6MjE6NDBBTSArMDgwMCwgUGluZ2ZhbiBM
aXUgd3JvdGU6Cj4gPiA+ID4gRnJvbTogSmVyZW15IExpbnRvbiA8amVyZW15LmxpbnRvbkBhcm0u
Y29tPgo+ID4gPiA+Cj4gPiA+ID4gVGhlIGxpbnV4IGtlcm5lbCBDT05GSUdfWkJPT1Qgb3B0aW9u
IGNyZWF0ZXMKPiA+ID4gPiBzZWxmIGRlY29tcHJlc3NpbmcgUEUga2VybmVsIGltYWdlcy4gU28g
dGhpcyBtZWFucwo+ID4gPiA+IHRoYXQga2V4ZWMgc2hvdWxkIGhhdmUgYSBnZW5lcmljIHVuZGVy
c3RhbmRpbmcgb2YKPiA+ID4gPiB0aGUgZm9ybWF0IHdoaWNoIG1heSBiZSB1c2VkIGJ5IG11bHRp
cGxlIGFyY2hlcy4KPiA+ID4gPgo+ID4gPiA+IFNvIGxldHMgYWRkIGFuIGFyY2ggaW5kZXBlbmRl
bnQgdmFsaWRhdGlvbgo+ID4gPiA+IGFuZCBkZWNvbXByZXNzaW9uIHJvdXRpbmUuCj4gPiA+ID4K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKZXJlbXkgTGludG9uIDxqZXJlbXkubGludG9uQGFybS5j
b20+Cj4gPiA+ID4gW01vZGlmaWVkIGJ5IFBpbmdmYW4gdG8gZXhwb3J0IGtlcm5lbCBmZF0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nZmFuIExpdSA8cGlsaXVAcmVkaGF0LmNvbT4KPiA+ID4K
PiA+ID4gSGkgUGluZ2ZhbiwKPiA+ID4KPiA+ID4gdW5mb3J0dW5hdGVseSB0aGlzIGNhdXNlcyBh
IGJ1aWxkIGZhaWx1cmUgb24gaHBwYS4KPiA+ID4KPiA+ID4gLi4vLi4va2V4ZWMva2V4ZWMtcGUt
emJvb3QuYzozMToxMDogZmF0YWwgZXJyb3I6IGtleGVjLXBlLXpib290Lmg6IE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkKPiA+ID4gICAgMzEgfCAjaW5jbHVkZSA8a2V4ZWMtcGUtemJvb3QuaD4K
PiA+ID4gICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4KPiA+ID4KPiA+ID4gTGlu
azogaHR0cHM6Ly9naXRodWIuY29tL2hvcm1zL2tleGVjLXRvb2xzL2FjdGlvbnMvcnVucy81NzIz
NTgwNTIzL2pvYi8xNTUwODQyNTc5MAo+ID4gPgo+ID4gCj4gPiBJdCBpcyBub3QgcmVsYXRlZCB0
byBjcm9zcy1jb21waWxpbmcuIEFjdHVhbGx5LCBJIGhhdmUgdHJpZWQgdG8KPiA+IHNpbXBsaWZ5
IHRoZSB0ZXN0IG1hdHJpeCwgd2hpY2ggbGltaXRzIHRoZSBjb21waWxhdGlvbiBvbmx5IG9uIHg4
Nl82NC4KPiA+IEFuZCBJIGdvdCB0aGUgc2ltaWxhciBlcnJvciBbMV0KPiA+IAo+ID4gVGhlIHdv
cmtmbG93IGNvbnRyb2wgZmlsZSBpcyBbMl0sIHdoaWNoIGNsaXBzIG91dCBhbGwgYXJjaGVzIGV4
Y2VwdAo+ID4geDg2XzY0LiAgQnV0IEkgY2FuIHN1Y2Nlc3NmdWxseSBidWlsZCBpdCBvbiB0aGUg
RmVkb3JhIHN5c3RlbSB3aXRoIHRoZQo+ID4gZm9sbG93aW5nIGJhc2ggc2NyaXB0LCB3aGljaCBp
cyBiYXNlZCBvbiB0aGUgZ2l0aHViJ3MgYnVpbGQgbG9nLiAgU28KPiA+IG1heWJlIGl0IGlzIGEg
YnVnIHdpdGggdGhlIGNvbXBpbGluZyB0b29scz8KPiA+IAo+ID4ga2V4ZWNfdG9vbHNfZGlyPSIu
LyIKPiA+IAo+ID4gbWtkaXIgJGtleGVjX3Rvb2xzX2Rpci9fYnVpbGQgXAo+ID4gICAgICAgICAg
JGtleGVjX3Rvb2xzX2Rpci9fYnVpbGQvc3ViIFwKPiA+ICAgICAgICAgICRrZXhlY190b29sc19k
aXIvX2luc3QgXAo+ID4gICAgICAgICAgJGtleGVjX3Rvb2xzX2Rpci9fZGVzdAo+ID4gY2htb2Qg
YS13ICRrZXhlY190b29sc19kaXIKPiA+IHRlc3QgLWQgJGtleGVjX3Rvb2xzX2Rpci9fYnVpbGQK
PiA+IElOU1RBTExfQkFTRT0kKGNkICRrZXhlY190b29sc19kaXIvX2luc3QgJiYgcHdkIHwgc2Vk
IC1lCj4gPiAncyxeW146XFwvXTpbXFwvXSwvLCcpICYmXAo+ID4gICAgICAgICBERVNURElSPSIk
a2V4ZWNfdG9vbHNfZGlyL19kZXN0IiAmJiBcCj4gPiAgICAgICAgIGNkICRrZXhlY190b29sc19k
aXIvX2J1aWxkL3N1YiAmJiBcCj4gPiAgICAgICAgICAgICAgICAgLi4vLi4vY29uZmlndXJlIFwK
PiA+ICAgICAgICAgICAgICAgICAgXAo+ID4gICAgICAgICAgICAgICAgIC0tc3JjZGlyPS4uLy4u
IC0tcHJlZml4PSIkSU5TVEFMTF9CQVNFIiAmJiBcCj4gPiAgICAgICAgIG1ha2UgIC1qOAo+ID4g
Cj4gPiAKPiA+IFsxXTogaHR0cHM6Ly9naXRodWIuY29tL3BmbGl1L2tleGVjLXRvb2xzL2FjdGlv
bnMvcnVucy81NzM3MjU0MTA5L2pvYi8xNTU0ODUyMDg2Mwo+ID4gWzJdOiBodHRwczovL2dpdGh1
Yi5jb20vcGZsaXUva2V4ZWMtdG9vbHMvYmxvYi96Ym9vdFY2Ly5naXRodWIvd29ya2Zsb3dzL21h
aW4ueW1sCj4gCj4gVGhhbmtzLAo+IAo+IEkgZ3Vlc3MgdGhhdCBrZXhlYy1wZS16Ym9vdC5oIGlz
IG1pc3NpbmcgaW4gdGhlIGJ1aWxkIGVudmlyb25tZW50IGZvciB0aGUKPiBHaXRIdWIgYWN0aW9u
cywgYnV0IHByZXNlbnQgaW4geW91ciBGZWRvcmEgZW52aXJvbm1lbnQuCj4gCj4gQ291bGQgeW91
IHRha2UgYSBsb29rIGFuZCBzZWUgd2hlcmUgeW91ciBjb3B5IG9mIGtleGVjLXBlLXpib290LmgK
PiBjYW1lIGZyb20/CgpBY3R1YWxseSBpdCBzZWVtcyB0byBiZSBhZGRlZCBieSB0aGlzIHBhdGNo
IChzb3JyeSBmb3Igbm90IG5vdGljaW5nKSEKU28gSSBndWVzcyBpdCBpcyBhbiBpbmNsdWRlIHBh
dGggcHJvYmxlbS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
