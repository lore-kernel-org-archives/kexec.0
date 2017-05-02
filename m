Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d5d4R-0000Lw-Vq
 for kexec@lists.infradead.org; Tue, 02 May 2017 19:02:49 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v42IrqXG026053
 for <kexec@lists.infradead.org>; Tue, 2 May 2017 15:02:26 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a6x8qwbh4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 02 May 2017 15:02:26 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 3 May 2017 05:02:22 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v42J2D817143770
 for <kexec@lists.infradead.org>; Wed, 3 May 2017 05:02:21 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v42J1lwn012171
 for <kexec@lists.infradead.org>; Wed, 3 May 2017 05:01:47 +1000
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 02 May 2017 15:01:22 -0400
In-Reply-To: <13679.1491830392@warthog.procyon.org.uk>
References: <1491568577.4184.97.camel@linux.vnet.ibm.com>
 <1491551180.4184.50.camel@linux.vnet.ibm.com>
 <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <21572.1491548994@warthog.procyon.org.uk>
 <27362.1491556638@warthog.procyon.org.uk>
 <13679.1491830392@warthog.procyon.org.uk>
Mime-Version: 1.0
Message-Id: <1493751682.3680.11.camel@linux.vnet.ibm.com>
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
To: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com, Dave Young <dyoung@redhat.com>

SGkgRGF2aWQsCgpPbiBNb24sIDIwMTctMDQtMTAgYXQgMTQ6MTkgKzAxMDAsIERhdmlkIEhvd2Vs
bHMgd3JvdGU6Cj4gTWltaSBab2hhciA8em9oYXJAbGludXgudm5ldC5pYm0uY29tPiB3cm90ZToK
PiAKPiA+IEZyb20gYW4gSU1BIHBlcnNwZWN0aXZlLCBlaXRoZXIgYSBmaWxlIGhhc2ggb3Igc2ln
bmF0dXJlIGFyZSB2YWxpZCwKPiA+IGJ1dCBmb3IgdGhpcyB1c2FnZSBpdCBtdXN0IGJlIGEgc2ln
bmF0dXJlLgo+IAo+IE5vdCBuZWNlc3NhcmlseS4gIElmIElNQSBjYW4gZ3VhcmFudGVlIHRoYXQg
YSBtb2R1bGUgaXMgdGhlIHNhbWUgYmFzZWQgb24gaXRzCj4gaGFzaCByYXRoZXIgdGhhbiBvbiBh
IGtleSwgSSB3b3VsZCd2ZSB0aG91Z2h0IHRoYXQgc2hvdWxkIGJlIGZpbmUuCgpGaWxlIGhhc2hl
cyBjYW4gYmUgbW9kaWZpZWQgb24gdGhlIHJ1bm5pbmcgc3lzdGVtLCBzbyB0aGV5J3JlIG5vcm1h
bGx5CnVzZWQswqBpbiBjb25qdW5jdGlvbiB3aXRoIEVWTSwgdG8gZGV0ZWN0IG9mZiBsaW5lIG1v
ZGlmaWNhdGlvbiBvZgptdXRhYmxlIGZpbGVzIGFuZCBwcmV2ZW50IHRoZWlyIHVzYWdlLgoKVGhl
c2UgcGF0Y2hlcyBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNy81LzIvNDY1wqBzaG91bGQgcHJv
dmlkZSBzb21lCm9mIHRoZSBtaXNzaW5nIGZ1bmN0aW9uYWxpdHkuCgpNaW1pCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
