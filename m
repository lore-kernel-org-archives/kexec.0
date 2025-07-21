Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF534C83F26
	for <kexec@archiver.kernel.org>; Mon, 21 Jul 2025 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I2e2g+RSdLVrXvuMyT6qHHm4bEHxvzYzZzIUO+TrG+M=; b=SM1BNeqA7sYO4+ixXTyRf+Hx4Z
	6xIZqrIkEufbaOC3+wARINK9E+msPl27LaNC/0N70cxhtAyUXSrGnxBdvZrhqU0TCg27QF1WeHCql
	E4bLDgMHPUDElwsaaIaZomRWsvtOzIbnQfT93GHN3ECgCGJNhQETwvjOMqVN06DNzd7mzIQs5XNof
	NVDcf5wwWqY3p9durAbFSs2AHQBlzXdCz3wrD7PQOg9VDdKWvveM9Tva7hCVvT7eV5Iga/8gbJpSj
	AVVLc8/LOKKExVBtM4FS070pBkqDQJ4B3bjYYc6s4QOFGGqXtOH+1D0KWxHJpOj9ck6xKgm/+Xfsk
	Bvr/Erwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udtbA-00000000Bui-0ZG1;
	Mon, 21 Jul 2025 16:42:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udrMB-0000000HUms-16g3
	for kexec@lists.infradead.org;
	Mon, 21 Jul 2025 14:19:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753107545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2e2g+RSdLVrXvuMyT6qHHm4bEHxvzYzZzIUO+TrG+M=;
	b=KaR+HD4FD6pHoUmP//6Mmxa7bisdzPMl03x54Ii3n0Uwj0umlLEmWwsCF/8hi3Icu5ZlhQ
	cGDJjKJcV1hAeBSWfO+d6BZvUQKrGeMrQqqoTUdEU/r5L/k5qEr+QM3t+NtDO5AznMnhXx
	GavArUfSNH/IzWJDzDppr8bcP5qADL8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-3r4ZZuQ4N_-9aAhfZ7v34g-1; Mon, 21 Jul 2025 10:19:02 -0400
X-MC-Unique: 3r4ZZuQ4N_-9aAhfZ7v34g-1
X-Mimecast-MFC-AGG-ID: 3r4ZZuQ4N_-9aAhfZ7v34g_1753107541
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so6538084a91.2
        for <kexec@lists.infradead.org>; Mon, 21 Jul 2025 07:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107541; x=1753712341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2e2g+RSdLVrXvuMyT6qHHm4bEHxvzYzZzIUO+TrG+M=;
        b=L+rSV+yD2YEvjAmOcrZKRwVxDSGst1Po1vLOW79XhVePGK3LU1s1p1Bkq/UuYWcvqq
         OGCjuPG4MposHya6qVlzth3pkB0grSeuYz9vI/FOnf4YFLmbZLG9ZIgRnXWiqSRzyGe6
         1P6AP3JTR+efdmZOBeRYsgLYo0fBoWi8rwIBvGZm8mv9cIdknibqNQbztwmVIQq0Lvca
         zKh5xspTJ75IMMyr7QTgqViPDgwVv9AmuRfIgOU1kPhG3Ywa88EGV9wGyHRHYTK8/SyC
         nY/wmALEZqNHGUiq8hnkO0bbekQrxb4+GNP0a+ia/AU+V1oIPkkGYAkHZyYHDdKmmhjL
         krhg==
X-Forwarded-Encrypted: i=1; AJvYcCVNwHTUGZn4cfjibfpEttvTz4hiaHhYGu43DTq+qKXA6Xiv3OKCg3kLW7AfWHnWQD7SzNiHeg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz64NPq5omwwqGggitkBocE96rF3hhZC2KhMlPLxTTD0Iaz6bLo
	ORxfhRJc1E0jM6ktR4v5bIpkILHczIg2kWeRIIBOPDqmM+T1GV/CxT6LdZszSDhFcJgXZg4tBKh
	SUqVdDQmoAmk4Lc/DRs9uRd1GwDfoP+2W1HPUiI3nCnsnMu8eSZsyYTJRoCOIVas34EQqLr33oj
	FpcdkDSnUZDpOtfcc1FIlW/UfA7B+s/0BzvUN9
X-Gm-Gg: ASbGncuuF//58n5unhRSGLTyngU0q6IrqAlgj1T69SidPJPWceypPIg2J9kaskxe5+6
	XS4FD0ygLVzLjjU9HLL/MH5jlRbmpMlOCgUNkj81ViloPZIiXEMpAMvPrCGEKC1//gEE3TTu3lo
	Pr8NxU0sf3HkMTTQ9GwOSfDA==
