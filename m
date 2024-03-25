Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81233C47DD9
	for <kexec@archiver.kernel.org>; Mon, 25 Mar 2024 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=f0qEeI05rNms5d4n9Ap2VB8UckgMbg3c2/8vX4OTu90=; b=wyLQQzxV2970eP
	GKi9bBPgjDI0HmCBGCpN6crZ6iya5t9l9tqhHjdU8h/sV4OqVEq3qcNLZQmCtZHa8DviEM0JFq3jQ
	G6zIZy7JURPo7B4CczwjmgWzogGFmdj5K/KVpBa800BIkSY6PSg7UMKqZQQxoGbQJ8uHi5M+oNMaO
	vFCtCXTvSzFHyR7Ow2b7h51zRilPTv2naVUzwNb79R7CQC7qJzS2wquUtUmmigFr4cDDlSILVetK3
	lj5vYBVi3ygLSmXFu8KfwciLvjElYkkN2ib9YqdS/qDb1I4qRSAyaziOmCb8PWP/jBarFrukS8llm
	yRgrsf+aLrJBKrVdJKFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roZoB-0000000EaXB-3cpM;
	Mon, 25 Mar 2024 02:11:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roZo7-0000000EaVm-1NeF
	for kexec@lists.infradead.org;
	Mon, 25 Mar 2024 02:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711332683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LZLO/mIIstkgFP8Jy9i1sdTVDL/fM4acrw4PX4Ic7og=;
	b=OiM08AIZXUR9dnEwDd3pxRzb0cFy83nxWGPgfgL5YlWBdhCbulyuCizIHUjryiHVSh4NS2
	fiswQM5wETBSFHEWHwEmMoGcRbHK2hOPJu9UNxUngN5bWkU0Xs+Ij2ojtFRUBrFBaMFUrJ
	6QrWWTtom/qRFwG8ZmXezq69ZPj6F6Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-ajRnVs39MfK8Ehnxg-IYQw-1; Sun, 24 Mar 2024 22:11:21 -0400
X-MC-Unique: ajRnVs39MfK8Ehnxg-IYQw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a469d3547c7so367850466b.0
        for <kexec@lists.infradead.org>; Sun, 24 Mar 2024 19:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711332680; x=1711937480;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZLO/mIIstkgFP8Jy9i1sdTVDL/fM4acrw4PX4Ic7og=;
        b=TD2Lb+rpLpZRiYOg5JzORXKYx8jE7H7z4Ae1we9ggKwbI+oo/qOzhfJytoncezH1Qg
         jcko8HbCVVfbZmKXYQBEwUe7FAlMATMNbAkhedjQZXlx+k2iRVMlpDeiIdD7M0S2VYDo
         Lwwsq9XfyBPtM0eRRMdius4tq08pZPZgAm+mRj1Jd1i89xMpD2CUEYw3/P5fWybHpwWv
         w7p4GaxWODlT9/cFoqCIoWDmj1k9/E6RJcSBsq//XyzKqtN3lWwoZMuMZPgxliTVe6YO
         zMiHQHh6W/iWsSxk/aJEn1TUukShRQ2oA+TXP+SQWGP2EEzcSxqr7vJ7e4UpOO2JwOrZ
         8zHA==
X-Gm-Message-State: AOJu0YxALoVcu8FIeIrMit+BojGn8dfS72P9UbSZDiKKfSrccW1WGSBc
	c3M+K98a5rV1Z9e42pv4Cw6Y6bC5/xyOCUocOKLzWDNN4pxBiOKccHg+KrMECCLxL0B/DigGT94
	q+kmk7Ooc9io1tNajq6czdSv+U60WRveMbMd9llreRCRkwlbGtyR7aJDjghMJHnvcwF0fR28RnP
	Od1/QpnIoI5Q7+y33C6O+r+1KitoZe7Gv5
X-Received: by 2002:a17:907:54b:b0:a46:e9f9:2208 with SMTP id wk11-20020a170907054b00b00a46e9f92208mr4432406ejb.3.1711332679840;
        Sun, 24 Mar 2024 19:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlvHyzb1y00a0FYKpm52OZFuMgSrNhoJRiBdIzTv8yYTOECUxWIn1dwVBxksvbNzrSvulGNb9Lk/iWgFtvNWU=
X-Received: by 2002:a17:907:54b:b0:a46:e9f9:2208 with SMTP id
 wk11-20020a170907054b00b00a46e9f92208mr4432394ejb.3.1711332679543; Sun, 24
 Mar 2024 19:11:19 -0700 (PDT)
MIME-Version: 1.0
From: Tao Liu <ltao@redhat.com>
Date: Mon, 25 Mar 2024 10:10:43 +0800
Message-ID: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
Subject: Implementing .shutdown method for efa module
To: mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, 
	jgg@ziepe.ca, leon@kernel.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_191127_551332_5D60FA45 
X-CRM114-Status: GOOD (  10.63  )
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

