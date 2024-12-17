Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701C2E7716A
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPL93mBy2j7SD8UGFpfkOUpq//hWhZVwrtDUwkgko/8=; b=JqvSeMKLHSdsLjZWv094smbW54
	/HfdFj+hbyq91MC8GmFlNCq6jYaPYj2kyit91xkMmd7mYob0AbqtEBlxhG6a7nJ2uO0euJOa10MYU
	SlAVZaq/yE1ve0YlSCERzj5tIxCtYZsGuCxNUt7M6MFF8X4c3pzW2eV9FplbfrNBaTf9Mw/bQ3u6k
	sZbfV5jkCinx+DUWmsIgNNFSAg264Wjmv2V47CiCTxO/VQ4EJ/wF4D1gIvxOPjnEUbh6MsgCSI9qi
	wAxAe17NuprKNwDvlcnGSvY+WpymjK2/50ueGWccGr1fUULDUimftUfiYrQ6dcsUc97Y12PBzt+Xa
	uu+CBviQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUgZ-0000000D6DW-3fjk;
	Tue, 17 Dec 2024 10:20:15 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUbE-0000000D5Iu-0uOW
	for kexec@lists.infradead.org;
	Tue, 17 Dec 2024 10:14:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BA2C7A40B4B
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 10:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2745C4CEDD
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734430482;
	bh=OPL93mBy2j7SD8UGFpfkOUpq//hWhZVwrtDUwkgko/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BGa4MHzRtcdbiDw4dpQqmMzG6yLBp417qR8NvoqFAgzP5rGo42qtQXuEM4/pcojyE
	 Qp/EOk6cxKrvcjraZYoBuerX7hxgFXKenl13X1VED04jfCbvTalj1nr9fS0Ks6+AbY
	 JSgh/cFIQ+ND3ocNHwBu+X5DmDhjKQ2V698aA7wGToaV/yt1YCPx7UmM28vhOpgRaX
	 vNLkpi6H4TcPP5GUac9xyN+6SNzbI4AgoPyeyvr0YHDj9BIdGtal7fnkpf22Kj4MSb
	 NhIBVV+SEJ7tGnNFFgjzz6U4lkYOFiKrdnW8XMfoF/5MzJ7/8SqCToDrQExeZLnp5w
	 u21KYLDE88ALA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so5370704e87.2
        for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 02:14:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9iQmYa0Zvw08LZ1xnkgsSSGkYdfxG9CyqrmUPziW6iNJKcRubwX0xkIlZVBPgC53tFj2M2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJ69Ts6TKb3xZawKKklxg9M4DtVHr6xydkpmOSuzXRLpwKeOzJ
	bXkTp1jn0uZHfDTIl81uRqcIN18jLVBjkgTPxzZPX3HO2cvYKyu+UameJtBK4pBz3pihQZj57zO
	gPPg/xqHQj3qiaAVPuBoEV3Dtdag=
X-Google-Smtp-Source: AGHT+IEHEqgshx48LpQkxmt7DQQCnQ/7L59ik4neDe+UpvzdB1r/xaAqQ8ldkgLyB+Oub2u9IimT2ZmItOjdapUo0dc=
X-Received: by 2002:a05:6512:39cc:b0:540:2f59:7561 with SMTP id
 2adb3069b0e04-54099b699d2mr5130581e87.50.1734430480882; Tue, 17 Dec 2024
 02:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org>
 <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com>
 <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org> <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com>
 <27388506-9BE8-4540-A444-166C49133295@infradead.org> <CAMj1kXE-60BqLx4VH6Cw_s0nt=bkx=oFQuts+m6sZFeziH1sqg@mail.gmail.com>
 <111B7BEE-FDA0-4085-8A97-89EC9DE7A51B@infradead.org>
In-Reply-To: <111B7BEE-FDA0-4085-8A97-89EC9DE7A51B@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 11:14:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEURHzq0vmt-18N81QPACN2_53m2EaAOhb+fTc8ppTGVQ@mail.gmail.com>
Message-ID: <CAMj1kXEURHzq0vmt-18N81QPACN2_53m2EaAOhb+fTc8ppTGVQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] x86/kexec: Use typedef for relocate_kernel_fn
 function prototype
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>, 
	Tao Liu <ltao@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_021444_378847_F3DFF952 
X-CRM114-Status: GOOD (  25.96  )
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

On Tue, 17 Dec 2024 at 11:07, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On 17 December 2024 10:54:19 CET, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Tue, 17 Dec 2024 at 10:42, David Woodhouse <dwmw2@infradead.org> wrot=
e:
> >> Hm, I am perfectly happy to believe that my memory is failing me, espe=
cially when it comes to specifics of i386 assembler code. But are you also =
telling me that
> >> <https://kernelnewbies.org/FAQ/asmlinkage> is a lie?
> >>
> >
> >It seems wildly out of date, at least.
> >
> >Commit 96a388de5dc53a8b2 from 2007 removed the asmlinkage definition
> >containing regparm(0) from include/asm-i386/linkage.h, and I'm not
> >convinced it was ever sound to conflate linkage with calling
> >convention like that. Today, asmlinkage evaluates to 'extern "C"' when
> >using a C++ compiler, which is also not part of the type.
> >
> >However, I failed to notice that this just moves code around, and only
> >applies to 32-bit in the first place. So I won't waste any more of
> >your time obsessing over this.
>
> Too late :)
>
> You've already made me concerned about what the calling convention *is* f=
or relocate_kernel() on i386. Because if asmlinkage doesn't mean regparm(0)=
 any more and the i386 kernel is still built with -mregparm=3D3, then how d=
oes the asm code (which seems to believe all its arguments are on the stack=
) actually work?
>
> It seems slightly unlikely that kexec on i386 has just been broken since =
2007 but I'm not sure I'd completely rule it out.
>
> So now I guess I have to actually build a 32-bit userspace test case and =
*test* it.
>
> And that means I no longer have any excuse for not doing all the same cle=
anups in the i386 version of the code that I've done for x86_64...
>
> Thanks for that :)
>

Actually, asmlinkage still means regparm(0) on i386, so I'm going to
have to apologise again, for my poor git foo this time.

