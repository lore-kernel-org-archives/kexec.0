Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2030ACDB46B
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 22:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fdY9TCOCaqdI9+jOH1ZxraaFlRq2CcnwWYmV5BAETuo=; b=rxqlLNdAhrDkSLatws/wmLwGwn
	m4lMkmBQ6ha9BBljezAF5GRJFRtRqJ3amg8saKF7Z93gt5g+VxitxlFpT8FBhiIqkQKN7ooRhhXnt
	lcdsGr35jJQVwUBB/4amse8bMHxSSM/MAj4Yo2XY9XZNaPhrrgjZVAMO1LCIePDJIBoNWImsU3BE0
	JpPZVmZNr/UkOCC8HBGt2pO3+t1NfGjwX0hUDV2/tdmtFz38xcTbPKeHBzHl7zrZf4ySKQQkaFcMj
	BM7rBwlI7hA9zxzurGVh+lF1n3Y9qW/VO3wMFsj99Gq4pr5Q35PdPoD6aczsMdkOA4FaEsu2ZXsbk
	wXx4ngcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnFc-00000005Ra5-30ey;
	Mon, 22 Jun 2026 22:36:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnFZ-00000005RZi-1dc3
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 22:36:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782167774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdY9TCOCaqdI9+jOH1ZxraaFlRq2CcnwWYmV5BAETuo=;
	b=EtcRKmjTyVU8zPet9maVWkXGHJELb6S8UIxOdb08ReSUyjiNQ65DcRiULsGx95By6vbAeO
	gBI6QnsfvXH3AkwuwTswXrN/2k/eIXPbge5ZGrZBk22+qeVhmmfRB1TU2UAXo/9q0X9mAI
	DaiMSBErZAVjDpI2WzVrEnhhYUF5mzg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-ujAb10sgNHCtIUT58pSGow-1; Mon, 22 Jun 2026 18:36:12 -0400
X-MC-Unique: ujAb10sgNHCtIUT58pSGow-1
X-Mimecast-MFC-AGG-ID: ujAb10sgNHCtIUT58pSGow_1782167772
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517787172b0so93104921cf.0
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 15:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167772; x=1782772572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdY9TCOCaqdI9+jOH1ZxraaFlRq2CcnwWYmV5BAETuo=;
        b=FHvmqW1WQI9yULxRaBhUHQV3Z8hOUAkRg5sV6JjVNousEC/yV5USqTnIIlAldzalox
         wJwRrWswUjzIT9/5BBcaZY3Qw+70bzCAWhuPIISLZ5hlv3i7Si+zkiLJ0qq2BfWdeRWu
         R64r4yAVUdr09m8/MS1H+yuCtqorV+FOKNYUTAlnY+mXj6hll9yCBVxdnK/wWSs7zPRJ
         K29uvk83vwkoeh0Ct5U8gWzUOhFvU7jR7HTgHmf5Q9HjWKV98FPWmpHkIKVVjkVN7/It
         U0I9ZRo2k98mQFz59TSsTDsatPXcomI+5ntcdzy908Pnnb6qd51W/eca+YwFp405rTaI
         jbmA==
X-Forwarded-Encrypted: i=1; AFNElJ9hw8fqxQ/gwOFMqOcwzCodTXRkJeUUHC37IdMBlYBC6Zpua6IW2eRfMXJc0zQggWojJDgePg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwP1Kt1J8P3yR4U3/3Ir2jzN88lPgqHnQragNuw3ekrKefhok/n
	JmcTyRlenYWrc58u4PshCqPhg9imdNpnLDX4ngJdXcRc4XkMmQOjmrIj2JFn8sZQtswI45egzQt
	qfAzDpALyfX4McdAyy+WaCtP6an3QlLQdOp1eHW9hqZ1naXepOJyR0wlqkZFmxNCtVQhCekH3CH
	/Mx8ZByCgmzVTiYcED6aInoZYPSuj218qt7P3/
X-Gm-Gg: AfdE7cm4n+B8eQ6v4rH7jakXf4IvxeQ3KXX+oFGSc2F3d2AocDOKX++z+Lbn8MfNPyW
	yFo/FWq32GoSBjSloByZmPzVps+rwlvvYW7/7TKnT2hZBQFT16BNkejqdyPCjPd7dYYEp2uQQgh
	7qrHzanXKe3nS8vbk601Hiy7V431piTEtPyGMZ0mzVEgi0aS3XoLyNgMf+xt/OBAUdTwY=
X-Received: by 2002:a05:622a:481a:b0:516:d943:175f with SMTP id d75a77b69052e-519e4e31b61mr270185871cf.52.1782167771818;
        Mon, 22 Jun 2026 15:36:11 -0700 (PDT)
