Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxdUc-00027M-Tn
 for kexec@lists.infradead.org; Mon, 20 Jul 2020 21:38:39 +0000
Message-ID: <1595281097.5055.79.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/12] ima: Fix rule parsing bugs and extend
 KEXEC_CMDLINE rule support
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 20 Jul 2020 17:38:17 -0400
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
Mime-Version: 1.0
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
To: Tyler Hicks <tyhicks@linux.microsoft.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc: Nayna Jain <nayna@linux.ibm.com>, Janne Karhunen <janne.karhunen@gmail.com>, Prakhar Srivastava <prsriva02@gmail.com>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>

W0NjJ2luZyBTYXNoYV0KCk9uIFRodSwgMjAyMC0wNy0wOSBhdCAwMToxOCAtMDUwMCwgVHlsZXIg
SGlja3Mgd3JvdGU6Cgo+IEkgZW52aXNpb24gcGF0Y2hlcyAxLTcgZ29pbmcgdG8gc3RhYmxlLiBU
aGUgc2VyaWVzIGlzIG9yZGVyZWQgaW4gYSB3YXkKPiB0aGF0IGhhcyBhbGwgdGhlIGZpeGVzIHVw
IGZyb250LCBmb2xsb3dlZCBieSBjbGVhbnVwcywgZm9sbG93ZWQgYnkgdGhlCj4gZmVhdHVyZSBw
YXRjaC4gVGhlIGJyZWFrZG93biBvZiBwYXRjaGVzIGxvb2tzIGxpa2Ugc286Cj4gCj4gIE1lbW9y
eSBsZWFrIGZpeGVzOiAxLTMKPiAgUGFyc2VyIHN0cmljdG5lc3MgZml4ZXM6IDQtNwo+ICBDb2Rl
IGNsZWFudXBzIG1hZGUgcG9zc2libGUgYnkgdGhlIGZpeGVzOiA4LTExCj4gIEV4dGVuZCBLRVhF
Q19DTURMSU5FIHJ1bGUgc3VwcG9ydDogMTIKCkkgYWdyZWUgdGhleSBzaG91bGQgYmUgYmFja3Bv
cnRlZCwgYnV0IHRoZXkgZG9uJ3QgYXBwbHkgY2xlYW5seSBiZWZvcmUKbGludXgtNS42LiDCoFRo
ZSBjaGFuZ2VzIGFyZW4ndCB0aGF0IG1ham9yLiDCoFNvbWUgcGF0Y2ggaHVua3MgYXBwbHkKY2xl
YW5seSwgYnV0IHdvbid0IGNvbXBpbGUsIHdoaWxlIG90aGVycyBwYXRjaCBodW5rcyBuZWVkIHRv
IGJlCmRyb3BwZWQgYmFzZWQgb24gd2hlbiB0aGUgZmVhdHVyZSB3YXMgdXBzdHJlYW1lZC4gwqBG
b3IgdGhlc2UgcmVhc29ucywKSSdtIG5vdCBDYydpbmcgc3RhYmxlLgoKRmVhdHVyZSB1cHN0cmVh
bWVkOgotIExTTSBwb2xpY3kgdXBkYXRlOiBsaW51eCA1LjMKLSBrZXkgY29tbWFuZCBsaW5lOiBs
aW51eCA1LjMKLSBibGFja2xpc3Q6IGxpbnV4IDUuNQotIGtleXJpbmdzOiBsaW51eCA1LjYKCkZv
ciBMaW51eCA1LjM6Ci3CoERlcGVuZGVuY3kgb24gYmFja3BvcnRpbmcgY29tbWl0IDQ4M2VjMjZl
ZWQ0MiAoImltYTogaW1hL2xzbSBwb2xpY3kKcnVsZSBsb2FkaW5nIGxvZ2ljIGJ1ZyBmaXhlcyIp
IHRvIGFwcGx5ICLCoGltYTogRnJlZSB0aGUgZW50aXJlIHJ1bGUgaWYKaXQgZmFpbHMgdG8gcGFy
c2UiLgoKTWltaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
