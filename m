Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iY9p8-000323-01
 for kexec@lists.infradead.org; Fri, 22 Nov 2019 14:22:19 +0000
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v4 0/4] makedumpfile/arm64: Add support for ARMv8.2
 extensions
From: John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <03F00E44-16D9-46E8-88DA-6891968CE167@oracle.com>
Date: Fri, 22 Nov 2019 08:22:01 -0600
Message-Id: <5F63D43D-09E6-4188-A708-C31AB9F6CC0A@oracle.com>
References: <1573556939-17803-1-git-send-email-bhsharma@redhat.com>
 <CAJ2QiJJ6DdxFheRo78+n1=ZuqMQnHeuLVWchK8SApt3w9wBKLQ@mail.gmail.com>
 <B71B3868-9A0B-46AD-8777-97A1599BFB91@oracle.com>
 <CACi5LpOF2FLrmXEyJ4FfjqJBxxt-np2+1V0EFK__EH=6ubFE0A@mail.gmail.com>
 <276620F6-E9AC-4BC6-B413-D84677C3D6BC@oracle.com>
 <CACi5LpO9hRKotoMAgEQiLPEHWm7DO_NXWmTL1Wcfi3A0OyGJMQ@mail.gmail.com>
 <4C21663E-4E3B-402D-96FD-BD7623C6628A@oracle.com>
 <F5504C62-6D51-4E37-AA35-269FEA7AE480@oracle.com>
 <C825B090-610A-4EFE-9292-57DDD4832BA6@oracle.com>
 <03F00E44-16D9-46E8-88DA-6891968CE167@oracle.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>, kexec mailing list <kexec@lists.infradead.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Prabhakar Kushwaha <prabhakar.pkin@gmail.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>

CgpIaSBCaHVwZXNoLAoKSSByZWNhbGwgc2VlaW5nIGEgcmVmZXJlbmNlIHRvIG1vZGlmaWNhdGlv
biBhcmUgbmVlZGVkIGZvciB0aGUgY3Jhc2ggQ0xJIGFsc28gdG8gc3VwcG9ydCA1LjQuMC1yYyB3
aXRoIHlvdXIga2VybmVsIHBhdGNoZXMgY2l0ZWQgaGVyZS4KIApXaGVyZSB3b3VsZCBJIGZpbmQg
dGhhdCBhdCA/ICBJIGRvbuKAmXQgc2VlIGNyYXNoIG9uIEdpYmxhYi4KCgo+Pj4gCj4+PiAKPj4+
IEhpIAo+Pj4gCj4+PiAKPj4+IEkgd2FzIGFibGUgdG8gZm9yayBhbmQgY2xvbmUgeW91ciB3b3Jr
IGFyZWEgLgo+Pj4gCj4+PiBJIGNhbiBzZWUgbWFrZWR1bXBmaWxlIHdvcmtzIG5vdyAhIAo+Pj4g
Cj4+PiBGYW50YXN0aWMgOzsgIFRoYW5rIHlvdSBmb3IgeW91ciBwYXRpZW5jZSAhCj4+PiAKPj4g
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
