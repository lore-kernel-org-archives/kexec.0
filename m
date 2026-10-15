Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAC9CC6B38
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rZelI1I51j7rf9JD3PGtzWapemkkjt987366KVri7bQ=; b=UYiwu8mruA8LWN/ALepT78D0LY
	ExTJmSaY4wTEulYlOwE+BWsABsekd/WamPw46w0cewlmUhkM9WGrOqVpP7rDxT5cis85UpuU4/WrN
	MGsVlnbBPOpElTB3gP/cQpXuEFPbdazsuyk1M5/0nxb9EHEfPgP4RW2emcvXyMemxXgRO5LGfJVk2
	Jx/Z6eFyia3Dcse0cBAdNpWl+3tc0mA/O1y6FMWLkTVOmDDgefpTOp4ASWsubS1nhZPAOkauX9cIi
	F59kCtqtkM+Fbzeuo0aOv9LKQCKvdWgXcy3NeRyM5jZun/A4+L8bQhVRaFzLMhw7LYRCuEGKqf1YY
	ACsPfkyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHve-0000000HIFs-3u4U;
	Thu, 15 Oct 2026 09:39:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHvd-0000000HIFO-2W7i
	for kexec@bombadil.infradead.org;
	Thu, 15 Oct 2026 09:39:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=rZelI1I51j7rf9JD3PGtzWapemkkjt987366KVri7bQ=; b=BT7051inzdjVw/kcrzF5n/IOrP
	PhdFqtfICzKaYCktMGJ+Bnu+Fb693TKcV9uZ6tKNALyjTYF7nAXytf/MkoDiqA3X1JQDhprQY2lBx
	lcQ5kJbQGeC9nQAHCRrsxxy9R9vuETT6UqJHvh+lekUTMgwkvMp7lWb8cfPkj0K+zepXqdI/nkZgi
	MLOOeb2vh+PyQbzNNAutImRVFu7QEW/+K+UwyNBNLJPNk7Xz6YsESLnLFUHC3RPOUkbETzNZPOiFy
	ySaTHLR2JHXCx/jSlbejAud22YiKygtBDM9xoRnGWhBA/TpjvkDKNJl2/ABXQeZNzk3exTUz8tZAX
	FviXOP8g==;
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHHv2-00000000BYJ-0j16
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:39:12 +0000
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-7c03a445cb8so897706137.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792057113; x=1792661913; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rZelI1I51j7rf9JD3PGtzWapemkkjt987366KVri7bQ=;
        b=S6fgMYLjck3+riJFJHKm8AyTytMl3kD9dUtUPlEeSbxjl0Muj2uAbqENZ4dgX91Wun
         fqpy6d82hAjx67OU0IMZkfnVTotYgP2pJGe05zU1YjtK8LimbjS7T5TYpixdaQIrYO+t
         0RMy/0tZb69Wxs+1bNU5ZTJ1X921c0unxDwV+QOMtAMyt16dYMRrpMp8VOeSHGXanV9z
         GvKEDehTpa+LayvtaRo4JzPxlR2MsyXC8rK3v3dX64wKm3c06MbleNcInLqb3T2Amn0r
         qxQwbdkRMG2GcysxoO3Gm81KbycJdpIRLa5tgj8EUSKt8RCAKtQ3nE6Cjmj7dqczdf6w
         iz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057113; x=1792661913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rZelI1I51j7rf9JD3PGtzWapemkkjt987366KVri7bQ=;
        b=qlW9iMRBzKg6j4FuqUbT3+Gdd2eqUOLGTbNVZsqo9ZhWsEgvuwVUyuX4fkTXDWHSQy
         qWgFlHRQcre6cmDSqiSIVGUXXBBGWj5gIpIqqMi3Zh3YCQfPUHEVG+vKKIyDEOHqxo70
         x99tpz2QQjiF2+p4MhgFAshr5gBxPN0DwCXii5b6g/DKMBxP+GTOZvxWb7I4KQ+9r0BR
         GUABh6pN8Uby058PI2HTThAYEZASsTJ/s3Y2cjtNIVLC115oQkPQWgJ6oDEmVf12Cmbe
         kYb2So5AtzaDd7/87B5s/fb/yKtcbDyXMIncZGf3q2MkNWWjiAlRUqvY+gPyORw9kBU1
         LRwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBeZYGhH5G2N3HoskL/JDIhN3lTd39sisRkHf1zLnuX2fwkKY445sFErQB1GO6J01rBsRcLA==@lists.infradead.org
