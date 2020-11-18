Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfEbC-0001bZ-2b
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 03:57:40 +0000
Subject: Re: [MAKDUMPFILE PATCH] Add option to estimate the size of vmcore
 dump files
References: <20201012070905.5837-1-jthierry@redhat.com>
 <CACi5LpNSnr+9v_sMPZnCQu14pML6PR1bBLKqj4tVaxk2O9k0wA@mail.gmail.com>
 <f12bb1e2-c984-68d0-f952-d6b7243c8a7e@redhat.com>
 <CACi5LpM-hCjnFg6Knb57Fr7+zVnTDewYRLAFABeNrd_gy+GhGw@mail.gmail.com>
 <OSBPR01MB19912E6BD4B99FE4915708FFDD030@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <617405cb-717f-62ee-e463-a41dc9560cbb@redhat.com>
 <OSBPR01MB1991C4EB34CBC812E4616F26DD170@OSBPR01MB1991.jpnprd01.prod.outlook.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <f0c14722-1563-de64-433d-33ea0429a332@redhat.com>
Date: Wed, 18 Nov 2020 11:57:29 +0800
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB1991C4EB34CBC812E4616F26DD170@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Content-Language: en-US
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
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>, Julien Thierry <jthierry@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

SGksIEthenUsIEp1bGllbiBhbmQgQmh1cGVzaAoK5ZyoIDIwMjDlubQxMOaciDI45pelIDE2OjMy
LCBIQUdJTyBLQVpVSElUTyjokKnlsL7jgIDkuIDku4EpIOWGmemBkzoKPiBJJ20gcmV0aGlua2lu
ZyBhYm91dCB3aGF0IGNvbW1hbmQgb3B0aW9ucyBtYWtlZHVtcGZpbGUgc2hvdWxkIGhhdmUuCj4g
SWYgb25jZSB3ZSBhZGQgYW4gb3B0aW9uIHRvIG1ha2VkdW1wZmlsZSwgd2UgY2Fubm90IGNoYW5n
ZSBpdCBlYXNpbHksCj4gc28gSSdkIGxpa2UgdG8gdGhpbmsgY2FyZWZ1bGx5Lgo+IAo+IFRoZSBj
YWxjdWxhdGVkIHNpemUgbWlnaHQgYmUgdXNlZnVsIGlmIGl0J3MgcHJpbnRlZCBzbyB0aGF0IGl0
IGNhbiBiZQo+IGVhc2lseSBwb3N0LXByb2Nlc3NlZCBieSBzY3JpcHRzLCBlLmcuIGZvciBhdXRv
bWF0ZWQgdGVzdHMuICBJZiBzbywKPiBtYWtlZHVtcGZpbGUgYWxyZWFkeSBwcmludHMgaXRzIHN0
YXRpc3RpY3Mgd2l0aCAiLS1tZXNzYWdlLWxldmVsIDE2IiwKPiBhbmQgaXQgbWlnaHQgYmUgdXNl
ZnVsIHRvIGFsc28gcHJpbnQgdGhlbSBieSBhbiBvcHRpb24gbGlrZSAiLS1zaG93LXN0YXRzIi4K
PiAKPiAgICMgbWFrZWR1bXBmaWxlIC0tc2hvdy1zdGF0cyAtbCAtZCAzMSB2bWNvcmUgZHVtcC5s
ZDMxCj4gICB0b3RhbF9wYWdlcyB4eHgKPiAgIGV4Y2x1ZGVkX3BhZ2VzIHl5eQo+ICAgLi4uCj4g
ICB3cml0ZV9ieXRlcyB6enoKPiAKPiBBbHNvLCBpZiB3ZSBhbHNvIGhhdmUgIi0tZHJ5LXJ1biIg
b3B0aW9uIHRvIG5vdCB3cml0ZSBhY3R1YWxseSwgaXQncwo+IGV4cGxpY2l0IGFuZCBtZWV0cyBC
aHVwZXNoJ3MgdXNlIGNhc2UuICBXaGF0IGRvIHlvdSB0aGluaz8KPiAKCkl0IHNlZW1zIHRoYXQg
YWRkaW5nIGEgc3RhdGlzdGljYWwgb3B0aW9uIGNvdWxkIGJlIGJldHRlciB0aGFuIG5vdGhpbmcu
CgpEbyB5b3UgaGF2ZSBhbnkgZGVjaXNpb25zIG9uIHRoaXMgaXNzdWU/IE9yIGFueSB0aG91Z2h0
cz8KCgpUaGFua3MKTGlhbmJvCgo+IFRoYW5rcywKPiBLYXp1CgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
