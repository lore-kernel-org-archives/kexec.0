Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170ACC001E0
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 08:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dHCwXMEvD8iN++2gHoKkgg5jerw5nZQtpS7wU+0+JoM=; b=GnRSclreB6V655
	Ur+sOW9POSE1UTuKmpWhkkuyEC7mjux+u50zuxYXD6G+9Wr67BETek7fKQwgA+CV0tC8dbVtgWtQd
	lnzDCAl48TA9AT2yb92VcxBALrq5n89aD7muu6MhadPMZswhPs+B9+EVkCm/luYSU5Qpux0z3gQx1
	6a6YJdITOYkvq4YXzTk9RXc+XOxiLgKDD1+8OArpOTEwmiKekDllZ01rBqzlCrCa9JLxzr/CIsr4J
	JgAAwIGuB0/QtMgrwOoTgLFULCiv5BR0KblnGkWJSby5UYgp9RM4QRsvqat1JdbZve2NSNgzoyMHg
	TA4n4qtL9bNppv7amS8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRTKU-006xoU-1h;
	Thu, 03 Aug 2023 08:05:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRTKM-006xjl-2t
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 08:05:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4D0E461C54;
	Thu,  3 Aug 2023 08:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFDBC433C7;
	Thu,  3 Aug 2023 08:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691049897;
	bh=7jMQZDS60l404q8kskZeeBMd4kcNGegff0wGouSbz0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPJvfhww7Lc5bbRNB7pKO858SEW6NzUc+ULKTnSnlfCCCsUlcrO9zEilOWRGZG1a2
	 HNGB+SB+BMpnNEfGYItY/EBY7yzGQOD4Op6x0Q2b3gC2AU2x21zoXpxDmKmcYysKkL
	 zNflf6/gC71L0/xqVla70gB8c/UGhFGdkg8mK5m6y17quIOVlTfnMpRGtWLKSnEivi
	 kC+3dhWPNfmw/DstFwof0hDt4BeHrS4nk2/5Uo2cg0TbsAZ6rKZiseOMKkcEcMhWav
	 0SuVVVE4scB2JkRfgL0XMe8xaTZ4Aw3KsfXVXWFHUdH5QwC+sxgen7JQTgksibf+h1
	 hHYoCsvU3bdYw==
Date: Thu, 3 Aug 2023 10:04:53 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>,
	horms@verge.net.au, ardb@kernel.org
Subject: Re: [PATCHv6 3/5] kexec/zboot: Add arch independent zboot support
Message-ID: <ZMtfpX5EF5TqzODM@kernel.org>
References: <20230724022142.6425-1-piliu@redhat.com>
 <20230724022142.6425-4-piliu@redhat.com>
 <ZMitmSZPqnH+/70s@kernel.org>
 <CAF+s44QBMgsT7Q2ro9obVvHYCrKYTQoeCnOVOMzhfexQS+_6Sw@mail.gmail.com>
 <ZMpJIZ18ynQLln8W@kernel.org>
 <ZMpJcgeGeYhcuGfe@kernel.org>
 <ZMpNLGt6RtxalSBb@kernel.org>
 <CAF+s44QFUonTW1DJjW-gGtN6Yi+tdw=rMSyr+jGgZvuHmGOpZA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44QFUonTW1DJjW-gGtN6Yi+tdw=rMSyr+jGgZvuHmGOpZA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_010459_127161_F4C63305 
X-CRM114-Status: GOOD (  42.02  )
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

