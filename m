Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EA9C00528
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nHQWVY1gun4gGOOsq90cbzcN39Ar6ar9LBxkVWb3inI=; b=GRem+PikaSacSw
	S7xOv/Wm2K/GPVcLoGzQ8ZlSrUw1DkuO+F7W3LdqpjJjgr8i3Qp6rn6I4H33hyvQIOnq+RMBV+Ndd
	SlhkrC7pbpV1GVbW+rxs9tZEhM1bajar8fERaIUEM+ZtfmLsNEeSwgj2CjqUmgtBorgRpMv3H2PhS
	O9MW+T1Gsnbe0c5XeoYcTAdecbtco94XGPbvhwRhCFtqr+IzRh0Go0GYrsegyB21TyWX6L4Ey6k8Y
	LYy/hqngS8a2pO7sjoRkvf9QXcQkenVxjNo6BjRfuGC1D99KOQKUJ+nt10OaxdwKKf/i499KsuvxB
	rUGQNPlaYeFTJdP0eR5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRB36-004u7C-2U;
	Wed, 02 Aug 2023 12:33:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRB33-004u6c-0z
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 12:33:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B856E61947;
	Wed,  2 Aug 2023 12:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B8CC433C8;
	Wed,  2 Aug 2023 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690979632;
	bh=VlB4olWLaKGV0i+8jFJ5pD+l7s7pCkczXm0Hmk6tpVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqvjcH4ZEPbCcsMnNGh68KU6TjmBbILZrrGZoTgyCk6S4OJO2botCq9UoleOIBO2H
	 ZipvmRglIuJKENt7cBpqjZ+ukDNyEJCvZ4luXhFERtRHqSw0QL3fiaQCaNa0rdNBB3
	 S4eHNvedI/1C6pnRvX5HfLPk3bc4Uyv+fVglCLuTB4r1p33/SFWHmgrtu2wgFGyVbh
	 A3H/qTPcKKXgpKyr8Tdb1vXVEzFSu5rGp3wohOsfpkWCMS4SYuwpknr8hZeqLuznRe
	 8Qk6ibrFPO8mH+CAq5sWuMqjAEUNMOsT9oFVhopJh8/rg7C4IqQ6XKOUGCg9A7iSFH
	 z1ScOgREZdyAw==
Date: Wed, 2 Aug 2023 14:33:48 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>,
	horms@verge.net.au, ardb@kernel.org
Subject: Re: [PATCHv6 3/5] kexec/zboot: Add arch independent zboot support
Message-ID: <ZMpNLGt6RtxalSBb@kernel.org>
References: <20230724022142.6425-1-piliu@redhat.com>
 <20230724022142.6425-4-piliu@redhat.com>
 <ZMitmSZPqnH+/70s@kernel.org>
 <CAF+s44QBMgsT7Q2ro9obVvHYCrKYTQoeCnOVOMzhfexQS+_6Sw@mail.gmail.com>
 <ZMpJIZ18ynQLln8W@kernel.org>
 <ZMpJcgeGeYhcuGfe@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZMpJcgeGeYhcuGfe@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_053353_425859_1850B0FF 
X-CRM114-Status: GOOD (  37.57  )
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

