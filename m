Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fcPfI-0005ou-Ly
 for kexec@lists.infradead.org; Mon, 09 Jul 2018 06:28:54 +0000
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
From: lijiang <lijiang@redhat.com>
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com> <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
Message-ID: <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
Date: Mon, 9 Jul 2018 14:28:11 +0800
MIME-Version: 1.0
In-Reply-To: <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

5ZyoIDIwMTjlubQwN+aciDAz5pelIDE5OjQ0LCBsaWppYW5nIOWGmemBkzoKPiDlnKggMjAxOOW5
tDA35pyIMDPml6UgMTk6MTQsIEJvcmlzbGF2IFBldGtvdiDlhpnpgZM6Cj4+IE9uIFR1ZSwgSnVs
IDAzLCAyMDE4IGF0IDA2OjU4OjE0UE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+PiBGb3Iga2R1
bXAsIHRoZSBlbGYgaGVhZGVyIGZpbmFsbHkgdXNlIHRoZSBjcmFzaCBrZXJuZWwgcmVzZXJ2ZWQg
bWVtb3J5LCBpdCBpcyBub3QgYW4gb2xkIG1lbW9yeS4KPj4KPj4gTGFtbWUgcmVwZWF0IG15IHN1
Z2dlc3Rpb246Cj4+Cj4+IFNvIGJlZWYgdXAgdGhlIGxvZ2ljIGluIF9faW9yZW1hcF9jYWxsZXIo
KSB0byBmaWd1cmUgb3V0IGJhc2VkIG9uIHRoZQo+PiBhZGRyZXNzIHdoZXRoZXIgdG8gYWNjZXNz
IHRoZSBtZW1vcnkgZW5jcnlwdGVkIG9yIG5vdC4gSW4gZ2VuZXJhbCwgeW91Cj4+IGNhbiBkZWR1
Y2UsIGJhc2VkIG9uIHRoZSByZWdpb24geW91J3JlIG1hcHBpbmcsIHdoZXRoZXIgeW91IG5lZWQg
dG8gbWFwCj4+IGluIGVuY3J5cHRlZCBvciBkZWNyeXB0ZWQuCj4+Cj4+IEZvciBleGFtcGxlOgo+
Pgo+PiAgICAgICAgIGFkZHIgPSBlbGZjb3JlaGRyX2FkZHI7Cj4+Cj4+ICAgICAgICAgLyogUmVh
ZCBFbGYgaGVhZGVyICovCj4+ICAgICAgICAgcmMgPSBlbGZjb3JlaGRyX3JlYWQoKGNoYXIgKikm
ZWhkciwgc2l6ZW9mKEVsZjY0X0VoZHIpLCAmYWRkcik7Cj4+ICAgICAgICAgaWYgKHJjIDwgMCkK
Pj4gICAgICAgICAgICAgICAgIHJldHVybiByYzsKPj4KPj4gZWxmY29yZWhkcl9hZGRyIGhhcyB0
aGF0IGVsZmNvcmVoZHIgYWRkcmVzcy4gU28geW91IGNhbiBjaGVjayB3aGljaCBhZGRyZXNzCj4+
IHlvdSdyZSBtYXBwaW5nIGFuZCBkbzoKPj4KPj4gX19pb3JlbWFwX2NhbGxlcjoKPj4KPj4gLi4u
Cj4+IAlwcm90ID0gX19pb3JlbWFwX2NvbXB1dGVfcHJvdCguLi4pOwo+Pgo+PiBhbmQgdGhhdCBf
X2lvcmVtYXBfY29tcHV0ZV9wcm90KCkgZnVuY3Rpb24gd2hpY2ggeW91IHdpbGwgYWRkIHdpbGwg
aGF2ZQo+PiBhbGwgdGhhdCBsb2dpYyB0byBkZXRlcm1pbmUgZW5jcnlwdGVkIG9yIG5vdCBieSBj
b21wYXJpbmcgYWRkcmVzc2VzIGV0Yy4KPj4KPj4gRG9lcyB0aGF0IG1ha2UgbW9yZSBzZW5zZT8K
Pj4KPiBUaGFuayB5b3UsIEJvcmlzLiBHb29kIGlkZWEsIEkgd2lsbCByZXRoaW5rIGFib3V0IHRo
aXMgaXNzdWUgYW5kIHBvc3QgaXQgYWdhaW4uCj4gCkhpLCBCb3JpcwpMYXN0IHdlZWssIEkgaGFk
IHRyaWVkIG1hbnkgd2F5cyB0byBkbyB0aGlzIHdvcmssIGJ1dCBpdCBsb29rcyBsaWtlIHRoYXQg
dGhlIHdheXMgb2YKZGVkdWNpbmcgYWRkcmVzcyBpcyBub3Qgc3VpdGFibGUgdG8gYW5vdGhlciBz
Y2VuYXJpb3MsIHN1Y2ggYXMgbWFwcGluZyBzb21lIGRldmljZXMKbW1pbyBzcGFjZSwgd2hpY2gg
YXJlIHVuZW5jcnlwdGVkLCBhbmQgdGhlIGRldmljZSBtbWlvIHNwYWNlIGlzIG91dHNpZGUga2R1
bXAga2VybmVsCmxpa2UgdGhlIG9sZCBtZW1vcnksIGJ1dCB0aGUgb2xkIG1lbW9yeSBpcyBlbmNy
eXB0ZWQsIHdlIGNhbid0IGZpbmQgdGhlIGdlbmVyYWwgcnVsZXMKdG8gZGVjaWRlIHdoZW4gdG8g
ZW5jcnlwdCBvciBub3QuIFNvIGl0IHNob3VsZCBiZSB0aGUgYmVzdCB3YXkgdGhhdCB0aGUgY2Fs
bGVyIGNhcmUgYWJvdXQKZW5jcnlwdGlvbiBvciBub3QuIFdoYXQgZG8geW91IHRoaW5rPwoKPiBS
ZWdhcmRzLAo+IExpYW5ibwo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
