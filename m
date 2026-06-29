Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9365AC43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 11:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=II6UFmS/kZBk86eBwc2++62peQEiQa8YkmG82Y63ygs=; b=O6kHiWO+zVJrwOjFSeRFPx2XEB
	lU8WispUGiwOV7VEZw2ssKH9IMJL66K9LR5PDfCZVT3B4xtHvdLZ6ZS8/Ut2DsWLfE5LC/lKMy/Ci
	niC3oBqQ0DCVK32lMKTqiMShll1pK4iM2ViixcIaCPq6QplZYGavFLKSpCK6B9mtErrvXlx8daDLH
	1cMLOLF6Ko04kHhaQAXsgS64aZRibXg9sY8LfJMoBW4eCFOE3uAQ05rxmmCCv5F670oPL/lZyztSt
	C4IoQ44v4OXDK6hftT+77VKoQxNN41ba5c8apR6fms8YvlnZUC8YmV2/DIJFHtLfDIZxWbs2Wq7nY
	HEMj7NGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we9vA-0000000EOcZ-2W2K;
	Mon, 29 Jun 2026 11:13:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we9v9-0000000EOcP-2MSw;
	Mon, 29 Jun 2026 11:12:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 98BA560008;
	Mon, 29 Jun 2026 11:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6531F000E9;
	Mon, 29 Jun 2026 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782731578;
	bh=II6UFmS/kZBk86eBwc2++62peQEiQa8YkmG82Y63ygs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YK/8dN9y+lJGv9+y5AfOEXUWUafvy1CPBci2prcfSZcbGSx74/vxgjKXHzh0yAKAC
	 IsglvZmbRrH0SJZP3vnZhOLO7RWJodTrVLSxrjAIKABiCyhsXkJYXISx2AWi06IOp+
	 lX/xmQ7cD8V/jt2TwgiUDh4acL+V6RzIXPVjWL/cEyGQ4wvlytEGsoX1TyYwfcEomn
	 gzRoy6aMtwF2Ll6fK65lAMkBPWCWUjX5Vr5Y2LWTIyXi80CVFk1XelkiBj+9pORW3d
	 8ZCvAX8eStZA491T1hS5wuIwVZ2r1b/Oqc7cS1ox/xBR6ZLo/BILF6SRX/3SRCfuUs
	 eMjJTWNR2oB3A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Tao Liu <ltao@redhat.com>,  kexec@lists.infradead.org,  pjw@kernel.org,
	palmer@dabbelt.com,  aou@eecs.berkeley.edu,  alex@ghiti.fr,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
	linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in
 machine_kexec_prepare
In-Reply-To: <CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
	(Baoquan He's message of "Fri, 26 Jun 2026 16:04:37 +0800")
References: <20260529032739.13264-2-ltao@redhat.com>
	<CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
	<CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
Date: Mon, 29 Jun 2026 13:12:54 +0200
Message-ID: <2vxzh5mlk3bd.fsf@kernel.org>
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

+Cc IMA maintainers

On Fri, Jun 26 2026, Baoquan He wrote:

> Add kexec ML to CC.
>
> On Fri, Jun 26, 2026 at 7:46=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote:
>>
>> Kindly ping, any comments?
>>
>> Thanks,
>> Tao Liu
>>
>> On Fri, May 29, 2026 at 3:35=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
>> >
>> > A NULL pointer reference issue is noticed in riscv's machine_kexec_pre=
pare,
>> > where image->segment[i].buf might be NULL and copied unchecked.
>> >
>> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
>> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
>> > but kbuf.buffer is NULL.
>> >
>> > Fix this by simply adding a check before copy.
>> >
>> > Signed-off-by: Tao Liu <ltao@redhat.com>
>> > ---
>> >  arch/riscv/kernel/machine_kexec.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/mac=
hine_kexec.c
>> > index 2306ce3e5f22..d81d576f9cb5 100644
>> > --- a/arch/riscv/kernel/machine_kexec.c
>> > +++ b/arch/riscv/kernel/machine_kexec.c
>> > @@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
>> >                 if (image->segment[i].memsz <=3D sizeof(fdt))
>> >                         continue;
>> >
>> > +               if (image->segment[i].buf =3D=3D NULL)
>> > +                       continue;
>> > +
>
> This is a good fix, maybe we can add code comments to explain it as
> below, just for reference.
>
>                /*
>                 * Some segments (e.g. IMA) reserve space but have no buff=
er
>                 * loaded yet. Skip them as they cannot contain an FDT.
>                 */
> And is there any other place where the similar issue exists? e.g on Loong=
Arch?
>
> Other than above concerns, this patch looks good to me:
>
> Acked-by: Baoquan He <bhe@redhat.com>

Yeah, the patch LGTM to me too.

Acked-by: Pratyush Yadav <pratyush@kernel.org>

Although I think IMA can make this a bit easier to understand. First, in
ima_add_kexec_buffer() it should set kbuf.buffer to NULL and kbuf.bufsz
to 0 explicitly instead of using kexec_buffer and kexec_buffer_size
which are initialized to NULL and 0, but never updated. Using the
variables here adds an extra level of indirection.

Also, perhaps we should add a comment in ima_add_kexec_buffer() about
how this all works, since where the IMA buffer lives and where it gets
updated it fairly complicated and took me some time to piece together.

--=20
Regards,
Pratyush Yadav

