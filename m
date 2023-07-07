Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94944EB64DA
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Voo9WedtssCvwW6KzFqzRYrlXT44107vE2gXPo59wQo=; b=hbtjOeMVFowbFf
	RzhpKEsBB8cd/RnKxOqTp637sIqSv/8zCfwX1Pa+PJ9SDzGSag0BJrsfC3H0S79J65Yj80QYiaAlR
	O+JQMcpsfKu5Mn86p7x6FuBPQVfQz37tj02E/MuHze9FqbfDHyCPVNehW++ZTOlTVhxZT2tqjVWiK
	wsJDHRoij4ikOmu0ZYbCc4CdR2T1Ietgo2jcfeTL9FhFwjEuJ1SuhcsK4ycOT8Gg341XisG27jNnX
	G5WHaR62Qu/eGiuIiqFrKmHvcclof6gqq4lUSYUHWKtrCZ6i5HLVXllktKlpCgB5NsbjLM5glSvLg
	JJ0zO1m2AHlEg8J6lNjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHgeR-003xa0-0q;
	Fri, 07 Jul 2023 08:17:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHgeO-003xYl-0c
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 08:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688717828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPaN5pqbomSOKx5xl3JROR9VsqVfGN0ANT/ZNiELBU8=;
	b=EgxBKNnyQfx6Lw8bnawKtB2iSqgq+xBoiydyXbfrhey3ItWOriUxBH/FmVtpoRtMEk6PjJ
	ZCykEsS5Z4SJ2351FolvgY670d8WV0nCDU4mP+3LZufQyCHQXwQpA2FDQrKIg/GIDcaorz
	TVS1Ru3+sZf73n/tLeYnqmo0J1S2n4o=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-adppQkOUMoSrzDvA-IrZzA-1; Fri, 07 Jul 2023 04:17:07 -0400
X-MC-Unique: adppQkOUMoSrzDvA-IrZzA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34616cffaabso1547985ab.1
        for <kexec@lists.infradead.org>; Fri, 07 Jul 2023 01:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688717826; x=1691309826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPaN5pqbomSOKx5xl3JROR9VsqVfGN0ANT/ZNiELBU8=;
        b=MRSUgsme8BsPxg+uBilnaQCiSQBMh4/g0auoSWecgqfzhtIJ2wjFWF9rSAzvmkQHNe
         YGIMqOClz3mFvx6qKAn6Z3xG7Yvife+xihytD9CH2cp0osyMsSvU2TREhbtUm00PHAtF
         oNG7K+R/60dklZPJFH7FOBR680rBozq2PovfT1sfwEkBpHk2N04Dm+YvIL9kRABgRgs6
         xNCmRN3IU0dgWmhB7puZeNi+QLH97IbR27Y6nb5YTao8gIBNI8d2gKSGfh1kEeBlBUUh
         WpMu1Unu0jUnKhnczJrKeAFlwwc5JoS9wL6p/+xHI8DBN/2p/mX1S8pcnRyghK2JC3oR
         SaIg==
X-Gm-Message-State: ABy/qLYr7qaWLhgAmICA9cy1XjUTMuGGNWne9jOu7yGCFIMKuLZ3kez1
	Ior36W4ipZZS0gTgIVPb8uI9Kb30556R1+SBys8iV9hgR9qmzm3MEkyWcX6jh3rUUxfgdkqPfb9
	wmyaNmb+hl1XtWlnLoBa25VtaSRmwzA9gzWXU
X-Received: by 2002:a05:6e02:1a62:b0:346:1919:7cb1 with SMTP id w2-20020a056e021a6200b0034619197cb1mr6742341ilv.2.1688717826685;
        Fri, 07 Jul 2023 01:17:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLdSmS3qJJRQ35msI1TYAi+yBPPV4fvNEEnqy2IXhTRvWYiVXIjdoR/KlooxuKrMIls/Q5ivEzfqkjGa2k8uU=
