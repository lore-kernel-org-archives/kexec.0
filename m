Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fcDnW-0004m4-Kh
 for kexec@lists.infradead.org; Sun, 08 Jul 2018 17:48:36 +0000
Received: by mail-vk0-x243.google.com with SMTP id l64-v6so9278024vkl.12
 for <kexec@lists.infradead.org>; Sun, 08 Jul 2018 10:48:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180708025946.GI3047@MiWiFi-R3L-srv>
References: <20180704041038.8190-3-bhe@redhat.com>
 <201807042347.hfDcKxmG%fengguang.wu@intel.com>
 <20180708025946.GI3047@MiWiFi-R3L-srv>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 8 Jul 2018 20:48:22 +0300
Message-ID: <CAHp75VcjGQutVtZ90C0huUGCY6yj8H0Wo0tMdrbLmLsRQ+x4XQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] resource: Use list_head to link sibling resource
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
To: Baoquan He <bhe@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, brijesh.singh@amd.com, Tom Lendacky <thomas.lendacky@amd.com>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, richard.weiyang@gmail.com, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, baiyaowei@cmss.chinamobile.com, Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Stephen Hemminger <sthemmin@microsoft.com>, kbuild test robot <lkp@intel.com>, linux-nvdimm@lists.01.org, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input <linux-input@vger.kernel.org>, Gustavo Padovan <gustavo@padovan.org>, Borislav Petkov <bp@suse.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, devicetree <devicetree@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Josh Triplett <josh@joshtriplett.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Yinghai Lu <yinghai@kernel.org>, Jon Derrick <jonathan.derrick@intel.com>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@01.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, kbuild test robot <fengguang.wu@intel.com>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>

On Sun, Jul 8, 2018 at 5:59 AM, Baoquan He <bhe@redhat.com> wrote:
> On 07/05/18 at 01:00am, kbuild test robot wrote:

> However, I didn't find below branch. And tried to open it in web
> broswer, also failed.

While this is kinda valid point...

> Could you help have a look at this?

...isn't obvious that you didn't change the file mentioned in a report?
Just take latest linux-next and you will see.


>> All error/warnings (new ones prefixed by >>):
>>
>> >> arch/mips/pci/pci-rc32434.c:57:11: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>>      .child = &rc32434_res_pci_mem2
>>               ^
>>    arch/mips/pci/pci-rc32434.c:57:11: note: (near initialization for 'rc32434_res_pci_mem1.child.next')
>> >> arch/mips/pci/pci-rc32434.c:51:47: warning: missing braces around initializer [-Wmissing-braces]
>>     static struct resource rc32434_res_pci_mem1 = {
>>                                                   ^
>>    arch/mips/pci/pci-rc32434.c:60:47: warning: missing braces around initializer [-Wmissing-braces]
>>     static struct resource rc32434_res_pci_mem2 = {
>>                                                   ^
>>    cc1: some warnings being treated as errors
>>
>> vim +57 arch/mips/pci/pci-rc32434.c
>>
>> 73b4390f Ralf Baechle 2008-07-16  50
>> 73b4390f Ralf Baechle 2008-07-16 @51  static struct resource rc32434_res_pci_mem1 = {
>> 73b4390f Ralf Baechle 2008-07-16  52          .name = "PCI MEM1",
>> 73b4390f Ralf Baechle 2008-07-16  53          .start = 0x50000000,
>> 73b4390f Ralf Baechle 2008-07-16  54          .end = 0x5FFFFFFF,
>> 73b4390f Ralf Baechle 2008-07-16  55          .flags = IORESOURCE_MEM,
>> 73b4390f Ralf Baechle 2008-07-16  56          .sibling = NULL,
>> 73b4390f Ralf Baechle 2008-07-16 @57          .child = &rc32434_res_pci_mem2
>> 73b4390f Ralf Baechle 2008-07-16  58  };
>> 73b4390f Ralf Baechle 2008-07-16  59
>>
>> :::::: The code at line 57 was first introduced by commit
>> :::::: 73b4390fb23456964201abda79f1210fe337d01a [MIPS] Routerboard 532: Support for base system
>>
>> :::::: TO: Ralf Baechle <ralf@linux-mips.org>
>> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>



-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
