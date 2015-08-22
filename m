Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSwxH-0003KW-8E
 for kexec@lists.infradead.org; Sat, 22 Aug 2015 00:46:44 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V3 PATCH 1/4] panic/x86: Fix re-entrance problem due to panic
 on NMI
Date: Sat, 22 Aug 2015 00:46:18 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445493C7D2@GSjpTKYDCembx31.service.hitachi.net>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.84120.stgit@softrs>
 <20150820234500.GI3161@worktop.event.rightround.com>
In-Reply-To: <20150820234500.GI3161@worktop.event.rightround.com>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric
 W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> From: Peter Zijlstra [mailto:peterz@infradead.org]
> 
> On Thu, Aug 06, 2015 at 02:45:43PM +0900, Hidehiro Kawai wrote:
> > diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> > index d05bd2e..dcd4038 100644
> > --- a/arch/x86/kernel/nmi.c
> > +++ b/arch/x86/kernel/nmi.c
> > @@ -231,7 +231,7 @@ void unregister_nmi_handler(unsigned int type, const char *name)
> >  #endif
> >
> >  	if (panic_on_unrecovered_nmi)
> > -		panic("NMI: Not continuing");
> > +		nmi_panic("NMI: Not continuing");
> >
> >  	pr_emerg("Dazed and confused, but trying to continue\n");
> >
> 
> What tree is this again.. my tree (-tip) doesn't have
> panic_on_unrecovered_nmi nonsense.

I created this patch set on top of the v4.2-rc5, but this is
mostly related to x86 and should be based on -tip tree.
I'll do rebase in the next version.

Regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
