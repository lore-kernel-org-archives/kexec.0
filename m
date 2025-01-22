Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00127C02181
	for <kexec@archiver.kernel.org>; Wed, 22 Jan 2025 09:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yyCjRrkbGde3kvq5V4txWDKrLIctP6FAvSzHNKivVTM=; b=blGD8ojHpkPe0gJdHfvKVkJCqr
	ufLF0NZmv33WO1dAz2WTU/JR2XQbqY1v1d8/bqft4CnqyPpB9/FnI6ZVBF9LyBYyhF96J2fxVQbRA
	xkZ08KI8WriNfERKDZonAy+T3zy50z4PvBNNRKZcj1kj45JdFidNMTjLIWv37jYPuUZ9NeM0IE2Zc
	seORfSzBR10PpGnqLh/ZcYgHwLv3yI9g4wOPZOE5ZL+FC5kIDsu/+gTigCA2A6+uSC2/TWibnPg1N
	QUklG+vmyj18M/Im6tLLZg2h0T54GQEfOvJeNRR9Y/6Q6V21TEVP6z6QQlT1kUS9E6cXxPrnZ7bcz
	o0W2XaVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taXJV-00000009pJu-3yXQ;
	Wed, 22 Jan 2025 09:46:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taXIn-00000009pDk-0Ues
	for kexec@lists.infradead.org;
	Wed, 22 Jan 2025 09:45:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737539136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyCjRrkbGde3kvq5V4txWDKrLIctP6FAvSzHNKivVTM=;
	b=BNW6GM1ypiUQ3ggy1OfTq9uFhMjC1J22ro+64agm0x6qhjTlr4L3D+iEPH7djogJyagTws
	N/duy6K2aGZKHkpzP361qVf3ptlJycfn48lq3Glun+eEAX0swUlg0+RbTxGhd5ooHZ76DE
	ApDXiNTDPUUsQoS9p6Dwi8WHAcr7Tx8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-0B_Bw-icPB63sGnpXAWvtQ-1; Wed, 22 Jan 2025 04:45:34 -0500
X-MC-Unique: 0B_Bw-icPB63sGnpXAWvtQ-1
X-Mimecast-MFC-AGG-ID: 0B_Bw-icPB63sGnpXAWvtQ
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso49890165ab.1
        for <kexec@lists.infradead.org>; Wed, 22 Jan 2025 01:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737539134; x=1738143934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyCjRrkbGde3kvq5V4txWDKrLIctP6FAvSzHNKivVTM=;
        b=DdsiuDxh74SjJCwAidh3L9xm4mx3CZ3zp9zEuokxPKP8EQ1DXTdf/iuitCIauqy3v/
         kaNkBEGHP3EGn1fMqbFH5dSdQgRzHkdA7mlgixuG6Xq6kH4tzAokAxCHtSysKTM7PJoq
         qV/0UzFG3dObHuIArBn12u4gHIXNOoZMtJc/macYQ1n5qtKKPaasdaYPHzNKQFej4H6n
         I34wy3OxTL8dlzVXd8Dng1qTy4VyXGM5MBN9dzrkk/E62s9joRiL8sETGid1J4+V7lW/
         hRb+XsQNv3jmgWxUEPVNrSNymarugKSpHazefbeFAOLISo2xvmhub4GM6OGhmxu/7l9F
         uhhw==
X-Forwarded-Encrypted: i=1; AJvYcCX2M97nkpKtES9AijrK/th7/XDDHCxUn6zfQgAOm7zjcrXAuP9chAte8yiuFOtY6me9ongP6A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxxpfBKo9T50YLTYrQx6Sb5BpBkVGLasK5h57csoxe9ZX4mP7zq
	K7bQ7YrkR/jf3layfsfuPlysf4p+wuhwk4pB+NgiVtggXplt9cGfDjJ8UZAKlFK/XQrp+vSH2e8
	IHQZlMVOCD14h9zRGbIq3ul2MxiozZb39X39emqIUQfTpWoXnle7/rMo+Nk4b9J1g2oYVeARKy9
	EKefzrn4nAyw9/xPD0tLOVaKN5q47nnxKB
X-Gm-Gg: ASbGncujrxlwvgUOcTGb4v1CZlNb1E1vEgNza5Rvi/oaCfcrevjlBJKKj0VEuNtROjw
	SSo67AI0skoP1O4coq+2bMZR0l6jJhTxv2VptDv69VmCiqMIC0Y8l
X-Received: by 2002:a05:6e02:4708:b0:3cf:b62a:d38b with SMTP id e9e14a558f8ab-3cfb62ad548mr6839305ab.12.1737539133952;
        Wed, 22 Jan 2025 01:45:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIPD077b4G8AkO2RvsoOP8ZsRfpujjR36pn01SrQFGxp7KGByKkBoan7/VXdsRXY43BKX2FEh2Wdm8Pbn+dpI=
X-Received: by 2002:a05:6e02:4708:b0:3cf:b62a:d38b with SMTP id
 e9e14a558f8ab-3cfb62ad548mr6839035ab.12.1737539133320; Wed, 22 Jan 2025
 01:45:33 -0800 (PST)
MIME-Version: 1.0
References: <Z4WFjBVHpndct7br@desktop0a>
In-Reply-To: <Z4WFjBVHpndct7br@desktop0a>
From: RuiRui Yang <ruyang@redhat.com>
Date: Wed, 22 Jan 2025 17:45:41 +0800
X-Gm-Features: AbW1kvYNw_qRoZSbVWcaArR-_IblaJucJ-H4UePBgio9Q2kKLmrwRXL4Nk8Joco
Message-ID: <CALu+AoQhCjUPr2dnYdN751dyUgNUpyx1HCfyztF5GaP3QRzibQ@mail.gmail.com>
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from hibernation
To: io@r-ricci.it
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com, 
	kexec@lists.infradead.org, linux-pm@vger.kernel.org, 
	akpm@linux-foundation.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bm4P9tgVaDDhIQApie-baabGKXXUVGzBMK8aTZA7iLI_1737539134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_014537_227301_0BE80BFA 
X-CRM114-Status: UNSURE (   8.97  )
X-CRM114-Notice: Please train this message.
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

> I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> running Void Linux, with the following commands:
>
> ```
> # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> # reboot
> # printf reboot >/sys/power/disk
> # printf disk >/sys/power/state
> ```

Which kexec-tools version have you used?  I'm just asking to see which
syscall is used for loading the new kernel.   From your bisect results
it seems kexec_file_load, but just a double check as kexec_load and
kexec_file_load use different sources for building the e820 table.

Thanks
Dave


