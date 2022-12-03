Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8831C47088
	for <kexec@archiver.kernel.org>; Sat,  3 Dec 2022 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Cc:MIME-Version:Date:Message-Id
	:Subject:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rCI7R8/YDgN/9v9f9xo8aXySpjJ8t7t6a6U8qdA5DTM=; b=ug2vOpDJeMLbdS
	YLaxK2kaphIg1WmeL3FstmosPTVkkcB872PM3dXlcFCbEZmqrWflQBn5L4/FBI6SBqdaNXC9o6lLw
	FQLCAmc+LESXO359dbFvICFvaaiGWw661IeRzks10kWXCgTKxU2hD3LyQ6HguOth1M/pVhy52w4Uc
	fiuqxvCN5ZcQZDHYmvEzGWXxi827DlfRwVep4u3QNqveCWDSTHoi2GXXU7ysaX7eCKzK0nxjm+dYt
	vptewNTofgfOcxltmnhycWoE31KARFHM7pw369VtyVHQfhO+a+pZIb/vIToNntIfPZjlzsRpR7W/P
	pShhr9J1dXa1qkaiwRHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1Gpz-001rpj-6G; Sat, 03 Dec 2022 00:57:03 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1Gpu-001roE-Vr
	for kexec@lists.infradead.org; Sat, 03 Dec 2022 00:57:00 +0000
Received: by mail-pf1-x435.google.com with SMTP id c15so6385403pfb.13
        for <kexec@lists.infradead.org>; Fri, 02 Dec 2022 16:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18IZ0m5toh803lbdbvk/IEmYiB7S5eI1v1wKhdMmz6I=;
        b=FxQVJ80S9QkHllGqaVUvnNBiW1xUrcSiYTno/9plqqGOFfeEqGXXEiGXeRlhf57k4O
         wP4zI/rjXepwujEZ5K0JDERtkOORTHTVW3murD7yOKYk8Rhu/0O9KizxLx868HXw4WzC
         hKwXODCFYDscH+gB6BFDyA2nHgRN+gug8OK2pFNSBzDVGu1H5v9Aajo1g9JTZL/GORFv
         WDY2evnKAQunFA+yeuF5UHiF7vo2oobtvTKYpGpIr59gP1UqjFZtpdn3Q02Q1ksrxtj6
         J8pBdK+4Q1NyTg6LZRIL69Dbyl0B1iTcJEeXtC57Mab4rMxHsXCIktj6tsebfqma8Keo
         6nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18IZ0m5toh803lbdbvk/IEmYiB7S5eI1v1wKhdMmz6I=;
        b=gBNuadNwmQ57xRsF9oWxn88fRjDnOSbonpo6xDWXRrdM/n6rQs2xBNyIqQOSYJL2cL
         s1WZOvcdyqRZNYinnoETAYI+Ky36q8fCqkZ8tIizKP37Oot3C+vjDSIebJkQFoDzSxq4
         mDKPdXjUdriAeCWj13bPIJIxShYvh43tJ4cjgOLcuL1+0GFyZwF/J3NW4hdk0d2Zkm/u
         fgGVudVWi4kBkHco9g/B+vJXfy1TcgslSVpuc+QJ10eI2cnpduRmk/+6iQO/XECSM22q
         JbIYPmqAqDCDU/WRe2IS9FKoUQftWvWdIbMoRk4dQZFu+Ydmp2OXNhdHKhc/1af/BNFg
         JGTQ==
X-Gm-Message-State: ANoB5pmHLEUJ7j9M/Bkp+TLHx/dMPUklO7r1b5ku4K3oa+/NE/1TgKRF
	rBAmmi1AlI3GBobyHRUyFSLn8A==
X-Google-Smtp-Source: AA0mqf7l8GDn2HO87/kOUsruTegFJYC7NPmDdYxV0Oo4X9myc0x/MCYGm6AFgGQ18JfhnX017FqfFw==
X-Received: by 2002:a63:ce10:0:b0:478:5e53:4742 with SMTP id y16-20020a63ce10000000b004785e534742mr13351694pgf.471.1670029015924;
        Fri, 02 Dec 2022 16:56:55 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id x28-20020aa79a5c000000b0056b8181861esm5859524pfj.19.2022.12.02.16.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 16:56:55 -0800 (PST)
In-Reply-To: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
Message-Id: <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com>
Date: Fri, 02 Dec 2022 16:49:39 -0800
MIME-Version: 1.0
X-Mailer: b4 0.11.0-dev-e660e
Cc: hschauhan@nulltrace.org, yixun.lan@gmail.com, kexec@lists.infradead.org,
  heinrich.schuchardt@canonical.com, linux-doc@vger.kernel.org, crash-utility@redhat.com,
  linux-kernel@vger.kernel.org, k-hagio-ab@nec.com, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: mick@ics.forth.gr, corbet@lwn.net, alexandre.ghiti@canonical.com,
  vgoyal@redhat.com, bhe@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>,
  Conor Dooley <conor.dooley@microchip.com>, bagasdotme@gmail.com, dyoung@redhat.com, Palmer Dabbelt <palmer@dabbelt.com>,
  heiko@sntech.de, Xianting Tian <xianting.tian@linux.alibaba.com>, guoren@kernel.org,
  anup@brainfault.org, aou@eecs.berkeley.edu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_165659_038255_51A06B5D 
X-CRM114-Status: UNSURE (   6.91  )
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

On Wed, 26 Oct 2022 22:42:06 +0800, Xianting Tian wrote:
> As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> need to update according to Bagas's comments.
> https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> 
> As others patches in above patch set already applied, so this patch set only contains below two
> patches.
> 
> [...]

Applied, thanks!

[1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
      https://git.kernel.org/palmer/c/649d6b1019a2
[2/2] Documentation: kdump: describe VMCOREINFO export for RISCV64
      https://git.kernel.org/palmer/c/c5b4216929eb

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
