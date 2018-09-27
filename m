Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5MFE-0001WH-Om
 for kexec@lists.infradead.org; Thu, 27 Sep 2018 02:41:38 +0000
Subject: Re: [PATCH 3/4 v7] amd_iommu: remap the device table of IOMMU with
 the memory encryption mask for kdump
References: <20180907081805.368-1-lijiang@redhat.com>
 <20180907081805.368-4-lijiang@redhat.com>
 <20180925120442.wmh6fjpdghxjyvio@8bytes.org>
From: lijiang <lijiang@redhat.com>
Message-ID: <bc9973a2-d3d3-19c2-11ab-3299ad2105c9@redhat.com>
Date: Thu, 27 Sep 2018 10:40:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180925120442.wmh6fjpdghxjyvio@8bytes.org>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: thomas.lendacky@amd.com, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

5ZyoIDIwMTjlubQwOeaciDI15pelIDIwOjA0LCBKb2VyZyBSb2VkZWwg5YaZ6YGTOgo+IE9uIEZy
aSwgU2VwIDA3LCAyMDE4IGF0IDA0OjE4OjA0UE0gKzA4MDAsIExpYW5ibyBKaWFuZyB3cm90ZToK
Pj4gSW4ga2R1bXAga2VybmVsLCBpdCB3aWxsIGNvcHkgdGhlIGRldmljZSB0YWJsZSBvZiBJT01N
VSBmcm9tIHRoZSBvbGQgZGV2aWNlCj4+IHRhYmxlLCB3aGljaCBpcyBlbmNyeXB0ZWQgd2hlbiBT
TUUgaXMgZW5hYmxlZCBpbiB0aGUgZmlyc3Qga2VybmVsLiBTbyB3ZQo+PiBoYXZlIHRvIHJlbWFw
IHRoZSBvbGQgZGV2aWNlIHRhYmxlIHdpdGggdGhlIG1lbW9yeSBlbmNyeXB0aW9uIG1hc2suCj4+
Cj4+IFNpZ25lZC1vZmYtYnk6IExpYW5ibyBKaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPgo+IAo+
IFBsZWFzZSBjaGFuZ2UgdGhlIHN1YmplY3QgdG86Cj4gCj4gCWlvbW11L2FtZDogUmVtYXAgdGhl
IGRldmljZSB0YWJsZSBvZiBJT01NVSB3aXRoIHRoZSBtZW1vcnkgZW5jcnlwdGlvbiBtYXNrIGZv
ciBrZHVtcAo+IAo+IFdpdGggdGhhdCB5b3UgY2FuIGFkZCBteToKPiAKPiBBY2tlZC1ieTogSm9l
cmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+Cj4gCgpUaGFuayB5b3UsIEpvZXJnLgpTb3JyeSBm
b3IgbXkgbGF0ZSByZXBseS4gSSB3aWxsIGNoYW5nZSB0aGUgc3ViamVjdCBhbmQgcmVzZW5kIHRo
aXMgcGF0Y2guCgpUaGFua3MuCkxpYW5ibwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
