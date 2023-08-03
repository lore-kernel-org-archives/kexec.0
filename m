Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AC2C001DE
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 02:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PVgQQIlIqh3xxxpjeVPGRz5VGN5eN5zjjdpOa6NpJU0=; b=qLlGNKdvj/u8LN
	kckFqazHKhVcDVUfg3POvIehwjd9udHTKGTv1wAF/1n4lXIL5zVI5SPl5xPqOv1pazXU+cQveRbHS
	tVXJCmzMw6J+pKYkn5ofNUbD13FSGs5yMIfHz1q0BHwCZXSuteX+cwi48ECelD8vvCuQlaZGIzHMT
	hChNEmjhqALDCjpnw4WopVSpZCwz0+AELxD4nfO8NGpZ0IH4r25DzpdSMS7XhH8GL89GQkCQaU9bT
	igpBc9iuGSu8xrcNXePQhjCLDvATkQKMGoCR5Jg7ByiArWRmu12hBVpV20C6upT7SZaWEDUHz3ldE
	/2wjQ0RSQXGQH7fYkOyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRODT-006TAq-2O;
	Thu, 03 Aug 2023 02:37:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRODN-006T9o-2z
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 02:37:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691030244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtSGJEVGSLpq5D/pQpoUYSAv16XcU2R+8yDAwhXnXeU=;
	b=CwxPgh962m5Otos/Jksal1XcwaVd3ZYaW/WpaQIG7l5IAGXHqTV2IaPVVyPQLT+1EyLa88
	uGmRCUTcPO/EmsqifeswXI0D7hwEJiukoXbNOm0WBDZ6ezTl+0txI3XEkX7qs3QxIr1Aew
	/cIpDK209avnscihCTn9fljIh98aq2I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-4L-vUjKYPgGAGWANLqBicQ-1; Wed, 02 Aug 2023 22:37:22 -0400
X-MC-Unique: 4L-vUjKYPgGAGWANLqBicQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63d062fc6f8so5394986d6.3
        for <kexec@lists.infradead.org>; Wed, 02 Aug 2023 19:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691030242; x=1691635042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtSGJEVGSLpq5D/pQpoUYSAv16XcU2R+8yDAwhXnXeU=;
        b=HVKE8Au5QQZ5ZXiyLDl4o+aX/TUN0R7T7z1gR47JyJ50LHrkl/sB6NUINGS88Qpicv
         MdupQw6p5PKR7POKiJxPhoXbyFDo8R1a8tOJQorIp+eeutx+dmcm8MS9sAEJ1s/9SPv4
         YT54W0jIDR1+/OLtrt5/gF3rXxD9D8NLEloKaRVWRSadlNU+Uj0nYtCe5Dr1GlnVCRmq
         KIDprdpe7BXyPONw5UHMdy/ddYNE8wXAN4b17Rsdfoiux8qIujSmgdX2aS7U/YjxAtYU
         u4AqW7rHw24PcpVpwlGiyTGOOaEOIAqn2vYThNynFs3N83EEHTmWa58MtqMKT1ziV2Uq
         h1TA==
X-Gm-Message-State: ABy/qLba8ZYw6hnzL+n2L4BgzVNYlfM/ZL77r3/hpzrVd/tsuUen9jS4
	FvqcUX4Tjk7GLsqdGEDf6EXRo09A8ei6e2VbNwTJLIGcjN8MbOFuHnkwTrViczxlukyyMxT6p6B
	N793Kv8t2uDlIEtlgZdmaIUFF02sA8KAL+Hwa1cM+oMAt5Jhjdw==
X-Received: by 2002:a0c:dd0b:0:b0:63d:212e:8ae7 with SMTP id u11-20020a0cdd0b000000b0063d212e8ae7mr16562520qvk.14.1691030241940;
        Wed, 02 Aug 2023 19:37:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHs5c74gJsJjoxne/Z87oSidCV08ZLW8vVDxlYo4E+RJ3CpbR9PCw0OL4cC3qrGw9yIXeUjrPSkXM4nKavaz3A=
X-Received: by 2002:a0c:dd0b:0:b0:63d:212e:8ae7 with SMTP id
 u11-20020a0cdd0b000000b0063d212e8ae7mr16562507qvk.14.1691030241695; Wed, 02
 Aug 2023 19:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230724022142.6425-1-piliu@redhat.com> <20230724022142.6425-4-piliu@redhat.com>
 <ZMitmSZPqnH+/70s@kernel.org> <CAF+s44QBMgsT7Q2ro9obVvHYCrKYTQoeCnOVOMzhfexQS+_6Sw@mail.gmail.com>
 <ZMpJIZ18ynQLln8W@kernel.org> <ZMpJcgeGeYhcuGfe@kernel.org> <ZMpNLGt6RtxalSBb@kernel.org>
