Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B587C25B08
	for <kexec@archiver.kernel.org>; Mon,  8 Aug 2022 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FCd3afCcg0vVNaUA/Yozq4jjRbm1AZGoCrh/vDAa31M=; b=Bv7y4K9/crG5L3
	egGNpbNUZVnjpKLEJ9JfX4ZwTGlVHEnHHXfI79nQ83mExXgHgq/d2da9kp0AwmS4NRyDVWzkJysRO
	7J96zAq/XRZcZIhBJrYg7TCj8mNSu0gqDQxxGFOXukUqSI2oKu9l3Drem/ywgdhUigy8L8Vn6ANih
	Ab5VIoLDCaPQzo8XN/HQoWJ4d06+D4EHzMR3oHf19w7Mzfg1Qtjr0J8X6aM1Bl3SGzrIf0HsHIRMX
	Th77HuX+yuTtH8Fj7MpU2bA+x9nxGJCDyWL4DPue2HITLTlX7YKWmqAn4pSnXl3dovnl0fOa3BS1D
	XP9UzOCq8ry/BrqCZCdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL4wO-00EkJT-MN; Mon, 08 Aug 2022 15:45:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL4wM-00EkFo-AP
	for kexec@lists.infradead.org; Mon, 08 Aug 2022 15:45:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A894861025
	for <kexec@lists.infradead.org>; Mon,  8 Aug 2022 15:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE1C4347C
	for <kexec@lists.infradead.org>; Mon,  8 Aug 2022 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659973503;
	bh=0+M//WFj4QufhDanyiSvlllCgJP3lcJFBIdND72VH8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FhbrpMMaW2VUB25O64jvPFojr9qmr2z94jzXHOwlQcZjFoOeD+MqjEAnArO/n1t4v
	 3e69NiO/Rw3splQ8Vi6UGj4ihHsI/STjI4gQ4tiNRgENmj/aDlU2hw0Py6Xb4HsRPM
	 AMFoPYG9njomAJGUXzxlgvy5s+HP6+xorvEPjhWNLoLO1EAHl2b2nrEk5XweEf5XmQ
	 MOh42c1f9tfg5dUf/0H9aiKilYkN+zRoHI2F3RU2x1QgBwERXyhA7AWr2kW89Mp2KV
	 EQ0pQwlqVJwr4zQ9HjC2JHvhw5uKq7O0/UbNgchFQQvnU4FZ/OiMxaPQZoTeAAQ5jy
	 lB8X0UGSzZTcA==
Received: by mail-ua1-f52.google.com with SMTP id s7so3660271uao.4
        for <kexec@lists.infradead.org>; Mon, 08 Aug 2022 08:45:03 -0700 (PDT)
X-Gm-Message-State: ACgBeo1lYwNuhpQQPInZBUUxrbEihiiIy/bNJqPiuG/gzQ9rA6r1tsx7
	yma1MMMmdjhJJHZ/Q98JEifZYEOR+Htd3BSnFQ==
X-Google-Smtp-Source: AA6agR6mVFjC5VBa80Aifh09hljy1mvccPoQFLhpS0jUnBD7z5E4KFhe92+/ImOsfK5s/YfuXt9X9tMfwqH2jC4zR10=
X-Received: by 2002:ab0:2505:0:b0:384:cc62:9a75 with SMTP id
 j5-20020ab02505000000b00384cc629a75mr7586379uan.36.1659973502267; Mon, 08 Aug
 2022 08:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com> <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
 <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
In-Reply-To: <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Aug 2022 09:44:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLXGSPzCDUD6sD-CsziPw0PWxSTocNfxnwOGR_-ALos9w@mail.gmail.com>
Message-ID: <CAL_JsqLXGSPzCDUD6sD-CsziPw0PWxSTocNfxnwOGR_-ALos9w@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Baoquan He <bhe@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, kexec@lists.infradead.org, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Thomas Lendacky <thomas.lendacky@amd.com>, efault@gmx.de, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@redhat.com>, sourabhjain@linux.ibm.com, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220808_084514_479684_44091354 
X-CRM114-Status: GOOD (  26.44  )
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

On Mon, Aug 8, 2022 at 9:19 AM Eric DeVolder <eric.devolder@oracle.com> wrote:
>
>
>
> On 8/7/22 22:25, Baoquan He wrote:
> > Hi Eric,
> >
> > On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> >> The use of __weak is being eliminated within kexec sources.
> >> The technique uses macros mapped onto inline functions in
> >> order to replace __weak.
> >>
> >> This patchset was using __weak and so in order to replace
> >> __weak, this patch introduces arch/*/asm/crash.h, patterned
> >> after how kexec is moving away from __weak and to the macro
> >> definitions.
> >
> > Are you going to replace __weak in kexec of arll ARCHes? I don't see
> > your point why all these empty header files are introduced. Wondering
> > what's impacted if not adding these empty files?
>
> Hi Baoquan,
> In this patchset, to file include/linux/crash_core.h I added the line #include <asm/crash.h>.
> I patterned this after how include/linux/kexec.h does #include <asm/kexec.h>.
>
> For kexec, the items that were __weak are refactored into corresponding asm/kexec.h.
>
> I followed suit for crash __weak items. File crash_core.h now #include's asm/crash.h and
> so that file needs to be present for every arch, else build failures ensue. It turns out
> x86_64 already had this file.
>
> At this time, I was not planning on converting the other arch's __weak to asm/crash.h, but at least
> with these empty files, the infrastructure is in place for when that does occur.

asm-generic is the right location for default asm headers. I'm not
really sure you even need them as you mainly seem to be using the
header to enable a feature. That's normally done by the arch selecting
a kconfig option. But as Borislav previously pointed out, you don't
need a new option here if the arch must provide support when kexec and
hotplug are enabled/supported.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
