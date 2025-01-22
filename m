Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9908C02181
	for <kexec@archiver.kernel.org>; Wed, 22 Jan 2025 05:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9l60eMiBatjulNqPwNpZ4yuZ+rTXdgZOa9/Ftk6xxo4=; b=Efe79g0AQkNj40A9+zfa5Wh/cD
	lxB2S665csp+9GW0YCl+aW7SCbU+2VlL0E9lfkThO+C2sg7qnWF2Giu5tZ0jdfo+hkPnfDW9gDQaS
	Z7lEuCOBerTewNUijTmpDO1GYM0HffXsSYTv9p8TrkWUzIVXcrkCiQQior77Eeaurz8taJgc6qLmj
	LrTW0a/PDqZn95EBJLdVmskzLlNly1cSm4RbxvSqh8kNybdNNc92bK/VA3/N4XwU47KHpeT/+B4av
	6cNyE+IZ0hVztDKFAYDtTfAu4DGqOGQXqEZhu/K9OMgfgHYre/DZhjwDRd/oa4t5AwQnrpDcboE8p
	Qu73bQGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taTR8-00000009QWc-18lJ;
	Wed, 22 Jan 2025 05:37:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taTPq-00000009QP0-2ZFp
	for kexec@lists.infradead.org;
	Wed, 22 Jan 2025 05:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737524196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9l60eMiBatjulNqPwNpZ4yuZ+rTXdgZOa9/Ftk6xxo4=;
	b=Rn4SOnrWXqtKE2bSqz9yDugHo2Zln0uZ1wZP33kjg3BlXXDD9nZjjpfBMQQvv2c54F9Obp
	IGfiWx+9FnEali+wqVBSkwoSJYtk8rkSTGPOGiN9YyeutmoyIX6/tdJ8U/526DJ4WT40Pu
	d+H6B6lcNutIju4Uat/3XuLqwUasAT0=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-QwkLR66VNsGc60kNZ-jk3w-1; Wed, 22 Jan 2025 00:36:34 -0500
X-MC-Unique: QwkLR66VNsGc60kNZ-jk3w-1
X-Mimecast-MFC-AGG-ID: QwkLR66VNsGc60kNZ-jk3w
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3cde3591dbfso4025015ab.0
        for <kexec@lists.infradead.org>; Tue, 21 Jan 2025 21:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737524194; x=1738128994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l60eMiBatjulNqPwNpZ4yuZ+rTXdgZOa9/Ftk6xxo4=;
        b=oStcYZ4UM3bz1AMTz8hcf+j0ch1qiyoLLIc3Q8LjJgxjTQlyMa65EHDXehs5ggdecJ
         5MqOdVcX9aiEuuuLZGaBSsnKRWZtFcrJuCoD1oeJoyjj7Onm+Y3z+CtBM2517AOPcQCG
         ly2bKkN0MhQxXhiR/VKCxnOTsX3glVh2GbLCnu9SlqhaBHp+FZvhm0skVUVQDl4Kigk8
         gRhm0vP6kblRo56FxPqgwrvJOuZ6fqv2gSVEXDwj24q5MPH3zkAsz/Kht5ABh3prR5L3
         YCv/Y6gSkWaaoyv+QYb3a/Rsyr00oiHIVfiViOQxVc4+ytvoIgyJtIfRVogEh5ErS3CW
         SBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxPFTgUTPvgg66JlOXeM1PQZDa1rKkddxnoKTiDxYwYwRyb6Kv0NK7TYWHQF7QDCf79X987g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyhb3JJZmi4ljnSpReUVLR1CnKlukrQVEj8oIqOsKzCbQYLM788
	Hk16bhTLo1YULyHYhNUlTgkSvVrOyuh3HYBYWVKp+nIdPaSzvYlltkAMLMSiuSU6aZ1Yvzct6KO
	prDm5TWiHLRTO8flkBIY/AR0er2XcyexEiVjKzTIy22gpyg7ABGfHSiaAmbZIGGzlP+IhtmyOVn
	uzh4eIlq8gY7KtRum6ISojiZRrWKJdB+bN
X-Gm-Gg: ASbGncvQxVIL+14lp/T29IRXkY48rivspPJG1wEdzoxl6R+PgyeG7r/S2xrrIHeAIOD
	cJSkaSLtntll9UyfDqhNf2w8dQxlngENZRcqgHJMV1alx/qsd0BPv
X-Received: by 2002:a05:6e02:b28:b0:3cd:e9a0:3c3d with SMTP id e9e14a558f8ab-3cf7479d52amr170082745ab.2.1737524193749;
        Tue, 21 Jan 2025 21:36:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1NteIeOEFSZQJMQta9H79qVzAVNQuPvHhvy/+a48GnvWI55kw2kVLGryRVDAv7Jiw553w+jC1f5oh5mpxImA=
X-Received: by 2002:a05:6e02:b28:b0:3cd:e9a0:3c3d with SMTP id
 e9e14a558f8ab-3cf7479d52amr170082645ab.2.1737524193462; Tue, 21 Jan 2025
 21:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com> <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com> <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com> <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com> <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
 <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com> <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
 <c5f68f9f-1494-426b-a5b2-bf6c1483c02f@gmail.com>
In-Reply-To: <c5f68f9f-1494-426b-a5b2-bf6c1483c02f@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 22 Jan 2025 13:36:40 +0800
X-Gm-Features: AbW1kvasSuob105uOOtVQhAqqYFk9t9t0n8BzZ024DbzitZW85su35TvVCpG4fY
Message-ID: <CALu+AoS5_w2CV5w+b1WrFRFH7nfwmkLZUh=AXn=D=7rAhDNVAQ@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, devel@edk2.groups.io, 
	kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wDF25b3B0gEb2BQOvNDnVSG-eVCFo3SLXYreVzQkCwE_1737524194
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_213638_741125_29CB1A9D 
X-CRM114-Status: GOOD (  20.81  )
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

Hi,
On Mon, 20 Jan 2025 at 19:48, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 20/01/2025 11:29, Ard Biesheuvel wrote:
> > On Mon, 20 Jan 2025 at 11:50, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >>
> >>
> >> On 20/01/2025 10:32, Ard Biesheuvel wrote:
> >>> On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
> >>>>
> >>>>
> >>> ...
> >>>> Hi Ard,
> >>>>
> >>>> Just wanted to check how should we proceed forward? Should we try and fix the warning
> >>>> and corruption during kexec as done in this series or not initialize memory attributes
> >>>> table at all in kexec boot? I would prefer fixing the issues as in this series.
> >>>>
> >>>
> >>> I would prefer kexec boot on x86 to disregard the memory attributes
> >>> table entirely.
> >>
> >> Would you like Dave to send something like
> >> https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
> >> on the mailing list (wrapped in ifdef CONFIG_X86_64)
> >>
> >
> > I prefer this approach. and no need for the ifdef, this is x86
> > specific code, and the memory attributes table is already ignored
> > entirely on 32-bit x86 iirc
>
> ah yes, I ignored the file name when reviewing it and just focused on the function :)
>
> Will wait for Dave to send it.

Ok,  I will add reported-by from you and suggested-by from Ard.  But I
can not test the efi mem attr, I'd prefer to have your test results
first.  Could you confirm that?

Thanks
Dave


