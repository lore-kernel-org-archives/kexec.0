Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nue.novell.com ([195.135.221.5])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZgqeW-0004Hr-Au
 for kexec@lists.infradead.org; Tue, 29 Sep 2015 08:52:49 +0000
Date: Tue, 29 Sep 2015 16:52:09 +0800
From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] kexec: fix out of the ELF headers buffer issue in
 syscall kexec_file_load()
Message-ID: <20150929085209.GE2115@linux-rxt1.site>
References: <1443422490-17768-1-git-send-email-jlee@suse.com>
 <20150929035044.GA719@dhcp-128-25.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150929035044.GA719@dhcp-128-25.nay.redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Baoquan He <bhe@redhat.com>, Takashi Iwai <tiwai@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>, "Lee,
 Chun-Yi" <joeyli.kernel@gmail.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hi Minfei, 

On Tue, Sep 29, 2015 at 11:50:44AM +0800, Minfei Huang wrote:
> On 09/28/15 at 02:41pm, Lee, Chun-Yi wrote:
> > On big machines have CPU number that's very nearly to consume whole ELF
> > headers buffer that's page aligned, 4096, 8192... Then the page fault error
> > randomly happened.
> > 
> > This patch modified the code in fill_up_crash_elf_data() by using
> > walk_system_ram_res() instead of walk_system_ram_range() to count the max
> > number of crash memory ranges. That's because the walk_system_ram_range()
> > filters out small memory regions that reside the same page, but
> > walk_system_ram_res() does not.
> > 
> > The oringial page fault issue sometimes happened on big machines when
> > preparing ELF headers:
> > 
> > [  305.291522] BUG: unable to handle kernel paging request at ffffc90613fc9000
> > [  305.299621] IP: [<ffffffff8103d645>] prepare_elf64_ram_headers_callback+0x165/0x260
> > [  305.308300] PGD e000032067 PUD 6dcbec54067 PMD 9dc9bdeb067 PTE 0
> > [  305.315393] Oops: 0002 [#1] SMP
> > [...snip]
> > [  305.420953] task: ffff8e1c01ced600 ti: ffff8e1c03ec2000 task.ti: ffff8e1c03ec2000
> > [  305.429292] RIP: 0010:[<ffffffff8103d645>]  [<ffffffff8103d645>] prepare_elf64_ra
> > m_headers_callback+0x165/0x260
> > [...snip]
> > 
> > After tracing prepare_elf64_headers() and prepare_elf64_ram_headers_callback(),
> > the code uses walk_system_ram_res() to fill-in crash memory regions information
> > to program header, so it counts those small memory regions that reside in a
> > page area. But, when kernel was using walk_system_ram_range() in
> > fill_up_crash_elf_data() to count the number of crash memory regions, it
> > filters out small regions.
> > 
> > I printed those small memory regions, for example:
> > 
> > kexec: Get nr_ram ranges. vaddr=0xffff880077592258 paddr=0x77592258, sz=0xdc0
> > 
> > Base on the logic of walk_system_ram_range(), this memory region will be
> > filter out:
> > 
> > pfn = (0x77592258 + 0x1000 - 1) >> 12 = 0x77593
> > end_pfn = (0x77592258 + 0xfc0 -1 + 1) >> 12 = 0x77593
> > end_pfn - pfn = 0x77593 - 0x77593 = 0  <=== if (end_pfn > pfn)      [FAIL]
> > 
> > So, the max_nr_ranges that counted by kernel doesn't include small memory
> > regions. That causes the page fault issue happened in later code path for
> > preparing EFL headers,
> > 
> > This issue was hided on small machine that doesn't have too many CPU because
> > the free space of ELF headers buffer can cover the number of small memory
> > regions. But, when the machine has more CPUs or the number of memory regions
> > very nearly to consume whole page aligned buffer, e.g. 4096, 8192... Then
> > issue will happen randomly.
> > 
> > Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> > ---
> >  arch/x86/kernel/crash.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index e068d66..ad273b3d 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -185,8 +185,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >  }
> >  
> >  #ifdef CONFIG_KEXEC_FILE
> > -static int get_nr_ram_ranges_callback(unsigned long start_pfn,
> > -				unsigned long nr_pfn, void *arg)
> > +static int get_nr_ram_ranges_callback(u64 start, u64 end, void *arg)
> >  {
> >  	int *nr_ranges = arg;
> 
> Ccing kexec maillist.
> 
> Good cacthing.
> 
> It is appreciate if you can change the above type to unsigned int
> accordingly.
> 
> Thanks
> Minfei
> 

Looks unsigned int* is better, I will change in next version.
Thanks for your review.

Joey Lee

> >  
> > @@ -214,7 +213,7 @@ static void fill_up_crash_elf_data(struct crash_elf_data *ced,
> >  
> >  	ced->image = image;
> >  
> > -	walk_system_ram_range(0, -1, &nr_ranges,
> > +	walk_system_ram_res(0, -1, &nr_ranges,
> >  				get_nr_ram_ranges_callback);
> >  
> >  	ced->max_nr_ranges = nr_ranges;
> > -- 
> > 2.1.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
