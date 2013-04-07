Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UOiaq-0003Sv-H2
 for kexec@lists.infradead.org; Sun, 07 Apr 2013 05:56:45 +0000
Message-ID: <51610A32.6080200@cn.fujitsu.com>
Date: Sun, 07 Apr 2013 13:54:58 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] i386:kexec-bzImage: Use "\0" as command line instead
 of empty command line
References: <20130403094356.GA7259@udknight> <515FB809.3020103@gmail.com>
 <20130407010103.GA2176@udknight>
In-Reply-To: <20130407010103.GA2176@udknight>
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
To: Wang YanQing <udknight@gmail.com>
Cc: jbarnes@sgi.com, tjd21@cl.cam.ac.uk, khalid.aziz@hp.com, kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hari@in.ibm.com, Zhang Yanfei <zhangyanfei.yes@gmail.com>

5LqOIDIwMTPlubQwNOaciDA35pelIDA5OjAxLCBXYW5nIFlhblFpbmcg5YaZ6YGTOgo+IE9uIFNh
dCwgQXByIDA2LCAyMDEzIGF0IDAxOjUyOjA5UE0gKzA4MDAsIFpoYW5nIFlhbmZlaSB3cm90ZToK
Pj4g5LqOIDIwMTPlubQwNOaciDAz5pelIDE3OjQzLCBXYW5nIFlhblFpbmcg5YaZ6YGTOgo+Pj4g
SSBnZXQgZ2FyYmFnZSBvdXRwdXQgb2YgL3Byb2MvY21kbGluZSBhbmQgaW4gZG1lc2cgd2hlbiBJ
Cj4+PiB1c2Uga2V4ZWMgdG8gbG9hZCBuZXcga2VybmVsIGJ6SW1hZ2Ugd2l0aG91dCBhcHBlbmQg
Y29tbWFuZAo+Pj4gbGluZSBsaWtlIGJlbG93Ogo+Pj4KPj4+IGtleGVjIC1sIGJ6SW1hZ2UgLS1p
bml0cmQ9aW5pdHJhbWZzLgo+Pgo+PiBIZWxsbyBXYW5nCj4+Cj4+IEkgdHJpZWQgdGhpczoKPj4K
Pj4gLi9idWlsZC9zYmluL2tleGVjIC1sIC9ib290L3ZtbGludXotMi42LjMyLTI3OS5lbDYuaTY4
NiAtLWluaXRyZD0vYm9vdC9pbml0cmFtZnMtMi42LjMyLTI3OS5lbDYuaTY4Ni5pbWcgCj4+Cj4+
IEJ1dCBub3RoaW5nIGhhcHBlbmVkIGFuZCBpdCBzZWVtZWQgdGhlIGNvbW1hbmQgbG9hZGVkIHRo
ZSBrZXJuZWwgc3VjY2Vzc2Z1bGx5Lgo+PiBDYW4geW91IGRlc2NyaWJlIHlvdXIgc2l0dWF0aW9u
IG1vcmUgY29uY3JldGVseSwgcGxlYXNlPwo+IFllcywgaXQgd2lsbCBsb2FkIHRoZSBrZXJuZWwg
c3VjY2Vzc2Z1bGx5LCBidXQgd2hlbiB5b3UgdXNlIGtleGVjIC1lIHRvIHJ1biBpbnRvCj4gdGhl
IGxvYWRlZCBrZXJuZWwsIGluIHRoZSBuZXcga2VybmVsIGNvbnRleHQsIHlvdSB3aWxsIGdldCBn
YXJiYWdlIG91dHB1dCB3aGVuIAo+IGV4ZWN1dGUgYGNhdCAvcHJvYy9jbWRsaW5lYCwgYW5kIHlv
dSBhbHNvIGNhbiBzZWUgdGhlIGdhcmJhZ2UgaW4gIktlcm5lbCBjb21tYW5kCj4gbGluZSIgZnJv
bSBkbWVzZy4gCgpXaXRoIG5vIGNvbW1hbmRsaW5lLCBjYW4gdGhlIG5ldyBrZXJuZWwgYm9vdD8K
SSB0cmllZCBpbiBteSBib3ggYW5kIHRoZSBuZXcga2VybmVsIGp1c3QgcGFuaWNrZWQgZm9yIGl0
IGNhbm5vdApmaW5kIGEgcm9vdD0gYXJndW1lbnQgaW4gaXRzIGNvbW1hbmRsaW5lLgoKVGhhbmtz
ClpoYW5nCgo+IAo+IEkgYW0gc3VyZSB5b3Ugd2lsbCBzZWUgdGhpcyBpc3N1ZSwgYmVjYXVzZSB3
aGVuIHVzZXIgcGFzcyBubyBjbWRsaW5lLCBhbmQgY21kbGluZV9sZW4KPiB3aWxsIGJlY2F1c2Ug
emVybywgc28gdGhlIGxpbmUgYmVsb3cgaW4gc2V0dXBfbGludXhfYm9vdGxvYWRlcl9wYXJhbWV0
ZXJzX2hpZ2ggd2lsbAo+IG5vdCB3b3JrOgo+IGNtZGxpbmVfcHRyW2NtZGxpbmVfbGVuIC0gMV0g
PSAnXDAnOwo+IAo+IFRoYW5rcwo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
