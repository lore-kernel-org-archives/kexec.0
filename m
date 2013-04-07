Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-da0-x229.google.com ([2607:f8b0:400e:c00::229])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UOdz8-00018S-5V
 for kexec@lists.infradead.org; Sun, 07 Apr 2013 01:01:31 +0000
Received: by mail-da0-f41.google.com with SMTP id w4so2100895dam.14
 for <kexec@lists.infradead.org>; Sat, 06 Apr 2013 18:01:21 -0700 (PDT)
Date: Sun, 7 Apr 2013 09:01:03 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH] i386:kexec-bzImage: Use "\0" as command line instead of
 empty command line
Message-ID: <20130407010103.GA2176@udknight>
References: <20130403094356.GA7259@udknight>
 <515FB809.3020103@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <515FB809.3020103@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: jbarnes@sgi.com, tjd21@cl.cam.ac.uk, khalid.aziz@hp.com, kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hari@in.ibm.com

T24gU2F0LCBBcHIgMDYsIDIwMTMgYXQgMDE6NTI6MDlQTSArMDgwMCwgWmhhbmcgWWFuZmVpIHdy
b3RlOgo+IOS6jiAyMDEz5bm0MDTmnIgwM+aXpSAxNzo0MywgV2FuZyBZYW5RaW5nIOWGmemBkzoK
PiA+IEkgZ2V0IGdhcmJhZ2Ugb3V0cHV0IG9mIC9wcm9jL2NtZGxpbmUgYW5kIGluIGRtZXNnIHdo
ZW4gSQo+ID4gdXNlIGtleGVjIHRvIGxvYWQgbmV3IGtlcm5lbCBiekltYWdlIHdpdGhvdXQgYXBw
ZW5kIGNvbW1hbmQKPiA+IGxpbmUgbGlrZSBiZWxvdzoKPiA+IAo+ID4ga2V4ZWMgLWwgYnpJbWFn
ZSAtLWluaXRyZD1pbml0cmFtZnMuCj4gCj4gSGVsbG8gV2FuZwo+IAo+IEkgdHJpZWQgdGhpczoK
PiAKPiAuL2J1aWxkL3NiaW4va2V4ZWMgLWwgL2Jvb3Qvdm1saW51ei0yLjYuMzItMjc5LmVsNi5p
Njg2IC0taW5pdHJkPS9ib290L2luaXRyYW1mcy0yLjYuMzItMjc5LmVsNi5pNjg2LmltZyAKPiAK
PiBCdXQgbm90aGluZyBoYXBwZW5lZCBhbmQgaXQgc2VlbWVkIHRoZSBjb21tYW5kIGxvYWRlZCB0
aGUga2VybmVsIHN1Y2Nlc3NmdWxseS4KPiBDYW4geW91IGRlc2NyaWJlIHlvdXIgc2l0dWF0aW9u
IG1vcmUgY29uY3JldGVseSwgcGxlYXNlPwpZZXMsIGl0IHdpbGwgbG9hZCB0aGUga2VybmVsIHN1
Y2Nlc3NmdWxseSwgYnV0IHdoZW4geW91IHVzZSBrZXhlYyAtZSB0byBydW4gaW50bwp0aGUgbG9h
ZGVkIGtlcm5lbCwgaW4gdGhlIG5ldyBrZXJuZWwgY29udGV4dCwgeW91IHdpbGwgZ2V0IGdhcmJh
Z2Ugb3V0cHV0IHdoZW4gCmV4ZWN1dGUgYGNhdCAvcHJvYy9jbWRsaW5lYCwgYW5kIHlvdSBhbHNv
IGNhbiBzZWUgdGhlIGdhcmJhZ2UgaW4gIktlcm5lbCBjb21tYW5kCmxpbmUiIGZyb20gZG1lc2cu
IAoKSSBhbSBzdXJlIHlvdSB3aWxsIHNlZSB0aGlzIGlzc3VlLCBiZWNhdXNlIHdoZW4gdXNlciBw
YXNzIG5vIGNtZGxpbmUsIGFuZCBjbWRsaW5lX2xlbgp3aWxsIGJlY2F1c2UgemVybywgc28gdGhl
IGxpbmUgYmVsb3cgaW4gc2V0dXBfbGludXhfYm9vdGxvYWRlcl9wYXJhbWV0ZXJzX2hpZ2ggd2ls
bApub3Qgd29yazoKY21kbGluZV9wdHJbY21kbGluZV9sZW4gLSAxXSA9ICdcMCc7CgpUaGFua3MK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
