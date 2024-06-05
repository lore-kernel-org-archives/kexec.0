Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7166C27C54
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 02:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cUXH5g/9jIpduUAv1o6A5BM56f4Q69v/lF86e9iyzlo=; b=FnRIf/JlSCas0/
	seBJuLOcwFQ/G7L46bEGyZTswlFWNQOV1qgt46XhThj+YxRpN2a3kb9wHoml6I9ZZI7bh0IhYf0zi
	A4r3xTfKBTA/ClVAV4bt/d0JvqW5iXJA0p5ulKA5ZLUMbnvJ16e68jUtyR1wVZb04rmSQ025sWc1m
	7zY01lbh6BCXsTrAkxgD+8HXYQAywEE03D59ugcG03D7ivC2UuE4Eku5qPaeP5K1xvdcUZw/8ybEk
	+iUTd2LTIuMz/zTVer5WEBWLacz7fJ3baDwjwJmWder/j5NkQtL4/H7FGoansPFE0jR5uZzbLC7G5
	nvLlLUHx93z4rlIMyagA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEgmR-00000004VE8-07Kf;
	Wed, 05 Jun 2024 02:53:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEgmM-00000004VDO-3htZ
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 02:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717556012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3FTX+9rZeC4z0llUfSKTY9Loz4suuB0WymmiOnqwlu0=;
	b=SSEJVtb4g4H3gpOYspQA/IIBOg/Ivlo3nIhHRTzNOWzxGk2ovKlhIk/7kSQGCVvhk0gf5S
	Wm+39Cwtm7vFlO1zCxNgldCN+AlCaakLoTnqnImki+5T2PqzRARj+7F7PaKkw4IA5ncovA
	WjtUozHawq6asJnQySfMA6FWwDZ4QQ0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-7A1v40QNOrq1O7fPoRLVXA-1; Tue, 04 Jun 2024 22:53:30 -0400
X-MC-Unique: 7A1v40QNOrq1O7fPoRLVXA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3745776e1ecso8957725ab.2
        for <kexec@lists.infradead.org>; Tue, 04 Jun 2024 19:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717556010; x=1718160810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FTX+9rZeC4z0llUfSKTY9Loz4suuB0WymmiOnqwlu0=;
        b=l/glv5EU/tHroGKkLGH6oiWf9Qs8VCjlvJK5IfYKC95/9Hx0FA/MrLsx/366G7vNz3
         8tmdcNV5DGxF3sZjQQ8thUjqNUNeemNv4dIhZ/9lZi4P/zTzQU59QTTlcvgpBPHwy01r
         4htgs55/2pfSqg2BMQ5iHI60h4qErraVDVodfP9+X10FUHfyk2IwJ9xPIV/so3bWHuXL
         AOq65ZOuhnOd2wBtZoOtUs1M6se26cSBwn1BsF+tsqzxt6SSdB5Yv0c/ECsBbrj8rJxC
         MCcJXZqJ/SdAOHXNHej0JJkY4X8rLgbCQYiH9q6ZC6thT+UfS787pndRSPAkZpbnabVf
         YK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwU9hmtqwLh6FNnOm+inPF+cHMUjTRGHm0p9gJ5xndvx1JwVo831cwHP50253ObF8aG9QutdYFGRH3SZ8NUZOfBPZpzRWdbDRB
X-Gm-Message-State: AOJu0YwT7tDX7mkiTiAGadW8eNnw2Ja21I4A684+msLITQL78Y/w+Xua
	0MsRmLgT4wZf7YfJfRESwXVF7ZMb5EPxj4eREVSJ1OBOBmxQuzBxP6vU7c2WiLOFbTYbJPemnz/
	GsRkeF/Hj4Wr0TAAcqdrJ1wwNBnzM8VHnmOW/pZUyF/rKC4ZqmDlWJiSd3OSv83A+Se+UTn7mxs
	eekZ8hb2kTd+84z/67vZnbaDIXD8tzalO5
X-Received: by 2002:a92:c262:0:b0:374:6545:5546 with SMTP id e9e14a558f8ab-374b1f3e5ddmr14071915ab.2.1717556009933;
        Tue, 04 Jun 2024 19:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBBqBjje1/Rae28nzKbAjV9C7xlZjBxKlW7978XbuE4RsH8R8NhNUkzBWIWBCLsBy3RsdRYMvU/X86zSTOyEs=
X-Received: by 2002:a92:c262:0:b0:374:6545:5546 with SMTP id
 e9e14a558f8ab-374b1f3e5ddmr14071685ab.2.1717556009574; Tue, 04 Jun 2024
 19:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local> <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
 <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
In-Reply-To: <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 10:53:44 +0800
Message-ID: <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Borislav Petkov <bp@alien8.de>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org, 
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_195335_023573_A0EE67A4 
X-CRM114-Status: GOOD (  19.27  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 5 Jun 2024 at 02:03, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jun 04, 2024 at 07:09:56PM +0800, Dave Young wrote:
> > Anyway there is not such a helper for all cases.
>
> But maybe there should be...
>
> This is not the first case where the need arises to be able to say:
>
>         if (am I a kexeced kernel)
>
> in code.
>
> Perhaps we should have a global var kexeced or so which gets incremented
> on each kexec-ed kernel, somewhere in very early boot of the kexec-ed
> kernel we do
>
>         kexeced++;
>
> and then other code can query it and know whether this is a kexec-ed
> kernel and how many times it got kexec-ed...

It's something good to have but not must for the time being,  also no
idea how to save the status across boot, for EFI boot case probably a
EFI var can be used, but how can it be cleared in case of physical
boot.    Otherwise probably injecting some kernel parameters, anyway
this needs more thinking.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
