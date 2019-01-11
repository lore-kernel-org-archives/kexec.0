Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghzRe-00007Y-RE
 for kexec@lists.infradead.org; Fri, 11 Jan 2019 16:14:08 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0BGDuaC137068
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2019 11:14:03 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pxuy8rm7a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2019 11:14:03 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Fri, 11 Jan 2019 16:14:00 -0000
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 11 Jan 2019 11:13:40 -0500
In-Reply-To: <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1547223220.19931.471.camel@linux.ibm.com>
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
To: Dave Young <dyoung@redhat.com>, Kairui Song <kasong@redhat.com>
Cc: jwboyer@fedoraproject.org, ebiggers@google.com, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

T24gRnJpLCAyMDE5LTAxLTExIGF0IDIxOjQzICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgpbc25p
cF0KCj4gUGVyc29uYWxseSBJIHdvdWxkIGxpa2UgdG8gc2VlIHBsYXRmb3JtIGtleSBzZXBhcmF0
ZWQgZnJvbSBpbnRlZ3JpdHkuCj4gQnV0IGZvciB0aGUga2V4ZWNfZmlsZSBwYXJ0IEkgdGhpbmsg
aXQgaXMgZ29vZCBhdCBsZWFzdCBpdCB3b3JrcyB3aXRoCj4gdGhpcyBmaXguCj4gCj4gQWNrZWQt
Ynk6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPgoKVGhlIG9yaWdpbmFsICJwbGF0Zm9y
bSIga2V5cmluZyBwYXRjaGVzIHRoYXQgTmF5bmEgcG9zdGVkIG11bHRpcGxlCnRpbWVzIHdlcmUg
aW4gdGhlIGNlcnRzIGRpcmVjdG9yeSwgYnV0IG5vYm9keSBjb21tZW50ZWQvcmVzcG9uZGVkLiDC
oFNvCnNoZSByZXdvcmtlZCB0aGUgcGF0Y2hlcywgbW92aW5nIHRoZW0gdG8gdGhlIGludGVncml0
eSBkaXJlY3RvcnkgYW5kCnBvc3RlZCB0aGVtIChjYydpbmcgdGhlIGtleGVjIG1haWxpbmcgbGlz
dCkuIMKgSXQncyBhIGJpdCBsYXRlIHRvIGJlCmFza2luZyB0byBtb3ZlIGl0LCBpc24ndCBpdD8K
Ck1pbWkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
