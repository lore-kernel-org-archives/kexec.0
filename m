Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F278C44500
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uh7HGlG5BHoSUsvlsYaBrF++hCjSyZH34tmkueyHFBM=; b=0yjpejy3LKRvffJvj/pEAh/RB2
	xojPbZIvZPgP/TfuoaaCWgCefCsJsQjtIs+Xbi2khAfOCX9wB14wKoP8Gj0oH2eZJl3RYEYPqy759
	KBTltVGSW/DEsAtcSfoJ6YDSjxTYaAUFwSzsVi1l+ebeu8Dz43bfeBvF1Xy0z+j6kU+ijVHE3ISMb
	7aHR+BbZO0VBwuCJwtwTF/gGYWvfLdqBmQS5CgxuE88Ut8iYmdYzjCefZ5qHdejivUWjKkjizMydM
	g2jags16NO319GfKhVs3dHYeRtNmvFlXf5AyFd+kpgZ1fTN4ejh62EHbnmrkGVrzmizd8DuFGkeLH
	9fHMf+kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfblo-00000006mc2-0kfk;
	Fri, 03 Jul 2026 11:09:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfblk-00000006maY-1fe3
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 11:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783076954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uh7HGlG5BHoSUsvlsYaBrF++hCjSyZH34tmkueyHFBM=;
	b=Z9HFHot+nWeBReW690yKsr6tlvdd3GbkSX7upTjRupJXg8qvvvrPa1r9SFDmSMGIgh3GmZ
	/d7K45RypiaMspN00iyd63SfkYAKKIm4NYUI4DffyBI2EKz4N6iSJs0xQk0kf11ncwjaf3
	JaF0Zkr10Vt75K8hxeINf8HtZpMlwAA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ffXXmT9VNrGLspq2Er-xeQ-1; Fri, 03 Jul 2026 07:09:13 -0400
X-MC-Unique: ffXXmT9VNrGLspq2Er-xeQ-1
X-Mimecast-MFC-AGG-ID: ffXXmT9VNrGLspq2Er-xeQ_1783076953
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0199faafso5294391cf.3
        for <kexec@lists.infradead.org>; Fri, 03 Jul 2026 04:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076953; x=1783681753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uh7HGlG5BHoSUsvlsYaBrF++hCjSyZH34tmkueyHFBM=;
        b=IfARz4N8DyeobyzeUaOdisE27k09LD0ZEqo7Hltswa7dZkmwaKiKr/BesN0hosuxBZ
         tEj/nwOW8YoSpeO3+8NSezyVG86/bQtd0phL8vTUfTY+oZSSHlENjKusBZ3sJbZLDoTR
         VaNkI8JTKIAiisg353ZnfEJiIW8kAUMAvB8p04ELJrUpp6SeBLxVwSQy6N74MiIaAAz4
         rw92D5GujLJl1KkE0UBgTe5n/UIY0d1m5AN83xkT0FPq0RPlNo9X2S9nj8ull50f9xR2
         a9uRaGOpdo4bhLDlKmRmgtIy1lbKMeZ61EPG5GaMNZhCLZwylUJG+kTbDoP+iDTR7zZx
         1kGA==
X-Forwarded-Encrypted: i=1; AFNElJ8//e1pq+SzMVCrHgBybioE7pA+jTnn5Fbz5Rjh5lzlh0Z9PKFVGyqxtsg/qmTudazIT00vwA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyzAPd7Uq0V2qmAVGXuSU0hG8Y/YNg2+jk57KrBf4xM/c4HsIdd
	q9x49g0+dM6ojqmaJKFO+AtqPfnoRdfRZyfrDN0oNjdOhAb0TYnw2BT8Tff/PEruICpfbe9UzDM
	INAlUQiDlFiDXReJa0BOMn3iMZhdV0mTiTCgkMjE5TE6RQX1knz9b5PhFILVqL2OCL4EFOgPzbC
	uTfs8EOKrPzJvL+Gszn6s8pB3kong2c+QeZy/I
X-Gm-Gg: AfdE7cnxm/kQ6OdS3J+0UW807w+nj9YgWzqEJx/mYX5aK6np0opr9QAMq9FVdzayMBZ
	6hckunZpRZE3BD92gLFumWvxXooffdKGeMMvoQBgyUrAgP8r8YTOQwZolhweIE+n6bqbgJ+O7WD
	qrM9ogh8SF3A9+X8z6+l5WBs99WVxEGyaTdSGKyB028EGs+Nop96/61eAu7l9yk50f/Q==
X-Received: by 2002:a05:622a:44:b0:51c:24c:59de with SMTP id d75a77b69052e-51c26b629eamr143143161cf.72.1783076953312;
        Fri, 03 Jul 2026 04:09:13 -0700 (PDT)
