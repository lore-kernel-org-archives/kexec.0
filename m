Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D0CC07CA9
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 08:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ud/qaRfS4AUk4SdOhpIypqsLtsNfe63QMSn5YqssWkk=; b=180ab0ZsbXmI0J
	cWGsxS08Z9yt2DH+C5V2+U82AJBkQ5le1vuZrfYC5UwNrUczP0K43haD0ksQEzVOAbLJdtCau1CAk
	Koya+tpXpBLGu+JttaMbjEUM+ypqTivBXE8mXI7q4M4gf2MyscRFvOPlIxIPT3LbrC+UVT4dywvQw
	IXSwde1tQeC/jd5sV6+gr5aW2W0Dpuct6aJm5amPl3ynX7xsmIjXCgzpsDxVB1vA1YVS4KvjWpviC
	97bXez2biCJUFq5K54ReAkOV0HbOWBBmPOOQS92TDEMFLF366k8P9W9v1CmzlnItPS/LLP9IMGj0m
	ke8nAEIcs7FjzaUbmLvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7tvq-004cK7-0M;
	Tue, 28 Nov 2023 08:59:02 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7tvm-004cIQ-2z
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 08:59:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A965D21987;
	Tue, 28 Nov 2023 08:58:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A6213763;
	Tue, 28 Nov 2023 08:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pOlCIM+rZWXNUwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 08:58:55 +0000
Date: Tue, 28 Nov 2023 09:58:46 +0100
From: Michal Hocko <mhocko@suse.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Tao Liu <ltao@redhat.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWWrxt0HLC6V4_6X@tiehlicka>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAF+s44QDMzSq3ihzRtaP9ZwF-drfAiQq713d9bastsJFiReJ4w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44QDMzSq3ihzRtaP9ZwF-drfAiQq713d9bastsJFiReJ4w@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: A965D21987
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_005859_122858_E6C65A20 
X-CRM114-Status: GOOD (  29.42  )
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

