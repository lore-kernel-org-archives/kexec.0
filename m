Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F431C43602
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90otGYM9YNogT3/612Z38WIGOFh0NDbrJXj/gkAcc4M=; b=E6teUisf2Q9N+JTDu2crVHSdQo
	HG+UxQOCy/Viha5Wa0LBqtP5FfskOsTCPszFtdKczN6Ldy5KxYHpVarKrZI8IT16+bmVqkrL0C4Vu
	lBb4lLi63pk9cvvJgZYUwE1IzA+YK8jAi7swjJZMw2W9mTG7YtiPwnS35wY+5FjnQJHEcCsB8K48+
	A14uDmbSabyaa/24GUgbrVeXPG7g7WzhOXf7hbU/gr9HXo+kY4L4+JglQEob6goRZQNfxjaBakp5n
	ENXmK+QIREcogkrDAzUaiyhaXHW9GyN/GCe6WygfvASv0+0VuRDT+aRHHI+S7H1VjpyHV7inJsuFm
	O3HguXmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfbcm-00000006k8p-3Vn2;
	Fri, 03 Jul 2026 11:00:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfbcj-00000006k7W-42Gk
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 10:59:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783076396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90otGYM9YNogT3/612Z38WIGOFh0NDbrJXj/gkAcc4M=;
	b=WqamhOy7gAPRXxJTOKPKH2HeG4kK/3+d6KDRhFpYzsnfwCBofBxDy5BYHkcrmv8LYpjFKs
	YCFlvV0XWpBHQZX3FToxaG4G5t1tfCH8XtCInEA9vthZlwnXLVT/64xspo5I9YslKhBaBy
	jZNpAMsupqCdNol0+zfADB6YFMlgNYU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-MOgHnU16OEGXK6F44rcQVw-1; Fri, 03 Jul 2026 06:59:53 -0400
X-MC-Unique: MOgHnU16OEGXK6F44rcQVw-1
X-Mimecast-MFC-AGG-ID: MOgHnU16OEGXK6F44rcQVw_1783076393
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5e38fbc5so37222485a.2
        for <kexec@lists.infradead.org>; Fri, 03 Jul 2026 03:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076393; x=1783681193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=90otGYM9YNogT3/612Z38WIGOFh0NDbrJXj/gkAcc4M=;
        b=Hvyxa6mr1CWo++j+FjfUT6zvvrlgRAoskOEmRnUwtztcyYN3EnxMhsH52c3gIcV1t1
         qzY+bYMHJmBRsn1x/VvJmUBBhmAD+iZcYVE8D++5VN90nPmWUoHiMiAqpc7gKUuiJl+L
         3kQ7mvwzPkwJ8o1p7d4FePSMpNhQhE9Np0mGDH/X1wA8Exq+c3BHtWR1O3RVXGk0Z7cP
         ei94kaBAs0MYoSdShg+5z4pxd+RSLtD/z3CUuTkYEnczT34k5iLlTbkUydZ4VPhTJyYo
         H1rMbEiR5gL1ONVUySV3uDOJGgwywNFtMzrob7F5gdvEr8S0GwPfuaNEb1Vk92yA4DYr
         q8DA==
X-Forwarded-Encrypted: i=1; AFNElJ+8NozOAv3V/3K0gwgII0eG8jG0i5RE0TKji2TH3TIW9i+TyeoCNGJ2nIrL49sDH3/6dbNXxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzaYxfQexWQRhm9ExM+zhS8OCHswsZE26LWwKoociLl65SuXX8e
	sg6JOB+G94Lw22+06Rn0ugeJKuJcE7rc5Jcae4EY+4zPlHpew2Kv+HCgBQOKgMnopU6rKOfHdaU
	p99roUoGYrUs94xpCRUig4CUp888wJJUNglqEjpwpW65lmjvC6woP9GNUjkO4haFYOfEkzPyFBr
	CZoKm/40XtMegi/BMMHTRBxEEwoqVMNPvVUuAE
X-Gm-Gg: AfdE7cn3HTMVSOYFS6e4gsTR/6aO2Q7nJGa1NutJKc3yT0DEm/ZaQ7vMIgkgHeyRpzK
	9FXJgkgVVm2p5uVA4XAfvCBuOM56TDYGa0iV4pYzvp3r01AXTfFYklCGUnAMFVDYGIB3dgf93XB
	5mCMw2Gc+dTGQIDpsIjOsR2kWoqWdSWlDZ4CNxxzepUFlrCz2XCYd0v1pfh1/AglYV/A==
X-Received: by 2002:a05:620a:4016:b0:92e:6a43:4768 with SMTP id af79cd13be357-92e781cde5emr1264293285a.11.1783076392670;
        Fri, 03 Jul 2026 03:59:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4016:b0:92e:6a43:4768 with SMTP id
 af79cd13be357-92e781cde5emr1264290485a.11.1783076392257; Fri, 03 Jul 2026
 03:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260701025732.66330-2-ltao@redhat.com> <akSOb1_1tcJvFyda@kernel.org>
 <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com> <2vxz33y2j4mi.fsf@kernel.org>
In-Reply-To: <2vxz33y2j4mi.fsf@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 3 Jul 2026 22:59:15 +1200
X-Gm-Features: AVVi8Cezbo0yX7OHAq34QhJe08uT7CxY47RNCIsfCYAyC3SXHTFCS-ZJgPFpSss
Message-ID: <CAO7dBbXBc4kvE2J09EhBs+MYpcJOV1UdNnSG=5RqcUUqimU5Qg@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in machine_kexec_prepare
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, bhe@redhat.com, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, linux-integrity@vger.kernel.org, 
	Markus.Elfring@web.de, kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vl411AT5HdqPXA_I4ZMWtrG3nYY8ZkNLJBZYN-RLR3s_1783076393
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_035958_069294_7ABEB57C 
X-CRM114-Status: GOOD (  29.21  )
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

Hi Pratyush,

On Thu, Jul 2, 2026 at 12:06=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Wed, Jul 01 2026, Tao Liu wrote:
>
> > Hi Jarkko,
> >
> > On Wed, Jul 1, 2026 at 3:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.o=
rg> wrote:
> >>
> >> On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
> >> > A NULL pointer dereference issue is noticed in riscv's machine_kexec=
_prepare,
> >> > where image->segment[i].buf might be NULL and copied unchecked.
> >> >
> >> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> >> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> >> > but kbuf.buffer is NULL
> >>
> >> This should have a proper call sequence. Now the root cause is
> >> obfuscated.
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
> From my reading of the IMA code, I think they do so because they don't
> want to add a buffer to the kimage just yet. This is because there can
> be IMA measurements between kexec load and kexec reboot. So they use
> kexec_add_buffer() to reserve the physical address space, then they vmap
> the destination pages in ima_kexec_post_load(), and then update the
> destination pages directly via a reboot notifier. So they do not have a
> buffer copied to the destination pages at the time of
> kexec_add_buffer().
>
> Now all that is fairly convoluted and not very obvious, but I am not
> sure if there is a better way of doing this off the top of my head.

Thank you very much for resolving my confusion! Now I understand it
much better...

Thanks,
Tao Liu

>
> >
> >>
> >> >
> >> > Fix this by simply adding a check before copy.
> >> >
> >> > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> >> > Acked-by: Baoquan He <bhe@redhat.com>
> >> > Acked-by: Pratyush Yadav <pratyush@kernel.org>
> >> > Signed-off-by: Tao Liu <ltao@redhat.com>
> [...]
>
> --
> Regards,
> Pratyush Yadav
>


