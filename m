Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF8FCD3423
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KV7zz3IVCgqM4rAO8VDBmG5qW5sfO3INZmQIYnfF9qQ=; b=gEZK4JiuTpTBfIBlRwqtyLux8l
	UR3/VEuiZ6uJJC1bgyIws0o2+DpW09Oj+k0WLyXsGF3QrC22vkE0ROH41wRwiKwmSbhoQTiZcRH43
	R9CL9AxBqI+1T9KoOKEqafbXzi6iCPA3ffadM3QpXh5DwpOVE236eexMjgr+ILfCph6bPtGdT5CKR
	HsBS4LX/bINDntK1PuZsjs0bFspJ+0TZkS6EPfXRgGibI7A4b/gx59OVQKKiewe5+TztkRuZ3m/5C
	+WdlHTeLEKaJx/M3fR+tvuBmRI9uofveMDKA1GeWToSwf4PhRFlEXV4IRB4m9PcAdp6OpGT3U4ryo
	O7uRYlDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIriI-00000007Voj-0HBq;
	Fri, 01 May 2026 17:31:42 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIriF-00000007Vne-3uyy
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 17:31:41 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3650453fb28so276957a91.2
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656699; x=1778261499; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV7zz3IVCgqM4rAO8VDBmG5qW5sfO3INZmQIYnfF9qQ=;
        b=Op9i6lB0BI+vX1xxLkWfbuPcbjTYGblHeLniGPJXq0vjF5k+l5hjkzaXNQl7v7oubL
         nl5sCpXh97x7wOqqVu2Ok6JzmNECR148KJSiZfZHxchzvxtO6qxoybxqa4DO5/eJdnCg
         29ITGGF7PPpMOr7goqTgnDfdKqPZNeK6cNgpxt8YYUMUF1pbgboP8fNa3UXCA8oPXhiq
         mijbVGjrmFMUJWx06vL4qZfYCvXXu4eajuzM2GuB2xfCfmfhAiG09VLUHJAd++kLDfA9
         HyQFk2fyERgCvbZako18oIndggvLRSSN4MBgKejaVZXc81MylZmcq8IBIQKLGBQ2FUBq
         9Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656699; x=1778261499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KV7zz3IVCgqM4rAO8VDBmG5qW5sfO3INZmQIYnfF9qQ=;
        b=p1M7AqRhxFgaJ3CwSu8NpWMxNRxIhkMcx3kja4vGzU64mBUMDyGZz4XkW4U+Xg3++H
         5JEh+oOIXrP6HSsEeSEtewtMbfgv52/KepT4QfrudG3Hoo2x4nzaL0OKWPpCOdNoijjb
         xyZ+q98919DbNOY1zngt36O/znlt1VnSCRsKVYgLnhmwiMtVVJkggFdknKJm8Z2lQpRD
         uzxKFIlj8WHCe72xs4z1MF7smQ6dq8U9P2JgGvkJjTYOjmfEEZ8GVZ8WEG05om8XD7++
         mttFHqL6sQa1eaAKsVUHL1OanfbwBvkgo+z3C5W1DE5UcOhD/mG8AEHA3MluUnXKQvuL
         B7fA==
X-Forwarded-Encrypted: i=1; AFNElJ8im+EACBqtp3bmKE2SYvFR/NNCdSDX5YNM3JhOnxeZg49LLWNNOQyBhNIYHcafCDzBWTnhxw==@lists.infradead.org
X-Gm-Message-State: AOJu0YywWkMzeJhvmHeKmhmegIP+juo0StALiyI2cbTNYVyIGFmys0dS
	3H0hnZKY3uRzCap+UK9SaMrykHRegj6MWOufMM+jVg421U4inAv6aUg3
X-Gm-Gg: AeBDiesxLklN18awWH52UQ7JhNmr9x8YQUtjKaUWBW5+szOe5Mses7pmb0WwGwX9FPZ
	D/aq23nWGBBW1eFXUeRRPJuaGOZ7YzJt4KlaFcELeCgBwebG6p9p18EW+5vtFaX0bGlzJyd3WZt
	PPuOiLl5ooB9U3WricMllKEOwa6JZhPeP3a92Ka8v5Q6Rq92jcQL5NiDx9aMlxhyw1xWUB9bd2v
	X11ipjeSWC+khBUegAbcT3CcLHGrl6h1137ooY9mMxOwCr5GRIaeChXukNfVm+H2FYodkccl6Vz
	Hy8Pqz7iXZppvvXf3lZumAmCNo+R67Ta3kVq7zHbrBigcsLnOaXuO1XYwg5C36915cqMwl/hsYr
	FTmo/OuoCtj+TdAjCDkZiSyguA/TL2Do8u3nmt7fQ1ij8bCMdEOyNATibNebE8xtoeF8qT+5V4A
	slHPo669kGnIU/b2BB6vu7YkCUWK0QUvJVAhyxKg==
X-Received: by 2002:a17:90b:1d44:b0:35b:e4d8:e21d with SMTP id 98e67ed59e1d1-3650cdd4a78mr173094a91.2.1777656699024;
        Fri, 01 May 2026 10:31:39 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:15cc:43cd:8af9:5a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caad2459sm27094895ad.33.2026.05.01.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:38 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] liveupdate: validate restored LUO file set metadata
Date: Sat,  2 May 2026 01:30:52 +0800
Message-ID: <20260501173053.73116-5-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501173053.73116-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
 <20260501173053.73116-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_103140_096303_10972BFD 
X-CRM114-Status: GOOD (  11.01  )
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

The restored session metadata provides the LUO file set address and count.
LUO maps that address with phys_to_virt() and uses the restored count to
walk the serialized file array.

Reject invalid empty file set metadata, reject counts above LUO_FILE_MAX,
and check that the physical range is KHO-preserved before mapping it.

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


