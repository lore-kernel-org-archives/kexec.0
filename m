Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47B4C28D13
	for <kexec@archiver.kernel.org>; Mon, 22 Aug 2022 07:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l4HuBH5iBWKu9I1Ts08QrCY9uSCZhdpxug7VEUOnHQQ=; b=dStZzrKhl0f/wD
	QELSL41hlqThzqnK17VE+47erXqlupSDznw5f/UvnUph+barnHtkC7vk8qS3js7MGD2RRefjj/Rih
	XCbEcLmh/iQFYfbX/xAzF9WGRZtomqoU72nwcodLO/Txovlz7PAuYMyq66QU/e5n7/M7wIWiMVEgu
	ScGz/nb7LNb9vmDqLPPFqj0EoZVamtsfoWGbTffpe5vD4m0nFuANIg0QQJ8+znWKrg0Yq7hXvCoE1
	lS8bImaH3tVDTXqiCs/l17gAde19vGOwUHIZAQBVGnBlwD9wHrQZFg8X3R9PdlQa04OeCzsJ8/uWf
	jetI2l6cdP6WXHsw+xuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ1st-005wbu-DL; Mon, 22 Aug 2022 07:30:07 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ1s3-005wLb-6v; Mon, 22 Aug 2022 07:29:29 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11c5ee9bf43so11885935fac.5;
        Mon, 22 Aug 2022 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AWMBPRr/4IoSHG6OnWgIerpaeuUvdG2MxcgosAs8QME=;
        b=WyHlSiL/cogs/slMxPIprKWHpBEJv6mxi+qagsSNw0EQrjkWO1MadhsmS+wqxHov8J
         emhoGrP/IxDiUp4yx6O9XSlfHFVrnjaWlDZmiThH4JpLd1a1xEr9ksbkQuaBq0o5IrRZ
         7xWaHgqRmMeDPKk43eJdc8Q5Jg3IkmDA5Xi6gEvVN/s0Q55SJqLpqElKDG8viPdG/LDr
         tslvl7Ia3cy8MnCjVr6gTBqfsedy4YECQytrVhO4OVfAIaDzWFXuW/9HwG2ZhiXIthy9
         iIWB5V4wSguw8F71YsVfk611xl0cRkZ/TY0hLVf8PsA8zh9fP3f1rHjNPnbomOXy9xxA
         2iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AWMBPRr/4IoSHG6OnWgIerpaeuUvdG2MxcgosAs8QME=;
        b=mMeDISXaSvh+qZxfJWjUTjAXXZRelHHAeEAyyDQ0MRbtrMPZSZzp9vSrr1FBoq/DVJ
         sIY3bXSL1mz9ai680Kr4B+OuYFTQiGvPgyEo1wCj4A2z4D9iLLM26geNjD49XBOsQ1/t
         GFtvkG+zKbuUyvaNLLg5cWo/rijRqPgm8fALMtXiSaJ+AY7X1Bb+hfXomUagVzs1LaY+
         xkEf6unEbgv3gqlo+l5xN3K8GBihOMFKgudGgSB8FJmypGcSa8jGrSMYPwPMI7RrZW5V
         QD5osFbX1AbaQ5QfglivRU1ZxCrTvNYTLI8paOSHmM3HKIheHla1vptgjIMx6NkEHDnV
         YHAg==
X-Gm-Message-State: ACgBeo0+3k+ZXVrA3RFHt+MRvX28FLP2NvZvZp+hL4tLYwOIVY/tpptf
	0kZakLn3xMCiSnZWe34avekFes3W5DYRKuSQmcw=
X-Google-Smtp-Source: AA6agR7gdLtQHLlIczC7dHdWojf0lsvnUDwq32acFzmX4UI62LA51MXLPjl5CaaJoUOepUAgk06bIuASAx0RALfAjks=
X-Received: by 2002:a05:6870:6086:b0:10b:8905:14c3 with SMTP id
 t6-20020a056870608600b0010b890514c3mr11518550oae.255.1661153352781; Mon, 22
 Aug 2022 00:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220813031753.3097720-1-xianting.tian@linux.alibaba.com> <CANU+ZyckYehZaX0uSLPiyLKq2TMmTkqs3O6i4=NerdjXGGxBDA@mail.gmail.com>
