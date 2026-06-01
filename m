Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC91CD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNgVF9TEy/caXgQVeIMxyPx0m1lO15Jde8bB+011DoI=; b=rGdZh0YLLgEipN0jDF4S5E8AbP
	x5Gy51H41lRSMiOYCOoRXtdXFnni1RC3FcwtV9WYNaJRaYzw12bllq8rd3LBzjkCZfq7dNtPDlqaO
	MIglydPsXOoP9JAazyvXJgKeZal9RmhXcucFZipbvtKZFyIDHtTWWF7IlkUtEnxdIw53xC7K9V4yI
	0IVj0CUKniWiNRYRATN0sd2r+VzzIKUz5K6l0Ym+/BBZtTGX8LtMwBarvIOK2r01SSI4H/Hk91Kby
	SUV38f8/hfq/ICRdEmJfnRvFEPbs4nx8IBenLTzHZPo96PeOsC1PE9TkPENwWWPr1NWsPRfbM1d8K
	4hePTDPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUBoQ-0000000C2f1-31Pb;
	Mon, 01 Jun 2026 23:12:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUBoO-0000000C2e5-0Geg
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 23:12:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780355565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNgVF9TEy/caXgQVeIMxyPx0m1lO15Jde8bB+011DoI=;
	b=fqa9InAPzOVOZerTA5e9AScYl/b21dB2V7TE76ih2K4yFk2HyVCOzypiC4wqBkUejYJmhM
	Akxu3sad3MswZDorrTaY6/YbEYvJKkk2Ej9W//AynWpRDFJB8VzbCYCH2SW7QNrFqUi+Yl
	Su02d/KdPH5L5x/h8g5Soj1iHdhVnek=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-VQQ76ddhMcGb2-1EPRgKcQ-1; Mon, 01 Jun 2026 19:12:43 -0400
X-MC-Unique: VQQ76ddhMcGb2-1EPRgKcQ-1
X-Mimecast-MFC-AGG-ID: VQQ76ddhMcGb2-1EPRgKcQ_1780355563
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51766317074so9959331cf.3
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 16:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355563; x=1780960363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNgVF9TEy/caXgQVeIMxyPx0m1lO15Jde8bB+011DoI=;
        b=LXWCSIrU+lgj01UaokjrqiIOeIL6NWZuKOlXn6c36VUE2SDH9QZN/q5UV4hNPl4mWk
         8N99M2A8o3P+YwVnDAfGwAKCGXSA0sL94DT+7+LagXaEibuJVhF7kM83m1t1WaF55QXf
         LqzPr7z+IjRf8HswY4jBBBLWri/Z7yt4UIan8EjiCWFvVaE+IKSkolJOP+X4KAfleuHo
         duOKdLiU9+YlT7q3kng3pWII3WeEICx2c9WdMizW2V7GjUnRjIx6d1rC87zFnU1D3gBU
         fdlnKvf5Eg9gXYj9PqQbursw3D4ocr91PYlKIlAFe485V1DlN869Q8GzdKavlrSNJhxf
         7jTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bIJqts3dzNoS77bMtoLedXgTIf+Bd87hjYcCBskql8jW/g2ByHihcqibX1crKfAZs9cvjmw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4xWI4HUOk5ep3x4CYbTjhttCQ31E4PI3cfzeP2nSVQxJOaTe/
	XjQYoWrFymG33tEb1RcptCBl68G4hArrtFuWxc3GcacSfNQEQAORdrRBFTvFoAXkjc7qv25NmqQ
	wjMKZodnVUFEr0gZq2/hojLrj7O00BeaMC9n7H3aeU9YawmaOgqt4xJoIgtNYlBYpsUHXw7FTGc
	uztkCZE2qyPIvaOjmYX4J7pJ5lntT6PuQdGUZ3
X-Gm-Gg: Acq92OE8S+AoxsrmahuAF0NO5UPOBtCK3iGJx/SQJDmotHJ6FEZoVT2pooZAJknhyf9
	Q5bsU0wX1mBxFHV4Pw84amSn0XmAlglIJsmvP2NiCvTATCENzfdstr/rp+UafEEI8f4R/Ub5Qny
	svg/ykH73XgbENUe5EEKbzLHwP1aucZ5t2yXyVxmi8NCFyql8U6jkDN8f5prOsDnqptelEf6KDp
	+z0rP5VGyYf07qv
X-Received: by 2002:a05:622a:2a1a:b0:517:5d7c:98ad with SMTP id d75a77b69052e-5175d7c9a00mr58043191cf.29.1780355563094;
        Mon, 01 Jun 2026 16:12:43 -0700 (PDT)
X-Received: by 2002:a05:622a:2a1a:b0:517:5d7c:98ad with SMTP id
 d75a77b69052e-5175d7c9a00mr58042811cf.29.1780355562650; Mon, 01 Jun 2026
 16:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com> <ahoA_5MfC7FuC8CQ@templeofstupid.com>
