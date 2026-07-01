Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FDEC43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 12:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hne4NKxMdbJBFIiD0wCOi2iipHevw0mcVZRCTIIGryU=; b=zVCuMAU2xHRYMynuVkv0zyx6/x
	BEIJO65JLQM8kjIwD8KxUuntqbhJRYzJixGyNlY/Rk4dYHFO7wdJE3jyqAGn5xzZq0MvE7tngV8vI
	Q2ocXfBr7tjLxX6PbaWC45CNvh3felQVsMrfuLH0tQWlgk8yrtHR6xoSssq1kqNayJujk6T9VWqsl
	AnjYGx6TsYRBE3/gnHCwkYY/MUJ6g5lKs3RbiOprOQ8rLtpvTHpmR3F7YcvDClDT4MbV9mlFw+VJw
	xKGtBbnYNG+rYfEdk1dZOXJFijrbl8AMP62rauiHyK2Jw7z+HRyUEQW8SFFo3Pj7UUBuD+lOPgfxb
	+v0R9gqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wetiN-00000001ktd-3eBZ;
	Wed, 01 Jul 2026 12:06:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wetiM-00000001krO-2oeZ;
	Wed, 01 Jul 2026 12:06:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D5BE26001D;
	Wed,  1 Jul 2026 12:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A713F1F00A3E;
	Wed,  1 Jul 2026 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907609;
	bh=Hne4NKxMdbJBFIiD0wCOi2iipHevw0mcVZRCTIIGryU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LOWpQrRhH97A0fz5LUgzxyegEAGwXRsHMYb3vqySjqS9mxdabcfZ6VlENUAdS96Ud
	 f7T0eRj3gJuhgXnXx9x+EGoOBhK1kRjaytar+2yi6TXjJbS6LJkNzrjs7cwdrkodEF
	 n0XEF8l0UTwlAXaRhPhRiSgC1fR8EJ0B2ZfURlzSepWEU8Okyfa3gF7U+lAVb7Axjl
	 dKy58x9a04WPcSeCb/qHszbUDg/WJTeaMcdVE8OaO0zh8Nm8t4ZSQIiWl+5Iu2fKWY
	 SLv5HE3sCyI2ttG09B9QcM6JHgvwlXk/1QBxWHzEIZyiwDmKeSBj4CzodBHdri8oeV
	 QjeXYEXSGlcxQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,  pjw@kernel.org,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  alex@ghiti.fr,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  bhe@redhat.com,  zohar@linux.ibm.com,
  roberto.sassu@huawei.com,  dmitry.kasatkin@gmail.com,
  eric.snowberg@oracle.com,  linux-integrity@vger.kernel.org,
  pratyush@kernel.org,  Markus.Elfring@web.de,
  kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in
 machine_kexec_prepare
