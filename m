Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvcHK-0003VX-Lp
 for kexec@lists.infradead.org; Thu, 08 Aug 2019 06:52:04 +0000
Date: Thu, 8 Aug 2019 08:51:04 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4] x86/mce: protect nr_cpus from rebooting by broadcast
 mce
In-Reply-To: <CAFgQCTs7XN3xBPt64jPNb4wCGAZRmYSjhPM=tgcLriVCEx+uDA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908080850220.2882@nanos.tec.linutronix.de>
References: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
 <20190807025843.GA4776@dhcp-128-65.nay.redhat.com>
 <20190807075226.GA10392@mypc>
 <alpine.DEB.2.21.1908071504310.24014@nanos.tec.linutronix.de>
 <CAFgQCTs7XN3xBPt64jPNb4wCGAZRmYSjhPM=tgcLriVCEx+uDA@mail.gmail.com>
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Baoquan He <bhe@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, x86@kernel.org, Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>, Daniel Drake <drake@endlessm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Qian Cai <cai@lca.pw>, Dave Young <dyoung@redhat.com>, Xunlei Pang <xlpang@linux.alibaba.com>, Vlastimil Babka <vbabka@suse.cz>, Eric Biederman <ebiederm@xmission.com>

On Thu, 8 Aug 2019, Pingfan Liu wrote:
> On Wed, Aug 7, 2019 at 9:07 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> [...]
> > > > >
> > > > > *** Back ground ***
> > > > >
> > > > > On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> > > > > broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.
> >
> > Pingfan, please trim your replies and remove the useless gunk after your answer.
> OK. I will.
> 
> Thanks,
>     Pingfan
> >
> > Thanks,
> >
> >         tglx
> 

First attempt to do so failed :)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
