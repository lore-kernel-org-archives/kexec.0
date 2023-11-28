Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AB1C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 02:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N5wQ2DVmHJzur4UGZrKcn/l/qsgG8sSCKgpIguso/mU=; b=sVK5lNJindsx88
	SPb5yJhwGUyajBsS1bvrjFEmV1lnApAPFNP9eHFNEyXvFpSj+51szpChCbQ9njtXVbHqvwYXqDIUt
	rh994aJ+fgM+54xkA3JeXOfoO/2jekab/CnLv8iq65F4sIxj3X70Smx6G8To96Qg7kYJtRYyLfbvX
	TuIjsK3PJqsdg6hRZL4IrqIDjYNH5UQ4SusYWa0Xh/sDvWytRz8TkKhDVJel2CvtlQSZNKbNp605Q
	1+GtPTFq6Sf8CDjbPZc/ra5Yu9MJPkoef6tvlxOGe265v0Cp2XAbzkUw6JIH7hILEMYOlbwLVVWaq
	rkErB/uuJQKAFoXDY6/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7nZe-003rSi-0d;
	Tue, 28 Nov 2023 02:11:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7nZb-003rSC-2T
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 02:11:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701137498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybA3u2D2n3zV+vLhPpowqdJYuAB99119WeeWqv/jh3o=;
	b=QgQyUkKPfFgJzlqSUmQ5+0WBE77C1eTbf8YxUMeQsSg5X0vBOnpgB0676vnXcK8iDKterG
	xLEoYXYBpqzYAl2dDNhJxqRKFZB7TvOn4bo1YhsWpczslmEuBa9O49uusI1xGH+HA++VXk
	+68np1PsN5hLuGYr0dNR1tSzHTekt30=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-MLSVnv92NhKsmWqo6Uvz6g-1; Mon, 27 Nov 2023 21:11:35 -0500
X-MC-Unique: MLSVnv92NhKsmWqo6Uvz6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7AE38477A0;
	Tue, 28 Nov 2023 02:11:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EC541121308;
	Tue, 28 Nov 2023 02:11:33 +0000 (UTC)
Date: Tue, 28 Nov 2023 10:11:31 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	mhocko@suse.cz
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_181139_876246_884DB28D 
X-CRM114-Status: GOOD (  31.16  )
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

