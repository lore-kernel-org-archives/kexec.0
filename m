Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-x22d.google.com ([2a00:1450:400c:c05::22d])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZhuXe-0003Kq-1K
 for kexec@lists.infradead.org; Fri, 02 Oct 2015 07:14:06 +0000
Received: by wicge5 with SMTP id ge5so19952286wic.0
 for <kexec@lists.infradead.org>; Fri, 02 Oct 2015 00:13:42 -0700 (PDT)
Date: Fri, 2 Oct 2015 09:13:39 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] kexec: fix out of the ELF headers buffer issue in
 syscall kexec_file_load()
Message-ID: <20151002071339.GA2159@gmail.com>
References: <1443531537-29436-1-git-send-email-jlee@suse.com>
 <20151001160741.07eac580c087ddb89a3e314c@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151001160741.07eac580c087ddb89a3e314c@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Baoquan He <bhe@redhat.com>, Takashi Iwai <tiwai@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, "Lee,
 Chun-Yi" <joeyli.kernel@gmail.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 29 Sep 2015 20:58:57 +0800 "Lee, Chun-Yi" <joeyli.kernel@gmail.com> wrote:
> 
> > This patch modified the code in fill_up_crash_elf_data by using
> > walk_system_ram_res instead of walk_system_ram_range to count the max
> > number of crash memory ranges. That's because the walk_system_ram_range
> > filters out small memory regions that are resided in the same page, but
> > walk_system_ram_res does not.
> > 
> > The oringial issue is page fault error that sometimes happened on big machines
> > when preparing ELF headers:
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
> > After tracing prepare_elf64_headers and prepare_elf64_ram_headers_callback,
> > the code uses walk_system_ram_res to fill-in crash memory regions information
> > to program header, so it counts those small memory regions that are resided in
> > a page area. But, when kernel was using walk_system_ram_range in
> > fill_up_crash_elf_data to count the number of crash memory regions, it filters
> > out small regions. I printed those small memory regions, for example:
> > 
> > kexec: Get nr_ram ranges. vaddr=0xffff880077592258 paddr=0x77592258, sz=0xdc0
> > 
> > Base on the code in walk_system_ram_range, this memory region will be filtered
> > out:
> > 
> > pfn = (0x77592258 + 0x1000 - 1) >> 12 = 0x77593
> > end_pfn = (0x77592258 + 0xfc0 -1 + 1) >> 12 = 0x77593
> > end_pfn - pfn = 0x77593 - 0x77593 = 0  <=== if (end_pfn > pfn) is FALSE
> > 
> > So, the max_nr_ranges that's counted by kernel doesn't include small memory
> > regions. That causes the page fault issue happened in later code path for
> > preparing EFL headers.
> > 
> > This issus is not easy to reproduce on small machines that don't have too
> > many CPUs because the allocated page aligned ELF buffer has more free space
> > to cover those small memory regions' PT_LOAD headers.
> > 
> 
> fyi, I added a cc:stable to my copy of this patch.

Note that I already have it applied, with a much improved changelog:

  e3c41e37b0f4 ("x86/kexec: Fix kexec crash in syscall kexec_file_load()")

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
