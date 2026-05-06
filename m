Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F3CD3424
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 04:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mX4Zs/joSWAsH/8RYZkV3cPKu95fU/AtYiaXzPcWqwY=; b=QJzpK+928I72i19CgqGGSI8YO4
	lWh8plFnpxDZMx/6PAGSK2dulQxLXh9V1GCq7NrgynSwncPhoUorHg8Ncqbpgh7DLEr1bwIbDr5w0
	3YHB6Fp1Fy+Ye1mHAC0Fn3IF4UMa0Tn71X/+sOgPuuUXDlSkcuxfJ6UmsD43B8iS6ipgboguKLjSv
	soPB5Z4vmokiiovST45fzbJnsGGzz7iXXlYj8XNlgw4MjTOsjqaetBp3uMtJHUOuMNpBdWz8gK7if
	7xDtLD4vTqy3X8pBDslIK437ovABWxokby4Tv/gJwFrd3bJriZQPavjcIZYg743BSpblDpL0UkO7z
	iYIvJmew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTvo-00000000hx1-2KCT;
	Wed, 06 May 2026 04:32:20 +0000
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTvl-00000000hum-1l85
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 04:32:19 +0000
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so3536985d50.0
        for <kexec@lists.infradead.org>; Tue, 05 May 2026 21:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778041936; x=1778646736; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mX4Zs/joSWAsH/8RYZkV3cPKu95fU/AtYiaXzPcWqwY=;
        b=e8LdaputpEULsDDojw4bfyXk6DfNf4yurhunpLYa2OBh4bHF0HVd3ZDuRumdSRUX+k
         KpE24h26nSzfh6AlM+f111WZbsjbN3tuxXnBkdg1PXnxr9IXkc/k1MBqeVtXIvN+IldQ
         5Vu4VAixDkXMF5bUCeo4vnzCzKjuzr2hnA8luKQ1N2xG1jt2GRKlaayd44AaOYLgKhuF
         v6MxAHK1CYcomsoAv85Kubil2dlFcne3VRaWdH6aBr4/GckjfqJw3wRptHm3Ml8ba0ST
         sP8ZMoHPsmFUw8z40yVcikiP2cVw7m2gPitZusbkePiR+mswosveWKI/xnNJgJOnDgAp
         OHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778041936; x=1778646736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mX4Zs/joSWAsH/8RYZkV3cPKu95fU/AtYiaXzPcWqwY=;
        b=ZMtu482c7nJfGIIRSzt5qwarbZETtQfSZ+E24Us1dQlDY2+25wg3ra4hIt792u2khQ
         BOrqcO9YBoxNndOLDv58XJ/wm9KvPzs4p7TT30aGMyqJ6zZ8Tx6eD6veGodk2JbU2IkG
         WMptcAxnVa0QiLRPSVmaA4fQhVUbKIo+3xFK2BgZ1iEMKOxKY+gmNCnwjSadApwou1AW
         AZ1qp2T5I0997b/9/MweYroUeC6aDRs8F0H3yTLmwaPVQSOehdjXkxX3ao6ULHlvDkx/
         5IEBTYbxx/QOf6iqfSkkzOh8O1iitSMX9TePXMWme+iUCmI2KlEi1asPhohRHleDnRl8
         MS8A==
X-Forwarded-Encrypted: i=1; AFNElJ9oL++gbTDyVEJmgy+ZgvaHnwuNZkJPth7kp0781DImav1ga81GUhleTpXDGBY821OX2ulEWw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzUdf4H71eIz5SsxAviyH0fxRoCjLpQGxzSGaJDa93+KFAgy9r1
	J4yt6027GBi0imKVShNzPNAi+j5y64ZkNcC1LitJ8ZpzwcJJumBln6GZZSov4Bmyink=
X-Gm-Gg: AeBDiet5SIDzfz5eVtL7JHgWHRJg6t0KzNcWnS2NX+8npE1jS2j7V0L47XdshZco6RA
	2UmU8Ek6APGvOv1cxXSlyb1WkOXMdqlsgDrbubaEplt30cLcymMHrm9N88wp6bt0rQOjyR+cEWC
	XgovQ0XsIVHmkxrp5Zs1aB6Jfd3mMC5uVs8eWyOCos8/rGP6Xe/U57dpga0Cy2IBal1fg0lXLza
	cONy00mioJ9JMWyR0CeTqMPuIsEuGO2WXeQaNYfYy8AKEOrkoi2h9HY2XOWi5GcTcXkh9dWmiEX
	KlKlVwV72P4c1NYtGq5l1IJfWeM6TXhuyEEpuhPh2OaWEV9gSYY8iJoJRy9hEXZgKZfseS6wuem
	mSkDizT0wNqNnOmkj3pTPS6KVk0ZfdNYcCpZNWIrFvW76Bk8jlwqs02zay+mWkTa8kn3y/BvhvH
	c09V778fAXzX74g1wAbBHVVuuZXq1PxKe0PooDIqAFo/DOZ/dZNdPjkXLBFDQ6Z6kd9wLtSMtSg
	J3T+cuN/d5SEwigT6DEvttyEE7qb9wjT8sVu6/EyaOWxv7QeCZ87NlTUTo/
