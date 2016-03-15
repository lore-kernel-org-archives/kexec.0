Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1afjVN-0001lq-Sw
 for kexec@lists.infradead.org; Tue, 15 Mar 2016 07:35:02 +0000
Date: Tue, 15 Mar 2016 15:38:53 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v4] Improve the performance of --num-threads -d 31
Message-ID: <20160315073853.GA6391@dhcp-128-25.nay.redhat.com>
References: <1457483231-2092-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160315063430.GA12981@dhcp-128-25.nay.redhat.com>
 <56E7B5D9.30303@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56E7B5D9.30303@cn.fujitsu.com>
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
To: =?utf-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?= <zhouwj-fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org

T24gMDMvMTUvMTYgYXQgMDM6MTJwbSwgIlpob3UsIFdlbmppYW4v5ZGo5paH5YmRIiB3cm90ZToK
PiBIZWxsbyBNaW5mZWksCj4gCj4gSSBndWVzcyB0aGUgcmVzdWx0IGlzIGFmZmVjdGVkIGJ5IHRo
ZSBjYWNoZXMuCj4gSG93IGFib3V0IGV4ZWN1dGluZyB0aGUgZm9sbG93aW5nIGNvbW1hbmQgYmVm
b3JlIHJ1bm5pbmcgbWFrZWR1bXBmaWxlIGVhY2ggdGltZT8KPiAjIGVjaG8gMyA+IC9wcm9jL3N5
cy92bS9kcm9wX2NhY2hlcwoKQWxsIG9mIGNhY2hlIHdpbGwgYmUgZHJvcHBlZCBiZWZvcmUgc3Rh
cnRpbmcgbmV3IHRlc3QuIEhtbSwgaXQgaXMKbGltaXRlZCB0byBkZWJ1ZyBpbiBrZHVtcCBrZXJu
ZWwuIEkgd2lsbCB1c2UgInN0cmFjZSIgdG8gZGVidWcgaXQgbGF0ZXIuCgpUaGFua3MKTWluZmVp
Cgo+IAo+IC0tIAo+IFRoYW5rcwo+IFpob3UKPiAKPiBPbiAwMy8xNS8yMDE2IDAyOjM0IFBNLCBN
aW5mZWkgSHVhbmcgd3JvdGU6Cj4gPkhpLCBaaG91Lgo+ID4KPiA+SSBoYXZlIGFwcGxpZWQgdGhp
cyBwYXRjaCBiYXNlIG9uIDEuNS45LiBUaGVyZSBhcmUgc2V2ZXJhbCB0ZXN0Y2FzZXMgSQo+ID5o
YXZlIHRlc3RlZC4KPiA+Cj4gPi0gbWFrZWR1bXBmaWxlIC0tbnVtLXRocmVhZHMgNjQgLWQgMzEK
PiA+ICAgICByZWFsICAgIDBtMC4wMTBzCj4gPiAgICAgdXNlciAgICAwbTAuMDAycwo+ID4gICAg
IHN5cyAwbTAuMDA5cwo+ID4KPiA+LSBtYWtlZHVtcGZpbGUgLS1udW0tdGhyZWFkcyAzMSAtZCAz
MQo+ID4gICAgIHJlYWwgICAgMm00MC45MTVzCj4gPiAgICAgdXNlciAgICAxMG01MC45MDBzCj4g
PiAgICAgc3lzIDIzbTkuNjY0cwo+ID4KPiA+bWFrZWR1bXBmaWxlIC0tbnVtLXRocmVhZHMgMzAg
LWQgMzEKPiA+ICAgICByZWFsICAgIDBtMC4wMDZzCj4gPiAgICAgdXNlciAgICAwbTAuMDAycwo+
ID4gICAgIHN5cyAwbTAuMDA0cwo+ID4KPiA+bWFrZWR1bXBmaWxlIC0tbnVtLXRocmVhZHMgMzIg
LWQgMzEKPiA+ICAgICByZWFsICAgIDBtMC4wMDdzCj4gPiAgICAgdXNlciAgICAwbTAuMDAycwo+
ID4gICAgIHN5cyAwbTAuMDA1cwo+ID4KPiA+LSBtYWtlZHVtcGZpbGUgLS1udW0tdGhyZWFkcyA4
IC1kIDMxCj4gPiAgICAgcmVhbCAgICAybTMyLjY5MnMKPiA+ICAgICB1c2VyICAgIDdtNC42MzBz
Cj4gPiAgICAgc3lzIDJtMC4zNjlzCj4gPgo+ID4tIG1ha2VkdW1wZmlsZSAtLW51bS10aHJlYWRz
IDEgLWQgMzEKPiA+ICAgICByZWFsICAgIDRtNDIuNDIzcwo+ID4gICAgIHVzZXIgICAgN20yNy4x
NTNzCj4gPiAgICAgc3lzIDBtMjIuNDkwcwo+ID4KPiA+LSBtYWtlZHVtcGZpbGUub3JpZyAtZCAz
MQo+ID4gICAgIHJlYWwgICAgNG0xLjI5N3MKPiA+ICAgICB1c2VyICAgIDNtMzkuNjk2cwo+ID4g
ICAgIHN5cyAwbTE1LjIwMHMKPiA+Cj4gPlRoaXMgcGF0Y2ggaGFzIGEgaHVnZSBpbmNyZW1lbnQg
dG8gdGhlIGZpbHRlciBwZXJmb3JtYW5jZSB1bmRlciAzMS4gQnV0Cj4gPml0IGlzIG5vdCBzdGFi
bGUsIHNpbmNlIG1ha2VkdW1wZmlsZSBmYWlscyB0byBkdW1wIHZtY29yZSBpbnRlcm1pdHRlbnRs
eS4KPiA+WW91IGNhbiBmaW5kIHRoZSBhYm92ZSB0ZXN0IHJlc3VsdCwgbWFrZWR1bXBmaWxlIGZh
aWxzIHRvIGR1bXAgdm1jb3JlCj4gPndpdGggb3B0aW9uIC0tbnVtLXRocmVhZHMgNjQsIGFsc28g
aXQgbWF5IG9jY3VyIHdpdGggb3B0aW9uCj4gPi0tbnVtYmVyLXRocmVhZHMgOC4KPiA+Cj4gPlRo
YW5rcwo+ID5NaW5mZWkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
