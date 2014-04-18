Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wb9UM-0004BC-Qj
 for kexec@lists.infradead.org; Fri, 18 Apr 2014 14:09:59 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <clg@fr.ibm.com>;
 Fri, 18 Apr 2014 15:09:35 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id E63B91B0806E
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 15:09:35 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3IE9WJE60621042
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 14:09:32 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3IE9W4d029002
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 08:09:32 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
Subject: [PATCH 6/7] ppc64, cleanup: fix implicit declaration compile warnings
Date: Fri, 18 Apr 2014 16:08:39 +0200
Message-Id: <1397830120-13323-7-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1397830120-13323-1-git-send-email-clg@fr.ibm.com>
References: <1397830120-13323-1-git-send-email-clg@fr.ibm.com>
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

Li4va2V4ZWMvYXJjaC9wcGM2NC9rZXhlYy1wcGM2NC5jOiBJbiBmdW5jdGlvbiDigJhnZXRfZGV2
dHJlZV9kZXRhaWxz4oCZOgouLi9rZXhlYy9hcmNoL3BwYzY0L2tleGVjLXBwYzY0LmM6NDE0OjU6
IHdhcm5pbmc6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHJlc2VydmXigJkg
Wy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgcmVzZXJ2ZShLRFVNUF9CQUNL
VVBfTElNSVQsIGNyYXNoX2Jhc2UtS0RVTVBfQkFDS1VQX0xJTUlUKTsKICAgICBeCi4uL2tleGVj
L2FyY2gvcHBjNjQvY3Jhc2hkdW1wLXBwYzY0LmM6IEluIGZ1bmN0aW9uIOKAmGxvYWRfY3Jhc2hk
dW1wX3NlZ21lbnRz4oCZOgouLi9rZXhlYy9hcmNoL3BwYzY0L2NyYXNoZHVtcC1wcGM2NC5jOjM5
MToyOiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhyZXNlcnZl
4oCZIFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIHJlc2VydmUoaW5mby0+YmFj
a3VwX3N0YXJ0LCBzeik7CiAgXgoKU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0Bmci5pYm0uY29tPgotLS0KIGtleGVjL2FyY2gvcHBjNjQvY3Jhc2hkdW1wLXBwYzY0LmMgfCAg
ICAxICsKIGtleGVjL2FyY2gvcHBjNjQva2V4ZWMtcHBjNjQuYyAgICAgfCAgICAxICsKIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEva2V4ZWMvYXJjaC9wcGM2
NC9jcmFzaGR1bXAtcHBjNjQuYyBiL2tleGVjL2FyY2gvcHBjNjQvY3Jhc2hkdW1wLXBwYzY0LmMK
aW5kZXggYzBkNTc1ZDg3YmUwLi43MWEwOWRiZmYxN2YgMTAwNjQ0Ci0tLSBhL2tleGVjL2FyY2gv
cHBjNjQvY3Jhc2hkdW1wLXBwYzY0LmMKKysrIGIva2V4ZWMvYXJjaC9wcGM2NC9jcmFzaGR1bXAt
cHBjNjQuYwpAQCAtMzQsNiArMzQsNyBAQAogI2luY2x1ZGUgIi4uLy4uL2NyYXNoZHVtcC5oIgog
I2luY2x1ZGUgImtleGVjLXBwYzY0LmgiCiAjaW5jbHVkZSAiY3Jhc2hkdW1wLXBwYzY0LmgiCisj
aW5jbHVkZSAiLi4vLi4vZnMyZHQuaCIKIAogc3RhdGljIHN0cnVjdCBjcmFzaF9lbGZfaW5mbyBl
bGZfaW5mbzY0ID0KIHsKZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvcHBjNjQva2V4ZWMtcHBjNjQu
YyBiL2tleGVjL2FyY2gvcHBjNjQva2V4ZWMtcHBjNjQuYwppbmRleCA0OWIyOTFkMWU5ODYuLmY2
NGI4MzNiNjY1YiAxMDA2NDQKLS0tIGEva2V4ZWMvYXJjaC9wcGM2NC9rZXhlYy1wcGM2NC5jCisr
KyBiL2tleGVjL2FyY2gvcHBjNjQva2V4ZWMtcHBjNjQuYwpAQCAtMzMsNiArMzMsNyBAQAogI2lu
Y2x1ZGUgImtleGVjLXBwYzY0LmgiCiAjaW5jbHVkZSAiY3Jhc2hkdW1wLXBwYzY0LmgiCiAjaW5j
bHVkZSA8YXJjaC9vcHRpb25zLmg+CisjaW5jbHVkZSAiLi4vLi4vZnMyZHQuaCIKIAogc3RhdGlj
IHN0cnVjdCBtZW1vcnlfcmFuZ2UgKmV4Y2x1ZGVfcmFuZ2UgPSBOVUxMOwogc3RhdGljIHN0cnVj
dCBtZW1vcnlfcmFuZ2UgKm1lbW9yeV9yYW5nZSA9IE5VTEw7Ci0tIAoxLjcuMTAuNAoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
