Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99EDC25B75
	for <kexec@archiver.kernel.org>; Sun, 26 May 2024 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VpJjf/TNLDhKvyucyTVfsV2rBhxMSK2xWOvhLulqHB4=; b=QnQ5CZ0hocKd4s
	muSefjUUWlpZ3Ldm9/O3FQEyAnfQQ389FVgE2gAkARAybx4HZ7LMIXxa5N3DNp+pjaBNbZmE3N0QO
	4d1P84tVt4sNRqzR12iHM5M2nLh1K88pk0UevUuVYAcbYsDzhErQc9S6ue3V19xP2CYujnOLroKJR
	CP6oj3shoyuxL4Cx5Jf3s/bmYLuGcP1+/7GUK6z8hdaeU3v/EwjhRgV2eDYzbGUT44S5SkTxeuyM9
	OLIL9/0qcA2dhnAHa2KfLszazdYJfPMuny6vcUvWvjjOBAmC5dTm6NO7s7nF5xNptHxilfpj8JOHc
	SExz8+3lV+nWkQxNoKeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBLLD-0000000DHoF-1RXX;
	Sun, 26 May 2024 21:23:43 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBLLB-0000000DHnj-1v2a
	for kexec@lists.infradead.org;
	Sun, 26 May 2024 21:23:43 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-354fb2d8f51so2731260f8f.3
        for <kexec@lists.infradead.org>; Sun, 26 May 2024 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716758618; x=1717363418; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=ZDu3YWonRdK8oVFQD+80yjgEOHI0ekw5ywax3GrMGMmIY7VLkwn9/z+18eHnLOKZw5
         bB6z41L+cJuEqkAUzK/vfMjdHGlQfppqqzFQszPF1dIoJjExZt469QSZJjWqdT9pJUnB
         bNiRH7Xm3EWAns4TtqGORb73CnlVV97jAtSEgkeC9DAX6lBtUoLIEfr36DwDSmzSljlB
         hXzvf9fJqQRsCdOwslzLGW0lSlwBls239QMmcXqtm0W+5vEk8xN6pmzmaaHadgbIgw8b
         b3iKzemyeR6rV7gukM69ZOw0ZMADDMLgTZbPvjIcuxQZxmdZHnPh5QZkU/9WKlUd6w0X
         pbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758618; x=1717363418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=Hpiy9053pcijm7JS9HZpdxT4YHPNSBf04EIhcsnbfQRfAB713/bM4GnaLiVH5VAV04
         wkxjvxSLtDfD/m34hUtOzn8Lh5nT+i7xgwVh4bwa0pwjqnbI0nQ1a4Hh8zCI7Q7+QfGI
         UU4FErBjZv3F84X8FxUwCn52/633k5rLLKdw4I9M9ZiqKtoM0pJrw2k4GwQi9jpeXJpF
         w3Md50REWDNPcZOZk6U9gX3Dp7YKy6VcFjTbpKpn+np0egxDe0WAmw+RkDPVnsWwfNxh
         zvm7LdVe028gvX3YnPV7gtof823rvrrVWxabwFLXrCs3x2EHzU1I+HlDJrZ1fNvbUgy6
         aOGw==
X-Forwarded-Encrypted: i=1; AJvYcCVY9upfJ6s4TA3fhPwDg6NYQyWNzZDBQHrm2akV274U3049wohgjaqRYw/2d7ABRGmnml8M7ovp+mAMyZQPlvhru+h82rkdYKjN
X-Gm-Message-State: AOJu0YyRsyI0c9pTLLyUGuWKGaBSsZP5sU7kstmW0ba/h/QixCZiaiCR
	wfD2qHHiB6iB44E8MTQfJrsZy5EGJeMS256VtbcHXGNHAwmOEPl1qIxrwBu8Qnc=
X-Google-Smtp-Source: AGHT+IFy5L/fF6HnmYmy15FzQ2I5Aj94AJhD6S8HOgJeCGnH2efGYlzLjxrfvdfR5wJ4GRUcUbR/8g==
X-Received: by 2002:a5d:4e01:0:b0:354:f1de:33eb with SMTP id ffacd0b85a97d-3552f4fd249mr5166115f8f.26.1716758618179;
        Sun, 26 May 2024 14:23:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7de1bsm7224197f8f.13.2024.05.26.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:23:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: bhe@redhat.com
Cc: amir73il@gmail.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dyoung@redhat.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	netfs@lists.linux.dev,
	thorsten.blum@toblux.com,
	vgoyal@redhat.com
Subject: [RESEND PATCH 4/4] crash: Remove duplicate included header
Date: Sun, 26 May 2024 23:23:10 +0200
Message-ID: <20240526212309.1586-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
References: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_142341_523615_E204C928 
X-CRM114-Status: UNSURE (   7.93  )
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
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..d3b4cd12bdd1 100644
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
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
