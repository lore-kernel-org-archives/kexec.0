Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065F0CD4F51
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 19:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4LnA2m0HBgYoRoNlBSHl4zr1o2yEpdKjWvd1WzFSz2c=; b=NgYchRPYp4X56qvJrV96Ojjefe
	bqmFrT+iKt/mGrhWLIJHXs6/a0CAoGmXo9C0HQlnFeblKNdLovoZtZ0EMADFSnww+vE3NYjTnpIM8
	OQxer4CWgh3W2Am1o26G1onY515M81UF2YUw39rI8eT2d6qlNcQ0vVtJ6wU5E6oFFhicyrgZYM1JA
	DWOKgu8ALh2799tnVxxb4vEp8IDNSO+Un5ezW8Cp1DRs0HJFRPCs+YInkBk7CDFojZBa+1NYmfuFt
	D3LhCIN5vGQRP4lHTHxP0wSa2AVcSVtu7T4eGToE2VYrD1MZbYwJc9V3JvGjdguf0r3RTF204Hxcm
	Vj/N/MvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8d-0000000DKRG-3yVO;
	Sun, 17 May 2026 19:26:59 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8b-0000000DKP8-2D1A
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 19:26:58 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-51306c9f2e1so22986711cf.0
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779046016; x=1779650816; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LnA2m0HBgYoRoNlBSHl4zr1o2yEpdKjWvd1WzFSz2c=;
        b=bgJF6vS8QYnBUwwxmkZwWd1CBpbb3K5T95JOTcqrS0LK/bP/ECDMCrP2NvjP3X0U3X
         oZKSaHsOMJG3s86WbrOAYJtigIoXrxHd479I5EUJMxtINogUhBh6iccMk3pBqq0TsfQE
         +IyjdtCsiIs2QUGyWiu4WAdfVNJm4lZt1Mj0Quvncy0VQLw0WwPo/CGjbrdNNxFRAEh3
         bMpWrJVDA5RLoQUhpUndM3kpUWYEC6THfB6j/sdNR2BxBlcOOatTiro0oFBuuzLjnARw
         2aJx0AAH5SRX1DBvXG9nTqXhZJdcRDPwrLyvbB5i5JZ4QOAvBGMF1GQfc71X5p9ASDZi
         6yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779046016; x=1779650816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4LnA2m0HBgYoRoNlBSHl4zr1o2yEpdKjWvd1WzFSz2c=;
        b=Qyq1aE62pBCp8buZRzcfo52u5fNNWs6pt+pBAYh3nMbfW8utjc6+akNSHC+TiW6T1x
         uTPcn8U+GXJurh3hqTmJrIqvQ2YuK+t+hJokaflvUY6DNRUb0SNqqSOSjseXYW2el/XD
         2N5A3nsbXNFcPnAlq+19P18vuNB7ZOYRibVJyzQLj86u4S1umerGzNiYkItLYohB0cGQ
         1o5KIhKE4Goz24cdocDN+1shBfvXAe2zPhWrHleQJu6Nx0ZBevSgYMOjLm49eBQ2TcM8
         oYdqgXOLlQEQGSH8RVA4LyQvn21QeSXfDNF6SeU9MnIw40QnON82RonF1xlbb8BpBy+1
         yH7g==
X-Forwarded-Encrypted: i=1; AFNElJ+x+7NO24tTibepogkn8Rdvn4KdysmTLpGRiOTF7CXDGd5Qkb6cC1pFuS5OobQFXAINbqtJeg==@lists.infradead.org
X-Gm-Message-State: AOJu0YypoIiPDndMKGG+kzJkKiBEgsMA+pj2yJmoC7WLBFOoAJyz/Fi5
	rOJhA/zaKvEern5m+ko20XAfkS+EwmXZupN2V91yISLAU900PLRuhkohF5u67EO5u2o=
X-Gm-Gg: Acq92OG4KJ5LNw47LnPK1lraVZqI7Mf8P+WC+fc/DvkV+xp2RwvO+ylg1MH6+8rfsj7
	4Vuy84fX3wC2YFbwlmNvw/vmdnGkV0MIeejJrzBi2GG2wUutw6Cfwj1psIgOtGMqjgl9XRT//QY
	aCNfumMGCtBy1zrbDYnNEm6dMOQZnZRPVbG8/seHejZLAfkaRrl93kluAJ4eCVoipd/I0IUk5nc
	y+iqRawDwhheo1Y4+e9WpK9wNZR9wU7jz/kmK7aDdz+03KILKSDj5bWq0fFCcmabv1+hBsWMsu4
	81k4YI5Frt1/E6cPpdJBbxMRtL8Kk2WvxAYjwed/QI5FlHW+bnQHV1wvTWMJMxpXFcGV1OTNdxP
	UBmIYQQcBymtF4ZTQMpPRqytItMyu4CQO4MV4/n3BvPg0BPD2TS932Kb9g5f7lZy/wHyi5gX9BX
	f/l18J6JPNYUGpojPE5Loqbykaeo/Qrmj6vqHFHqvY3uakwz7Wa0IHVz4DE2TX1A==
X-Received: by 2002:a05:622a:4a0f:b0:50d:8009:2b3d with SMTP id d75a77b69052e-5165a03ad85mr178171821cf.13.1779046016534;
        Sun, 17 May 2026 12:26:56 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d5c4dsm108828621cf.12.2026.05.17.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:26:55 -0700 (PDT)
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
Subject: [PATCH v4 2/5] liveupdate: fix TOCTOU race in luo_session_retrieve()
Date: Sun, 17 May 2026 19:26:47 +0000
Message-ID: <20260517192650.1019314-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
References: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_122657_564735_8ED88894 
X-CRM114-Status: UNSURE (   9.81  )
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

Extend the scope of the rwsem_read lock in luo_session_retrieve() to
overlap with the acquisition of the session mutex. This prevents a
concurrent thread from releasing and freeing the session between the
lookup and the mutex lock.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3327a28fc1f..59b37d17db6b 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -415,12 +415,11 @@ int luo_session_retrieve(const char *name, struct file **filep)
 	struct luo_session *it;
 	int err;
 
-	scoped_guard(rwsem_read, &sh->rwsem) {
-		list_for_each_entry(it, &sh->list, list) {
-			if (!strncmp(it->name, name, sizeof(it->name))) {
-				session = it;
-				break;
-			}
+	guard(rwsem_read)(&sh->rwsem);
+	list_for_each_entry(it, &sh->list, list) {
+		if (!strncmp(it->name, name, sizeof(it->name))) {
+			session = it;
+			break;
 		}
 	}
 
-- 
2.53.0


