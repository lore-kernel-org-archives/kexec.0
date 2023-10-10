Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13796CD98C0
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 21:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5vvo1p5luD16jtaSodSkJLAT9Zzrd0Uz3PMWMLT8mJk=; b=b04oGWgz9fHkJIbxNd9O9Ugl4d
	I9/RuifaB2ejZ7KwHINPbCJ4R2rrtaLRy/wpEfmlsdFZIcm6Gmo8bzZzMjNcxeVHsPPntbyJa9nPx
	/dwU3skkF/loXmhuUfFfZ7/bUwwWR5bJlfHtmcaNr/59W2tTE2HvbTx29HrLGeM5ZB157T4ch9Nty
	Hk1vzDEZO4hmJBdhh1hfZVWot+mrNZ4xm8N6PoXiUMWfpfJ7LuRf5zHpCOy8n/0PFn+/GJiyy1Znd
	QjAIbLueIKb5cP+aEeNpfUbPYHm06SmAikZvC3XHDz1XxhbgZ8XAxaXSCJtdjNrz514Zqna8vLe7C
	dD1sU1KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqJxt-00EATz-0v;
	Tue, 10 Oct 2023 21:08:29 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqJxq-00EASA-1r
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 21:08:28 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:33772)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qqJxV-008n5l-AY; Tue, 10 Oct 2023 15:08:05 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:58340 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qqJxU-00B8ud-5z; Tue, 10 Oct 2023 15:08:04 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org,  Steven Rostedt <rostedt@goodmis.org>,
  Ricardo Ribalda <ribalda@google.com>,  Ross Zwisler <zwisler@google.com>,
  Rob Clark <robdclark@gmail.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  kexec@lists.infradead.org
References: <20230929021213.2364883-1-joel@joelfernandes.org>
	<87bkdl55qm.fsf@email.froward.int.ebiederm.org>
	<CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
	<CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
	<87il7fzusf.fsf@email.froward.int.ebiederm.org>
	<CAEXW_YRv4Uqfn-9cQvDTRGNbCbC9s3jg+PP1-nqYP-DNO54R-w@mail.gmail.com>
