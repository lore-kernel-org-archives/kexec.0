Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZvQJ-0001LJ-El
 for kexec@lists.infradead.org; Wed, 17 Aug 2016 07:38:06 +0000
Message-ID: <1471419459.3229.1.camel@suse.de>
Subject: Re: [PATCH 3/3] close_dump_bitmap: simplify logic
From: Martin Wilck <mwilck@suse.de>
Date: Wed, 17 Aug 2016 09:37:39 +0200
In-Reply-To: <20160816075911.09a0659d@hananiah.suse.cz>
References: <20160810125658.23366-1-mwilck@suse.de>
 <20160810125658.23366-4-mwilck@suse.de>
 <20160810150846.6a257447@hananiah.suse.cz>
 <1470836145.3194.31.camel@suse.de>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E5CE94@BPXM01GP.gisp.nec.co.jp>
 <20160816075911.09a0659d@hananiah.suse.cz>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

T24gVHVlLCAyMDE2LTA4LTE2IGF0IDA3OjU5ICswMjAwLCBQZXRyIFRlc2FyaWsgd3JvdGU6Cj4g
T24gVHVlLCAxNiBBdWcgMjAxNiAwMDozNzowOSArMDAwMAo+IEF0c3VzaGkgS3VtYWdhaSA8YXRz
LWt1bWFnYWlAd20uanAubmVjLmNvbT4gd3JvdGU6Cj7CoAo+ID4gU28sIGNvdWxkIHlvdSB3b3Jr
IGZvciB0aGF0IGNsZWFudXAgYmVmb3JlIHlvdXIgdGhyZWUgcGF0Y2hlcyBhcyBhbgo+ID4gYWRk
aXRpb25hbCBjbGVhbnVwIHBhdGNoID8KPiAKPiBPSywgSSB0YWtlIGl0LiA7LSkKPiAKPiBNYXJ0
aW4sIGRvIHlvdSBtaW5kIHJlYmFzaW5nIHlvdXIgcGF0Y2ggd2hlbiBJJ20gZG9uZSB3aXRoIHRo
ZQo+IGNsZWFudXA/CgpObyBwcm9ibGVtLgoKUmVnYXJkcwpNYXJ0aW4KCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
