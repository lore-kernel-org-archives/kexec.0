Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B60BC04FFE
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vlLvun72mftZcBEYE43pxDPdIpekvp+Lijb2r9TuDqE=; b=u96SpFs+QgFZ8c
	95vZi+nkFQWF3TkUmY+mw59b98DEVcJ/qazjTok3pf6O4ZGmjmyb0DmKT5LzjRcuTMuIWZtmJRSFm
	AiiZtXeKVGabekHF+/4FmJcoAkMLausZqzLbl8MUwuP5NtsRUlKNAMbaEipH7HCK5sXgnozPspjlo
	aS/7fXun5Z5ue0PB5u/rowh8JTxKq1/p5Z87h9XntybBtbMZupJf5riPXR2bJJ55DJ3uMujzw9uh8
	/wWrKDvUput+N3t/YrtAqJgufUav2lHK2GDGvUW/ZbPQBxbXdLqlTZOmk6jBOcQvQ/xpKH0UNyfoa
	l+p5kyqJwhK6RCMvajZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2dxN-0000000Dxup-0bWg;
	Thu, 02 May 2024 21:27:09 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2dxK-0000000Dxro-25C6
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 21:27:07 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a58eb9a42d9so852534666b.0
        for <kexec@lists.infradead.org>; Thu, 02 May 2024 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685223; x=1715290023; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK+Nr9GDbKVe99LdxHOspcXdSuPveINKp7xXqjsO2YU=;
        b=QsmxFgDqnAyEGHvYYAlLUj5AzXfxu0EW/Ulp/j8fG/zLzO3HPL8Dvv6KGDFg9xnF7n
         6Ki/e+A8Pc4c590ehaUFRMcpQV0pDklpG0neyPSfMLMBCE5+tvzm6nOia/9JrRFlFZLp
         Lkuxv/qixdP8Dqbd0eoUPELeHXI1ZQ7VLmzY6iBKUcPGJH/M8Y09hz6o1sTl6yGaMGTd
         kWOtbByIKSjA7VEn2oWbqdV4qyGyCbtX3QIdPBI/iyaPdeIZ9ukREnk/e0hdWPBSLE77
         MuA/powc9p5j5wcMgbIJXJBpqGKybMr8gWKj/0AMr8UzZ5JMPmxUS+DAMtqmiYGaJwyY
         0GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685223; x=1715290023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yK+Nr9GDbKVe99LdxHOspcXdSuPveINKp7xXqjsO2YU=;
        b=nKrA+weSUfbgzbIgMbzt+sm0NKQIEeJLZwzsyFoL1LniYvkY7Wh+X5JdRrPA3whxcJ
         TaJToH+RL93SD1JbJFRTsiioWMD6/WI8evgQji8Zm4WJ90r1qs5za/kxmEv8f7CKfRtj
         uZs8V+ubp8xKQElW6+ohyJ5BIGTD9VeG3t7/WEw+Fzi0rVDq0qm51nDRg5AMI6lRWfZK
         TcVuGoHWoOwQDURlWdFH619QepR4SJokP+nNa2w+YMAkFXAwiHA8mPaqhtS/CojbVWsD
         8+C5vqQrpzSWVU6C+p2fC+owrQWh5EEbs6/gYDbMDU1Mfm/p+SLLu6OqP3zS7NegLS/2
         SCfA==
X-Forwarded-Encrypted: i=1; AJvYcCXM5vCzyM7Yy/KL+8LJ+yyjwcJf5t8TT9AhLIBcvlmPTGdiOZNF6h9SFFhKCRsmq11F3jbxz5ujoeMmb42qRfiDetSEvNIMYl/d
X-Gm-Message-State: AOJu0Ywz5c4NIkSMFH2kHv9dz+HREpuSLs51lncO6sC3epf6YaUvO0H6
	5uJN1dU3Wo65tqpmW6XH5bqDDT9fys8z4TXX6CrreGHeuBswIeJwpAJ9t8F3B7o=
X-Google-Smtp-Source: AGHT+IHBzotw8Ke7fIjVdKa5ibyRzh+WvB5Y+2scCGw1BD2igSpBC2Pxgr1SRQKeUwy8LwjKiKAuPw==
X-Received: by 2002:a17:906:c083:b0:a55:b99d:74a7 with SMTP id f3-20020a170906c08300b00a55b99d74a7mr364245ejz.11.1714685223722;
        Thu, 02 May 2024 14:27:03 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:27:03 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 4/4] crash: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:31 +0200
Message-ID: <20240502212631.110175-4-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_142706_597552_232612ED 
X-CRM114-Status: UNSURE (   9.50  )
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

Remove duplicate included header file linux/kexec.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 066668799f75..c460e687edd6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