X-Received: by 2002:a05:622a:481a:b0:516:d943:175f with SMTP id
 d75a77b69052e-519e4e31b61mr270185381cf.52.1782167771409; Mon, 22 Jun 2026
 15:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com> <ahoA_5MfC7FuC8CQ@templeofstupid.com>
 <CAO7dBbWOgztZPrazUGN6q+L_62ipywj4Myurcd4R4q95J0_XMw@mail.gmail.com>
 <ah4oINLOlhxpQuFR@templeofstupid.com> <CAO7dBbWZ8V_33MnXfgd_DfAwOVEBYtjwwm2DQxy8OrbipYBuBQ@mail.gmail.com>
 <ah5gyh2RfLg-JzDF@templeofstupid.com> <CAO7dBbVqBKmCzAXrRLvEOJg_+VjZOXxLkjfVkVHE0Emg976wew@mail.gmail.com>
 <ajl422McaqugeWHs@templeofstupid.com>
In-Reply-To: <ajl422McaqugeWHs@templeofstupid.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 23 Jun 2026 10:35:34 +1200
X-Gm-Features: AVVi8Cc-cR9wqWjhmTDBxKa7Ln-1743wXkDDRm5Iheb0vnFX1IC2LJBP9IBRNTQ
Message-ID: <CAO7dBbXCsCb16+aUDctHgDGrDbpOsRmh=kL4Fx=RA1CY2rp41A@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yZjz-AKYtnkqDKapQg8Pyc3_WYSes1-q5o3y3rixmuI_1782167772
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_153617_533591_D27ED6E5 
X-CRM114-Status: GOOD (  31.32  )
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

Hi Krister,

On Tue, Jun 23, 2026 at 6:03=E2=80=AFAM Krister Johansen
<kjlx@templeofstupid.com> wrote:
>
> Hi Tao,
> I appreciate your additional investigation on these questions.
>
> On Thu, Jun 11, 2026 at 01:24:50PM +1200, Tao Liu wrote:
> > Hi Krister,
> >
> > I took some time to think about the data erase functions as we
> > discussed previously, and I have implemented one sample data eraser
> > based on the current v5 extension framework in [1]. According to my
> > test, this works well and has no conflict with the mm page filtering
> > extensions. With this, people can do data erasure as well as page
> > filtering in both 1st/2nd kernel as long as btf/kallsyms info is
> > accessiable.
>
> I took a look at the example in your subsequent e-mail.  I think this
> would work for what I'm trying to.  I didn't realize that the extension
> callbacks you built had the ability to call into the other erase code
> that's also available to eppic.

Thank you for raising the data erasure issue, to be honest I hadn't
thought about it in depth before your message.

>
> > As for btf/kallsyms support for makedumpfile.conf based erasure, I
> > forgot to mention there is one critical info missing compare with "-x
> > vmlinux" dwarfinfo, is the type of global variables, please see the
> > patch [2]. As far as I know, currently kernel hasn't enabled the btf's
> > ability of including global variable's types. E.g. symbol "init_task",
> > we can only know its address by lookup kallsyms, but btf have no
> > record if its type, because it is a global variable. If we create
> > makedumpfile.conf as follows:
> >
> > [vmlinux]
> > erase init_task
> >
> > It can work with no problem for "-x vmlinux" because dwarfinfo
> > contains all info. But it will fail to btf/kallsyms, for btf doesn't
> > know init_task's type is task_struct. However this is not a problem
> > for makedumpfile extensions, because when programming, we can cast it
> > as task_struct by "init_task =3D GET_KERN_SYM(init_task); task_list =3D
> > init_task + KERN_MEMBER_OFF(task_struct, tasks); ...",  but we cannot
> > do the same to makedumpfile.conf.
>
> Got it.  It wouldn't work with the current configuration file syntax
> because it needs more information to pass to the APIs that perform the
> btf lookup?  Trying to understand if GET_KERN_SYM can be dynamically

Yes, because currently, no BTF info is integrated for global kernel
variables. That is, we can only know global variable's address by
kallsyms, but no type info from BTF. If we try to build
makedumpfile.conf erasure upon btf, it should be something like:

[vmlinux]
erase (struct task_struct)init_task

To be honest, the syntax will be ugly, and I'd prefer the issue fixed
on the kernel side rather than in makedumpfile.conf side. As for why
kernel hasn't enable the global variable's btf info, that's another
story and should be addressed individually.

> filled in, or if its a macro that's evaluated at compile time and isn't
> dynamically changable.

When macros such as INIT_MOD_SYM(vmlinux, init_task) are used, a
special elf section will be reserved for the extension .so at compile
time, this indicates the extension needs this kernel symbol before it
can run. When makedumpfile parses the kernel's btf/kallsyms, these
special sections will be filled with their respective values. After
this, the extension is runnable, by using GET_KERN_SYM() macro, the
values will be retrived from the special section and developers can
use it directly.

Thanks,
Tao Liu


>
> Thanks again,
>
> -K
>


