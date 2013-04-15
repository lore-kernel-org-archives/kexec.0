Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URfMk-00056k-2w
 for kexec@lists.infradead.org; Mon, 15 Apr 2013 09:06:22 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
Date: Mon, 15 Apr 2013 11:05:34 +0200
Message-ID: <2471280.iW0sCiTc3x@skinner.arch.suse.de>
In-Reply-To: <5167DA38.3050600@cn.fujitsu.com>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
 <5167DA38.3050600@cn.fujitsu.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, yinghai@kernel.org, cpw@sgi.com, vgoyal@redhat.com

T24gRnJpZGF5LCBBcHJpbCAxMiwgMjAxMyAwNTo1NjowOCBQTSBaaGFuZyBZYW5mZWkgd3JvdGU6
Cj4g5LqOIDIwMTPlubQwNOaciDEx5pelIDIwOjI2LCBUaG9tYXMgUmVubmluZ2VyIOWGmemBkzoK
PiA+IEN1cnJlbnRseSByYW5nZXMgYXJlIHBhc3NlZCB2aWEga2VybmVsIGJvb3QgcGFyYW1ldGVy
czoKPiA+IG1lbW1hcD1leGFjdG1hcCBtZW1tYXA9WCNZIG1lbW1hcD0KPiA+IAouLi4KPiA+IC0J
aWYgKCEoZW5kIC0gc3RhcnQpKQo+ID4gLQkJcmV0dXJuIDA7Cj4gPiArCS8qCj4gPiArCSAqIEln
bm9yZSB1c2FibGUgbWVtb3J5IHJhbmdlcyBmb3Iga2R1bXAga2VybmVsIHNtYWxsZXIKPiA+ICsJ
ICogdGhhbiAxMDBrIHRvIGF2b2lkIHRvbyBtdWNoIHJhbmdlcyBwYXNzZWQKPiA+ICsJICogU2F2
ZSB0aGUgbmV3IHJhbmdlcyAoZXhsdWRpbmcgbG93ZXIgdGhhbiAxMDBrIHJhbmdlcykgaW4gdG1w
X21hcAo+ID4gKwkgKiBhbmQgc3RvcmUgdGhlIG51bWJlciBvZiBlbGVtZW50cyBpbiB0bXBfbWFw
X3Jhbmdlcwo+ID4gKwkgKi8KPiA+ICsJZm9yIChtID0gMCwgaSA9IDA7IGkgPCBDUkFTSF9NQVhf
TUVNTUFQX05SOyBpKyspIHsKPiA+ICsJCXVuc2lnbmVkIGxvbmcgc3RhcnRrLCBlbmRrOwo+ID4g
KwkJc3RhcnRrID0gKHVzYWJsZV9tZW1baV0uc3RhcnQvMTAyNCk7Cj4gPiArCQllbmRrID0gKCh1
c2FibGVfbWVtW2ldLmVuZCArIDEpLzEwMjQpOwo+ID4gKwkJaWYgKCFzdGFydGsgJiYgIWVuZGsp
Cj4gPiArCQkJLyogQWxsIHJlZ2lvbnMgdHJhdmVyc2VkLiAqLwo+ID4gKwkJCWJyZWFrOwo+ID4g
Kwo+ID4gKwkJLyogQSByZWdpb24gaXMgbm90IHdvcnRoIGFkZGluZyBpZiByZWdpb24gc2l6ZSA8
IDEwMEsuIEl0IGVhdHMKPiA+ICsJCSAqIHVwIHByZWNpb3VzIGNvbW1hbmQgbGluZSBsZW5ndGgu
ICovCj4gCj4gTm93IHlvdSBhcmUgcGFzc2luZyB0aGUgZTgyMCB0YWJsZSBkaXJlY3RseSBpbnN0
ZWFkIG9mIHRoZSBjb21tYW5kbGluZSwgc28KPiBkb2VzIHRoaXMgY29tbWVudCBtYWtlIHNlbnNl
IG5vdz8KWWVzIHlvdSBhcmUgcmlnaHQsIHRoZSBjb21tZW50IGlzIHdyb25nLgpJdCBzaG91bGQg
bW9yZSBiZSBsaWtlOgovKgpBIHJlZ2lvbiBpcyBub3Qgd29ydGggYWRkaW5nIGlmIHJlZ2lvbiBz
aXplIDwgMTAwSy4gZTgyMCBlbnRyaWVzIGFyZSAKcmVzdHJpY3RlZCB0byAxMjggaW4ga2VybmVs
LCB3aXRoIGtkdW1wIHdlIG1heSBoYXZlIHRvIHBhc3MgdGhlIG9uZSBvciBvdGhlcgptb3JlIGFu
ZCB3ZSB3YW50IHRvIHRyeSB0byBzdGF5IGF0IDEyOCBtYXggZW50cmllcyAoZnJvbSBvcmlnaW5h
bCB0YWJsZSkgYXMgCmNsb3NlIGFzIHBvc3NpYmxlLgoqLwoKVGhhbmtzLAoKICAgICAgVGhvbWFz
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