T24gVHVlIDI4LTExLTIzIDEwOjA3OjA4LCBQaW5nZmFuIExpdSB3cm90ZToKPiBPbiBTdW4sIE5v
diAyNiwgMjAyMyBhdCA1OjI04oCvQU0gSmlyaSBCb2hhYyA8amJvaGFjQHN1c2UuY3o+IHdyb3Rl
Ogo+ID4KPiA+IEhpIFRhbywKPiA+Cj4gPiBPbiBTYXQsIE5vdiAyNSwgMjAyMyBhdCAwOTo1MTo1
NEFNICswODAwLCBUYW8gTGl1IHdyb3RlOgo+ID4gPiBUaGFua3MgZm9yIHRoZSBpZGVhIG9mIHVz
aW5nIENNQSBhcyBwYXJ0IG9mIG1lbW9yeSBmb3IgdGhlIDJuZCBrZXJuZWwuCj4gPiA+IEhvd2V2
ZXIgSSBoYXZlIGEgcXVlc3Rpb246Cj4gPiA+Cj4gPiA+IFdoYXQgaWYgdGhlcmUgaXMgb24tZ29p
bmcgRE1BL1JETUEgYWNjZXNzIG9uIHRoZSBDTUEgcmFuZ2Ugd2hlbiAxc3QKPiA+ID4ga2VybmVs
IGNyYXNoPyBUaGVyZSBtaWdodCBiZSBkYXRhIGNvcnJ1cHRpb24gd2hlbiAybmQga2VybmVsIGFu
ZAo+ID4gPiBETUEvUkRNQSB3cml0ZSB0byB0aGUgc2FtZSBwbGFjZSwgaG93IHRvIGFkZHJlc3Mg
c3VjaCBhbiBpc3N1ZT8KPiA+Cj4gPiBUaGUgY3Jhc2gga2VybmVsIENNQSBhcmVhKHMpIHJlZ2lz
dGVyZWQgdmlhCj4gPiBjbWFfZGVjbGFyZV9jb250aWd1b3VzKCkgYXJlIGRpc3RpbmN0IGZyb20g
dGhlCj4gPiBkbWFfY29udGlndW91c19kZWZhdWx0X2FyZWEgb3IgZGV2aWNlLXNwZWNpZmljIENN
QSBhcmVhcyB0aGF0Cj4gPiBkbWFfYWxsb2NfY29udGlndW91cygpIHdvdWxkIHVzZSB0byByZXNl
cnZlIG1lbW9yeSBmb3IgRE1BLgo+ID4KPiA+IEtlcm5lbCBwYWdlcyB3aWxsIG5vdCBiZSBhbGxv
Y2F0ZWQgZnJvbSB0aGUgY3Jhc2gga2VybmVsIENNQQo+ID4gYXJlYShzKSwgYmVjYXVzZSB0aGV5
IGFyZSBub3QgR0ZQX01PVkFCTEUuIFRoZSBDTUEgYXJlYSB3aWxsIG9ubHkKPiA+IGJlIHVzZWQg
Zm9yIHVzZXIgcGFnZXMuCj4gPgo+ID4gVXNlciBwYWdlcyBmb3IgUkRNQSwgc2hvdWxkIGJlIHBp
bm5lZCB3aXRoIEZPTExfTE9OR1RFUk0gYW5kIHRoYXQKPiA+IHdvdWxkIG1pZ3JhdGUgdGhlbSBh
d2F5IGZyb20gdGhlIENNQSBhcmVhLgo+ID4KPiA+IEJ1dCB5b3UncmUgcmlnaHQgdGhhdCBETUEg
dG8gdXNlciBwYWdlcyBwaW5uZWQgd2l0aG91dAo+ID4gRk9MTF9MT05HVEVSTSB3b3VsZCBzdGls
bCBiZSBwb3NzaWJsZS4gV291bGQgdGhpcyBiZSBhIHByb2JsZW0gaW4KPiA+IHByYWN0aWNlPyBE
byB5b3Ugc2VlIGFueSB3YXkgYXJvdW5kIGl0Pwo+ID4KPiAKPiBJIGhhdmUgbm90IGEgcmVhbCBj
YXNlIGluIG1pbmQuIEJ1dCB0aGlzIHByb2JsZW0gaGFzIGtlcHQgdXMgZnJvbQo+IHVzaW5nIHRo
ZSBDTUEgYXJlYSBpbiBrZHVtcCBmb3IgeWVhcnMuICBNb3N0IGltcG9ydGFudGx5LCB0aGlzIG1l
dGhvZAo+IHdpbGwgaW50cm9kdWNlIGFuIHVuZWFzeSB0cmFja2luZyBidWcuCgpMb25nIHRlcm0g
cGlubmluZyBpcyBzb21ldGhpbmcgdGhhdCBoYXMgY2hhbmdlZCB0aGUgcGljdHVyZSBJTUhPLiBU
aGUKQVBJIGhhZCBiZWVuIGJyZXdlaW5nIGZvciBhIGxvbmcgdGltZSBidXQgaXQgaGFzIGJlZW4g
ZXN0YWJsaXNoZWQgYW5kCnVzYWdlIHNwcmVhZGluZy4gSXMgaXQgcG9zc2libGUgdGhhdCBzb21l
IGRyaXZlciBjb3VsZCBiZSBkb2luZyByZW1vdGUKRE1BIHdpdGhvdXQgdGhlIGxvbmcgdGVybSBw
aW5uaW5nPyBRdWl0ZSBwb3NzaWJsZSBidXQgdGhpcyBtZWFucyBzdWNoIGEKZHJpdmVyIHNob3Vs
ZCBiZSBmaXhlZCByYXRoZXIgdGhhbiBwcmV2ZW50aW5nIGNtYSB1c2UgZm9yIHRoaXMgdXNlY2Fz
ZQpUQkguCiAKPiBGb3IgYSB3YXkgYXJvdW5kLCBtYXliZSB5b3UgY2FuIGludHJvZHVjZSBhIHNw
ZWNpZmljIHpvbmUsIGFuZCBmb3IgYW55Cj4gR1VQLCBtaWdyYXRlIHRoZSBwYWdlcyBhd2F5LiBJ
IGhhdmUgZG91YnRzIGFib3V0IHdoZXRoZXIgdGhpcyBhcHByb2FjaAo+IGlzIHdvcnRod2hpbGUs
IGNvbnNpZGVyaW5nIHRoZSB0cmFkZS1vZmYgYmV0d2VlbiBiZW5lZml0cyBhbmQKPiBjb21wbGV4
aXR5LgoKTm8sIGEgem9uZSBpcyBkZWZpbml0ZWx5IG5vdCBhbiBhbnN3ZXIgdG8gdGhhdCBiZWNh
dXNlIGJlY2F1c2UgYSkKdXNlcnNwYWNlIHdvdWxkIG5lZWQgdG8gYmUgYWJsZSB0byB1c2UgdGhh
dCBtZW1vcnkgYW5kIHVzZXJzcGFjZSBtaWdodApwaW4gbWVtb3J5IGZvciBkaXJlY3QgSU8gYW5k
IG90aGVycy4gU28gaW4gdGhlIGVuZCBsb25ndGVybSBwaW5uaW5nCndvdWxkIG5lZWQgdG8gYmUg
dXNlZCBhbnl3YXkuCgotLSAKTWljaGFsIEhvY2tvClNVU0UgTGFicwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
