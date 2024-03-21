Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D25C54E68
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 09:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zybplOfkrsPS5JmJtmzWbF0ba4waUGrszKjak0H7lJE=; b=o9W4cmd97ud/hq
	mR34DcJa99mS4XyB1+JvACoaensdsnLa8E9BdBXws58ubuGcBvI/r2N3Q9UHN/fzEoux/gXYfAONo
	sKw8xmIGzVG9BppKBa7Pqgm8ycOpBAOtuXr3g8/MRLVDPWwTk161XtTvhHp8JPWiwGYxUWNIqz6eI
	p5JMXQZBsU5sjcEOOF1Ijp4AUbR/U+lnqBpnxuSRpdWp8g5N+tKH3hul/RuD70KTOesqO3TIfYJkt
	X4GVKvCjzX0+P9kFhKl6jkTABauKnksGM3rw5NgOTNpyOcmExhLYZ38wgy2BzI30Y+pklklsk1Sro
	DywUL7WyugZHWoFM0aXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnEYW-00000002SXB-2ofn;
	Thu, 21 Mar 2024 09:17:48 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnEYS-00000002SWN-0J2O
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 09:17:45 +0000
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V0ftc1pdbzwPtw;
	Thu, 21 Mar 2024 17:15:04 +0800 (CST)
Received: from dggpemm100003.china.huawei.com (unknown [7.185.36.68])
	by mail.maildlp.com (Postfix) with ESMTPS id E9925140158;
	Thu, 21 Mar 2024 17:17:37 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm100003.china.huawei.com (7.185.36.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 17:17:37 +0800
Received: from dggpemm500019.china.huawei.com ([7.185.36.180]) by
 dggpemm500019.china.huawei.com ([7.185.36.180]) with mapi id 15.01.2507.035;
 Thu, 21 Mar 2024 17:17:37 +0800
From: "chenhaixiang (A)" <chenhaixiang3@huawei.com>
To: Baoquan He <bhe@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, Louhongxiang <louhongxiang@huawei.com>, "wangbin (A)"
	<wangbin224@huawei.com>, "Fangchuangchuang(Fcc,Euler)"
	<fangchuangchuang@huawei.com>, lihuafei <lihuafei1@huawei.com>, "wanghai (M)"
	<wanghai38@huawei.com>, "Wangkefeng (OS Kernel Lab)"
	<wangkefeng.wang@huawei.com>
Subject: Re: Question about Address Range Validation in Crash Kernel
 Allocation
Thread-Topic: Question about Address Range Validation in Crash Kernel
 Allocation
Thread-Index: Adp7cE73weHIObK0T8WW9veSElcNWA==
Date: Thu, 21 Mar 2024 09:17:37 +0000
Message-ID: <4eeac1f733584855965a2ea62fa4da58@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.95]
MIME-Version: 1.0
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_021744_456235_3721BA95 
X-CRM114-Status: GOOD (  11.85  )
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


> > I'm sorry for the delay. Here are some details from the boot log and
> /proc/iomem:
> > The Boot log:
> > [    0.000000] Linux version 6.8.0 (root@localhost.localdomain) (gcc (GCC)
> 10.3.1, GNU ld (GNU Binutils) 2.37) #3 SMP PREEMPT_DYNAMIC Wed Mar 20
> 11:46:11 UTC 2024
> > [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.8.0
> root=/dev/mapper/root ro crashkernel=512M resume=/dev/mapper/swap
> rd.lvm.lv=root rd.lvm.lv=swap crash_kexec_post_notifiers softlockup_panic=1
> reserve_kbox_mem=16M fsck.mode=auto fsck.repair=yes panic=3
> nmi_watchdog=1 quiet rd.shell=0 memblock=debug efi=debug
> console=ttyS0,115200n8 console=tty0
> ......snip...
> > [    0.022622] memblock_phys_alloc_range: 536870912 bytes align=0x1000000
> from=0x0000000000000000 max_addr=0x0000000100000000
> reserve_crashkernel_generic+0x7c/0x220
> > [    0.022628] memblock_phys_alloc_range: 536870912 bytes align=0x1000000
> from=0x0000000100000000 max_addr=0x0000400000000000
> reserve_crashkernel_generic+0x7c/0x220
> > [    0.022632] memblock_reserve: [0x000000c01f000000-0x000000c03effffff]
> memblock_alloc_range_nid+0xee/0x170
> > [    0.022634] memblock_phys_alloc_range: 268435456 bytes align=0x1000000
> from=0x0000000000000000 max_addr=0x0000000100000000
> reserve_crashkernel_generic+0x11d/0x220
> > [    0.022638] memblock_reserve: [0x0000000049000000-0x0000000058ffffff]
> memblock_alloc_range_nid+0xee/0x170
> > [    0.022640] crashkernel low memory reserved: 0x49000000 - 0x59000000
> (256 MB)
> > [    0.022641] crashkernel reserved: 0x000000c01f000000 -
> 0x000000c03f000000 (512 MB)
> 
> Here, crashkernel,low is reserved in region:  [0x49000000 - 0x59000000] (256
> MB)
>       crashkernel,high is reserved in region: [0x000000c01f000000 -
> 0x000000c03f000000] (512 MB) ......
> > [    0.029839] memblock_reserve: [0x000000c03ffff740-0x000000c03fffff7f]
> memblock_alloc_range_nid+0xee/0x170
> > [    0.029843] e820: update [mem 0x53cbd000-0x53ccffff] usable ==>
> reserved
> > [    0.029861] TSC deadline timer available
> 
> Then here, region [0x53cbd000-0x53ccffff] is reserved in e820, and print abvoe
> "usable ==> reserved". This should be the step which prevents earlier reserved
> crashkernel,low from being added to iomem tree. I am not sure what triggered
> the e820 update.
Current analysis suggests that efi_reserve_boot_services() is causing the update of the e820 table.

> 
> How do you boot into your new 6.8.0 kernel? Used kexec -l to jump into the 2nd
> kernel, or reboot from bios/firmware boot up into 6.8.0?
It's reboot from bios boot up into 6.8.0. I attempted to revert the below patch,
 and this time the conflicting segment "53cbd000-53ccffff" also appeared in the /proc/iomem
 of the 6.8 kernel.

2d4fd058-60efefff : System RAM
  2d4fd058-58ffffff : System RAM
    49000000-58ffffff : Crash kernel
      53cbd000-53ccffff : Reserved
60eff000-704fefff : Reserved
--
  93dd424000-93dd9fffff : Kernel bss
  c01f000000-c03effffff : Crash kernel
d0000000000-d0fffffffff : PCI Bus 0000:00
  d0000000000-d00001fffff : PCI Bus 0000:01
> 
> Reverting below commit should fix your problem, can you try it?
> 
> commit 4a693ce65b186fddc1a73621bd6f941e6e3eca21
> Author: Huacai Chen <chenhuacai@kernel.org>
> Date:   Fri Dec 29 16:02:13 2023 +0800
> 
>     kdump: defer the insertion of crashkernel resources


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
