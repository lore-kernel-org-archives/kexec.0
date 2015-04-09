Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yg1vR-00024t-CB
 for kexec@lists.infradead.org; Thu, 09 Apr 2015 02:10:39 +0000
Date: Thu, 9 Apr 2015 11:10:13 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] configure.ac: Fix failure caused by x32 ABI test
Message-ID: <20150409021013.GA32707@verge.net.au>
References: <1428515338-4374-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1428515338-4374-1-git-send-email-anibal.limon@linux.intel.com>
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
To: =?utf-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Cc: kexec@lists.infradead.org

T24gV2VkLCBBcHIgMDgsIDIwMTUgYXQgMTI6NDg6NThQTSAtMDUwMCwgQW7DrWJhbCBMaW3Ds24g
d3JvdGU6Cj4gV2hlbiB0cnkgdG8gY29tcGlsZSB3aXRoIHpsaWIgZmFpbHMgZHVlIHRvIGNvbmZp
Z3VyZS5hYwo+IGJhZCBleHBhbnNpb24gY2F1c2VkIGJ5IHgzMiBBQkkgdGVzdCB0aGF0IG5lZWRz
IEFDX1BST0dfQ0MKPiBmb3IgdXNlIEFDX0VHUkVQX0NQUC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBB
bsOtYmFsIExpbcOzbiA8YW5pYmFsLmxpbW9uQGxpbnV4LmludGVsLmNvbT4KClRoYW5rcyBmb3Ig
Zm9sbG93aW5nIHVwIG9uIHRoaXMsIGFwcGxpZWQuCgo+IC0tLQo+ICBjb25maWd1cmUuYWMgfCA0
ICstLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPiBpbmRleCAxZWNh
ZGQ1Li5lMGI1Zjc4IDEwMDY0NAo+IC0tLSBhL2NvbmZpZ3VyZS5hYwo+ICsrKyBiL2NvbmZpZ3Vy
ZS5hYwo+IEBAIC04LDYgKzgsNyBAQCBBQ19JTklUKGtleGVjLXRvb2xzLCAyLjAuMTAuZ2l0KQo+
ICBBQ19DT05GSUdfQVVYX0RJUiguL2NvbmZpZykKPiAgQUNfQ09ORklHX0hFQURFUlMoW2luY2x1
ZGUvY29uZmlnLmhdKQo+ICBBQ19MQU5HKEMpCj4gK0FDX1BST0dfQ0MKPiAgCj4gIEFDX0RFRklO
RV9VTlFVT1RFRChQQUNLQUdFX0RBVEUsICJgZGF0ZSAnKyVkICVCICVZJ2AiLAo+ICAJCVtEZWZp
bmUgdG8gdGhlIHJlbGVhc2UgZGF0ZSBvZiB0aGlzIHBhY2thZ2VdKQo+IEBAIC0xMDYsOSArMTA3
LDYgQEAgQUNfQVJHX1dJVEgoW2Jvb2tlXSwKPiAgCj4gIGRubCAtLS1Qcm9ncmFtcwo+ICBkbmwg
VG8gc3BlY2lmeSBhIGRpZmZlcmVudCBjb21waWxlciwganVzdCAnZXhwb3J0IENDPS9wYXRoL3Rv
L2NvbXBpbGVyJwo+IC0KPiAtQUNfUFJPR19DQwo+IC0KPiAgaWYgdGVzdCAiJHtidWlsZH0iICE9
ICIke2hvc3R9IiA7IHRoZW4KPiAgCUFDX0NIRUNLX1BST0dTKEJVSUxEX0NDLCBbJHtidWlsZF9h
bGlhc30tZ2NjICR7YnVpbGR9LWdjYyBnY2NdKQo+ICBlbHNlCj4gLS0gCj4gMS45LjEKPiAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
