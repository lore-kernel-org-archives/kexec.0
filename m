Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PccMe-00013a-Kb
	for kexec@lists.infradead.org; Tue, 11 Jan 2011 11:26:13 +0000
Message-ID: <4D2C3E4D.3070307@redhat.com>
Date: Tue, 11 Jan 2011 19:26:05 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
Subject: Re: [Patch] kexec_load: check CAP_SYS_MODULE
References: <1294302325-22593-1-git-send-email-amwang@redhat.com>	<m1bp3uifln.fsf@fess.ebiederm.org>	<AANLkTinLhAuSny735kofonAkaqwJvjjDHMUed_r03rVc@mail.gmail.com>	<m1k4igjwzf.fsf@fess.ebiederm.org>	<1294432333.3237.107.camel@localhost.localdomain>	<m18vywh1g7.fsf@fess.ebiederm.org>	<1294447189.3237.132.camel@localhost.localdomain>
	<m1k4ieesky.fsf@fess.ebiederm.org>
In-Reply-To: <m1k4ieesky.fsf@fess.ebiederm.org>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>

5LqOIDIwMTHlubQwMeaciDA55pelIDEwOjA5LCBFcmljIFcuIEJpZWRlcm1hbiDlhpnpgZM6Cj4K
PiBXZSBhcmVuJ3QgZGVhbGluZyB3aXRoIG1vZHVsZXMgSSB0aGluayBDQVBfU1lTX01PRFVMRSBp
cyB0b3RhbGx5Cj4gaXJyZWxldmFudCBpbiB0aGUgY29udGV4dCBvZiBrZXhlYy4KCgpZZWFoLCBh
bHRob3VnaCBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIENBUF9TWVNfTU9EVUxFLCBidXQgaXQK
cmVhbGx5IGNvbmZ1c2VkIG1lIHRvIGFkZCBpdCB0byBrZXhlY19sb2FkKCkgZnJvbSBpdHMgbmFt
ZS4KCj4KPiBJIHRoaW5rIHRvIGFjY29tcGxpc2ggd2hhdCB5b3Ugd2FudCB3ZSBlaXRoZXIgbmVl
ZCBhIHdheSB0byBkaXNhYmxlCj4gc3lzX2tleGVjX2xvYWQgb3IgcG9zc2libHkgYSBuZXcgdmVy
eSB0YXJnZXRlZCBjYXBhYmlsaXR5IGJpdC4KPgo+IFlvdSBhcmUgbWFraW5nIGl0IHNvIHRoYXQg
Z2l2aW5nIHNvbWVvbmUgQ0FQX1NZU19NT0RVTEUgaXMgZ2l2aW5nIG1vcmUKPiB0aGFuIHRoZSBh
YmlsaXR5IHRvIGxvYWQga2VybmVsIG1vZHVsZXMuICBXaGljaCBzZWVtcyBub24taW50dWl0aXZl
IGZyb20KPiBhIHN5c3RlbSBtYW5hZ2VtZW50IHBvaW50IG9mIHZpZXcuCj4KCkhvdyBhYm91dCBD
QVBfU1lTX0tFWEVDPwoKVGhhbmtzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
