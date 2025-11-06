Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0936BCCF9F8
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 01:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FpU+/xQHHJRFTQ3d6N+Gk66txNoxwS8muPGcXzThu4Y=; b=iN95CDdKPm+4HbM5QqBQL+VAfC
	FUO591tF8z4SZpQc9o2k6bupLgndXESpnOMbqz24JM/tLQDUpFwzMZ2YBrpYMGfTM8TeWzVxzTaBR
	cQOAkZElCvyqFcIP1/xieZAaK9sYyww3O9TSwkuLzNL7ltMMs14857LwRUV6QpZ3qeMb+tHsnTPib
	n3BKt1ep5lz4qVeNfaZiiUk5iOJN8+RkCRR/i/Av/onA7Dh7sa1rP3yBTjJclwdg5F1U5VXpSsNdU
	FitJfceXOhabr3hlFMdcxbdAUDzbaoSdyR0aTgob4pOWhUo5tjZ7qDz4LTWwhZj20tcmztevdwj/v
	P/7Zp++A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGobM-0000000Egu2-32r1;
	Thu, 06 Nov 2025 01:15:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGobH-0000000Egt1-3pJX
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 01:15:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762391742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpU+/xQHHJRFTQ3d6N+Gk66txNoxwS8muPGcXzThu4Y=;
	b=JFlG5bSa3l5/kao/45FaxtWQ2u/nRaIo0P8P2Ckj867UPvsdaPu/q3O1F8ghF2TdgIwlQj
	Dsx0LXXSy4cH/TQcmU/WuiYGBDol4LM/yUS9pV45TJM5fqxgBCDrGZAkeBnjNFyltHzKru
	xiurI3FWCjQOLDkRDRsfa93LWllvTh4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-5dyLDLzqOI67uoWpVzfC4w-1; Wed, 05 Nov 2025 20:15:40 -0500
X-MC-Unique: 5dyLDLzqOI67uoWpVzfC4w-1
X-Mimecast-MFC-AGG-ID: 5dyLDLzqOI67uoWpVzfC4w_1762391740
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7af85c822c7so401944b3a.2
        for <kexec@lists.infradead.org>; Wed, 05 Nov 2025 17:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391740; x=1762996540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpU+/xQHHJRFTQ3d6N+Gk66txNoxwS8muPGcXzThu4Y=;
        b=ICVfFpRTUOx8k4+/WhKo2mcF9NR+TH21bk8W3nBIsanTJ1jSxSo3Duq3kck1bQHlJx
         b51fca3CiZQeoDnHSx5xEtK6/ZcPQDftfD+BBRwL3lNmonANQXAeI8dZpEYRBSZR6e6X
         LeCTVjpt7d/yVMWSfXkk1dQC2bJmYYqLic4ftpHPvMqcC5RUA8lPY4TKhnxELYFIbN9t
         JIKIslcIwStswdOa9X9iRd++B978PyHEw40eayvGL5Z457bPeEInPdRpP8aEykRmphbf
         mEPQLecJQlINjEduGtAxHpqPNh6uWXAYwVI7ClSXmNP0maQKl+mrevzSRQzaYGZi0B4a
         EnLg==
X-Gm-Message-State: AOJu0YyOwZlkCaSIGLYOJMWFCi/9EMyi0EtSUOT1yFxyqpT+IRJon/4/
	Ig9qcQx04JErqlXxvfNCbkS8zdQQQK9mNjxMlQBfet7bKSO4ebWKjx7DN20BA7HnDtA1bqdh11B
	w6Y+oG5zBkUZ0HG/gtqsUME2rH+g9tJXHkvHxXxQfjuAhZeV+SprtNcvPceWP/XRwNfGi9OMVyG
	XnbT2M9O86F+X07Izc/QuUYsZ4kRNObPYIShbk
X-Gm-Gg: ASbGncs+Xrb2Lf0808OtFyEuUji3k8zG67FioEmRs+TmsrTPSk+24NItvmc+A5guN0Y
	1gnsWsldHrf25DP4sg1aaB2goty+PBw3lHHf0auB4CHI5c2g84n5zXcnteKzVQ7H63/Cu9eb6Wb
	STX/eQocyG+j1oc3XeeboDqseaugo88yB9LYSGiCTyqEvp11zA9NfOFTEC
X-Received: by 2002:a05:6a20:7f83:b0:347:6c59:c728 with SMTP id adf61e73a8af0-34f84013e8cmr6524217637.8.1762391739746;
        Wed, 05 Nov 2025 17:15:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWmP8T75BYVAEODQyprbrgb0t85KfaaPTk9oa4Un/hkZU21VI14iTVWUltKXfQZOucBtAha8hOeAxTIy67Mf8=
X-Received: by 2002:a05:6a20:7f83:b0:347:6c59:c728 with SMTP id
 adf61e73a8af0-34f84013e8cmr6524184637.8.1762391739354; Wed, 05 Nov 2025
 17:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20251105130922.13321-1-piliu@redhat.com> <20251105130922.13321-2-piliu@redhat.com>
 <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
In-Reply-To: <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 09:15:28 +0800
X-Gm-Features: AWmQ_bkaZeeTVPgQitrAcHy5UsjO--zmL_VCoy8Ahhy155j47bWBbZj8mwo9iD8
Message-ID: <CAF+s44Rj8Jszzk0JeaTOWL5eErHt6jugtXoyuitSPjsQkU8VpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aL2o2IY-aFyGnzFetTlek44st1JFKOOsrYuJAKfP4Dc_1762391740
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_171544_371645_52DBDA39 
X-CRM114-Status: GOOD (  16.15  )
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

On Thu, Nov 6, 2025 at 8:14=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed,  5 Nov 2025 21:09:22 +0800 Pingfan Liu <piliu@redhat.com> wrote:
>
> > When I tested kexec with the latest kernel, I ran into the following wa=
rning:
> >
> > [   40.712410] ------------[ cut here ]------------
> > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 ki=
mage_map_segment+0x144/0x198
> > [...]
> > [   40.816047] Call trace:
> > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > [...]
> > [   40.855423] ---[ end trace 0000000000000000 ]---
> >
> > This is caused by the fact that kexec allocates the destination directl=
y
> > in the CMA area. In that case, the CMA kernel address should be exporte=
d
> > directly to the IMA component, instead of using the vmalloc'd address.
>
> This is something we should backport into tearlier kernels.
>
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: linux-integrity@vger.kernel.org
> > To: kexec@lists.infradead.org
>
> So I'm thinking we should add
>
> Fixes: 0091d9241ea2 ("kexec: define functions to map and unmap segments")
> Cc: <stable@vger.kernel.org>
>
> yes?
>

Yes, it should be. Thanks for your help!


Best Regards,

Pingfan


