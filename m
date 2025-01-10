Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C382E77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 06:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IiAJ8xDeDKCQRhrhPqhN/i2nPASyCdrjQorH10tZa3Q=; b=Ow2btmpg9iv0yS1dgZMO+zZTEN
	/SscY8WyJaElaMJfSrHYj1fYH8QrpyTylnBvHGDvODLsusV2VvIBCxBnXAIj+6YMk3VYd2VsKB+nY
	SHv7HpEmUDgjcC9EknvSZd5BFpSXdtys0MCsLb6PpOdJqfyEVIXGQcIKucniaTGqHfrq0VXEnauC0
	tcot5b53aX1JVkCPVS/EoDmUenXnkkZj4tU/W5XyhLH72+UyhyW/V5eQCrx+plQcHoj1GAvCI0FHf
	Uh2QRV6J1wXGZuVfrze7vCQD002GcOEmJpqEGgj5kJ3BPid2I5PxvksbmMDUsnYzCfVxffd2i9iKQ
	PWGbKErg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW8mD-0000000EIJG-1ZZW;
	Fri, 10 Jan 2025 06:45:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW8WV-0000000EG5q-49p7
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 06:29:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736490574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IiAJ8xDeDKCQRhrhPqhN/i2nPASyCdrjQorH10tZa3Q=;
	b=GUdW9hdGgNsYE6xIi9Nt7SMJrLabLseowcrB1AImqpSGt+ikGlUXxMfsz98dtszzwWC1tS
	3lONw24IKkNqzIdWI3x9NMEWrK1BdwnrfNB3OIHDWtvViycpVF1EiNxTY3Cz+1zVnolakR
	rr82rV4wsQpGtczstcUtTqHwHkAhsYg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-bSDYifBiOsOYF0alzP0-yA-1; Fri, 10 Jan 2025 01:29:32 -0500
X-MC-Unique: bSDYifBiOsOYF0alzP0-yA-1
X-Mimecast-MFC-AGG-ID: bSDYifBiOsOYF0alzP0-yA
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a91a13f63fso13090325ab.3
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 22:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736490571; x=1737095371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiAJ8xDeDKCQRhrhPqhN/i2nPASyCdrjQorH10tZa3Q=;
        b=fgRUdj/4Q91WQdhOreutpspoTcZhFssnm+6yvTthSQpPbJzFh83mxqhiKkBeQ9rjyb
         mGeMEzr3qBxi6Sql2t7csjXsOc0U+ZkrAKB39TESR8hILEz7nq0TmUSlEYK3VhQ3vNxD
         8hKvkAU1cX3sOMYpDrtQLFSpC8exZmQfdiIF5ukw13xSE51ZdmmoNt/k/F4awlbE8D6a
         vf/CuD+7NdV/Zo6g6I9Xb9qxl4GeBYZvSYqIlhGTarSCxOFK9d2ljJyuTsPyJJV2Hf/y
         bFOE7CSH7OJLoMZxZBGKW1FnrCGXjQUykZR2XmLomUV/TfRbJvWloFzHpzicTS+LmU5o
         qKeA==
X-Forwarded-Encrypted: i=1; AJvYcCXAx5txKKUh07ZLt2KDv1rmhdGdDNcw9J+keDNcksoWavkfmUhQRLJDoLjjnqRRy+qqHFrBxQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx90e2+McoBsYxL4x35DFuDPCdg0RZu0xWLri9tIL4FxXo2N4gP
	C8hmsq54jJObV6z8TBr+91D9Y8M6Us2l6yRNlthJ/OV2UXRQlaiaGgZT5JZ0i3MimCyiHOXu9iB
	+vW1HqFunnPfV2QYojor/oWA+djbuJx5OITc4WVVjkU/4ev7vtL4+cJIIzjgKTUfuWAmcDeVNQv
	vOGFDolvPNEGufLyKWCXWEm/M57+aU8V12
