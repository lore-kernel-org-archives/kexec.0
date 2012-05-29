Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SZGYh-0005LZ-Ez
 for kexec@lists.infradead.org; Tue, 29 May 2012 07:09:38 +0000
Message-ID: <4FC47579.2040504@cn.fujitsu.com>
Date: Tue, 29 May 2012 15:06:33 +0800
From: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] Export offsets of VMCS fields as note information
 for kdump
References: <4FB35C48.30708@cn.fujitsu.com> <4FB92D5A.3060507@redhat.com>
 <4FB9A92D.7050108@cn.fujitsu.com> <4FB9FE08.4050905@redhat.com>
 <4FBA05F6.8070804@cn.fujitsu.com> <4FBA0C8A.2050003@redhat.com>
 <4FBB0ACA.2040907@cn.fujitsu.com> <4FC30C40.80500@cn.fujitsu.com>
 <4FC37D94.3080404@redhat.com>
In-Reply-To: <4FC37D94.3080404@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com, Greg KH <gregkh@linuxfoundation.org>

09ogMjAxMsTqMDXUwjI4yNUgMjE6MjgsIEF2aSBLaXZpdHkg0LS1wDoKPiBPbiAwNS8yOC8yMDEy
IDA4OjI1IEFNLCBZYW5mZWkgWmhhbmcgd3JvdGU6Cj4+Cj4+IERvdSB5b3UgaGF2ZSBhbnkgY29t
bWVudHMgYWJvdXQgdGhpcyBwYXRjaCBzZXQ/Cj4gCj4gSSBzdGlsbCBoYXZlIGEgaGFyZCB0aW1l
IHVuZGVyc3RhbmRpbmcgd2h5IGl0IGlzIG5lZWRlZC4gIElmIHRoZSBob3N0Cj4gY3Jhc2hlcywg
dGhlcmUgaXMgbm8gcmVhc29uIHRvIGxvb2sgYXQgZ3Vlc3Qgc3RhdGU7IHRoZSBob3N0IHNob3Vs
ZAo+IHN1cnZpdmUgbm8gbWF0dGVyIHdoYXQgdGhlIGd1ZXN0IGRvZXMuCj4gCj4gCgpPSy4gTGV0
IG1lIHN1bW1hcml6ZSBpdC4KCjEuIFdoeSBpcyB0aGlzIHBhdGNoIG5lZWRlZD8gKE91ciByZXF1
aXJlbWVudCkKICAgCldlIG9uY2UgY2FtZSB0byBhIGJ1Z2d5IHNpdHVhdGlvbjogYSBob3N0IHNj
aGVkdWxlciBidWcgY2F1c2VkIGd1ZXN0IG1hY2hpbmUncwp2Y3B1IHN0b3BwZWQgZm9yIGEgbG9u
ZyB0aW1lIGFuZCB0aGVuIGxlZCB0byBoZWFydGJlYXQgc3RvcCAoaG9zdCBpcyBzdGlsbCBydW5u
aW5nKS4KICAgCndlIHdhbnQgdG8gaGF2ZSBhbiBlZmZpY2llbnQgd2F5IHRvIG1ha2UgdGhlIGJ1
ZyBhbmFseXNpcyB3aGVuIHdlIGNvbWUgdG8gdGhlIHNpbWlsYXIKc2l0dWF0aW9uIHdoZXJlIGd1
ZXN0IG1hY2hpbmUgZG9lc24ndCB3b3JrIHdlbGwgZHVlIHRvIHNvbWV0aGluZyBvZiBob3N0IG1h
Y2hpbmUncywgCgpCZWNhdXNlIHdlIHNob3VsZCBkZWJ1ZyBib3RoIGhvc3QgbWFjaGluZSdzIGFu
ZCBndWVzdCBtYWNoaW5lJ3Mgc2lkZXMgdG8gbG9vayBmb3IKdGhlIHJlYXNvbnMsIHNvIHdlIHdh
bnQgdG8gZ2V0IGJvdGggaG9zdCBtYWNoaW5lJ3MgY3Jhc2ggZHVtcCBhbmQgZ3Vlc3QgbWFjaGlu
ZSdzCmNyYXNoIGR1bXAgYXQgdGhlIHNhbWUgdGltZSB3aGVuIHRoZSBidWdneSBzaXR1YXRpb24g
cmVtYWlucy4gCgoyLiBXaGF0IHdpbGwgd2UgZG8/CiAgIApJZiB0aGlzIGJ1ZyB3YXMgZm91bmQg
b24gY3VzdG9tZXIncyBlbnZpcm9ubWVudCwgd2UgaGF2ZSB0d28gd2F5cyB0byBhdm9pZAphZmZl
Y3Rpbmcgb3RoZXIgZ3Vlc3QgbWFjaGluZXMgcnVubmluZyBvbiB0aGUgc2FtZSBob3N0LiBGaXJz
dCwgd2UgY291bGQgZG8gYnVnCmFuYWx5c2lzIG9uIGFub3RoZXIgZW52aXJvbm1lbnQgdG8gcmVw
cm9kdWNlIHRoZSBidWdneSBzaXR1YXRpb247IFNlY29uZCwgd2UKY291bGQgbWlncmF0ZSBvdGhl
ciBndWVzdCBtYWNoaW5lcyB0byBvdGhlciBob3N0cy4gCgpBZnRlciB0aGUgYnVnZ3kgc2l0dWF0
aW9uIGlzIHJlcHJvZHVjZWQsIHdlIHBhbmljIHRoZSBob3N0ICptYW51YWxseSouClRoZW4gd2Ug
Y291bGQgdXNlIHVzZXJsYW5kIHRvb2xzIHRvIGdldCBndWVzdCBtYWNoaW5lJ3MgY3Jhc2ggZHVt
cCBmcm9tIGhvc3QgbWFjaGluZSdzCndpdGggdGhlIGZlYXR1cmUgcHJvdmlkZWQgYnkgdGhpcyBw
YXRjaCBzZXQuIEZpbmFsbHkgd2UgY291bGQgYW5hbHlzZSB0aGVtIHNlcGFyYXRlbHkKdG8gZmlu
ZCB3aGljaCBzaWRlIGNhdXNlcyB0aGUgcHJvYmxlbS4KClRoYW5rcwpaaGFuZyBZYW5mZWkKCiAg
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
