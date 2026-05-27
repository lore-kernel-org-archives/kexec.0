Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFECCD6E43
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 20:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/XM3jS+J1liNewPoraeZEXRi0gsjZOZDbQIQgPIvPA=; b=4FALmS/XgUWVP2PM6PD7fBWUWg
	i2zZtJG5ULk1BtrlX17r456w0wC9bhyybB5oaGvPBee0//WnAjpQCULB6XnpKIbmFJF7OYcwILVzo
	mjIB4NK027U8B0Vz0oMETfVasYpb+GOUcZhMbZM+2ex6Y4U/g0zGFnmGd7G1Qp1bJ+B2afpPfJrdG
	a4nodouYoZKuSOq9I8v1Mj8NOePcZWUnelSP3zWGaD353vID+P/WdNzgkSA+Je6s+iKpWbHHl3d9C
	hyqoKdeiJQkNqFk0PE2Y4Zk+OWXsLwvxy9CUcVhHYu84M5USApJ6SmbxeZYQo0iqvbZugJXJAMRAs
	HZYJfKKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqx-00000004ibK-0aIP;
	Wed, 27 May 2026 20:27:47 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqu-00000004iZM-48qg
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 20:27:46 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-50faeb8317bso109584561cf.2
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779913663; x=1780518463; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/XM3jS+J1liNewPoraeZEXRi0gsjZOZDbQIQgPIvPA=;
        b=O7dmnqzCDBJD6aw3s2FPUyid3m+wTwjIcVJVrZHqb3wOAo7z9aJMGg4rE3atTahLQ/
         Cfb9lEP/iJu5tfnSKexa+klLPTRQW/PVEO/dLxNgceb9zmGfSczW3NH73EkWy9AOVlJE
         7jdAwdrOaWCdlhEccSCi8nr6prE1mwDWJWD3J0u3PXAzRB/5pZ55J7Z7e+st0/UU2Mqc
         2z1baX/qWYTELUCMY+m26rCZJ52PY9BHqJmkdhmASi86DMB4m5UVqKqR+LI7DIVSsitB
         gR61xeLF9Kb9aPRWI0R1xGlgS1Mo1ZgIA8QpIJUAwo31ol/7BkD2YZXn+tBYCxh49pPi
         XzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913663; x=1780518463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/XM3jS+J1liNewPoraeZEXRi0gsjZOZDbQIQgPIvPA=;
        b=p/xvGTu6gOy69diw+c0LllH9poxHVTkGqo0Ejtg46WRS4KXY6OysWpHxc5YLvsYrIi
         3+SEF1vuJ46lBeXj7ZoyEE/67h2Hmyx25jhWFfHFuQHGWO6g5vuSbGcrGlo1ZfUTNiLP
         96FnWPZFswRFdJ1IyVKXGeSxMk4ZSv6tO5XS796u+DzPXQOACi7SsHLJV1eL2YSGqQ5P
         s590ht5Nt3z0KV2kjQC62V+u1oBrB/ncqDgFBpRfdqCQPDbfOkmuAp8hy9g8B8KPfSPW
         ZSzaSMlzGYiCjiDOzlI0A18qDezABDs8xgPai0I52OS+77lIbgKSY6nlKFlGJTZ27JtY
         Ybyg==
X-Forwarded-Encrypted: i=1; AFNElJ/Bdg62W/lDtTiNzMeX5UYK7qAb29xuBZx27bbCbS2Kjd1St78erRUDoUJkBsId7AEOpGCsLg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwidkAleFOj9487M9tqwUfhbgGtigMoeOL0+Z6yyK0JpxmxZXHB
	+Cn48CKxq6DNjipKkCczfvXSwaxpygEsqWJFBLHRf/kEXHGMc595mAnIVEVvBUkKUkk=
X-Gm-Gg: Acq92OEmkHT7Bym/2/g1EZLvkFJ2gykjP5paO7e86wpA6PCnYYFEB3lOGXSPFWjCCY0
	UVnjMozikrD6vroLAfnYcabPdNNWvL+0UtooW6l8jS3Hp0w4ByBY7IU7LzLsvgQeRDgBDJbLhQv
	Git97JsFYj+96Nty+KIWXqQUCB8Dz4l1gvWcYRVcrFMflHQUSvZRehOwYDJGc257A061C5Hw++R
	juGFiLy6oCrr/kHVa/JJpvuAcwD5wxqg0gYJXFvkcNS9M/rSkTkY/TIBr72ZewDA84+KrlHUbc5
	JfEOM02OLNGEcPZ0ATY6OAwzCeKV+fUGiS4+U5ynd0vjAwDjUcwcHU57tWKJ3MojO3TATa48kwa
	djElLJA6BMTe2forXwWrzXneFgw1dQYbqZywnlLZyUI2Ggs0Q/f9jc3dxVmktHtBIADey+WiKwj
	PBq/GWpHlA6Qh5W8wETZYw8ROkgMcgATR8TTDtUvt12mDZ1/QUlcp9F0yarJ2LbQ==
X-Received: by 2002:ac8:5f46:0:b0:516:ed02:c85f with SMTP id d75a77b69052e-516ed02d766mr217487011cf.9.1779913663594;
        Wed, 27 May 2026 13:27:43 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069ecb93sm58632971cf.4.2026.05.27.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:27:42 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	error27@gmail.com,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v6 2/5] liveupdate: fix TOCTOU race in luo_session_retrieve()
Date: Wed, 27 May 2026 20:27:34 +0000
Message-ID: <20260527202737.1345192-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
References: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_132745_030516_B3A4B703 
X-CRM114-Status: GOOD (  10.49  )
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
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 74c39d93d45a..169131642939 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -443,12 +443,11 @@ int luo_session_retrieve(const char *name, struct file **filep)
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


