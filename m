Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gIFEZ-0007cc-Ic
 for kexec@lists.infradead.org; Thu, 01 Nov 2018 15:50:17 +0000
Received: by mail-lj1-f194.google.com with SMTP id z80-v6so12421748ljb.8
 for <kexec@lists.infradead.org>; Thu, 01 Nov 2018 08:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <1540593788-28181-1-git-send-email-bhsharma@redhat.com>
 <201810301913.XPGMpz0a%fengguang.wu@intel.com>
In-Reply-To: <201810301913.XPGMpz0a%fengguang.wu@intel.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 1 Nov 2018 21:19:46 +0530
Message-ID: <CACi5LpP4+H-9X3AuAt3j=SA5Y4Qk6nA-7D4HdcRF8JGaqKx_fg@mail.gmail.com>
Subject: Re: [PATCH] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
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
To: lkp@intel.com
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, James Morse <james.morse@arm.com>, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Sandoval <osandov@fb.com>, Borislav Petkov <bp@alien8.de>, kbuild-all@01.org, Dave Anderson <anderson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

On Tue, Oct 30, 2018 at 5:02 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Bhupesh,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on v4.19 next-20181030]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Bhupesh-Sharma/x86_64-vmcoreinfo-Append-page_offset_base-to-vmcoreinfo/20181027-075816
> config: x86_64-randconfig-s4-10301649 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    arch/x86/kernel/machine_kexec_64.o: In function `arch_crash_save_vmcoreinfo':
> >> arch/x86/kernel/machine_kexec_64.c:359: undefined reference to `page_offset_base'
> >> arch/x86/kernel/machine_kexec_64.c:359: undefined reference to `page_offset_base'
>
> vim +359 arch/x86/kernel/machine_kexec_64.c
>
>    352
>    353  void arch_crash_save_vmcoreinfo(void)
>    354  {
>    355          VMCOREINFO_NUMBER(phys_base);
>    356          VMCOREINFO_SYMBOL(init_top_pgt);
>    357          vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>    358                          pgtable_l5_enabled());
>  > 359          VMCOREINFO_NUMBER(page_offset_base);
>    360
>

Thanks I can reproduce the issue, I will send a v2 shortly to fix the
build issue.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
