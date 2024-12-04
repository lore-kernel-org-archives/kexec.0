Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2004E77176
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/hPjJFLUCb0ZdSDAqGVI3uh+hCPNkczr7XmzIQmCEzE=; b=aGl18yZHporr0fsSQKwkf0Xpir
	MXpFFizj0eIBQBXVr1B4qNRjSieibg79IU/yymCf/2TTTZVI9L539Ib5ItzsGeEcukxppDHM4FLB1
	eZjHS/Rn9Zp12URwTnWy0uej921mzqI8V/Neqsp6pJFD8/wNXb+DdnJStqd3m7XkzYqAVDNYr1QTP
	cFIaCwgdcqH5c9wBuK+hV6HOpPHfhCcPAvIsGuKL+mjLqATiPbfOT0OcumAljXAwYCUtvAEdjLLOg
	yG2CVDeVZ8oUMDbHKuFkFj5yluEQgBoNWJPDR6knJW5nNMXr9sqCyjp8uqrXYTFN5xxtNRbNQt4XU
	W0nUVrIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxj-0000000CbcC-09Cd;
	Wed, 04 Dec 2024 12:58:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIouN-0000000CaB6-3XXb
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:55:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hPjJFLUCb0ZdSDAqGVI3uh+hCPNkczr7XmzIQmCEzE=;
	b=cQUBjrHC6vuua6YJh3h/w0XCrGusBAG31hO28IrWKXTd4iOjlDk08wjUFqtKMOZYhNoWPn
	Xu51WI2LXGXFKEID26X8TYgt54osLNucZs38bIBtskdHdIEKlxEtBbedI+bJv313Vkpf7G
	VstWXl2cUnPdSvxmIE0rmakzlBcJMWs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-P_b3lVUqPvyiswd_spyd-A-1; Wed, 04 Dec 2024 07:55:10 -0500
X-MC-Unique: P_b3lVUqPvyiswd_spyd-A-1
X-Mimecast-MFC-AGG-ID: P_b3lVUqPvyiswd_spyd-A
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349d895ef8so62526395e9.0
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316909; x=1733921709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hPjJFLUCb0ZdSDAqGVI3uh+hCPNkczr7XmzIQmCEzE=;
        b=DUk/F8WugsQuujzFf0IsYLQMEuTkS14BQlUDSXmIo888zDIUo+LNmeuXS4h1nU9L+A
         f10qafPJDpWHoV4nn4GbNLPRk82LUYeDt0ql6YGglwne1sWqPusK5pKAGRWK/JCo33wY
         lcwM93Bn1uSk69XsN5TNxBQtV1abPyo/tUCGSIo335VxWqRLa8NoBW8Hw2lXi4xUtLV6
         TjYBVC7Yr4EdveS9jgfg3ngjZVp9rGR1sjMPrxYRCHagHCcxEabssbAPBfgN9xcTwMjq
         QAIhlc4OoZKmfUHKBob0snRkI0dE5+x8/QGaSsaUMjMh4WMIuxAGjFtZCLmyNbyG9XDK
         pA+A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4YMX/nCpfaJy8g63RbMc1KPNEUWT2AOlUxpdMCDFOl99xQN+Ef2Jw6ZtOm1DDZg9H/M+8g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwGQHZCzr4ytIEDGomw27M+5Lu+qoUKU2UDZiLfpcuh02ldBhbR
	/I/EPbzZgESri5bRnyFhnEkpdSTTH5Eu7aw/lbTDWXmu54hXeqaQOAXku5ZOa2SBBSXGJcQzDNJ
	NAZbDKxMkuQR/X66WrWymZFiPFyR6uW0axDpOYXYe6k3YcPlC05TUWbhdOg==
X-Gm-Gg: ASbGncvsJ9TjNqPD3Xwa8MJaBi4EXpG25ruLyUcx7cmKJj5vZ6q3VkNEkC51xVYq8kk
	nT/I0NCQ9ZfplDDQLUgCaUATlsHFLzQstxEFclBwGCbYZcTz1UITTqr5xuMhxaiGyNbSNwxjMP3
	6KbEPs+zCfZB5N6gKDCy+yn16WcqLASjoBvEF51KYLPKNBuOUTl2awRd4no90yUyVZMfa8Boe9F
	ToM3icCZSTjmiFgpaiAqJxHjP5cEsjFTfnGPzpTWtqH72G2UDXlc2yStUA5wy43Hl2XQcjoZTa8
	3TuIb4gS4BAEdXkgaPm+ds8IwpLYq6iTpvw=
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr60274935e9.6.1733316908762;
        Wed, 04 Dec 2024 04:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKlYOU/tZlshqWyJGjVsl03zkEzffSPE/+D71b9Tfd5+g4TqcfXtmwO5t6x/22DC/lF4E/bA==
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr60274425e9.6.1733316908112;
        Wed, 04 Dec 2024 04:55:08 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385db7f86dasm16267209f8f.66.2024.12.04.04.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:06 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 07/12] fs/proc/vmcore: factor out freeing a list of vmcore ranges
Date: Wed,  4 Dec 2024 13:54:38 +0100
Message-ID: <20241204125444.1734652-8-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DHrkWY0yY4iDrQ6xXa-5W2JsnMcta-PLfKtuAmmCcww_1733316909
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045511_953692_ABF85ADD 
X-CRM114-Status: GOOD (  13.53  )
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

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           |  9 +--------
 include/linux/crash_dump.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9b72e255dd03..e7b3cde44890 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1592,14 +1592,7 @@ void vmcore_cleanup(void)
 		proc_vmcore = NULL;
 	}
 
-	/* clear the vmcore list. */
-	while (!list_empty(&vmcore_list)) {
-		struct vmcore_range *m;
-
-		m = list_first_entry(&vmcore_list, struct vmcore_range, list);
-		list_del(&m->list);
-		kfree(m);
-	}
+	vmcore_free_ranges(&vmcore_list);
 	free_elfcorebuf();
 
 	/* clear vmcore device dump list */
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 9717912ce4d1..5d61c7454fd6 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -135,6 +135,17 @@ static inline int vmcore_alloc_add_range(struct list_head *list,
 	return 0;
 }
 
+/* Free a list of vmcore ranges. */
+static inline void vmcore_free_ranges(struct list_head *list)
+{
+	struct vmcore_range *m, *tmp;
+
+	list_for_each_entry_safe(m, tmp, list, list) {
+		list_del(&m->list);
+		kfree(m);
+	}
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.47.1


