Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1coVIZ-0001aA-J5
 for kexec@lists.infradead.org; Thu, 16 Mar 2017 13:18:41 +0000
Date: Thu, 16 Mar 2017 21:18:09 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Update vmcoreinfo after crash happened
Message-ID: <20170316131809.GC23625@x1>
References: <1489666587-24103-1-git-send-email-xlpang@redhat.com>
 <20170316122730.GB23625@x1> <58CA86D2.70800@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58CA86D2.70800@redhat.com>
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
To: xlpang@redhat.com
Cc: Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

On 03/16/17 at 08:36pm, Xunlei Pang wrote:
> On 03/16/2017 at 08:27 PM, Baoquan He wrote:
> > Hi Xunlei,
> >
> > Did you really see this ever happened? Because the vmcore size estimate
> > feature, namely --mem-usage option of makedumpfile, depends on the
> > vmcoreinfo in 1st kernel, your change will break it.
> 
> Hi Baoquan,
> 
> I can reproduce it using a kernel module which modifies the vmcoreinfo,
> so it's a problem can actually happen.
> 
> > If not, it could be not good to change that.
> 
> That's a good point, then I guess we can keep the crash_save_vmcoreinfo_init(),
> and store again all the vmcoreinfo after crash. What do you think?

Well, then it will make makedumpfile segfault happen too when execute
below command in 1st kernel if it existed:
	makedumpfile --mem-usage /proc/kcore

So we still need to face that problem and need fix it. vmcoreinfo_note
is in kernel data area, how does module intrude into this area? And can
we fix the module code?


> 
> >
> > Baoquan
> >
> > On 03/16/17 at 08:16pm, Xunlei Pang wrote:
> >> Currently vmcoreinfo data is updated at boot time subsys_initcall(),
> >> it has the risk of being modified by some wrong code during system
> >> is running.
> >>
> >> As a result, vmcore dumped will contain the wrong vmcoreinfo. Later on,
> >> when using "crash" utility to parse this vmcore, we probably will get
> >> "Segmentation fault".
> >>
> >> Based on the fact that the value of each vmcoreinfo stays invariable
> >> once kernel boots up, we safely move all the vmcoreinfo operations into
> >> crash_save_vmcoreinfo() which is called after crash happened. In this
> >> way, vmcoreinfo data correctness is always guaranteed.
> >>
> >> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> >> ---
> >>  kernel/kexec_core.c | 14 +++-----------
> >>  1 file changed, 3 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >> index bfe62d5..1bfdd96 100644
> >> --- a/kernel/kexec_core.c
> >> +++ b/kernel/kexec_core.c
> >> @@ -1367,12 +1367,6 @@ static void update_vmcoreinfo_note(void)
> >>  	final_note(buf);
> >>  }
> >>  
> >> -void crash_save_vmcoreinfo(void)
> >> -{
> >> -	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
> >> -	update_vmcoreinfo_note();
> >> -}
> >> -
> >>  void vmcoreinfo_append_str(const char *fmt, ...)
> >>  {
> >>  	va_list args;
> >> @@ -1402,7 +1396,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
> >>  	return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
> >>  }
> >>  
> >> -static int __init crash_save_vmcoreinfo_init(void)
> >> +void crash_save_vmcoreinfo(void)
> >>  {
> >>  	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
> >>  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> >> @@ -1474,13 +1468,11 @@ static int __init crash_save_vmcoreinfo_init(void)
> >>  #endif
> >>  
> >>  	arch_crash_save_vmcoreinfo();
> >> -	update_vmcoreinfo_note();
> >> +	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
> >>  
> >> -	return 0;
> >> +	update_vmcoreinfo_note();
> >>  }
> >>  
> >> -subsys_initcall(crash_save_vmcoreinfo_init);
> >> -
> >>  /*
> >>   * Move into place and start executing a preloaded standalone
> >>   * executable.  If nothing was preloaded return an error.
> >> -- 
> >> 1.8.3.1
> >>
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
