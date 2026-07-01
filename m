Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E76C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 04:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ijvj3rIROI2FO/mVXn6rz1WJEKmru4R1tDm+SMDG9ms=; b=iZUMX5bMp/l0BojiBiuCR2vcIY
	JMnARgDKixXF2h785HAEJCr2SQUUwsZPPcfkATmnrCdNczIG9buagIFcmWKDO+qyTn1rlyoboGvDb
	KEORXhA+y6YPHOrq3obyc9giks4Q9t/hk/ur72GVTJjWzKf04s3JvZ2yRBVemdcCvWXJioRpPeiJw
	/eipF/QDBrAytaxTxlwbWHD71JUllhn8V5kfzQhvlGNoKTTIWqambS+ywyC+BJ+XEYZ5EdqCn1omU
	cXfYu85gU0w0MOgr412o25z/N64ShIKsoIumxxhQI7/eqM01GfVR5NJnALAYME+9Qs7qiNecBi6j/
	dukSh5iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wen2E-00000000euN-0IWo;
	Wed, 01 Jul 2026 04:58:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wen2B-00000000etk-1NQD
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 04:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782881930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijvj3rIROI2FO/mVXn6rz1WJEKmru4R1tDm+SMDG9ms=;
	b=OCyPD6rDvEHUE4vJPUd1STcAkwdkoLV74BTWPNgVHOhz+Qa6bC6s1pImQqHQFJeEnB6Hls
	PWzchWU6Rc2WAfLrQpoZ2YF/Ij5jGjz1+szIvnCmYZlf8PKaIB9/Ojqic3lm1Kwjrq7CJv
	S5dP6DOrb7EscYprB0pUa4MdfEhZ8rM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-KOHGPB6qPtySFBjFEWpFZA-1; Wed, 01 Jul 2026 00:58:46 -0400
X-MC-Unique: KOHGPB6qPtySFBjFEWpFZA-1
X-Mimecast-MFC-AGG-ID: KOHGPB6qPtySFBjFEWpFZA_1782881926
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1eb52e1fso4995581cf.0
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 21:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782881926; x=1783486726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijvj3rIROI2FO/mVXn6rz1WJEKmru4R1tDm+SMDG9ms=;
        b=EjSyD2abBcSCfPJZ/VLH6/O1IQEoknNLz9zkzf7/aqw4ADYYe0IHWPT39Bu6Eik92N
         r2X3CsISI08K2eEdYRaYN3N+DOpYbtsAJklK0FNo6gAW6rUmjaKMioLuTo0j7UqG/Qj+
         W/U4mRTwCjXcZLkoysWpCALAuN6IxOxBVvIq0AWr9NAwmHACjckbhPPtGOutksp8QbAC
         CF/NMAd/Yi4i1ufy0Ij7jaFpUlRHFiNVD18/WNprCNAu7SGZQQWQqVQgXfLIBVR7V8Sz
         /WbRpQ73hFGrxeLfzCMfYSGa96xE8FdL/GZ5du+Ser+93EjDvsjfl8gbbsOLS7bSI1Pe
         4LFQ==
X-Forwarded-Encrypted: i=1; AFNElJ81v8OTjSJDv2W/+F9I1HjBhiUgPgenjz9rqRK5KN2Uu/CXTWqJ3SJHo1PlTlEs86/B+nOV0g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxYZJ2M79T4z6o0Nj5y+buKXtr0fT27Md+LVYbFFWl/qUW3n+D6
	2qF0oGnN59ZprBQc0OEEOpeeV7r+9LKAHOuN2yxgylvCClN8hORBgNOyvEM/EqLr4cVO6dfmoSl
	D4SChjVeGHA2MJU7W6DU1Gbz1ckk1JpoGDuQvDYIndOfa5/iuLGbXMlQsSMm3yO7y4PI4YVgCXl
	/4ztMv//4Asn8mLvJFOUVhBXS8oKMJPxy3cbEa
X-Gm-Gg: AfdE7clS12vfr3TLVdJCqrRQDLPfdzWpeDmj8YujA2P6GocwC5/KMax+9j3wPLnpah+
	schgmmN3GGKCB41B9I9txVAvbIreOx2zODK15NCeLlmKTCVzVRRqnwsqofs68fkaW8Er88z33f+
	GkrkbfTXKvpgsI4QeTajB75YX7zgfz8Jeh7FSTLfRdWzN7JgvEblNxUDBkC+6t7bh00A==
X-Received: by 2002:a05:622a:5506:b0:517:5f04:f24c with SMTP id d75a77b69052e-51c26b0074emr1885951cf.39.1782881926271;
        Tue, 30 Jun 2026 21:58:46 -0700 (PDT)
X-Received: by 2002:a05:622a:5506:b0:517:5f04:f24c with SMTP id
 d75a77b69052e-51c26b0074emr1885651cf.39.1782881925860; Tue, 30 Jun 2026
 21:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260701025732.66330-2-ltao@redhat.com> <akSOb1_1tcJvFyda@kernel.org>
In-Reply-To: <akSOb1_1tcJvFyda@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 1 Jul 2026 16:58:09 +1200
X-Gm-Features: AVVi8CecY3QtyR15biAB9c6BdBCvMEH22nDddc-TMyZfwtXlVx2ChNVQ9i9xRmk
Message-ID: <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in machine_kexec_prepare
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	linux-integrity@vger.kernel.org, pratyush@kernel.org, Markus.Elfring@web.de, 
	kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5Gz23iGjSJuBgYZTU7J6BshgPyWLpxAX_ghAtdbmmVc_1782881926
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_215851_448545_5C5E8B5E 
X-CRM114-Status: GOOD (  26.66  )
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

