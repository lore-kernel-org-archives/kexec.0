Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wb9UM-0004BB-Ia
 for kexec@lists.infradead.org; Fri, 18 Apr 2014 14:09:59 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <clg@fr.ibm.com>;
 Fri, 18 Apr 2014 15:09:34 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id ED45117D8047
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 15:10:28 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3IE9WCw59965450
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 14:09:32 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3IE9Vmx007126
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 08:09:31 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
Subject: [PATCH 0/7] ppc64: little endian zImage support
Date: Fri, 18 Apr 2014 16:08:33 +0200
Message-Id: <1397830120-13323-1-git-send-email-clg@fr.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>

SGksCgpBIHpJbWFnZSBpcyBwcGM2NCBlbGYgZXhlY3V0YWJsZSBmaWxlIGNvbnRhaW5pbmcgYW4g
ZWxmIHNlY3Rpb24gCiIua2VybmVsOnZtbGludXguc3RyaXAiIGluIHdoaWNoIGEgdm1saW51eCBm
aWxlIGlzIGNvbXByZXNzZWQuIAoKVGhlIHN1cHBvcnQgZm9yIHN1Y2ggZmlsZXMgaXMgc2ltcGx5
IGFkZGVkIGJ5IGRldGVjdGluZyB0aGUgCiIua2VybmVsOnZtbGludXguc3RyaXAiIHNlY3Rpb24g
d2hlbiBhIHBwYzY0IGV4ZWN1dGFibGUgaXMgbG9hZGVkLiAKSWYgZm91bmQsIHRoZSBlbWJlZGRl
ZCB2bWxpbnV4IGZpbGUgaXMgdW5jb21wcmVzc2VkIGFuZCBsb2FkZWQgCmluIGxpZXUgb2YgdGhl
IG9yaWdpbmFsIHpJbWFnZSBmaWxlLgoKUGF0Y2ggMSBhZGRzIGEgc2ltcGxlIGhlbHBlciByb3V0
aW5lIHRvIGxvb2sgZm9yIGEgc2VjdGlvbi4gUGF0Y2ggMgphZGRzIGEgcHJvcG9zYWwgdG8gYnlw
YXNzIHRoZSBjaGVjayBvbiB0aGUgaW50ZXJwIHByb2dyYW0gaGVhZGVyIAp3aGljaCBpcyBuZWVk
ZWQgZm9yIHpJbWFnZSBmaWxlcyBvbiBsaXR0bGUgZW5kaWFuLiBQYXRjaCAzIGFkZHMgdGhlIApj
b3JlIGZ1bnRpb25uYWxpdHkgYW5kIHRoZSBmaW5hbCBwYXRjaGVzIGFyZSBwcGM2NCBjb21waWxl
IGNsZWFudXBzIAp3aGljaCBwb2x1dGVkIG91dHB1dC4KCkFsc28gYXZhaWxhYmxlIGhlcmUgOgoK
ICAgICBodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0ZXIva2V4ZWMtdG9vbHMgemltYWdlCgpDb21t
ZW50cyBhcmUgd2VsY29tZSAhIAoKVGhhbmtzCkMuCgpDw6lkcmljIExlIEdvYXRlciAoNyk6CiAg
a2V4ZWM6IGFkZCBhIGVsZl9yZWxfZmluZF9zZWN0aW9uIHNlcnZpY2UKICBrZXhlYzogYnlwYXNz
IGNoZWNrIG9uIGludGVycCBwcm9ncmFtIGhlYWRlciBmb3IgcHBjNjRsZSB6SW1hZ2UKICBwcGM2
NDogZGV0ZWN0IHpJbWFnZSBmaWxlcyBhbmQgbG9hZCB0aGUgdW5jb21wcmVzc2VkIHZtbGludXgK
ICBwcGM2NCwgY2xlYW51cDogY21kbGluZV9sZW4gdmFyaWFibGVzIGFyZSB1bnVzZWQKICBwcGM2
NCwgY2xlYW51cDogcmVtb3ZlIGRlYWQgY29kZSBpbiBrZXhlYy16SW1hZ2UtcHBjNjQKICBwcGM2
NCwgY2xlYW51cDogZml4IGltcGxpY2l0IGRlY2xhcmF0aW9uIGNvbXBpbGUgd2FybmluZ3MKICBw
cGM2NCwgY2xlYW51cDogZml4IHVudXNlZCB2YXJpYWJsZSBjb21waWxlIHdhcm5pbmcKCiBrZXhl
Yy9hcmNoL2FybS9rZXhlYy1lbGYtcmVsLWFybS5jICAgICAgIHwgICAgNSArCiBrZXhlYy9hcmNo
L2NyaXMva2V4ZWMtZWxmLXJlbC1jcmlzLmMgICAgIHwgICAgNSArCiBrZXhlYy9hcmNoL2kzODYv
a2V4ZWMtZWxmLXJlbC14ODYuYyAgICAgIHwgICAgNSArCiBrZXhlYy9hcmNoL2lhNjQva2V4ZWMt
ZWxmLXJlbC1pYTY0LmMgICAgIHwgICAgNSArCiBrZXhlYy9hcmNoL202OGsva2V4ZWMtZWxmLXJl
bC1tNjhrLmMgICAgIHwgICAgNSArCiBrZXhlYy9hcmNoL21pcHMva2V4ZWMtZWxmLXJlbC1taXBz
LmMgICAgIHwgICAgNSArCiBrZXhlYy9hcmNoL3BwYy9rZXhlYy1lbGYtcmVsLXBwYy5jICAgICAg
IHwgICAgNSArCiBrZXhlYy9hcmNoL3BwYzY0L2NyYXNoZHVtcC1wcGM2NC5jICAgICAgIHwgICAg
MyArLQoga2V4ZWMvYXJjaC9wcGM2NC9rZXhlYy1lbGYtcHBjNjQuYyAgICAgICB8ICAgMjMgKysr
LQoga2V4ZWMvYXJjaC9wcGM2NC9rZXhlYy1lbGYtcmVsLXBwYzY0LmMgICB8ICAgMzUgKysrLS0K
IGtleGVjL2FyY2gvcHBjNjQva2V4ZWMtcHBjNjQuYyAgICAgICAgICAgfCAgICAxICsKIGtleGVj
L2FyY2gvcHBjNjQva2V4ZWMtcHBjNjQuaCAgICAgICAgICAgfCAgICAyICsKIGtleGVjL2FyY2gv
cHBjNjQva2V4ZWMtekltYWdlLXBwYzY0LmMgICAgfCAgMjE0ICsrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLQoga2V4ZWMvYXJjaC9zMzkwL2tleGVjLWVsZi1yZWwtczM5MC5jICAgICB8ICAg
IDUgKwoga2V4ZWMvYXJjaC9zaC9rZXhlYy1lbGYtcmVsLXNoLmMgICAgICAgICB8ICAgIDUgKwog
a2V4ZWMvYXJjaC94ODZfNjQva2V4ZWMtZWxmLXJlbC14ODZfNjQuYyB8ICAgIDUgKwoga2V4ZWMv
a2V4ZWMtZWxmLWV4ZWMuYyAgICAgICAgICAgICAgICAgICB8ICAgIDQgKwoga2V4ZWMva2V4ZWMt
ZWxmLXJlbC5jICAgICAgICAgICAgICAgICAgICB8ICAgMTcgKysrCiBrZXhlYy9rZXhlYy1lbGYu
aCAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMyArCiAxOSBmaWxlcyBjaGFuZ2VkLCAyMDgg
aW5zZXJ0aW9ucygrKSwgMTQ0IGRlbGV0aW9ucygtKQoKLS0gCjEuNy4xMC40CgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