X-Received: by 2002:a05:622a:44:b0:51c:24c:59de with SMTP id
 d75a77b69052e-51c26b629eamr143142551cf.72.1783076952684; Fri, 03 Jul 2026
 04:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260701025732.66330-2-ltao@redhat.com> <akSOb1_1tcJvFyda@kernel.org>
 <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com> <akTsE_jYq-GtXcpF@kernel.org>
In-Reply-To: <akTsE_jYq-GtXcpF@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 3 Jul 2026 23:08:35 +1200
X-Gm-Features: AVVi8Cclc4CZSlkWyFCrDTmGWrXtXO513XB-yjh4k4HPtk_zt3VKjRYaC6ARqq0
Message-ID: <CAO7dBbVoppy-1AY8paE8KBb93UubhBHBhvsgjOm0Hnbxiq4byQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in machine_kexec_prepare
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	linux-integrity@vger.kernel.org, pratyush@kernel.org, Markus.Elfring@web.de, 
	kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TfyQ_3a2gODsezrapdsu_8VyUVxjFBth0v5-PoNyfYM_1783076953
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_040916_537903_44C0A0C7 
X-CRM114-Status: GOOD (  39.41  )
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

Hi Jarkko,

On Wed, Jul 1, 2026 at 10:34=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Jul 01, 2026 at 04:58:09PM +1200, Tao Liu wrote:
> > Hi Jarkko,
> >
> > On Wed, Jul 1, 2026 at 3:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.o=
rg> wrote:
> > >
> > > On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
> > > > A NULL pointer dereference issue is noticed in riscv's machine_kexe=
c_prepare,
> > > > where image->segment[i].buf might be NULL and copied unchecked.
> > > >
> > > > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> > > > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> > > > but kbuf.buffer is NULL
> > >
> > > This should have a proper call sequence. Now the root cause is
> > > obfuscated.
> >
> > Sure, I will attach the stack trace in v4. Here is the one:
> >
> > [   62.867540] kexec_file(Image): Loaded kernel at 0x80200000
> > bufsz=3D0x34ed800 memsz=3D0x35d0000
> > [   62.879983] Unable to handle kernel access to user memory without
> > uaccess routines at virtual address 0000000000000000
> > [   62.880736] Current kexec pgtable: 4K pagesize, 57-bit VAs,
> > pgdp=3D0x00000001062eb000
> > [   62.881185] [0000000000000000] pgd=3D00000000413b4401,
> > p4d=3D000000004151bc01, pud=3D00000000415b7801, pmd=3D0000000040af5801,
> > pte=3D0000000000000000
> > [   62.881969] Oops [#1]
> > [   62.882077] Modules linked in:
> > [   62.882717] CPU: 1 UID: 0 PID: 894 Comm: kexec Not tainted 7.1.1 #4
> > PREEMPT(lazy)
> > [   62.883037] Hardware name: QEMU QEMU Virtual Machine, BIOS
> > edk2-20260508-2.fc44 05/08/2026
> > [   62.883365] epc : __memcpy+0xd4/0xf8
> > [   62.883685]  ra : machine_kexec_prepare+0x8a/0x298
> > [   62.883914] epc : ffffffff81393ee8 ra : ffffffff800366ca sp :
> > ff20000004a83d10
> > [   62.884214]  gp : ffffffff83258db8 tp : ff6000008573db80 t0 :
> > ffffffff80033640
> > [   62.884433]  t1 : 2152ffffffffffc0 t2 : 0000000003000000 s0 :
> > ff20000004a83d80
> > [   62.884710]  s1 : 0000000000000000 a0 : ff20000004a83d10 a1 :
> > 0000000000000000
> > [   62.884987]  a2 : 0000000000000028 a3 : 0000000000000028 a4 :
> > 0000000000000000
> > [   62.885208]  a5 : 0000000000000000 a6 : 0000000104e33fff a7 :
> > 0000000000000000
> > [   62.885486]  s2 : ff60000082a35800 s3 : 0000000000000000 s4 :
> > 0000000000000010
> > [   62.885774]  s5 : 0000000000000028 s6 : ff20000004a83d10 s7 :
> > 0000000000000005
> > [   62.886005]  s8 : 00000000000000c0 s9 : 000000000ac0d220 s10:
> > ffffffff835420e8
> > [   62.886218]  s11: 0000000000000000 t3 : ffffff800000007c t4 :
> > ff1c000002138d00
> > [   62.886515]  t5 : ffffffffffffffff t6 : ff20000004a83d10 ssp :
> > 0000000000000000
> > [   62.886860] status: 0000000200000120 badaddr: 0000000000000000
> > cause: 000000000000000d
> > [   62.887162] [<ffffffff81393ee8>] __memcpy+0xd4/0xf8
> > [   62.887388] [<ffffffff801b253a>] __do_sys_kexec_file_load+0x1b2/0x33=
8
> > [   62.887612] [<ffffffff801b26e4>] __riscv_sys_kexec_file_load+0x24/0x=
40
> > [   62.887855] [<ffffffff81395ea4>] do_trap_ecall_u+0x1a4/0x5a8
> > [   62.888134] [<ffffffff813a9eec>] handle_exception+0x16c/0x178
> > [   62.888445] Code: 7613 07f6 ca05 86b3 00c5 e7b3 01f5 8fd5 8b8d eb89
> > (4198) 0591
> > [   62.889223] ---[ end trace 0000000000000000 ]---
> > Segmentation fault         kexec -l /boot/vmlinuz-7.1.1
> > --initrd=3D/boot/initramfs-7.1.1.img --reuse-cmdline
> >
> > (gdb) p image->segment[0]
> > $3 =3D {{buf =3D 0x0, kbuf =3D 0x0}, bufsz =3D 0, mem =3D 10737586176, =
memsz =3D 4096}
> >
> > The buf =3D 0x0 and bufsz =3D 0 comes from ima_add_kexec_buffer(), thou=
ght
> > I'm not sure why it added a NULL segment, but it is no harm to add a
> > NULL checker here in case any other scenarios similar as IMA.
>
> The mission oriented purpose of kernel's git log is to be a quick
> checklist for bisecting bugs for instance. You have a dump of details
> there for a transcript. Now you should do rationalize that because how
> can you otherwise trust your own code?
>
> Here's one recent example from me:
>
> https://lore.kernel.org/linux-integrity/20260509185108.2681198-1-jarkko@k=
ernel.org/
>
> This is IMHO way more important part for a bug fix like this than the
> code change itself.
>
> It's the "engineering part" of the  equation.
>
> >
> > >
> > > >
> > > > Fix this by simply adding a check before copy.
> > > >
> > > > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> > > > Acked-by: Baoquan He <bhe@redhat.com>
> > > > Acked-by: Pratyush Yadav <pratyush@kernel.org>
> > > > Signed-off-by: Tao Liu <ltao@redhat.com>
> > > > ---
> > > >
> > > > v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
> > > > link to v2: https://lore.kernel.org/linux-riscv/20260627222602.2359=
4-2-ltao@redhat.com/
> > > > link to v1: https://lore.kernel.org/linux-riscv/20260529032739.1326=
4-2-ltao@redhat.com/
> > > >
> > > > ---
> > > >  arch/riscv/kernel/machine_kexec.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/=
machine_kexec.c
> > > > index 2306ce3e5f22..afc68f6a4aa1 100644
> > > > --- a/arch/riscv/kernel/machine_kexec.c
> > > > +++ b/arch/riscv/kernel/machine_kexec.c
> > > > @@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
> > > >               if (image->segment[i].memsz <=3D sizeof(fdt))
> > > >                       continue;
> > > >
> > > > +             /*
> > > > +              * Some segments (e.g. IMA) reserve space but have no=
 buffer
> > > > +              * loaded yet. Skip them as they cannot contain an FD=
T.
> > > > +              */
> > >
> > > This is destined to rot over time. It also adds up also potentially t=
o
> > > the backporting effort while backporting to stable kernes. And most
> > > importantly. Please, don't document every other null check.
> >
> > OK, will get rid of it.
>
> general rules of thumb i personally follow usually:
>
> 1. features/improvements: can be a bit more eager with comments
> 2. bugs: you really have to have rationale for having a commnet. E.g.,
>    mandatory SAFETY comment in linux-rust would obviously qualify.
> 3. both: if you add a comment are you sure it won't rot over time?
>

Thank you very much for providing detailed guidance on code commenting
and commit log drafting. I really appreciate your help with those!

Thanks,
Tao Liu

> >
> > Thanks,
> > Tao Liu
> >
> > >
> > > > +             if (image->segment[i].buf =3D=3D NULL)
> > >
> > > if (!image->segments[i].buf)
> > >
> > > > +                     continue;
> > > > +
> > > >               if (image->file_mode)
> > > >                       memcpy(&fdt, image->segment[i].buf, sizeof(fd=
t));
> > > >               else if (copy_from_user(&fdt, image->segment[i].buf, =
sizeof(fdt)))
> > > > --
> > > > 2.54.0
> > > >
> > > >
> > >
> > > BR, Jarkko
> > >
> >
>
> BR, Jarkko
>