In-Reply-To: <ZMpNLGt6RtxalSBb@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 3 Aug 2023 10:37:10 +0800
Message-ID: <CAF+s44QFUonTW1DJjW-gGtN6Yi+tdw=rMSyr+jGgZvuHmGOpZA@mail.gmail.com>
Subject: Re: [PATCHv6 3/5] kexec/zboot: Add arch independent zboot support
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>, horms@verge.net.au, 
	ardb@kernel.org
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_193726_058128_AF77E79E 
X-CRM114-Status: GOOD (  39.77  )
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

T24gV2VkLCBBdWcgMiwgMjAyMyBhdCA4OjMz4oCvUE0gU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJu
ZWwub3JnPiB3cm90ZToKPgo+IE9uIFdlZCwgQXVnIDAyLCAyMDIzIGF0IDAyOjE3OjU3UE0gKzAy
MDAsIFNpbW9uIEhvcm1hbiB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDAyLCAyMDIzIGF0IDAyOjE2
OjMzUE0gKzAyMDAsIFNpbW9uIEhvcm1hbiB3cm90ZToKPiA+ID4gT24gV2VkLCBBdWcgMDIsIDIw
MjMgYXQgMDU6NTM6NTlQTSArMDgwMCwgUGluZ2ZhbiBMaXUgd3JvdGU6Cj4gPiA+ID4gSGkgU2lt
b24sCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MgZm9yIHRoZSB0cnkuIFBsZWFzZSBzZWUgdGhlIGNv
bW1lbnQgYmVsb3cuCj4gPiA+ID4KPiA+ID4gPiBPbiBUdWUsIEF1ZyAxLCAyMDIzIGF0IDM6MDDi
gK9QTSBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPiA+ID4KPiA+
ID4gPiA+IE9uIE1vbiwgSnVsIDI0LCAyMDIzIGF0IDEwOjIxOjQwQU0gKzA4MDAsIFBpbmdmYW4g
TGl1IHdyb3RlOgo+ID4gPiA+ID4gPiBGcm9tOiBKZXJlbXkgTGludG9uIDxqZXJlbXkubGludG9u
QGFybS5jb20+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoZSBsaW51eCBrZXJuZWwgQ09ORklH
X1pCT09UIG9wdGlvbiBjcmVhdGVzCj4gPiA+ID4gPiA+IHNlbGYgZGVjb21wcmVzc2luZyBQRSBr
ZXJuZWwgaW1hZ2VzLiBTbyB0aGlzIG1lYW5zCj4gPiA+ID4gPiA+IHRoYXQga2V4ZWMgc2hvdWxk
IGhhdmUgYSBnZW5lcmljIHVuZGVyc3RhbmRpbmcgb2YKPiA+ID4gPiA+ID4gdGhlIGZvcm1hdCB3
aGljaCBtYXkgYmUgdXNlZCBieSBtdWx0aXBsZSBhcmNoZXMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+IFNvIGxldHMgYWRkIGFuIGFyY2ggaW5kZXBlbmRlbnQgdmFsaWRhdGlvbgo+ID4gPiA+ID4g
PiBhbmQgZGVjb21wcmVzc2lvbiByb3V0aW5lLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKZXJlbXkgTGludG9uIDxqZXJlbXkubGludG9uQGFybS5jb20+Cj4gPiA+ID4g
PiA+IFtNb2RpZmllZCBieSBQaW5nZmFuIHRvIGV4cG9ydCBrZXJuZWwgZmRdCj4gPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFBpbmdmYW4gTGl1IDxwaWxpdUByZWRoYXQuY29tPgo+ID4gPiA+ID4K
PiA+ID4gPiA+IEhpIFBpbmdmYW4sCj4gPiA+ID4gPgo+ID4gPiA+ID4gdW5mb3J0dW5hdGVseSB0
aGlzIGNhdXNlcyBhIGJ1aWxkIGZhaWx1cmUgb24gaHBwYS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiAu
Li8uLi9rZXhlYy9rZXhlYy1wZS16Ym9vdC5jOjMxOjEwOiBmYXRhbCBlcnJvcjoga2V4ZWMtcGUt
emJvb3QuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQo+ID4gPiA+ID4gICAgMzEgfCAjaW5j
bHVkZSA8a2V4ZWMtcGUtemJvb3QuaD4KPiA+ID4gPiA+ICAgICAgIHwgICAgICAgICAgXn5+fn5+
fn5+fn5+fn5+fn5+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gTGluazogaHR0cHM6Ly9naXRodWIuY29t
L2hvcm1zL2tleGVjLXRvb2xzL2FjdGlvbnMvcnVucy81NzIzNTgwNTIzL2pvYi8xNTUwODQyNTc5
MAo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEl0IGlzIG5vdCByZWxhdGVkIHRvIGNyb3NzLWNv
bXBpbGluZy4gQWN0dWFsbHksIEkgaGF2ZSB0cmllZCB0bwo+ID4gPiA+IHNpbXBsaWZ5IHRoZSB0
ZXN0IG1hdHJpeCwgd2hpY2ggbGltaXRzIHRoZSBjb21waWxhdGlvbiBvbmx5IG9uIHg4Nl82NC4K
PiA+ID4gPiBBbmQgSSBnb3QgdGhlIHNpbWlsYXIgZXJyb3IgWzFdCj4gPiA+ID4KPiA+ID4gPiBU
aGUgd29ya2Zsb3cgY29udHJvbCBmaWxlIGlzIFsyXSwgd2hpY2ggY2xpcHMgb3V0IGFsbCBhcmNo
ZXMgZXhjZXB0Cj4gPiA+ID4geDg2XzY0LiAgQnV0IEkgY2FuIHN1Y2Nlc3NmdWxseSBidWlsZCBp
dCBvbiB0aGUgRmVkb3JhIHN5c3RlbSB3aXRoIHRoZQo+ID4gPiA+IGZvbGxvd2luZyBiYXNoIHNj
cmlwdCwgd2hpY2ggaXMgYmFzZWQgb24gdGhlIGdpdGh1YidzIGJ1aWxkIGxvZy4gIFNvCj4gPiA+
ID4gbWF5YmUgaXQgaXMgYSBidWcgd2l0aCB0aGUgY29tcGlsaW5nIHRvb2xzPwo+ID4gPiA+Cj4g
PiA+ID4ga2V4ZWNfdG9vbHNfZGlyPSIuLyIKPiA+ID4gPgo+ID4gPiA+IG1rZGlyICRrZXhlY190
b29sc19kaXIvX2J1aWxkIFwKPiA+ID4gPiAgICAgICAgICAka2V4ZWNfdG9vbHNfZGlyL19idWls
ZC9zdWIgXAo+ID4gPiA+ICAgICAgICAgICRrZXhlY190b29sc19kaXIvX2luc3QgXAo+ID4gPiA+
ICAgICAgICAgICRrZXhlY190b29sc19kaXIvX2Rlc3QKPiA+ID4gPiBjaG1vZCBhLXcgJGtleGVj
X3Rvb2xzX2Rpcgo+ID4gPiA+IHRlc3QgLWQgJGtleGVjX3Rvb2xzX2Rpci9fYnVpbGQKPiA+ID4g
PiBJTlNUQUxMX0JBU0U9JChjZCAka2V4ZWNfdG9vbHNfZGlyL19pbnN0ICYmIHB3ZCB8IHNlZCAt
ZQo+ID4gPiA+ICdzLF5bXjpcXC9dOltcXC9dLC8sJykgJiZcCj4gPiA+ID4gICAgICAgICBERVNU
RElSPSIka2V4ZWNfdG9vbHNfZGlyL19kZXN0IiAmJiBcCj4gPiA+ID4gICAgICAgICBjZCAka2V4
ZWNfdG9vbHNfZGlyL19idWlsZC9zdWIgJiYgXAo+ID4gPiA+ICAgICAgICAgICAgICAgICAuLi8u
Li9jb25maWd1cmUgXAo+ID4gPiA+ICAgICAgICAgICAgICAgICAgXAo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAtLXNyY2Rpcj0uLi8uLiAtLXByZWZpeD0iJElOU1RBTExfQkFTRSIgJiYgXAo+ID4g
PiA+ICAgICAgICAgbWFrZSAgLWo4Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFsxXTogaHR0cHM6
Ly9naXRodWIuY29tL3BmbGl1L2tleGVjLXRvb2xzL2FjdGlvbnMvcnVucy81NzM3MjU0MTA5L2pv
Yi8xNTU0ODUyMDg2Mwo+ID4gPiA+IFsyXTogaHR0cHM6Ly9naXRodWIuY29tL3BmbGl1L2tleGVj
LXRvb2xzL2Jsb2IvemJvb3RWNi8uZ2l0aHViL3dvcmtmbG93cy9tYWluLnltbAo+ID4gPgo+ID4g
PiBUaGFua3MsCj4gPiA+Cj4gPiA+IEkgZ3Vlc3MgdGhhdCBrZXhlYy1wZS16Ym9vdC5oIGlzIG1p
c3NpbmcgaW4gdGhlIGJ1aWxkIGVudmlyb25tZW50IGZvciB0aGUKPiA+ID4gR2l0SHViIGFjdGlv
bnMsIGJ1dCBwcmVzZW50IGluIHlvdXIgRmVkb3JhIGVudmlyb25tZW50Lgo+ID4gPgo+ID4gPiBD
b3VsZCB5b3UgdGFrZSBhIGxvb2sgYW5kIHNlZSB3aGVyZSB5b3VyIGNvcHkgb2Yga2V4ZWMtcGUt
emJvb3QuaAo+ID4gPiBjYW1lIGZyb20/Cj4gPgo+ID4gQWN0dWFsbHkgaXQgc2VlbXMgdG8gYmUg
YWRkZWQgYnkgdGhpcyBwYXRjaCAoc29ycnkgZm9yIG5vdCBub3RpY2luZykhCj4gPiBTbyBJIGd1
ZXNzIGl0IGlzIGFuIGluY2x1ZGUgcGF0aCBwcm9ibGVtLgo+Cj4gSSB0aGluayBJIGhhdmUgZm91
bmQgdGhlIHByb2JsZW0uCj4gVGhlIGtleGVjLXRvb2xzIGJ1aWxkIHN5c3RlbSBpcyBhIGJpdCB1
bnVzdWFsLAo+IGFuZCB0aGUgbmV3IGZpbGUsIGtleGVjLXBlLXpib290LmgsIHdhcyBub3QgaW5j
bHVkZWQgaW4gZGlzdHJpYnV0aW9uCj4gdGFyYmFsbHMuIFRodXMgdGhlIGJ1aWxkIGZhaWx1cmVz
Lgo+CgpVbmV4cGVjdGVkbHksIGFuZCB0aGFuayBmb3IgeW91ciBpbnNpZ2h0LgoKPiBJIHRoaW5r
IHlvdSBjYW4gcmVzb2x2ZSB0aGF0IGJ5IHNxdWFzaGluZyB0aGUgZm9sbG93aW5nIGludG8gdGhp
cyBwYXRjaC4KPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL01ha2VmaWxlIGIvaW5jbHVkZS9NYWtl
ZmlsZQo+IC0tLSBhL2luY2x1ZGUvTWFrZWZpbGUKPiArKysgYi9pbmNsdWRlL01ha2VmaWxlCj4g
QEAgLTEsNiArMSw3IEBACj4gIGRpc3QgKz0gaW5jbHVkZS9NYWtlZmlsZSAgICAgICAgICAgICAg
IFwKPiAgICAgICAgIGluY2x1ZGUvY29uZmlnLmggICAgICAgICAgICAgICAgXAo+ICAgICAgICAg
aW5jbHVkZS9jb25maWcuaC5pbiAgICAgICAgICAgICBcCj4gKyAgICAgICBpbmNsdWRlL2tleGVj
LXBlLXpib290LmggICAgICAgIFwKPiAgICAgICAgIGluY2x1ZGUva2V4ZWMtdUltYWdlLmggICAg
ICAgICAgXAo+ICAgICAgICAgaW5jbHVkZS94ODYveDg2LWxpbnV4LmggICAgICAgICBcCj4gICAg
ICAgICBpbmNsdWRlL3g4Ni9tYl9pbmZvLmggICAgICAgICAgIFwKPgoKQWZ0ZXIgYXBwbHlpbmcg
dGhpcyBwYXRjaCwgdGhlIGdpdGh1YiB3b3JrZmxvdyBzdWNjZXNzZnVsbHkgZmluaXNoZWQuCkkg
d2lsbCBzZW5kIG91dCBWNyBpbW1lZGlhdGVseS4KCkFwcHJlY2lhdGUgZm9yIHlvdXIga2luZCBo
ZWxwIGFnYWluLgoKVGhhbmtzLAoKUGluZ2ZhbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