In-Reply-To: <CANU+ZyckYehZaX0uSLPiyLKq2TMmTkqs3O6i4=NerdjXGGxBDA@mail.gmail.com>
From: Yixun Lan <yixun.lan@gmail.com>
Date: Mon, 22 Aug 2022 07:28:52 +0000
Message-ID: <CALecT5g-cRDz8zwpHnoVEuZXMNRkZ9LUagEmCUJG0RM-e+_4Sw@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] Support RISCV64 arch and common commands
To: lijiang <lijiang@redhat.com>
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>, 
	"Discussion list for crash utility usage, maintenance and development" <crash-utility@redhat.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	heinrich.schuchardt@canonical.com, guoren@kernel.org, 
	=?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	linux-riscv <linux-riscv@lists.infradead.org>, kexec@lists.infradead.org, 
	hschauhan@nulltrace.org, huanyi.xj@alibaba-inc.com, 
	lifang_xia@linux.alibaba.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220822_002926_597892_6D57CD01 
X-CRM114-Status: GOOD (  25.46  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi lijiang

On Mon, Aug 22, 2022 at 3:56 AM lijiang <lijiang@redhat.com> wrote:
>
> Hi, Xianting
> Thank you for the update.
> On Sat, Aug 13, 2022 at 11:18 AM Xianting Tian <xianting.tian@linux.alibaba.com> wrote:
>>
>> This series of patches are for Crash-utility tool, it make crash tool support
>> RISCV64 arch and the common commands(*, bt, p, rd, mod, log, set, struct, task,
>> dis, help -r, help -m, and so on).
>>
>> To make the crash tool work normally for RISCV64 arch, we need a Linux kernel
>> patch, which exports the kernel virtual memory layout, va_bits, phys_ram_base
>> to vmcoreinfo, it can simplify the development of crash tool.
>>
>> The Linux kernel patch set:
>> https://lore.kernel.org/linux-riscv/20220811074150.3020189-1-xianting.tian@linux.alibaba.com/
>> [ Patch 1 ~ 4 already merged to Linux for-next branch, targeted for 5.20;
>>   Patch 5, 6 already merged to Palmer's riscv-crash branch:
>>   https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-crash ]
>>
>
> Can you also help to share the patch link for kexec-tools? Or share your loading steps and generate a vmcore in riscv64 system?
>
> I tried it with kexec-tools and got the following error:
>
> [root@fedora-riscv kexec-tools]# ./configure
> checking for gcc... gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables...
> checking whether we are cross compiling... no
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ISO C89... none needed
> checking build system type... riscv64-unknown-linux-gnu
> checking host system type... riscv64-unknown-linux-gnu
> checking target system type... riscv64-unknown-linux-gnu
> configure: error: unsupported architecture riscv64
>
> Thanks.
> Lianbo
>
>> This series of patches are tested on QEMU RISCV64 env and SoC platform of
>> T-head Xuantie 910 RISCV64 CPU.
>>
>> ====================================
>>   Some test examples list as below
>> ====================================
>> ... ...
>>       KERNEL: vmlinux
>>     DUMPFILE: vmcore
>>         CPUS: 1
>>         DATE: Fri Jul 15 10:24:25 CST 2022
>>       UPTIME: 00:00:33
>> LOAD AVERAGE: 0.05, 0.01, 0.00
>>        TASKS: 41
>>     NODENAME: buildroot
>>      RELEASE: 5.18.9
>>      VERSION: #30 SMP Fri Jul 15 09:47:03 CST 2022
>>      MACHINE: riscv64  (unknown Mhz)
>>       MEMORY: 1 GB
>>        PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>>          PID: 113
>>      COMMAND: "sh"
>>         TASK: ff60000002269600  [THREAD_INFO: ff60000002269600]
>>          CPU: 0
>>        STATE: TASK_RUNNING (PANIC)
>>
>> carsh>
>>
>> crash> p mem_map
>> mem_map = $1 = (struct page *) 0xff6000003effbf00
>>
>> crash> p /x *(struct page *) 0xff6000003effbf00
>> $5 = {
>>   flags = 0x1000,
>>   {
>>     {
>>       {
>>         lru = {
>>           next = 0xff6000003effbf08,
>>           prev = 0xff6000003effbf08
>>         },
>>         {
>>           __filler = 0xff6000003effbf08,
>>           mlock_count = 0x3effbf08
>>         }
>>       },
>>       mapping = 0x0,
>>       index = 0x0,
>>       private = 0x0
>>     },
>>   ... ...
>>
>> crash> mod
>>      MODULE       NAME             BASE         SIZE  OBJECT FILE
>> ffffffff0113e740  nvme_core  ffffffff01133000  98304  (not loaded)  [CONFIG_KALLSYMS]
>> ffffffff011542c0  nvme       ffffffff0114c000  61440  (not loaded)  [CONFIG_KALLSYMS]
>>
>> crash> rd ffffffff0113e740 8
>> ffffffff0113e740:  0000000000000000 ffffffff810874f8   .........t......
>> ffffffff0113e750:  ffffffff011542c8 726f635f656d766e   .B......nvme_cor
>> ffffffff0113e760:  0000000000000065 0000000000000000   e...............
>> ffffffff0113e770:  0000000000000000 0000000000000000   ................
>>
>> crash> vtop ffffffff0113e740
>> VIRTUAL           PHYSICAL
>> ffffffff0113e740  8254d740
>>
>>    PGD: ffffffff810e9ff8 => 2ffff001
>>   P4D: 0000000000000000 => 000000002fffec01
>>   PUD: 00005605c2957470 => 0000000020949801
>>   PMD: 00007fff7f1750c0 => 0000000020947401
>>    PTE: 0 => 209534e7
>>  PAGE: 000000008254d000
>>
>>   PTE     PHYSICAL  FLAGS
>> 209534e7  8254d000  (PRESENT|READ|WRITE|GLOBAL|ACCESSED|DIRTY)
>>
>>       PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
>> ff6000003f0777d8 8254d000                0        0  1 0
>>
>> crash> bt
>> PID: 113      TASK: ff6000000226c200  CPU: 0    COMMAND: "sh"
>>  #0 [ff20000010333b90] riscv_crash_save_regs at ffffffff800078f8
>>  #1 [ff20000010333cf0] panic at ffffffff806578c6
>>  #2 [ff20000010333d50] sysrq_reset_seq_param_set at ffffffff8038c03c
>>  #3 [ff20000010333da0] __handle_sysrq at ffffffff8038c604
>>  #4 [ff20000010333e00] write_sysrq_trigger at ffffffff8038cae4
>>  #5 [ff20000010333e20] proc_reg_write at ffffffff801b7ee8
>>  #6 [ff20000010333e40] vfs_write at ffffffff80152bb2
>>  #7 [ff20000010333e80] ksys_write at ffffffff80152eda
>>  #8 [ff20000010333ed0] sys_write at ffffffff80152f52
>>
>> -------
>> Changes V1 -> V2:
>>  1, Do the below fixes based on HAGIO KAZUHITO's comments:
>>     Fix build warnings,
>>     Use MACRO for Linux version,
>>     Add description of x86_64 binary for riscv64 in README,
>>     Fix build error for the "sticky" target for build on x86_64,
>>     Fix the mixed indent.
>>  2, Add 'help -m/M' support patch to this patch set.
>>  3, Support native compiling approach, which means the host OS distro
>>     is also a riscv64 (lp64d) Linux, based on Yixun Lan's comments.
>>  4, Use __riscv and __riscv_xlen instead of __riscv64__ based on Yixun Lan's comments.
>> Changes V2 -> V3:
>>  1, Fix coding style, avoid including the header twice, move free() to right place,
>>     introduce VM_FLAGS and so on based on Li Jiang's comments.
>>  2, Adjust the implementation of riscv64_verify_symbol(refer to the logic of x86_64_verify_symbol)
>>     as KSYMS_START isn't set when verify symbol in some case.
>>
>>
>> Xianting Tian (9):
>>   Add RISCV64 framework code support
>>   RISCV64: Make crash tool enter command line and support some commands
>>   RISCV64: Add 'dis' command support
>>   RISCV64: Add 'irq' command support
>>   RISCV64: Add 'bt' command support
>>   RISCV64: Add 'help -r' command support
>>   RISCV64: Add 'help -m/M' command support
>>   RISCV64: Add 'mach' command support
>>   RISCV64: Add the implementation of symbol verify
>>
>>  Makefile            |    7 +-
>>  README              |    4 +-
>>  configure.c         |   43 +-
>>  defs.h              |  252 +++++++-
>>  diskdump.c          |   21 +-
>>  help.c              |    2 +-
>>  lkcd_vmdump_v1.h    |    8 +-
>>  lkcd_vmdump_v2_v3.h |    8 +-
>>  netdump.c           |   22 +-
>>  ramdump.c           |    2 +
>>  riscv64.c           | 1491 +++++++++++++++++++++++++++++++++++++++++++
>>  symbols.c           |   10 +
>>  12 files changed, 1848 insertions(+), 22 deletions(-)
>>  create mode 100644 riscv64.c
>>
>> --
>> 2.17.1
>>

FYI, take a look at
lists.infradead.org/pipermail/linux-riscv/2021-October/008773.html

also need this extra fix
lists.infradead.org/pipermail/linux-riscv/2022-August/018398.html

and just follow normal scheme to use kexec + crash, there is nothing different

Yixun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
