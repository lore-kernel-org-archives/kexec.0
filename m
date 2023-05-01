Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B33C77B73
	for <kexec@archiver.kernel.org>; Mon,  1 May 2023 19:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=STcUlg1SQCupNKD5h1PjVyYcbXNMvHImoaxDxcQFZA4=; b=peMX3YDEsjZ8n2
	Ug+nn362bbGTSDV6KP8ciQwer8UOo8w8OAI1xJvmieEr37St0rSV66nyRrtx6jAucl/l35FF+CTat
	1e37jshqTF13PufZy+ms1C+N/2OqF7yAMqBvpsUQ6dl6ZhA25kq6elfBHQkR66jJ3QvMi44l0Gmle
	B4UyNnTwV0o1iEVucVPvRqiGyE7QJDBBu0driBkNNKIIUuj2eHHDifYNK96fRSp2r720DOcJizPQR
	7gmxJQQ8wKmU4mfQ9HlLWpbrys80o+mZH/Yw/DPWUVZjGeJTiP8NtVyO8zcd7U2DhboXx6y7WPGuf
	UrmD7UmZXeGxWJRlC3Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZcG-00Go6N-2L;
	Mon, 01 May 2023 19:55:20 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZcE-00Go5L-1p
	for kexec@lists.infradead.org;
	Mon, 01 May 2023 19:55:20 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso4512453276.2
        for <kexec@lists.infradead.org>; Mon, 01 May 2023 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682970917; x=1685562917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6/Qwr73DpjqVyRdRECBbxXjLLTahq/uJGnivC6mAq8=;
        b=nOGV79JHEufvcYn2AKhdk79/ViXSWov22Cy33zWA1Gtst+eCDvoVa3OWWz5HNIcCII
         UZejZi5Uegh9PTt5hwbCSATYVQ0siN0O+UgoBQWNisA50H9K9bZk9Wrc9Z0OQeeEfA/+
         +yThvmo2Fno7BKwBTkUAF3LbTzoNv7/LwN0wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970917; x=1685562917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6/Qwr73DpjqVyRdRECBbxXjLLTahq/uJGnivC6mAq8=;
        b=LGje1++SBcCFHxwi9LuaOwlbhXULKoTN+E2h5RcfXhh4luueB05tcegUY4sFru8428
         6rIcW/YdcDeV9fHYqrNngDKmd3kMcMg+weWUQoeeuIdtsH+siwVV+svDCPz+Cb4rJBWO
         Hui1uC/U7f2Q26Qb6ZcBARjJVZgwY2VnIc60r5W9Xsj1ndc0QGEqQuhk3gyEjPAufyWo
         Na0eBgRL5of3erzlv8dy9f54H9JRHKV+tBMyOgmsVg3fgurnZGXlRox41LJhnRwqrKaU
         BxGj0Bwt01+QjpmL+aj9GYzzjc64tP24Az1LRY0mtzncLxVMuwixt+xWPWxSBpyh6LIo
         myvw==
X-Gm-Message-State: AC+VfDyeE16d6DcsHyOUJQoCPyox9QMNDXKYdv3Gy+VEAzPfrgxFdaiJ
	06Os955rEBeoel3jILJMoIOzfhxogcTegYkUTxxcjA==
X-Google-Smtp-Source: ACHHUZ6UAXBPBX1H2vjMI1q/4vq+kHMocTcgAqmn6/rC7tv6GpkwixPF0A0raTbJaN/fim3ox8b8Bw==
X-Received: by 2002:a25:24c4:0:b0:b9a:7df5:4f1f with SMTP id k187-20020a2524c4000000b00b9a7df54f1fmr15159538ybk.37.1682970917051;
        Mon, 01 May 2023 12:55:17 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id o3-20020a5b0643000000b00b8f13ff2a8esm6844735ybq.61.2023.05.01.12.55.16
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 12:55:16 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-559f1819c5dso30970147b3.0
        for <kexec@lists.infradead.org>; Mon, 01 May 2023 12:55:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:a28a:b0:e6:f7e8:1e4d with SMTP id
 a10-20020a056a20a28a00b000e6f7e81e4dmr13625249pzl.33.1682970895325; Mon, 01
 May 2023 12:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org> <20230501-cottage-overjoyed-1aeb9d72d309@spud>
In-Reply-To: <20230501-cottage-overjoyed-1aeb9d72d309@spud>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 1 May 2023 21:54:43 +0200
X-Gmail-Original-Message-ID: <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
Message-ID: <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To: Conor Dooley <conor@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, 
	Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>, 
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ross Zwisler <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Simon Horman <horms@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	stable@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_125518_635266_FEDC3898 
X-CRM114-Status: GOOD (  25.73  )
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

Hi Conor

On Mon, 1 May 2023 at 19:41, Conor Dooley <conor@kernel.org> wrote:
>
> Hey Ricardo,
>
> On Mon, May 01, 2023 at 02:38:22PM +0200, Ricardo Ribalda wrote:
> > If PGO is enabled, the purgatory ends up with multiple .text sections.
> > This is not supported by kexec and crashes the system.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  arch/riscv/purgatory/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> > index 5730797a6b40..cf3a44121a90 100644
> > --- a/arch/riscv/purgatory/Makefile
> > +++ b/arch/riscv/purgatory/Makefile
> > @@ -35,6 +35,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
> >  CFLAGS_string.o := -D__DISABLE_EXPORTS
> >  CFLAGS_ctype.o := -D__DISABLE_EXPORTS
> >
> > +# When profile optimization is enabled, llvm emits two different overlapping
> > +# text sections, which is not supported by kexec. Remove profile optimization
> > +# flags.
> > +KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
>
> With the caveat of not being au fait with the workings of either PGO or
> of purgatory, how come you modify KBUILD_CFLAGS here rather than the
> purgatory specific PURGATORY_CFLAGS that are used later in the file?

Definitely, not a Makefile expert here, but when I tried this:

@@ -35,6 +40,7 @@ PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding
-fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
+PURGATORY_CFLAGS := $(filter-out -fprofile-sample-use=%
-fprofile-use=%,$(KBUILD_CFLAGS))

It did not work.

Fixes: bde971a83bbf ("KVM: arm64: nvhe: Fix build with profile optimization")

does this approach, so this is what I tried and worked.

Thanks!
>
> Cheers,
> Conor.
>
> > +
> >  # When linking purgatory.ro with -r unresolved symbols are not checked,
> >  # also link a purgatory.chk binary without -r to check for unresolved symbols.
> >  PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
> >
> > --
> > 2.40.1.495.gc816e09b53d-goog
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
