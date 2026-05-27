Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12924CD4F54
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 07:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZb+3VL3Tdj6KXmr/Gl2VfCXYL/H+zHDAxXTGV9/oRQ=; b=GIJWgt7c8qNVUmKTnSjUhVzCCS
	p4ysohQWJwr2LqlWwjmhFUWlCACp56YWqZ6+lMRjlX+ASL6xC0EgTcec0+zjgToBbpwXwdIEnMS7o
	ceyr/cVQiCTVBlvR/0Q5M3fv2TnApzXHwOAV+fdx7YDbkNxxupIUBr5OESi7NvMQuMA8fKSW/NmJD
	asxUPZnjC3e3Q940OX6hHDxMj1JmBoQusVgM8dK5hFOWI9GGUqTrbdirXYRea9rFHSSqO/7AfzAQs
	YEfLbvpsudiJRDfhV7Ty9C6VafCrQw068zPKkHVa8pDnuudEDUCMrSapuuG6MgFCSpPBnUgmyXui2
	VSoYzkMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS94P-00000003Uch-3neC;
	Wed, 27 May 2026 07:52:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS94N-00000003UcI-0CzN
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 07:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779868368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZb+3VL3Tdj6KXmr/Gl2VfCXYL/H+zHDAxXTGV9/oRQ=;
	b=UDCU/GicPVEhHqFaqGjRCbEdQA/YE70GG5N4XnfDGeO5sdK4Ja86lx8n/5NDn1sVeLrqEC
	Lhgl8KZltbaAGToflPkRAyh0s3Tm7AnTa4UyZQhYtEbijfpgsF5DNHqzPxBA35MinvJi51
	PzjhTRCE+MwV3VCsI0l7Oqv49hc0qLo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-ovsKi2ZRNk-ynjfTkZdIvA-1; Wed, 27 May 2026 03:52:46 -0400
X-MC-Unique: ovsKi2ZRNk-ynjfTkZdIvA-1
X-Mimecast-MFC-AGG-ID: ovsKi2ZRNk-ynjfTkZdIvA_1779868366
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5165d10e036so199652051cf.3
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 00:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779868366; x=1780473166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZb+3VL3Tdj6KXmr/Gl2VfCXYL/H+zHDAxXTGV9/oRQ=;
        b=ixJDGY4zpK42X9zCf7wqYrg47O+PGGc+Er2c1H6Qc8icn/8nkmjW7Ns1pbX04H5mcR
         6fzAVOY8IHptfVmoY/bg+WpUb6VN5YGtGJ9kkiYAsgWZl+TwMp36Ggm6k0w3yoNAq0S2
         C9vVhlzQ4OkU32eHE9JNHl7jayrxaAoYONJdNIy6pZc/DrEIj+AK+Mrs8Sh3APED5j/3
         RlfuYdsqOP7cRcOi42imKZf2+tjVU4GC5kWkC5ZXwfzAa1ySm/iFDgfmn8swM2a0RZY9
         iizoOH9q3cKcbO5DavNsGfVDa4upfm+pgYVU/W+SCBjTKQXrKE6JKWyTMnEO5OQvqUVZ
         Ph9Q==
X-Gm-Message-State: AOJu0Yw1NEmaRkI9dgNto/vyC4ayNDY4L+A5wJaAqcfTTgCQgdW2qFNb
	m/NEsVjpuomWdUQHcqXBlL8bOwIroiNpZdlYnem2oy1fq8cdWZM46xR3Jf5d2vK9wWkVNKOWNOd
	qyxKwhndDDPhZwOFUOWaX9WzgPwiOVLdwN0tUfLvBG+/KGBheIGkdJBmgacZPSYRuY57adgs6dI
	hKAWdQVjoRCMRSwqUG8D3whXhwK1nNSx2vVlM6YscFQyabOEs=
X-Gm-Gg: Acq92OEPhz2FgaYmDPiduybysiRuw39OmdRbVfFyLwhv2exwwLyh/XhAMsbAMdeTme5
	abzgcfMYaHsNtdtSF4Fwl2GxcSHqR6vwhRh1zvjfHhj412WarTJMVwbeN6W1yO72SSVgzQtCvOv
	+A8jlN0vJUI2I6vTUQAEwjK8LXxYIyUKhRvK3FlkJe8DbDnCCQdVt0vGGiXLUysoOoyKW6tm85+
	s7uSqUGuGDa7kg=
X-Received: by 2002:a05:622a:1a8c:b0:516:dc6d:acd0 with SMTP id d75a77b69052e-516dc6db837mr262107111cf.29.1779868365619;
        Wed, 27 May 2026 00:52:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8c:b0:516:dc6d:acd0 with SMTP id
 d75a77b69052e-516dc6db837mr262106931cf.29.1779868364965; Wed, 27 May 2026
 00:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260526045806.23933-2-ltao@redhat.com> <20260527074112.GB51310@horms.kernel.org>
 <20260527074239.GD51310@horms.kernel.org>
In-Reply-To: <20260527074239.GD51310@horms.kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 27 May 2026 19:52:08 +1200
X-Gm-Features: AVHnY4IDoMC_L4AdOLQQ5xTH8aFSEHcbjeDUhTLfBlGU32ki5ZfY7g5lvi0leAI
Message-ID: <CAO7dBbW2ECfKHt18-B7LUYaJgTe8wvun3ccoSSbMkG8LynZ4bw@mail.gmail.com>
Subject: Re: [kexec-tools][PATCH] RISC-V: add kexec_load support for vmlinuz
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eKXly07A86QQesDoQ3jLniuM1uzoAkqsVQVzZnJ3oCY_1779868366
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_005251_153847_0CF908B4 
X-CRM114-Status: GOOD (  11.40  )
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

Hi Simon,

On Wed, May 27, 2026 at 7:42=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, May 27, 2026 at 08:41:12AM +0100, Simon Horman wrote:
> > On Tue, May 26, 2026 at 04:58:07PM +1200, Tao Liu wrote:
> > > Copy arm64 code and change for riscv so that the kexec -c can load
> > > a vmlinuz image.
> > >
> > > Signed-off-by: Tao Liu <ltao@redhat.com>
> >
> > Thanks, applied.
>
> ... here:
>
> - RISC-V: add kexec_load support for vmlinuz
>   https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commi=
t/?id=3D771e89dc104e

Thanks a lot for that! :)

Thanks,
Tao Liu

>


