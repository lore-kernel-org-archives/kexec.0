Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Ra2BW-0000rt-Il
 for kexec@lists.infradead.org; Mon, 12 Dec 2011 09:28:35 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
 (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBC9SWXl030396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 12 Dec 2011 04:28:32 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
 by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id
 pBC9SWjf001340
 for <kexec@lists.infradead.org>; Mon, 12 Dec 2011 04:28:32 -0500
Received: from darkstar.nay.redhat.com (wlan-5-111.nay.redhat.com
 [10.66.12.111] (may be forged))
 by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id pBC9SUaH010563
 for <kexec@lists.infradead.org>; Mon, 12 Dec 2011 04:28:31 -0500
Date: Mon, 12 Dec 2011 17:30:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: build fix: use __func__ instead of __function__
Message-ID: <20111212093045.GA20934@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

QmVsb3cgYnVpbGQgZmFpbHVyZSBoYXBwZW5zOgprZXhlYy9jcmFzaGR1bXAuYzogSW4gZnVuY3Rp
b24g4oCYZ2V0X2NyYXNoX25vdGVzX3Blcl9jcHXigJk6CmtleGVjL2NyYXNoZHVtcC5jOjEwNjog
ZXJyb3I6IOKAmF9fZnVuY3Rpb25fX+KAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBm
dW5jdGlvbikKa2V4ZWMvY3Jhc2hkdW1wLmM6MTA2OiBlcnJvcjogKEVhY2ggdW5kZWNsYXJlZCBp
ZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZQprZXhlYy9jcmFzaGR1bXAuYzoxMDY6IGVy
cm9yOiBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluLikKbWFrZTogKioqIFtrZXhlYy9j
cmFzaGR1bXAub10gRXJyb3IgMQoKY2hhbmdlIHRvIHVzZSBfX2Z1bmNfXyBpbnN0ZWFkIG9mIF9f
ZnVuY3Rpb24gdG8gZml4IHRoaXMgaXNzdWUuCi0tLQoga2V4ZWMvY3Jhc2hkdW1wLmMgfCAgICAy
ICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9rZXhlYy9jcmFzaGR1bXAuYyBiL2tleGVjL2NyYXNoZHVtcC5jCmluZGV4IGU3
YWM0MmMuLmRiNGEzMWUgMTAwNjQ0Ci0tLSBhL2tleGVjL2NyYXNoZHVtcC5jCisrKyBiL2tleGVj
L2NyYXNoZHVtcC5jCkBAIC0xMDMsNyArMTAzLDcgQEAgaW50IGdldF9jcmFzaF9ub3Rlc19wZXJf
Y3B1KGludCBjcHUsIHVpbnQ2NF90ICphZGRyLCB1aW50NjRfdCAqbGVuKQogCSphZGRyID0gKHVp
bnQ2NF90KSB0ZW1wOwogCSpsZW4gPSBNQVhfTk9URV9CWVRFUzsgLyogd2Ugc2hvdWxkIGdldCB0
aGlzIGZyb20gdGhlIGtlcm5lbCBpbnN0ZWFkICovCiAjaWZkZWYgREVCVUcKLQlwcmludGYoIiVz
OiBjcmFzaF9ub3RlcyBhZGRyID0gJUx4XG4iLCBfX2Z1bmN0aW9uX18sICphZGRyKTsKKwlwcmlu
dGYoIiVzOiBjcmFzaF9ub3RlcyBhZGRyID0gJUx4XG4iLCBfX2Z1bmNfXywgKmFkZHIpOwogI2Vu
ZGlmCiAKIAlmY2xvc2UoZnApOwotLSAKMS43LjQuNAoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
