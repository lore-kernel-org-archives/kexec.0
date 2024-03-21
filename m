Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2ACC54E58
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 07:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K7jmr4ke6+2CxcBK87KZOWuqvFds9P3bwhRKk6uEuaU=; b=pR/NrC1f8OgZnn
	edKL8fCvENjEVSQO8l8gOJ/Lt3R5xMp8SmkZol+S4X+3R8P+q/aDkuqavTCk7aGTMfyclAxpC8xSL
	euBZ3nenUpBjccGQSfwNyIQrNiVLIpV3l0IZdW4trP/mBCnbyroATaOoaLJ7o3ZoXwMqFU8hZd+3U
	S288lK+WTChKUHZIrXow7d9LjkWiX1nczD2MIsHXJNjrC42nr/oPGqHx6veMq/haWd1YKViJxconr
	L5p7o6tB1lks9jCTwUGP9fEX2N12jTBYGotIf/v4IEbxbgn89oFw299i2CEKV7HUqO577RwJ917S4
	6/A9DMHZwjOXAYo5j7uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCYI-000000028BC-2K7C;
	Thu, 21 Mar 2024 07:09:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCYF-000000028AP-3dKz
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 07:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711004962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xWT2EOfA7XUSo4v0k+JucEmD6lnqrgRj6M66iKRoktQ=;
	b=NhrF7FYtT0ZxywqVTmjFbfIORho3iTrQO1BgBk2N/GNNOiLfC9XNBlzrcjF5McmGhOdOec
	A9o33YGngs5yiJjjuGcKs6ydLzkudESffVRod+B9K+zYuBTr/u0FbtDmvl7HB2jgk2XBKk
	lmmPHb0fjJPL3AdO32paBenoFXhhL90=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-yi-c5pFxP2Oo7Tc64OLdtg-1; Thu,
 21 Mar 2024 03:09:20 -0400
X-MC-Unique: yi-c5pFxP2Oo7Tc64OLdtg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FC6F28C97CA;
	Thu, 21 Mar 2024 07:09:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0304E492BD4;
	Thu, 21 Mar 2024 07:09:18 +0000 (UTC)
Date: Thu, 21 Mar 2024 15:09:11 +0800
From: Baoquan He <bhe@redhat.com>
To: "chenhaixiang (A)" <chenhaixiang3@huawei.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	chenhuacai@kernel.org, x86@kernel.org,
	Louhongxiang <louhongxiang@huawei.com>,
	"wangbin (A)" <wangbin224@huawei.com>,
	"Fangchuangchuang(Fcc,Euler)" <fangchuangchuang@huawei.com>,
	lihuafei <lihuafei1@huawei.com>,
	"wanghai (M)" <wanghai38@huawei.com>
Subject: Re: Question about Address Range Validation in Crash Kernel
 Allocation
Message-ID: <ZfvdFxR40Duh037w@MiWiFi-R3L-srv>
References: <45065451d7d343679e150313c1ee2b62@huawei.com>
MIME-Version: 1.0
In-Reply-To: <45065451d7d343679e150313c1ee2b62@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_000924_004748_E39E877F 
X-CRM114-Status: GOOD (  10.36  )
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

On 03/21/24 at 03:22am, chenhaixiang (A) wrote:
> I'm sorry for the delay. Here are some details from the boot log and /proc/iomem:
> The Boot log:
> [    0.000000] Linux version 6.8.0 (root@localhost.localdomain) (gcc (GCC) 10.3.1, GNU ld (GNU Binutils) 2.37) #3 SMP PREEMPT_DYNAMIC Wed Mar 20 11:46:11 UTC 2024
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.8.0 root=/dev/mapper/root ro crashkernel=512M resume=/dev/mapper/swap rd.lvm.lv=root rd.lvm.lv=swap crash_kexec_post_notifiers softlockup_panic=1 reserve_kbox_mem=16M fsck.mode=auto fsck.repair=yes panic=3 nmi_watchdog=1 quiet rd.shell=0 memblock=debug efi=debug console=ttyS0,115200n8 console=tty0
......snip...
> [    0.022622] memblock_phys_alloc_range: 536870912 bytes align=0x1000000 from=0x0000000000000000 max_addr=0x0000000100000000 reserve_crashkernel_generic+0x7c/0x220
> [    0.022628] memblock_phys_alloc_range: 536870912 bytes align=0x1000000 from=0x0000000100000000 max_addr=0x0000400000000000 reserve_crashkernel_generic+0x7c/0x220
> [    0.022632] memblock_reserve: [0x000000c01f000000-0x000000c03effffff] memblock_alloc_range_nid+0xee/0x170
> [    0.022634] memblock_phys_alloc_range: 268435456 bytes align=0x1000000 from=0x0000000000000000 max_addr=0x0000000100000000 reserve_crashkernel_generic+0x11d/0x220
> [    0.022638] memblock_reserve: [0x0000000049000000-0x0000000058ffffff] memblock_alloc_range_nid+0xee/0x170
> [    0.022640] crashkernel low memory reserved: 0x49000000 - 0x59000000 (256 MB)
> [    0.022641] crashkernel reserved: 0x000000c01f000000 - 0x000000c03f000000 (512 MB)

Here, crashkernel,low is reserved in region:  [0x49000000 - 0x59000000] (256 MB)
      crashkernel,high is reserved in region: [0x000000c01f000000 - 0x000000c03f000000] (512 MB)
......
> [    0.029839] memblock_reserve: [0x000000c03ffff740-0x000000c03fffff7f] memblock_alloc_range_nid+0xee/0x170
> [    0.029843] e820: update [mem 0x53cbd000-0x53ccffff] usable ==> reserved
> [    0.029861] TSC deadline timer available

Then here, region [0x53cbd000-0x53ccffff] is reserved in e820, and print
abvoe "usable ==> reserved". This should be the step which prevents earlier
reserved crashkernel,low from being added to iomem tree. I am not sure
what triggered the e820 update.

How do you boot into your new 6.8.0 kernel? Used kexec -l to jump into
the 2nd kernel, or reboot from bios/firmware boot up into 6.8.0?

Reverting below commit should fix your problem, can you try it? 

commit 4a693ce65b186fddc1a73621bd6f941e6e3eca21
Author: Huacai Chen <chenhuacai@kernel.org>
Date:   Fri Dec 29 16:02:13 2023 +0800

    kdump: defer the insertion of crashkernel resources


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
