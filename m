Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHut1-0008QG-Rm
 for kexec@lists.infradead.org; Wed, 11 Apr 2012 10:34:52 +0000
Message-ID: <4F855E3C.9010003@cn.fujitsu.com>
Date: Wed, 11 Apr 2012 18:34:36 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] KVM: VMX: Add functions to fill VMCSINFO
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F84E365.10201@cn.fujitsu.com>
 <4F85454E.6020201@redhat.com>
In-Reply-To: <4F85454E.6020201@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com

5LqOIDIwMTLlubQwNOaciDEx5pelIDE2OjQ4LCBBdmkgS2l2aXR5IOWGmemBkzoKPiBPbiAwNC8x
MS8yMDEyIDA0OjUwIEFNLCB6aGFuZ3lhbmZlaSB3cm90ZToKPj4gVGhpcyBwYXRjaCBpcyB0byBp
bXBsZW1lbnQgdGhlIGZlYXR1cmUgdGhhdCBhdCBpbml0aWFsaXphdGlvbiBvZgo+PiBrdm1faW50
ZWwgbW9kdWxlLCBmaWxscyBWTUNTSU5GTyB3aXRoIGEgVk1DUyByZXZpc2lvbiBpZGVudGlmaWVy
LAo+PiBhbmQgZW5jb2RlZCBvZmZzZXRzIG9mIFZNQ1MgZmllbGRzLiBUaGUgcmVhc29uIHdoeSB3
ZSBwdXQgdGhlCj4+IFZNQ1NJTkZPIHByb2Nlc3NpbmcgYXQgdGhlIGluaXRpYWxpemF0aW9uIG9m
IGt2bV9pbnRlbCBtb2R1bGUKPj4gaXMgdGhhdCBpdCdzIGRhbmdlcm91cyB0byByb2IgVk1YIHJl
c291cmNlcyB3aGlsZSBrdm0gbW9kdWxlIGlzCj4+IGxvYWRlZC4KPiAKPiBNYXliZSBpdCBzaG91
bGQgYmUgZG9uZSBieSBhIHNlcGFyYXRlIG1vZHVsZS4KPiAKCklmIHdlIHB1dCB2bWNzaW5mbyBw
cm9jZXNzaW5nIGF0IHRoZSBpbml0aWFsaXphdGlvbiBvZiBrdm1faW50ZWwgbW9kdWxlLAphcyBz
b29uIGFzIHRoZSBrdm1faW50ZWwgbW9kdWxlIGlzIGxvYWRlZCwgVk1DU0lORk8gaXMgZmlsbGVk
LiBBbmQgaXQgaXMKYmVjYXVzZSB2bWNzaW5mbyBwcm9jZXNzaW5nIGlzIGF0IHRoZSBpbml0aWFs
aXphdGlvbiBvZiBrdm1faW50ZWwgbW9kdWxlLApubyBrdm0gZ3Vlc3RzIGFyZSBydW5uaW5nLCBz
byBpdCB3aWxsIG5vdCByb2IgYW55IFZNWCByZXNvdXJjZXMuCgpJZiBpdCBpcyBkb25lIGJ5IGEg
c2VwYXJhdGUgbW9kdWxlLCBJIGFtIGFmcmFpZCB0aGlzIG1vZHVsZSBtYXkgbm90IGJlCmxvYWRl
ZCB3aGVuIHRoZSBrZXJuZWwgbmVlZHMgVk1DU0lORk8uCgo+PiArCj4+ICsJa3ZtX2NwdV92bXhv
bihfX3BhKHBlcl9jcHUodm14YXJlYSwgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSkpKTsKPj4gKwl2
bWNzX2xvYWQodm1jcyk7Cj4gCj4gU2hvdWxkIGRvIHRoaXMgYWZ0ZXIgd3JpdGluZyBpbnRvIHRo
ZSB2bWNzIGRpcmVjdGx5ICh2bWNzX2xvYWQoKSBtYXkKPiBjYWNoZSBzb21lIGluZm9ybWF0aW9u
IGZvciB2bWNzX3JlYWQoKSkuCj4KCkhtbSwgdGhhbmtzIGZvciBwb2ludGluZyB0aGlzLgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
