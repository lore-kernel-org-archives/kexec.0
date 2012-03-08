Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv2.oss.ntt.co.jp ([222.151.198.100])
 by bombadil.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S5WOv-0007Xc-9W
 for kexec@lists.infradead.org; Thu, 08 Mar 2012 06:00:34 +0000
Message-ID: <4F584AFC.9070300@oss.ntt.co.jp>
Date: Thu, 08 Mar 2012 15:00:28 +0900
From: =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8=?= <fernando@oss.ntt.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] boot: add early NMI counter
References: <CAE9FiQVPnO8-tuPoio0Wxv=8rjdm2tJbBk3+3ystueyYtZn9BA@mail.gmail.com>
 <20120216172735.GX9751@redhat.com>
 <CAE9FiQVhbAM9vjx-uFcuc0ndsUp0aez9_TsQHStje5G5iwYbag@mail.gmail.com>
 <20120216215603.GH9751@redhat.com> <m1y5s2ku36.fsf@fess.ebiederm.org>
 <m1fwe9bpk2.fsf@fess.ebiederm.org> <20120217195430.GO9751@redhat.com>
 <m1y5s07rn3.fsf@fess.ebiederm.org> <20120220151419.GU9751@redhat.com>
 <m1obss39a4.fsf@fess.ebiederm.org> <20120221135934.GF26998@redhat.com>
 <m1ipip6xe8.fsf@fess.ebiederm.org> <4F573E1C.2060909@oss.ntt.co.jp>
 <4F573E74.5040504@oss.ntt.co.jp> <4F573EF0.1080501@oss.ntt.co.jp>
 <m1399j1ysk.fsf@fess.ebiederm.org>
In-Reply-To: <m1399j1ysk.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Don Zickus <dzickus@redhat.com>, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu, vgoyal@redhat.com

T24gMDMvMDgvMjAxMiAwMTo1MCBQTSwgRXJpYyBXLiBCaWVkZXJtYW4gd3JvdGU6Cj4gRmVybmFu
ZG8gTHVpcyBWw6F6cXVleiBDYW88ZmVybmFuZG9Ab3NzLm50dC5jby5qcD4gIHdyaXRlczoKPgo+
PiBTdWJqZWN0OiBbUEFUQ0hdIGJvb3Q6IGFkZCBlYXJseSBOTUkgY291bnRlcgo+Pgo+PiBGcm9t
OiBGZXJuYW5kbyBMdWlzIFZhenF1ZXogQ2FvPGZlcm5hbmRvQG9zcy5udHQuY28uanA+Cj4+Cj4+
IFdlIGN1cnJlbnRseSBpZ25vcmUgZWFybHkgTk1JcyBidXQgaXQgd291bGQgYmUgbmljZSB0byBi
ZSBhYmxlIHRvCj4+IGtub3cgd2hldGhlciB0aGV5IGFjdHVhbGx5IG9jY3VycmVkLgo+Pgo+PiBU
aGlzIHBhdGNoIGFkZHMgYW4gZWFybHkgTk1JIGNvdW50ZXIgYW5kIGV4cG9ydHMgaXQgdHJvdWdo
Cj4+IC9wcm9jL2ludGVycnVwdHMgd2l0aCB0aGUgbmFtZSBvZiBFTk0gKEVhcmx5IE5NSSkuCj4g
Rm9yIGEgdXNlcnNwYWNlIGludGVyZmFjZSBJIHN1c3BlY3Qgd2UganVzdCB3YW50IHRvIGR1bXAg
dGhlIGNvdW50Cj4gaW50byB0aGUgTk1JIGNvdW50ZXIuCj4KPiBJdCBwcm9iYWJseSBtYWtlcyBz
ZW5zZSB0byBoYXZlIGEgc2VwYXJhdGUgdmFyaWFibGUgaW4gZWFybHkgYm9vdCBsaWtlCj4geW91
IGRvLCBidXQgdGhlbiBhYm91dCB0aGUgdGltZSB3ZSBzZXR1cCB0aGUgbm9ybWFsIE5NSSBoYW5k
bGVyIG1vdmUgdGhlCj4gTk1JIGNvdW50IG92ZXIgYW5kIHBvc3NpYmx5IGRvIHNvbWV0aGluZyBs
aWtlIHJlYm9vdCBpZiB0aGF0IGlzIG91cgo+IHBvbGljeS4KCkkgYW0gZmluZSB3aXRoIGVpdGhl
ciBhcHByb2FjaC4gSSBndWVzcyB0aGF0IGlzIHRoZSB4ODYgbWFpbnRhaW5lcnMnCmNhbGwuIElu
Z28sIFRob21hcywgUGV0ZXIsIHdoYXQgZG8geW91IHRoaW5rPyBTaG91bGQgSSBhZGQgYSBuZXcK
ZW50cnkgdG8gL3Byb2MvaW50ZXJydXB0cyBvciBtb3ZlIG92ZXIgdGhlIGVhcmx5IE5NSSBjb3Vu
dCB0byB0aGUKZXhpc3RpbmcgcGVyLWNwdSBOTUkgY291bnRlcj8KClRoYW5rcywKRmVybmFuZG8K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
