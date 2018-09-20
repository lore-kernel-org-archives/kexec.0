Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g338B-0004YM-27
 for kexec@lists.infradead.org; Thu, 20 Sep 2018 17:52:48 +0000
Received: by mail-wm1-f53.google.com with SMTP id y2-v6so421238wma.1
 for <kexec@lists.infradead.org>; Thu, 20 Sep 2018 10:52:34 -0700 (PDT)
Received: from t-5.eu (p5B2831D8.dip0.t-ipconnect.de. [91.40.49.216])
 by smtp.gmail.com with ESMTPSA id r9sm7665195wrx.65.2018.09.20.10.52.32
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Sep 2018 10:52:32 -0700 (PDT)
Received: from t-5.eu (localhost [127.0.0.1])
 by t-5.eu (Postfix) with ESMTP id 8D00315AFD9
 for <kexec@lists.infradead.org>; Thu, 20 Sep 2018 19:52:31 +0200 (CEST)
MIME-Version: 1.0
Date: Thu, 20 Sep 2018 19:52:31 +0200
From: =?UTF-8?Q?J=C3=BCrgen_Herrmann?= <t-5@t-5.eu>
Subject: cannot get kdump to work, kexec stops in load_segments()
Message-ID: <73ee47d5aea541566c89ff264c2d39ed@t-5.eu>
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
To: kexec@lists.infradead.org

SGVsbG8hCgpJIGFtIHRyeWluZyB0byBkZWJ1ZyBhIGhhbmcgaW4gYnRyZnMtc2VuZDogSSB0YWxr
ZWQgdG8gdGhlIGd1eXMgb24gdGhlIApsaW51eC1idHJmcwptYWlsaW5nIGxpc3QgYW5kIHRoZXkg
bmVlZCBhIGtkdW1wIG9mIHRoZSBzdGF0ZSB3aGVuIHRoZSBoYW5nIGhhcHBlbnMuCgpJIGFscmVh
ZHkgc2V0IHVwIGtkdW1wOgokIGtkdW1wLWNvbmZpZyBzaG93CkRVTVBfTU9ERTogICAgICAgIGtk
dW1wClVTRV9LRFVNUDogICAgICAgIDEKS0RVTVBfU1lTQ1RMOiAgICAga2VybmVsLnBhbmljX29u
X29vcHM9MQpLRFVNUF9DT1JFRElSOiAgICAvdmFyL2NyYXNoCmNyYXNoa2VybmVsIGFkZHI6IDB4
MjQwMDAwMDAKICAgIC92bWxpbnV6OiBzeW1ib2xpYyBsaW5rIHRvIGJvb3Qvdm1saW51ei00LjE1
LjAtMzQtZ2VuZXJpYwprZHVtcCBpbml0cmQ6CiAgICAvaW5pdHJkLmltZzogc3ltYm9saWMgbGlu
ayB0byBib290L2luaXRyZC5pbWctNC4xNS4wLTM0LWdlbmVyaWMKY3VycmVudCBzdGF0ZTogICAg
cmVhZHkgdG8ga2R1bXAKCmtleGVjIGNvbW1hbmQ6CiAgIC9zYmluL2tleGVjIC1wIC1kIC0tY29t
bWFuZC1saW5lPSJCT09UX0lNQUdFPS92bWxpbnV6LTQuMTguNiAKcm9vdD1VVUlEPWE5MTRjMTQx
LTcyYmYtNDQ4Yi04NDdmLWQ2NGVlODJkOGI3YiBybyByb290ZmxhZ3M9c3Vidm9sPUAgCnF1aWV0
IHNwbGFzaCB2dC5oYW5kb2ZmPTEgbnJfY3B1cz0xIHN5c3RlbWQudW5pdD1rZHVtcC10b29scy5z
ZXJ2aWNlIAppcnFwb2xsIG5vdXNiIGF0YV9waWl4LnByZWZlcl9tc19oeXBlcnY9MCIgLS1pbml0
cmQ9L2luaXRyZC5pbWcgL3ZtbGludXoKCktlcm5lbCB2ZXJzaW9uIGlzIDQuMTguNiBmcm9tIGtl
cm5lbC5vcmcKCkNQVTogSW50ZWwoUikgQ29yZShUTSkgaTUtODI1MFUgQ1BVIEAgMS42MEdIegoK
SSBkaWQgYSBsaXR0bGUgZGlnZ2luZyBpbiB0aGUga2VybmVsIGNvZGUgd2l0aCBwcmludGsoKSBz
dGF0ZW1lbnRzIGFuZAp0aGUgZXhlY3V0aW9uIHN0b3BzIGluIGFyY2gveDg2L2tlcm5lbC9tYWNo
aW5lX2tleGVjXzY0LmMgaW4gZnVuY3Rpb24KbG9hZF9zZWdtZW50cygpLiBUaGUgbGFzdCBwcmlu
dGsgSSBzZWUgaXMgYmVmb3JlIHRoZSBjYWxsIG9mIApsb2FkX3NlZ21lbnRzKCkuCgpBIHNjcmVl
bnNob3Qgb2YgdGhlICJ0ZXN0LWNyYXNoIiBjYW4gYmUgc2VlbiBoZXJlOgpodHRwczovL3QtNS5l
dS9vd25jbG91ZC9pbmRleC5waHAvcy9XQ3hvTnVTcW5LVmc2SjcKCldoYXQgZWxzZSBkbyBJIG5l
ZWQgdG8gcHJvdmlkZSBpbiB0ZXJtcyBvZiBpbmZvcm1hdGlvbj8KCkJlc3QgcmVnYXJkcywKSsO8
cmdlbgotLSAKSsO8cmdlbiBIZXJybWFubgpodHRwczovL3QtNS5ldQpBTGJlcnRzdHJhw59lIDIK
OTQzMjcgQm9nZW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
