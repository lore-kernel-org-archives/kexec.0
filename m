Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QFdvm-0005tB-Jl
	for kexec@lists.infradead.org; Fri, 29 Apr 2011 02:59:49 +0000
Message-ID: <4DBA299C.6020003@redhat.com>
Date: Fri, 29 Apr 2011 10:59:40 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
Subject: Re: [Patch] kexec: remove duplicated backup_src_start field from
	struct crash_elf_info
References: <1303875207-9273-1-git-send-email-amwang@redhat.com>
	<20110427150151.GB7790@redhat.com> <4DB91DFC.4060708@redhat.com>
	<20110428131539.GA7883@redhat.com>
	<20110428220515.GI3610@verge.net.au>
In-Reply-To: <20110428220515.GI3610@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

5LqOIDIwMTHlubQwNOaciDI55pelIDA2OjA1LCBTaW1vbiBIb3JtYW4g5YaZ6YGTOgo+IE9uIFRo
dSwgQXByIDI4LCAyMDExIGF0IDA5OjE1OjM5QU0gLTA0MDAsIFZpdmVrIEdveWFsIHdyb3RlOgo+
PiBPbiBUaHUsIEFwciAyOCwgMjAxMSBhdCAwMzo1Nzo0OFBNICswODAwLCBDb25nIFdhbmcgd3Jv
dGU6Cj4+PiDkuo4gMjAxMeW5tDA05pyIMjfml6UgMjM6MDEsIFZpdmVrIEdveWFsIOWGmemBkzoK
Pj4+PiBBbWVyaWdvLAo+Pj4+Cj4+Pj4gTm93IHdobyB3aWxsIGRvIGZvbGxvd2luZyBpbml0aWFs
aXphdGlvbiBmb3IgcHBjPwo+Pj4+Cj4+Pj4gaW5mby0+YmFja3VwX3NyY19zdGFydCA9IEJBQ0tV
UF9TUkNfU1RBUlQ7Cj4+Pj4gaW5mby0+YmFja3VwX3N6ID0gQkFDS1VQX1NSQ19FTkQgLSBCQUNL
VVBfU1JDX1NUQVJUICsgMTsKPj4+Pgo+Pj4+IEkgdGhpbmsgSSBoYXZlIGNvbmNlcm4gZm9yIG1p
cHMgdG9vLgo+Pj4KPj4+IFJpZ2h0LCB3ZSBuZWVkIHRvIGluaXRpYWxpemUgdGhlbSBpbiBsb2Fk
X2NyYXNoZHVtcF9zZWdtZW50cygpLgo+Pj4KPj4+IEhvdyBhYm91dCB0aGUgYXR0YWNoZWQgcGF0
Y2g/IEl0IGlzIHVudGVzdGVkLgo+Pj4KPj4KPj4+IFNpZ25lZC1vZmYtYnk6IFdBTkcgQ29uZzxh
bXdhbmdAcmVkaGF0LmNvbT4KPj4KPj4gT2ssIHRoaXMgb25lIGxvb2tzIGJldHRlci4KPgo+IFZp
dmVrLCBjYW4gSSB0YWtlIHRoYXQgYXMgYW4gQWNrZWQtYnk/Cj4KPiBDb25nLCBjYW4geW91IGNs
YXJpZnkgaWYgSSBuZWVkIHRvIHJldmVydCBhbnkgb2YgeW91ciByZWNlbnQgcGF0Y2hlcyBvcgo+
IG5vdD8KCk5vLCB0aGF0IGF0dGFjaGVkIHBhdGNoIGlzIHJpZ2h0IHRvIGZpeCB0aGUgZmlyc3Qg
b25lLCBzbyB5b3UgZG9uJ3QKbmVlZCB0byByZXZlcnQgYW55dGhpbmcuCgpUaGFua3MhCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