T24gV2VkLCBBdWcgMDIsIDIwMjMgYXQgMDI6MTc6NTdQTSArMDIwMCwgU2ltb24gSG9ybWFuIHdy
b3RlOgo+IE9uIFdlZCwgQXVnIDAyLCAyMDIzIGF0IDAyOjE2OjMzUE0gKzAyMDAsIFNpbW9uIEhv
cm1hbiB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDAyLCAyMDIzIGF0IDA1OjUzOjU5UE0gKzA4MDAs
IFBpbmdmYW4gTGl1IHdyb3RlOgo+ID4gPiBIaSBTaW1vbiwKPiA+ID4gCj4gPiA+IFRoYW5rcyBm
b3IgdGhlIHRyeS4gUGxlYXNlIHNlZSB0aGUgY29tbWVudCBiZWxvdy4KPiA+ID4gCj4gPiA+IE9u
IFR1ZSwgQXVnIDEsIDIwMjMgYXQgMzowMOKAr1BNIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVs
Lm9yZz4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAxMDoy
MTo0MEFNICswODAwLCBQaW5nZmFuIExpdSB3cm90ZToKPiA+ID4gPiA+IEZyb206IEplcmVteSBM
aW50b24gPGplcmVteS5saW50b25AYXJtLmNvbT4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGUgbGlu
dXgga2VybmVsIENPTkZJR19aQk9PVCBvcHRpb24gY3JlYXRlcwo+ID4gPiA+ID4gc2VsZiBkZWNv
bXByZXNzaW5nIFBFIGtlcm5lbCBpbWFnZXMuIFNvIHRoaXMgbWVhbnMKPiA+ID4gPiA+IHRoYXQg
a2V4ZWMgc2hvdWxkIGhhdmUgYSBnZW5lcmljIHVuZGVyc3RhbmRpbmcgb2YKPiA+ID4gPiA+IHRo
ZSBmb3JtYXQgd2hpY2ggbWF5IGJlIHVzZWQgYnkgbXVsdGlwbGUgYXJjaGVzLgo+ID4gPiA+ID4K
PiA+ID4gPiA+IFNvIGxldHMgYWRkIGFuIGFyY2ggaW5kZXBlbmRlbnQgdmFsaWRhdGlvbgo+ID4g
PiA+ID4gYW5kIGRlY29tcHJlc3Npb24gcm91dGluZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKZXJlbXkgTGludG9uIDxqZXJlbXkubGludG9uQGFybS5jb20+Cj4gPiA+ID4g
PiBbTW9kaWZpZWQgYnkgUGluZ2ZhbiB0byBleHBvcnQga2VybmVsIGZkXQo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogUGluZ2ZhbiBMaXUgPHBpbGl1QHJlZGhhdC5jb20+Cj4gPiA+ID4KPiA+ID4g
PiBIaSBQaW5nZmFuLAo+ID4gPiA+Cj4gPiA+ID4gdW5mb3J0dW5hdGVseSB0aGlzIGNhdXNlcyBh
IGJ1aWxkIGZhaWx1cmUgb24gaHBwYS4KPiA+ID4gPgo+ID4gPiA+IC4uLy4uL2tleGVjL2tleGVj
LXBlLXpib290LmM6MzE6MTA6IGZhdGFsIGVycm9yOiBrZXhlYy1wZS16Ym9vdC5oOiBObyBzdWNo
IGZpbGUgb3IgZGlyZWN0b3J5Cj4gPiA+ID4gICAgMzEgfCAjaW5jbHVkZSA8a2V4ZWMtcGUtemJv
b3QuaD4KPiA+ID4gPiAgICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fgo+ID4gPiA+
Cj4gPiA+ID4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL2hvcm1zL2tleGVjLXRvb2xzL2FjdGlv
bnMvcnVucy81NzIzNTgwNTIzL2pvYi8xNTUwODQyNTc5MAo+ID4gPiA+Cj4gPiA+IAo+ID4gPiBJ
dCBpcyBub3QgcmVsYXRlZCB0byBjcm9zcy1jb21waWxpbmcuIEFjdHVhbGx5LCBJIGhhdmUgdHJp
ZWQgdG8KPiA+ID4gc2ltcGxpZnkgdGhlIHRlc3QgbWF0cml4LCB3aGljaCBsaW1pdHMgdGhlIGNv
bXBpbGF0aW9uIG9ubHkgb24geDg2XzY0Lgo+ID4gPiBBbmQgSSBnb3QgdGhlIHNpbWlsYXIgZXJy
b3IgWzFdCj4gPiA+IAo+ID4gPiBUaGUgd29ya2Zsb3cgY29udHJvbCBmaWxlIGlzIFsyXSwgd2hp
Y2ggY2xpcHMgb3V0IGFsbCBhcmNoZXMgZXhjZXB0Cj4gPiA+IHg4Nl82NC4gIEJ1dCBJIGNhbiBz
dWNjZXNzZnVsbHkgYnVpbGQgaXQgb24gdGhlIEZlZG9yYSBzeXN0ZW0gd2l0aCB0aGUKPiA+ID4g
Zm9sbG93aW5nIGJhc2ggc2NyaXB0LCB3aGljaCBpcyBiYXNlZCBvbiB0aGUgZ2l0aHViJ3MgYnVp
bGQgbG9nLiAgU28KPiA+ID4gbWF5YmUgaXQgaXMgYSBidWcgd2l0aCB0aGUgY29tcGlsaW5nIHRv
b2xzPwo+ID4gPiAKPiA+ID4ga2V4ZWNfdG9vbHNfZGlyPSIuLyIKPiA+ID4gCj4gPiA+IG1rZGly
ICRrZXhlY190b29sc19kaXIvX2J1aWxkIFwKPiA+ID4gICAgICAgICAgJGtleGVjX3Rvb2xzX2Rp
ci9fYnVpbGQvc3ViIFwKPiA+ID4gICAgICAgICAgJGtleGVjX3Rvb2xzX2Rpci9faW5zdCBcCj4g
PiA+ICAgICAgICAgICRrZXhlY190b29sc19kaXIvX2Rlc3QKPiA+ID4gY2htb2QgYS13ICRrZXhl
Y190b29sc19kaXIKPiA+ID4gdGVzdCAtZCAka2V4ZWNfdG9vbHNfZGlyL19idWlsZAo+ID4gPiBJ
TlNUQUxMX0JBU0U9JChjZCAka2V4ZWNfdG9vbHNfZGlyL19pbnN0ICYmIHB3ZCB8IHNlZCAtZQo+
ID4gPiAncyxeW146XFwvXTpbXFwvXSwvLCcpICYmXAo+ID4gPiAgICAgICAgIERFU1RESVI9IiRr
ZXhlY190b29sc19kaXIvX2Rlc3QiICYmIFwKPiA+ID4gICAgICAgICBjZCAka2V4ZWNfdG9vbHNf
ZGlyL19idWlsZC9zdWIgJiYgXAo+ID4gPiAgICAgICAgICAgICAgICAgLi4vLi4vY29uZmlndXJl
IFwKPiA+ID4gICAgICAgICAgICAgICAgICBcCj4gPiA+ICAgICAgICAgICAgICAgICAtLXNyY2Rp
cj0uLi8uLiAtLXByZWZpeD0iJElOU1RBTExfQkFTRSIgJiYgXAo+ID4gPiAgICAgICAgIG1ha2Ug
IC1qOAo+ID4gPiAKPiA+ID4gCj4gPiA+IFsxXTogaHR0cHM6Ly9naXRodWIuY29tL3BmbGl1L2tl
eGVjLXRvb2xzL2FjdGlvbnMvcnVucy81NzM3MjU0MTA5L2pvYi8xNTU0ODUyMDg2Mwo+ID4gPiBb
Ml06IGh0dHBzOi8vZ2l0aHViLmNvbS9wZmxpdS9rZXhlYy10b29scy9ibG9iL3pib290VjYvLmdp
dGh1Yi93b3JrZmxvd3MvbWFpbi55bWwKPiA+IAo+ID4gVGhhbmtzLAo+ID4gCj4gPiBJIGd1ZXNz
IHRoYXQga2V4ZWMtcGUtemJvb3QuaCBpcyBtaXNzaW5nIGluIHRoZSBidWlsZCBlbnZpcm9ubWVu
dCBmb3IgdGhlCj4gPiBHaXRIdWIgYWN0aW9ucywgYnV0IHByZXNlbnQgaW4geW91ciBGZWRvcmEg
ZW52aXJvbm1lbnQuCj4gPiAKPiA+IENvdWxkIHlvdSB0YWtlIGEgbG9vayBhbmQgc2VlIHdoZXJl
IHlvdXIgY29weSBvZiBrZXhlYy1wZS16Ym9vdC5oCj4gPiBjYW1lIGZyb20/Cj4gCj4gQWN0dWFs
bHkgaXQgc2VlbXMgdG8gYmUgYWRkZWQgYnkgdGhpcyBwYXRjaCAoc29ycnkgZm9yIG5vdCBub3Rp
Y2luZykhCj4gU28gSSBndWVzcyBpdCBpcyBhbiBpbmNsdWRlIHBhdGggcHJvYmxlbS4KCkkgdGhp
bmsgSSBoYXZlIGZvdW5kIHRoZSBwcm9ibGVtLgpUaGUga2V4ZWMtdG9vbHMgYnVpbGQgc3lzdGVt
IGlzIGEgYml0IHVudXN1YWwsCmFuZCB0aGUgbmV3IGZpbGUsIGtleGVjLXBlLXpib290LmgsIHdh
cyBub3QgaW5jbHVkZWQgaW4gZGlzdHJpYnV0aW9uCnRhcmJhbGxzLiBUaHVzIHRoZSBidWlsZCBm
YWlsdXJlcy4KCkkgdGhpbmsgeW91IGNhbiByZXNvbHZlIHRoYXQgYnkgc3F1YXNoaW5nIHRoZSBm
b2xsb3dpbmcgaW50byB0aGlzIHBhdGNoLgoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvTWFrZWZpbGUg
Yi9pbmNsdWRlL01ha2VmaWxlCi0tLSBhL2luY2x1ZGUvTWFrZWZpbGUKKysrIGIvaW5jbHVkZS9N
YWtlZmlsZQpAQCAtMSw2ICsxLDcgQEAKIGRpc3QgKz0gaW5jbHVkZS9NYWtlZmlsZQkJXAogCWlu
Y2x1ZGUvY29uZmlnLmgJCVwKIAlpbmNsdWRlL2NvbmZpZy5oLmluCQlcCisJaW5jbHVkZS9rZXhl
Yy1wZS16Ym9vdC5oCVwKIAlpbmNsdWRlL2tleGVjLXVJbWFnZS5oCQlcCiAJaW5jbHVkZS94ODYv
eDg2LWxpbnV4LmgJCVwKIAlpbmNsdWRlL3g4Ni9tYl9pbmZvLmgJCVwKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
