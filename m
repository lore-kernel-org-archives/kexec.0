Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E054C4708E
	for <kexec@archiver.kernel.org>; Mon,  5 Dec 2022 22:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Cc:MIME-Version:Date:Message-Id
	:Subject:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7RR4ELNexu3PFWmk9ZV9X2huEgQyhnjoxvsEqXoRGwo=; b=nCPGEb2X4qS+nj
	IUtAoVzulasIBirBI4jjvFNmd1GCm2qWeihAQxUXA6ZMNH+gA4EzKtLUXXUUsh+VJ0ki6hQtVoB8B
	b/WGA16Uo3D/5Wk4QlxamrmEyxGpCJAsyA+mNy9F0iX1fnFH8duwUUwcWkgshNMFenXzxdgJ+N6Y5
	OcbZz7LWD5U49wYUY4Osyb8GN2H4XQOijtXr1QuEyE1G5JoiF++MaepZr5kRwO5kBXh6tvKohfvL0
	42Qduh/LCJ8S3y7WjFIcFW1ecbVmcrR4GpRasR40E76dKxYqu0vluehgbOzz4RuAV9bJlCN/UeXxc
	oHVNZ4IJrRA+hQlo6C2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Jz2-00BIwn-0e; Mon, 05 Dec 2022 22:30:44 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Jyy-00BIri-FG
	for kexec@lists.infradead.org; Mon, 05 Dec 2022 22:30:43 +0000
Received: by mail-pj1-x1035.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so16255380pjs.4
        for <kexec@lists.infradead.org>; Mon, 05 Dec 2022 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ES2k5wJuZRctREsjiyUhiGb9OyDVGDDXD7SGJfpP1jQ=;
        b=i6Uw13yqFBGcuPiVXN0VWc5ozg7Z6Zebk/OzRXzynMRTiW8FAYVdHsYat9BYLZoyN4
         +1qvFvXPl4HGr11e5IW/tnZEvB7xKJKWWPmhyCblb1sC+DW/yoXxFl2CzuVVeuprUHR1
         WFG+9NWsEbcACIYRPzf9DbO0K8rtn8juuODqz5ET+m/sNU/1xzOtkyg2jQt2+3Hgjvmz
         BsCCBBedhi0EWCNmxaXmImKlW2eUdxfs5YRM5yMtK5txMCHugkSf2yqzZC5/sQNBdymb
         +/F9w2Qys4Ly9xz5ljQlDVqpHtRaE4KcEnB3U1p0nX5eI4DMEd0tkhzCQ9hE6WKKVSUh
         GflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES2k5wJuZRctREsjiyUhiGb9OyDVGDDXD7SGJfpP1jQ=;
        b=sFF4M/k7VuoxrRgV7QvuGeIBOQ3DSSzN8ety5eeAhsgfLBoKK96O/uuHbSrZAoWUee
         cy+Qy+ZvzFLgXlUv1Urf1KKIK0vWe0uCUppCAlQgNtUc8lJl9zgAwdRNX3QO+vgcbtYP
         Gnda/1TftT4ume03y8tVFu9lsCpovhZqk3N0O4baWYVKTDkvwQUrx0TxDegVGlsU4b1d
         79nw+75bFpF55914dr742yJDvZRbLNqUNvQ2c89gknAmqIewjGcUnJLpJencvQ3KbGKj
         qioofpvkqxxBP6S2JWmplkKgb0GuqnqJcTDwu1k5K5WemyQiAATra+ar/KQiJWCtdYHk
         12Cw==
X-Gm-Message-State: ANoB5pntElUJpG0qQmQe6yI+gPS4Lfkn2Wb4dHEi6tevZNimuRhrYdRs
	Cj9Kg4NQxvT1sYFFRdM6mUcXtQ==
X-Google-Smtp-Source: AA0mqf403jjH6Od07domECqCLhAmdAmXlon4xMYzxQd+PtWi53Y8a1CH/kZX203Y4CwYWxNXRkiSjQ==
X-Received: by 2002:a17:90a:fd8c:b0:219:408c:a41e with SMTP id cx12-20020a17090afd8c00b00219408ca41emr39645073pjb.194.1670279436221;
        Mon, 05 Dec 2022 14:30:36 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s3-20020a625e03000000b0056bf29c9ba3sm10650290pfb.146.2022.12.05.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:30:35 -0800 (PST)
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
Message-Id: <167027930833.25586.2671834159281320615.b4-ty@rivosinc.com>
Date: Mon, 05 Dec 2022 14:28:28 -0800
MIME-Version: 1.0
X-Mailer: b4 0.11.0-dev-e660e
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  kexec@lists.infradead.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: aou@eecs.berkeley.edu, liaochang1@huawei.com, rdunlap@infradead.org,
  u.kleine-koenig@pengutronix.de, Paul Walmsley <paul.walmsley@sifive.com>, lizhengyu3@huawei.com,
  Li Huafei <lihuafei1@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_143040_591193_07CB6741 
X-CRM114-Status: UNSURE (   8.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, 4 Nov 2022 17:56:57 +0800, Li Huafei wrote:
> This is reported by kmemleak detector:
> 
> unreferenced object 0xff60000082864000 (size 9588):
>   comm "kexec", pid 146, jiffies 4294900634 (age 64.788s)
>   hex dump (first 32 bytes):
>     d0 0d fe ed 00 00 12 ed 00 00 00 48 00 00 11 40  ...........H...@
>     00 00 00 28 00 00 00 11 00 00 00 02 00 00 00 00  ...(............
>   backtrace:
>     [<00000000f95b17c4>] kmemleak_alloc+0x34/0x3e
>     [<00000000b9ec8e3e>] kmalloc_order+0x9c/0xc4
>     [<00000000a95cf02e>] kmalloc_order_trace+0x34/0xb6
>     [<00000000f01e68b4>] __kmalloc+0x5c2/0x62a
>     [<000000002bd497b2>] kvmalloc_node+0x66/0xd6
>     [<00000000906542fa>] of_kexec_alloc_and_setup_fdt+0xa6/0x6ea
>     [<00000000e1166bde>] elf_kexec_load+0x206/0x4ec
>     [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
>     [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
>     [<0000000040c62c03>] ret_from_syscall+0x0/0x2
> 
> [...]

Applied, thanks!

[1/2] RISC-V: kexec: Fix memory leak of fdt buffer
      https://git.kernel.org/palmer/c/96df59b1ae23
[2/2] RISC-V: kexec: Fix memory leak of elf header buffer
      https://git.kernel.org/palmer/c/cbc32023ddbd

These are on for-next.  They'd probably be fine fixes candidates had I gotten
to them in time, but it's pretty late and a leak during kexec doesn't seem like
a show-stopper.  They'll get backported anyway, but this way they get an extra
week in linux-next just to see.

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
