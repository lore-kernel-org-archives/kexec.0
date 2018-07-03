Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1faKXX-0000F8-J3
 for kexec@lists.infradead.org; Tue, 03 Jul 2018 12:36:17 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w63CUXWd143542
 for <kexec@lists.infradead.org>; Tue, 3 Jul 2018 08:36:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k0927rnnq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 03 Jul 2018 08:36:03 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 3 Jul 2018 13:35:59 +0100
Subject: Re: [PATCH v5 1/8] security: define new LSM hook named
 security_kernel_load_data
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 03 Jul 2018 08:35:41 -0400
In-Reply-To: <64f467a5-e907-ee3e-495b-b2c731715037@gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-2-git-send-email-zohar@linux.vnet.ibm.com>
 <64f467a5-e907-ee3e-495b-b2c731715037@gmail.com>
Mime-Version: 1.0
Message-Id: <1530621341.3452.5.camel@linux.vnet.ibm.com>
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
To: J Freyensee <why2jjj.linux@gmail.com>, linux-integrity@vger.kernel.org
Cc: Andres Rodriguez <andresx7@gmail.com>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Casey Schaufler <casey@schaufler-ca.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>

T24gTW9uLCAyMDE4LTA3LTAyIGF0IDExOjQ1IC0wNzAwLCBKIEZyZXllbnNlZSB3cm90ZToKPiAK
PiBPbiA3LzIvMTggNzozNyBBTSwgTWltaSBab2hhciB3cm90ZToKPiA+IERpZmZlcmVudGlhdGUg
YmV0d2VlbiB0aGUga2VybmVsIHJlYWRpbmcgYSBmaWxlIGZyb20gdGhlIGtlcm5lbCBsb2FkaW5n
Cj4gPiBkYXRhIHByb3ZpZGVkIGJ5IHVzZXJzcGFjZS4gIFRoaXMgcGF0Y2ggZGVmaW5lcyBhIG5l
dyBMU00gaG9vayBuYW1lZAo+ID4gc2VjdXJpdHlfa2VybmVsX2xvYWRfZGF0YS4KPiAKPiBJZiB0
aGlzIHBhdGNoIHNlcmllcyBpcyByZS1kb25lLCBjYW4gd2UgdHdlYWsgdGhlIGRlc2NyaXB0aW9u
IGhlcmUgCj4gcGxlYXNlP8KgIEZyb20gd2hhdCBJIHVuZGVyc3Rvb2Qgb2YgdGhlIGNvZGUgaW4g
dGhpcyBwYXRjaCwgSSdkIHR3ZWFrIGl0IGFzOgo+IAo+ICJEaWZmZXJlbnRpYXRlIGJldHdlZW4g
dGhlIGtlcm5lbCByZWFkaW5nIGEgZmlsZSBzcGVjaWZpZWQgYnkgdXNlcnNwYWNlIAo+IGFuZCB0
aGUga2VybmVsIGxvYWRpbmcgYSBibG9jayBvZiBkYXRhIHByb3ZpZGVkIGJ5IHVzZXJzcGFjZS7C
oCBUaGlzIAo+IHBhdGNoIGRlZmluZXMgYSBuZXcgTFNNIGhvb2sgbmFtZWQgc2VjdXJpdHlfa2Vy
bmVsX2xvYWRfZGF0YSgpLiIKPiAKPiAgRnJvbSB0aGUgZGVzY3JpcHRpb24sIEkgZ290IGEgdGFk
IGNvbmZ1c2VkIGlmIHRoZSB0aGUga2VybmVsCj4gcmVhZGluZyBhIGZpbGUgd2FzIGFsc28gcHJv
dmlkZWQgYnkgdXNlcnNwYWNlIChJIGtub3cgaXQgbWF5IGJlIDJuZC0KPiBuYXR1cmUgdG8gcGVv
cGxlIG9uIHRoaXMgbGlzdCwgSSdtIHN0aWxsIGxlYXJuaW5nIHRoaXMga2VybmVsCj4gbW9kdWxl
KS4KCkNvdWxkIHdlIHJlcGxhY2UgImEgYmxvY2sgb2YgZGF0YSBwcm92aWRlZCBieSB1c2Vyc3Bh
Y2UiIHdpdGgganVzdAoiZGF0YSBwcm92aWRlZCBieSB1c2Vyc3BhY2UiPwoKTWltaQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
