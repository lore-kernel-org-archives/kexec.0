Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fPvYJ-0002hF-Dc
 for kexec@lists.infradead.org; Mon, 04 Jun 2018 19:54:05 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w54JoLef016251
 for <kexec@lists.infradead.org>; Mon, 4 Jun 2018 15:53:52 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jd9bnecda-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 04 Jun 2018 15:53:51 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Mon, 4 Jun 2018 20:53:49 +0100
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Mon, 04 Jun 2018 15:53:40 -0400
In-Reply-To: <20180604193215.GA13553@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com>
 <20180604193215.GA13553@mail.hallyn.com>
Mime-Version: 1.0
Message-Id: <1528142020.3237.138.camel@linux.vnet.ibm.com>
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
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andres Rodriguez <andresx7@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@kernel.org>, James Morris <james.l.morris@oracle.com>, Jessica Yu <jeyu@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, Paul Moore <paul@paul-moore.com>

T24gTW9uLCAyMDE4LTA2LTA0IGF0IDE0OjMyIC0wNTAwLCBTZXJnZSBFLiBIYWxseW4gd3JvdGU6
Cj4gUXVvdGluZyBNaW1pIFpvaGFyICh6b2hhckBsaW51eC52bmV0LmlibS5jb20pOgo+ID4gT24g
VHVlLCAyMDE4LTA1LTI5IGF0IDE0OjAxIC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOgo+ID4gPiBJ
bnN0ZWFkIG9mIGFkZGluZyB0aGUgc2VjdXJpdHlfa2VybmVsX3JlYWRfZmlsZSBMU00gaG9vayAt
IG9yIGRlZmluaW5nIGEKPiA+ID4gd3JhcHBlciBmb3Igc2VjdXJpdHlfa2VybmVsX3JlYWRfZmls
ZSBMU00gaG9vayBhbmQgYWRkaW5nIGl0LCBvcgo+ID4gPiByZW5hbWluZyB0aGUgZXhpc3Rpbmcg
aG9vayB0byBzZWN1cml0eV9rZXJuZWxfcmVhZF9kYXRhKCkgYW5kIGFkZGluZyBpdAo+ID4gPiAt
IGluIHBsYWNlcyB3aGVyZSB0aGUga2VybmVsIGlzbid0IHJlYWRpbmcgYSBmaWxlLCB0aGlzIHZl
cnNpb24gb2YgdGhlCj4gPiA+IHBhdGNoIHNldCBkZWZpbmVzIGEgbmV3IExTTSBob29rIG5hbWVk
IHNlY3VyaXR5X2tlcm5lbF9sb2FkX2RhdGEoKS4KPiA+ID4gCj4gPiA+IFRoZSBuZXcgTFNNIGhv
b2sgZG9lcyBub3QgcmVwbGFjZSB0aGUgZXhpc3Rpbmcgc2VjdXJpdHlfa2VybmVsX3JlYWRfZmls
ZQo+ID4gPiBMU00gaG9vaywgd2hpY2ggaXMgc3RpbGwgbmVlZGVkLCBidXQgZGVmaW5lcyBhIG5l
dyBMU00gaG9vayBhbGxvd2luZwo+ID4gPiBMU01zIGFuZCBJTUEtYXBwcmFpc2FsIHRoZSBvcHBv
cnR1bml0eSB0byBmYWlsIGxvYWRpbmcgdXNlcnNwYWNlCj4gPiA+IHByb3ZpZGVkIGZpbGUvZGF0
YS4KPiA+ID4gCj4gPiA+IFRoZSBvbmx5IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgdHdvIExTTSBo
b29rcyBpcyB0aGUgTFNNIGhvb2sgbmFtZSBhbmQgYQo+ID4gPiBmaWxlIGRlc2NyaXB0b3IuICBX
aGV0aGVyIHRoaXMgaXMgY2F1c2UgZW5vdWdoIGZvciByZXF1aXJpbmcgYSBuZXcgTFNNCj4gPiA+
IGhvb2ssIGlzIGxlZnQgdG8gdGhlIHNlY3VyaXR5IGNvbW11bml0eS4KPiA+IAo+ID4gUGF1bCBk
b2VzIG5vdCBoYXZlIGEgcHJlZmVyZW5jZSBhcyB0byBhZGRpbmcgYSBuZXcgTFNNIGhvb2sgb3Ig
Y2FsbGluZwo+ID4gdGhlIGV4aXN0aW5nIGhvb2suIMKgRWl0aGVyIHdheSBpcyBmaW5lLCBhcyBs
b25nIGFzIGJvdGggdGhlIG5ldyBhbmQKPiA+IGV4aXN0aW5nIGhvb2tzIGNhbGwgdGhlIGV4aXN0
aW5nIGZ1bmN0aW9uLgo+ID4gCj4gPiBDYXNleSBkaWRuJ3QgbGlrZSB0aGUgaWRlYSBvZiBhIHdy
YXBwZXIuCj4gPiBKYW1lcyBzdWdnZXN0ZWQgcmVuYW1pbmcgdGhlIExTTSBob29rLgo+ID4gCj4g
PiBUaGUgbWFpbnRhaW5lcnMgZm9yIHRoZSBjYWxsZXJzIG9mIHRoZSBMU00gaG9vayBwcmVmZXIg
YSBtZWFuaW5nZnVsCj4gPiBMU00gaG9vayBuYW1lLiDCoFRoZSAibnVsbCIgYXJndW1lbnQgaXMg
bm90IGFzIG11Y2ggb2YgYSBjb25jZXJuLiDCoE9ubHkKPiA+IEVyaWMgc2VlbXMgdG8gYmUgYXNr
aW5nIGZvciBhIHNlcGFyYXRlLCBuZXcgTFNNIGhvb2ssIHdpdGhvdXQgdGhlCj4gPiAibnVsbCIg
YXJndW1lbnQuCj4gPiAKPiA+IFVubGVzcyBzb21lb25lIHJlYWxseSBvYmplY3RzLCB0byBhY2Nv
bW1vZGF0ZSBFcmljIHdlJ2xsIGRlZmluZSBhIG5ldwo+ID4gTFNNIGhvb2sgbmFtZWQgc2VjdXJp
dHlfa2VybmVsX2xvYWRfZGF0YS4gwqBFcmljLCBhcmUgeW91IHBsYW5uaW5nIG9uCj4gCj4gSSdt
IGNvbmZ1c2VkIC0gaXNuJ3QgdGhhdCB3aGF0IHRoaXMgcGF0Y2hzZXQgZGlkPyA6KQoKUmlnaHQu
IMKgSSdtIHRyeWluZyB0byBnZXQgY29uc2Vuc3VzIHdoZXRoZXIgaXQgaXMgbmVlZGVkLgoKPiAK
PiA+IEFjaydpbmcgcGF0Y2hlcyAxICYgMj8KPiA+IAo+ID4gTWltaQo+IC0tCj4gVG8gdW5zdWJz
Y3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGxpbnV4LXNl
Y3VyaXR5LW1vZHVsZSIgaW4KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZn
ZXIua2VybmVsLm9yZwo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5l
bC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbAo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
