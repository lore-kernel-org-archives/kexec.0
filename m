Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv1.oss.ntt.co.jp ([222.151.198.98])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hggz8-0000RN-2t
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 08:52:39 -0400
Subject: Re: [PATCH 10/10] Use safe_apic_wait_icr_idle in
	__send_IPI_dest_field - x86_64
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
In-Reply-To: <200704251433.40302.ak@suse.de>
References: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
	<1177501872.17974.56.camel@sebastian.intellilink.co.jp>
	<200704251433.40302.ak@suse.de>
Date: Wed, 25 Apr 2007 21:52:36 +0900
Message-Id: <1177505556.19745.16.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, mbligh@google.com, Keith Owens <kaos@ocs.com.au>, akpm@linux-foundation.org

T24gV2VkLCAyMDA3LTA0LTI1IGF0IDE0OjMzICswMjAwLCBBbmRpIEtsZWVuIHdyb3RlOgo+IE9u
IFdlZG5lc2RheSAyNSBBcHJpbCAyMDA3IDEzOjUxOjEyIEZlcm5hbmRvIEx1aXMgVsOhenF1ZXog
Q2FvIHdyb3RlOgo+ID4gVXNlIHNhZmVfYXBpY193YWl0X2ljcl9pZGxlIHRvIGNoZWNrIElDUiBp
ZGxlIGJpdCBpZiB0aGUgdmVjdG9yIGlzCj4gPiBOTUlfVkVDVE9SIHRvIGF2b2lkIHBvdGVudGlh
bCBoYW5ndXBzIGluIHRoZSBldmVudCBvZiBjcmFzaCB3aGVuIGtkdW1wCj4gPiB0cmllcyB0byBz
dG9wIHRoZSBvdGhlciBDUFVzLgo+IAo+IEJ1dCB3aGF0IGhhcHBlbnMgdGhlbiB3aGVuIHRoaXMg
ZmFpbHM/IFdvbid0IHRoaXMgZ2l2ZSBhbm90aGVyIGhhbmc/Cj4gSGF2ZSB5b3UgdGVzdGVkIHRo
aXM/CkluIGtkdW1wIHRoZSBjcmFzaGluZyBDUFUgKGkuZS4gdGhlIENQVSB0aGF0IGNhbGxlZCBj
cmFzaF9rZXhlYykgaXMgdGhlCm9uZSBpbiBjaGFyZ2Ugb2YgcmVib290aW5nIGludG8gYW5kIGV4
ZWN1dGluZyB0aGUgZHVtcCBjYXB0dXJlIGtlcm5lbC4KQnV0IGJlZm9yZSBkb2luZyB0aGlzIGl0
IGF0dGVtcHRzIHRvIHN0b3AgdGhlIG90aGVyIENQVXMgc2VuZGluZyBhIElQSQp1c2luZyBOTUlf
VkVDVE9SIGFzIHRoZSB2ZWN0b3IuIFRoZSBwcm9ibGVtIGlzIHRoYXQgc29tZXRpbWVzIGRlbGl2
ZXJ5CnNlZW1zIHRvIGZhaWwgYW5kIHRoZSBjcmFzaGluZyBDUFUgZ2V0cyBzdHVjayB3YWl0aW5n
IGZvciB0aGUgSUNSIHN0YXR1cwpiaXQgdG8gYmUgY2xlYXJlZCwgd2hpY2ggd2lsbCBuZXZlciBo
YXBwZW4uIAoKV2l0aCB0aGlzIHBhdGNoLCB3aGVuIHNhZmVfYXBpY193YWl0X2ljcl9pZGxlIHRp
bWVzIG91dCB0aGUgQ1BVIHdpbGwKY29udGludWUgZXhlY3V0aW5nIGFuZCB0cnkgdG8gaGFuZCBv
dmVyIGNvbnRyb2wgdG8gdGhlIGR1bXAgY2FwdHVyZQprZXJuZWwgYXMgdXN1YWwuIEFmdGVyIGFw
cGx5aW5nIHRoaXMgcGF0Y2ggSSBoYXZlIG5vdCBzZWVuIGhhbmdzIGluIHRoZQpyZWJvb3QgcGF0
aCB0byBzZWNvbmQga2VybmVsIHNob3dpbmcgdGhlIHN5bXB0b21zIG1lbnRpb25lZCBiZWZvcmUs
IGJ1dApwZXJoYXBzIEkgYW0ganVzdCBiZWluZyBsdWNreSBhbmQgdGhlcmUgaXMgc29tZXRoaW5n
IGVsc2UgZ29pbmcgb24uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