On Wed, Jul 1, 2026 at 3:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
> > A NULL pointer dereference issue is noticed in riscv's machine_kexec_pr=
epare,
> > where image->segment[i].buf might be NULL and copied unchecked.
> >
> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> > but kbuf.buffer is NULL
>
> This should have a proper call sequence. Now the root cause is
> obfuscated.

Sure, I will attach the stack trace in v4. Here is the one:

[   62.867540] kexec_file(Image): Loaded kernel at 0x80200000
bufsz=3D0x34ed800 memsz=3D0x35d0000
[   62.879983] Unable to handle kernel access to user memory without
uaccess routines at virtual address 0000000000000000
[   62.880736] Current kexec pgtable: 4K pagesize, 57-bit VAs,
pgdp=3D0x00000001062eb000
[   62.881185] [0000000000000000] pgd=3D00000000413b4401,
p4d=3D000000004151bc01, pud=3D00000000415b7801, pmd=3D0000000040af5801,
pte=3D0000000000000000
[   62.881969] Oops [#1]
[   62.882077] Modules linked in:
[   62.882717] CPU: 1 UID: 0 PID: 894 Comm: kexec Not tainted 7.1.1 #4
PREEMPT(lazy)
[   62.883037] Hardware name: QEMU QEMU Virtual Machine, BIOS
edk2-20260508-2.fc44 05/08/2026
[   62.883365] epc : __memcpy+0xd4/0xf8
[   62.883685]  ra : machine_kexec_prepare+0x8a/0x298
[   62.883914] epc : ffffffff81393ee8 ra : ffffffff800366ca sp :
ff20000004a83d10
[   62.884214]  gp : ffffffff83258db8 tp : ff6000008573db80 t0 :
ffffffff80033640
[   62.884433]  t1 : 2152ffffffffffc0 t2 : 0000000003000000 s0 :
ff20000004a83d80
[   62.884710]  s1 : 0000000000000000 a0 : ff20000004a83d10 a1 :
0000000000000000
[   62.884987]  a2 : 0000000000000028 a3 : 0000000000000028 a4 :
0000000000000000
[   62.885208]  a5 : 0000000000000000 a6 : 0000000104e33fff a7 :
0000000000000000
[   62.885486]  s2 : ff60000082a35800 s3 : 0000000000000000 s4 :
0000000000000010
[   62.885774]  s5 : 0000000000000028 s6 : ff20000004a83d10 s7 :
0000000000000005
[   62.886005]  s8 : 00000000000000c0 s9 : 000000000ac0d220 s10:
ffffffff835420e8
[   62.886218]  s11: 0000000000000000 t3 : ffffff800000007c t4 :
ff1c000002138d00
[   62.886515]  t5 : ffffffffffffffff t6 : ff20000004a83d10 ssp :
0000000000000000
[   62.886860] status: 0000000200000120 badaddr: 0000000000000000
cause: 000000000000000d
[   62.887162] [<ffffffff81393ee8>] __memcpy+0xd4/0xf8
[   62.887388] [<ffffffff801b253a>] __do_sys_kexec_file_load+0x1b2/0x338
[   62.887612] [<ffffffff801b26e4>] __riscv_sys_kexec_file_load+0x24/0x40
[   62.887855] [<ffffffff81395ea4>] do_trap_ecall_u+0x1a4/0x5a8
[   62.888134] [<ffffffff813a9eec>] handle_exception+0x16c/0x178
[   62.888445] Code: 7613 07f6 ca05 86b3 00c5 e7b3 01f5 8fd5 8b8d eb89
(4198) 0591
[   62.889223] ---[ end trace 0000000000000000 ]---
Segmentation fault         kexec -l /boot/vmlinuz-7.1.1
--initrd=3D/boot/initramfs-7.1.1.img --reuse-cmdline

(gdb) p image->segment[0]
$3 =3D {{buf =3D 0x0, kbuf =3D 0x0}, bufsz =3D 0, mem =3D 10737586176, mems=
z =3D 4096}

The buf =3D 0x0 and bufsz =3D 0 comes from ima_add_kexec_buffer(), thought
I'm not sure why it added a NULL segment, but it is no harm to add a
NULL checker here in case any other scenarios similar as IMA.

>
> >
> > Fix this by simply adding a check before copy.
> >
> > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> > Acked-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Pratyush Yadav <pratyush@kernel.org>
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >
> > v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
> > link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-=
ltao@redhat.com/
> > link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-=
ltao@redhat.com/
> >
> > ---
> >  arch/riscv/kernel/machine_kexec.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/mach=
ine_kexec.c
> > index 2306ce3e5f22..afc68f6a4aa1 100644
> > --- a/arch/riscv/kernel/machine_kexec.c
> > +++ b/arch/riscv/kernel/machine_kexec.c
> > @@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
> >               if (image->segment[i].memsz <=3D sizeof(fdt))
> >                       continue;
> >
> > +             /*
> > +              * Some segments (e.g. IMA) reserve space but have no buf=
fer
> > +              * loaded yet. Skip them as they cannot contain an FDT.
> > +              */
>
> This is destined to rot over time. It also adds up also potentially to
> the backporting effort while backporting to stable kernes. And most
> importantly. Please, don't document every other null check.

OK, will get rid of it.

Thanks,
Tao Liu

>
> > +             if (image->segment[i].buf =3D=3D NULL)
>
> if (!image->segments[i].buf)
>
> > +                     continue;
> > +
> >               if (image->file_mode)
> >                       memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
> >               else if (copy_from_user(&fdt, image->segment[i].buf, size=
of(fdt)))
> > --
> > 2.54.0
> >
> >
>
> BR, Jarkko
>