Date: Tue, 10 Oct 2023 16:07:56 -0500
In-Reply-To: <CAEXW_YRv4Uqfn-9cQvDTRGNbCbC9s3jg+PP1-nqYP-DNO54R-w@mail.gmail.com>
	(Joel Fernandes's message of "Tue, 10 Oct 2023 16:37:30 -0400")
Message-ID: <87fs2ii3tf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1qqJxU-00B8ud-5z;;;mid=<87fs2ii3tf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19fQVsZIQFBvLass6Dx9AXn4t9Jez/iWB0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_140826_613350_08C264D3 
X-CRM114-Status: GOOD (  38.95  )
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

Sm9lbCBGZXJuYW5kZXMgPGpvZWxAam9lbGZlcm5hbmRlcy5vcmc+IHdyaXRlczoKCj4gT24gTW9u
LCBPY3QgOSwgMjAyMyBhdCAxMTozMOKAr0FNIEVyaWMgVy4gQmllZGVybWFuIDxlYmllZGVybUB4
bWlzc2lvbi5jb20+IHdyb3RlOgo+Pgo+PiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFu
ZGVzLm9yZz4gd3JpdGVzOgo+Pgo+PiA+IE9uIE1vbiwgT2N0IDIsIDIwMjMgYXQgMjoxOOKAr1BN
IEpvZWwgRmVybmFuZGVzIDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnPiB3cm90ZToKPj4gPiBbLi5d
Cj4+ID4+ID4gPiBTdWNoIGZyZWV6aW5nIGlzIGFscmVhZHkgYmVpbmcgZG9uZSBpZiBrZXJuZWwg
c3VwcG9ydHMgS0VYRUNfSlVNUCBhbmQKPj4gPj4gPiA+IGtleGVjX2ltYWdlLT5wcmVzZXJ2ZV9j
b250ZXh0IGlzIHRydWUuIEhvd2V2ZXIsIGRvaW5nIGl0IGlmIGVpdGhlciBvZiB0aGVzZSBhcmUK
Pj4gPj4gPiA+IG5vdCB0cnVlIHByZXZlbnRzIGNyYXNoZXMvcmFjZXMuCj4+ID4+ID4KPj4gPj4g
PiBUaGUgS0VYRUNfSlVNUCBjYXNlIGlzIHNvbWV0aGluZyBlbHNlIGVudGlyZWx5LiAgSXQgaXMg
c3VwcG9zZWQgdG8gd29yawo+PiA+PiA+IGxpa2Ugc3VzcGVuZCB0byBSQU0uICBNYXliZSByZWJv
b3Qgc2hvdWxkIGFzIHdlbGwsIGJ1dCBJIGFtCj4+ID4+ID4gdW5jb21mb3J0YWJsZSBtYWtpbmcg
YSBnZW5lcmljIGRldmljZSBmaXgga2V4ZWMgc3BlY2lmaWMuCj4+ID4+Cj4+ID4+IEkgc2VlIHlv
dXIgcG9pbnQgb2Ygdmlldy4gSSB0aGluayByZWd1bGFyIHJlYm9vdCBzaG91bGQgYWxzbyBiZSBm
aXhlZAo+PiA+PiB0byBhdm9pZCBzaW1pbGFyIGNyYXNoIHBvc3NpYmlsaXRpZXMuIEkgYW0gaGFw
cHkgdG8gbWFrZSBhIGNoYW5nZSBmb3IKPj4gPj4gdGhhdCBzaW1pbGFyIHRvIHRoaXMgcGF0Y2gg
aWYgd2Ugd2FudCB0byBwcm9jZWVkIHRoYXQgd2F5Lgo+PiA+Pgo+PiA+PiBUaG91Z2h0cz8KPj4g
Pgo+PiA+IEp1c3QgY2hlY2tpbmcgaG93IHdlIHdhbnQgdG8gcHJvY2VlZCwgaXMgdGhlIGNvbnNl
bnN1cyB0aGF0IHdlIHNob3VsZAo+PiA+IHByZXZlbnQga2VybmVsIGNyYXNoZXMgd2l0aG91dCBy
ZWx5aW5nIG9uIHVzZXJzcGFjZSBzdG9wcGluZyBhbGwKPj4gPiBwcm9jZXNzZXM/IFNob3VsZCB3
ZSBmaXggcmVndWxhciByZWJvb3Qgc3lzY2FsbCBhcyB3ZWxsIGFuZCBub3QganVzdAo+PiA+IGtl
eGVjIHJlYm9vdD8KPj4KPj4gSXQganVzdCBvY2N1cnJlZCB0byBtZSB0aGVyZSBpcyBzb21ldGhp
bmcgdmVyeSBmaXNoeSBhYm91dCBhbGwgb2YgdGhpcy4KPj4KPj4gV2hhdCB1c2Vyc3BhY2UgZG8g
eW91IGhhdmUgdXNpbmcga2V4ZWMgKG5vdCBrZXhlYyBvbiBwYW5pYykgdGhhdCBkb2Vzbid0Cj4+
IHByZWZvcm0gdGhlIHNhbWUgdXNlcnNwYWNlIHNodXRkb3duIGFzIGEgbm9ybWFsIHJlYm9vdD8K
Pj4KPj4gUXVpdGUgZnJhbmtseSBzdWNoIGEgdXNlcnNwYWNlIGlzIGJ1Z2d5LCBhbmQgYXJndWFi
bHkgdGhhdCBpcyB3aGVyZSB5b3UKPj4gc2hvdWxkIHN0YXJ0IGZpeGluZyB0aGluZ3MuCj4KPiBJ
dCBpcyBhIHNpbXBsZSB1bml0IHRlc3QgdGhhdCB0ZXN0cyBrZXhlYyBzdXBwb3J0IGJ5IGtleGVj
LXJlYm9vdGluZwo+IHRoZSBrZXJuZWwuIEkgZG9uJ3QgdGhpbmsgU0lHU1RPUC9TSUdLSUxMJ2lu
ZyBkdXJpbmcga2V4ZWMtcmVib290IGlzCj4gaWRlYWwgYmVjYXVzZSBpbiBhIHJlYWwgcGFuaWMt
b24ta2V4ZWMgdHlwZSBjcmFzaCwgdGhhdCBtYXkgbm90IGhhcHBlbgo+IGFuZCBzbyBkb2VzIG5v
dCBlbXVsYXRlIHRoZSByZWFsIHdvcmxkIHRoYXQgd2VsbC4gSSB0aGluayB3ZSB3YW50IHRoZQo+
IGtleGVjLXJlYm9vdCB0byBkbyBhICpyZWJvb3QqIHdpdGhvdXQgY3Jhc2hpbmcgdGhlIGtlcm5l
bCB3aGlsZSBkb2luZwo+IHNvLiBSaWNhcmRvL1N0ZXZlIGNhbiBjaGltZSBvbiB3aGF0IHRoZXkg
ZmVlbCBhcyB3ZWxsLgoKVGhpcyBpcyBjb25mdXNpbmcuICBZb3UgaGF2ZSBhIHVuaXQgdGVzdCB0
aGF0LCB0aGF0IHRlc3RzIGtleGVjIG9uCnBhbmljIHVzaW5nIGEgdGhlIGZ1bGwga2V4ZWMgcmVi
b290LgoKVGhlIHR3byBhcmUgZnVuZGFtZW50YWxseSBzaW1pbGFyIGJ1dCB5b3UgYXJlbid0IGdv
aW5nIHRvIGhhdmUgYSB2YWxpZAp0ZXN0IGNhc2UgaWYgeW91IG1peCB0aGVtLgoKVGhlcmUgaXMg
YSB3aG9sZSBrZXJuZWwgbW9kdWxlIHRoYXQgdGVzdHMgbW9yZSBpbnRlcmVzdGluZyBjYXNlcywK
Zm9yIHRoZSBzaW1wbGUgY2FzZSB5b3UgcHJvYmFibHkganVzdCB3YW50IHRvIGRvOgoKCWVjaG8g
J3AnID4gL3Byb2Mvc3lzcnEtdHJpZ2dlcgoKQXQgbGVhc3QgSSB0aGluayBpdCBpcyBwIHRoYXQg
Y2F1c2VzIGEga2VybmVsLXBhbmljLgoKVGhhdCB3aWxsIGVuc3VyZSB5b3UgYXJlIGV4ZXJjaXNp
bmcgdGhlIGtleGVjIG9uIHBhbmljIGNvZGUgcGF0aC4gIFRoYXQKcGVyZm9ybXMgdGhlIG1pbmlt
YWwgc2h1dGRvd24gaW4gdGhlIGtlcm5lbC4KCj4+IFRoYXQgd2F5IHlvdSBjYW4gZ2V0IHRoZSBv
cmRlcmx5IHNodXRkb3duCj4+IG9mIHVzZXJzcGFjZSBkYWVtb25zL3NlcnZpY2VzIGFsb25nIHdp
dGggYW4gb3JkZXJseSBzaHV0ZG93biBvZgo+PiBldmVyeXRoaW5nIHRoZSBrZXJuZWwgaXMgcmVz
cG9uc2libGUgZm9yLgo+Cj4gRml4aW5nIGluIHVzZXJzcGFjZSBpcyBhbiBvcHRpb24gYnV0IHBl
b3BsZSBhcmUgbm90IGhhcHB5IHRoYXQgdGhlCj4ga2VybmVsIGNhbiBjcmFzaCBsaWtlIHRoYXQu
CgpJbiBhIGtleGVjIG9uIHBhbmljIHNjZW5hcmlvIHRoZSBrZXJuZWwgbmVlZHMgdG8gcGVyZm9y
bSB0aGF0IGFic29sdXRlCmJhcmUgZXNzZW50aWFsIHNodXRkb3duIGJlZm9yZSBjYWxsaW5nIGtl
eGVjIChiYXNpY2FsbHkgbm90aGluZykuCkR1cmluZyBrZXhlYy1vbi1wYW5pYyBub3RoaW5nIGNh
biBiZSByZWxpZWQgdXBvbiBiZWNhdXNlIHdlIGRvbid0IGtub3cKd2hhdCBpcyBicm9rZW4uICBJ
ZiB0aGF0IGlzIHdoYXQgeW91IGNhcmUgYWJvdXQgKGFzIHN1Z2dlc3RlZCBieSB0aGUKdW5pdCB0
ZXN0KSB5b3UgbmVlZCB0byBmaXggdGhlIGRldmljZSBpbml0aWFsaXphdGlvbi4KCkluIGEgbm9y
bWFsIGtleGVjIHNjZW5hcmlvIHRoZSB3aG9sZSBub3JtYWwgcmVib290IHByb2Nlc3MgaXMgZXhw
ZWN0ZWQuCkkgaGF2ZSBubyBwcm9ibGVtcyB3aXRoIGZpeGluZyB0aGUga2VybmVsIHRvIGhhbmRs
ZSB0aGF0IHNjZW5hcmlvLApidXQgaW4gdGhlIHJlYWwgd29ybGQgdGhlIGVudGlyZSBvcmRlcmx5
IHNodXRkb3duIGJvdGgsIGtlcm5lbAphbmQgdXNlcnNwYWNlIHNob3VsZCBiZSBwZXJmb3JtZWQu
Cgo+PiBBdCB0aGUga2VybmVsIGxldmVsIGEga2V4ZWMgcmVib290IGFuZCBhIG5vcm1hbCByZWJv
b3QgaGF2ZSBiZWVuCj4+IGRlbGliZXJhdGVseSBrZXB0IGFzIGNsb3NlIGFzIHBvc3NpYmxlLiAg
V2hpY2ggaXMgd2h5IEkgc2F5IHdlIHNob3VsZAo+PiBmaXggaXQgaW4gcmVib290Lgo+Cj4gWW91
IG1lYW4gZml4IGl0IGluIHVzZXJzcGFjZT8KCk5vLiAgSSBtZWFuIGluIHRoZSBrZXJuZWwgdGhl
IG9yZGVybHkgc2h1dGRvd24gZm9yIGEga2V4ZWMgcmVib290IGFuZCBhbgpvcmRpbmFyeSByZWJv
b3QgYXJlIGtlcHQgYXMgY2xvc2UgdG8gdGhlIHNhbWUgYXMgcG9zc2libGUuCgpJdCBzaG91bGQg
YmUgdGhlIGNhc2UgdGhhdCB0aGUgb25seSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZSB0d28gaXMg
dGhhdAppbiBvbmNlIGNhc2Ugc3lzdGVtIGZpcm13YXJlIHRha2VzIG92ZXIgYWZ0ZXIgdGhlIG9y
ZGVybHkgc2h1dGRvd24sCmFuZCBpbiB0aGUgb3RoZXIgY2FzZSBhIG5ldyBrZXJuZWwgdGFrZXMg
b3ZlciBhZnRlciB0aGUgb3JkZXJseSBzaHV0ZG93bi4KCkVyaWMKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
