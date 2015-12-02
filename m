Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a421t-0001yH-Fm
 for kexec@lists.infradead.org; Wed, 02 Dec 2015 07:40:46 +0000
Message-ID: <565E9FFE.20501@cn.fujitsu.com>
Date: Wed, 2 Dec 2015 15:38:38 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 00/11] makedumpfile: parallel processing
References: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <5575123D.8090506@cn.fujitsu.com>
 <1831406384.24254782.1448959169018.JavaMail.zimbra@redhat.com>
 <565E81A7.4080604@cn.fujitsu.com>
 <20151202072443.GD2899@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20151202072443.GD2899@dhcp-128-65.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: Chao Fan <cfan@redhat.com>, Shaohui Deng <shdeng@redhat.com>, kexec@lists.infradead.org

T24gMTIvMDIvMjAxNSAwMzoyNCBQTSwgRGF2ZSBZb3VuZyB3cm90ZToKPiBIaSwKPgo+IE9uIDEy
LzAyLzE1IGF0IDAxOjI5cG0sICJaaG91LCBXZW5qaWFuL+WRqOaWh+WJkSIgd3JvdGU6Cj4+IEkg
dGhpbmsgdGhlcmUgaXMgbm8gcHJvYmxlbSBpZiBvdGhlciB0ZXN0IHJlc3VsdHMgYXJlIGFzIGV4
cGVjdGVkLgo+Pgo+PiAtLW51bS10aHJlYWRzIG1haW5seSByZWR1Y2VzIHRoZSB0aW1lIG9mIGNv
bXByZXNzaW5nLgo+PiBTbyBmb3IgbHpvLCBpdCBjYW4ndCBkbyBtdWNoIGhlbHAgYXQgbW9zdCBv
ZiB0aW1lLgo+Cj4gU2VlbXMgdGhlIGhlbHAgb2YgLS1udW0tdGhyZWFkcyBkb2VzIG5vdCBzYXkg
aXQgZXhhY3RseToKPgo+ICAgIFstLW51bS10aHJlYWRzIFRIUkVBRE5VTV06Cj4gICAgICAgIFVz
aW5nIG11bHRpcGxlIHRocmVhZHMgdG8gcmVhZCBhbmQgY29tcHJlc3MgZGF0YSBvZiBlYWNoIHBh
Z2UgaW4gcGFyYWxsZWwuCj4gICAgICAgIEFuZCBpdCB3aWxsIHJlZHVjZXMgdGltZSBmb3Igc2F2
aW5nIERVTVBGSUxFLgo+ICAgICAgICBUaGlzIGZlYXR1cmUgb25seSBzdXBwb3J0cyBjcmVhdGlu
ZyBEVU1QRklMRSBpbiBrZHVtcC1jb21yZXNzZWQgZm9ybWF0IGZyb20KPiAgICAgICAgVk1DT1JF
IGluIGtkdW1wLWNvbXByZXNzZWQgZm9ybWF0IG9yIGVsZiBmb3JtYXQuCj4KPiBMem8gaXMgYWxz
byBhIGNvbXByZXNzIG1ldGhvZCwgaXQgc2hvdWxkIGJlIG1lbnRpb25lZCB0aGF0IC0tbnVtLXRo
cmVhZHMgb25seQo+IHN1cHBvcnRzIHpsaWIgY29tcHJlc3NlZCB2bWNvcmUuCj4KClNvcnJ5LCBp
dCBzZWVtcyB0aGF0IHNvbWV0aGluZyBJIHNhaWQgaXMgbm90IHNvIGNsZWFyLgpsem8gaXMgYWxz
byBzdXBwb3J0ZWQuIFNpbmNlIGx6byBjb21wcmVzc2VzIGRhdGEgYXQgYSBoaWdoIHNwZWVkLCB0
aGUKaW1wcm92aW5nIG9mIHRoZSBwZXJmb3JtYW5jZSBpcyBub3Qgc28gb2J2aW91cyBhdCBtb3N0
IG9mIHRpbWUuCgo+IEFsc28gd29ydGggdG8gbWVudGlvbiBhYm91dCB0aGUgcmVjb21tZW5kZWQg
LWQgdmFsdWUgZm9yIHRoaXMgZmVhdHVyZS4KPgoKWWVzLCBJIHRoaW5rIGl0J3Mgd29ydGguIEkg
Zm9yZ290IGl0LgoKLS0gClRoYW5rcwpaaG91CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
