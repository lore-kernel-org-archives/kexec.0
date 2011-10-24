Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qy0-f170.google.com ([209.85.216.170])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RIMND-0003Ud-Bw
	for kexec@lists.infradead.org; Mon, 24 Oct 2011 15:23:36 +0000
Received: by qyk32 with SMTP id 32so2130653qyk.15
	for <kexec@lists.infradead.org>; Mon, 24 Oct 2011 08:23:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <m1ipneifqv.fsf@fess.ebiederm.org>
References: <1319468137.3615.16.camel@br98xy6r>
	<m1ipneifqv.fsf@fess.ebiederm.org>
Date: Mon, 24 Oct 2011 23:23:33 +0800
Message-ID: <CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
Subject: Re: kdump: crash_kexec()-smp_send_stop() race in panic
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org, holzheu@linux.vnet.ibm.com, Vivek Goyal <vgoyal@redhat.com>

T24gTW9uLCBPY3QgMjQsIDIwMTEgYXQgMTE6MTQgUE0sIEVyaWMgVy4gQmllZGVybWFuCjxlYmll
ZGVybUB4bWlzc2lvbi5jb20+IHdyb3RlOgo+IE1pY2hhZWwgSG9semhldSA8aG9semhldUBsaW51
eC52bmV0LmlibS5jb20+IHdyaXRlczoKPgo+PiBIZWxsbyBWaXZlaywKPj4KPj4gSW4gb3VyIHRl
c3RzIHdlIHJhbiBpbnRvIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW86Cj4+Cj4+IFR3byBDUFVzIGhh
dmUgY2FsbGVkIHBhbmljIGF0IHRoZSBzYW1lIHRpbWUuIFRoZSBmaXJzdCBDUFUgY2FsbGVkCj4+
IGNyYXNoX2tleGVjKCkgYW5kIHRoZSBzZWNvbmQgQ1BVIGNhbGxlZCBzbXBfc2VuZF9zdG9wKCkg
aW4gcGFuaWMoKQo+PiBiZWZvcmUgY3Jhc2hfa2V4ZWMoKSBmaW5pc2hlZCBvbiB0aGUgZmlyc3Qg
Q1BVLiBTbyB0aGUgc2Vjb25kIENQVQo+PiBzdG9wcGVkIHRoZSBmaXJzdCBDUFUgYW5kIHRoZXJl
Zm9yZSBrZHVtcCBmYWlsZWQuCj4+Cj4+IDFzdCBDUFU6Cj4+IHBhbmljKCktPmNyYXNoX2tleGVj
KCktPm11dGV4X3RyeWxvY2soJmtleGVjX211dGV4KS0+IGRvIGtkdW1wCj4+Cj4+IDJuZCBDUFU6
Cj4+IHBhbmljKCktPmNyYXNoX2tleGVjKCktPmtleGVjX211dGV4IGFscmVhZHkgaGVsZCBieSAx
c3QgQ1BVCj4+IMKgIMKgIMKgIMKgLT5zbXBfc2VuZF9zdG9wKCktPiBzdG9wIENQVSAxIChzdG9w
IGtkdW1wKQo+Pgo+PiBIb3cgc2hvdWxkIHdlIGZpeCB0aGlzIHByb2JsZW0/IE9uZSBwb3NzaWJp
bGl0eSBjb3VsZCBiZSB0byBkbwo+PiBzbXBfc2VuZF9zdG9wKCkgYmVmb3JlIHdlIGNhbGwgY3Jh
c2hfa2V4ZWMoKS4KPj4KPj4gV2hhdCBkbyB5b3UgdGhpbms/Cj4KPiBzbXBfc2VuZF9zdG9wIGlz
IGluc3VmZmljaWVudGx5IHJlbGlhYmxlIHRvIGJlIHVzZWQgYmVmb3JlIGNyYXNoX2tleGVjLgo+
Cj4gTXkgZmlyc3QgcmVhY3Rpb24gd291bGQgYmUgdG8gdGVzdCBvb3BzX2luX3Byb2dyZXNzIGFu
ZCB3YWl0IHVudGlsCj4gb29wc19pbl9wcm9ncmVzcyA9PSAxIGJlZm9yZSBjYWxsaW5nIHNtcF9z
ZW5kX3N0b3AuCj4KCisxCgpPbmUgb2YgbXkgY29sbGVhZ3VlIG1lbnRpb25lZCB0aGUgc2FtZSBw
cm9ibGVtIHdpdGggbWUgaW5zaWRlClJILCBnaXZlbiB0aGUgZmFjdCB0aGF0IHRoZSByYWNlIGNv
bmRpdGlvbiB3aW5kb3cgaXMgc21hbGwsIGl0IHdvdWxkCm5vdCBiZSBlYXN5IHRvIHJlcHJvZHVj
ZSB0aGlzIHNjZW5hcmlvLgoKVGhhbmtzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
