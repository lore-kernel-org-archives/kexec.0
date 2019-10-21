Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMdAn-0008Rp-8x
 for kexec@lists.infradead.org; Mon, 21 Oct 2019 19:16:58 +0000
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Makedumpfile help for 5.4.0.rc3 : Arm
From: John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <CACi5LpM9eN7XuFRi-BapvGNSfu8GgDPTi0BRG9WT4E_nJkzwfw@mail.gmail.com>
Date: Mon, 21 Oct 2019 14:16:51 -0500
Message-Id: <B641BD39-6FA8-4382-AA04-D83CDCF5D278@oracle.com>
References: <1C379272-3B10-432C-8A83-8F3008CEE87F@oracle.com>
 <CACi5LpM9eN7XuFRi-BapvGNSfu8GgDPTi0BRG9WT4E_nJkzwfw@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

SGkgQmh1cGVzaAoKPiBPbiBPY3QgMjEsIDIwMTksIGF0IDE6NTMgUE0sIEJodXBlc2ggU2hhcm1h
IDxiaHNoYXJtYUByZWRoYXQuY29tPiB3cm90ZToKPiAKPiBIZWxsbyBKb2huLAo+IAo+IE9uIE1v
biwgT2N0IDIxLCAyMDE5IGF0IDk6MzkgUE0gSm9obiBEb25uZWxseQo+IDxqb2huLnAuZG9ubmVs
bHlAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+IAo+PiAKPj4gCj4+IEhlbGxvLAo+PiAKPj4gCj4+IEth
enVoaXRvIEhhZ2lvIGFza2VkIG1lIHRvIHNoYXJlIG15IHRlc3QgcmVzdWx0cyBvbiB0aGlzIHBh
dGNoIGZvciBtYWtlZHVtcGZpbGUgOgo+PiAKPj4gCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9v
ZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fc291cmNlZm9yZ2UubmV0X3BfbWFrZWR1bXBm
aWxlX2NvZGVfY2lfN2JkYjQ2OGMyYzk5ZGQ3ODBjOWE1MzIxZjkzYzc5Y2JmZGNlMjUyN18mZD1E
d0lDQWcmYz1Sb1AxWXVtQ1hDZ2FXSHZsWllSOFBaaDhCdjdxSXJNVUI2NWVhcElfSm5FJnI9dDJm
UGc5RDg3RjdEOGptMF8zQ0c5eW9pSUtkUmc0cWNfdGhCdzRiek1oYyZtPVVrTHE5cnBSQ0RqN0Rx
S2EtNWRWbHZTN3lNWnhCN2p2TmQ5YUd1dHZFdTAmcz1kOVRMbU9QVk80UEZ0dmNGd1ZPZVpSY01n
MFVPbXkwNFhkZ3p0VnhYV3lnJmU9IAo+PiAKPj4gQW5kIEkgd2FzIHN1Y2Nlc3NmdWxseSBhYmxl
IHRvIGdldCB2bWNvcmUgZHVtcHMgb24gdm1saW51ei01LjMuNiBhbmQgNS40LjAtcmMzIEludGVs
ICggeDg2LTY0KSBrZXJuZWxzLgo+PiAKPj4gSSBhbSBzdGlsbCBoYXZpbmcgZGlmZmljdWx0aWVz
IGdldHRpbmcgdm1jb3JlcyBvbiA1LjQuMC5yYzMgICBBcm0ga2VybmVscyB3aXRoIHRoaXMgdXBk
YXRlIHRvIG1ha2VkdW1wZmlsZS4KPj4gCj4+IEkgZ2V0IHRoaXMgbWVzc2FnZTsKPj4gCj4+IAo+
PiBCdWZmZXIgc2l6ZSBmb3IgdGhlIGN5Y2xpYyBtb2RlOiAzMTQ1NzI4Cj4+IHZhX2JpdHMgICAg
ICA6IDQ3Cj4+IHBhZ2Vfb2Zmc2V0ICA6IGZmZmZjMDAwMDAwMDAwMDAKPj4gY2FsY3VsYXRlX3Bs
YXRfY29uZmlnOiBQQUdFIFNJWkUgMHgxMDAwMCBhbmQgVkEgQml0cyA0NyBub3Qgc3VwcG9ydGVk
Cj4+IGdldF9tYWNoZGVwX2luZm9fYXJtNjQ6IENhbid0IGRldGVybWluZSBwbGF0Zm9ybSBjb25m
aWcgdmFsdWVzCj4+IAo+PiBtYWtlZHVtcGZpbGUgRmFpbGVkLgo+PiAKPj4gCj4+IEFueSBzdWdn
ZXN0aW9ucyB3ZWxjb21lZAo+IAo+IEkgYW0gd29ya2luZyBvbiB0aGUgY2hhbmdlcyBpbiB0aGUg
dm1jb3JlaW5mbyBhZnRlciB0aGUgNTItYml0IFZBCj4gY2hhbmdlcyBmcm9tIFN0ZXZlIHdlcmUg
YWNjZXB0ZWQgaW4gTGludXggNS40LXJjMSAoIlN1cHBvcnQgZm9yIDUyLWJpdAo+IHZpcnR1YWwg
YWRkcmVzc2luZyBpbiBrZXJuZWwgc3BhY2XigJ0pLgoKCiAgIEkgZG9u4oCZdCBzZWUgYSBjb21t
aXQgd2l0aCB0aGlzIHRpdGxlIGluIGxpbnV4LXN0YWJsZSAgOyAgQ291bGQgeW91IGJlIGEgbGl0
dGxlIG1vcmUgc3BlY2lmaWMgd2hhdCBmaWxlICB0aGF0IHdhcyBhcHBsaWVkIHRvID8gIApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
