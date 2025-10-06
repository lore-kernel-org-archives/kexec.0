Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9773BCCA470
	for <kexec@archiver.kernel.org>; Mon,  6 Oct 2025 23:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ybILaILRCl7/UBex2ty3xf+O7+CzTBJ2uGf6Ymm2ESU=; b=AQIfSMggCBa8xC0qqBz003p+23
	mLz4oKKlpmRRWeMOF3fZsfccT7KTd4eF1uLwFSDk3yrBTNTc5pM5/7DZARLHGmuiGoa3N5WIimoeP
	XZFusYGgQnVmDcfJZmLvtg/+pm6pW+P09OvdjTA/vN2GggsdejW0wRTGqkBzld3SAc3iCBrWhH8p+
	3Bc2RgcCP0xwR+nCay/6kRuzeMB5pjgwwY4mWsQ1JsXWy9RobdTKyZ3l0AYGYMrmWhjPHY0dp3iU/
	RpavS/c4Kn+8BTqbQWudEYqLfk0TWjtSV4VaZVEF5kp1b5dpn+h7+hb4WqXBh3HpFwb7ltDj1Tps9
	qrg6gW+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ujQ-00000001112-47Po;
	Mon, 06 Oct 2025 23:35:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ujO-0000000110N-2Xhi
	for kexec@lists.infradead.org;
	Mon, 06 Oct 2025 23:35:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759793699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybILaILRCl7/UBex2ty3xf+O7+CzTBJ2uGf6Ymm2ESU=;
	b=EIcDAXh6TUy6m+hNwSMtJsYx0+qpU5LOfkz0TckRTNPXbqbfwVkcCNc3GAzMK29U+k4ZoV
	jTTDHvr8y3++wm92KGE9PkNV5dKrDyGRWPkyM44hT+a5kuY1XOgQPho1wZI5OqUexHZLHg
	vcK2mWN47P0+0ySZT8Eo6kcBPbmYTmw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-e1ECwn4LP428WicEdg85Qw-1; Mon, 06 Oct 2025 19:34:56 -0400
X-MC-Unique: e1ECwn4LP428WicEdg85Qw-1
X-Mimecast-MFC-AGG-ID: e1ECwn4LP428WicEdg85Qw_1759793696
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4de5fe839aeso131244631cf.3
        for <kexec@lists.infradead.org>; Mon, 06 Oct 2025 16:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759793696; x=1760398496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybILaILRCl7/UBex2ty3xf+O7+CzTBJ2uGf6Ymm2ESU=;
        b=sOkBf2/CsTPbc99/qTohjzJctXswPVyi5eKrdAtY6aIjaCpKHONOo0Pu1qrtT+qcrm
         oCZFhpwfD8XzkUd+Q1WzDgo4OXRl3FIrSHd5I3IL2oj6K8hxalfeBMnYpRnfv32FApLL
         eXsmiNk78DLP+hqWyeOKyqfS2psRcnnGSKnbyuqXwB72tuIg6nxpI57waNg0x7eRl7Dp
         aNr8BheMSqibPK7Ab+cFhY1auNklxBkK55NaJmFCXqfx7Qre0ExR3HmkbG/+UghcT3f+
         MJXoIBUb5VI6NMF7oBZtFvIafK7gMhdjrOFCdzXmvEXEKzlE7zRsInA4Kq6lCUpOFFTG
         Y1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVkyBUqH86zQhFY+aR1Sp76HZMvTPDxZMA2P1hJAL5CXnWa071AM4PsCFOTXov+mj5Z8ZwwXA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yww2zta/E8miGsEbh5ABkLY+NJObMa9mdEv/5Fi+7pP1NI7gOb4
	3pN0T1eUsJWl8tFLkVy4qk9RSHiy/Hyf5yvvxBC7qjNkwzt6s30o+3hvnHRsNICXbaeCjZ9loJH
	eayEbwIMC+tXX/QbZXPLeJQ80K+15DmsoH69R5cttrcWqSiczLYlpTqxNnID5fKef2UTad8gNPX
	W9psod2aT6kYSPab7KYziBl/cVV1R5QAvznL4t
X-Gm-Gg: ASbGncvtDLlPQ0vkv+EUpqg6lQh86LgSp21s7ARL/QB1BYYbU35nKgs3hQrvX1gX2tL
	Jmwng22HsGqgzkvJFwCalzbe8i74Pwa8yQMcQ/xzJ8xZA8LmtTYrw9qc6mYeeRckGmsYit0YEeB
	vB9XuOKGQcqXaaa6FwnJ4hi2XDUc4=
X-Received: by 2002:a05:622a:550d:b0:4b7:a3ac:701c with SMTP id d75a77b69052e-4e576a2b225mr222255161cf.13.1759793696051;
        Mon, 06 Oct 2025 16:34:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFA4nYNqarA2pFZ091eiqCpdMYvtmFpn4w2eYrABOe6c4Di935ydlDHXX3A55UKw8lm641HHW/4xWzWdWIfnU=
