Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g7fQi-0006x7-54
 for kexec@lists.infradead.org; Wed, 03 Oct 2018 11:35:01 +0000
Date: Wed, 3 Oct 2018 13:34:35 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v8 RESEND 0/4] Support kdump for AMD secure memory
 encryption(SME)
Message-ID: <20181003113435.GB4436@zn.tnic>
References: <20180930031033.22110-1-lijiang@redhat.com>
 <20181002114012.GB29859@zn.tnic>
 <43da68b1-fda0-c033-39e1-907d01f13354@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <43da68b1-fda0-c033-39e1-907d01f13354@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

T24gV2VkLCBPY3QgMDMsIDIwMTggYXQgMTE6NTc6NTlBTSArMDgwMCwgbGlqaWFuZyB3cm90ZToK
PiBJIG5vdGljZWQgdGhhdCB5b3VyIHRlc3Qgd2FzIGJhc2VkIG9uIFtwYXRjaCB2OCBSRVNFTkQg
NC80XSwKCkhvdyBkaWQgeW91IG5vdGljZSB0aGF0PwoKTGV0J3Mgc2VlLCB0aGUgcGF0Y2ggaW4g
cXVlc3Rpb24gaXMgdGhpcyBvbmU6CgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9icC9icC5naXQvY29tbWl0Lz9oPXJjNiUyYjAtc21lLWtkdW1wJmlkPTRh
MGYyYWRmNmNmMzc0ZWQzZTc0MjEzNGU0MDU5MWVhMzNkNTViMDUKCmFuZCBpdCBoYXMgYSBMaW5r
IHRhZzoKCkxpbms6IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvYmU3YjQ3ZjktNmJlNi1lMGQx
LTJjMmEtOTEyNWJjNzRiODE4QHJlZGhhdC5jb20KCk5vdyBsZXQncyBvcGVuIHRoYXQgbGluayB0
YWcuIEkgZG9uJ3Qga25vdyBhYm91dCB5b3UgYnV0IG15IGJyb3dzZXIgc2F5czoKCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvYmU3YjQ3ZjktNmJlNi1lMGQxLTJjMmEtOTEyNWJjNzRiODE4
QHJlZGhhdC5jb20vVC8jdQoKd2hpY2ggcG9pbnRzIHRvCgpTdWJqZWN0OiBSZTogW1BBVENIIHY5
IDQvNF0ga2R1bXAvdm1jb3JlOiBzdXBwb3J0IGVuY3J5cHRlZCBvbGQgbWVtb3J5IHdpdGggU01F
IGVuYWJsZWQKCkxvb2tpbmcgYXQgdGhhdCBtYWlsLCBpdHMgbWVzc2FnZSBpZCBpczoKCk1lc3Nh
Z2UtSUQ6IDxiZTdiNDdmOS02YmU2LWUwZDEtMmMyYS05MTI1YmM3NGI4MThAcmVkaGF0LmNvbT4K
Ckl0IGxvb2tzIHRvIG1lIGl0IGlzIGFscmVhZHkgdjksIG5vPwoKLS0gClJlZ2FyZHMvR3J1c3Ms
CiAgICBCb3Jpcy4KClNVU0UgTGludXggR21iSCwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwgSmFu
ZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbiwgSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
