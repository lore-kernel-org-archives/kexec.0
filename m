Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C261EC54E67
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 00:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7hawHTCYS+buGxSnhe904DGzleBRoCEslJsZfu48ncU=; b=hFPBGCYkiPsFo1
	1jEKC42c2So16FSdhN6Y5abWDQnMqNP5McYU0bqung0xMZ5FiMd8PUkDhXluwlxd1c8kTlf9agS/I
	hIIhMtRgjZvupYSVXj6jgdawgyue4C0f7h57h44WxDy8hlVl0VOrjVTUJmnGdyIAS2ZRlMHsqdmrL
	ig2FzPh96L2UBnXU3wRHi4hlhenvup67IussCZT1NA7R+52MlaG9PhyZbVsf8G9PwjQMxbAlGviUa
	NS7xezOTaTO/d7VHnExzx9bf3iouivvUIGBwFqLde/osHtZldrK6f50WN87bbNdw6WCX80OPQSA9B
	N79UVmZIkGfwGd2Gwxpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn6jr-00000001OQn-1QIh;
	Thu, 21 Mar 2024 00:56:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn6jn-00000001OPx-3lue
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 00:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710982612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7nyTfy4ZKS+0vxtvDTzpFx0ooSJsIqwsPGQDi44f8vU=;
	b=icAmJQ8W99bKx7eXMz4c3uzVdwP1BSwOgxlZzDCbH2Jf+clk3TpHIvyzpBiJH5qIYW3aDM
	7Uvqyl2gQDjbgoUWZBswphNszBQhcZkzf9MNJP3gAUnvi7+YHg4LZ0m8bpMX88pV1myOOY
	JjzAHDm63h26Cn9HnRGBA3BQxW4KSaw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-DYemm2pjM-WK6zk4yCdi6w-1; Wed, 20 Mar 2024 20:56:50 -0400
X-MC-Unique: DYemm2pjM-WK6zk4yCdi6w-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366b2ee3b5bso1529565ab.1
        for <kexec@lists.infradead.org>; Wed, 20 Mar 2024 17:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710982610; x=1711587410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nyTfy4ZKS+0vxtvDTzpFx0ooSJsIqwsPGQDi44f8vU=;
        b=SdISpf7JkGkTybkPi/KgDQZbglrwPVc3pa6+U6rPHd3tEe3FhuT07s95yH7quMRu1S
         +iG6DWAx7nkk1LWZatYbRYueFNQURvg3WdK9R96pM0Uve5xHqfPehBKmGChGAbErOgAH
         fhPoQIsKh5uoRUCcNqSfTkbHq06VUOR1rKorkwPZKDroza+Bm3uRIPjKkRt75e8dXrF0
         W99f5BS31Qs5qEzhwSKq5ROz4ABoETjRCV05LY8cYi3rWTE9E3MpWbkqC5iqTXc+Xjdz
         v7WJvTzFCUbetaSBeCaMJIqM+j98PA9SSAJ9ZxNo+yzlRIqLAzhIxEXkNuR8/oGeOFgs
         k9gg==
X-Forwarded-Encrypted: i=1; AJvYcCWTb3RoHF4o2JVX0qP/68ORTGIYBkNREQfy9ZvPq4Aal6zlSqJwK7RsvF7hmYJX2VLRQ+48ei3PifzYBEIFKxoS5z13bAQmpnOj
X-Gm-Message-State: AOJu0YwXAa5So5+7myA7DI9J20C0ANuWACjqgG4hUHgqqsXUg6Vn/6Yb
	fX2rUun+FVEXuSlr/uwf3I+7MI1zaNvNWwqRlRCXl2Fx5s2b2VbtlhBXZ5c5vHKLi9NEaZenApD
	ytIOBvmCvIknReqM7hlJBX8xIw8xnDhUoaSdq00qOESs2Cu4JGugo2J3om3bGQeZt6Dxvxhj7dA
	/9aaxeDSNDSzlb5FHEhNAZIzzeMrXz0aB7
X-Received: by 2002:a92:dcc2:0:b0:366:7922:9509 with SMTP id b2-20020a92dcc2000000b0036679229509mr15726560ilr.2.1710982610126;
        Wed, 20 Mar 2024 17:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8Cyz7FUh75+9TP6TV4dnUMPt/EleDATTJuOKf6cagiCNR9N9d9vuTcHdlDAPkWI1xkb8qk+TQeLIJNaZdTSw=
X-Received: by 2002:a92:dcc2:0:b0:366:7922:9509 with SMTP id
 b2-20020a92dcc2000000b0036679229509mr15726542ilr.2.1710982609844; Wed, 20 Mar
 2024 17:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com> <4d9fe26b-cf0e-4381-9dee-20f43f371710@intel.com>
