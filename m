Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1639DCD98C5
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 01:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j5RaIGEaG96nSykq283O4N7mLcySz+gP7SKsno6HMF8=; b=YF+qRMA+12am2el2hGv0ozvz2b
	62olZgawdgk2SYCY5TXSakYhRP4Tw/nFGetIYEqo43BmAJuptmubrBUPTDTD5NgOsVYQ5xEcFi0k2
	FTXP/akDzpO4QGXAQUDy03tQagu+zJh64MAMNndPvre+H20wJuiF8HYRqvnQrqKMRaEzXSRUYUNfX
	2kZrEa+OWdkINxwopFf3nE4Cpt3mVmVqe+ZksZpBbcT6/COrHJTC6UqzEOwvoH7jkdlKMlIQVIPbW
	TUqqDVwkuYReNgaJf5trH+ITUiJJ4C+LSP4H4WbE22/Z84TdbuYnRAF9JkSJE5Cm60Q/ciXWCzINQ
	qLFiXZow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXUAp-00000008Wbo-2GVJ;
	Thu, 11 Jun 2026 01:25:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXUAl-00000008WbS-3i86
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 01:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781141130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5RaIGEaG96nSykq283O4N7mLcySz+gP7SKsno6HMF8=;
	b=Nd9mglK3nkqYLTISOMSoAGLJy6A8cTEumYBQoQQ8M/8hM0qEbtsILIzUCRvrv8VTwi0yQN
	52nGscghHW0LVomyEsDOMLt+gB1E9IAbFCu1qrsY0vwRjslk8IChxbfEBflKischtbGSd9
	C+pvCsYT/GTL9yUO+6NjvOE5V95gSrk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-NtOpQSRgPG60_mdt_iwRIQ-1; Wed, 10 Jun 2026 21:25:29 -0400
X-MC-Unique: NtOpQSRgPG60_mdt_iwRIQ-1
X-Mimecast-MFC-AGG-ID: NtOpQSRgPG60_mdt_iwRIQ_1781141128
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccd83d58d9so121265966d6.0
        for <kexec@lists.infradead.org>; Wed, 10 Jun 2026 18:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781141128; x=1781745928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5RaIGEaG96nSykq283O4N7mLcySz+gP7SKsno6HMF8=;
        b=PnHCIybK+TzPmv9Cln9u9o/JIAXeToYbM2aI/4KjupR1zA/gC44x92uKf505H5cXGa
         sjlMh2IWYsCGrwdEEliOFUqxhGuogT8smiR+m6SbT922Yq76p+QNMY3D2e5tE7RzMGND
         jqpvxrfAGLWtVnbVfXttVl6TXhp11br06KRuT25Nf/4R+4R1/QiskGtnfYaBx+D+hwSp
         n6wLTnNDG5hR6n22+5TswDMD3sBGQH9B0xhJaUI1Qlwk0XqmIbWw+Iq/Nrz/QN0J7l9D
         /J7OWYdAVxWwbXOThxLzTV6rPcxcnXERH9mWH5LDaS3VkUdWF8QPCEPQmLKHUrAysi0e
         dkxw==
X-Forwarded-Encrypted: i=1; AFNElJ96Lvf+cqwKtosueUh5fcFGPBwTdL8RFjnqurabqHxnQn9EeTDxLfcwMybWJuXWffoUq35M9g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+wKRjxYJTYUwJbPqUoNDVnETd/p3rRI54ilGYIITdMxlVFl9L
	c9YQcwpvy1/doH/auFKg4PkKreohpPBgxA6OzbCsAK491y7g0i+nMgwimAoljmmPcUZ4IWnUgPl
	LJhtlkI97CahO+NK0a00TG7FR1XcsILs5L0DFWT4IKErYGuuP/8OAPp70LERzBnyhWlLfhHPF/o
	KJ/qE0d8wQyKvEqVl5xjCgKOGx86tQz/NlxMuT
X-Gm-Gg: Acq92OEk7Ly0JT4GoETsZoyctrjhbup7v47oAh27aZffQJmuDe9iZuyxySgtiyx2X5S
	jwjxAKiu1KiiOmX/aaXZlGq/m10W36Hp/C2dH7KL7wRXJnhaAiV6e/sSFB/xwwhSpxdEOsrmjBe
	xn3EViG52QdqWs9gNAQaHaVzOcoBjmepNwCF59O1nnsQiUjicRkmTAVcQqOUF8TBSXyGDXvOHC+
	ksoDEvomItWcQOc
