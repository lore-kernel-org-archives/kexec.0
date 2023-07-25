Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF8AC0015E
	for <kexec@archiver.kernel.org>; Tue, 25 Jul 2023 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PV3zBZlNOzJ2vL6tnjeJZIBfSNn+lN8OBFEBmNMPxT8=; b=lRZYT1hjjICKui
	OQen3BVNQJYDlEh5znRmmjMkL2QqBiQmCaevttXpynJRot5D5+KuFWPzo1FqsnpCNINxXsZX7b4aL
	3fsgsQwyGJcRppgdM+2mgrmOn/GbyyVBobfx9A0sJPH8t357WlIEJYtkQ+qScjS5ncBKgcttzbVnl
	F5pAC/02V+2KG6qrvIfy0Wc22PYn6gybBDOlwo68tMS5zAF7mG6sjn3T0A78QB+U1G+HdwJJkb/xO
	INww+tQmCYPuALbezkR4TlCO+NFNGTd7ws+ajmw0aLh8eTcpZfmSB6OsnCBzbBh4AQ4JSb2FUxnus
	ZERq2I3THHVeI+5Qu/tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOLRa-0087al-0g;
	Tue, 25 Jul 2023 17:03:30 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOLRX-0087ZQ-0q
	for kexec@lists.infradead.org;
	Tue, 25 Jul 2023 17:03:28 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbea147034so47025735e9.0
        for <kexec@lists.infradead.org>; Tue, 25 Jul 2023 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690304604; x=1690909404;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4+AkqHfBt+YF57UntWNN2nKkLF9PtsmEtzT5w0gGjw=;
        b=R8+j0MkNrQ9S1wsciu9YPQVqDiyOWBtNFsYYRAYkSldu25nmGXgnlE75BefikcMfLG
         4SEFn3CZL1vNb3HOeviMoFSF3L730rOMzcL7qUFVoRHEREDW0WdcWtOmKbzMVlfae5T5
         TsIDLX6YD4no0mPEHSW/5ZNX+eV/v8ncrX/4CRdwb8j1Joj3YKPEgits7wlA2y7RMXbr
         jqro8ts/A8MQfam9HTsPOhxDN4/coVhxV3a0codjQhF0gulrZn9lj2iVIyNJxYY5YE53
         WihUiIKfhYMgoJPvEnpRc0Q4Ij1WHEf6sE1d2HRjx4+Z8Aytuo5Z79P7R/1zJktYzIMg
         9dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690304604; x=1690909404;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4+AkqHfBt+YF57UntWNN2nKkLF9PtsmEtzT5w0gGjw=;
        b=NRpUiZuYCth5WtyI9/Z7nQ2wO57XNFtGyA7s8Do8cqDzcmvTVZtJAj1F1NkHSl/ZlI
         GXqYwm/3gvWA1zkC8brQK+c8MGuaaHMfvxx931oGkmvOml/LfBNicvqIfb2VZWaNMfiX
         s4+Ys/Qj+TQMRfSZ92pmOkeMN7Q00lym7L3wz1w1WTqSvNedMUjgoWU1Pilpt7TwQV2b
         4bEnrkCMxLTkzIsju0sFosKggp/V2HKMxJE99ynpr6VrKTOhh3nl71wnrh0o9nTjhJEk
         hm5w8Y+vlaBU2t9s9r2Ai7pSe7zsEmz8nyokvcBIm4LW/6EcfPDQo6sF+z+p+7pGg7zA
         mqIQ==
X-Gm-Message-State: ABy/qLaO8g9s/keWXxOmlLWjA7BOySsHJDH/Bvj9AEopOx3zjwWOiFWy
	+zB4MMiQYRd1D14c/LYjN3CirQ==
X-Google-Smtp-Source: APBJJlGgjQxBjIlV3D6Fz51keIByk9Gjjuex8YMFGkODUlaMAU9GW06ihUuImle6v5gOk1v8OaNujA==
X-Received: by 2002:a1c:7c08:0:b0:3f9:70f:8b99 with SMTP id x8-20020a1c7c08000000b003f9070f8b99mr8493034wmc.7.1690304604300;
        Tue, 25 Jul 2023 10:03:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c1d0500b003fbb1ce274fsm6046067wms.0.2023.07.25.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:03:23 -0700 (PDT)
Date: Tue, 25 Jul 2023 20:03:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_100327_323806_E83ECCCB 
X-CRM114-Status: GOOD (  11.81  )
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

The bug is the error handling:

	if (tmp < nr_bytes) {

"tmp" can hold negative error codes but because "nr_bytes" is type
size_t the negative error codes are treated as very high positive
values (success).  Fix this by changing "nr_bytes" to type ssize_t.  The
"nr_bytes" variable is used to store values between 1 and PAGE_SIZE and
they can fit in ssize_t without any issue.

Fixes: 5d8de293c224 ("vmcore: convert copy_oldmem_page() to take an iov_iter")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cb80a7703d58..1fb213f379a5 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -132,7 +132,7 @@ ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
 			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
-	size_t nr_bytes;
+	ssize_t nr_bytes;
 	ssize_t read = 0, tmp;
 	int idx;
 
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
