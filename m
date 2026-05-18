Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93402CD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HTwV3krVMC166ptArXz7vUwnLCTb4D391nKOdGZOpkw=; b=N9qvhydCV6eerfKHo3OLQAJpM8
	TOfCLDEqQ6bO3uFz9ndAn1y6R3e1yFuJ4Qu+A03EtlP2JJ3x7vswOLqC2Dd46v/RoJD9y7OVDA2O/
	Hlv3zdS0oGtNOjjbc1awDShpgbEwXAIramx8XNOTNDIDhZK9nsV8a9WQnVzkint3s37uvn+en+TN0
	7xSHMsno9a9UEGctPRCU1kdjDJ/xEc4vRzzpndtb8QO2ZMgWvX6H4S0LvzzyMaq/fijv3zflZ0ezS
	eHjYORIyNcBNIPCcB3o5V+GV+0O9PiQX+1Ihs/cnsDOiLYTAvHeYxJMPaBrvhoWX08r0xhTX0wpsz
	vVYgqPPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUy-0000000FiJ0-2OQC;
	Mon, 18 May 2026 12:55:08 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUv-0000000FiGO-41er
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 12:55:07 +0000
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso30064246d6.0
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779108905; x=1779713705; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTwV3krVMC166ptArXz7vUwnLCTb4D391nKOdGZOpkw=;
        b=jhm5QOUKjxjNK+QtkWgdFnU9fYqr4dBPNifKW8wWUR6NFsvLN0bCN+3rDNjDyOebcz
         869xWGgqhIE8ra8MkVjcr1+XsHdpcBxzG5acidzflYn4jTZscukwDUr3x6yGcNZA68QK
         Gnqmv9bSeXw4tUlf5aE1u2+i49WfK6bXm71Pn8oa/koz0chsoTM0kPZDjXeJQxWIBsrJ
         5ztTTH4lKgAr0ust8GGIN1FY7ivHrgFS8fC2yEySPN1JpzUfPtq23Ve5lyfxeuLs/BqN
         DECStTNYUn2bb86i5sV1MOmQdpCbLo8QrNn1+DnELs943YIU2nitzspkhWIOjCrx/562
         mIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108905; x=1779713705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HTwV3krVMC166ptArXz7vUwnLCTb4D391nKOdGZOpkw=;
        b=Dnx8Buc8LDZAO2pSmIRzcSdShp6NoBqvXVLBNX1edOrtYO5zouvGENgdI+3KieJo55
         sqx7+o3Q5kqbOAjb8iEWWrIbwpPF03jMC1Cp/zJfOc5M38glWrYJGjBXT0Z25mQCx6k+
         ioOqVSJYpU3YR4qlKt9wrqE6OZXpuy+rMUobs0abopfaHQgMy5ZKRnl8jOXJIERYfOsf
         mAagQroNslKyMBwS3SY/uaWn4NFJ9N7RCv2eqhcCvWtG8pOpBYZm6J3nHafiaAMDQyYX
         GtudHfbVUI6KbnnAPZE0Dj7lB5tWcErDz8hV9K4CPq8EOi8pBeqOTS0A20oSyqSWqfcj
         jptw==
X-Forwarded-Encrypted: i=1; AFNElJ+kQI4U6lmlEYLRSEgNU6sSMSw30KkjqOhvqGs0HpeIs3b1J64FVqWzEec2tdR2bn04f086mA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRMA9OfTPEJ8NwasEQrr/DF+jDiaIq4yEkbmWdUHz4z/QgRpxH
	8bsqo9pD5cCikpyMLyBFJdDZfeanUQJRGOyh87DIQvZ+DhoyK/OhqEORWB1QSm0bpww=
X-Gm-Gg: Acq92OEJj7Eho2ge6nuOqy9X0vglQHvjMwaVk9kLgR3cJbBbK5Sj1kQ9VLzINYm1XBu
	9uqONZYzjRjyEDkDhiSIHOdFUoBm6CQf8m4hPmu94wl2SJbK/8IAQdGiyW/P51QujhWA/+41Q5r
	IANlczvohzqiRjPjlYPCL2Y22PqGyLwzNq2cQrMzI+T0jlFcpId7RsdphrtApXbfWj+qng4LaJt
	9EFMUYEc11rYGvZTU+da87u0TLvUfoI4ENEMAV0UwZPnB765e9muGpCeVUgEheq2rwJ+FbW28w0
	UReA9Z2NAFHWsXILpxSAvV7VtrglppcSPwk8EtCr2M0wizIYW1xOheQnc76LKwvJJqCNILzpmGh
	fwwjXf7+qmeHp/otkpSebo7+mcxcIXFA9NZS3jExSydZO3Uw/Bo+hLMEDuWtaKK9VMeYS11oR1W
	JKiNdc8Y5OmA4Dz+lxvHa7uS1lQV5i3vs08bJ6tIsWmpQz+aHJbl4=
X-Received: by 2002:a05:6214:da1:b0:8ba:b3b3:971 with SMTP id 6a1803df08f44-8ca0f687df2mr251833076d6.32.1779108904519;
        Mon, 18 May 2026 05:55:04 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3608c1desm54511756d6.2.2026.05.18.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:55:03 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v5 2/5] liveupdate: fix TOCTOU race in luo_session_retrieve()
Date: Mon, 18 May 2026 12:54:56 +0000
Message-ID: <20260518125459.1092373-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_055506_049280_046F5BA7 
X-CRM114-Status: GOOD (  10.27  )
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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


