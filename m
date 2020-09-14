Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHjtD-0003cQ-MK
 for kexec@lists.infradead.org; Mon, 14 Sep 2020 08:31:10 +0000
Subject: Re: makedumpfile: a feature question about filtering
References: <9da0d585-4170-5758-e27d-814fcb97d575@redhat.com>
 <OSBPR01MB1991C082928AD18ED5574DDBDD240@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <0b99591e-7117-7661-e728-684ece22787e@redhat.com>
 <OSBPR01MB19915EEEDE74943D073908D4DD230@OSBPR01MB1991.jpnprd01.prod.outlook.com>
From: piliu <piliu@redhat.com>
Message-ID: <e6f42e12-5c7c-67fa-0f5c-621d7508ee45@redhat.com>
Date: Mon, 14 Sep 2020 16:30:58 +0800
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB19915EEEDE74943D073908D4DD230@OSBPR01MB1991.jpnprd01.prod.outlook.com>
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
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

CgpPbiAwOS8xNC8yMDIwIDA0OjE1IFBNLCBIQUdJTyBLQVpVSElUTyjokKnlsL7jgIDkuIDku4Ep
IHdyb3RlOgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IE9uIDA5LzExLzIwMjAgMDQ6
NTMgUE0sIEhBR0lPIEtBWlVISVRPKOiQqeWwvuOAgOS4gOS7gSkgd3JvdGU6Cj4+PiBIaSBQaW5n
ZmFuLAo+Pj4KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+Pj4gSGVsbG8sCj4+Pj4K
Pj4+PiBUaGVyZSBpcyBhbiBhcHBlYWwgd2hpY2ggb25seSB3YW50cyB0byBzYXZlIHNvbWUgdXNl
ciBwYWdlIGluY2x1ZGluZyBlbnYKPj4+PiBhbmQgYXJncyBwYWdlcywgYW5kIGRpc2NhcmRzIHRo
ZSBvdGhlciB1c2VyIHNwYWNlIHBhZ2VzLgo+Pj4KPj4+IEkgdW5kZXJzdGFuZCB0aGF0IGl0J3Mg
aGVscGZ1bCB0byBnZXQgdGhlbSBldmVuIHdpdGggLWQgMzEgZm9yIGNyYXNoJ3MKPj4+ICJwcyAt
YSIgb3B0aW9uLi4KPj4+Cj4+Pj4KPj4+PiBUbyBhY2hpZXZlIHRoaXMgZmVhdHVyZSwgbW1fc3Ry
dWN0J3MgbWVtYmVycyAiYXJnX3N0YXJ0LCBhcmdfZW5kLAo+Pj4+IGVudl9zdGFydCwgZW52X2Vu
ZDsiIHNob3VsZCBiZSBhY2Nlc3NlZC4gU28gd2UgbmVlZCB0byBleHBvcnQgbW1fc3RydWN0Cj4+
Pj4gYW5kIGluaXRfbW0gdGhyb3VnaCB2bWNvcmUuCj4+Pgo+Pj4gSG93IG1hbnkgb2Zmc2V0cy9z
aXplcyB3aWxsIGJlIHJlcXVpcmVkIHRvIHdhbGsgYWxsIHRhc2tzPwo+PiBBdCBwcmVzZW50LCBJ
IHRoaW5rIG9ubHkgdGhlIGluZm8gImFyZ19zdGFydCwgYXJnX2VuZCwgZW52X3N0YXJ0LAo+PiBl
bnZfZW5kIiBpbiBtbV9zdHJ1Y3QgYXJlIHJlcXVpcmVkLgo+IAo+IGFoIHdoYXQgSSB3YW50ZWQg
dG8gYXNrIG1haW5seSB3YXMgdGhlIG51bWJlciBvZiB0aGUgb2Zmc2V0cy9zaXplcyB1c2VkIHRv
Cj4gd2FsayB0aHJvdWdoIGFsbCAodXNlcikgdGFza3MgaW4gYSBzeXN0ZW0sIGJlY2F1c2UgbWFr
ZWR1bXBmaWxlIGNhbm5vdCBnZXQKPiB0byBhIHRhc2sncyBhcmdfc3RhcnQgb25seSB3aXRoIE9G
RlNFVChtbV9zdHJ1Y3QuYXJnX3N0YXJ0KS4gIElzIGl0IGVhc3kKPiBlbm91Z2ggdG8gZG8gaXQg
b25seSB3aXRoIHNldmVyYWwgdm1jb3JlaW5mbyBlbnRyaWVzPwpZZXMsIGl0IGlzLiBJdGVyYXRp
bmcgb3ZlciB0YXNrcyByZXF1aXJlcyB0byBleHBvc2UKT0ZGU0VUKG1tX3N0cnVjdC5tbWxpc3Qs
IGFuZCAmaW5pdF9tbS4gVGhlbiBmb3IgZWFjaCBtbV9zdHJ1Y3QsIHdlIG5lZWQKYW4gYWNjZXNz
IHRvICJhcmdfc3RhcnQsIGFyZ19lbmQsIGVudl9zdGFydCxlbnZfZW5kIgoKVGhhbmtzLApQaW5n
ZmFuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