In-Reply-To: <4d9fe26b-cf0e-4381-9dee-20f43f371710@intel.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 21 Mar 2024 08:57:01 +0800
Message-ID: <CALu+AoR3QA58_WJVLc06ma5RC69jYLi2BHBsq1fvxK07amNSaw@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: do not update E820 kexec table for setup_data
To: "Huang, Kai" <kai.huang@intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_175656_155523_3BE26252 
X-CRM114-Status: GOOD (  36.70  )
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

Hi,

On Thu, 21 Mar 2024 at 05:56, Huang, Kai <kai.huang@intel.com> wrote:
>
> Hi Dave,
>
> Some nitpicking in changelog:

Will fix the grammar issues.  Thanks for your review!

>
> On 5/03/2024 2:32 pm, Dave Young wrote:
> > crashkernel reservation failed on a Thinkpad t440s laptop recently,
>
> ',' -> '.' to make it as a standalone sentence.
>
> > Actually the memblock reservation succeeded, but later insert_resource()
> > failed.
> >
> > Test step:
> > kexec load ->
> >       kexec reboot ->
> >               check the crashkernel memory
> >               dmesg|grep "crashkernel reserved"; saw reserved suceeeded:
>
> "suceeeded" -> "succeeded".
>
> >               0x00000000d0000000 - 0x00000000da000000
> >               grep Crash /proc/iomem: got nothing
>
> And somehow I found it's not easy to read.  :-)
>
> >
> > The background story is like below:
>
> Better to have an blank line to make text more breathable.
>
> > Currently E820 code reserves setup_data regions for both the current kernel
> > and the kexec kernel, and it will also insert them into resources list.
>
> "will insert" -> "inserts".
>
> > Before the kexec kernel reboot nobody passes the old setup_data, kexec only
>
>                           ^ "reboots"                             ^ and
>
> > passes SETUP_EFI and SETUP_IMA if needed.  Thus the old setup data memory
> > are not used at all. But due to old kernel updated the kexec e820 table
>
>    ^ is                                      ^ updates
>
> > as well so kexec kernel see them as E820_TYPE_RESERVED_KERN regions, later
>
> "so kexec kernel" -> ", the kexec kernel"
>
> "see" -> "sees"
>
> ", later" -> ", and later"
>
> > the old setup_data regions will be inserted into resources list in kexec
>
> "will be" -> "are"
>
> > kernel by e820__reserve_resources().
> >
> > Note, due to no setup_data passed in for those old regions they are not
>
>                             ^ is
>
> > early reserved (by function early_reserve_memory), crashkernel memblock
>
>                                                    ^ and the
>
> > reservation will just regard them as usable memory and it could reserve
>
> "regard" -> "treat"
>
> > reserve crashkernel region overlaps with the old setup_data regions.
>
> double "reserve".
>
> "crashkernel region" -> "the crashkernel region"
>
> "overlaps" -> "which overlaps"
>
> >
> > Just like the bug I noticed here, kdump insert_resource failed because
> > e820__reserve_resources added the overlapped chunks in /proc/iomem already.
>
>                           ^ has added
> >
> > Finally, looking at the code, the old setup_data regions are not used
> > at all as no setup_data passed in by the kexec boot loader. Although
>
>                           ^ is passed
>
> > something like SETUP_PCI etc could be needed, kexec should pass
> > the info as setup_data so that kexec kernel can take care of them.
> > This should be taken care of in other separate patches if needed.
> >
> > Thus drop the useless buggy code here.
> >
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >   arch/x86/kernel/e820.c |   16 +---------------
> >   1 file changed, 1 insertion(+), 15 deletions(-)
> >
> > Index: linux/arch/x86/kernel/e820.c
> > ===================================================================
> > --- linux.orig/arch/x86/kernel/e820.c
> > +++ linux/arch/x86/kernel/e820.c
> > @@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
> >               pa_next = data->next;
> >
> >               e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -
> > -             /*
> > -              * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> > -              * to be reserved.
> > -              */
> > -             if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> > -                     e820__range_update_kexec(pa_data,
> > -                                              sizeof(*data) + data->len,
> > -                                              E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -
> >               if (data->type == SETUP_INDIRECT) {
> >                       len += data->len;
> >                       early_memunmap(data, sizeof(*data));
> > @@ -1036,12 +1026,9 @@ void __init e820__reserve_setup_data(voi
> >
> >                       indirect = (struct setup_indirect *)data->data;
> >
> > -                     if (indirect->type != SETUP_INDIRECT) {
> > +                     if (indirect->type != SETUP_INDIRECT)
> >                               e820__range_update(indirect->addr, indirect->len,
> >                                                  E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -                             e820__range_update_kexec(indirect->addr, indirect->len,
> > -                                                      E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -                     }
> >               }
> >
> >               pa_data = pa_next;
> > @@ -1049,7 +1036,6 @@ void __init e820__reserve_setup_data(voi
> >       }
> >
> >       e820__update_table(e820_table);
> > -     e820__update_table(e820_table_kexec);
> >
> >       pr_info("extended physical RAM map:\n");
> >       e820__print_table("reserve setup_data");
> >
> >
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
