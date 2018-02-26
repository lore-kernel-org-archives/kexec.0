Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqKW7-0000x2-QU
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 15:16:54 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QF9WvA052353
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 10:16:30 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gck1x4xga-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 10:16:30 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 15:16:27 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 01/11] kexec_file: Silence compile warnings
Date: Mon, 26 Feb 2018 16:16:10 +0100
In-Reply-To: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
References: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <20180226151620.20970-2-prudo@linux.vnet.ibm.com>
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
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

V2hlbiBidWlsZGluZyB0aGUga2VybmVsIHdpdGggQ09ORklHX0tFWEVDX0ZJTEUgZW5hYmxlZCBn
Y2MgcHJpbnRzIGEKY29tcGlsZSB3YXJuaW5nIG11bHRpcGxlIHRpbWVzLgoKSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIDxwYXRoPi9saW51eC9pbml0L2luaXRyYW1mcy5jOjUyNjowOgo8cGF0aD4vaW5j
bHVkZS9saW51eC9rZXhlYy5oOjEyMDo5OiB3YXJuaW5nOiDigJhzdHJ1Y3Qga2ltYWdl4oCZIGRl
Y2xhcmVkIGluc2lkZSBwYXJhbWV0ZXIgbGlzdCBbZW5hYmxlZCBieSBkZWZhdWx0XQogICAgICAg
ICB1bnNpZ25lZCBsb25nIGNtZGxpbmVfbGVuKTsKICAgICAgICAgXgpUaGlzIGlzIGJlY2F1c2Ug
dGhlIHR5cGVkZWZzIGZvciBrZXhlY19maWxlX2xvYWQgdXNlcyBzdHJ1Y3Qga2ltYWdlIGJlZm9y
ZQppdCBpcyBkZWNsYXJlZC4gRml4IHRoaXMgYnkgc2ltcGx5IGZvcndhcmQgZGVjbGFyaW5nIHN0
cnVjdCBraW1hZ2UuCgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwIFJ1ZG8gPHBydWRvQGxpbnV4LnZu
ZXQuaWJtLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L2tleGVjLmggfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rZXhlYy5o
IGIvaW5jbHVkZS9saW51eC9rZXhlYy5oCmluZGV4IGYxNmY2Y2ViMzg3NS4uN2JhZTVlODdiZjBk
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2tleGVjLmgKKysrIGIvaW5jbHVkZS9saW51eC9r
ZXhlYy5oCkBAIC0xMTQsNiArMTE0LDggQEAgc3RydWN0IHB1cmdhdG9yeV9pbmZvIHsKIAl1bnNp
Z25lZCBsb25nIHB1cmdhdG9yeV9sb2FkX2FkZHI7CiB9OwogCitzdHJ1Y3Qga2ltYWdlOworCiB0
eXBlZGVmIGludCAoa2V4ZWNfcHJvYmVfdCkoY29uc3QgY2hhciAqa2VybmVsX2J1ZiwgdW5zaWdu
ZWQgbG9uZyBrZXJuZWxfc2l6ZSk7CiB0eXBlZGVmIHZvaWQgKihrZXhlY19sb2FkX3QpKHN0cnVj
dCBraW1hZ2UgKmltYWdlLCBjaGFyICprZXJuZWxfYnVmLAogCQkJICAgICB1bnNpZ25lZCBsb25n
IGtlcm5lbF9sZW4sIGNoYXIgKmluaXRyZCwKLS0gCjIuMTMuNQoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