X-Received: by 2002:a05:622a:903:b0:517:6d82:9aec with SMTP id d75a77b69052e-517ed686b2dmr14980841cf.0.1781141128245;
        Wed, 10 Jun 2026 18:25:28 -0700 (PDT)
X-Received: by 2002:a05:622a:903:b0:517:6d82:9aec with SMTP id
 d75a77b69052e-517ed686b2dmr14980351cf.0.1781141127666; Wed, 10 Jun 2026
 18:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com> <ahoA_5MfC7FuC8CQ@templeofstupid.com>
 <CAO7dBbWOgztZPrazUGN6q+L_62ipywj4Myurcd4R4q95J0_XMw@mail.gmail.com>
 <ah4oINLOlhxpQuFR@templeofstupid.com> <CAO7dBbWZ8V_33MnXfgd_DfAwOVEBYtjwwm2DQxy8OrbipYBuBQ@mail.gmail.com>
 <ah5gyh2RfLg-JzDF@templeofstupid.com>
In-Reply-To: <ah5gyh2RfLg-JzDF@templeofstupid.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 11 Jun 2026 13:24:50 +1200
X-Gm-Features: AVVi8Cc6vlbUeIDa7V2q4yL-Ed8z-pjXy49SCjL2tLYz9Svk3qgQoO7d6KamRHQ
Message-ID: <CAO7dBbVqBKmCzAXrRLvEOJg_+VjZOXxLkjfVkVHE0Emg976wew@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4csBfc3ciiupwh_HahNtylPDctl42yAAfRjdeZhl8Fw_1781141128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_182532_030215_2DB1C713 
X-CRM114-Status: GOOD (  60.83  )
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

I took some time to think about the data erase functions as we
discussed previously, and I have implemented one sample data eraser
based on the current v5 extension framework in [1]. According to my
test, this works well and has no conflict with the mm page filtering
extensions. With this, people can do data erasure as well as page
filtering in both 1st/2nd kernel as long as btf/kallsyms info is
accessiable.

As for btf/kallsyms support for makedumpfile.conf based erasure, I
forgot to mention there is one critical info missing compare with "-x
vmlinux" dwarfinfo, is the type of global variables, please see the
patch [2]. As far as I know, currently kernel hasn't enabled the btf's
ability of including global variable's types. E.g. symbol "init_task",
we can only know its address by lookup kallsyms, but btf have no
record if its type, because it is a global variable. If we create
makedumpfile.conf as follows:

[vmlinux]
erase init_task

It can work with no problem for "-x vmlinux" because dwarfinfo
contains all info. But it will fail to btf/kallsyms, for btf doesn't
know init_task's type is task_struct. However this is not a problem
for makedumpfile extensions, because when programming, we can cast it
as task_struct by "init_task =3D GET_KERN_SYM(init_task); task_list =3D
init_task + KERN_MEMBER_OFF(task_struct, tasks); ...",  but we cannot
do the same to makedumpfile.conf.

In summary, if we still want to use makedumpfile.conf for data
erasure, "-x vmlinux"'s dwarfinfo is unavoidable for now.

Thanks,
Tao Liu

[1]: https://lore.kernel.org/kexec/20260610234249.10993-2-ltao@redhat.com/
[2]: https://lore.kernel.org/all/20250207012045.2129841-3-stephen.s.brennan=
@oracle.com/