T24gMTEvMjgvMjMgYXQgMDk6MTJhbSwgVGFvIExpdSB3cm90ZToKPiBIaSBKaXJpLAo+IAo+IE9u
IFN1biwgTm92IDI2LCAyMDIzIGF0IDU6MjLigK9BTSBKaXJpIEJvaGFjIDxqYm9oYWNAc3VzZS5j
ej4gd3JvdGU6Cj4gPgo+ID4gSGkgVGFvLAo+ID4KPiA+IE9uIFNhdCwgTm92IDI1LCAyMDIzIGF0
IDA5OjUxOjU0QU0gKzA4MDAsIFRhbyBMaXUgd3JvdGU6Cj4gPiA+IFRoYW5rcyBmb3IgdGhlIGlk
ZWEgb2YgdXNpbmcgQ01BIGFzIHBhcnQgb2YgbWVtb3J5IGZvciB0aGUgMm5kIGtlcm5lbC4KPiA+
ID4gSG93ZXZlciBJIGhhdmUgYSBxdWVzdGlvbjoKPiA+ID4KPiA+ID4gV2hhdCBpZiB0aGVyZSBp
cyBvbi1nb2luZyBETUEvUkRNQSBhY2Nlc3Mgb24gdGhlIENNQSByYW5nZSB3aGVuIDFzdAo+ID4g
PiBrZXJuZWwgY3Jhc2g/IFRoZXJlIG1pZ2h0IGJlIGRhdGEgY29ycnVwdGlvbiB3aGVuIDJuZCBr
ZXJuZWwgYW5kCj4gPiA+IERNQS9SRE1BIHdyaXRlIHRvIHRoZSBzYW1lIHBsYWNlLCBob3cgdG8g
YWRkcmVzcyBzdWNoIGFuIGlzc3VlPwo+ID4KPiA+IFRoZSBjcmFzaCBrZXJuZWwgQ01BIGFyZWEo
cykgcmVnaXN0ZXJlZCB2aWEKPiA+IGNtYV9kZWNsYXJlX2NvbnRpZ3VvdXMoKSBhcmUgZGlzdGlu
Y3QgZnJvbSB0aGUKPiA+IGRtYV9jb250aWd1b3VzX2RlZmF1bHRfYXJlYSBvciBkZXZpY2Utc3Bl
Y2lmaWMgQ01BIGFyZWFzIHRoYXQKPiA+IGRtYV9hbGxvY19jb250aWd1b3VzKCkgd291bGQgdXNl
IHRvIHJlc2VydmUgbWVtb3J5IGZvciBETUEuCj4gPgo+ID4gS2VybmVsIHBhZ2VzIHdpbGwgbm90
IGJlIGFsbG9jYXRlZCBmcm9tIHRoZSBjcmFzaCBrZXJuZWwgQ01BCj4gPiBhcmVhKHMpLCBiZWNh
dXNlIHRoZXkgYXJlIG5vdCBHRlBfTU9WQUJMRS4gVGhlIENNQSBhcmVhIHdpbGwgb25seQo+ID4g
YmUgdXNlZCBmb3IgdXNlciBwYWdlcy4KPiA+Cj4gPiBVc2VyIHBhZ2VzIGZvciBSRE1BLCBzaG91
bGQgYmUgcGlubmVkIHdpdGggRk9MTF9MT05HVEVSTSBhbmQgdGhhdAo+ID4gd291bGQgbWlncmF0
ZSB0aGVtIGF3YXkgZnJvbSB0aGUgQ01BIGFyZWEuCj4gPgo+ID4gQnV0IHlvdSdyZSByaWdodCB0
aGF0IERNQSB0byB1c2VyIHBhZ2VzIHBpbm5lZCB3aXRob3V0Cj4gPiBGT0xMX0xPTkdURVJNIHdv
dWxkIHN0aWxsIGJlIHBvc3NpYmxlLiBXb3VsZCB0aGlzIGJlIGEgcHJvYmxlbSBpbgo+ID4gcHJh
Y3RpY2U/IERvIHlvdSBzZWUgYW55IHdheSBhcm91bmQgaXQ/CgpUaGFua3MgZm9yIHRoZSBlZmZv
cnQgdG8gYnJpbmcgdGhpcyB1cCwgSmlyaS4KCkkgYW0gd29uZGVyaW5nIGhvdyB5b3Ugd2lsbCB1
c2UgdGhpcyBjcmFzaGtlcm5lbD0sY21hIHBhcmFtZXRlci4gSSBtZWFuCnRoZSBzY2VuYXJpbyBv
ZiBjcmFzaGtlcm5lbD0sY21hLiBBc2tpbmcgdGhpcyBiZWNhdXNlIEkgZG9uJ3Qga25vdyBob3cK
U1VTRSBkZXBsb3kga2R1bXAgaW4gU1VTRSBkaXN0cm9zLiBJbiBTVVNFIGRpc3Ryb3MsIGtkdW1w
IGtlcm5lbCdzCmluaXRyYW1mcyBpcyB0aGUgc2FtZSBhcyB0aGUgMXN0IGtlcm5lbCwgb3Igb25s
eSBjb250YWluIHRob3NlIG5lZWRlZAprZXJuZWwgbW9kdWxlcyBmb3IgbmVlZGVkIGRldmljZXMu
IEUuZyBpZiB3ZSBkdW1wIHRvIGxvY2FsIGRpc2ssIE5JQwpkcml2ZXIgd2lsbCBiZSBmaWx0ZXIg
b3V0PyBJZiBsYXR0ZXIgY2FzZSwgSXQncyBwb3NzaWJseSBoYXZpbmcgdGhlCm9uLWZsaWdodCBE
TUEgaXNzdWUsIGUuZyBOSUMgaGFzIERNQSBidWZmZXIgaW4gdGhlIENNQSBhcmVhLCBidXQgbm90
CnJlc2V0IGR1cmluZyBrZHVtcCBib290dXAgYmVjYXVzZSB0aGUgTklDIGRyaXZlciBpcyBub3Qg
bG9hZGVkIGluIHRvCmluaXRpYWxpemUuIE5vdCBzdXJlIGlmIHRoaXMgaXMgMTAwJSwgcG9zc2li
bGUgaW4gdGhlb3J5PwoKUmVjZW50bHkgd2UgYXJlIHNlZWluZyBhbiBpc3N1ZSB0aGF0IG9uIGEg
SFBFIHN5c3RlbSwgUENJIGVycm9yIG1lc3NhZ2VzCmFyZSBhbHdheXMgc2VlbiBpbiBrZHVtcCBr
ZXJuZWwsIHdoaWxlIGl0J3MgYSBsb2NhbCBkdW1wLCBOSUMgZGV2aWNlIGlzCm5vdCBuZWVkZWQg
YW5kIHRoZSBpZ2IgZHJpdmVyIGlzIG5vdCBsb2FkZWQgaW4uIFRoZW4gYWRkaW5nIGlnYiBkcml2
ZXIKaW50byBrZHVtcCBpbml0cmFtZnMgY2FuIHdvcmsgYXJvdW5kIGl0LiBJdCdzIHNpbWlsYXIg
d2l0aCBhYm92ZQpvbi1mbGlnaHQgRE1BLgoKVGhlIGNyYXNoa2VybmVsPSxjbWEgcmVxdWlyZXMg
bm8gdXNlcnNwYWNlIGRhdGEgZHVtcGluZywgZnJvbSBvdXIKc3VwcG9ydCBlbmdpbmVlcnMnIGZl
ZWRiYWNrLCBjdXN0b21lciBuZXZlciBleHByZXNzIHRoZXkgZG9uJ3QgbmVlZCB0bwpkdW1wIHVz
ZXIgc3BhY2UgZGF0YS4gQXNzdW1lIGEgc2VydmVyIHdpdGggaHVnZSBkYXRhYnNlIGRlcGxveWVk
LCBhbmQKdGhlIGRhdGFiYXNlIG9mdGVuIGNvbGxhcHNlZCByZWNlbnRseSBhbmQgZGF0YWJhc2Ug
cHJvdmlkZXIgY2xhaW1lZCB0aGF0Cml0J3Mgbm90IGRhdGFiYXNlJ3MgZmF1bHQsIE9TIG5lZWQg
cHJvdmUgdGhlaXIgaW5ub2NlbmNlLiBXaGF0IHdpbGwgeW91CmRvPwoKU28gdGhpcyBsb29rcyBs
aWtlIGEgbmljZSB0byBoYXZlIHRvIG1lLiBBdCBsZWFzdCBpbiBmZWRvcmEvcmhlbCdzCnVzYWdl
LCB3ZSBtYXkgb25seSBiYWNrIHBvcnQgdGhpcyBwYXRjaCwgYW5kIGFkZCBvbmUgc2VudGVuY2Ug
aW4gb3VyCnVzZXIgZ3VpZGUgc2F5aW5nICJ0aGVyZSdzIGEgY3Jhc2hrZXJuZWw9LGNtYSBhZGRl
ZCwgY2FuIGJlIHVzZWQgd2l0aApjcmFzaGtlcm5lbD0gdG8gc2F2ZSBtZW1vcnkuIFBsZWFzZSBm
ZWVsIGZyZWUgdG8gdHJ5IGlmIHlvdSBsaWtlIi4KVW5sZXNzIFNVU0Ugb3Igb3RoZXIgZGlzdHJv
cyBkZWNpZGVzIHRvIHVzZSBpdCBhcyBkZWZhdWx0IGNvbmZpZyBvcgpzb21ldGhpbmcgbGlrZSB0
aGF0LiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJIG1pc3NlZCBhbnl0aGluZyBvciB0b29rCmFueXRo
aW5nIHdyb25nLgoKVGhhbmtzCkJhb3F1YW4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
