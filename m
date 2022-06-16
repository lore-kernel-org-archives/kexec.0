Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1006C433EF
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 02:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xQqo5rrsaES1tCZgxEI/4c0RVGsJ08OBO6QZWAAsjiE=; b=Te/VHUV14XFDEC
	2NfOGd5vXLXz36ApZ4D522PT79HxQKW10F22hj7MI6eZjhxrp9h8y7LsMWh60Ijp7QKRt9TC3HXbT
	t0Hj6xOzMY7Rlzg1cugxjXJkoQyimeLKkTP0ADbDhkhuwUNOcXqOnZtHaHZ8lIQYbRThERN1G5nGd
	chkuKe/XoCjBZqNnWK0QROoEK5ER2iQwkEohzrr34QIResDoTB8/KaDr72ctcF0Fyc5g60cirv8Om
	kk4xGB29xU+wLEFitVU4lawS5GLvJ1utoVRbbs1m1CdVPKcvzE5tEuWZKJ0GuwJvjgL+vBKXOD2ac
	tlHGaV1AqUs5sz+1KRsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1f96-0002Cp-RG; Thu, 16 Jun 2022 02:22:08 +0000
Received: from conssluserg-03.nifty.com ([210.131.2.82])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1f94-0002Ba-GV; Thu, 16 Jun 2022 02:22:08 +0000
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45]) (authenticated)
	by conssluserg-03.nifty.com with ESMTP id 25G2LlUN017142;
	Thu, 16 Jun 2022 11:21:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 25G2LlUN017142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1655346109;
	bh=P7NLUpsWOkVk/+cmwAKzWiFyiQWv1lSs0T4trUb3nx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rV6F1BKehrtbboii9bGfc7PAItcM1JRxcakHoPibvcz16pqgXEKPtS5lhd/QAW7MH
	 VdQ2G3UnutrazDWxlY7mEjXlm/GCl3h2Q1MEt2mCfZasHcl67bHNhuWL0QE0sT2scG
	 68VHXVOedtew2aTYFWpfsEAXkgRuBnvfYvszpnzKhM7S5aArwlDqfFas9/1Mheu3aD
	 DamRSMKHBNkA+Mp3tk6TV5JFpSZQtMsx908r4DuIv3AKciYj3MzmXvGe0MwUVKrWaf
	 YAyPSn1wcmkCnANq+7Cm+xN45il259kWvc3zbYCI7CdLiBk03JmXurZCqVfb+WNk/e
	 M+V83j6ULODmA==
X-Nifty-SrcIP: [209.85.221.45]
Received: by mail-wr1-f45.google.com with SMTP id m24so17539512wrb.10;
        Wed, 15 Jun 2022 19:21:48 -0700 (PDT)
X-Gm-Message-State: AJIora86S7gbsloued5pbELKZZL0DBsUpxu5lY6REEeT2/Dp52fixVTA
	dFp/wj31VKV8KEyZMjV7dzpWVltQd3Bnc96yQZo=
X-Google-Smtp-Source: AGRyM1vh+O9ugtHtQ+c7oRD5FHR6rGy3PRlgDlAyzYbAL4spdxQtsbMvFR1LyFHVQy8P/pdwh5hNfav2zmKoYRTWEVg=
X-Received: by 2002:a05:6000:1f09:b0:21a:5f3:316a with SMTP id
 bv9-20020a0560001f0900b0021a05f3316amr2466296wrb.682.1655346106940; Wed, 15
 Jun 2022 19:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070204.26882-1-lizhengyu3@huawei.com> <e507585a-574e-a217-479b-cb677d2df443@infradead.org>
In-Reply-To: <e507585a-574e-a217-479b-cb677d2df443@infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 16 Jun 2022 11:21:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASHC2nrszDgHzYE6WSAh0OD2f-6GpXTdMmc959vShF+JQ@mail.gmail.com>
Message-ID: <CAK7LNASHC2nrszDgHzYE6WSAh0OD2f-6GpXTdMmc959vShF+JQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: kexec: Fix build error without CONFIG_KEXEC
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Li Zhengyu <lizhengyu3@huawei.com>, palmer@rivosinc.com, mick@ics.forth.gr,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, liaochang1@huawei.com,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_192206_799415_BD54F3FA 
X-CRM114-Status: GOOD (  16.99  )
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

On Thu, Jun 2, 2022 at 1:00 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 6/1/22 00:02, Li Zhengyu wrote:
> > When CONFIG_KEXEC_FILE=y but CONFIG_KEXEC is not set:
> >
> > kernel/kexec_core.o: In function `kimage_free':
> > kexec_core.c:(.text+0xa0c): undefined reference to `machine_kexec_cleanup'
> > kernel/kexec_core.o: In function `.L0 ':
> > kexec_core.c:(.text+0xde8): undefined reference to `machine_crash_shutdown'
> > kexec_core.c:(.text+0xdf4): undefined reference to `machine_kexec'
> > kernel/kexec_core.o: In function `.L231':
> > kexec_core.c:(.text+0xe1c): undefined reference to `riscv_crash_save_regs'
> > kernel/kexec_core.o: In function `.L0 ':
> > kexec_core.c:(.text+0x119e): undefined reference to `machine_shutdown'
> > kernel/kexec_core.o: In function `.L312':
> > kexec_core.c:(.text+0x11b2): undefined reference to `machine_kexec'
> > kernel/kexec_file.o: In function `.L0 ':
> > kexec_file.c:(.text+0xb84): undefined reference to `machine_kexec_prepare'
> > kernel/kexec_file.o: In function `.L177':
> > kexec_file.c:(.text+0xc5a): undefined reference to `machine_kexec_prepare'
> > Makefile:1160: recipe for target 'vmlinux' failed
> > make: *** [vmlinux] Error 1
> >
> > These symbols should depend on CONFIG_KEXEC_CORE rather than CONFIG_KEXEC
> > when kexec_file has been implemented on RISC-V, like the other archs have
> > done.
> >
> > Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> thanks.
>
> > ---
> >  arch/riscv/kernel/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index c71d6591d539..33bb60a354cd 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -78,7 +78,7 @@ obj-$(CONFIG_SMP) += cpu_ops_sbi.o
> >  endif
> >  obj-$(CONFIG_HOTPLUG_CPU)    += cpu-hotplug.o
> >  obj-$(CONFIG_KGDB)           += kgdb.o
> > -obj-$(CONFIG_KEXEC)          += kexec_relocate.o crash_save_regs.o machine_kexec.o
> > +obj-$(CONFIG_KEXEC_CORE)     += kexec_relocate.o crash_save_regs.o machine_kexec.o
> >  obj-$(CONFIG_KEXEC_FILE)     += elf_kexec.o machine_kexec_file.o
> >  obj-$(CONFIG_CRASH_DUMP)     += crash_dump.o
> >
>
> --
> ~Randy


Perhaps, worth this:

Fixes: 6261586e0c91 ("RISC-V: Add kexec_file support")



Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
