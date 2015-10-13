Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2001:470:1f0b:db:abcd:42:0:1])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zm64I-0004Ne-Fp
 for kexec@lists.infradead.org; Tue, 13 Oct 2015 20:21:07 +0000
Date: Tue, 13 Oct 2015 22:19:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
In-Reply-To: <20151005082704.GA23259@nazgul.tnic>
Message-ID: <alpine.DEB.2.11.1510132210590.25029@nanos>
References: <20150930115548.GI2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
 <20151001062733.GL2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499D30D@GSjpTKYDCembx31.service.hitachi.net>
 <20151001084335.GA3764@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499DB92@GSjpTKYDCembx31.service.hitachi.net>
 <20151001110110.GA3544@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499ED83@GSjpTKYDCembx31.service.hitachi.net>
 <20151002074721.GA16538@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A844549A4557@GSjpTKYDCembx31.service.hitachi.net>
 <20151005082704.GA23259@nazgul.tnic>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1011334831-1444767176=:25029"
Content-ID: <alpine.DEB.2.11.1510132213340.25029@nanos>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 'Peter Zijlstra' <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, =?ISO-2022-JP?Q?=1B$BJ=3F=3E=3E2mL&=1B=28J_=2F_HIRAMATU=1B$B!$=1B=28JMASAMI?= <masami.hiramatsu.pt@hitachi.com>, Ingo Molnar <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?ISO-2022-JP?Q?=1B$B2O9g1Q9=28=1B=28J_=2F_KAWAI=1B$B!$=1B=28JHIDEHIRO?= <hidehiro.kawai.ez@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1011334831-1444767176=:25029
Content-Type: TEXT/PLAIN; CHARSET=ISO-2022-JP
Content-ID: <alpine.DEB.2.11.1510132213341.25029@nanos>

Borislav,

On Mon, 5 Oct 2015, Borislav Petkov wrote:
> On Mon, Oct 05, 2015 at 02:03:58AM +0000, 河合英宏 / KAWAI，HIDEHIRO wrote:
> > That's different from my point of view.  I'm not going to pass
> > some data from the first kernel to the second kernel. I'm just going to
> > provide a configurable option for the second kernel to users.
> 
> Dude, WTF?! You're adding a kernel command line which is supposed to
> be used *only* by the kdump kernel. But nooo, it is there in the open
> and visible to people. And anyone can type it in during boot. AND THAT
> SHOULDN'T BE POSSIBLE IN THE FIRST PLACE!
> 
> This information is strictly for the kdump kernel - it shouldn't be a
> generic command line option. How hard it is to understand that simple
> fact?!

Calm down!

Disabling that NMI in the first kernel is not going to make the world
explode. We have enough command line options a user can type in, which
are way worse than that one. If some "expert" types nonsense on the
first kernel command line, then it's none of our problems, really.

If Kawai would have marked that option as a debug feature, this
discussion would have probably never happened.

Aside of that, the best way to hand in options for the kdump kernel is
the command line. We have an existing interface for that.

Let's move on. Nothing to see here.

Thanks,

	tglx


--8323329-1011334831-1444767176=:25029
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--8323329-1011334831-1444767176=:25029--

