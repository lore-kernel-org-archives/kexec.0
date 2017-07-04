Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dSDLS-0007y4-R8
 for kexec@lists.infradead.org; Tue, 04 Jul 2017 02:13:44 +0000
Received: by mail-pf0-x241.google.com with SMTP id s66so27576867pfs.2
 for <kexec@lists.infradead.org>; Mon, 03 Jul 2017 19:13:22 -0700 (PDT)
Message-ID: <1499134144.1734.41.camel@gmail.com>
Subject: Re: [PATCH] kexec:arm: support zImage with appended device tree
From: Hoeun Ryu <hoeun.ryu@gmail.com>
Date: Tue, 04 Jul 2017 11:09:04 +0900
In-Reply-To: <20170703164109.GJ22756@flint.armlinux.org.uk>
References: <1498208138-19283-1-git-send-email-hoeun.ryu@gmail.com>
 <20170626091412.GE837@flint.armlinux.org.uk>
 <1498531003.1734.13.camel@gmail.com>
 <20170627085359.GH837@flint.armlinux.org.uk>
 <BA3D72AC-402C-4148-B49A-560720267961@gmail.com>
 <20170703164109.GJ22756@flint.armlinux.org.uk>
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
To: Russell King <rmk@armlinux.org.uk>
Cc: Matthew Leach <matthew.leach@arm.com>, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Wang Nan <wangnan0@huawei.com>

T24gTW9uLCAyMDE3LTA3LTAzIGF0IDE3OjQxICswMTAwLCBSdXNzZWxsIEtpbmcgd3JvdGU6Cj4g
T24gVHVlLCBKdW4gMjcsIDIwMTcgYXQgMDY6NTE6NTBQTSArMDkwMCwgSG9ldW4gUnl1IHdyb3Rl
Ogo+ID4gCj4gPiA+IAo+ID4gPiBXaGF0IGFib3V0IHRoZSBpbml0cmQ/wqDCoERvIHlvdSB3YW50
IHRvIGFwcGVuZCB0aGF0IGFzIHdlbGw/Cj4gPiBJIGhhdmUgdGhvdWdodCBvZiBpdC4KPiA+IEkg
dGhpbmsgSXQgd291bGQgYmUgYmV0dGVyIHRvIGhhdmUgaXQuCj4gPiBCdXQgSSB0aGluayB0aGlz
IGlzIHRoZSBmaXJzdCBzdGVwIHRvIGRvIHNvLgo+IFRoYXQgaXMgc29tZXRoaW5nIHdlIGRvbid0
IHN1cHBvcnQgd2l0aCB0aGUga2VybmVsLCBhbmQgd291bGQgYmUKPiBpbnNhbmUKPiB0byBkbyBz
byAtIGl0IHdvdWxkIG1lYW4gdGhhdCB0aGUgdmVyeSBkdW1iIGRlY29tcHJlc3NvciB3b3VsZCBo
YXZlCj4gdG8gcmVsb2NhdGUgbm90IG9ubHkgdGhlIGR0YiBpbWFnZSwgYnV0IGFsc28gdGhlIGlu
aXRyZCBpbWFnZSB0bwo+IHNvbWUgb3RoZXIgcGFydCBvZiBtZW1vcnkuwqDCoEl0IG1vdmVzIHRo
ZSBhcHBlbmRlZCBkdGIgaW1hZ2UgYWxvbmcKPiB3aXRoCj4gdGhlIHJlc3Qgb2YgdGhlIHpJbWFn
ZSBhcyBvbmUgY29tcGxldGUgYmxvYiwgYnV0IHRoYXQgZG9lc24ndCB3b3JrCj4gc28gd2VsbCBm
b3IgYW4gYXBwZW5kZWQgaW5pdHJkLsKgwqBJdCB3aWxsIGFsc28gYmUgcmF0aGVyIHNsb3cuCj4g
Cj4gU28gSSdkIGxpa2UgdG8gY29udGludWUgbXkgZGlzY291cmFnZW1lbnQgb2YgdGhpcyBlbnRp
cmUgYXBwcm9hY2ggYW5kCj4gc2F5IHRoYXQga2V4ZWMtdG9vbHMgc2hvdWxkICpub3QqIGFkZCBz
dXBwb3J0IGZvciBhbiBhcHBlbmRlZCBEVEIgbm9yCj4gYW4gYXBwZW5kZWQgaW5pdHJkLgo+IAo+
IFRoZSBrZXJuZWwgYnVpbGQgcHJvY2VzcyBnaXZlcyB5b3UgdGhlIGtlcm5lbCBpbWFnZSBhbmQg
ZHRiIGZpbGUuCj4gVGhlIGFwcGVuZGVkLWR0YiBpbWFnZSBzdXBwb3J0IHRoYXQgd2UgaGF2ZSBp
biB0aGUga2VybmVsIGlzIGZvcgo+IGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHdpdGggbm9uLURU
IGF3YXJlIGJvb3QgbG9hZGVycyB0aGF0IG9ubHkKPiBrbm93IGhvdyB0byBkZWFsIHdpdGggb25l
IG9yIHR3byBpbWFnZXMgYXQgYm9vdCB0aW1lLgo+IAoKSSB1bmRlcnN0YW5kIGFuZCByZXNwZWN0
IHlvdXIgb3Bpbmlvbi4KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