X-Gm-Message-State: AFq9FYIMJgJ3REWXjJ6vvMa6E1YBUoLYlHd9QojQZbGIBD0XQEl+e9cK
	m9seS4XybCAOJXiBpR3vtXzYbFcu4RKNthPoF1NBzWR9HCE7L5ajctwZP5HsBMxydzQ=
X-Gm-Gg: AYBFou3WiTEP6dJHGGV+o15rQs0zb2qDL93fVkre1TIbwBgGxk83gR4hVey6nOCbs11
	xFUuz30ceL39HHbVgcZUL3RYBJQkDX68tVU8zfc7kh18Rp066PvgJBDFL5QlNtak7BGW76XBkoE
	zoWA7etXykdoiW+i6UyumVekXOp987l9aO4SwoS4t3J+63fWQZPQjab41GK7sCciN6313r8F8ed
	RUpBuRC4ql69MNU5HnR03MCYHcsiO7FG4H9nFPhg9P5zyiPwBGeYlRRLslQTyJ3bwccktPZ/ztT
	XF1LXTM0OKZU2BP68E/ybI6OwKH7hIIAN1nIOomPn6Bnsouu9tA9y7Xd7YKhtnKGQ4TINFjIOZt
	v6bAnzyZ69TJZ29SlwcPrQ3kDfU3xiDEvLoqtG2OwfWFhzgBFTWJ/dZ+C4dhrWvcgk8aI8wbS56
	VU+cF7pBnobpsSQZEt+mRwpnvNQmVQWd027XeFLwdYmbPN+fHb5WG0rf6G+yDqIHVWQd4aVYXSe
	kGAA/NtKm5FUCtBUxRDEwcq5eluc0yuqDcU0TXtBCBohgrQvgfBYwhJnDkrDJEiu5/3txvOMjA7
	yWPE7sdw/aLDAAq9W9oOZU+vpIaNJA==
X-Received: by 2002:a05:6102:2924:b0:7cc:56a:58d2 with SMTP id ada2fe7eead31-7cc056a64bcmr366185137.31.1792057113624;
        Thu, 15 Oct 2026 02:38:33 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003d37009sm12275672241.2.2026.10.15.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:38:33 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [PATCH v1 5/7] liveupdate: Allow file handlers to mark retrieve failures as retryable
Date: Thu, 15 Oct 2026 05:38:14 -0400
Message-ID: <20261015093816.2438942-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_103849_795237_2D5C8D13 
X-CRM114-Status: GOOD (  26.51  )
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

When luo_retrieve_file() invokes a handler's .retrieve() callback and it
returns an error, LUO currently records the error in
luo_file->retrieve_status and blocks any subsequent retrieve attempts.
This is necessary when the handler has already partially consumed or
freed the preserved KHO state.

However, with user arguments passed to .retrieve(), a handler may fail
early while validating caller-supplied parameters (such as a missing
argument, an invalid or read-only target file descriptor, or a non-empty
target file) before touching any preserved KHO state. In such cases,
userspace should be able to fix the argument and retry
LIVEUPDATE_SESSION_RETRIEVE_FD, and if the file is never retrieved,
.finish() must still run to release the preserved KHO state.

