Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572F6C46CA2
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 05:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DbN0v5rZgQXOrCrW8WfXQIGnpcZfWsTAy2Pn/KBEzi0=; b=Xqvnjnn1M7plWe
	l8u/y5sfY6U9kfaLkALFjYjhzV9pfueQ0gE3GoeNpGczuFjKK37jExj+5DfKYrOpTIPupe0LEF7kT
	YWkEi2GVMBsA/IFlyYH7HzCs9POpychhK5tGsu92uuiNHlw/tp3s+norGU5wVzAOzgILm+wd9ilM8
	5lqnCzqkhdgpiQBMEBqXV9t9DoI78AmRHMqqcaSE58fLPgMAuBn9wjNGv6oPQW/lrK3tXz18x61/x
	4iiLq0RObkycGLAuhfBv5hV/2tOb6PqmqLeGY/ERgmr3y7QG9f/TWFXoXEBjMwTTr6e5K+tJPnLcv
	sxJ2XJfdoToj2T/AFB0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF66V-00973U-39;
	Mon, 18 Dec 2023 05:23:47 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF66Q-00970P-2s
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 05:23:45 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d337dc9697so22400615ad.3
        for <kexec@lists.infradead.org>; Sun, 17 Dec 2023 21:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702877019; x=1703481819; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0WX6F1qW4cp//8qgyXAfZIVfHgcSLJQmpyt0DLFZPqc=;
        b=nC27dLC93bFys+72fkyTtQQfHH+1yTqaXBnfJvNpL1m/LNV/baDXx2DQ4gpHtj4jyP
         ueTK7gnmkj6KWDwneRd8Nrnu8CVhKKwxw3vmx/n46dUjxjyMQNVRzXoJ+WWiiwxvaalE
         gtXfX54DQcMkMTkoRhDCbt3SySBrDobYoh1hRmEipdTzwKJcK4r9tDzWuLK3UDUe6Bus
         3yB4RoxAmSS0dH+iPPMD233LUhATD0X+igN0Xa5KM6DyM78qt4n/MYij9113FIbEt73/
         D7IUauRLtjvoegyzWE46JUHPJRGCE6NxcFT12fnl25+D9AFhozQ3s4UEsgpN8/brLtoF
         SNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702877019; x=1703481819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WX6F1qW4cp//8qgyXAfZIVfHgcSLJQmpyt0DLFZPqc=;
        b=Tio6Onfkg3VeVBHZrOioupCtINGanIa9N3MnO/WpbWgQjgwDIIoJ2O3WpiB6onfrBw
         spyBuw3RDLkHpWF4UcVEghKHSG4N+lTzxU6jjQxE8eLNhVqp3vgP+epO9JBh3PIQO/BR
         ZIah3LQszOx+Z5L4Rr6mPhUjbH/VcPxjIZj1UDeeAJCF8y5uFRA6zsbVgvwIpnJh8MOq
         UW9sW8TB0C3I0maf2wWll81JAazsG9H8TW81NEEFPRAEIZ9emYmrODB/BGB+lIHXWioQ
         Pmm8gfShXcljMCCyyKc2ivo0rCyGVuY1zzNfvlMf6G0JK9458wFWrJbTShKZS5WVfHMr
         zehw==
X-Gm-Message-State: AOJu0YxSVEgXRyAkabH2aaPtDqzvDfVFDIm4IxE8XhcFc/lfsN+KwviM
	FujomQlguha0f7vtNs0KhR4tJf510120
X-Google-Smtp-Source: AGHT+IEn1cUznCH5wteDtUVXtiqc1RE/B9Lpwdu5aFI67zaUagVX24XaEWBraUfG4Ek/xdVT9joxeQ==
X-Received: by 2002:a17:902:c406:b0:1d0:4a2e:1d89 with SMTP id k6-20020a170902c40600b001d04a2e1d89mr19765110plk.31.1702877019403;
        Sun, 17 Dec 2023 21:23:39 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001d3c0300c72sm582434plh.197.2023.12.17.21.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 21:23:38 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>
Subject: [RFC 0/3] kdump: Check mem_map of CMA area in kdump
Date: Mon, 18 Dec 2023 13:23:22 +0800
Message-Id: <20231218052325.20982-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231217_212342_947001_E70CF8AE 
X-CRM114-Status: UNSURE (   8.33  )
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

From: Pingfan Liu <piliu@redhat.com>


First of all, this series is only for proof of concept. It only passes compilation.

For years, CMA is proposed to be used as crashkernel reserved memory.
But DIO prevent us to follow it since DMA may be in-flight and ruin the
kdump kernel.

This series exports the crash kernel's CMA area information through
device-tree, and kdump kernel skips any page, which refcnt!=mapcount and
has a potential DMA activity.

The exported information include:
	u64 kdump_cma_pfn;
	u64 kdump_cma_pg_cnt;
	u64 kdump_cma_pg_paddr;

And they should be filled with Jiri's series "[PATCH 0/4] kdump:
crashkernel reservation from CMA"

After the conjunction of two series, the CMA used for kdump has only the
following risk, where the following conditions:
	-1.a wrong code forges _refcnt and mapcount to the same value
	-2.the page is also used by DIO


Is it acceptable, or any rescue e.g. CRC on page?

Please share your thoughts.

Thanks,

Pingfan


Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org
---
Pingfan Liu (3):
  crash_dump: Parse the CMA's mem_map in kdump
  of: kexec: Set up properties for reusing CMA in kdump
  of: fdt: Parse properties of reusing CMA in kdump

 drivers/of/fdt.c      | 43 +++++++++++++++++++++++
 drivers/of/kexec.c    | 14 ++++++++
 include/linux/kexec.h |  5 +++
 init/main.c           |  4 +++
 kernel/crash_dump.c   | 80 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
