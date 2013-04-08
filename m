Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UP5pQ-0000JW-CS
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 06:45:21 +0000
Message-ID: <51626724.7070902@cn.fujitsu.com>
Date: Mon, 08 Apr 2013 14:43:48 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] i386:kexec-bzImage: Use "\0" as command line instead
 of empty command line
References: <20130403094356.GA7259@udknight> <515FB809.3020103@gmail.com>
 <20130407010103.GA2176@udknight> <51610A32.6080200@cn.fujitsu.com>
 <20130407093540.GA4046@udknight> <20130408010804.GA2241@udknight>
 <51623AFD.9000605@cn.fujitsu.com> <20130408035345.GA6651@udknight>
 <516248A4.6030500@cn.fujitsu.com> <20130408060729.GA2334@udknight>
In-Reply-To: <20130408060729.GA2334@udknight>
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

5LqOIDIwMTPlubQwNOaciDA45pelIDE0OjA3LCBXYW5nIFlhblFpbmcg5YaZ6YGTOgo+IE9uIE1v
biwgQXByIDA4LCAyMDEzIGF0IDEyOjMzOjQwUE0gKzA4MDAsIFpoYW5nIFlhbmZlaSB3cm90ZToK
Pj4gSSB0aGluayB0aGlzIGlzIG9rIGZvciB3ZSBoYXZlIGZpbGxlZCBhbGwgdGhlIHJlYWxfbW9k
ZSBidWZmZXIgd2l0aCAwLgo+IEkgZG9uJ3QgdGhpbmsgc28sIGl0IG11c3QgYmUgc29tZXRoaW5n
cyB3cm9uZywgaWYgd2UgaGFkIGZpbGxlZCBhbGwKPiB0aGUgcmVhbF9tb2RlIGJ1ZmZlciB3aXRo
IDAsIHdoeSBkbyB3ZSBuZWVkIG15IHBhdGNoIHRvIHNldCAKPiB0aGUgc3RyaW5nIHRlcm1pbmF0
aW9uIGd1YXJkICdcMCc/IAoKcmVhbF9tb2RlID0ga2VybmVsMTYgYnVmICsgY29tbWFuZGxpbmUg
KyBwdXJnYXRvcnkgY29tbWFuZGxpbmUuCgpBdCBmaXJzdCwgd2UgZmlsbGVkIGFsbCByZWFsX21v
ZGUgYnVmZmVyIHdpdGggMCwgdGhlbiB3ZSBhc3NpZ25lZCB2YWx1ZXMKdG8ga2VybmVsMTYgYnVm
IGp1c3QgaW4gdGhlIGhlYWQgb2YgcmVhbF9tb2RlLgpBbmQgbmV4dCwgd2UgY29waWVkIHRoZSBj
b21tYW5kbGluZSBqdXN0IGFmdGVyIHRoZSBrZXJuZWwxNiBidWYuIFVzdWFsbHksCndoZW4gd2Ug
Y29weSBhIHN0cmluZyBpbnRvIGEgYnVmZmVyLCB3ZSB3aWxsIHNldCB0aGUgc3RyaW5nIHRlcm1p
bmF0aW9uCmd1YXJkICdcMCcgcmlnaHQgYWZ0ZXIgdGhlIHN0cmluZyBpbiB0aGUgYnVmZmVyIGZv
ciBzYWZldHksIEkgdGhpbmsuCgpBcyB5b3VyIHBhdGNoLCBJZiB3ZSBoYXZlIG5vIGNvbW1hbmRs
aW5lLCBhbmQganVzdCBhc3NpZ24gaXQgdG8gJ1wwJy4gSXQKcHJldmVudHMgdGhlIHByb2JsZW1z
IHRvIGhhcHBlbiBiZWxvdzoKCkluIHNldHVwX2xpbnV4X2Jvb3Rsb2FkZXJfcGFyYW1ldGVyc19o
aWdoCgoxMjAgICAgICAgICBjbWRsaW5lX3B0ciA9ICgoY2hhciAqKXJlYWxfbW9kZSkgKyBjbWRs
aW5lX29mZnNldDsKMTIxICAgICAgICAgbWVtY3B5KGNtZGxpbmVfcHRyLCBjbWRsaW5lLCBjbWRs
aW5lX2xlbik7CjEyMiAgICAgICAgIGNtZGxpbmVfcHRyW2NtZGxpbmVfbGVuIC0gMV0gPSAnXDAn
OwoKaWYgY21kbGluZV9sZW4gPT0gMCwgTGluZSAxMjIgd2lsbCBjb3JydXB0IGtlcm5lbDE2IGJ1
ZiBqdXN0IGJlZm9yZSB0aGUgY29tbWFuZGxpbmUuCgpBbmQgaW4gZG9fYnpJbWFnZV9sb2FkLCBm
b3IgZXhhbXBsZSwKCjM2OSAgICAgICAgIGNtZGxpbmVfZW5kID0gc2V0dXBfYmFzZSArIGtlcm4x
Nl9zaXplX25lZWRlZCArIGNvbW1hbmRfbGluZV9sZW4gLSAxOwozNzAgICAgICAgICBlbGZfcmVs
X3NldF9zeW1ib2woJmluZm8tPnJoZHIsICJjbWRsaW5lX2VuZCIsICZjbWRsaW5lX2VuZCwKMzcx
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih1bnNpZ25lZCBsb25nKSk7CgpMaW5l
IDM2OSB3aWxsIGdvIHdyb25nLCB0b28uCgo+IAo+IERvZXMgJ1wwJyBlcXVhbCB6ZXJvLCByaWdo
dD8KClllYWgsIGlmIHdlIHdyaXRlICdcMCcsIHRoZSB2YWx1ZSBzdG9yZSBpbnRvIHRoZSBjaGFy
IGJ1ZiBpcyB6ZXJvLCBJIHRoaW5rLgoKQ29ycmVjdCBtZSBpZiBJIGFtIHdyb25nLCBwbGVhc2Uu
CgpUaGFua3MKWmhhbmcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
