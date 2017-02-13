Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdA9m-0004RF-2W
 for kexec@lists.infradead.org; Mon, 13 Feb 2017 06:30:40 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile Patch 0/6] Fix --mem-usage /proc/kcore
Date: Mon, 13 Feb 2017 06:26:47 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EA4B89@BPXM01GP.gisp.nec.co.jp>
References: <cover.1486381805.git.panand@redhat.com>
In-Reply-To: <cover.1486381805.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

Hello Pratyush,

>`makedumpfile --mem-usage /proc/kcore` has been broken after kaslr specific
>modifications. I have proposed a kernel patch [0] which has been ACKed by
>Andrew Morton and is available in next-2017020 now. Hopefully, it should be
>part of upstream in v4.10 release. This kernel patch helps to fix this
>issue for both the case of kaslr enabled and disabled.
>
>To seek other's feedback, I am sending makedumpfile patches before kernel
>patch hits upstream.

Thanks for taking care of this feature.
I understand that the problem is:

 - phys_base is necessary for VtoP, but:
   - SYMBOL(phys_base) is unavailable since /proc/kcore doesn't export VMCOREINFO.
   - get_phys_base() doesn't work well since current PT_LOAD doesn't have valid p_paddr.

The new makedumpfile with this patches can show unexpected behavior since it
will refer to invalid p_paddr(always 0). Of course, also current makedumpfile cannot
work if phys_base isn't 0.

If we don't have any way to get phys_base in 1st kernel environment, 
I think we should disable this feature in older kernel (e.g. by checking kernel version).


Thanks,
Atsushi Kumagai

>[0]
>http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?h=next-20170206&id=c9d4e5d7b7fd6c74e134ca44d
>f8a5386efbc561c
>
>Baoquan He (2):
>  makedumpfile: Correct the calculation of kvaddr in
>    set_kcore_vmcoreinfo
>  makedumpfile: Discard process_dump_load
>
>Pratyush Anand (4):
>  show_mem_usage(): calculate page offset after elf load
>  initial(): call cach_init() a bit early
>  x86_64: check physical address in PT_LOAD for none direct mapped
>    regions
>  elf_info: kcore: check for invalid physical address
>
> arch/x86_64.c  |  6 ++++--
> elf_info.c     | 25 +++++--------------------
> makedumpfile.c | 12 ++++++------
> 3 files changed, 15 insertions(+), 28 deletions(-)
>
>--
>2.9.3
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
