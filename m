Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DCBC54E5D
	for <kexec@archiver.kernel.org>; Tue, 19 Mar 2024 04:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BmNNEOFLqQ7jNd/rQc+jKVVNZJ72yUrQvUYN0X18pM0=; b=0GRYEiTnwz60fl
	zTtZSxvWqbd8nezoKoHSqdGfjF4rMr17Eq4Lm3ZSMtpKQMoWhmc2YjyEd0LDi7jddXxfjby6ip5xl
	0GmVK30P//kHvwHnvWtS+zHy6qR8/eocCAQPManJKq5Bvx22/uufNkyZrt6yvhIoXDsB+0QoTV9GB
	Nm//RDs2frzEpJCRqSLs6kA5Cti4KRaclWrWcBuZx4OsqAsApG+lOt/xFjkoPmuZj/peN3ckGzbRG
	vfEKCAul2f4WyAr/Ewm5lIOa1xLqPbaX4LAj00SzZbYwPe86+nzzfzKCA4+GgTLj1Cozi/tp6kNQ9
	rlhaJSvejUkP1Sb/eVDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmQr0-0000000BB9X-1AHO;
	Tue, 19 Mar 2024 04:13:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmQqw-0000000BB8I-2e62
	for kexec@lists.infradead.org;
	Tue, 19 Mar 2024 04:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710821606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWG74Dl5bTbuxCti86zPWOGnY2g2FNK26/oHUY3dQ8I=;
	b=IcjrwVnvr7QPBqohWq1yMKF48oPMmPJecR50VrHIYWb0jIjfRcQvrkrtjYxYlsE5SRgGDj
	YDj7P8CnY9d4TSSURPgXT3DJ/B8ilbHeeYsPoA9eJjLI8vaLngHWC+yFvj07NmWCe6Svru
	fOQXJLSgH2/fDipyQG6H1Mm2uxm+EYM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-KIiZSSjFNSOwrxDvd9qT-Q-1; Tue, 19 Mar 2024 00:13:25 -0400
X-MC-Unique: KIiZSSjFNSOwrxDvd9qT-Q-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-366929c9109so7225425ab.1
        for <kexec@lists.infradead.org>; Mon, 18 Mar 2024 21:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710821604; x=1711426404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWG74Dl5bTbuxCti86zPWOGnY2g2FNK26/oHUY3dQ8I=;
        b=GiVtFlAjE6R30gx3EdqIS6sFEcHsATFkW0dfyf31nERo3oAX0JaklZdly6NGaesdA5
         epO/8ctbZpF2QGJF6utIwHI2fiNDBASh9UFlQwyTvtsgwk3CIAX0CHds6mCwDWuwBVkZ
         wBXNq/1qGV82s69ixcnrgoRdCiezlClU2oUi/o0c4hl5LmDkGiBF1mrlJYbtD1MWsGy9
         CmSbuYERUe/bMW6uVGZesAKdAdcxwxFzVbHQLW3CmtH9JEp/9WfO4ZyNgtr/f22rODzt
         mIfqkZNJNxApxNqKufzQ7M4k2EFMBENKGe18G1FazERmAfdmhegbdlW/fph1JW94FCUY
         z+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrljiTZvUDpVTEzkvx+yB5+y+kMCWAA8u3rOBLeUPQscGkQ3wkXdoRBQ/SLJFa4oSrNWvI/vYZ4Z3XgJ8vIqY5TYhTYksxuGj8
X-Gm-Message-State: AOJu0Yzjm5XrNKbAHDBT+GskZrfq6ENGiTncOQHEHmVfUxOhhh5FBU3J
	6r1l5H181/QYiUMzkPOLyCI2UW6ls/qfnqPnpVBuJBQv8HcZ11u7Ps84KJI+xP3j4EzbmB5sCfd
	CSGuPv/na6tv5uxAJMRsKAZfb0vwjX3VucV7gMuRg8PLeBjmGmg4FovbIyDUrXSbDvcDNPykims
	Espdf6CenA8AaGj7szFulJFYmXPfhLlt4ZlNdW6Z5a
