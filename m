Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g7J2P-0007Ia-PQ
 for kexec@lists.infradead.org; Tue, 02 Oct 2018 11:40:27 +0000
Date: Tue, 2 Oct 2018 13:40:12 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v8 RESEND 0/4] Support kdump for AMD secure memory
 encryption(SME)
Message-ID: <20181002114012.GB29859@zn.tnic>
References: <20180930031033.22110-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180930031033.22110-1-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

T24gU3VuLCBTZXAgMzAsIDIwMTggYXQgMTE6MTA6MjlBTSArMDgwMCwgTGlhbmJvIEppYW5nIHdy
b3RlOgo+IFdoZW4gU01FIGlzIGVuYWJsZWQgb24gQU1EIG1hY2hpbmUsIGl0IGFsc28gbmVlZHMg
dG8gc3VwcG9ydCBrZHVtcC4gQmVjYXVzZQoKT2ssIEkndmUgY2xlYW5lZCB0aGVtIHVwIGhlYXZp
bHkgYW5kIHB1c2hlZCB0aGVtIGhlcmU6CgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9icC9icC5naXQsIGJyYW5jaCByYzYrMC1zbWUta2R1bXAKCkhvd2V2
ZXIsIHRlc3Rpbmcgb24gbXkgemVuIGJveCBkb2Vzbid0IGdvIGFzIHBsYW5uZWQuIEFuZCB0aGlz
IGlzIGV2ZW4gYmVmb3JlCnlvdXIgcGF0Y2hlcy4KCkkgbG9hZCB0aGUga2R1bXAga2VybmVsIHdp
dGgga2V4ZWMtdG9vbHMgZnJvbSB0aGUgZ2l0LXJlcG8gKyB0aGUgcGF0Y2ggeW91Cm1lbnRpb246
CgojIH4vYnBldGtvdi9iaW4vc2Jpbi9rZXhlYyAtcCAvYm9vdC92bWxpbnV6LTQuMTkuMC1yYzYr
IC0taW5pdHJkIC9ib290L2luaXRyZC00LjE5LjAtcmM2KyAtLWNvbW1hbmQtbGluZT0icm9vdD0v
ZGV2L21hcHBlci91YnVudHUtLTAxMDIzNjAxMjEzMi0tdmctbGVhcDE1IHNwbGFzaD1zaWxlbnQg
c2hvd29wdHMgY29uc29sZT10dHlTNSwxMTUyMDAgY29uc29sZT10dHkwIGRlYnVnIGlnbm9yZV9s
b2dsZXZlbCBsb2dfYnVmX2xlbj0xNk0gMSBpcnFwb2xsIG1heGNwdXM9MSByZXNldF9kZXZpY2Vz
IHZnYT1ub3JtYWwiCgp2ZXJpZnkgdGhhdCBpdCBoYXMgYmVlbiBsb2FkZWQ6CgojIGdyZXAgLiAv
c3lzL2tlcm5lbC9rZXhlY18qCi9zeXMva2VybmVsL2tleGVjX2NyYXNoX2xvYWRlZDoxCi9zeXMv
a2VybmVsL2tleGVjX2NyYXNoX3NpemU6MjY4NDM1NDU2Ci9zeXMva2VybmVsL2tleGVjX2xvYWRl
ZDowCgphbmQgdGhlbiB0cmlnZ2VyIHRoZSBwYW5pYzoKCiMgZWNobyBjID4gL3Byb2Mvc3lzcnEt
dHJpZ2dlcgoKYW5kIEkgc2VlIHRoZSBwYW5pYyBoYXBwZW5pbmcgaW4gdGhlIHNlcmlhbCBjb25z
b2xlIGJ1dCB0aGVuIG5vdGhpbmcuClRoZSBib3ggcmVzZXRzIGluc3RlYWQuCgpTbyBzb21ldGhp
bmcncyBzdGlsbCBicm9rZW4uCgpUcnlpbmcgdGhlIGtleGVjIC1sL2tleGVjIC1lIGdhbWUgd29y
a3MgLSB0aGUgc2Vjb25kIGtlcm5lbCBnZXRzIGtleGVjZWQKcHJvcGVybHkuCgotLSAKUmVnYXJk
cy9HcnVzcywKICAgIEJvcmlzLgoKU1VTRSBMaW51eCBHbWJILCBHRjogRmVsaXggSW1lbmTDtnJm
ZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9uLCBIUkIgMjEyODQgKEFHIE7DvHJuYmVy
ZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
