Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZKigj-0004Dl-19
 for kexec@lists.infradead.org; Thu, 30 Jul 2015 07:55:38 +0000
Received: by wicmv11 with SMTP id mv11so10182999wic.0
 for <kexec@lists.infradead.org>; Thu, 30 Jul 2015 00:55:15 -0700 (PDT)
Date: Thu, 30 Jul 2015 09:55:13 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to
 panic on NMI
Message-ID: <20150730075512.GB9387@dhcp22.suse.cz>
References: <20150727015850.4928.87717.stgit@softrs>
 <20150727015850.4928.50289.stgit@softrs>
 <20150727143405.GF11317@dhcp22.suse.cz>
 <55B6E2A3.8070004@hitachi.com>
 <04EAB7311EE43145B2D3536183D1A8445491D5E8@GSjpTKYDCembx31.service.hitachi.net>
 <20150729082329.GA15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491DB5E@GSjpTKYDCembx31.service.hitachi.net>
 <20150729092157.GC15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491F23A@GSjpTKYDCembx31.service.hitachi.net>
 <04EAB7311EE43145B2D3536183D1A8445491F614@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445491F614@GSjpTKYDCembx31.service.hitachi.net>
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
To: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= <hidehiro.kawai.ez@hitachi.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "'ltc-kernel@ml.yrl.intra.hitachi.co.jp'" <ltc-kernel@ml.yrl.intra.hitachi.co.jp>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gVGh1IDMwLTA3LTE1IDA3OjMzOjE1LCDmsrPlkIjoi7Hlro8gLyBLQVdBSe+8jEhJREVISVJP
IHdyb3RlOgpbLi4uXQo+IEFyZSB5b3UgdXNpbmcgU0dJIFVWPyAgT24gdGhhdCBwbGF0Zm9ybSwg
Tk1JcyBtYXkgYmUgZGVsaXZlcmVkIHRvCj4gYWxsIGNwdXMgYmVjYXVzZSBMVlQxIG9mIGFsbCBj
cHVzIGFyZSBub3QgbWFza2VkIGFzIGZvbGxvd3M6CgpUaGlzIGlzIENvbXB1dGUgQmxhZGUgNTIw
WEIxIGZyb20gSGl0YWNoaSB3aXRoIDI0MCBjcHVzLgoKLS0gCk1pY2hhbCBIb2NrbwpTVVNFIExh
YnMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
