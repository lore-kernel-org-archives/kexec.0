Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHvHQ-0008ID-Pq
 for kexec@lists.infradead.org; Wed, 11 Apr 2012 11:00:05 +0000
Message-ID: <4F856422.6010904@cn.fujitsu.com>
Date: Wed, 11 Apr 2012 18:59:46 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F84E0DF.8040206@cn.fujitsu.com> <20120411102136.GG2428@amd.com>
In-Reply-To: <20120411102136.GG2428@amd.com>
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
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, avi@redhat.com, ebiederm@xmission.com

5LqOIDIwMTLlubQwNOaciDEx5pelIDE4OjIxLCBKb2VyZyBSb2VkZWwg5YaZ6YGTOgo+IEhpLAo+
IAo+IE9uIFdlZCwgQXByIDExLCAyMDEyIGF0IDA5OjM5OjQzQU0gKzA4MDAsIHpoYW5neWFuZmVp
IHdyb3RlOgo+PiBUaGUgcHJvYmxlbSBpcyB0aGF0IFZNQ1MgaW50ZXJuYWwgaXMgaGlkZGVuIGJ5
IEludGVsIGluIGl0cwo+PiBzcGVjaWZpY2F0aW9uLiBTbywgd2UgcmV2ZXJzZSBlbmdpbmVlcmlu
ZyBpdCBpbiB0aGUgd2F5IGltcGxlbWVudGVkIGluCj4+IHRoaXMgcGF0Y2ggc2V0Lgo+IAo+IEhh
dmUgeW91IG1hZGUgc3VyZSB0aGlzIGxheW91dCBpcyB0aGUgc2FtZSBvbiBhbGwgdWFyY2hpdGVj
dHVyZXMgdGhhdAo+IGltcGxtZW50IFZNWD8KPiAKPiAKPiAJSm9lcmcKPiAKClRoZSBsYXlvdXQg
ZGlmZmVycyBmcm9tIGVhY2ggb3RoZXIgaW4gZGlmZmVyZW50IFZNQ1MgcmV2aXNpb24gaWRlbnRp
ZmllcnMuIApUaGUgVk1DUyByZXZpc2lvbiBpZGVudGlmaWVyIGlzIGNvbnRhaW5lZCBhdCB0aGUg
Zmlyc3QgMzIgYml0cyBvZiB0aGUgVk1DUwpyZWdpb24uIEFuZCB0aGUgVk1DUyByZXZpc2lvbiBp
ZGVudGlmaWVycyBtYXkgZGlmZmVyIGZyb20gZGlmZmVyZW50IGFyY2hpdGVjdHVyZXMuCgpmb3Ig
ZXhhbXBsZSwgdGhlcmUgYXJlIHR3byBwcm9jZXNzb3JzIGJlbG93OgpQcm9jZXNzb3IgMTogSW50
ZWwoUikgWGVvbihSKSBDUFUgRTc1NDAgIEAgMi4wMEdIeiB3aXRoIDI0IGNvcmVzClJFVklTSU9O
X0lEPWUKRklFTEQoUElOX0JBU0VEX1ZNX0VYRUNfQ09OVFJPTCk9MDU1NDA1NTAKRklFTEQoQ1BV
X0JBU0VEX1ZNX0VYRUNfQ09OVFJPTCk9MDU0NDA1NDAKRklFTEQoU0VDT05EQVJZX1ZNX0VYRUNf
Q09OVFJPTCk9MDU0YzA1NDgKRklFTEQoVk1fRVhJVF9DT05UUk9MUykgPSAgICAgICAgMDU3YzA1
NzgKRklFTEQoVk1fRU5UUllfQ09OVFJPTFMpPSAgICAgICAgMDU5NDA1OTAKLi4uLi4uCgpQcm9j
ZXNzb3IgMjogSW50ZWwoUikgQ29yZShUTSkyIER1byBDUFUgRTc1MDAgIEAgMi45M0dIegpSRVZJ
U0lPTl9JRD1kCkZJRUxEKFBJTl9CQVNFRF9WTV9FWEVDX0NPTlRST0wpPTAxODQwMTgwCkZJRUxE
KENQVV9CQVNFRF9WTV9FWEVDX0NPTlRST0wpPTAxOTQwMTkwCkZJRUxEKFNFQ09OREFSWV9WTV9F
WEVDX0NPTlRST0wpPTBmZTQwZmUwCkZJRUxEKFZNX0VYSVRfQ09OVFJPTFMpID0gICAgICAgIDAx
ZTQwMWUwCkZJRUxEKFZNX0VOVFJZX0NPTlRST0xTKT0gICAgICAgIDAzMTQwMzEwCgpUaGUgcHVy
cG9zZSB0byBnZXQgdGhlIFZNQ1NJTkZPIG9mIG9uZSBhcmNoaXRlY3R1cmUgaXMgZm9yIGd1ZXN0
IGRlYnVnZ2luZyB0aGF0IHdhcwpydW5uaW5nIG9uIHRoZSBzYW1lIGFyY2hpdGVjdHVyZSwgc28g
dGhlcmUgaXMgbm8gcHJvYmxlbSB0aGUgbGF5b3V0cyBkaWZmZXIgZnJvbSBkaWZmZXJlbnQKYXJj
aGl0ZWN0dXJlcy4KClRoYW5rcwpaaGFuZyBZYW5mZWkKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
