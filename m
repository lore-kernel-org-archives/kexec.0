Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E708CD5BD5
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0poEg6dzE32DnYuKI7VywdtZZms3dhY1RszrIEICmMM=; b=bR7IoiV+nRO+gHb1qLSjfY4NpI
	N/o1mRHU2RrMs3ITbL1+7GGVYvFp6Y45AHredipgpHmBtm+UjIPh0r6ZcnOk8/Q9/eMRekIPtSMXN
	r3TUVLEUdo6SEqBAtN/S6nSnqdqT8DL4ICCPuxQhmwN61CtOoHe3k8yKKtAVAdPdOeWk99nKgSTXo
	h5QhH3M+P3WuCHEDb6/GEL5aJTouzy+Ut3fyDVVxKW5WtC/ansvn6IA8DWjc1WQ4SgBY8fcyqANOt
	IHRm3xBabK2AAgNEKLB5GJP2pAHJW0rKJ1bYqJQaXjHUbB+y/3TkXshuPs5y6DeZ7cGAQzhlZaOsU
	prkh/4JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSejw-000000067Si-1KAT;
	Thu, 28 May 2026 17:41:52 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeju-000000067RC-2Cqy
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 17:41:51 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-365ff2ab7beso13783475a91.1
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779990109; x=1780594909; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0poEg6dzE32DnYuKI7VywdtZZms3dhY1RszrIEICmMM=;
        b=uCdI5qlRWq+KvQQRfL50ZH5fL0C4Iqdmje1vGSRLj1dTcfeQJF7UJP2IRYyec4mr/+
         +pnyZl6jI5ZION4JdQsixVTE3L/BmvbgRCqcx1uh/fUbuyjINiGBDzxaOBjWQCQIni/x
         aTXIh17tpQyhYNgxBpypaSncR+BG3iAbLOjwusp/cPbv37StpE85ChSlNgkNBNaB7luZ
         rWHfIHtmoW11YBuolziYLaWHbfG5tblrMLQkrcej3l1eE0gzcCmaYPR05UYKEPsZP029
         vXOBBVqEhvDMjOUjIF8cFlaJR+LfjBNsaxJkumCa5yUjl14VA5Pj5yn+1oTV6IONtij1
         VX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990109; x=1780594909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0poEg6dzE32DnYuKI7VywdtZZms3dhY1RszrIEICmMM=;
        b=KFghUR5GeXANGIWQm+/mY8X0K6S6BHNiRNpOA7Pny1hajLw1HVy+wIervT9tghPUMJ
         sX1fkPzuPsCB579F1+rvv17n0eUoN9t7u0XcJfw+T1K9nDh2LSXIkWzLZTDllkeDVz4m
         7E5QAmHu4474X4ZVclYOPY2rnq9/C5E005Mm5JKCvp1MS4hfc5AvMlw1d2JyqWz3e1fS
         ObiNkR3acb68xoPTg/PfBGUk+YPbWxEwsPNBP6G4pwgcqQWxkNZH0W+VGZ+Id7sgIX8L
         PFxN4Itm6TzO1+hVoR58AsvpYNrrs6p2L1wG5/xUrmIHMU3jIFw+s9PzASukWleKeh10
         m5uA==
X-Gm-Message-State: AOJu0YzwkzACL93/A2PNEqbH8f0UsjuOqaXXoNtaIhaeEM96iEcKxzSU
	O6o0g8Je2MmP/OHT8lr3Prv2PdurClDgYbjpkU2O77GHqWnLfhwHBRy7qhOu5+gl33B5WU7XMO8
	mRXV3nei2dFeDpFIUo0XFQeOq+UHH4DK6qGGaSLRZJenH4iZSCTEliAPgvuhbfBdxyvOEBrsSSi
	lfmTKUYINlYuP8zcf1FH4bURXctiGL1oHprd1JMYpiniRzNRjILuQ=
X-Received: from pjbei7.prod.google.com ([2002:a17:90a:e547:b0:36a:7f0b:e285])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:544b:b0:36b:9798:4f68 with SMTP id 98e67ed59e1d1-36b9c9717d1mr2611746a91.9.1779990108327;
 Thu, 28 May 2026 10:41:48 -0700 (PDT)
Date: Thu, 28 May 2026 17:41:39 +0000
In-Reply-To: <20260528174140.1921129-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260528174140.1921129-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528174140.1921129-2-dmatlack@google.com>
Subject: [PATCH 1/2] liveupdate: Reference count outgoing FLB data
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_104150_566945_0730E539 
X-CRM114-Status: GOOD (  16.14  )
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

Increment the outgoing FLB refcount in liveupdate_flb_get_outgoing() so
that the FLB structure cannot be freed while the caller is actively
using it. Add an additional liveupdate_flb_put_outgoing() function so
the caller can explicitly indicate when it is done using the outgoing
FLB.

During a Live Update, the kernel may need to fetch the outgoing FLB
outside of the scope of a file handler's preserve() and unpreserve()
callbacks. In that situation there is no way for the caller to protect
itself against the outgoing FLB from being freed while it is using it.
Incrementing the reference count in liveupdate_flb_get_outgoing()
ensures it cannot be freed.

This change also aligns the outgoing FLB lifecycle management with the
incoming FLB, since the latter uses the same get/put semantics.

Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
Assisted-by: Gemini:gemini-3-pro-preview
Signed-off-by: David Matlack <dmatlack@google.com>
---
 include/linux/liveupdate.h  |  5 +++++
 kernel/liveupdate/luo_flb.c | 10 +++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 88722e5caf02..c344bf987b63 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -243,6 +243,7 @@ int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
 void liveupdate_flb_put_incoming(struct liveupdate_flb *flb);
 
 int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
+void liveupdate_flb_put_outgoing(struct liveupdate_flb *flb);
 
 #else /* CONFIG_LIVEUPDATE */
 
@@ -292,5 +293,9 @@ static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
 	return -EOPNOTSUPP;
 }
 
+static inline void liveupdate_flb_put_outgoing(struct liveupdate_flb *flb)
+{
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index 8f5c5dd01cd0..7ddef552ff6b 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -135,7 +135,7 @@ static int luo_flb_file_preserve_one(struct liveupdate_flb *flb)
 	return 0;
 }
 
-static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
+void liveupdate_flb_put_outgoing(struct liveupdate_flb *flb)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 
@@ -266,7 +266,7 @@ int luo_flb_file_preserve(struct liveupdate_file_handler *fh)
 
 exit_err:
 	list_for_each_entry_continue_reverse(iter, flb_list, list)
-		luo_flb_file_unpreserve_one(iter->flb);
+		liveupdate_flb_put_outgoing(iter->flb);
 	up_read(&luo_register_rwlock);
 
 	return err;
@@ -291,7 +291,7 @@ void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh)
 
 	guard(rwsem_read)(&luo_register_rwlock);
 	list_for_each_entry_reverse(iter, flb_list, list)
-		luo_flb_file_unpreserve_one(iter->flb);
+		liveupdate_flb_put_outgoing(iter->flb);
 }
 
 /**
@@ -546,6 +546,10 @@ int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp)
 		return -EOPNOTSUPP;
 
 	guard(mutex)(&private->outgoing.lock);
+	if (!private->outgoing.obj)
+		return -ENOENT;
+
+	refcount_inc(&private->outgoing.count);
 	*objp = private->outgoing.obj;
 
 	return 0;
-- 
2.54.0.823.g6e5bcc1fc9-goog


