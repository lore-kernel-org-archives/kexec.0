Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E33EE77188
	for <kexec@archiver.kernel.org>; Mon,  6 Jan 2025 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lb4ujHOCBnXnDLQMGCGiEHAzoDL91LOqVg57rFPfdz8=; b=ant0bXL4HeMu6eZpaftzETVW0K
	IlqoUU2Iv1jedb3AtGxUwQiGTXZwJnDP/WKR4To35wsTXgaLZDRppwjoInQxBWPt0WqJDiHMHR3GB
	O3mb2g6JAB7bDdFL2y45RsX+NWhKZ/R0KDZ9AY1xzIqEmDu0Vhg+++sGdoht2XhsprB7XLpvYWqF2
	iluOkuFgCmOS+74UqjXiQRbxdGh7OYmqqvtFYkGNpuETRx2wabx6+iqEb/jZnAXkrT2AL05XBz8zB
	GaDh+8O+s16x5+JVCZzgrWD3EJ9XfDCw3MqzNBG8UxkJs5v4E+tIhusnnGOYAcewauEMFvBHy6efY
	hOnIjEUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqnY-000000026EQ-2Tp8;
	Mon, 06 Jan 2025 17:21:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUpfY-00000001u0l-02UX
	for kexec@bombadil.infradead.org;
	Mon, 06 Jan 2025 16:09:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lb4ujHOCBnXnDLQMGCGiEHAzoDL91LOqVg57rFPfdz8=; b=N1YfHxnHgoBMZQ7PomYWqJXzXm
	v93ulzKwTVqwauS81E/jB2iiAAfHz7Qlsz8kerXdGOo6dYvrSKGnosIPi2HOO/xCxBVU7Ax7Z2ufk
	hEIoTa+hBSTAInPVwfH5+CPAuEKK3aY208rhoX8+bA2g//IOTHdW2+jaiTDQVww4pjE64aSD8HRBJ
	+u5+L4pj0apsJpQCPnqDzCMHiA2VHXfPVoknAqx72awJPvqowmWdAT9mBc1eMbCFtMscsIA3jAtez
	5bwFog7b72ghtwDJBthPVNXbCkErxi/GAaIrVWgRC3zuS9zYbyHe78iyFPl0Ty0kgJN8hHX1NPP3Q
	dOWmIf3w==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUpfU-00000008xxO-3cId
	for kexec@lists.infradead.org;
	Mon, 06 Jan 2025 16:09:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 96F4CA41654
	for <kexec@lists.infradead.org>; Mon,  6 Jan 2025 16:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271F9C4CED2
	for <kexec@lists.infradead.org>; Mon,  6 Jan 2025 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736179765;
	bh=DWdPT4GRJfFWhiHcZ0jRg3zMpjQWsxS843DGOAwaQT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oiM34Hh9vvvaTuWKZp5R5487tEV8Hzp2b6S8xIWhHtrG1udBT1nG2aCYkb3xyB9db
	 hhLpwTagxGlzL80yZ43TJvfbfDhxR251PT0OZSfChYbrlSd7+ARCYOwEzzcBWIgmtP
	 QW6RIALj2wwZC4VF8teeMfeoivDHO4qEI90NXrGBveicuzg/74zYQcISxsZNcK/rzP
	 PA/i2ZpZMugDCXaT5msAKZ6xT4d8wYI70QCrCS440PGenGfF08R7NSuKxPHhH1bkXt
	 7kPLqCYspDJGJlHer+FZi4PlZesy1K++e39zBOvX9k+Ykhxlv3ktLBDQnNdg6MR7Ya
	 pcfM4NO/TYjEA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401c52000fso14595118e87.2
        for <kexec@lists.infradead.org>; Mon, 06 Jan 2025 08:09:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjxOXwv4UWpzhYaj3tPWwsf8M6OM6lqafCjLqBMVAQ1gd7Vq2EWdY97UsV2YPN/r2yOF/KUQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyKb5aBts4CCje1KbjLJNj0+gdumQ68JvR0z55sfdN8O6/UG81V
	m8weaRiPzMJPsSWAHOwwxMJbxvE/cRLnOTi9E712Wc6SNh4riUcVx0k52fm6RgHkWbeJHJNFcUn
	LokZGhD1MWSPpJtNaQY8KX0XkDps=
X-Google-Smtp-Source: AGHT+IE6KR8Qr/gqYra6rmvnHjVuhxiMK+oZ4WylZrhzL6qwwOcFsvYEmEfqv4llFH6iJA5IO2d2iXQ0wuNkmF2p8pc=
X-Received: by 2002:a05:6512:1094:b0:542:223a:b6e9 with SMTP id
 2adb3069b0e04-54229538b98mr17971561e87.18.1736179763499; Mon, 06 Jan 2025
 08:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org>
 <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
 <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org> <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
 <de9b93a9f6088322ad5bed79b069a49203517dd7.camel@infradead.org>
In-Reply-To: <de9b93a9f6088322ad5bed79b069a49203517dd7.camel@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 6 Jan 2025 17:09:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEXPTdm=oA7+WPPBcCX69x_N_Y8woaaNwDFh0QAZNjf5g@mail.gmail.com>
Message-ID: <CAMj1kXEXPTdm=oA7+WPPBcCX69x_N_Y8woaaNwDFh0QAZNjf5g@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86/kexec: Cope with relocate_kernel() not being at
 the start of the page
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>, Tao Liu <ltao@redhat.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_160929_303098_9B5ED6C5 
X-CRM114-Status: GOOD (  25.93  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, 3 Jan 2025 at 11:10, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Tue, 2024-12-17 at 10:25 +0100, Ard Biesheuvel wrote:
> >
> > > > You can still avoid the absolute relocations though, ...
> > > ...
> > > > > +       addq    $identity_mapped, %rsi
> > > > > +       subq    $__relocate_kernel_start, %rsi
> > > >
> > > > ... if you turn this into
> > > >
> > > > 0:     addq    $identity_mapped - 0b, %rsi
> > > >        subq    $__relocate_kernel_start - 0b, %rsi
> > >
> > > Is there any benefit to doing so? Are absolute relocations problematic?
> >
> > Every absolute relocation produces an entry in the relocation table
> > that needs to be applied at every boot when KASLR is in effect. Beyond
> > that, it doesn't matter.
> >
> > I've looked into PIC codegen/PIE linking for the core kernel, which is
> > why this caught my eye. If that effort ever advances, I'll need to
> > revisit this code as well and apply the change I suggested.
>
> OK, since it looks like I'll be reposting this series once I'm back at
> a keyboard for real, I've done that in my tree.
>

Thanks

> There's one more absolute relocation, for saved_context just before
> returning to the kernel from the 'virtual_mapped' code. That's only
> reloading the GDT, and we could probably do that from the C code in
> machine_kexec().

I suppose you're referring to

#ifdef CONFIG_KEXEC_JUMP
        /* Saved in save_processor_state. */
        movq    $saved_context, %rax
        lgdt    saved_context_gdt_desc(%rax)
#endif

Any reason not to simply use

        lgdt    saved_context+saved_context_gdt_desc(%rip)

here?

