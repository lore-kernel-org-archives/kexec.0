Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007FCCD3424
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rg6/BjuyUXCcpPF5+z/gged95vUIgjLnAi+C6UXeFxk=; b=4B5en+61xTLXeZqYFymishZCEK
	ko5mXuQO0Cvy5qtgg0+RSKfMQ+xhgo2jifsdGfXhAv9dydRAfHPMKWG6mZPjnuR4XOIHvPr4arBPi
	+qioffLkItfVD6vEBxYVIiXmogsHZIW8X6I1AGdHWGLwh8JwbzRbEJm/FrW+LsF8ZPF6LtjoOx4Jr
	2L8mUmAI/mrbNEstpk7Fnrt+5nzr4o1KgzUzsMbYip6oHzNdc5jHUBxXpJ8moIk6a6OaQ/4V3XpJb
	ePdPU96fZ4M94HW8U6Y2vLSajT8VzYAb/4sH2nzKdZCIuDwiU9ayrM33hmJKhM2xeVWfJAH910A9w
	GFnEhLvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkVG-00000006Yl5-21wD;
	Fri, 01 May 2026 09:49:46 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkVE-00000006Yjy-1AbY
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 09:49:45 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so865616b3a.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777628983; x=1778233783; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg6/BjuyUXCcpPF5+z/gged95vUIgjLnAi+C6UXeFxk=;
        b=jHN3JQao/X8fpe4rtlzu/MLR1lblwkuhaPUNLYhSy0+NnIc2vnQudPIsPM9me7koSN
         oAYP/2XUr2G4M7Laup7fg7J4N+VAVhp7uer6hg+ck564vPbyvm/gLNoccVeGyuxx7Mwk
         ZMlZCRVEwb4Z4c2zMvzPv8255DavTkraZbJyLe6BsbBp1UN9jHqGa8OHDoj21xoUWgF4
         loUkkTtlD8Cxaim8UFrU63B7zX0Yugj6wg8SONUJTlz8GHmT8fwwUyfFjK2UHKR3b6eZ
         6XfAPsefbVAdjaLNXVkUfGFYtW2gJk4IVeSmCUfzFGFoYPFEk1JKomE264JnY11kc9Om
         RrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777628983; x=1778233783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rg6/BjuyUXCcpPF5+z/gged95vUIgjLnAi+C6UXeFxk=;
        b=LVoE/9cKBafJS+gox9jASXJB+DxyGfev+3Kfccl3eR7EwUnpkMIA5p78zcxVxlgk7M
         Z6sR747ZL5vvOW9bCXJunFEXPRQUbw3gCCXkdYll9DYfZeAlTUf9GrHURhWgSzjGwPSL
         MAsRNhVL74EPbDToe+ZJ6jkdLm+VIQEu+qF32C256dZNh9AKsr0n37Hc5WM+n89c2sCv
         J1pGce4H0HOZn+Oj7T5FQBM0D/BHLz6/hHkvgJGoldLtpEwXUBOTeOcztWkimqEw4Ila
         jsmVyq1HvX9QhRgZ3/3ZuntHYaepY4139rp+YpyrdjGSz/yJPNfYBJ8QjJcjD2yiH/+N
         Rrhg==
X-Forwarded-Encrypted: i=1; AFNElJ8yvbv3aLLoYanEMGsTHHcck0ZpU20WmYT426qAEVq2UuK0JrU/P0djtcNWJG9UkSqwrfr7/Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwrNHJ8WtADOxU0oUIoVkEriyQw/PsXcZn4uF1sRinuHRPpS4Vy
	FQo9lEbHaBQwMTqj80Tli3kTsW5aAhDR/hG4xwAeq5jpbuYyjtpFMjjs
X-Gm-Gg: AeBDiesiFfVcqf4boSkZ4EzhR2GuWgYdGW9wd99nY0X+hU/Eog7ai3uDI/+8s6Zu6kc
	Ro/NhEuT9ZtyGC5cf9rQMtXUqZB+4LsKrEpnLS0chKUxQH9dt9vEw02E67uoFWfK6zTFSvKYFF+
	reEpZXI8+sKZKKRJygY7btI1GoSDxhhdkIDN9V3oO53+BPfln+H0YgCux5rTvxmb6ZorW0ZaShO
	lY8BLBYuTErX+rgNOcNEJ2DaR1Gv/rhMDDwkzdSo3Z7HabhSrmfnnGHfFtEaUB6hqAgOkEv0m6Z
	nxK56L2AfEPxOQcaVZK1++9uo6gPhElclBqwVpE1AIkBRpSDdKr/3kLkEh9fxKuFNmmis4ojhJ/
	T+OthxD2WYZR3LxpUOHe/DZWrgZndWsUC/Wehaae3uVC1c1ADhKqqopQCm9DqJNYqILIgOVcyfc
	0MhIuaXW6p2HT0UuhvRmok8hWif+uwM4BgAoI/DQ==
X-Received: by 2002:a05:6a00:a253:b0:82f:776f:a78d with SMTP id d2e1a72fcca58-8351a344c46mr2584281b3a.19.1777628983321;
        Fri, 01 May 2026 02:49:43 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:eebe:247e:613c:24d7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582dd55sm2042729b3a.1.2026.05.01.02.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:49:42 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 4/5] liveupdate: validate restored LUO file-set metadata
Date: Fri,  1 May 2026 17:46:36 +0800
Message-ID: <20260501094637.38650-5-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_024944_319485_54D9EE55 
X-CRM114-Status: UNSURE (   9.96  )
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

Signed-off-by: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
---
 kernel/liveupdate/luo_file.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a0a419085e28..cde43d822f8f 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -783,11 +783,21 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	struct luo_file_ser *file_ser;
 	u64 i;
 
-	if (!file_set_ser->files) {
-		WARN_ON(file_set_ser->count);
+	if (!file_set_ser->count) {
+		if (file_set_ser->files)
+			return -EINVAL;
 		return 0;
 	}
 
+	if (file_set_ser->count > LUO_FILE_MAX)
+		return -EINVAL;
+
+	if (!file_set_ser->files)
+		return -EINVAL;
+
+	if (!kho_is_preserved(file_set_ser->files, LUO_FILE_PGCNT))
+		return -EINVAL;
+
 	file_set->count = file_set_ser->count;
 	file_set->files = phys_to_virt(file_set_ser->files);
 
-- 
2.53.0


