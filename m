Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832B7C61DB9
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DbB/ht4kuz9HrzZ+87IjaChTvsjDGMv7+LkCGq9sCCk=; b=T+5Lu5NXLn4gokXnlZXV48YYEB
	3mKSIxGd0CyhGXNHUS2lRyB5wVdVEb1egwc3n4Snk6phh/XmB1Mp+a3QJtWG2z/hRayNWmHm8eZjz
	lwhBGh9KbAEu0uTYGaDnzUHnO9PPXD02bDQfUdRetCOjGKQukyyt9Ql+4qXuNpxywPPLy0K8hzCNF
	YcQkl6qdnnCH8rSWSpxeDwTulL7btZF8Ac+RmUbD9HtJOaJzWfUyfj1TBp5SMr+SpgNSnBuXR0vMv
	pP201S/ecfa5/Wvx2ad6sjJ2qJ75LgTZY4Vx0KyYh4cUBD1hAUMQeCpSjxlUODmLovlPd6Gb7Vgix
	MAhAD2BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsHH-00000005Loj-07gn;
	Fri, 28 Aug 2026 08:49:35 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsH9-00000005LfY-2Itp
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:31 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2d71ae3455aso11215955ad.1
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906967; x=1788511767; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DbB/ht4kuz9HrzZ+87IjaChTvsjDGMv7+LkCGq9sCCk=;
        b=HT9ZfasostTMG4EWodVnKbsqvJkElh8z+XrYVRnlRd6h8YLHp0JKtEbW2aww4nOjIB
         2JqLaexabkuYFetVPxGH9lHWCTTJHOmZtoDoDOTckBLWX9sZCNS4btt9hyGJyQghtotF
         Zmm6lWsF2QWhW/gVDee2ouU62P0Qa5rggpiDDKyBJhcnu8aY531ompKWLxXnqyddEdUa
         uVcnM7Jjh7fBZx/XF3BT5Tenpt+fzxvDsQzssdWUfiD8jJuJKpNm6YPrlVDeGyznulqf
         VD6JCNOHX/hOaqobTUO6dYtXwVegGu2m0+o0fFU2Qk34ikn6bp0368g/sTCNer7n2Tw2
         ibCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906967; x=1788511767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DbB/ht4kuz9HrzZ+87IjaChTvsjDGMv7+LkCGq9sCCk=;
        b=odUEsGzkOjwKACj7bPjr8RcR5IPUWvzxx4QUK33UyIHBC7wCM3DIEEkDYo/FX7BTxN
         Tjt07LVxOG7ChHG5qMIdfG8DjaoMgxVh1t3YLAgFA6eq5U2Rk04g2X8bRb2uhduR09q6
         SoP1jVOp/0oQJRbODcrH7NiiZzEhjULACUZAacdyaET4GV++64Gz5wmxXHh0sifdylFl
         SeG3fh5xreqggTNiI5OXt7vNnN9VApd1x9EwIgw+4P9peWi93B02kPRgi6oQentTrGLu
         FFlPkqoDv/2h1Z/+zmFi6/jBGGtvOW5W8VX67eEISX8ekwY7bF/yXWn2AjQRFu7tnswG
         DBgg==
X-Gm-Message-State: AFuF++k9XUGJtf4lKvoZUjVFgYH97IGQuxzTNI8xeFyWFxftn3ezV70s
	7YntrUr7uk5d1Y+U8hyX2k0hCBqBdESQlQHxmz1EXJTMO4M1uxxYapQ55OewvvVw1us=
X-Gm-Gg: AR+sD11NvippDi06YDpmEd7y+FogfsO2q/u8XNPaJK88xIzFa1CqhNdfdHiDmkq/Xms
	JS5z1n+aMScn4chew99nUUhGGGmBWH8wACnZ8J9hbYHzhQxPAGGlIp07irvnLQeStTW7znWWLoT
	hQu9wLFjR6l42KFKYFsV53PCW0FOB15JXZelVGjxfLrbtgF8vMp2MHHqwea1GQ31KykRyUegMlx
	T9lzBGlhHJjfbOUPUffHXaEa6/1vEcNsrESt3ug2tsfrE/Voxn+cOuxMyo1c7r4wGmRaDQFfj8Y
	pOGV38l7dLhnFoO2hD5XtFlIHU1aoC5cQ4viFhgu2YeLzS55jjGjNlt7DIuWdpKyHkJwCmH1jSW
	Yl7t7ve4WvHJPww7iphPbLTjVu9qzuVziGRX/mUU7vn64GrLLZVkilPuc1VqWLWM62dJ3hfvWjD
	0I5iXXQvJekAgqp144c4SRHNUEMpMaihMm/HHoK8bCuwiCsTX+8kJmcE5u+sg=
X-Received: by 2002:a17:902:f705:b0:2ca:d9b3:715e with SMTP id d9443c01a7336-2d74ddc1f8amr106659775ad.9.1787906966735;
        Fri, 28 Aug 2026 01:49:26 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f99585csm3346907eec.21.2026.08.28.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:26 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/9] crash_dump: Improve readability of config_keys_restore_store
Date: Fri, 28 Aug 2026 16:48:52 +0800
Message-ID: <20260828084900.1496839-7-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828084900.1496839-1-coiby.xu@gmail.com>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014930_090355_D1231481 
X-CRM114-Status: GOOD (  12.63  )
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

config_keys_restore_store currently doesn't validate the user input
before restoring dm-crypt keys. Although it's not necessary for the case
of vmcore dumping, it's better to do it for the sake of consistency and
code readability. Also check the return code of
restore_dm_crypt_keys_to_thread_keyring.

Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 9ccc7b5320a3..e82693df73fb 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -371,13 +371,25 @@ static ssize_t config_keys_restore_show(struct config_item *item, char *page)
 static ssize_t config_keys_restore_store(struct config_item *item,
 					  const char *page, size_t count)
 {
-	if (!restore)
-		restore_dm_crypt_keys_to_thread_keyring();
+	bool val;
+	int r;
 
-	if (kstrtobool(page, &restore))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
-	return count;
+	if (val) {
+		if (restore) {
+			pr_warn("dm-crypt keys already restored!\n");
+			return count;
+		}
+		r = restore_dm_crypt_keys_to_thread_keyring();
+		if (!r) {
+			restore = true;
+			r = count;
+		}
+	}
+
+	return r;
 }
 
 CONFIGFS_ATTR(config_keys_, restore);
-- 
2.55.0


