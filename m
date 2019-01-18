Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkJLq-00077j-PH
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 01:53:44 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0I1iUOq066782
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2019 20:53:41 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q35btrk81-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2019 20:53:12 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Fri, 18 Jan 2019 01:53:10 -0000
Subject: Re: [PATCH v3 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 17 Jan 2019 20:52:52 -0500
In-Reply-To: <20190118013530.GA2814@dhcp-128-65.nay.redhat.com>
References: <20190116101654.7288-1-kasong@redhat.com>
 <1547773684.4026.10.camel@linux.ibm.com>
 <20190118013530.GA2814@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1547776372.3982.1.camel@linux.ibm.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: jwboyer@fedoraproject.org, Kairui Song <kasong@redhat.com>, ebiggers@google.com, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

T24gRnJpLCAyMDE5LTAxLTE4IGF0IDA5OjM1ICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IE9u
IDAxLzE3LzE5IGF0IDA4OjA4cG0sIE1pbWkgWm9oYXIgd3JvdGU6Cgo+ID4gSXQncyB0YWtlbiBz
byBsb25nIGZvciBtZSB0byByZXZpZXcvdGVzdCB0aGlzIHBhdGNoIHNldCBkdWUgdG8gYQo+ID4g
cmVncmVzc2lvbiBpbiBzYW5pdHlfY2hlY2tfc2VnbWVudF9saXN0KCksIGludHJvZHVjZWQgc29t
ZXdoZXJlCj4gPiBiZXR3ZWVuIDQuMjAgYW5kIDUuMC4wLXJjMS4gwqBUaGUgc2dlbWVudCBvdmVy
bGFwIHRlc3QgLSAiaWYgKChtZW5kID4KPiA+IHBzdGFydCkgJiYgKG1zdGFydCA8IHBlbmQpKSIg
LSBmYWlscywgcmV0dXJuaW5nIGEgLUVJTlZBTC4KPiA+IAo+ID4gSXMgYW55b25lIGVsc2Ugc2Vl
aW5nIHRoaXM/Cj4gCj4gTWltaSwgc2hvdWxkIGJlIHRoaXMgaXNzdWU/ICBJIGhhdmUgc2VudCBh
IGZpeCBmb3IgdGhhdC4KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgxMjI4MDEx
MjQ3LkdBOTk5OUBkaGNwLTEyOC02NS5uYXkucmVkaGF0LmNvbS8KClRoYW5rcywgdGhhdCByZXNv
bHZlZCB0aGUgcmVncmVzc2lvbi4KCk1pbWkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
