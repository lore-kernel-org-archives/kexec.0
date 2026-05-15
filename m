Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E58CD4F41
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 00:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IKtBgAtgrIMWIdboSAO5ZG30EAh7PtBJ6wDWGXdz9Wo=; b=OZ300ee9zi+rHe98CYdB4zEZOH
	WoWutS6N3/T1uU0mAIRFGo9h9vQ7kRSmtPcvwnaabjzlTEw76ZHadrrrj9gayVo0xXZkMHYZEq0eg
	sqboYl3dGiRgkw+gQPIWk58oQFQ8tw1gadORdeMKQZe6p6tgOwgq3lpFX3AcwuBVNC6hh7d11pXvB
	aNrJNJ0AjtURHjEe9G7a4kCn7fd2OzlvRgRax/KjxanNmeveZna4+wwaWZTCj+j6vdLbkRR6TeFrp
	WWI4kDEte3keC27Gc0V8BZQTwcKmHrDUc6OJg2QoYODiEkFaRLBunVDghejwRKh+JipgqJfLSRrHH
	S12JQR7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYY-00000006vqY-2vEk;
	Fri, 15 May 2026 00:37:34 +0000
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYW-00000006vnn-1Vuw
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 00:37:33 +0000
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-90d13fa59e8so400524585a.2
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 17:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778805451; x=1779410251; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKtBgAtgrIMWIdboSAO5ZG30EAh7PtBJ6wDWGXdz9Wo=;
        b=f5oCjC4DF4x7EB0oFY4r4rG/rS2x+yLAl7eyNMU9mGaxyRiUh5Bt5tzeLIaAdB55Pc
         EhkKIZb6fXVmQ1zwDrPcwSCbblJSX0lD4l8GtOH0vCOWXQtV/4oJrJxiqh2aDsEXSJlQ
         go0vJVceju7pgkCNrey9ZanlyHfBDkx1TJ5cyUft+VnImbBmxnfVqFlsSqzScpI4OBC6
         X0acgEq/tZQ1YRHlLAYdWEMc6P/9Y7b8KErfRirZPNKVF35sovmTJV6lAjAsoA62IBB1
         rGMmK9hkUX4F8dkeWK0/DirHqPgcegXBWLPuT2jdE5Eg/AHicIhnl+YWb5D+C6iUeG/L
         J32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805451; x=1779410251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IKtBgAtgrIMWIdboSAO5ZG30EAh7PtBJ6wDWGXdz9Wo=;
        b=BGfi+3Wlx5O7EnCxK6C0VVlYx4QK9+ilYYemy8zFBaWJw6XMoIf7LFZPaMRQVCJqYO
         gK5lKRbZJ+loZrhV3M/vwdDeNwtE4VHJhIvNi849fxo3GfLTzgup2Z8vXCkdWW7GR1Wj
         7X2VJU27/laOAMQgU8yjjYFXbVaanDpIinwjq0p4xVQqtkf8Cmfhjwh5wSkOlUOb4Th6
         I3tTUcxUqMToD6qe3XEMzDx9FzyvzoaZMgOU1PSHukqdXqR8PYzU8tSPiFZ1rW7lC0pa
         oOTGqydmRUugWUTJ41ldapAJgwkx3FIdYe4cryAuXhsXeAQ911FF26FuG7pVnZv0np2T
         V5lw==
X-Forwarded-Encrypted: i=1; AFNElJ+iwph5GzQAjTTx5YbbeNVDJuW6YlMCw/t51srlY98L80H+Gepyn6BWnoaHe6tNLna+eHuUuA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyF5aX4rEGgPLIXyiLnCZJ5r/0Icn36mFu1PeZKp0hEUxtKwDXT
	1mTkhUAQHyYrzP4lWqWlWhlTkgNb1d1lmA/DAIDGXqniuAW+GgP+Cj8xHbsIaPfSZkqjckZ9zie
	T2rG4USg=
X-Gm-Gg: Acq92OEgVaIsNKsQicARRiaPZ7QJ5j/HmVNci8nDhOZ7mAZNKVbiWAckFPbo2PLoYC3
	Ktxp+ci4l3OR0iH5pu6amioq/8Nvs03y8Vj5zAgqAjOH8KmO0aASBTr5lYj/ztUikd/Ozz4yKZI
	Pu37ePoAcx+a53CzDRD8sF96VtaXCD6JBz4O0JYdZrk1De3q8nhbWgjxSmXFtY1WcdpfXj1XoJ5
	1Rs+2gMphzgtNKaF4pjd9+XNc78l8rjYDNWQ465IMQhMOumWrNZ7nhqIxQ/Oj8jjas8GVIaQvw0
	pmfXS4bkevDZpfh6Hu9gYbsd6JXR74juVCOuYdSqRnBTG20aDeS+UZ8/s90A9qth1doDPtS47d6
	hlXQ4bGklAq4C5LpB6IMSUrYZRqDsoS/Uisk4D5W3z4KbidA2sm7wsVlFeUad092iEfH8nC34s7
	QZ0gh2KeOaOvvMzfxwaKwt5GkOvifL4vrVQ8S1DZcPcXDQXpSt8Cw=
X-Received: by 2002:a05:620a:319f:b0:8f5:5630:cabe with SMTP id af79cd13be357-911ce812018mr342401785a.36.1778805450965;
        Thu, 14 May 2026 17:37:30 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c16366csm36918236d6.40.2026.05.14.17.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:37:29 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kees@kernel.org,
	rppt@kernel.org,
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
Subject: [PATCH v3 4/5] liveupdate: fix TOCTOU race in luo_session_retrieve()
Date: Fri, 15 May 2026 00:37:21 +0000
Message-ID: <20260515003722.938123-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515003722.938123-1-pasha.tatashin@soleen.com>
References: <20260515003722.938123-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_173732_403345_4079C7E6 
X-CRM114-Status: UNSURE (   9.65  )
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
index 5aa0011d9643..f99a82517e51 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -426,12 +426,11 @@ int luo_session_retrieve(const char *name, struct file **filep)
 	int err;
 
 	guard(rwsem_read)(&luo_session_serialize_rwsem);
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


