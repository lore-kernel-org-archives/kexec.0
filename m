Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWkov-0002QN-Cd
 for kexec@lists.infradead.org; Thu, 07 May 2020 18:00:31 +0000
Subject: Re: [RFC 34/43] shmem: PKRAM: multithread preserving and restoring
 shmem pages
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
 <1588812129-8596-35-git-send-email-anthony.yznaga@oracle.com>
 <4e44858d-a416-696e-0d65-0b5ca8836b7d@infradead.org>
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Message-ID: <533ec65c-6d92-a75b-b151-aaa3f43224f8@oracle.com>
Date: Thu, 7 May 2020 10:59:09 -0700
MIME-Version: 1.0
In-Reply-To: <4e44858d-a416-696e-0d65-0b5ca8836b7d@infradead.org>
Content-Language: en-US
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
To: Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

CgpPbiA1LzcvMjAgOTozMCBBTSwgUmFuZHkgRHVubGFwIHdyb3RlOgo+IE9uIDUvNi8yMCA1OjQy
IFBNLCBBbnRob255IFl6bmFnYSB3cm90ZToKPj4gSW1wcm92ZSBwZXJmb3JtYW5jZSBieSBtdWx0
aXRocmVhZGluZyB0aGUgd29yayB0byBwcmVzZXJ2ZSBhbmQgcmVzdG9yZQo+PiBzaG1lbSBwYWdl
cy4KPj4KPj4gQWRkICdwa3JhbV9tYXhfdGhyZWFkcz0nIGtlcm5lbCBvcHRpb24gdG8gc3BlY2lm
eSB0aGUgbWF4aW11bSBudW1iZXIKPj4gb2YgdGhyZWFkcyB0byB1c2UgdG8gcHJlc2VydmUgb3Ig
cmVzdG9yZSB0aGUgcGFnZXMgb2YgYSBzaG1lbSBmaWxlLgo+PiBUaGUgZGVmYXVsdCBpcyAxNi4K
PiBIaSwKPiBQbGVhc2UgZG9jdW1lbnQga2VybmVsIGJvb3Qgb3B0aW9ucyBpbiBEb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dC4KCkknbGwgZG8gdGhhdC7CoCBU
aGFua3MhCgpBbnRob255Cgo+Cj4+IFdoZW4gcHJlc2VydmluZyBwYWdlcyBlYWNoIHRocmVhZCBz
YXZlcyBjaHVua3Mgb2YgYSBmaWxlIHRvIGEgcGtyYW1fb2JqCj4+IHVudGlsIG5vIG1vcmUgbm8g
bW9yZSBjaHVua3MgYXJlIGF2YWlsYWJsZS4KPj4KPj4gV2hlbiByZXN0b3JpbmcgcGFnZXMgZWFj
aCB0aHJlYWQgbG9hZHMgcGFnZXMgdXNpbmcgYSBjb3B5IG9mIGEKPj4gcGtyYW1fc3RyZWFtIGlu
aXRpYWxpemVkIGJ5IHBrcmFtX3ByZXBhcmVfbG9hZF9vYmooKS4gVW5kZXIgdGhlIGhvb2QKPj4g
ZWFjaCB0aHJlYWQgZW5kcyB1cCBmZXRjaGluZyBhbmQgb3BlcmF0aW5nIG9uIHBrcmFtX2xpbmsg
cGFnZXMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFudGhvbnkgWXpuYWdhIDxhbnRob255Lnl6bmFn
YUBvcmFjbGUuY29tPgo+PiAtLS0KPj4gIGluY2x1ZGUvbGludXgvcGtyYW0uaCB8ICAgMiArCj4+
ICBtbS9zaG1lbV9wa3JhbS5jICAgICAgfCAxMDEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4gdGhhbmtzLgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
