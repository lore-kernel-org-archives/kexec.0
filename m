Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ehb4C-0007pU-Px
 for kexec@lists.infradead.org; Fri, 02 Feb 2018 13:07:47 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w12D6SaI058690
 for <kexec@lists.infradead.org>; Fri, 2 Feb 2018 08:07:26 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fvps4v7fk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 02 Feb 2018 08:07:25 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Fri, 2 Feb 2018 13:07:24 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 01/17] kexec_file: Silence compile warnings
Date: Fri,  2 Feb 2018 14:07:02 +0100
In-Reply-To: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
References: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <20180202130718.35509-2-prudo@linux.vnet.ibm.com>
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
Cc: prudo@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

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