Hi,

Recently I experienced a kernel panic which is related to efa module
when testing kexec -l && kexec -e to switch to a new kernel on AWS
i4g.16xlarge instance.

Here is the dmesg log:

[    6.379918] systemd[1]: Mounting FUSE Control File System...
[    6.381984] systemd[1]: Mounting Kernel Configuration File System...
[    6.383918] systemd[1]: Starting Apply Kernel Variables...
[    6.385430] systemd[1]: Started Journal Service.
[    6.394221] ACPI: bus type drm_connector registered
[    6.421408] systemd-journald[1263]: Received client request to
flush runtime journal.
[    7.262543] efa 0000:00:1b.0: enabling device (0010 -> 0012)
[    7.432420] efa 0000:00:1b.0: Setup irq:191 name:efa-mgmnt@pci:0000:00:1b.0
[    7.435581] efa 0000:00:1b.0 efa_0: IB device registered
[    7.885564] random: crng init done
[    8.139857] XFS (nvme0n1p2): Mounting V5 Filesystem
d7003ecc-db6f-4bfb-bf92-60376b6a6563
[    8.265233] XFS (nvme0n1p2): Ending clean mount
[   10.555612] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

Red Hat Enterprise Linux 9.4 Beta (Plow)
Kernel 5.14.0-425.el9.aarch64 on an aarch64

ip-10-0-27-226 login: [   29.940381] kexec_core: Starting new kernel
[   30.079279] psci: CPU1 killed (polled 0 ms)
[   30.119222] psci: CPU2 killed (polled 0 ms)
[   30.199293] psci: CPU3 killed (polled 0 ms)
[   30.309214] psci: CPU4 killed (polled 0 ms)
[   30.379221] psci: CPU5 killed (polled 0 ms)
[   30.419210] psci: CPU6 killed (polled 0 ms)
[   30.489207] IRQ 191: no longer affine to CPU7
[   30.489667] psci: CPU7 killed (polled 0 ms)
..snip...
[   33.849123] psci: CPU63 killed (polled 0 ms)
[   33.849943] Bye!
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
[    0.000000] Linux version 5.14.0-417.el9.aarch64
(mockbuild@arm64-025.build.eng.bos.redhat.com) (gcc (GCC) 11.4.1
20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-42.el9) #1 SMP
PREEMPT_DYNAMIC Thu Feb 1 21:23:03 EST 2024
...snip...
[    1.012692] Freeing unused kernel memory: 6016K
[    2.370947] Checked W+X mappings: passed, no W+X pages found
[    2.370980] Run /init as init process
[    2.370982]   with arguments:
[    2.370983]     /init
[    2.370984]   with environment:
[    2.370984]     HOME=/
[    2.370985]     TERM=linux
[    2.373257] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    2.373259] CPU: 1 PID: 1 Comm: init Not tainted 5.14.0-417.el9.aarch64 #1
[    2.382240] Hardware name: Amazon EC2 i4g.16xlarge/, BIOS 1.0 11/1/2018
[    2.383814] Call trace:
[    2.384410]  dump_backtrace+0xa8/0x120
[    2.385318]  show_stack+0x1c/0x30
[    2.386124]  dump_stack_lvl+0x74/0x8c
[    2.387011]  dump_stack+0x14/0x24
[    2.387810]  panic+0x158/0x368
[    2.388553]  do_exit+0x3a8/0x3b0
[    2.389333]  do_group_exit+0x38/0xa4
[    2.390195]  get_signal+0x7a4/0x810
[    2.391044]  do_signal+0x1bc/0x260
[    2.391870]  do_notify_resume+0x108/0x210
[    2.392839]  el0_da+0x154/0x160
[    2.393603]  el0t_64_sync_handler+0xdc/0x150
[    2.394628]  el0t_64_sync+0x17c/0x180
[    2.395513] SMP: stopping secondary CPUs
[    2.396483] Kernel Offset: 0x586f04e00000 from 0xffff800008000000
[    2.397934] PHYS_OFFSET: 0x40000000
[    2.398774] CPU features: 0x0,00000101,70020143,10417a0b
[    2.400042] Memory Limit: none
[    2.400783] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

In the dmesg log, I found "[   30.489207] IRQ 191: no longer affine to
CPU7" is suspicious, which is related to efa module. After blacklist
efa module from automatic loading when bootup, the kernel panic issue
doesn't appear again.

It looks to me it is due to the efa being not properly shutdown during
kexec, so the ongoing DMA/interrupts etc overwrite the memory range.

Though the issue is reproduced on rhel's kernel, the upstream kernel
[1] doesn't have the .shutdown method implemented either. Since I'm
not very familiar with the efa driver, could you please implement the
.shutdown method in drivers/infiniband/hw/efa/efa_main.c? Thanks in
advance!

[1]: https://github.com/torvalds/linux/blob/master/drivers/infiniband/hw/efa/efa_main.c#L674

Thanks,
Tao Liu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