On Tue, Jun 2, 2026 at 4:49=E2=80=AFPM Krister Johansen <kjlx@templeofstupi=
d.com> wrote:
>
> Hi Tao,
>
> On Tue, Jun 02, 2026 at 03:04:12PM +1200, Tao Liu wrote:
> > On Tue, Jun 2, 2026 at 12:47=E2=80=AFPM Krister Johansen
> > <kjlx@templeofstupid.com> wrote:
> > Thanks for your in-depth explanation, it's very helpful to me for
> > designing the data erasing function.
>
> Thanks for the great discussion.
>
> > > On Tue, Jun 02, 2026 at 11:12:05AM +1200, Tao Liu wrote:
> > > > On Sat, May 30, 2026 at 9:11=E2=80=AFAM Krister Johansen
> > > I wondered about this, but for data-structures that are smaller than =
a
> > > page, wouldn't that mean that we're erasing other content?  The "eras=
e"
> > > plugins memset the output data to a chosen value (or 0), whereas the
> > > filtering just drops the page.  Couldn't this also lead to a situatio=
n
> > > where the debugger can't find the page at all, versus giving us one
> > > that's sanitized?  (I do understand why you want to drop the pages fo=
r
> > > the GPU cases)
> >
> > Frankly I didn't consider the data erasing as in-depth as you did. I
> > think you are right, makedumpfile needs to know which extensions
> > handle data erasing and which handle mm page filtering. I guess the mm
> > page filtering extensions will need to perform a "dry-run" filter
> > first, in case the "data erasing" extensions break any useful data
> > structure. In this step, "dry-run" will only record pfn numbers of the
> > pages that will be filtered. Then "data erasing" extensions are
> > called, so all the sensitive data is memset to 0. Finally, all desired
> > pages are filtered out based on the previous recording.
> >
> > With this, "data erase" and "page filtering" will not interfere with
> > each other. What do you think?
>
> This is a great point.  It's probably worth documenting the precedence
> order in which these callbacks are expected to be applied.  Naively, I
> might expect filtering pages to take precedence over erasing data
> structures.  For the GPU cases, these are orthogonal.  However, for
> something where a user might be both trying to filter the page and erase
> matching content, we don't have any rules defined.  It's probably less
> surprising to allow pages to be filtered first.  (I think it is this way
> in the code.) It also prevents the page filtering from completely
> filtering a page.
>
> > > > > Would you be willing to modify the extension registration options=
 to
> > > > > allow an extension to specify what kind it is? That way, in the f=
uture
> > > >
> > > > I'm not sure what you mean by "what kind". Do you mean an extension
> > > > needs to tell makedumpfile what purpose it is for when loading?
> > >
> > > Yes, sorry I wasn't clear in writing the question.  Stating this
> > > differently, if we want to allow the ability for different extensions=
 to
> > > do different things, how do the extensions declare to makedumpfile wh=
at
> > > they can do, so that it knows where to invoke their callbacks, and wh=
at
> > > callbacks of theirs to invoke.
> > >
> > > Looking at patch 6/9, right now run_extension_callback() is involved
> > > from __exclude_unncessary_pages and always calls the
> > > "extension_callback" symbol in the module.  This makes sense for a
> > > single extension type that's focused on filtering pages.  However, if=
 we
> > > wanted to have multiple different extensions, this might be more
> > > difficult.
> > >
> > > If we could determine what type of functionality the module implement=
s
> > > in load_extensions, then we could tell if this is a page filtering
> > > extension, an erase extension, or some other kind of extension.
> > >
> > > For example, for an erase filter, perhaps we would want two callbacks=
:
> > > one to set up the ranges to filter "extension_gather_callback" and
> > > another to actuallyf check the address range to see if it is filtered=
,
> > > "extension_filter_data_callback"
> > >
> > > I'm not sure about the names.  "extension_callback" seems generic, bu=
t
> > > this has a specific purpose.  It's a "extension_filter_page_callback"
> > >
> > > I may be overengineering this a bit, but having makedumpfile pass an =
ops
> > > vector to the extension in a load function could help here.  Then the
> > > module's load function fills out the vector with the functions it
> > > supports.  Depending on what's implemented, these can be placed into
> > > different callback lists to get invoked at different points in the
> > > program (e.g. one at pfn filter time, another in filter_data_buffer,
> > > etc).
> > >
> > > It sounds like you had a plan here, though.  Were you thinking of add=
ing
> > > new extension types a different way?
> >
> > I see your idea: makedumpfile predefines a few hook points at
> > different stages, and extensions can register their callbacks to these
> > hook points. For now I think 2 hook points are enough, one for page
> > filtering and other one for resiger the data erasing, which definitely
> > shouldn't be within __exclude_unnecessary_pages().
> >
> > I'm willing to modify the code. Such as implementing a hooking point
> > registration/management. But since I haven't work on the data erasing
> > functions so far, the design might be superficial, personally I'd
> > prefer to do this along with the data erasing functions in the next
> > independent patchset, considering current patchset we already includes
> > plenty of code/function implementations. @maintainers, What's your
> > opinion?
>
> Just to clarify, I'm not asking that you implement any erase
> functionality in the current patchset.  Rather, asking if there's a way
> to implement the current functionality such that the extension modules
> won't need recompilation when a new extension type is introduced. I
> think there are a number of different ways to do this, but I didn't want
> to be overly prescriptive in my feedback.
>
> Thanks again,
>
> -K
>