X-Received: by 2002:a05:6e02:2197:b0:367:841f:4ea with SMTP id j23-20020a056e02219700b00367841f04eamr1703768ila.3.1710821604468;
        Mon, 18 Mar 2024 21:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw2yGPDwNdTHpgshZtX42+6Fr/AzzNGxTbh290UoUCFi635TZEchb+9DVQ5qVrlww2086xuAqQekPrqvHq3lE=
X-Received: by 2002:a05:6e02:2197:b0:367:841f:4ea with SMTP id
 j23-20020a056e02219700b00367841f04eamr1703755ila.3.1710821604229; Mon, 18 Mar
 2024 21:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com>
In-Reply-To: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 19 Mar 2024 12:13:36 +0800
Message-ID: <CALu+AoQzrVBjkBjurv_3p9kCe9EfPszcf1Lzo1G5_QQGbv8B+Q@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: do not update E820 kexec table for setup_data
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_211330_873813_AA6DA1DD 
X-CRM114-Status: GOOD (  27.90  )
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

On Tue, 5 Mar 2024 at 09:32, Dave Young <dyoung@redhat.com> wrote:
>
> crashkernel reservation failed on a Thinkpad t440s laptop recently,
> Actually the memblock reservation succeeded, but later insert_resource()
> failed.
>
> Test step:
> kexec load ->
>         kexec reboot ->
>                 check the crashkernel memory
>                 dmesg|grep "crashkernel reserved"; saw reserved suceeeded:
>                 0x00000000d0000000 - 0x00000000da000000
>                 grep Crash /proc/iomem: got nothing
>
> The background story is like below:
> Currently E820 code reserves setup_data regions for both the current kernel
> and the kexec kernel, and it will also insert them into resources list.
> Before the kexec kernel reboot nobody passes the old setup_data, kexec only
> passes SETUP_EFI and SETUP_IMA if needed.  Thus the old setup data memory
> are not used at all. But due to old kernel updated the kexec e820 table
> as well so kexec kernel see them as E820_TYPE_RESERVED_KERN regions, later
> the old setup_data regions will be inserted into resources list in kexec
> kernel by e820__reserve_resources().
>
> Note, due to no setup_data passed in for those old regions they are not
> early reserved (by function early_reserve_memory), crashkernel memblock
> reservation will just regard them as usable memory and it could reserve
> reserve crashkernel region overlaps with the old setup_data regions.
>
> Just like the bug I noticed here, kdump insert_resource failed because
> e820__reserve_resources added the overlapped chunks in /proc/iomem already.
>
> Finally, looking at the code, the old setup_data regions are not used
> at all as no setup_data passed in by the kexec boot loader. Although
> something like SETUP_PCI etc could be needed, kexec should pass
> the info as setup_data so that kexec kernel can take care of them.
> This should be taken care of in other separate patches if needed.
>
> Thus drop the useless buggy code here.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/kernel/e820.c |   16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> Index: linux/arch/x86/kernel/e820.c
> ===================================================================
> --- linux.orig/arch/x86/kernel/e820.c
> +++ linux/arch/x86/kernel/e820.c
> @@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
>                 pa_next = data->next;
>
>                 e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -
> -               /*
> -                * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> -                * to be reserved.
> -                */
> -               if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> -                       e820__range_update_kexec(pa_data,
> -                                                sizeof(*data) + data->len,
> -                                                E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -
>                 if (data->type == SETUP_INDIRECT) {
>                         len += data->len;
>                         early_memunmap(data, sizeof(*data));
> @@ -1036,12 +1026,9 @@ void __init e820__reserve_setup_data(voi
>
>                         indirect = (struct setup_indirect *)data->data;
>
> -                       if (indirect->type != SETUP_INDIRECT) {
> +                       if (indirect->type != SETUP_INDIRECT)
>                                 e820__range_update(indirect->addr, indirect->len,
>                                                    E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -                               e820__range_update_kexec(indirect->addr, indirect->len,
> -                                                        E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -                       }
>                 }
>
>                 pa_data = pa_next;
> @@ -1049,7 +1036,6 @@ void __init e820__reserve_setup_data(voi
>         }
>
>         e820__update_table(e820_table);
> -       e820__update_table(e820_table_kexec);
>
>         pr_info("extended physical RAM map:\n");
>         e820__print_table("reserve setup_data");
>

Kindly ping for review.

Thanks!
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
