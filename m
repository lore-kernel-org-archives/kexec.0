Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvLg6-0006Xu-39
 for kexec@lists.infradead.org; Wed, 07 Aug 2019 13:08:32 +0000
Date: Wed, 7 Aug 2019 15:07:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4] x86/mce: protect nr_cpus from rebooting by broadcast
 mce
In-Reply-To: <20190807075226.GA10392@mypc>
Message-ID: <alpine.DEB.2.21.1908071504310.24014@nanos.tec.linutronix.de>
References: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
 <20190807025843.GA4776@dhcp-128-65.nay.redhat.com>
 <20190807075226.GA10392@mypc>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Baoquan He <bhe@redhat.com>, tony.luck@intel.com, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, x86@kernel.org, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Qian Cai <cai@lca.pw>, Dave Young <dyoung@redhat.com>, Xunlei Pang <xlpang@linux.alibaba.com>, Vlastimil Babka <vbabka@suse.cz>, Eric Biederman <ebiederm@xmission.com>

On Wed, 7 Aug 2019, Pingfan Liu wrote:
> On Wed, Aug 07, 2019 at 11:00:41AM +0800, Dave Young wrote:
> > Add Tony and Xunlei in cc.
> > On 08/05/19 at 04:58pm, Pingfan Liu wrote:
> > > This series include two related groups:
> > > [1-3/4]: protect nr_cpus from rebooting by broadcast mce
> > > [4/4]: improve "kexec -l" robustness against broadcast mce
> > > 
> > > When I tried to fix [1], Thomas raised concern about the nr_cpus' vulnerability
> > > to unexpected rebooting by broadcast mce. After analysis, I think only the
> > > following first case suffers from the rebooting by broadcast mce. [1-3/4] aims
> > > to fix that issue.
> > 
> > I did not understand and read the MCE details, but we previously had a
> > MCE problem, Xunlei fixed in below commit:
> > commit 5bc329503e8191c91c4c40836f062ef771d8ba83
> > Author: Xunlei Pang <xlpang@redhat.com>
> > Date:   Mon Mar 13 10:50:19 2017 +0100
> > 
> >     x86/mce: Handle broadcasted MCE gracefully with kexec
> > 
> > I wonder if this is same issue or not. Also the old discussion is in
> > below thread:
> > https://lore.kernel.org/patchwork/patch/753530/
> > 
> > Tony raised similar questions, but I'm not sure if it is still a problem
> > or it has been fixed.
> > 
>
> Xunlei's patch is the precondition of the stability for the case 2: boot
> up by "kexec -p nr_cpus="

Correct. The only dangerous issue which is then left is that an MCE hits
_before_ all CPUs have CR.MCE=1 set. That's a general issue also for cold
boot. Thanks to the brilliant hardware design, all we can do is pray....

> For case1/3, extra effort is needed.
> 
> Thanks,
> 	Pingfan
> > > 
> > > *** Back ground ***
> > > 
> > > On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> > > broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.

Pingfan, please trim your replies and remove the useless gunk after your answer.

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