X-Received: by 2002:a05:690c:e3cd:b0:7b2:64f4:a2dc with SMTP id 00721157ae682-7bdf5d8bc3dmr22771077b3.9.1778041936127;
        Tue, 05 May 2026 21:32:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm73436997b3.23.2026.05.05.21.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 21:32:15 -0700 (PDT)
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
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v1 2/3] liveupdate: block outgoing session mutations during serialization
Date: Wed,  6 May 2026 00:32:03 -0400
Message-ID: <20260506043200.2025677-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595; i=pasha.tatashin@soleen.com;
 h=from:subject; bh=l0gSXiU5M1hfOsQ+wzvUx7Ms+ibod+xggU7I0Nuz44Q=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBp+sRE6odvPXHaskiJ46m8gh/j1aNvm2YvrE8io
 p2X+l73ryOJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCafrERAAKCRC7dyhM23N6
 3iUvD/0ad8HdsH1gkdD8M/yqzD9ubhSoZa7QXOnVEdq4OleQzi+CTIuhX7FG1lMzS/EYicRJi4L
 KxJt821+vCsno4d2gS4BNqud2JlamG3+4EoyEbdOuNILun8+YTmKBktEzQs7fn3kgyZXiabCBJG
 K+Ke1tzJS+MFMjtg+VLemW1KWRNRvxifRwC6vuDWVVo4ZpWxPEZUuqqNc3T2GcsSa+qrljW8E/u
 exwk7B7hmmWo4g+9gwCBoMDLava30Gbvx3+3V9rLOTDzO+qoyNEnL1BIODbG+HrXmxfyXV4cGTl
 bvkCxzfNPZWP75O21pbW6txIxvO6u4AUTBrH7SLbwWtTCJ8Qk5nVEDvOkY+xw9w+Lh5LHNquxC/
 OeTLGnEXELG3m4vBVIzPPY7GL9i4aFGf2UeDSMebuAY9mPbl+4ZfY3K2sHcMGeZaSoiQFFxLZEq
 Gez3J7t17wqyNQXbCM39xUsi9HC+5kpmSAiWilMp0RqMAVQNrbyv+g7h1JObDqGw05IkZnFUFku
 ciB80RowKhKlz021GKqb1c+GD4WY9YsjRJLU3WLl7nUcOPy5T71W6BiKzMsSSYysEh8aYgpGT1i
 1WTKAcEK6ahYrB9DUFU0scdj0SfEAhZwmpjLFBTChZV0z8ySeRRmyKSw62LMDZK//EnlUzWxvgC riC+C93Wa2nXMBw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp; fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_213217_499577_A9874818 
X-CRM114-Status: GOOD (  12.25  )
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

Introduce a 'rebooting' flag in the session header to ensure that once
serialization has started, no new outgoing session mutations (creations
or file preservations) can occur.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3327a28fc1f..996adc995514 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -84,6 +84,7 @@
  * @header_ser: The header data of serialization array.
  * @ser:        The serialized session data (an array of
  *              `struct luo_session_ser`).
+ * @rebooting:  Indicates that the session list is being serialized.
  * @active:     Set to true when first initialized. If previous kernel did not
  *              send session data, active stays false for incoming.
  */
@@ -93,6 +94,7 @@ struct luo_session_header {
 	struct rw_semaphore rwsem;
 	struct luo_session_header_ser *header_ser;
 	struct luo_session_ser *ser;
+	bool rebooting;
 	bool active;
 };
 
@@ -147,6 +149,9 @@ static int luo_session_insert(struct luo_session_header *sh,
 
 	guard(rwsem_write)(&sh->rwsem);
 
+	if (sh->rebooting)
+		return -EBUSY;
+
 	/*
 	 * For outgoing we should make sure there is room in serialization array
 	 * for new session.
@@ -230,10 +235,15 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 static int luo_session_preserve_fd(struct luo_session *session,
 				   struct luo_ucmd *ucmd)
 {
+	struct luo_session_header *sh = &luo_session_global.outgoing;
 	struct liveupdate_session_preserve_fd *argp = ucmd->cmd;
 	int err;
 
 	guard(mutex)(&session->mutex);
+
+	if (READ_ONCE(sh->rebooting))
+		return -EBUSY;
+
 	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
 	if (err)
 		return err;
@@ -584,6 +594,8 @@ int luo_session_serialize(void)
 	int err;
 
 	guard(rwsem_write)(&sh->rwsem);
+
+	sh->rebooting = true;
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -598,6 +610,7 @@ int luo_session_serialize(void)
 	return 0;
 
 err_undo:
+	sh->rebooting = false;
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
 		i--;
 		luo_session_unfreeze_one(session, &sh->ser[i]);
-- 
2.54.0.545.g6539524ca2-goog


