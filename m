Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hCTgn-0006Iu-RZ
 for kexec@lists.infradead.org; Fri, 05 Apr 2019 18:35:47 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x35IT1cK077298
 for <kexec@lists.infradead.org>; Fri, 5 Apr 2019 14:35:43 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rpakkcxqw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 05 Apr 2019 14:35:42 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Fri, 5 Apr 2019 19:35:40 +0100
Subject: Re: [PATCH] selftests/kexec: update get_secureboot_mode
From: Mimi Zohar <zohar@linux.ibm.com>
In-Reply-To: <20190405124751.GA26595@dell5510>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
 <1554300369.7309.59.camel@linux.ibm.com> <20190405124751.GA26595@dell5510>
Date: Fri, 05 Apr 2019 14:35:09 -0400
Mime-Version: 1.0
Message-Id: <1554489309.4312.3.camel@linux.ibm.com>
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
To: Petr Vorel <pvorel@suse.cz>
Cc: Shuah Khan <shuah@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, Dave Young <dyoung@redhat.com>

T24gRnJpLCAyMDE5LTA0LTA1IGF0IDE0OjQ3ICswMjAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhp
IE1pbWksCj4gCj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IAo+
IFNvbWUgbWlub3IgY29tbWVudHMgYmVsb3cuCgpUaGFua3MhIMKgIk1pbm9yIiBjaGFuZ2VzIG1h
ZGUuIMKgVGhpcyBhbmQgdGhlIHJlc3Qgb2YgdGhlIHBhdGNoIHNldCBjYW4KYmUgc2VlbiBpbiB0
aGUgI25leHQtaW50ZWdyaXR5IGJyYW5jaC4KCk1pbWkKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