X-Gm-Gg: ASbGncuivQgty+s5fcp5RRg0fgHxko5Vh4z6vzbuslzmd39czCv4DcDOttK1hblvipP
	5KoyrrGKyzg8xC+Ec+DarJZ96/sFggsN9uNgnq/k=
X-Received: by 2002:a05:6e02:12ce:b0:3a7:e0c0:5f0d with SMTP id e9e14a558f8ab-3ce3a9a4fd2mr77709915ab.3.1736490571326;
        Thu, 09 Jan 2025 22:29:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuMsG7v+ceSW/JHqjCvzf3CO9gcnAzQ4Ie5mZym6pI8QV5WU6rSl5HJkiCgTEJ2MRAjQEpjPm7pc9yzxXpw4U=
X-Received: by 2002:a05:6e02:12ce:b0:3a7:e0c0:5f0d with SMTP id
 e9e14a558f8ab-3ce3a9a4fd2mr77709845ab.3.1736490571047; Thu, 09 Jan 2025
 22:29:31 -0800 (PST)
MIME-Version: 1.0
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com> <CALu+AoQyGN2m1ss7GSPCn5UqiEWb+M5BK9MStzMn64k83egtQg@mail.gmail.com>
In-Reply-To: <CALu+AoQyGN2m1ss7GSPCn5UqiEWb+M5BK9MStzMn64k83egtQg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 14:29:36 +0800
X-Gm-Features: AbW1kvb0Ce0nwN6VwX7_qaOwfUM0eNBbtLQO9Pu5wU213ir_Q127NeuZEXivH5Q
Message-ID: <CALu+AoSKCtU4iGRM8LH6qYbgKvZ79=zfC8kXXb_GJqp=mpEdFg@mail.gmail.com>
Subject: Re: [PATCH] x86/e820: update code comment about e820_table_kexec
To: Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4eBXPi97bLr3Oh6OxvF3r5dtL52Btm_EZ6JEn7-REOw_1736490571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_222936_104514_E33257B0 
X-CRM114-Status: GOOD (  28.51  )
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

> BTW,  the conversation below drived me to read the e820 code:
> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
>
> It could be better to clean up the e820 tables, anyway the comment fix
> in this patch itself is good for now.
>
> Basically e820_table_firmware is used by kexec-tools kexec_load
> implementation,  e820_table_kexec is used by kexec_file_load code to
> pass to the 2nd kernel in boot params.
>
> The e820_table_firmware is said to not be modified by the kernel in
> the code comment, but this is not true, at least the sev code updates
> the table.    The hibernate code generates crc32 checksum and verifies
> it, but since AFAIK e820 table update only happens in boot phase, it
> will be stable on runtime.  So we can just use e820_table_firmware for
> kexec use and drop the e820_table_kexec. With the change the
> kexec_file_load and kexec_load see the same memory ranges.
>
> Otherwise I thought we can use just one e820 table, dropping
> e820_table_firmware and e820_table_kexec, but then there will be
> fragments and memory waste  due to the setup_data ranges are reserved
> and updated in e820_table, so the e820_table_firmware being still be
> used for kexec makes sense.
>
> Anyway I need to think more about it,  please let me know if you have
> any concerns.

Reread the old commit 12df216c61c89e31e27e74146115a9728880ca6f
    x86/boot/e820: Introduce the bootloader provided e820_table_firmware[] table

It seems the e820_table_firmware was changed to be exported in sysfs
instead of e820_table_kexec,   but I suspect this is wrong.
kexec-tools (kexec_load) use the exported sysfs memmap info,  but
e820_table_firmware was created by above commit to be used by
hibernation and the table should not be changed,  the fact is there
are changes happen from time to time.

Question is does hibernation use the sysfs entries from its userspace
tools?  If yes, then we should have both kexec table and firmware
table exported because they are for different purposes and one may
change, another not.

If hibernation only uses the table within the kernel then it makes no
sense to export it to sysfs, we should only export the kexec table for
kexec-tools use.  In this way  both kexec_load (userspace) and
kexec_file_load (kernel load) can use same e820 table, it will reduce
the bugs and be easier to maintain.

Thanks
Dave