In-Reply-To: <ahoA_5MfC7FuC8CQ@templeofstupid.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 2 Jun 2026 11:12:05 +1200
X-Gm-Features: AVHnY4JBnUNLbT-cf1X95eaxyPA09YdWJDfs50D9I2SY0j-nApTauRPMRxiWETg
Message-ID: <CAO7dBbWOgztZPrazUGN6q+L_62ipywj4Myurcd4R4q95J0_XMw@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vPcoTn6443DMefGG3B-p8Y8cWEEOOU6hraRSVgZyyYs_1780355563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_161248_177311_4DFB7500 
X-CRM114-Status: GOOD (  45.08  )
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

Thanks a lot for your suggestions and comments!

On Sat, May 30, 2026 at 9:11=E2=80=AFAM Krister Johansen
<kjlx@templeofstupid.com> wrote:
>
> On Tue, Apr 14, 2026 at 10:26:47PM +1200, Tao Liu wrote:
> > A) This patchset will introduce the following features to makedumpfile:
> >
> >   1) Add .so extension support to makedumpfile
> >   2) Enable btf and kallsyms for symbol type and address resolving.
> >
> > B) The purpose of the features are:
> >
> >   1) Currently makedumpfile filters mm pages based on page flags, becau=
se flags
> >      can help to determine one page's usage. But this page-flag-checkin=
g method
> >      lacks of flexibility in certain cases, e.g. if we want to filter t=
hose mm
> >      pages occupied by GPU during vmcore dumping due to:
> >
> >      a) GPU may be taking a large memory and contains sensitive data;
> >      b) GPU mm pages have no relations to kernel crash and useless for =
vmcore
> >         analysis.
> >
> >      But there is no GPU mm page specific flags, and apparently we don'=
t need
> >      to create one just for kdump use. A programmable filtering tool is=
 more
> >      suitable for such cases. In addition, different GPU vendors may us=
e
> >      different ways for mm pages allocating, programmable filtering is =
better
> >      than hard coding these GPU specific logics into makedumpfile in th=
is case.
> >
> >   2) Currently makedumpfile already contains a programmable filtering t=
ool, aka
> >      eppic script, which allows user to write customized code for data =
erasing.
> >      However it has the following drawbacks:
> >
> >      a) cannot do mm page filtering.
> >      b) need to access to debuginfo of both kernel and modules, which i=
s not
> >         applicable in the 2nd kernel.
> >      c) eppic library has memory leaks which are not all resolved [1]. =
This
> >         is not acceptable in 2nd kernel.
> >
> >      makedumpfile need to resolve the dwarf data from debuginfo, to get=
 symbols
> >      types and addresses. In recent kernel there are dwarf alternatives=
 such
> >      as btf/kallsyms which can be used for this purpose. And btf/kallsy=
ms info
> >      are already packed within vmcore, so we can use it directly.
> >
> >   With these, this patchset introduces makedumpfile extensions, which i=
s based
> >   on btf/kallsyms symbol resolving, and is programmable for mm page fil=
tering.
> >   The following section shows its usage and performance, please note th=
e tests
> >   are performed in 1st kernel.
> >
> >   3) Compile and run makedumpfile extensions:
> >
> >   $ make LINKTYPE=3Ddynamic USELZO=3Don USESNAPPY=3Don USEZSTD=3Don EXT=
ENSION=3Don
> >   $ make extensions
>
> I love this idea.  Do you have time to take it further, and if not are
> you open to making the extension framework more modular so that we could
> add others in the future?

The purpose of extension is to make the framework modular. My original
thought is, we can implement several makedumpfile extensions, each
restricted to one specific function. Like one extension deals with AMD
gpu mm filtering only, one deals with Intel gpu only etc. For distros
we can ship all extensions along with makedumpfile once, but the
respective extensions will only take effect if the machine has AMD /
Intel gpu. This is the same case if you'd like to add other customized
functions while the makedumpfile core remains unchanged.

>
> Could the btf lookups be extended to cover the symbol lookups used by
> eppic and the erase filters so that the -x option is unnecessary for
> kernels that have BTF support?

Yes, from my view it is doable and not difficult to implement.

>
> The current extension implementation is focused just on skipping pages,
> but it would be great to be able to use this to erase data in structures
> like the config filters and eppic, but without having to provide a
> vmlinux at dump time.  What do you think about adding the ability to
> use the extensions to also erase parts of data structures, in addition
> to filtering whole pages?

That's the step 2 for the BTF/kallsyms work of makedumpfile, and I
have planed to work on this once the patchset(step 1) is accepted. The
reason for the task dividing is, the GPU mm page filtering is more
urgent than data erasing from my view. For data erasing, at least we
can do the erasing in 1st kernel with the help of dwarf, cumbersome
but working; For GPU mm filtering, as far as I know, there are no
handy tools in 2nd kernel.

I think erasing the data is doable upon the current page filtering code.

>
> Would you be willing to modify the extension registration options to
> allow an extension to specify what kind it is? That way, in the future

I'm not sure what you mean by "what kind". Do you mean an extension
needs to tell makedumpfile what purpose it is for when loading?

> we could register multiple different kinds without breaking existing
> ones.  One for filtering pages, one for erasing / modifying dump
> content, and others based upon whatever additional use cases develop.

That's the goal of extensions, each extension deals with its own
business. Could you point out the code that doesn't match the goal?
I'm happy to correct it in v6.

Thanks,
Tao Liu


>
> Thanks,
>
> -K
>


