Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4dvb-0002hy-Ln
 for kexec@lists.infradead.org; Mon, 02 Sep 2019 04:26:57 +0000
Received: by mail-pg1-x542.google.com with SMTP id d10so2212298pgo.5
 for <kexec@lists.infradead.org>; Sun, 01 Sep 2019 21:26:55 -0700 (PDT)
Date: Mon, 2 Sep 2019 12:26:42 +0800
From: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [PATCHv2 0/4] x86/mce: protect nr_cpus from rebooting by
 broadcast mce
Message-ID: <20190902042642.GA22792@mypc>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
 <20190830141156.GB30413@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190830141156.GB30413@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, x86@kernel.org, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>, Ingo Molnar <mingo@redhat.com>, Qian Cai <cai@lca.pw>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Eric Biederman <ebiederm@xmission.com>

On Fri, Aug 30, 2019 at 04:11:56PM +0200, Borislav Petkov wrote:
> On Tue, Aug 27, 2019 at 11:02:19AM +0800, Pingfan Liu wrote:
> > v1 -> v2: fix compile warning and error on x86_32
> > 
> > 
> > This series include two related groups:
> > [1-3/4]: protect nr_cpus from rebooting by broadcast mce
> > [4/4]: improve "kexec -l" robustness against broadcast mce
> > 
> > When I tried to fix [1], Thomas raised concern about the nr_cpus' vulnerability
> > to unexpected rebooting by broadcast mce. After analysis, I think only the
> > following first case suffers from the rebooting by broadcast mce. [1-3/4] aims
> > to fix that issue.
> > 
> > *** Back ground ***
> > 
> > On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> > broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.
> > 
> > The option 'nosmt' has already complied with the above rule by Thomas's patch.
> > For detail, refer to 506a66f3748 (Revert "x86/apic: Ignore secondary threads if
> > nosmt=force")
> > 
> > But for nr_cpus option, the exposure to broadcast MCE is a little complicated,
> > and can be categorized into three cases.
> 
> One thing is not clear to me: are you "fixing" a hypothetical case here
> or have you *actually* experienced an MCE happening while kdumping with
> nr_cpus < num_online_cpus()?
No, I do not hit this issue by myself.

But from the following two commits:
commit 5bc329503e8191c91c4c40836f062ef771d8ba83
Author: Xunlei Pang <xlpang@redhat.com>
Date:   Mon Mar 13 10:50:19 2017 +0100

    x86/mce: Handle broadcasted MCE gracefully with kexec
And
commit 506a66f374891ff08e064a058c446b336c5ac760
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Fri Jun 29 16:05:47 2018 +0200

    Revert "x86/apic: Ignore secondary threads if nosmt=force"

This issue is in practice.

BTW, clarify one thing kdumping (kexec -p) will not suffer from mce
issue as described in case 2. Only "kexec -l" will.

> 
> Btw, pls do not use lkml.org to refer to previous mails but
> 
> http://lkml.kernel.org/r/<Message-ID>
OK, I will.

Thanks,
	Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
