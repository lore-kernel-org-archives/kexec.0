Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA28C36001
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8yL5b2WTU5WHGZETUIu4ND+tiGH8mntIZf0oxmIMUMA=; b=2Y0+2mMlgIMN+sTwp8dFHfxgdB
	Kdng1xbUpoHtWjB/S7KHR2aHlMSuklezRxgxXahGxpBEk4LIzu5GY7U7ThyZaJ8njLZYhErKmdfBl
	T1nGGHmo2PzA2Nm5Q5aO8ndBluvAQO3dDc6AgrCfdTLMhzyZJGpg7txvEhkjHi4XKgSl5x2sfZIrD
	bCzxS5yBYTZJExllUrIJE+MtZPKmqYdfJnHoTVgUVhLJFMbNqF/zqhofW1zv+zjG5Vg0bGZN+Usn6
	mnPO0eMUmMRl1wy+2XlMpb4sPJhaYrSoU6Ih/pZmtjGh+6jivUwqiEXvAfG2TFybplOgtfNXGuByg
	Csvxyvsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRu-0000000CTvz-3geN;
	Thu, 20 Mar 2025 15:04:46 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58l-0000000AkRq-0XAZ
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:13 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2254bdd4982so4814425ad.1
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435770; x=1743040570; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yL5b2WTU5WHGZETUIu4ND+tiGH8mntIZf0oxmIMUMA=;
        b=wSfsMcupzBcOYYlvN7GoRYET9X70swpalaV45piFB5Jz8BFqcmfO98JIBHE1TxhzJk
         qmKyOfGded0SshqCJveqJ3MCATdGLJOBztkTo/EJaO0Hz7riBAKWY2knNmHmIdy5Dep2
         y8+wAG3ioPLSx3VDQwWRL9XhStVzAvljlVyN44+DWEtPqf9Yc1ydygaCOFMH3tjoAMVW
         pYgdj/jvKxEKI2QNZO0APEJgV0Y4mAby/R/c5eVjUPvvFtO1Yg4iuJfnUk+Xc1KaHmWo
         eRfLRQeWj9dD9K3XtKghn+LBeP1fupbPI2BzLnBCg7/vxg1s9bwIqu2PhaR3eeEL1lcJ
         WNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435770; x=1743040570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yL5b2WTU5WHGZETUIu4ND+tiGH8mntIZf0oxmIMUMA=;
        b=TOFCNpmB1SbfoWv0eKkYRgttBi7/OUj2BdKx3Ovjk9Gt3iULu9/9jTM/puAfhESeFI
         2xVaQTn848DDzHx9rP/Hg5MuWvGWEUcE/F/O6fmjaMswbPCRA1F7WBx7PiNeV+oIKH1G
         tpB1cG95e5pRcn1fUDvgHxCnePlY8RwvYC036/glB4gCeYY1w0D+x1cO28HajGD8qPHb
         cDbaPWpTK8OUv7LVRMulpyWyiFZ/4kKBrX7FvyyCv4EOnc91IxK7ALaN0OdheF/s5RuL
         ojBhgIBfcMxe2Mij/QWXNvnatJKkIJMFPYJR9VpkRPSIYsxDRRf2yOHD5jrUb1oXgZIy
         PW2w==
X-Forwarded-Encrypted: i=1; AJvYcCX8DWiYkJAmefMYgir8Y3Q479TobYXP8jXFejZ0JyLX+bJCszn0lKanJYzaEfuHh+6l9lw1Yg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWvqPbu0nSAIk5W0doXU1+J68MLD/MeOBGCBESr3VrQNcswkd/
	SILELejeVElDbSoWUWljyf/WadR98mF44let74dtF0Uvwou9GNNLXIpbaopxDSn35o34Fy83P5/
	3cnwwDw51VPYP2MSGqw==
X-Google-Smtp-Source: AGHT+IHW15FvPpMLWn1HKaL85qfGSHpQDCxTWGFYK6N/65irCZHXzpE1wn1H8XnTV124IW6pqODmzO2IIQUyBB4r
X-Received: from pfbna11.prod.google.com ([2002:a05:6a00:3e0b:b0:730:4672:64ac])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4187:b0:736:fff2:99b with SMTP id d2e1a72fcca58-7376d6ff535mr8193650b3a.23.1742435769805;
 Wed, 19 Mar 2025 18:56:09 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:41 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-7-changyuanl@google.com>
Subject: [PATCH v5 06/16] hashtable: add macro HASHTABLE_INIT
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_185611_222580_0BFA7E52 
X-CRM114-Status: UNSURE (   9.09  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

Similar to HLIST_HEAD_INIT, HASHTABLE_INIT allows a hashtable embedded
in another structure to be initialized at compile time.

Example,

struct tree_node {
    DECLARE_HASHTABLE(properties, 4);
    DECLARE_HASHTABLE(sub_nodes, 4);
};

static struct tree_node root_node = {
    .properties = HASHTABLE_INIT(4),
    .sub_nodes = HASHTABLE_INIT(4),
};

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/hashtable.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..27e07a436e2a 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -13,13 +13,14 @@
 #include <linux/hash.h>
 #include <linux/rculist.h>
 
+#define HASHTABLE_INIT(bits) { [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
+
 #define DEFINE_HASHTABLE(name, bits)						\
-	struct hlist_head name[1 << (bits)] =					\
-			{ [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
+	struct hlist_head name[1 << (bits)] =	HASHTABLE_INIT(bits)	\
 
 #define DEFINE_READ_MOSTLY_HASHTABLE(name, bits)				\
 	struct hlist_head name[1 << (bits)] __read_mostly =			\
-			{ [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
+		HASHTABLE_INIT(bits)
 
 #define DECLARE_HASHTABLE(name, bits)                                   	\
 	struct hlist_head name[1 << (bits)]
-- 
2.48.1.711.g2feabab25a-goog


