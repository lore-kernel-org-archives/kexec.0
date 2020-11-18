Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfHy4-0007o1-SM
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 07:33:29 +0000
Received: by mail-wr1-f69.google.com with SMTP id u1so571945wri.6
 for <kexec@lists.infradead.org>; Tue, 17 Nov 2020 23:33:20 -0800 (PST)
Subject: Re: [MAKDUMPFILE PATCH] Add option to estimate the size of vmcore
 dump files
References: <20201012070905.5837-1-jthierry@redhat.com>
 <CACi5LpNSnr+9v_sMPZnCQu14pML6PR1bBLKqj4tVaxk2O9k0wA@mail.gmail.com>
 <f12bb1e2-c984-68d0-f952-d6b7243c8a7e@redhat.com>
 <CACi5LpM-hCjnFg6Knb57Fr7+zVnTDewYRLAFABeNrd_gy+GhGw@mail.gmail.com>
 <OSBPR01MB19912E6BD4B99FE4915708FFDD030@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <617405cb-717f-62ee-e463-a41dc9560cbb@redhat.com>
 <OSBPR01MB1991C4EB34CBC812E4616F26DD170@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <f0c14722-1563-de64-433d-33ea0429a332@redhat.com>
From: Julien Thierry <jthierry@redhat.com>
Message-ID: <c065d8b2-68dc-8a1f-fe68-7b8882ec28f9@redhat.com>
Date: Wed, 18 Nov 2020 07:33:17 +0000
MIME-Version: 1.0
In-Reply-To: <f0c14722-1563-de64-433d-33ea0429a332@redhat.com>
Content-Language: en-US
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: lijiang <lijiang@redhat.com>, =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IA==?= =?UTF-8?B?5LiA5LuBKQ==?= <k-hagio-ab@nec.com>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

SGksCgpPbiAxMS8xOC8yMCAzOjU3IEFNLCBsaWppYW5nIHdyb3RlOgo+IEhpLCBLYXp1LCBKdWxp
ZW4gYW5kIEJodXBlc2gKPiAKPiDlnKggMjAyMOW5tDEw5pyIMjjml6UgMTY6MzIsIEhBR0lPIEtB
WlVISVRPKOiQqeWwvuOAgOS4gOS7gSkg5YaZ6YGTOgo+PiBJJ20gcmV0aGlua2luZyBhYm91dCB3
aGF0IGNvbW1hbmQgb3B0aW9ucyBtYWtlZHVtcGZpbGUgc2hvdWxkIGhhdmUuCj4+IElmIG9uY2Ug
d2UgYWRkIGFuIG9wdGlvbiB0byBtYWtlZHVtcGZpbGUsIHdlIGNhbm5vdCBjaGFuZ2UgaXQgZWFz
aWx5LAo+PiBzbyBJJ2QgbGlrZSB0byB0aGluayBjYXJlZnVsbHkuCj4+Cj4+IFRoZSBjYWxjdWxh
dGVkIHNpemUgbWlnaHQgYmUgdXNlZnVsIGlmIGl0J3MgcHJpbnRlZCBzbyB0aGF0IGl0IGNhbiBi
ZQo+PiBlYXNpbHkgcG9zdC1wcm9jZXNzZWQgYnkgc2NyaXB0cywgZS5nLiBmb3IgYXV0b21hdGVk
IHRlc3RzLiAgSWYgc28sCj4+IG1ha2VkdW1wZmlsZSBhbHJlYWR5IHByaW50cyBpdHMgc3RhdGlz
dGljcyB3aXRoICItLW1lc3NhZ2UtbGV2ZWwgMTYiLAo+PiBhbmQgaXQgbWlnaHQgYmUgdXNlZnVs
IHRvIGFsc28gcHJpbnQgdGhlbSBieSBhbiBvcHRpb24gbGlrZSAiLS1zaG93LXN0YXRzIi4KPj4K
Pj4gICAgIyBtYWtlZHVtcGZpbGUgLS1zaG93LXN0YXRzIC1sIC1kIDMxIHZtY29yZSBkdW1wLmxk
MzEKPj4gICAgdG90YWxfcGFnZXMgeHh4Cj4+ICAgIGV4Y2x1ZGVkX3BhZ2VzIHl5eQo+PiAgICAu
Li4KPj4gICAgd3JpdGVfYnl0ZXMgenp6Cj4+Cj4+IEFsc28sIGlmIHdlIGFsc28gaGF2ZSAiLS1k
cnktcnVuIiBvcHRpb24gdG8gbm90IHdyaXRlIGFjdHVhbGx5LCBpdCdzCj4+IGV4cGxpY2l0IGFu
ZCBtZWV0cyBCaHVwZXNoJ3MgdXNlIGNhc2UuICBXaGF0IGRvIHlvdSB0aGluaz8KPj4KPiAKPiBJ
dCBzZWVtcyB0aGF0IGFkZGluZyBhIHN0YXRpc3RpY2FsIG9wdGlvbiBjb3VsZCBiZSBiZXR0ZXIg
dGhhbiBub3RoaW5nLgo+IAo+IERvIHlvdSBoYXZlIGFueSBkZWNpc2lvbnMgb24gdGhpcyBpc3N1
ZT8gT3IgYW55IHRob3VnaHRzPwo+IAoKT24gbXkgZW5kIHRoaXMgbWFrZXMgc2Vuc2UsIEknbGwg
dHJ5IHRvIGFkZCB0aGUgLS1kcnktcnVuIGFuZCAKLS1zaG93LXN0YXRzIG9wdGlvbnMgYXMgS2F6
dSBzdWdnZXN0ZWQgYW5kIHBvc3QgYSBuZXcgdmVyc2lvbi4KCi0tIApKdWxpZW4gVGhpZXJyeQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