X-Received: by 2002:a05:6e02:1a62:b0:346:1919:7cb1 with SMTP id
 w2-20020a056e021a6200b0034619197cb1mr6742316ilv.2.1688717826255; Fri, 07 Jul
 2023 01:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 7 Jul 2023 16:18:31 +0800
Message-ID: <CALu+AoSyhnw0Cz06Mmqh+7FcLUF1q0txY1qbWLxkHO8OD5---Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] ima: measure events between kexec load and execute
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com, 
	kexec@lists.infradead.org, linux-integrity@vger.kernel.org, code@tyhicks.com, 
	nramas@linux.microsoft.com, paul@paul-moore.com, 
	Eric Biederman <ebiederm@xmission.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_011712_325038_A34E3F88 
X-CRM114-Status: GOOD (  30.58  )
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

[Add Eric in cc]

On Tue, 4 Jul 2023 at 05:58, Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
>
> The current Kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
> over to the new Kernel after kexec 'execute'.
>
> Some devices can be configured to call kexec 'load' first, and followed
> by kexec 'execute' after some time. (as opposed to calling 'load' and
> 'execute' in one single kexec command).  In such scenario, if new IMA
> measurements are added between kexec 'load' and kexec 'execute', the
> TPM PCRs are extended with the IMA events between 'load' and 'execute';
> but those IMA events are not carried over to the new kernel after kexec
> soft reboot.  This results in mismatch between TPM PCR quotes and the
> actual IMA measurements list after the device boots into the new kexec
> image.  This mismatch results in the remote attestation failing for that
> device.
>
> This patch series proposes a solution to solve this problem by allocating
> the necessary buffer at kexec 'load' time, and populating the buffer
> with the IMA measurements at kexec 'execute' time.
>
> The solution includes:
>  - addition of new functionality to allocate a buffer to hold IMA
>    measurements at kexec 'load',
>
>  - ima functionality to suspend and resume measurements as needed during
>    buffer copy at kexec 'execute',
>
>  - ima functionality for mapping the measurement list from the current
>    Kernel to the subsequent one,
>
>  - necessary changes to the kexec_file_load syscall, enabling it to call
>    the ima functions
>
>  - registering a reboot notifier which gets called during kexec 'execute',
>
>  - and removal of deprecated functions.
>
> The modifications proposed in this series ensure the integrity of the ima
> measurements is preserved across kexec soft reboots, thus significantly
> improving the security of the Kernel post kexec soft reboots.
>
> There were previous attempts to fix this issue [1], [2], [3].  But they
> were not merged into the mainline Kernel.
>
> We took inspiration from the past work [1] and [2] while working on this
> patch series.
>
> References:
> -----------
>
> [1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
> https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/
>
> [2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
> https://lkml.org/lkml/2016/8/16/577
>
> [3] [PATCH 1/6] kexec_file: Add buffer hand-over support
> https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/
>
> Tushar Sugandhi (10):
>   ima: implement function to allocate buffer at kexec load
>   ima: implement function to populate buffer at kexec execute
>   ima: allocate buffer at kexec load to hold ima measurements
>   ima: implement functions to suspend and resume measurements
>   kexec: implement functions to map and unmap segment to kimage
>   ima: update buffer at kexec execute with ima measurements
>   ima: remove function ima_dump_measurement_list
>   ima: implement and register a reboot notifier function to update kexec
>     buffer
>   ima: suspend measurements while the kexec buffer is being copied
>   kexec: update kexec_file_load syscall to call ima_kexec_post_load
>
>  include/linux/ima.h                |   3 +
>  include/linux/kexec.h              |  13 ++
>  kernel/kexec_core.c                |  72 +++++++++-
>  kernel/kexec_file.c                |   7 +
>  kernel/kexec_internal.h            |   1 +
>  security/integrity/ima/ima.h       |   4 +
>  security/integrity/ima/ima_kexec.c | 211 +++++++++++++++++++++++------
>  security/integrity/ima/ima_queue.c |  32 +++++
>  8 files changed, 295 insertions(+), 48 deletions(-)
>
> --
> 2.25.1
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
