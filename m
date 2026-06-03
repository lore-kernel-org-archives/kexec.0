Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB2ACD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i8sI6lLCNHN6RKEMLtPAJ87Qc5cPrvkoDu5wACGhMgc=; b=MmbJz05+lUTagVnbEDNcShdEHc
	2ouLGXQ+wQ1gbsZk2dN4pesd9gt7RQrHBufkvffG8420l03OzoxpZSnKhNmDjUA21reGWena5TY91
	0PIECCzhH+bFrR1O8JolcmFDtlnhin5NH0VcdaMpgKKJmbRt64i+XcQi1R4I9QllzBMQSSJjqLfhI
	56y2P4OaGSiwZSAsUNWMfsCBRhZquS8XZUghQawNjKrDMH2fXVexkwqnCUST0Rf2Dj2VxhLIw7ESk
	r5K4HP6o0l6usbpriP8JLq0gegtRDlCuFejx6Q6SdPGg5p/p7s00zYftpVX0yxQ67uh2OpCTragWk
	YaAQdKwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnlf-0000000FRjp-2QPK;
	Wed, 03 Jun 2026 15:44:31 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnlc-0000000FRin-3xgc
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:44:30 +0000
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-8cebfb15413so21160806d6.0
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780501468; x=1781106268; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8sI6lLCNHN6RKEMLtPAJ87Qc5cPrvkoDu5wACGhMgc=;
        b=DQFeIjFHQkFh7chOER5prmJwzgdv071S3q3EKGgPcHczmnfr7tK34toej4xZHzNraz
         bR2/gHRKa4QSLJ4tjUs6kDuP117D+krWC6COu4p6NEka/yGE5BIsJdzTUCBFhJ1WzVnl
         0bx6H3C5QTlbWD/L14Su1K3NZihdw3rdZIHM+IRw0e4jpIwZAu1bVSfvgQb8EGP3yCGL
         hkGqlJ//epvlIOjUT+ZxDvHYnxKgPI9sXx+ndL5zUMY7EPiojNhPqFqdqU1OIyEFq/RZ
         3IpCUfJXYiRzDObSEINUs6k1sNIOQ3KiTQZKV+AmVRfDItKm+VhmVEmW6PGaTXODrsBZ
         e25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501468; x=1781106268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i8sI6lLCNHN6RKEMLtPAJ87Qc5cPrvkoDu5wACGhMgc=;
        b=RD0x8g8C7tGmwiJYvQO/3LiRBfS3DqCvd3pRpQLhGn+U7iIhxnwV//dEInL2WIK/wc
         rrN/iwxshBH7niSutYDsDp1+f7ehyISnI+mju9Y+fmkf5b/GHOepidPIkljUtH349cOG
         iCUtmuXRgRl4w5DPLJheRep07SAJUoDAMxAQsBuUV3FBOOBTtVwQTM8mxRrvsJg1jqEF
         QNBeC2G7+aWj5YvMfzdFJOqFya0nerI/KUVDCnbIloGeuk/W9vR/bVRQwpiIpW831ulX
         ORCvSL/+pwpsLoVqgHQIbFJfSlsnA4B04TKM1s0EnIVe97mtdWtQwpjWoagQZbeogoQh
         1wSw==
X-Forwarded-Encrypted: i=1; AFNElJ8oPrftaaONGt3QDfS1ul3GMjYobcnXWuWOrRtsyJvXqdmrgNMe7AtHZvi8KxqWwtNR1ONFJg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4vgvMbNqHKP0JrBiQsoiAT2QaiqrsTG23BeJs+mtnJpu4SLcx
	kpjMc4PkfmCcqgbVGBsfgkBCD6Ug3coMwpM8Yyp/u8OSYfzomNF7YtxZ/fazS0GuQXo=
X-Gm-Gg: Acq92OF2UrR5m1L+FRzlG5k7Dv5+YKVI+iXm5lR8TG8PpFh9H/EBHYHEfG7t3ockocq
	31LAz3o9e43geyxtcGt4cLoTq9Mx5SVS2ZSODwbSC6cYUx8K4OrfxsiS4vj5MOTNOnlo+IWuH9V
	vKxa50EKP/22y4OlpTVGZBA/5T9nZRCtJ7IYExSyGABX8URqvs8a9x5Lff0MRQmDfZrxq5DtkcA
	bllio4xmlpXZzDLrfCiZQG7KmwTQX6KfPESTjj6UQ/boFs4J+sNe4avnFBT5oR7F1HXqKt+072h
	rW1NNnAgtj1+xCYv1wy984pW5Ij61tHjwKIq66Km4hnUCclQJTG1lguA1mOPmVJ0maCSJFSuzhh
	Of5R2Cr1YFL7S//i3AJqa/BKZjUP2caK7bgKB6uB1RX0LJW74dN56NNSQ6A00MEogr4K4Uj7rZf
	DMZCzPF/SwflJWHZZ/yHmhgK18P+2f4GkCesvz9sLDe2kMzoD6UGUIcr8lv3Hrhw==
X-Received: by 2002:a05:6214:aca:b0:8bd:6baa:6a0c with SMTP id 6a1803df08f44-8cecdc28301mr58362326d6.11.1780501467702;
        Wed, 03 Jun 2026 08:44:27 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd0520d3sm23311476d6.27.2026.06.03.08.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:44:27 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v7 02/13] liveupdate: avoid mixing cleanup guards with goto in luo_session_retrieve_fd
Date: Wed,  3 Jun 2026 15:43:51 +0000
Message-ID: <20260603154402.468928-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603154402.468928-1-pasha.tatashin@soleen.com>
References: <20260603154402.468928-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_084428_982247_9858705F 
X-CRM114-Status: GOOD (  10.26  )
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

Refactoring luo_session_retrieve_fd() to avoid mixing automated
cleanup-style guards with goto-based resource release, which is not
recommended under the Linux kernel coding style.

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 5c6cebc6e326..47566db64598 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -291,10 +291,11 @@ static int luo_session_retrieve_fd(struct luo_session *session,
 	if (argp->fd < 0)
 		return argp->fd;
 
-	guard(mutex)(&session->mutex);
+	mutex_lock(&session->mutex);
 	err = luo_retrieve_file(&session->file_set, argp->token, &file);
+	mutex_unlock(&session->mutex);
 	if (err < 0)
-		goto  err_put_fd;
+		goto err_put_fd;
 
 	err = luo_ucmd_respond(ucmd, sizeof(*argp));
 	if (err)
-- 
2.53.0


