Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C71C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C0eRNTRNun4PKYWrdIhick5RVmD+08hh2iy99USv2dg=; b=dncp7pEFHyfHc/2znXHURxzLxn
	ruXvy+9quHlHPlF6tnUrP1hAyVDRhMZz/lsmJcCTF/3U2+AVCPp+kWXOl/dDl1kTHSuwE6ILVoHlb
	5P9/o70uhwJNa7fOTlWxaLdo3gotTiAB+PZwPm3Rt30qgXosVop1g9cfNXeVD3qRY7RzuDEHPo97T
	wxmZ2C2Yg+nAJyeXCFmrTsG3gHA4lgfOvRkNx0T8Wxok2Y/nZwa0qPAyIzkmr6Qe2oi/3jYjRVH6f
	L2MTRrIE/qaKKXNOMd3DzugttBgzceWyuC5cR5ia1j/Mp+rFjFy+ewmyiDROXbFo+U6f65Pz/haT8
	76pGXjfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wetjv-00000001n3Q-1kjl;
	Wed, 01 Jul 2026 12:08:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wetjt-00000001n0f-2Tss;
	Wed, 01 Jul 2026 12:08:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0CFB160138;
	Wed,  1 Jul 2026 12:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2AA1F000E9;
	Wed,  1 Jul 2026 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907704;
	bh=C0eRNTRNun4PKYWrdIhick5RVmD+08hh2iy99USv2dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Lk0z/ZQBNWuYtX5yOP2RB8ff5+3SHNmHArT5mGIRw4gKVvkZg6/TGWpPSDRn1vUoB
	 7h0Svchp8RQk9jeBIpu2cmGAS9pqWjEe0cXuGkXpbg3WI8WFwI3qamF0M9B47NrSdz
	 6lRu0WURG8w7jW9SaeLmjXJfjZRQ0eUtzUCAPDif+6m2TOTUES5AeQbvQvLoXcrEPD
	 RaZr333OdeOtghfigKxJow6PwKBVRJfWhkE3Yw19SmPSfdyjHW8185kmrdE4IFO/cc
	 8a/fJUJ/MUCdG9cBe5+Kr0uaV07WwcQQgzZILuVCnyN0yYTCvZJBiKEjyAyuvMWiOR
	 lgFC+aGDyBsdw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Baoquan He <bhe@redhat.com>,
  kexec@lists.infradead.org,  pjw@kernel.org,  palmer@dabbelt.com,
  aou@eecs.berkeley.edu,  alex@ghiti.fr,  Mimi Zohar <zohar@linux.ibm.com>,
  Roberto Sassu <roberto.sassu@huawei.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,  Eric Snowberg <eric.snowberg@oracle.com>,
  linux-integrity@vger.kernel.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in
 machine_kexec_prepare
In-Reply-To: <CAO7dBbXzs2pMrVuJ3qUVT2KYNh9RysOOWy_HPTmCY3gYUh9LDQ@mail.gmail.com>
 (Tao
	Liu's message of "Wed, 1 Jul 2026 15:29:44 +1200")
References: <20260529032739.13264-2-ltao@redhat.com>
	<CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
	<CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
	<2vxzh5mlk3bd.fsf@kernel.org>
	<CAO7dBbXzs2pMrVuJ3qUVT2KYNh9RysOOWy_HPTmCY3gYUh9LDQ@mail.gmail.com>
Date: Wed, 01 Jul 2026 14:08:20 +0200
Message-ID: <2vxzy0fuhpzf.fsf@kernel.org>
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

> Hi Pratyush,
>
> On Mon, Jun 29, 2026 at 11:13=E2=80=AFPM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> +Cc IMA maintainers
>>
>> On Fri, Jun 26 2026, Baoquan He wrote:
>>
>> > Add kexec ML to CC.
>> >
>> > On Fri, Jun 26, 2026 at 7:46=E2=80=AFAM Tao Liu <ltao@redhat.com> wrot=
e:
>> >>
>> >> Kindly ping, any comments?
>> >>
>> >> Thanks,
>> >> Tao Liu
>> >>
>> >> On Fri, May 29, 2026 at 3:35=E2=80=AFPM Tao Liu <ltao@redhat.com> wro=
te:
>> >> >
>> >> > A NULL pointer reference issue is noticed in riscv's machine_kexec_=
prepare,
>> >> > where image->segment[i].buf might be NULL and copied unchecked.
>> >> >
>> >> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
>> >> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
>> >> > but kbuf.buffer is NULL.
>> >> >
>> >> > Fix this by simply adding a check before copy.
>> >> >
>> >> > Signed-off-by: Tao Liu <ltao@redhat.com>
>> >> > ---
>> >> >  arch/riscv/kernel/machine_kexec.c | 3 +++
>> >> >  1 file changed, 3 insertions(+)
>> >> >
>> >> > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/=
machine_kexec.c
>> >> > index 2306ce3e5f22..d81d576f9cb5 100644
>> >> > --- a/arch/riscv/kernel/machine_kexec.c
>> >> > +++ b/arch/riscv/kernel/machine_kexec.c
>> >> > @@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
>> >> >                 if (image->segment[i].memsz <=3D sizeof(fdt))
>> >> >                         continue;
>> >> >
>> >> > +               if (image->segment[i].buf =3D=3D NULL)
>> >> > +                       continue;
>> >> > +
>> >
>> > This is a good fix, maybe we can add code comments to explain it as
>> > below, just for reference.
>> >
>> >                /*
>> >                 * Some segments (e.g. IMA) reserve space but have no b=
uffer
>> >                 * loaded yet. Skip them as they cannot contain an FDT.
>> >                 */
>> > And is there any other place where the similar issue exists? e.g on Lo=
ongArch?
>> >
>> > Other than above concerns, this patch looks good to me:
>> >
>> > Acked-by: Baoquan He <bhe@redhat.com>
>>
>> Yeah, the patch LGTM to me too.
>>
>> Acked-by: Pratyush Yadav <pratyush@kernel.org>
>>
>> Although I think IMA can make this a bit easier to understand. First, in
>> ima_add_kexec_buffer() it should set kbuf.buffer to NULL and kbuf.bufsz
>> to 0 explicitly instead of using kexec_buffer and kexec_buffer_size
>> which are initialized to NULL and 0, but never updated. Using the
>> variables here adds an extra level of indirection.
>>
>> Also, perhaps we should add a comment in ima_add_kexec_buffer() about
>> how this all works, since where the IMA buffer lives and where it gets
>> updated it fairly complicated and took me some time to piece together.
>
> Thanks for your patch review and suggestions! I agree with your point
> on the IMA part, I was confused by the code too, e.g in
> ima_add_kexec_buffer():
>
> void *kexec_buffer =3D NULL;
> kbuf.buffer =3D kexec_buffer;
> ret =3D kexec_add_buffer(&kbuf);
> if (ret) {
>     pr_err("Error passing over kexec measurement buffer.\n");
>     vfree(kexec_buffer);
>     return;
> }
>
> Do we need to vfree(kexec_buffer)? When kexec_buffer is NULL and seems
> never get updated.
>
> I'm not familiar with IMA code, maybe there is a reason which I'm unaware=
 of...

I think it is just leftover from refactors. kexec_buffer used to point
to an actual buffer at some point and refactors to the function left
them always NULL but never removed them.

--=20
Regards,
Pratyush Yadav

