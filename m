Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C920FC4167B
	for <kexec@archiver.kernel.org>; Sat,  2 Dec 2023 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z/iTzXGY38mDb+R6U7WSDwzKzLCsGXnKAvEf4j+DGOA=; b=lfcnX4SOSIPLGK
	Aq/4xrl34KNc8TNdE+5lQOtsO/onTgwyxGzvTzji60z6PYSVyk7KBC4g04tAMN7vo+gH6wllVIg34
	jIFBo3Dm7xL83qUpw3GdgfbSzlJRfdKSppVJ8x+02x2jm6BtzU0LFS/UST4Nvefp4Qc4UWMvmV7AE
	SEjckp6G6j792N6i90EHgehqWTeWZFNzOFzNx42POOghDS1JO6nWqSYcqVqMZpZbXnOG9j51ykVGq
	BMeDVWtozVBKDdRuhowOz8CTC7bQgEFcd6cfIq9CXUwinr+F9K/natUklVL5kwNd1RQY9e4XRHKBd
	jHh3KyhezvS+4icrlLPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9Myg-00FQON-01;
	Sat, 02 Dec 2023 10:12:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9Mye-00FQNR-1J
	for kexec@bombadil.infradead.org;
	Sat, 02 Dec 2023 10:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Om88+ItOYiUR9BkfKy8zBYVtfohIDz0iD3ZLER6hOtY=; b=IzZ03cABuKuctUjyMS84/HrbAa
	6nSYxnCxAnWZUt+K3Vm+seR5ld0qUNoN6XgBIY3nGS6FpuAvthSwbnVp5PzhcTUJK8B5zfGggWjRq
	DuNk0xf9zftWfcv4MDMWxm6jle24fnpIAAvYQoGFyKRx+CGDt/9nB2lkakSzpCY+XmmtL5fQCpvQD
	94+USi9o1X/N1AdQmqRWH2e6El9TcDYWYaCgINGEUN1AyIQGn23F596dygwiLflf+kXqGV3QSkygr
	FRM9GX1Hpkr/C8v/4Vf+aLRH4c2PBug2Mp1jOqkEk1WN5fAkAX+aALBt326lrgHQG9WAqECtMuKKs
	rcMkkM7g==;
Received: from mail.loongson.cn ([114.242.206.163])
	by desiato.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9MyW-003A05-11
	for kexec@lists.infradead.org;
	Sat, 02 Dec 2023 10:11:57 +0000
Received: from loongson.cn (unknown [112.22.232.197])
	by gateway (Coremail) with SMTP id _____8CxfOrXAmtltl8+AA--.31534S3;
	Sat, 02 Dec 2023 18:11:36 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.232.197])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axm+TUAmtlkWdSAA--.53067S2;
	Sat, 02 Dec 2023 18:11:35 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: horms@kernel.org
Cc: chenhuacai@kernel.org,
	kexec@lists.infradead.org,
	wangrui@loongson.cn
Subject: Re: [PATCH] LoongArch: Load vmlinux.efi to the link address
Date: Sat,  2 Dec 2023 18:11:28 +0800
Message-ID: <20231202101128.133999-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231127134653.GC3354982@kernel.org>
References: <20231127134653.GC3354982@kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8Axm+TUAmtlkWdSAA--.53067S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF48Aw18Cr13ArW7GF4kGrX_yoW8ZFWDpr
	1UuFyrKr4xJr98GFyDt34Y9rn8J3sY9FW7JF1SkFWFkF4rJw1xXr45ta9rZF1Dtr45Zr1j
	vFnrtw1YqF45GwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231202_101153_627046_D8D8A07D 
X-CRM114-Status: GOOD (  10.20  )
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

> On Fri, Nov 24, 2023 at 11:46:58PM +0800, WANG Rui wrote:
> > Currently, kexec loads vmlinux.efi to address 0 instead of the link
> > address. This causes kexec to fail to boot the new vmlinux.efi on qemu.
> > 
> >   pei_loongarch_load: kernel_segment: 0000000000000000
> >   pei_loongarch_load: kernel_entry:   00000000015dc000
> >   pei_loongarch_load: image_size:     0000000001f30000
> >   pei_loongarch_load: text_offset:    0000000000200000
> >   pei_loongarch_load: phys_offset:    0000000000000000
> >   pei_loongarch_load: PE format:      yes
> >   loongarch_load_other_segments:333: command_line: kexec console=ttyS0,115200
> >   kexec_load: entry = 0x15dc000 flags = 0x1020000
> >   nr_segments = 2
> >   segment[0].buf   = 0x7fffef664010
> >   segment[0].bufsz = 0x1de9a00
> >   segment[0].mem   = (nil)
> >   segment[0].memsz = 0x1f30000
> >   segment[1].buf   = 0x555555e480b0
> >   segment[1].bufsz = 0x200
> >   segment[1].mem   = 0x1f30000
> >   segment[1].memsz = 0x4000
> > 
> > This patch adds `text_offset` when adding kernel segment to load
> > vmlinux.efi to the link address.
> > 
> >   pei_loongarch_load: kernel_segment: 0000000000000000
> >   pei_loongarch_load: kernel_entry:   00000000015dc000
> >   pei_loongarch_load: image_size:     0000000001f30000
> >   pei_loongarch_load: text_offset:    0000000000200000
> >   pei_loongarch_load: phys_offset:    0000000000000000
> >   pei_loongarch_load: PE format:      yes
> >   loongarch_load_other_segments:335: command_line: kexec console=ttyS0,115200
> >   kexec_load: entry = 0x15dc000 flags = 0x1020000
> >   nr_segments = 2
> >   segment[0].buf   = 0x7ffff1a04010
> >   segment[0].bufsz = 0x1de9a00
> >   segment[0].mem   = 0x200000
> >   segment[0].memsz = 0x1f30000
> >   segment[1].buf   = 0x555555b28098
> >   segment[1].bufsz = 0x200
> >   segment[1].mem   = 0x2130000
> >   segment[1].memsz = 0x4000
> > 
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
> 
> Thanks, applied.

Hi Simon,

The patch v1 breaks the real machine. Could you please revert it and just keep v2? Thanks.

- Rui


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
