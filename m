Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGebA-0006In-MB
 for kexec@lists.infradead.org; Sat, 05 Oct 2019 07:35:30 +0000
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer
 when SME was active
References: <20190920035326.27212-1-lijiang@redhat.com>
 <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
 <87r241piqg.fsf@x220.int.ebiederm.org>
 <20190928000505.GJ31919@MiWiFi-R3L-srv>
 <875zldp2vj.fsf@x220.int.ebiederm.org> <20190928030910.GA5774@MiWiFi-R3L-srv>
 <87zhimks5j.fsf@x220.int.ebiederm.org>
 <20191001074012.GK31919@MiWiFi-R3L-srv>
From: lijiang <lijiang@redhat.com>
Message-ID: <7e97421d-d9a8-9d57-1aa0-406039f8421d@redhat.com>
Date: Sat, 5 Oct 2019 15:35:07 +0800
MIME-Version: 1.0
In-Reply-To: <20191001074012.GK31919@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

5ZyoIDIwMTnlubQxMOaciDAx5pelIDE1OjQwLCBCYW9xdWFuIEhlIOWGmemBkzoKPiBPbiAwOS8z
MC8xOSBhdCAwNToxNGFtLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90ZToKPj4gQmFvcXVhbiBIZSA8
YmhlQHJlZGhhdC5jb20+IHdyaXRlczoKPj4+PiBuZWVkcyBhIGxpdHRsZSBiZXR0ZXIgZGVzY3Jp
cHRpb24uICBJIGtub3cgaXQgaXMgbm90IGEgbG90IG9uIG1vZGVybgo+Pj4+IHN5c3RlbXMgYnV0
IHJlc2VydmluZyBhbiBleHRyYSAxTSBvZiBtZW1vcnkgdG8gYXZvaWQgaGF2aW5nIHRvIHNwZWNp
YWwKPj4+PiBjYXNlIGl0IGxhdGVyIHNlZW1zIGluIG5lZWQgb2YgY2FsbGluZyBvdXQuCj4+Pj4K
Pj4+PiBJIGhhdmUgYW4gb2xkIHN5c3RlbSBhcm91bmQgdGhhdCBJIHRoaW5rIHRoYXQgNjQwSyBp
cyBhYm91dCAyNSUgb2YKPj4+PiBtZW1vcnkuCj4+Pgo+Pj4gVW5kZXJzdG9vZC4gQmFzaWNhbGx5
IDY0MEsgaXMgd2FzdGVkIGluIHRoaXMgY2FzZS4gQnV0IHdlIG9ubHkgZG8gbGlrZQo+Pj4gdGhp
cyBpbiBTTUUgY2FzZSwgYSBjb25kaXRpb24gY2hlY2tpbmcgaXMgYWRkZWQuIEFuZCBzeXN0ZW0g
d2l0aCBTTUUgaXMKPj4+IHByZXR0eSBuZXcgbW9kZWwsIGl0IG1heSBub3QgaW1wYWN0IHRoZSBv
bGQgc3lzdGVtLgo+Pgo+PiBUaGUgY29uZGl0aW9uYWwgcmVhbGx5IHNob3VsZCBiZSBiYXNlZCBv
biBpZiB3ZSBhcmUgcmVzZXJ2aW5nIG1lbW9yeQo+PiBmb3IgYSBrZHVtcCBrZXJuZWwuICBBS0Eg
aWYgY3Jhc2hfa2VybmVsPVhYWCBpcyBzcGVjaWZpZWQgb24gdGhlIGtlcm5lbAo+PiBjb21tYW5k
IGxpbmUuCj4+Cj4+IEF0IHdoaWNoIHBvaW50IEkgdGhpbmsgaXQgd291bGQgYmUgdmVyeSByZWFz
b25hYmxlIHRvIHVuY29uZGl0aW9uYWxseQo+PiByZXNlcnZlIHRoZSBsb3cgNjQwaywgYW5kIG1h
a2UgdGhlIHdob2xlIHRoaW5nIGEgbm9uLWlzc3VlLiAgVGhpcyB3b3VsZAo+PiBhbGxvdyB0aGUg
a2R1bXAgY29kZSB0byBqdXN0IG5vdCBkbyBhbnl0aGluZyBzcGVjaWFsIGZvciBhbnkgb2YgdGhl
Cj4+IHdlaXJkIHNwZWNpYWwgY2FzZS4KPj4KPj4gSXQgaXNuJ3QgcGVyZmVjdCBiZWNhdXNlIHdl
IG5lZWQgYSBwYWdlIG9yIHNvIHVzZWQgaW4gdGhlIGZpcnN0IGtlcm5lbAo+PiBmb3IgYm9vdHN0
cmFwcGluZyB0aGUgc2Vjb25kYXJ5IGNwdXMsIGJ1dCB0aGF0IHNlZW1zIGxpa2UgdGhlIGxlYXN0
IG9mCj4+IGV2aWxzLiAgRXNwZWNpYWxseSBhcyBubyBvbmUgd2lsbCBETUEgdG8gdGhhdCBtZW1v
cnkuCj4+Cj4+IFNvIHBsZWFzZSBsZXQncyBqdXN0IGNoYW5nZSB3aGF0IG1lbW9yeSB3ZSByZXNl
cnZlIHdoZW4gY3Jhc2hfa2VybmVsIGlzCj4+IHNwZWNpZmllZC4KPiAKPiBZZXMsIG1ha2VzIHNl
bnNlLCB0aGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4KPiAKClNvcnJ5IGZvciB0aGUgZGVsYXkg
YW5kIHRoYW5rcyBmb3IgeW91ciBjb21tZW50LCBFcmljLCBCYW9xdWFuIGFuZCBEYXZlIFlvdW5n
LgoKSSB3aWxsIGltcHJvdmUgcGF0Y2ggbG9nIGFuZCBhZGQgdGhlIGV4dHJhIGNvbmRpdGlvbiBj
cmFzaF9rZXJuZWwuIEkgd2lsbCBwb3N0CnYyIGxhdGVyLgoKVGhhbmtzLgpMaWFuYm8KCj4+Cj4+
Pj4gSG93IHdlIGludGVyYWN0IHdpdGggQklPUyB0YWJsZXMgaW4gdGhlIGZpcnN0IDY0MGsgbmVl
ZHMgc29tZQo+Pj4+IGV4cGxhbmF0aW9uLiAgQm90aCBpbiB0aGUgZmlyc3Qga2VybmVsIGFuZCBp
biB0aGUgY3Jhc2gga2VybmVsLgo+Pj4KPj4+IFllcywgdG90YWxseSBhZ3JlZS4KPj4+Cj4+PiBU
aG9zZSBCSU9TIHRhYmxlcyBoYXZlIGJlZW4gcmVzZXJ2ZWQgYXMgZTgyMCByZXNlcnZlZCByZWdp
b25zIGFuZCB3aWxsCj4+PiBiZSBwYXNzZWQgdG8ga2R1bXAga2VybmVsIGZvciByZXVzaW5nLiBN
ZW1ibG9jayByZXNlcnZlZCA2NDBLIGRvZXNuJ3QKPj4+IG1lYW4gaXQgd2lsbCBjb3ZlciB0aGUg
d2hvbGUgWzAsIDY0MEspIHJlZ2lvbiwgaXQgb25seSBzZWFyY2hlcyBmb3IKPj4+IGF2YWlsYWJs
ZSBzeXN0ZW0gUkFNIGZyb20gbWVtYmxvY2sgYWxsb2NhdG9yLgo+Pgo+PiBDYXJlZnVsIHdpdGgg
dGhhdCBhc3N1bXB0aW9uLiAgTXkgbWVtb3J5IGlzIHRoYXQgdGhlIGU4MjAgbWVtb3J5IG1hcAo+
PiBmcmVxdWVudGx5IGZhaWxzIHRvIGNvdmVyIGFyZWFzIGxpa2UgdGhlIHJlYWwgbW9kZSBpbnRl
cnJ1cHQgZGVzY3JpcHRvcgo+PiB0YWJsZSBhdCBhZGRyZXNzIDAuCj4gCj4gT0ssIHdpbGwgdGhp
bmsgbW9yZSBhYm91dCB0aGlzLiBUaGFua3MuCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
