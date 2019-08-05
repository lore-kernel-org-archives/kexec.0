Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hucdE-0006PV-Gk
 for kexec@lists.infradead.org; Mon, 05 Aug 2019 13:02:34 +0000
Date: Mon, 5 Aug 2019 15:02:21 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [LKP] [x86/boot] 5b51ae969e: kexec boot failed
Message-ID: <20190805130221.GA18887@zn.tnic>
References: <97f74c86-54bd-f165-ce33-b53ca48ab850@intel.com>
 <20190802093024.GB30710@zn.tnic>
 <0f817336-2d87-2110-13c0-e0a417d70e90@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f817336-2d87-2110-13c0-e0a417d70e90@intel.com>
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
To: "Chen, Rong A" <rong.a.chen@intel.com>
Cc: x86@kernel.org, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, kexec@lists.infradead.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, lkp@01.org

T24gTW9uLCBBdWcgMDUsIDIwMTkgYXQgMDc6NDk6NTRQTSArMDgwMCwgQ2hlbiwgUm9uZyBBIHdy
b3RlOgo+IFdlIHVzZSB0aGUgZm9sbG93aW5nIGNvbW1hbmQgdG8gYm9vdCBhIG5ldyBrZXJuZWw6
Cj4ga2V4ZWMgLS1ub2VmaSAtbCAvb3B0L3Jvb3Rmcy90bXAvcGtnL2xpbnV4L3g4Nl82NC1yaGVs
LTcuNi9nY2MtNy81YjUxYWU5NjllM2Q4YWIwMTM0ZWUzYzk4YTc2OWFkNmQyY2MyZTI0L3ZtbGlu
dXotNS4yLjAtcmMzLTAwMDA0LWc1YjUxYWU5NjllM2Q4YQo+IC0taW5pdHJkPS9vcHQvcm9vdGZz
L3RtcC9pbml0cmQtY29uY2F0ZW5hdGVkCgpBbmQgdGhpcyAiY29uY2F0ZW5hdGVkIiBpbml0cmQs
IGhvdyBkbyB5b3UgZ2VuZXJhdGUgdGhhdD8KCkZXSVcsIHRyeWluZyB0aGlzIGluIGEgdm0gZG9l
c24ndCBzZWVtIHRvIHdvcmsgYmVjYXVzZSBvZiBFRkkgZXZlbiB0aG91Z2gKLS1ub2VmaSBpcyBz
dXBwbGllZCBvbiB0aGUgY21kbGluZToKCiQga2V4ZWMgLS1ub2VmaSAtbCAvbW50L3RtcC9ieklt
YWdlClVua25vd24gdHlwZSAoUmVzZXJ2ZWQpIHdoaWxlIHBhcnNpbmcgL3N5cy9maXJtd2FyZS9t
ZW1tYXAvNS90eXBlLiBQbGVhc2UgcmVwb3J0IHRoaXMgYXMgYnVnLiBVc2luZyBSQU5HRV9SRVNF
UlZFRCBub3cuClVua25vd24gdHlwZSAoUmVzZXJ2ZWQpIHdoaWxlIHBhcnNpbmcgL3N5cy9maXJt
d2FyZS9tZW1tYXAvMS90eXBlLiBQbGVhc2UgcmVwb3J0IHRoaXMgYXMgYnVnLiBVc2luZyBSQU5H
RV9SRVNFUlZFRCBub3cuClVua25vd24gdHlwZSAoUmVzZXJ2ZWQpIHdoaWxlIHBhcnNpbmcgL3N5
cy9maXJtd2FyZS9tZW1tYXAvNi90eXBlLiBQbGVhc2UgcmVwb3J0IHRoaXMgYXMgYnVnLiBVc2lu
ZyBSQU5HRV9SRVNFUlZFRCBub3cuClVua25vd24gdHlwZSAoUmVzZXJ2ZWQpIHdoaWxlIHBhcnNp
bmcgL3N5cy9maXJtd2FyZS9tZW1tYXAvNC90eXBlLiBQbGVhc2UgcmVwb3J0IHRoaXMgYXMgYnVn
LiBVc2luZyBSQU5HRV9SRVNFUlZFRCBub3cuClVua25vd24gdHlwZSAoUmVzZXJ2ZWQpIHdoaWxl
IHBhcnNpbmcgL3N5cy9maXJtd2FyZS9tZW1tYXAvMi90eXBlLiBQbGVhc2UgcmVwb3J0IHRoaXMg
YXMgYnVnLiBVc2luZyBSQU5HRV9SRVNFUlZFRCBub3cuCgpJIG5lZWQgdG8gdHJ5IGl0IG9uIGEg
cmVhbCBib3guCgotLSAKUmVnYXJkcy9HcnVzcywKICAgIEJvcmlzLgoKU1VTRSBMaW51eCBHbWJI
LCBHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBNYXJ5IEhpZ2dpbnMsIFNyaSBSYXNpYWgsIEhSQiAy
MTI4NCAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