T24gVGh1LCBBdWcgMDMsIDIwMjMgYXQgMTA6Mzc6MTBBTSArMDgwMCwgUGluZ2ZhbiBMaXUgd3Jv
dGU6Cj4gT24gV2VkLCBBdWcgMiwgMjAyMyBhdCA4OjMz4oCvUE0gU2ltb24gSG9ybWFuIDxob3Jt
c0BrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBPbiBXZWQsIEF1ZyAwMiwgMjAyMyBhdCAwMjox
Nzo1N1BNICswMjAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6Cj4gPiA+IE9uIFdlZCwgQXVnIDAyLCAy
MDIzIGF0IDAyOjE2OjMzUE0gKzAyMDAsIFNpbW9uIEhvcm1hbiB3cm90ZToKPiA+ID4gPiBPbiBX
ZWQsIEF1ZyAwMiwgMjAyMyBhdCAwNTo1Mzo1OVBNICswODAwLCBQaW5nZmFuIExpdSB3cm90ZToK
PiA+ID4gPiA+IEhpIFNpbW9uLAo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcyBmb3IgdGhlIHRy
eS4gUGxlYXNlIHNlZSB0aGUgY29tbWVudCBiZWxvdy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBU
dWUsIEF1ZyAxLCAyMDIzIGF0IDM6MDDigK9QTSBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5v
cmc+IHdyb3RlOgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBh
dCAxMDoyMTo0MEFNICswODAwLCBQaW5nZmFuIExpdSB3cm90ZToKPiA+ID4gPiA+ID4gPiBGcm9t
OiBKZXJlbXkgTGludG9uIDxqZXJlbXkubGludG9uQGFybS5jb20+Cj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiBUaGUgbGludXgga2VybmVsIENPTkZJR19aQk9PVCBvcHRpb24gY3JlYXRlcwo+
ID4gPiA+ID4gPiA+IHNlbGYgZGVjb21wcmVzc2luZyBQRSBrZXJuZWwgaW1hZ2VzLiBTbyB0aGlz
IG1lYW5zCj4gPiA+ID4gPiA+ID4gdGhhdCBrZXhlYyBzaG91bGQgaGF2ZSBhIGdlbmVyaWMgdW5k
ZXJzdGFuZGluZyBvZgo+ID4gPiA+ID4gPiA+IHRoZSBmb3JtYXQgd2hpY2ggbWF5IGJlIHVzZWQg
YnkgbXVsdGlwbGUgYXJjaGVzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gU28gbGV0cyBh
ZGQgYW4gYXJjaCBpbmRlcGVuZGVudCB2YWxpZGF0aW9uCj4gPiA+ID4gPiA+ID4gYW5kIGRlY29t
cHJlc3Npb24gcm91dGluZS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEplcmVteSBMaW50b24gPGplcmVteS5saW50b25AYXJtLmNvbT4KPiA+ID4gPiA+ID4gPiBb
TW9kaWZpZWQgYnkgUGluZ2ZhbiB0byBleHBvcnQga2VybmVsIGZkXQo+ID4gPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFBpbmdmYW4gTGl1IDxwaWxpdUByZWRoYXQuY29tPgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBIaSBQaW5nZmFuLAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiB1bmZvcnR1bmF0
ZWx5IHRoaXMgY2F1c2VzIGEgYnVpbGQgZmFpbHVyZSBvbiBocHBhLgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiAuLi8uLi9rZXhlYy9rZXhlYy1wZS16Ym9vdC5jOjMxOjEwOiBmYXRhbCBlcnJvcjog
a2V4ZWMtcGUtemJvb3QuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQo+ID4gPiA+ID4gPiAg
ICAzMSB8ICNpbmNsdWRlIDxrZXhlYy1wZS16Ym9vdC5oPgo+ID4gPiA+ID4gPiAgICAgICB8ICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBMaW5rOiBo
dHRwczovL2dpdGh1Yi5jb20vaG9ybXMva2V4ZWMtdG9vbHMvYWN0aW9ucy9ydW5zLzU3MjM1ODA1
MjMvam9iLzE1NTA4NDI1NzkwCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSXQgaXMg
bm90IHJlbGF0ZWQgdG8gY3Jvc3MtY29tcGlsaW5nLiBBY3R1YWxseSwgSSBoYXZlIHRyaWVkIHRv
Cj4gPiA+ID4gPiBzaW1wbGlmeSB0aGUgdGVzdCBtYXRyaXgsIHdoaWNoIGxpbWl0cyB0aGUgY29t
cGlsYXRpb24gb25seSBvbiB4ODZfNjQuCj4gPiA+ID4gPiBBbmQgSSBnb3QgdGhlIHNpbWlsYXIg
ZXJyb3IgWzFdCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhlIHdvcmtmbG93IGNvbnRyb2wgZmlsZSBp
cyBbMl0sIHdoaWNoIGNsaXBzIG91dCBhbGwgYXJjaGVzIGV4Y2VwdAo+ID4gPiA+ID4geDg2XzY0
LiAgQnV0IEkgY2FuIHN1Y2Nlc3NmdWxseSBidWlsZCBpdCBvbiB0aGUgRmVkb3JhIHN5c3RlbSB3
aXRoIHRoZQo+ID4gPiA+ID4gZm9sbG93aW5nIGJhc2ggc2NyaXB0LCB3aGljaCBpcyBiYXNlZCBv
biB0aGUgZ2l0aHViJ3MgYnVpbGQgbG9nLiAgU28KPiA+ID4gPiA+IG1heWJlIGl0IGlzIGEgYnVn
IHdpdGggdGhlIGNvbXBpbGluZyB0b29scz8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBrZXhlY190b29s
c19kaXI9Ii4vIgo+ID4gPiA+ID4KPiA+ID4gPiA+IG1rZGlyICRrZXhlY190b29sc19kaXIvX2J1
aWxkIFwKPiA+ID4gPiA+ICAgICAgICAgICRrZXhlY190b29sc19kaXIvX2J1aWxkL3N1YiBcCj4g
PiA+ID4gPiAgICAgICAgICAka2V4ZWNfdG9vbHNfZGlyL19pbnN0IFwKPiA+ID4gPiA+ICAgICAg
ICAgICRrZXhlY190b29sc19kaXIvX2Rlc3QKPiA+ID4gPiA+IGNobW9kIGEtdyAka2V4ZWNfdG9v
bHNfZGlyCj4gPiA+ID4gPiB0ZXN0IC1kICRrZXhlY190b29sc19kaXIvX2J1aWxkCj4gPiA+ID4g
PiBJTlNUQUxMX0JBU0U9JChjZCAka2V4ZWNfdG9vbHNfZGlyL19pbnN0ICYmIHB3ZCB8IHNlZCAt
ZQo+ID4gPiA+ID4gJ3MsXlteOlxcL106W1xcL10sLywnKSAmJlwKPiA+ID4gPiA+ICAgICAgICAg
REVTVERJUj0iJGtleGVjX3Rvb2xzX2Rpci9fZGVzdCIgJiYgXAo+ID4gPiA+ID4gICAgICAgICBj
ZCAka2V4ZWNfdG9vbHNfZGlyL19idWlsZC9zdWIgJiYgXAo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgIC4uLy4uL2NvbmZpZ3VyZSBcCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIFwKPiA+ID4g
PiA+ICAgICAgICAgICAgICAgICAtLXNyY2Rpcj0uLi8uLiAtLXByZWZpeD0iJElOU1RBTExfQkFT
RSIgJiYgXAo+ID4gPiA+ID4gICAgICAgICBtYWtlICAtajgKPiA+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+ID4gWzFdOiBodHRwczovL2dpdGh1Yi5jb20vcGZsaXUva2V4ZWMtdG9vbHMvYWN0aW9u
cy9ydW5zLzU3MzcyNTQxMDkvam9iLzE1NTQ4NTIwODYzCj4gPiA+ID4gPiBbMl06IGh0dHBzOi8v
Z2l0aHViLmNvbS9wZmxpdS9rZXhlYy10b29scy9ibG9iL3pib290VjYvLmdpdGh1Yi93b3JrZmxv
d3MvbWFpbi55bWwKPiA+ID4gPgo+ID4gPiA+IFRoYW5rcywKPiA+ID4gPgo+ID4gPiA+IEkgZ3Vl
c3MgdGhhdCBrZXhlYy1wZS16Ym9vdC5oIGlzIG1pc3NpbmcgaW4gdGhlIGJ1aWxkIGVudmlyb25t
ZW50IGZvciB0aGUKPiA+ID4gPiBHaXRIdWIgYWN0aW9ucywgYnV0IHByZXNlbnQgaW4geW91ciBG
ZWRvcmEgZW52aXJvbm1lbnQuCj4gPiA+ID4KPiA+ID4gPiBDb3VsZCB5b3UgdGFrZSBhIGxvb2sg
YW5kIHNlZSB3aGVyZSB5b3VyIGNvcHkgb2Yga2V4ZWMtcGUtemJvb3QuaAo+ID4gPiA+IGNhbWUg
ZnJvbT8KPiA+ID4KPiA+ID4gQWN0dWFsbHkgaXQgc2VlbXMgdG8gYmUgYWRkZWQgYnkgdGhpcyBw
YXRjaCAoc29ycnkgZm9yIG5vdCBub3RpY2luZykhCj4gPiA+IFNvIEkgZ3Vlc3MgaXQgaXMgYW4g
aW5jbHVkZSBwYXRoIHByb2JsZW0uCj4gPgo+ID4gSSB0aGluayBJIGhhdmUgZm91bmQgdGhlIHBy
b2JsZW0uCj4gPiBUaGUga2V4ZWMtdG9vbHMgYnVpbGQgc3lzdGVtIGlzIGEgYml0IHVudXN1YWws
Cj4gPiBhbmQgdGhlIG5ldyBmaWxlLCBrZXhlYy1wZS16Ym9vdC5oLCB3YXMgbm90IGluY2x1ZGVk
IGluIGRpc3RyaWJ1dGlvbgo+ID4gdGFyYmFsbHMuIFRodXMgdGhlIGJ1aWxkIGZhaWx1cmVzLgo+
ID4KPiAKPiBVbmV4cGVjdGVkbHksIGFuZCB0aGFuayBmb3IgeW91ciBpbnNpZ2h0Lgo+IAo+ID4g
SSB0aGluayB5b3UgY2FuIHJlc29sdmUgdGhhdCBieSBzcXVhc2hpbmcgdGhlIGZvbGxvd2luZyBp
bnRvIHRoaXMgcGF0Y2guCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvTWFrZWZpbGUgYi9p
bmNsdWRlL01ha2VmaWxlCj4gPiAtLS0gYS9pbmNsdWRlL01ha2VmaWxlCj4gPiArKysgYi9pbmNs
dWRlL01ha2VmaWxlCj4gPiBAQCAtMSw2ICsxLDcgQEAKPiA+ICBkaXN0ICs9IGluY2x1ZGUvTWFr
ZWZpbGUgICAgICAgICAgICAgICBcCj4gPiAgICAgICAgIGluY2x1ZGUvY29uZmlnLmggICAgICAg
ICAgICAgICAgXAo+ID4gICAgICAgICBpbmNsdWRlL2NvbmZpZy5oLmluICAgICAgICAgICAgIFwK
PiA+ICsgICAgICAgaW5jbHVkZS9rZXhlYy1wZS16Ym9vdC5oICAgICAgICBcCj4gPiAgICAgICAg
IGluY2x1ZGUva2V4ZWMtdUltYWdlLmggICAgICAgICAgXAo+ID4gICAgICAgICBpbmNsdWRlL3g4
Ni94ODYtbGludXguaCAgICAgICAgIFwKPiA+ICAgICAgICAgaW5jbHVkZS94ODYvbWJfaW5mby5o
ICAgICAgICAgICBcCj4gPgo+IAo+IEFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2gsIHRoZSBnaXRo
dWIgd29ya2Zsb3cgc3VjY2Vzc2Z1bGx5IGZpbmlzaGVkLgo+IEkgd2lsbCBzZW5kIG91dCBWNyBp
bW1lZGlhdGVseS4KPiAKPiBBcHByZWNpYXRlIGZvciB5b3VyIGtpbmQgaGVscCBhZ2Fpbi4KClRo
YW5rcywgSSBzZWUgdjcgbm93LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
