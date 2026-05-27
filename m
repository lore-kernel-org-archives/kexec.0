Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A81CD5BD0
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 20:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5gjpcJOSlaxgR0u1Wf2qLG73MMh7gIWFnRjw8KOPySU=; b=1HJ2VLT0fJYkPwBj4c2XEktbVe
	hclUNIQ6q6tTqkrntFdgKfrgTcuYkFOzJutHiHEwss5x5sfFcVXSpZbz8Z4xjCn/8NlaHHU9aEMUD
	2ol5mzaJRayAOHHVqMfNeIzNfsXLHrrk6m+gpRj4LzmJCXyKwuXA/n7o8Wtpnc6u8I6CVX/ci10x5
	5K9n9e6Uah/PlLkEnFEnI9ptohUl5/rdSqP92CFeGmMFms4/PFGBgf8OH3UYdUUy5RRWjNQI6rFfL
	7zuhpG8WmzQTsKqE5pUaAkrrkwGuwP1EtL1Ox8R2u0oUq2tPsKxSuwj47gNh2DhYX0/ZhMZZkA61S
	JwBZ0+cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKr2-00000004ifR-3Hr8;
	Wed, 27 May 2026 20:27:52 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqy-00000004icR-3vWF
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 20:27:50 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-50e614fdb42so94197331cf.3
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779913667; x=1780518467; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gjpcJOSlaxgR0u1Wf2qLG73MMh7gIWFnRjw8KOPySU=;
        b=D/Bqem7ZgYMOaNnsr0VrcsJqxU4EPGjw2dtnw/EhjSkvGr1+97DKbRFgZ4F1VcIVZc
         jTpHkrEX3B3VA07YxdC6JD88tSzpEuGpvZt3e2+LHqNgMdfK9d6FSIrNgH9DFsw7sSLB
         bZEXMTwmCDCcq24luZuoiD9ZFiyu3zjCOdEckEW5RSHKwK2nIQM6TjahzfdsqMWuBp69
         Ex+vMJERZamdvR/xnTlqaouJriKDTY/RGUDzHNTYUq0Y4g1Uru7XgmjSRoIP3jnymZsV
         ro1Pg3RxBK1yHFQDZkKUY3k1hIKzkhPFn4UWvjY7bwgokAyGdPY1xthzxHfvyKk+Lox2
         4X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913667; x=1780518467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5gjpcJOSlaxgR0u1Wf2qLG73MMh7gIWFnRjw8KOPySU=;
        b=J752Y6xkYlBWGXr0NAkxb6OtFHBXjYNDkjTxUjddklE5ZRcDSTafSOGAK9XqK9DkNX
         gE9jEJg3wI9mlu2vjv81bOXqXSborE5wzAtdZkwYm1uRsila67ZTP596KWSCX3YnFZx4
         8piKNxsJCdpsnJ50xCF8kqSt9xN/pE+sxXZniQZfVsxhd1AWiDvQxsQlsn4Y/n3O210b
         9dlgnF/XpSDkpG1lRfDe61nOA5nTDZXcGtPdUGexjs0b8PIKnsFcSE0e792HDM40zV2X
         ecTCAyT9QTBzD7FykYwc9yKDRO6ZutoqRV87wLwFcRgM1ZSsZ+r80/PfEwNo6UrDvm+z
         VjoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tNBEMs86xy+dIgneRnKoY7ESlkaJquSV9DDWqAK99AYZq6KZ/YxrrPFiqdw1AyCSSFpUcUQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzbyrHcoQTPLFoTdj32conAFmLJ6PgGm8vmjp8eT7HdMddbpM5b
	gwyzVhYYFZlAjsz9FGkffpW3DHUzvbC42P13K/+iglWXIj/+GG2yVBMc2VYz5a6Rdcw=
X-Gm-Gg: Acq92OGDcYVfCkoiF3zkYqrlq1X8+zsqBGurM7KRC8WOjIAbdgdm9XkZgTw/jnvvR+Y
	aQJQJh4UnO+RWjSqtNLIFdb4RMweGZX/w9Fbcec4IXeuTOB9GTiMSIcN67qBXZtjNpc0FaM0WpU
	KhoUj3ta8l9v5m54q7hd2gnMSBsmTDSGzpkwNgoB5I6IYU/+UouyTB4LhT+ieqvjNPfMZS28uc+
	szfxtSGKAHXnwdLQeo8Sf2dw0UMh+WyAsUi6bssTzLvDFm44Ff0iyNgF/Al6y1WcL1aZHIzKISI
	bqUgrnJzyp5qdZtXiUoMit6+LAB2DAy3a0z07MZ6mZvk030YCaiWBBsy9J2sfybKbfu3/+DfWcQ
	EULEc5uBuMycmrmPwVZ0DjyxJfOfF0f+lD52LC5r+vIpFrBwcRu3x10HZDXX7gSMJyKveo/MzWa
	ut/9VHfX851YfGmia7qT7YI7gDpnqdl/981CVxJkrbTWyZts+YcPbBm7tomZFE8Q==
X-Received: by 2002:a05:622a:260f:b0:50b:4a84:aa94 with SMTP id d75a77b69052e-516d42ee019mr344407121cf.7.1779913667409;
        Wed, 27 May 2026 13:27:47 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069ecb93sm58632971cf.4.2026.05.27.13.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:27:46 -0700 (PDT)
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
Subject: [PATCH v6 5/5] liveupdate: Remove unused ser field from struct luo_session
Date: Wed, 27 May 2026 20:27:37 +0000
Message-ID: <20260527202737.1345192-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
References: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_132748_984825_3C193E4D 
X-CRM114-Status: GOOD (  11.34  )
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

The ser field in struct luo_session was intended to point to the
serialized data for a session, but it was never actually utilized in the
implementation. All serialization and deserialization logic consistently
uses the pointers maintained in struct luo_session_header.

Remove the dead field to clean up the structure.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 875844d7a41d..dd53d4a7277e 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -59,7 +59,6 @@ struct luo_file_set {
  * struct luo_session - Represents an active or incoming Live Update session.
  * @name:       A unique name for this session, used for identification and
  *              retrieval.
- * @ser:        Pointer to the serialized data for this session.
  * @list:       A list_head member used to link this session into a global list
  *              of either outgoing (to be preserved) or incoming (restored from
  *              previous kernel) sessions.
@@ -70,7 +69,6 @@ struct luo_file_set {
  */
 struct luo_session {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
-	struct luo_session_ser *ser;
 	struct list_head list;
 	bool retrieved;
 	struct luo_file_set file_set;
-- 
2.53.0


