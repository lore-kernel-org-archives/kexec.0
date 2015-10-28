Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-x231.google.com ([2a00:1450:400c:c05::231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrNMq-0001kM-DA
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 09:50:05 +0000
Received: by wicll6 with SMTP id ll6so5626610wic.1
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 02:49:42 -0700 (PDT)
From: Louis Bouchard <louis.bouchard@canonical.com>
Subject: Re: makedumpfile-1.5.9: Introduce parallel compression processing.
References: <0910DD04CBD6DE4193FCF86B9C00BE9701DF7CC4@BPXM01GP.gisp.nec.co.jp>
 <56308618.3080908@canonical.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DF7F43@BPXM01GP.gisp.nec.co.jp>
Message-ID: <56309A33.4000201@canonical.com>
Date: Wed, 28 Oct 2015 10:49:39 +0100
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DF7F43@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

SGksCgpMZSAyOC8xMC8yMDE1IDEwOjA3LCBBdHN1c2hpIEt1bWFnYWkgYSDDqWNyaXQgOgo+IEhl
bGxvIExvdWlzLAo+IAo+Pj4gbyBTdXBwb3J0IG5ldyBrZXJuZWxzCj4+PiAgLSBUaGUgc3VwcG9y
dGVkIGtlcm5lbCBpcyB1cGRhdGVkIHRvIDQuMSBpbiB0aGlzIHZlcnNpb24uCj4+PiAgICBBdCBm
aXJzdCBJJ20gZ29pbmcgdG8gZXh0ZW5kIHRoZSBzdXBwb3J0ZWQgdmVyc2lvbiB0byA0LjIsIGJ1
dAo+Pj4gICAgSSBmb3VuZCBhbiBpc3N1ZSB0aGF0IG1ha2VkdW1wZmlsZSBzZWVtcyB0byBleGNs
dWRlIG5lY2Vzc2FyeSBwYWdlcwo+Pj4gICAgYnkgbWlzdGFrZSBvbiBsaW51eCA0LjIuIFdoZW4g
Y3Jhc2gtNy4xLjMgcmVhZHMgdGhhdCBmaWx0ZXJlZCBkdW1wIGZpbGUsCj4+PiAgICB0aGUgZm9s
bG93aW5nIG1lc3NhZ2UgaXMgc2hvd24uCj4+Pgo+Pj4gICAgICAgY3Jhc2g6IHBhZ2UgZXhjbHVk
ZWQ6IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3M6IGYzZmUwMDAwICB0eXBlOiAiZmlsbF90YXNrX3N0
cnVjdCIKPj4+Cj4+PiAgICBUaGlzIHdpbGwgYmUgZml4ZWQgaW4gdGhlIG5leHQgdmVyc2lvbi4K
Pj4KPj4gSGF2ZSB5b3UgZml4ZWQgdGhlIDQuMiBrZXJuZWwgaXNzdWUgYWxyZWFkeSBvciB5b3Ug
aW50ZW5kIHRvIHdvcmsgb24gaXQgaW4gdGhlCj4+IGZ1dHVyZSA/Cj4gCj4gSSBoYXZlbid0IGRv
bmUgYW55dGhpbmcgeWV0LCBJIHdhcyBnb2luZyB0byB3b3JrIGZyb20gbm93Lgo+IAo+PiBCb3Ro
IERlYmlhbiBhbmQgVWJ1bnR1IHJ1biA0LjIga2VybmVsIHNvIGlmIHdhaXRpbmcgZm9yIGEgZml4
IGlzIGFjY2VwdGFibGUgSQo+PiB3b3VsZCByYXRoZXIgYnJpbmcgaW4gYSAxLjUuOSArIHBhdGNo
IHZlcnNpb24uCj4gCj4gU28gaXQgd2lsbCBiZSBoZWxwZnVsIGlmIHlvdSBjYW4gZG8gaXQuCj4g
Cj4gCj4gVGhhbmtzLAo+IEF0c3VzaGkgS3VtYWdhaQo+IAoKVGhhdCBpcyBwZXJmZWN0LiAgSnVz
dCBsZXQgbWUga25vdyBvbmNlIHlvdSBoYXZlIGlkZW50aWZpZWQgYSBmaXggYW5kIEkgd2lsbApp
bmNsdWRlIGl0IGluIHRoZSBuZXcgcGFja2FnZS4KCktpbmQgcmVnYXJkcywKCi4uLkxvdWlzCi0t
IApMb3VpcyBCb3VjaGFyZApTb2Z0d2FyZSBlbmdpbmVlciwgQ2xvdWQgJiBTdXN0YWluaW5nIGVu
Zy4KQ2Fub25pY2FsIEx0ZApVYnVudHUgZGV2ZWxvcGVyICAgICAgICAgICAgICAgICAgICAgICBE
ZWJpYW4gTWFpbnRhaW5lcgpHUEcgOiA0MjlEIDdBM0IgREQwNSBCNkY4IEFGNjMgIEI5QzQgOEIz
RCA4NjdDIDgyM0UgN0E2MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
