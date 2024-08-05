Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB14C3DA7F
	for <kexec@archiver.kernel.org>; Mon,  5 Aug 2024 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OsqI/no19mImnHuDk7FzhDFra2idqAjg1c0QXdsmgRk=; b=gVpxCgSIksDgPz
	+1HSa1j/keJGomm2Z+d3cyqlA57Gpebr55clKrF9FG2js13NW86H4gcxWPingHIXEDK/OsbsPXiV8
	INQmb+otcHxZvA1MGa19/P0xGxT5dc2jSzfsTE5uC1ropipBwzSlscnuSxHT1imM2UTBgHWxj/J19
	GXrNJoO5KC3bwtNNHT7rS/Dt+e/mOH4mjcx8jkUGfcCT2URiudgay6zQi21SNF7QRyQ7xA5PXKHje
	P99cIWhDsv4BBE1ywpiPyY20JUNPt1M3EcI3fb6wEOKZffjIr0Rvcjac5QDgiAtIyluMtTC+jam4i
	CMLyMxL7FsyFGF38zKiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sazJn-0000000GFqi-1umP;
	Mon, 05 Aug 2024 15:08:15 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sazJk-0000000GFq5-0bVR
	for kexec@lists.infradead.org;
	Mon, 05 Aug 2024 15:08:13 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so1285671366b.1
        for <kexec@lists.infradead.org>; Mon, 05 Aug 2024 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722870489; x=1723475289; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z12bTz3uc/6bWoxaYbSLkO/A8SqLo9rW3xC9vooatVQ=;
        b=Fyzq6fCtdAovbzWJYHyhySeyo09WCkT2rD6N+5wVISXwdBs0anIHMz/BP6L9AC6cgA
         fptU5EC5ILhN4+hEK3r7XF3/uyPjb7uTAsPF66TK9aQ4FchUsyyvcet+ppc4dXn1hwD3
         jkrvIGrIBOOpe2wp2WwmYwQ13+hwQnkyM7KUC8hidy2TDleETZjMDMi7j7170EiPNh10
         YoCh0HvCPRXogzSzNV6cKAKMHlhEA1FhvjsnKRqXuCw823f2oix7l4rfgtW5cRj0Ukud
         hMik9yVStYVaSHT8+X7Y4sGHUU4g3nZXrteWYmNtfE1cvi+XshlY1sd1TDfjkCDooMWU
         UWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870489; x=1723475289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z12bTz3uc/6bWoxaYbSLkO/A8SqLo9rW3xC9vooatVQ=;
        b=cEvlQ+3E2sw8YMGm7blHxa/Wspd4BhEWGu+oG28fmymfkfOEGhDHOpKGNwsOhJN1C0
         Azt7MC/PUhp9RaLLH9WvEImVzHpyTUhJj+WRpBVS2ofsniS7vr9Q6cROgkYwfPLpxY/t
         bo2BIlzBWOxn9o8RXQ4GqkM+HL8/1LLaNf1UjwIU6wVBu2CvG5EIWh7KzzGX+A9FxJE4
         FLzRC02yqh+XGmtpGuRZ78hq7C3i78oXK5DIJIiNBdpafB7WhdW6EUNEn2/4IhA7pdR3
         1+4gNwzb/6qSctJo1kMXC4MqTpggz9WNro34/jOIbGdGkNzZQ9DXpHr1gvmZpyvzQ+ny
         5ksQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAaAK5uhD9DZ7a6CrtNMSAl0wUDbEwkclfMbk9jLMoq/3dRH+GEZfJQ43/4bCp8HJAEfwAlpYZX5H4sCBO7BS8XuIqi9+1YUEq
X-Gm-Message-State: AOJu0YyUZnychNRDfAdmqFJEHRl0o9lqQ/bzTjgCjHyUYfA2lYWNaJRU
	ZhgbfRsbVDgB2hSPAR/R9r6AaZ1HjzsERYuC4lqSXs3gERLdE2W3XQHLQCRczVM=
X-Google-Smtp-Source: AGHT+IEag2rNRk0j4QehJ+DMvtcP+G/n9mTpBKv6zvPEM0uKOUnzQ0IF6Ol2eIkgYDDb+d00iGANlw==
X-Received: by 2002:a17:906:d554:b0:a72:6849:cb0f with SMTP id a640c23a62f3a-a7dc5100463mr806932766b.62.1722870489211;
        Mon, 05 Aug 2024 08:08:09 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec7173sm459121666b.204.2024.08.05.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:08:08 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	kexec@lists.infradead.org (open list:KEXEC),
	linux-kernel@vger.kernel.org (open list)
Cc: Petr Tesarik <ptesarik@suse.com>,
	stable@kernel.org
Subject: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when CONFIG_CRASH_HOTPLUG=y
Date: Mon,  5 Aug 2024 17:07:50 +0200
Message-ID: <20240805150750.170739-1-petr.tesarik@suse.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_080812_210631_C647A5D9 
X-CRM114-Status: GOOD (  11.36  )
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

From: Petr Tesarik <ptesarik@suse.com>

Fix the condition to exclude the elfcorehdr segment from the SHA digest
calculation.

The j iterator is an index into the output sha_regions[] array, not into
the input image->segment[] array. Once it reaches image->elfcorehdr_index,
all subsequent segments are excluded. Besides, if the purgatory segment
precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
the calculation.

Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
Cc: stable@kernel.org
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kernel/kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3d64290d24c9..3eedb8c226ad 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 #ifdef CONFIG_CRASH_HOTPLUG
 		/* Exclude elfcorehdr segment to allow future changes via hotplug */
-		if (j == image->elfcorehdr_index)
+		if (i == image->elfcorehdr_index)
 			continue;
 #endif
 
-- 
2.45.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