X-Received: by 2002:a05:622a:550d:b0:4b7:a3ac:701c with SMTP id
 d75a77b69052e-4e576a2b225mr222254891cf.13.1759793695714; Mon, 06 Oct 2025
 16:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz> <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com> <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
In-Reply-To: <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 7 Oct 2025 12:34:19 +1300
X-Gm-Features: AS18NWBxUcyeBHV1k29L8uNzXCcsOUwxNIfTLpM3voYn0O5GxYm8lT2LXMD4oz0
Message-ID: <CAO7dBbUdZg7Lp+7bHzpQSpP7PX4YO=isTEDeA3X8N+VihkCusw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: David Hildenbrand <dhildenb@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, kas@kernel.org, Jiri Bohac <jbohac@suse.cz>, riel@surriel.com, 
	vbabka@suse.cz, nphamcs@gmail.com, Baoquan He <bhe@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ySm6hAFSSfhs3RZW94w6WJ1kPMFV_fxxEz3TqmkbyM_1759793696
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_163502_723073_2C5D89D1 
X-CRM114-Status: GOOD (  37.90  )
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

Hi David,

On Tue, Oct 7, 2025 at 5:45=E2=80=AFAM David Hildenbrand <dhildenb@redhat.c=
om> wrote:
>
> On 06.10.25 18:25, Breno Leitao wrote:
> > On Mon, Oct 06, 2025 at 10:16:26AM +0200, David Hildenbrand wrote:
> >> On 03.10.25 17:51, Breno Leitao wrote:
> >>> Hello Jiri,
> >>>
> >>> On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
> >>>
> >>>> Currently this is only the case for memory ballooning and zswap. Suc=
h movable
> >>>> memory will be missing from the vmcore. User data is typically not d=
umped by
> >>>> makedumpfile.
> >>>
> >>> For zswap and zsmalloc pages, I'm wondering whether these pages will =
be missing
> >>> from the vmcore, or if there's a possibility they might be present bu=
t
> >>> corrupted=E2=80=94especially since they could reside in the CMA regio=
n, which may be
> >>> overwritten by the kdump environment.
> >>
> >> That's not different to ordinary user pages residing on these areas, r=
ight?
> >
> > Will zsmalloc on CMA pages be marked as "userpages"?
>
> No, but they should have the zsmalloc page type set.
>
> >
> > makedump file iterates over the pfns and check for a few flags before
> > "copying" them to disk.
> >
> > In makedumpfile, userpages are basically discarded if they are anonymou=
s
> > pages:
> >       #define isAnon(mapping, flags, _mapcount) \
> >               (((unsigned long)mapping & PAGE_MAPPING_ANON) !=3D 0 && !=
isSlab(flags,
> >               _mapcount))
> >
> >       https://github.com/makedumpfile/makedumpfile/blob/master/makedump=
file.h#L164
> >
> >       called from:
> >       https://github.com/makedumpfile/makedumpfile/blob/master/makedump=
file.c#L6671
> >
> > For zsmalloc pages in the CMA, The page struct (pfn)) is marked with ol=
d
> > page struct (from the first kernel), but, the content has changed
> > (replaced by kdump environment - 2nd kernel).
> >
> > So, whatever decision makedumpfile does based on the PFN, it will dump
> > incorrect data, given that the page content does not match the data
> > anymore.
>
> Right.
>
> >
> > If my understanding is valid, we don't want to dump any page that point=
s
> > to the PFN, because they will probably have garbage.
>
> My theory is that barely anybody will go ahead and check compressed page
> content, but I agree. We should filter them out.
>
> >
> > That said, I see two options:
> >
> >   1) Ignore the CMA area completely in makedump.
> >      - I don't think there is any way to find that area today. The kern=
el
> >        might need to print the CMA region somewhere (/proc/iomem?)
>
> /proc/iomem in the newkernel should indicate the memory region as System
> RAM (for the new kernel). That can just be filtered out in any case:
> dumping memory of the new kernel does not make sense in any case.
>
> >
> >   2) Given that most of the memory in CMA will be anonymous memory, and
> >      already discard by other rules, just add an additional entry for
> >      zsmalloc pages.
> >
> >      Talking to Kirill offline, it seems we can piggy back on MovableOp=
s
> >      page flag.
>
> We should likely check the page type instead if we go down that path.

If choosing a proper page type/flag is hard, maybe an ongoing new
feature for makedumpfile can help with that. In short, if we can get a
workable page flag for CMA to get filtered, then proceed as usual, If
cannot, then we can use eppic/btf/kallsyms[1] in makedumpfile to
programmably determine page type and filter it out. See the program
for determining amdgpu's mm pages[2].

[1]: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/T=
/#m901bf1413b844648c86e8a84d75b66d0531b9f92
[2]: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/T=
/#m38362d258e3b0bdc14a64e54a6acd5b85810ca26

Cheers,
Tao Liu

>
> --
> Cheers
>
> David / dhildenb
>


