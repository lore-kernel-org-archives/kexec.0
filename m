Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F90D32D8C
	for <kexec@archiver.kernel.org>; Tue, 12 Nov 2024 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SbsbpXU21CLT7MHfY0zzb1hyYq5uEs/Qv3w5rzPC1mw=; b=ExSaI1wioEAUYi
	8qbBGkG5t3C5RrfRXsqJ56o+bI5qlcINqrDfzHfILgz+IUD02IpH90VN7eL012OSSiKGUs4aVBBIr
	wLsVhQ0U6ygg65W/QveBY666tc7u+XHk8Z9T26aUrTsN0POp1LIqYJ65Yn2eeslEcwDoupJ8/yMD/
	aJlmA9k2veyK7mbkGOeGKmaPrkguFEamnMbSx+Fj/kWRcXjyI7GEbe6epeTCca+q/vqGntin3IQU0
	zBtSChWMnS95xou+nN4E94a+9gXBwxYUbm891GqmMKJuY6OTpEqoFDO1dwpAMzLyTmqRjqPgg6pbq
	KvJ1ZbP/boRuGLdHyfeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAo4G-0000000320Y-1rcb;
	Tue, 12 Nov 2024 10:24:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAnul-00000002zih-3FaG
	for kexec@bombadil.infradead.org;
	Tue, 12 Nov 2024 10:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NI2FSn6wR9NllQpa1yQiYOWhZtDJAgUAJVvJXNP2daY=; b=Lz8wX3hh3vIxhltmyWPz1aRlQn
	kWu59NA/aM1/3WjpsFfFE3ZgkPK8u9TMSbPtwr3mEzLidEio5ah/99Y7tmc/L7Ptfp/RwQ90hxljZ
	81C3LnCjpVBNCclD1/BWuQOqwMchTzPgMG10fSvD9OPaU6Mfg9JXHpqW2Zst8tqOPfrPu4OIpnrvl
	SEOButaG95BZKrqdY7Ui/yna2q4m+WpHri4Z/ma18p3GpODoZ1lpRpHqsQOmoPFg7t7lHk+Sox0fB
	XFQ3iqjB2LKTE8MGIO/lNohTEnJ/uG3nPEcACbfKTZ01p/nENMqyFn+L1zIAhgntrvLuaWE5zy+yH
	RpZAfrRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAnui-0000000EDfU-1WT0;
	Tue, 12 Nov 2024 10:14:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F4081300478; Tue, 12 Nov 2024 11:14:23 +0100 (CET)
Date: Tue, 12 Nov 2024 11:14:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org,
	jpoimboe <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 2/2] x86/kexec: Add data section to relocate_kernel
Message-ID: <20241112101423.GO22801@noisy.programming.kicks-ass.net>
References: <1983c62c02b863f6d70198730dbb55a1ef7ceb9f.camel@infradead.org>
 <20241108052241.3972433-1-dwmw2@infradead.org>
 <20241108052241.3972433-2-dwmw2@infradead.org>
 <B26FDB75-D8F3-4D9C-9078-C536C461A7CF@zytor.com>
 <1e8f11982ad0754d8123c143a514969fa2a07c05.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e8f11982ad0754d8123c143a514969fa2a07c05.camel@infradead.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Nov 12, 2024 at 08:44:33AM +0000, David Woodhouse wrote:
> On Fri, 2024-11-08 at 12:26 +0100, H. Peter Anvin wrote:
> > =

> > > --- a/arch/x86/kernel/vmlinux.lds.S
> > > +++ b/arch/x86/kernel/vmlinux.lds.S
> > > @@ -100,7 +100,7 @@ const_pcpu_hot =3D pcpu_hot;
> > > =A0=A0=A0=A0=A0=A0=A0=A0. =3D ALIGN(PAGE_SIZE);=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0\
> > > =A0=A0=A0=A0=A0=A0=A0=A0__relocate_kernel_start =3D .;=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > > =A0=A0=A0=A0=A0=A0=A0=A0*(.text.relocate_kernel);=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > > -=A0=A0=A0=A0=A0=A0=A0*(.rodata.relocate_kernel);=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > > +=A0=A0=A0=A0=A0=A0=A0*(.data.relocate_kernel);=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\

Why are we having data in the middle of the text section?

> > > =A0=A0=A0=A0=A0=A0=A0=A0__relocate_kernel_end =3D .;
> > > #else
> > > #define KEXEC_RELOCATE_KERNEL_TEXT
> > =

> > Looks good at first glance. I'm currently traveling so I haven't
> > fully reviewed it though.
> =

> Turns out it doesn't help much. It's neater, obviously, but objtool
> still wants to disassemble the .data.relocate_kernel section after it
> gets included in the overall kernel text section.

Objtool only decodes stuff that has SHF_EXECINSTR set. Why would your
data sections have that on?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
