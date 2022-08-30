Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6DBECAAD1
	for <kexec@archiver.kernel.org>; Tue, 30 Aug 2022 04:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cc8yybsU0/svcg4ww8/5chFCL87Fd8HThyh0p1MR6GU=; b=vw/Y8iUU9Kj9Yq
	+uF6Ugr5H05m/RNtevp/6oJtxGBQKfojvUqUeY9r9HzK5pbu1uMYNgYyiwsXWNYnVqC2+08w4Ff8r
	RnpCL5/dngfb0SuookMN/fO9XJV29pGqRY3caHFHZLZ8lkXbmCFFj9mD3i28qmnen+3155zzxAV99
	UDGJXyIQXyGHNCsCaXZ2QuWirEo9ocH1otEjzVjYVWJL/RvtnGEU+C/Nc+pYMFLzSREdglBy9k5zG
	1SiDANVOIYLllYjE9N+Agx+EDCrCGBpbqMeJ107QpRGDjzQ0VVNw90ch7YpJv7WSllgdL7/QDSsy5
	tpaeajXforABz6q6vRww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSsrr-00E05Z-Rw; Tue, 30 Aug 2022 04:28:51 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSsrY-00E01w-NC; Tue, 30 Aug 2022 04:28:33 +0000
Received: by mail-io1-xd33.google.com with SMTP id q81so8316998iod.9;
        Mon, 29 Aug 2022 21:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IiYV69tyEj+bybX6EJGKjRJBog8U9SbwxG5mkmTGRVw=;
        b=XVONKF7d3W7EwJOLHgmUQlSsZx1O823f6Rhtuul//ZTdPlpsEw5PIODBxIhzsc6WGp
         j7x+W1hY5a28AYYVt9Za/EaIMXL15HdiA2ms5ZYAOFAVkTRuIrcQeOsRnZuYDB7FVk3c
         +NpN/9EIQQEOa+4Qejc4S1azLG25u/kHejDzz7P2ipMV4HRizNArSkviiV7dVcQaehg1
         qkZ4g7X71uOE4EFrZZYzQsZVt2yNAZVWB/WsVfxeUt6t9ZZA9DVkgCyOjeJgYrWFj+gz
         Mq5owqtaO2Gg96hQ1XKjLpodC18At1I4l2w98y/0svMPRbZct5kGmo9jQnbrj02qZxTL
         j75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IiYV69tyEj+bybX6EJGKjRJBog8U9SbwxG5mkmTGRVw=;
        b=X+TStHVB7kAcvWOk6gb/iswapB5MmlopNkF+uOZnwAqPiFWTxGTXsAy5MXO+cWMbyU
         Qer+KDIHUjPMq3YeXgULo//WLOyYw65T2506dT+RHeuVRaSvlDBxwY/0DU14LDtDnosj
         WmVXbYyLPTz8gSMbOqLqLYgDf7SMK+qOq8YRykSvJ4tGzW3Uq67PwVj9/QKQjbpJan1x
         JmMpEfxtuKNqXUw3yEiQKUGjd3qdXqWVuQ0RFN3IjgB6z0dh13GRAYf3IfcgUmJkuixW
         WjuEmiaDxDwnhGPgu770x9GGn+b+f+3aE17mtrQq6JRL7DlB0OhmjuMH2JBvbs3mPX+X
         GEwA==
X-Gm-Message-State: ACgBeo03hHFOdHCcPl2Z0rSiBQoebhUD2/qLy5eSNztKH0WJ8SuCqfGM
	KYwxRSaZj0dPOfenOwIArDiBa2I2C8tK4W0c4uk=
X-Google-Smtp-Source: AA6agR5YwsPm1vdnZEuZ/JPg/Q4vlN/vmdgvE1r7QOmb/lP3dObcMTm7SnQwunOu+42Lb3Yuu0bO0ea1iKw1LcOT1QQ=
X-Received: by 2002:a05:6638:2613:b0:346:e2c5:aa4e with SMTP id
 m19-20020a056638261300b00346e2c5aa4emr11473681jat.160.1661833710912; Mon, 29
 Aug 2022 21:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220803151217.75962-1-ppbuk5246@gmail.com>
In-Reply-To: <20220803151217.75962-1-ppbuk5246@gmail.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Tue, 30 Aug 2022 13:28:19 +0900
Message-ID: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
Subject: [PATCH-RESEND] arm64/kexec: Fix missing extra range for crashkres_low.
To: will@kernel.org, chenzhou10@huawei.com, nramas@linux.microsoft.com, 
	thunder.leizhen@huawei.com
Cc: linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_212832_772845_ED61D4DC 
X-CRM114-Status: UNSURE (   8.98  )
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

Like crashk_res, Calling crash_exclude_mem_range function with
crashk_low_res area would need extra crash_mem range too.
Add one extra crash_mem range when crashk_low_res is used.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c
b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..378aee04e7d4 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -51,6 +51,9 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
        for_each_mem_range(i, &start, &end)
                nr_ranges++;

+       if (crashk_low_res.end)
+               nr_ranges++; /**< for exclusion of
crashkernel=size,low region */
+
        cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
        if (!cmem)
                return -ENOMEM;
--
2.35.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
