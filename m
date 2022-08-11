Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1183C00140
	for <kexec@archiver.kernel.org>; Thu, 11 Aug 2022 03:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cjCA/KTHuyXdWfxhKuFV+evLpB5Sf3xFhWA8UE640aE=; b=0Fzb1dekZkc74w
	DwJGqEyPr1V85bApFcQItqbeWPKu08C0KfUCSnkv1geoZc9UO6yOZ0QMWFaTN6ZB4G9acQbgXpucY
	gOhUMLDMWQadLWjZkKwnB9IECsc6Lp5U55HqJwAQQDWv9f26g5BFKI3UzWIbbMMh7EuqhkLoRJVmJ
	74pffEh/SOs6m/Qgv+fX8zVogel9DCauQOoYTJHoD/1fzKIC6yZQ0Tk7xKTtK6qeUePbSLcNMNTou
	F2uzvOOTeayOLxO/1LVAfNJaD6tmJqu9TKhRzY5QHd6zJw7qAtZ6TAfyk8AqRnXo7Y6NL1f3p4peM
	3LauEM6WBDpPKJdqvQRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLyXK-004gCn-Fh; Thu, 11 Aug 2022 03:07:06 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLyXH-004g9F-L3; Thu, 11 Aug 2022 03:07:05 +0000
Received: by mail-pg1-x531.google.com with SMTP id r22so13631687pgm.5;
        Wed, 10 Aug 2022 20:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LmnOiDMX3xGrA/oiBCR1NQTWs1yu4LdDCazzpBCjFtQ=;
        b=H5cnkUVNltB7wWsF6EV6zhRHqMdbHRl1/9X0CDEmIn8sQxFUTqE3GaaBiao9RVv2Mz
         GWFL+fetVlJKW24AtbvGfvy+ha6lP+7aSEb6M/IgtNFMnQUj9oK6w8bnLM4z+77rsjHZ
         MRrtvBp8y8vyFudVo2+O9wjHDVEB9Sv3UpJbLXpDTfhjTxtHkflOHqPlh3slyuFq0hSO
         s+W6AVm5/scjepfNTCg7e+IerJuZBjTapd0T5672TOKc2FVLrnIC/0BPN0dWSX2qIGjC
         PpH1AyDTbPS0p3IdtusCKRavn/bxNhTlDX2GHN0uoXdU47oMbRAhkFK4Ue92EdUAtYRh
         N9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LmnOiDMX3xGrA/oiBCR1NQTWs1yu4LdDCazzpBCjFtQ=;
        b=EB9OY94GdNxG3/476pCvzcDGhAMHtY7bqk5zW5LqgPF4RQg83VZw1hbbKWuq+2K/sh
         7weRF/JbKKvUag+OPe/kvoSpkJnM830z5/uRWkhtTiBUoheY1TmO4LZFKNNVJ4YWKGrW
         Kd8Rd/IGO7cYfsslhLjrqZERL/r0vFV1MBDDbi8CzpuNCOFKZJI9eYFncK0b34WMAJZx
         pSDA7uT+Nj+Rna2QuzEOymqPBndV51r3Ng0riHMmr/Vf6pVhqo2NfL5+O/e6WZ+thC6X
         pZ5NauEiFownC/6hvGAl1aFhXlJwR7IwkIpNdGmNg+HaCnO2DzUcTjh7Y0673Z5l09nV
         tY4w==
X-Gm-Message-State: ACgBeo2mSQF52QrlSE1l/mUePp+/3fdAIx+5SkdoBOt3HW1RuJ3OdsbN
	oGNOkd3N5Fx97xumlER+lYg=
X-Google-Smtp-Source: AA6agR5B0U4yEPzcfEMvg4EWSUMEiB5V88JgPoOag+aXjmtx75T7wOxR3QgN0r7Desc6C3h37KfZtA==
X-Received: by 2002:a63:4d0e:0:b0:412:1877:9820 with SMTP id a14-20020a634d0e000000b0041218779820mr25457368pgb.177.1660187220938;
        Wed, 10 Aug 2022 20:07:00 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id oj7-20020a17090b4d8700b001df264610c4sm10902763pjb.0.2022.08.10.20.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 20:07:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id EB139103BCD; Thu, 11 Aug 2022 10:06:55 +0700 (WIB)
Date: Thu, 11 Aug 2022 10:06:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	anup@brainfault.org, heiko@sntech.de, guoren@kernel.org,
	mick@ics.forth.gr, alexandre.ghiti@canonical.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
	Conor.Dooley@microchip.com, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, crash-utility@redhat.com,
	huanyi.xj@alibaba-inc.com, heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
Message-ID: <YvRyT5f5uH7LBs4H@debian.me>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_200703_734885_7E7B1CFB 
X-CRM114-Status: GOOD (  11.14  )
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

On Tue, Aug 02, 2022 at 08:18:17PM +0800, Xianting Tian wrote:
> These infos are needed by the kdump crash tool. Since these values change
> from time to time, it is preferable to export them via vmcoreinfo than to
> change the crash's code frequently.
> 

I have to agree with Conor.Dooley, that this patch is misleading (I see
documentation instead of real export). So IMO, the patch subject should
be "Documentation: kdump: describe VMCOREINFO export for RISCV64".

For MODULES_VADDR and friends, the doc can be improved, like:

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 6b76284a503ca5..6694acc32c3588 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -615,14 +615,13 @@ phys_ram_base
 
 Indicates the start physical RAM address.
 
-MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
------------------------------------------------------------------------------
-KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
-----------------------------------------------------------------------
+MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
+----------------------------------------------------------------------------------------------------------------------------------------------------
 
 Used to get the correct ranges:
-	MODULES_VADDR ~ MODULES_END : Kernel module space.
-	VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
-	VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
-	KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
-	KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
+
+  * MODULES_VADDR ~ MODULES_END : Kernel module space.
+  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
+  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
+  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
+  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
