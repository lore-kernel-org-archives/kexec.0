Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5A5CD4F3C
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kzbLbrBxTj3Os65r+VG8KyOSku+VVjAs9NkmdJFxbWQ=; b=KRHj38MP7FeX3Q96F9tm2ZerKx
	ujYkMdXpnBEdeP6zw/66PGPx70VTC8INCBbPGBjh0/8KBjfpCNgHdND/CnM5O0gb190XI8a6/bGA1
	6LZpObbOfjbhUNpeBXfb2v9kXOu8IRv51+KJhS3/W9wXXB9320evPEhStbbaWxRHXKLdOzoHa0flf
	dDo0m1Je0nUQOjUNIkjhNWw6P0eXsjL31gwURx1dxV20bK0/znsywyOsu9iC+bDz8qMkrI43lrUv7
	AApj3LKc6zK4GzJx+brdhbR0xNbEyju54rAPQfMWIFbxtQL5zRRqdhMa3JWV3zOJ7y2PkMJzDz9dB
	O6knt01w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8c-0000000DKQB-3d0C;
	Sun, 17 May 2026 19:26:58 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8a-0000000DKOV-0ZOu
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 19:26:57 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-50d880e6fbbso30374201cf.0
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779046015; x=1779650815; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzbLbrBxTj3Os65r+VG8KyOSku+VVjAs9NkmdJFxbWQ=;
        b=ZgGGEW5S6ehTedsblcRAYjr5/n5mrIvOjpF8e0Vvsl87G4cjOtA5oi+/7y/lRsf2nN
         9gCzDYZwZErBAI56o/A8/2B9xymJKdARbOe6x81FwZNewI2YgpMThir7l1/XO/cU4HtU
         ElbTtq9TPpUs8nDL8MvoXZ/wUSBP5YopC33rwSDzxHb0jPcwzPbpeTP2+Ak4qKTwF5mU
         xcJePyiSAPYzB1HYz8gKfX27ockvPQXDqWU5FNnmsrC7bcG3mRFbxjxgnyspqroDWio+
         YuH/rz0nplvUQJFt6Ew6epq/Ww7YtIthgD9LMx/pXqAlL6JVB8NR7NUbcYgu92bX+hwd
         IhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779046015; x=1779650815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzbLbrBxTj3Os65r+VG8KyOSku+VVjAs9NkmdJFxbWQ=;
        b=OssT51JuAEBv9VNt7FuA9Klg60NtPyxI5fPbV+GgCPVaU/5zyxQUYd1A5OW6gJ13Fs
         3tjNct1x+R3e9C9NCv4hU+u+K3XrQ6mwQ/6ljBR1l9yzWGMKqhPyGj3Fg2C0gYeP+f6j
         hH3yKT4HuOVFlRdVKpu0miUajydg8Db9Q7/HsqiweC+hdtHNH6vkoG5ZeB+JtlLt+Sgh
         fbQrdHF1/o8PNsq0s+idkdyHIWnUsXK1f5XEt1FHzx6QoCwSn7Ls6NvMKXiu/mMqyroD
         HzgVVt51BZ196emF+GlLlxfixUD1C7aCh2plKY5j40W+/WxLhQ4hbWIlG2OkUKOawrIx
         flRg==
X-Forwarded-Encrypted: i=1; AFNElJ9T5KardfHMMy/oISeXGEAR68CBdc74h9S9gsfgjXdHug7GHmhuW5vCeURJBPvCscR37Z9zRg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywke3fgtPjI9a9c94GSBU3VVK8qLkmvj+zGOC0DJn5tQU1GHYxB
	yrjmUVsmVi8Y6wSfQDQaQN7ir2NRLyme+U+Bl1wyQIiVDL5CDL3BQu2SKIQaVc+JAU0=
X-Gm-Gg: Acq92OFupjPZ66yz8qNkTDAa9xNAK3wg/7oFm+b6wk6CN9kzZ+NAsFstYK1QHqx3t3b
	KrywZQ5pcMGLSn06hfgdGKig0VsC/xI2LQxhmJFxni7Oi+cVtjZae6g4vcxnPAT98LU4HFh3Ikm
	dxiqdt2KdKN25xADOpwBH7mtPOz6lY37w34KFeKb90o4qCiZUhyqL2khnJ8Z8+lcmKYHST/4yts
	AtCmoGruF+QoUfzrtl+Rikmn10ET6ZF9QonuYpLDRRxtY37PdAxunMWphda6WXDpWMwo3Q4xV9+
	Og5072Mm63CWVRBNdr37C73qqTdTd6Rln4cnV9trTfF40wo1vy+uqUWz65qAvf1/bad/ofA+gGu
	MLo2o5EuPgobgCHj/Jpzji62Z6PEyS+y1G/gGUcYONk0GyK+49uHugN2MTCuPVEtR1BQ+0B9CVV
	T5L3IaQPt0eimiIBHnG4hupCbZ/lyvGkKIuLJlh9U4aBoVCFA+WQE=
X-Received: by 2002:a05:622a:211:b0:50b:2542:e16f with SMTP id d75a77b69052e-516597f0c9cmr161422881cf.15.1779046015040;
        Sun, 17 May 2026 12:26:55 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d5c4dsm108828621cf.12.2026.05.17.12.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:26:54 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	liaoyuanhong@vivo.com,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v4 1/5] liveupdate: skip serialization for context-preserving kexec
Date: Sun, 17 May 2026 19:26:46 +0000
Message-ID: <20260517192650.1019314-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
References: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_122656_170868_64C9E52A 
X-CRM114-Status: UNSURE (   9.18  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

A preserve_context kexec returns to the current kernel, which is
unrelated to live update where the state is passed to the next kernel.
Skip liveupdate_reboot() in this case to avoid serialization and prevent
sessions from being left in a frozen state upon return.

Fixes: db8bed8082dc ("kexec: call liveupdate_reboot() before kexec")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a43d2da0fe3e..dc770b9a6d05 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1146,9 +1146,11 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
-	error = liveupdate_reboot();
-	if (error)
-		goto Unlock;
+	if (!kexec_image->preserve_context) {
+		error = liveupdate_reboot();
+		if (error)
+			goto Unlock;
+	}
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-- 
2.53.0


