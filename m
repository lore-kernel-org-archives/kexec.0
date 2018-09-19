Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g2cYV-0008D9-Do
 for kexec@lists.infradead.org; Wed, 19 Sep 2018 13:30:13 +0000
Date: Wed, 19 Sep 2018 15:29:49 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/3 v2] resource: fix an error which walks through iomem
 resources
Message-ID: <20180919132949.GB9122@nazgul.tnic>
References: <20180919125251.8181-1-lijiang@redhat.com>
 <20180919125251.8181-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180919125251.8181-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

T24gV2VkLCBTZXAgMTksIDIwMTggYXQgMDg6NTI6NDlQTSArMDgwMCwgTGlhbmJvIEppYW5nIHdy
b3RlOgoKLi4uCgo+IEluIGZhY3QsIHdlIHNob3VsZCBnZXQgdGhlIHJlc291cmNlIEEgYW5kIEIg
d2hlbiB3ZSB3YWxrIHRocm91Z2ggdGhlCj4gd2hvbGUgdHJlZSwgYnV0IGl0IG9ubHkgZ2V0cyB0
aGUgcmVzb3VyY2UgQSwgdGhlIHJlc291cmNlIEIgaXMgbWlzc2VkLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IExpYW5i
byBKaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPgoKQmVmb3JlIGxvb2tpbmcgYXQgdGhpczogdGhl
IFNPQiBjaGFpbiBvZiBhbGwgdGhyZWUgcGF0Y2hlcyBpcyB3cm9uZy4KSGludDogc2VlIHNlY3Rp
b24gMTIpIGluIERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0Cgot
LSAKUmVnYXJkcy9HcnVzcywKICAgIEJvcmlzLgoKU1VTRSBMaW51eCBHbWJILCBHRjogRmVsaXgg
SW1lbmTDtnJmZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9uLCBIUkIgMjEyODQgKEFH
IE7DvHJuYmVyZykKLS0gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
