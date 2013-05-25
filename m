Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ug9tu-000673-Ir
 for kexec@lists.infradead.org; Sat, 25 May 2013 08:32:31 +0000
Received: by mail-pd0-f174.google.com with SMTP id 3so3145429pdj.33
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 01:32:07 -0700 (PDT)
Message-ID: <51A076FE.3060604@gmail.com>
Date: Sat, 25 May 2013 16:31:58 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524143644.GD18218@redhat.com> <20130524170626.2ac06efe@holzheu>
 <20130524152849.GF18218@redhat.com> <87mwrkatgu.fsf@xmission.com>
 <51A006CF.90105@gmail.com> <87k3mnahkf.fsf@xmission.com>
In-Reply-To: <87k3mnahkf.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

5LqOIDIwMTPlubQwNeaciDI15pelIDExOjAxLCBFcmljIFcuIEJpZWRlcm1hbiDlhpnpgZM6Cj4g
WmhhbmcgWWFuZmVpIDx6aGFuZ3lhbmZlaS55ZXNAZ21haWwuY29tPiB3cml0ZXM6Cj4gCj4+IEhl
bGxvIEVyaWMsCj4+Cj4+PiBUaGUgZnVuY3Rpb24gY29weV9vbGRtZW1fcGFnZSBhbHNvIGNvbmNl
cm5zIG1lLiAgSSBkb24ndCBoYXZlIGEgY2x1ZSB3aHkKPj4+IHdlIGR1cGxpY2F0ZSB0aGF0IGZ1
bmN0aW9uIG9uIGV2ZXJ5IGFyY2hpdGVjdXRyZSBpbiBhIHNsaWdodGx5IGRpZmZlcmVudAo+Pj4g
Zm9ybS4gIFRoZXJlIHNob3VsZCBiZSBlbm91Z2ggYWJzdHJhY3Rpb25zIGluIHRoZSBrZXJuZWwg
dG8gbWFrZSB0aGF0Cj4+PiB1bm5lY2Vzc2FyeS4gIEkgd291bGQgYmUgZ2xhZCB0byBzZWUgdGhh
dCBmdW5jdGlvbiBnbywgYW5kIHJlbW92ZSB0aGUKPj4+IHBvc3NpYmlsaXR5IG9mIGNvbmZ1c2lv
biB0aGF0IGhhcHBlbmVkIG9uIHMzOTAuCj4+Cj4+IFlvdSBtZWFuIHdlIHNob3VsZCBoYXZlIGEg
Y29tbW9uIGNvcHlfb2xkbWVtX3BhZ2UgZm9yIGFsbCBhcmNoaXRlY3R1cmVzPyBBbmQKPj4ganVz
dCBsaWtlIHZpdmVrIHNhaWQgYWJvdmUsIGZvciBzMzkwLCB3ZSBzaG91bGQgcHV0IHRoZSBzd2Fw
IGluZm8gaW4gdGhlIGVsZgo+PiBoZWFkZXJzIGluc3RlYWQgb2YgZG9pbmcgdGhhdCBpbiBjb3B5
X29sZG1lbV9wYWdlLgo+IAo+IEV4YWN0bHkuCj4gCj4gVGhlIHVzZXIgc3BhY2UgY2hhbmdlIGlu
IC9zYmluL2tleGVjIHNob3VsZCBldmVuIGJlIGJhY2t3YXJkcyBjb21wYXRpYmxlCj4gZm9yIHMz
OTAuICBTbyBmaXhpbmcgL3NiaW4va2V4ZWMgc2hvdWxkIHByb2JhYmx5IGNvbWUgZmlyc3QuCj4g
CgpJIGFtIGtpbmQgb2Ygbm90IHN1cmUgYWJvdXQgdGhlICJiYWNrd2FyZHMgY29tcGF0aWJsZSBm
b3IgczM5MCIgeW91IG1lYW50LgoKRm9yIHMzOTAsIGlmIHdlIHB1dCBzd2FwIGluZm8gaW50byB0
aGUgZWxmIGhlYWRlciwgVGhpcyB3aWxsIGNoYW5nZSAvc2Jpbi9rZXhlYy4KQnV0IGF0IHRoaXMg
cG9pbnQsIGNvcHlfb2xkbWVtX3BhZ2UgaXMgc3RpbGwgZG9pbmcgdGhlIHN3YXAgd2hlbiB3ZSB0
cnkgdG8gcmVhZAp0aGUgcGFnZXMgYW1vbmcgWzAgLSBPTERNRU1fU0laRV0gYW5kIFtPTERNRU1f
QkFTRSAtIE9MRE1FTV9CQVNFICsgT0xETUVNX1NJWkVdLgpTbyByZW1vdmluZyB0aGUgc3dhcCBp
biBjb3B5X29sZG1lbV9wYWdlIHNob3VsZCBiZSBkb25lIGF0IHRoZSBzYW1lIHRpbWUuCk5ldyBr
ZXhlYyB3aXRoIG9sZCBrZXJuZWxzIHdvdWxkIGZhaWwgYW5kIG9sZCBrZXhlYyB3aXRoIG5ldyBr
ZXJuZWxzIHdvdWxkIGZhaWwgdG9vLgoKU28gY291bGQgeW91IHBsZWFzZSBleHBsYWluIG1vcmUg
YWJvdXQgdGhlICIiYmFja3dhcmRzIGNvbXBhdGlibGUiLiBBbmQgcGxlYXNlCmNvcnJlY3QgbWUg
aWYgSSBhbSB3cm9uZy4KClRoYW5rcwpaaGFuZwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