Add a retryable output flag to struct liveupdate_file_op_args. When a
handler sets args->retryable = true on error, luo_retrieve_file() leaves
luo_file->retrieve_status at 0 so the retrieve operation can be retried
and .finish() will still clean up the unconsumed preserved state if the
session is finished without retrieving the file.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h      | 11 ++++++++---
 include/uapi/linux/liveupdate.h |  7 ++++---
 kernel/liveupdate/luo_file.c    | 20 ++++++++++++++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 52d3f453ae011..4e1f0f4cbd6fb 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -57,9 +57,13 @@ struct liveupdate_arg_spec {
  * @handler:          The file handler being called.
  * @retrieve_status:  The retrieve status for the 'can_finish / finish'
  *                    operation. A value of 0 means the retrieve has not been
- *                    attempted, a positive value means the retrieve was
- *                    successful, and a negative value means the retrieve failed,
- *                    and the value is the error code of the call.
+ *                    attempted (or only failed with a retryable error), a
+ *                    positive value means the retrieve was successful, and a
+ *                    negative value means the retrieve permanently failed, and
+ *                    the value is the error code of the call.
+ * @retryable:        For .retrieve(): [OUT] Set to true by the callback on
+ *                    error when the preserved state has not been consumed and
+ *                    retrieval may be retried.
  * @file:             The file object. For retrieve: [OUT] The callback sets
  *                    this to the new file. For other ops: [IN] The caller sets
  *                    this to the file being operated on.
@@ -81,6 +85,7 @@ struct liveupdate_arg_spec {
 struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
 	int retrieve_status;
+	bool retryable;
 	struct file *file;
 	u64 serialized_data;
 	void *private_data;
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 57a3c129d5a9d..0ab28fd58fa5f 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -175,9 +175,10 @@ struct liveupdate_session_preserve_fd {
  * associated with the token and populates the @fd field with a new file
  * descriptor referencing the restored resource in the current (new) kernel.
  * This operation must be performed *before* signaling completion via
- * %LIVEUPDATE_IOCTL_FINISH. If a retrieve of a token fails, subsequent
- * attempts to retrieve the token fail with the same error code. Failed
- * retrieves are not retried.
+ * %LIVEUPDATE_IOCTL_FINISH. If a retrieve of a token fails after consuming
+ * preserved state, subsequent attempts to retrieve the token fail with the
+ * same error code. Early argument or target validation errors before
+ * preserved state is consumed leave the token intact and may be retried.
  *
  * Return: 0 on success, negative error code on failure (e.g., invalid token).
  */
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index e3bfdbc6baedc..5c2ffec696885 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -138,9 +138,10 @@ static DEFINE_XARRAY(luo_preserved_files);
  * @retrieve_status: Status code indicating whether a user/kernel in the new kernel has
  *                 successfully called retrieve() on this file. This prevents
  *                 multiple retrieval attempts. A value of 0 means a retrieve()
- *                 has not been attempted, a positive value means the retrieve()
- *                 was successful, and a negative value means the retrieve()
- *                 failed, and the value is the error code of the call.
+ *                 has not been attempted (or only failed with a retryable
+ *                 error), a positive value means the retrieve() was successful,
+ *                 and a negative value means the retrieve() permanently failed,
+ *                 and the value is the error code of the call.
  * @mutex:         A mutex that protects the fields of this specific instance
  *                 (e.g., @retrieved, @file), ensuring that operations like
  *                 retrieving or finishing a file are atomic.
@@ -620,7 +621,9 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
  * The operation is idempotent: if a file has already been successfully
  * retrieved, this function will simply return a pointer to the existing
  * 'struct file' and report success without re-executing the retrieve
- * operation. This is handled by checking the 'retrieved' flag under a lock.
+ * operation. If a previous retrieve failed permanently, it returns that
+ * saved error code; if a previous retrieve failed with a retryable error
+ * before consuming preserved state, the retrieve operation is re-attempted.
  *
  * File retrieval can happen in any order; it is not bound by the order of
  * preservation.
@@ -678,8 +681,13 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token, u64 arg,
 	err = luo_file->fh->ops->retrieve(&args);
 	kfree(args.arg);
 	if (err) {
-		/* Keep the error code for later use. */
-		luo_file->retrieve_status = err;
+		/*
+		 * Keep the error code for later use unless the handler marked
+		 * the failure as retryable (e.g. invalid user argument before
+		 * preserved state was consumed).
+		 */
+		if (!args.retryable)
+			luo_file->retrieve_status = err;
 		return err;
 	}
 
-- 
2.56.0.385.gd3acb90ef8-goog