X-Received: by 2002:a17:90b:2252:b0:312:1508:fb4e with SMTP id 98e67ed59e1d1-31c9f45e1bamr34067979a91.17.1753107541239;
        Mon, 21 Jul 2025 07:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJIdqihCeYBVzkOqoaHkVeRUSem0hiE8oGsu0T7UvW6Id9zyyr788yaoKXL+Z4xHCOtXdyTT7abtsFJKNwYFA=
X-Received: by 2002:a17:90b:2252:b0:312:1508:fb4e with SMTP id
 98e67ed59e1d1-31c9f45e1bamr34067933a91.17.1753107540404; Mon, 21 Jul 2025
 07:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <197d1dc3bff.c01ddb9024897.1898328361232711826@zohomail.com>
 <cd3ca680ac5751368941713c1071e04d69544d47@intel.com> <197d710ac39.10e2c241536088.2706332519040181850@zohomail.com>
In-Reply-To: <197d710ac39.10e2c241536088.2706332519040181850@zohomail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 21 Jul 2025 22:18:48 +0800
X-Gm-Features: Ac12FXzDdHF_s7WVKonqNsgMwmdC6Q6zqqujKluH5OQTrSCN3xvRecpp-sj16FU
Message-ID: <CAF+s44SvWGxwty3FA6ZpR3GoXEbqXRDoT9H6KBj_jy0yM1jjLw@mail.gmail.com>
Subject: Re: Second kexec_file_load (but not kexec_load) fails on i915 if CONFIG_INTEL_IOMMU_DEFAULT_ON=n
To: Askar Safin <safinaskar@zohomail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, regressions <regressions@lists.linux.dev>, 
	intel-gfx <intel-gfx@lists.freedesktop.org>, kexec <kexec@lists.infradead.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, iommu <iommu@lists.linux.dev>, 
	Ben Hutchings <benh@debian.org>, joonaslahtinen <joonas.lahtinen@linux.intel.com>, 
	josesouza <jose.souza@intel.com>, davehansen <dave.hansen@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j-kql1VGnJtIslptpGmcXTkd7c-RRpf_a-_hp-JLAYQ_1753107541
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_071907_379548_F8D98F58 
X-CRM114-Status: GOOD (  21.09  )
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

On Sat, Jul 5, 2025 at 4:12=E2=80=AFAM Askar Safin <safinaskar@zohomail.com=
> wrote:
>
>  ---- On Fri, 04 Jul 2025 12:29:01 +0400  Jani Nikula <jani.nikula@linux.=
intel.com> wrote ---
>  > Thanks for the detailed debug info. I'm afraid all I can say at this
>  > point is, please file all of this in a bug report as described in
>  > [1]. Please add the drm.debug related options, and attach the dmesgs a=
nd
>  > configs in the bug instead of pointing at external sites.
>
> Okay, now let me speculate how to fix this bug. :) I think someone with m=
oderate kexec understanding
> and with Intel GPU should do this: reproduce the bug and then slowly modi=
fy kexec_file_load code until it
> becomes kexec_load code. (Or vice versa.) In the middle of this modificat=
ion the bug stops to reproduce,
> and so we will know what exactly causes it.
>
> kexec_file_load and kexec_load should behave the same. If they do not, th=
en we should
> understand, why. We should closely review their code.
>
> Also, in case of kexec_load kernel uncompressing and parsing performed by=
 "kexec" userspace
> tool, and in case of kexec_file_load by kernel. So we should closely revi=
ew this two uncompressing/parsing code fragments.
> I think that this bug is related to kexec, not to i915. And thus it shoul=
d be fixed by kexec people, not by i915 people. (But I may be wrong.)
>

I tend to agree with Baoquan on this scene when kexec rebooted with a
graphic card.
I heard that this was due to the missed initialization on the graphic
card by the firmware in the kexec reboot process. But it is not an
official explanation. If any experts could enlighten me on this, I'd
really appreciate it.

IMHO, you could try blacklisting the i915 module to see if
kexec_file_load works without issues - this would help narrow down the
culprit.

Thanks,

Pingfan

> But okay, I reported it to that bug tracker anyway: https://gitlab.freede=
sktop.org/drm/i915/kernel/-/issues/14598
>
> Maybe there is separate kexec bug tracker?
>
> Also, your bug tracker is cool. One can attach files in the middle of rep=
ort. Why not whole kernel uses it? :)
>
> --
> Askar Safin
> https://types.pl/@safinaskar
>
>