In-Reply-To: <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com>
 (Tao
	Liu's message of "Wed, 1 Jul 2026 16:58:09 +1200")
References: <20260701025732.66330-2-ltao@redhat.com>
	<akSOb1_1tcJvFyda@kernel.org>
	<CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com>
Date: Wed, 01 Jul 2026 14:06:45 +0200
Message-ID: <2vxz33y2j4mi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 01 2026, Tao Liu wrote:

> Hi Jarkko,
>
> On Wed, Jul 1, 2026 at 3:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>>
>> On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
>> > A NULL pointer dereference issue is noticed in riscv's machine_kexec_p=
repare,
>> > where image->segment[i].buf might be NULL and copied unchecked.
>> >
>> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
>> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
>> > but kbuf.buffer is NULL
>>
>> This should have a proper call sequence. Now the root cause is
>> obfuscated.
>
> Sure, I will attach the stack trace in v4. Here is the one:
>
> [   62.867540] kexec_file(Image): Loaded kernel at 0x80200000
> bufsz=3D0x34ed800 memsz=3D0x35d0000
> [   62.879983] Unable to handle kernel access to user memory without
> uaccess routines at virtual address 0000000000000000
> [   62.880736] Current kexec pgtable: 4K pagesize, 57-bit VAs,
> pgdp=3D0x00000001062eb000
> [   62.881185] [0000000000000000] pgd=3D00000000413b4401,
> p4d=3D000000004151bc01, pud=3D00000000415b7801, pmd=3D0000000040af5801,
> pte=3D0000000000000000
> [   62.881969] Oops [#1]
> [   62.882077] Modules linked in:
> [   62.882717] CPU: 1 UID: 0 PID: 894 Comm: kexec Not tainted 7.1.1 #4
> PREEMPT(lazy)
> [   62.883037] Hardware name: QEMU QEMU Virtual Machine, BIOS
> edk2-20260508-2.fc44 05/08/2026
> [   62.883365] epc : __memcpy+0xd4/0xf8
> [   62.883685]  ra : machine_kexec_prepare+0x8a/0x298
> [   62.883914] epc : ffffffff81393ee8 ra : ffffffff800366ca sp :
> ff20000004a83d10
> [   62.884214]  gp : ffffffff83258db8 tp : ff6000008573db80 t0 :
> ffffffff80033640
> [   62.884433]  t1 : 2152ffffffffffc0 t2 : 0000000003000000 s0 :
> ff20000004a83d80
> [   62.884710]  s1 : 0000000000000000 a0 : ff20000004a83d10 a1 :
> 0000000000000000
> [   62.884987]  a2 : 0000000000000028 a3 : 0000000000000028 a4 :
> 0000000000000000
> [   62.885208]  a5 : 0000000000000000 a6 : 0000000104e33fff a7 :
> 0000000000000000
> [   62.885486]  s2 : ff60000082a35800 s3 : 0000000000000000 s4 :
> 0000000000000010
> [   62.885774]  s5 : 0000000000000028 s6 : ff20000004a83d10 s7 :
> 0000000000000005
> [   62.886005]  s8 : 00000000000000c0 s9 : 000000000ac0d220 s10:
> ffffffff835420e8
> [   62.886218]  s11: 0000000000000000 t3 : ffffff800000007c t4 :
> ff1c000002138d00
> [   62.886515]  t5 : ffffffffffffffff t6 : ff20000004a83d10 ssp :
> 0000000000000000
> [   62.886860] status: 0000000200000120 badaddr: 0000000000000000
> cause: 000000000000000d
> [   62.887162] [<ffffffff81393ee8>] __memcpy+0xd4/0xf8
> [   62.887388] [<ffffffff801b253a>] __do_sys_kexec_file_load+0x1b2/0x338
> [   62.887612] [<ffffffff801b26e4>] __riscv_sys_kexec_file_load+0x24/0x40
> [   62.887855] [<ffffffff81395ea4>] do_trap_ecall_u+0x1a4/0x5a8
> [   62.888134] [<ffffffff813a9eec>] handle_exception+0x16c/0x178
> [   62.888445] Code: 7613 07f6 ca05 86b3 00c5 e7b3 01f5 8fd5 8b8d eb89
> (4198) 0591
> [   62.889223] ---[ end trace 0000000000000000 ]---
> Segmentation fault         kexec -l /boot/vmlinuz-7.1.1
> --initrd=3D/boot/initramfs-7.1.1.img --reuse-cmdline
>
> (gdb) p image->segment[0]
> $3 =3D {{buf =3D 0x0, kbuf =3D 0x0}, bufsz =3D 0, mem =3D 10737586176, me=
msz =3D 4096}
>
> The buf =3D 0x0 and bufsz =3D 0 comes from ima_add_kexec_buffer(), thought
> I'm not sure why it added a NULL segment, but it is no harm to add a
> NULL checker here in case any other scenarios similar as IMA.

From my reading of the IMA code, I think they do so because they don't
want to add a buffer to the kimage just yet. This is because there can
be IMA measurements between kexec load and kexec reboot. So they use
kexec_add_buffer() to reserve the physical address space, then they vmap
the destination pages in ima_kexec_post_load(), and then update the
destination pages directly via a reboot notifier. So they do not have a
buffer copied to the destination pages at the time of
kexec_add_buffer().

Now all that is fairly convoluted and not very obvious, but I am not
sure if there is a better way of doing this off the top of my head.

>
>>
>> >
>> > Fix this by simply adding a check before copy.
>> >
>> > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
>> > Acked-by: Baoquan He <bhe@redhat.com>
>> > Acked-by: Pratyush Yadav <pratyush@kernel.org>
>> > Signed-off-by: Tao Liu <ltao@redhat.com>
[...]

--=20
Regards,
Pratyush Yadav

