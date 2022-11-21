Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF88C4332F
	for <kexec@archiver.kernel.org>; Mon, 21 Nov 2022 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gqW3a7f77p+DrwGGmnefJywZwkiW+oQLhZ20lnr24cg=; b=Mvreej8BhiXrWG
	RgZq/CkCQ7Vs74mmCeQnSgz9DMGrSGRlaznllMKcWh+ogX21TLsqOPtyRWd4AJCi+0DZfuvLVAUEJ
	PnhKMHaAg4mqgnGU9qTKwdgik6Wo9RWDVMX2J3/0hlvZFIypIqJEjaTO7Dah+IF0wQuO3PCcm5L87
	N/CJbQc0Ic0wtveGOLu5+xgkzr3r3mPcNN44gkR3DZ2CBG8PxLHWMoK/EoCxExBo1tAj6scVOjFG1
	WOaK8e+eNhftJxNj4P//gkjnYKSdOn+05AqAZClEVM/E8FH2iHDfdUwvbGo8E9p2JRKjZOCtxxepo
	8XSOUxNm4WjRKDr2keSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1Ff-00ANJ4-CO; Mon, 21 Nov 2022 07:29:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1DJ-00ALQz-FS
	for kexec@lists.infradead.org; Mon, 21 Nov 2022 07:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669015650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N50omf+v9tTvkyUKa0XY0AIkXRuI62g4muqCOHQCuPo=;
	b=JqYLZLZdH3kuVFf6MPBB1ZNEdvtvZ9uy2sGBrbP9wqYQO3P6lotZ83PfOy7ltq4H7ZpP6v
	2/z8z9BBRaN477YhZTTsIVuka9WU7OAns1TtTxJLqyPxElzuqPixTGTlXQxb/67HQl04kx
	0zMxT81mMPVIIwmTJ+7BtgdRyEZVSJ8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-fg8yUPOeO420QHfYzi-5QQ-1; Mon, 21 Nov 2022 02:27:28 -0500
X-MC-Unique: fg8yUPOeO420QHfYzi-5QQ-1
Received: by mail-pf1-f197.google.com with SMTP id bw25-20020a056a00409900b0056bdd4f8818so7009171pfb.15
        for <kexec@lists.infradead.org>; Sun, 20 Nov 2022 23:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N50omf+v9tTvkyUKa0XY0AIkXRuI62g4muqCOHQCuPo=;
        b=tEZTUEmUbw+k9kfUJSr2038/3zJK7s0hhEPwX4wHcSzoNo6Drp6muZLm8eWbRUmjsB
         XhLZjxH2yjiIbcEZVgZH3KQH8zqSzl36+xSVHO12oZEWTeGFiE8gexIpGuCAwcA+HIle
         RIFc3YCmV9+iVDikYP0mo+DUo+lBXKM7fccKiyDYes3RHeAt0LA96cu+pfrrDTtr+CkH
         4De/+nV5snqMD14oaG+VXy3brmphjC7JXhJ/gQiHV+JE9eNTYGCB7Fd5NQxJTdj7aXVd
         w1GMBEQZwWanMSTYyMRnfbcBVjZs3d+9J9ahU5NipH5Ah/yGPxhdccolhViW0bg7+FpL
         SCrQ==
X-Gm-Message-State: ANoB5pm/75MUD1ARvchLktHvXikU8mHTGOpILdxadOp7PXce/DrWCGll
	Fy39os9xIlIQAa0/EpT7+oPGsSHEz6aU/WNBQLNRB9JMu0jj4pF26eTHa0KSx2JrfWt6lufPq0n
	loFBZLAJRk+hOhkoQsya+Blfn13acqENLNWB3VNB2kWcrShpqeBOPlZx3d+dNAW7PsV4=
X-Received: by 2002:a62:5e41:0:b0:56b:db09:a235 with SMTP id s62-20020a625e41000000b0056bdb09a235mr586964pfb.20.1669015647146;
        Sun, 20 Nov 2022 23:27:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6euZCzCDbMvci+vSLMNOtsuOD0+hYqb6XwMGuSvrXS5hZkDpXsz/SXoxFTRnBj9rTHSs3zgQ==
X-Received: by 2002:a62:5e41:0:b0:56b:db09:a235 with SMTP id s62-20020a625e41000000b0056bdb09a235mr586931pfb.20.1669015646754;
        Sun, 20 Nov 2022 23:27:26 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902b94300b00183c6784704sm1559065pls.291.2022.11.20.23.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:27:26 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Jiri Bohac <jbohac@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	James Morris <jmorris@namei.org>,
	Matthew Garrett <mjg59@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] lockdown: s390: kexec_file: don't skip signature verification when not secure IPLed
Date: Mon, 21 Nov 2022 15:27:15 +0800
Message-Id: <20221121072715.836323-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_232733_666448_D8E836A9 
X-CRM114-Status: GOOD (  10.66  )
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

Currently for s390, lockdown doesn't prevent unsigned kernel image from
being kexec'ed when secure IPL is disabled. Fix it by always verifying
the signature regardless secure IPL is enabled or not.

Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: David Howells <dhowells@redhat.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index fc6d5f58debe..627685426ac2 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -33,10 +33,6 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	unsigned long sig_len;
 	int ret;
 
-	/* Skip signature verification when not secure IPLed. */
-	if (!ipl_secure_flag)
-		return 0;
-
 	if (marker_len > kernel_len)
 		return -EKEYREJECTED;
 
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
