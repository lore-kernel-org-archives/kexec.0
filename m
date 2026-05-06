Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F03DCD343F
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 04:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AbOrubX+8qToIxR95hVSpUzrx6LpH8VO3i3UASQK7G8=; b=Wjot3ztxKubphA/ZfzJXQYe+Pv
	NjxemCy++WeehMBy70U5OGQyFk8sXyffw8Gyj3W1feuU0QojefOGPpRSzdBAISm9dve9bz+AgMEl+
	iHVSqCjKYgYnXxdHO2tQdcZzOE7f25KKdR/wRIAfQas0pGV0lB1cjw3BTswa56Rq2Ffp3ywZRPmgk
	IcZF239zKZmitnDgrtDGE+JNCbpF4vUws5/C1wS8IKXsMSGCiMnuWuV49r5FRjOIJK/5/luYyRMUH
	wYhTNu9PHChFn50ta4n2SVfvcUbZBH8FfqUI9xpgDrqv3B8Jw8jLTWnTkbdZMd7xgVPpD23mxEMk0
	ZNdaIdNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTvo-00000000hx6-2blg;
	Wed, 06 May 2026 04:32:20 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTvm-00000000hw9-3YeD
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 04:32:19 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-794719afcd4so55798327b3.1
        for <kexec@lists.infradead.org>; Tue, 05 May 2026 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778041938; x=1778646738; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbOrubX+8qToIxR95hVSpUzrx6LpH8VO3i3UASQK7G8=;
        b=ddeaU/egAo+g+SYkQmAxjIDv0xUrc9Pt18O0kjfiOUYeHsJv4hB9aixFcdMV+vIb4F
         5NqPSZ8OgJE+k0uei2pMZmNQKAhwcAfdKEgpeSIIGk9DS0Vk4iY6uVUUW/jKGfPYsMV9
         Dhimqu4PMk1iFJqlcwhdLbQWFgL09sdH/pabXWQp1dA+cvRrK0x8FTPV6wyvGOxksK/R
         hMZMRQPcm1vnHspuGb3BW2p+bGo9rj9m1s/cy2jip/B/XDOT+UfXu+0ctH8Cj6e6XqJl
         Da6m/8Qgb0V+0EAsj8cZH3JIi/ac++uY5S9oh97Hnaao2TZLO50UQowHogDJiKdur9xp
         Ewnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778041938; x=1778646738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AbOrubX+8qToIxR95hVSpUzrx6LpH8VO3i3UASQK7G8=;
        b=i2NJ57Q8ZCSS7BwXrtoJwdvWzmaiCqi/pNRyHKv4IVv0Xc31CtHWE4e5gZ5i90+SFJ
         ICzoRQZNS06lbglZWVIBU5LPK5MUluyMHR2/V8l5YV9SqXeopLMlDodzMhHtgNF4KFSQ
         mJiXns/OnZR7mBu4pc+rpfDy7o1UjezXtLfHV3Ms3JhgU46AD+o3L6adoYkW7GMo9uba
         6EFZ7JEjpXM4VFfgEjoiuhosXRid2+cAsg/TvJjBfWlWVy2fDEV6BfAgiQ+90eMsgLAz
         t9wei2ezafPYjul7LtlKhKXQG4v06GvePv963I4Y2i0l750EMYAe4MPg8dyXdfbVEY1d
         oOGA==
X-Forwarded-Encrypted: i=1; AFNElJ8tYjfuqIX+M8vU1X/mUOT44X4Rm49vPu8yyC3HJCYNztl9WpLbJw1m+M0vyxHJ8TYviX5ukg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzpZ3zBACeXdT7ip+6cG8Lb8gwCtXUGnrtEIK4Q3WEWdPcTqdlT
	7NBKb0lF40uiquVlcIwNixoskNhHPqmIkgy2571ntbrFI/9v9Nn1irdSRlijZwp95bA=
X-Gm-Gg: AeBDiev3On9Reyy4Unra0d4nuHbkHSKShUNaPyl51iC+wWPIbmbcgTxO6tUoinXURSJ
	thnBlSSMHw1faTA0HvF7ipvd8eGX/SHioTv88PwOilR0DopGY9+ccQ7kz1cT3T4zRfT5MK+fH96
	Yxg+lGuEn6Gtkz6irUayfQ+45gVkOv0Mo1IWCtIfhgSl/KCryVJfICNSHdW0xsaNmKzR3eZc5T3
	XcjCSpJbZ7ppE6/cAFdv8sqVpGID/HEfpuomBO0tdjp4NotAIyDM4oCqm1WxEg4RexvhKR8A2Em
	nuIdBB/msB90G3eBw/xxgjNtQpyfrP+vZ9dBEs3AW+qQxld9as6GR25QW6/4lsxfb3ej2go+Nzs
	XcnTXdfKkXTL02tMJm9LyTnCNMCQ8HNMRKKjSDUo2HF/qaxG845gvU/i4mqJMFFYdj3ZgsNQxsP
	jxgVF2V3ByEUwy8mZajFzMCb1YzKC19jO5wycg07Fc8LTOxsZUHoxkPtx54t55/65jTdnjHyfpI
	b30eYgPe35R8ROdSnDpHKvG12OgOdRCXlIZr4NfKSb3PDkmE4KYryNXd2I2
X-Received: by 2002:a05:690c:6a12:b0:7b8:3b51:c9b2 with SMTP id 00721157ae682-7bdf5e6576amr22480287b3.23.1778041938016;
        Tue, 05 May 2026 21:32:18 -0700 (PDT)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm73436997b3.23.2026.05.05.21.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 21:32:17 -0700 (PDT)
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
Subject: [PATCH v1 3/3] liveupdate: pin sessions and handle inactive ones during serialization
Date: Wed,  6 May 2026 00:32:04 -0400
Message-ID: <20260506043200.2025677-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5898; i=pasha.tatashin@soleen.com;
 h=from:subject; bh=m3ncrz+QJtlelk6UUVAGf06T0j6JaVYUB5b14TMx1hw=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBp+sRF0XIRouY2KDmLg449O5cM3kLqeGkw8kfjW
 d9DITOBCYCJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCafrERQAKCRC7dyhM23N6
 3mzuD/94Mf2kTQ81mL2Y7UYTByYy1rabHB1QORO5v2SRSxV7L8LyhVboQ3dbpgHlRLRIaCRE/YC
 U3mJsu7KpQ8q+LwE73WXqxr5xBfw387770nG9NW2pKqFZ9bLckEEzwGwW9gNN3Cl+7P/xYX67Mw
 HtD4H3TtkDl2NhW0S8e2nwUtGLMBY0PtEdNda21qJOkIEEW8qJ5AMfMZPFnriN0dLtxJTqviKKi
 MXORfrcJyqqFKlaka8NIce2PMLEe2gO+ymMbe+mEQ1NSDdRhEmNDxO27j5sJUc0XRsU0z2rNdJs
 OL0Ly25pYYuoYbUIxB0FYhSItLNRZeKmndnQsYjVLgQEs9+v3P6u8R5GJYA9lCbPYqOo3vcmIvU
 EX6l7cz2MTcmN9q/mElKTCnHIK9FAb467sGvL77IPCKxYxggApbuRshNsItR3aE/19sIlTUkyF/
 mNyId/wiMc6ih2BnTm4l755m3e/c3UsKWwuWljmBNUyWbOqvqa0hFR9d8M8tHXVH6qG2Vsg9Gez
 Gzl+wRkOStTWGEogA/p0dO8YXexDaD1R2P7Nenu2CPxKaZfIwpRfVWYhE9mDsFQSNDhclwGiewX
 DkleHYYUCoLSVAoFaTg76/Z4nu47UAM4D9wk/Yj4lctz2Aqyt6z4jvC4Om7ecg3nOuYQS1XaGel rNa3T+I8mSSyGhg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp; fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_213218_903489_2AB6720B 
X-CRM114-Status: GOOD (  20.11  )
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

During the reboot() syscall, user processes are still running
concurrently. Even though the system is actively serializing LUO
sessions and will not return to userspace unless liveupdate_reboot()
fails, it is still possible for a user process to close a preserved LUO
session. This creates a race condition where a session could be
destroyed while it is being serialized.

To fix this, we must ensure that we only preserve sessions that are not
closed at the time of serialization. Take a reference to the session's
struct file for all outgoing sessions to pin them during this process.

Handle inactive sessions (where get_file_active() fails) by cleaning
them up and removing them from the outgoing list during the pinning
phase. This ensures serialization can safely proceed with the remaining
active sessions.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_internal.h |  1 +
 kernel/liveupdate/luo_session.c  | 77 +++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 875844d7a41d..1124bab6e0de 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -73,6 +73,7 @@ struct luo_session {
 	struct luo_session_ser *ser;
 	struct list_head list;
 	bool retrieved;
+	struct file *file;
 	struct luo_file_set file_set;
 	struct mutex mutex;
 };
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 996adc995514..b344b64bbced 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -177,12 +177,27 @@ static int luo_session_insert(struct luo_session_header *sh,
 	return 0;
 }
 
+static void __luo_session_remove(struct luo_session_header *sh,
+				 struct luo_session *session)
+{
+	lockdep_assert_held_write(&sh->rwsem);
+	if (!list_empty(&session->list)) {
+		list_del_init(&session->list);
+		sh->count--;
+	}
+}
+
+static void luo_session_unpreserve_files(struct luo_session *session)
+{
+	scoped_guard(mutex, &session->mutex)
+		luo_file_unpreserve_files(&session->file_set);
+}
+
 static void luo_session_remove(struct luo_session_header *sh,
 			       struct luo_session *session)
 {
-	guard(rwsem_write)(&sh->rwsem);
-	list_del(&session->list);
-	sh->count--;
+	scoped_guard(rwsem_write, &sh->rwsem)
+		__luo_session_remove(sh, session);
 }
 
 static int luo_session_finish_one(struct luo_session *session)
@@ -217,12 +232,13 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 		if (err) {
 			pr_warn("Unable to finish session [%s] on release\n",
 				session->name);
+			scoped_guard(mutex, &session->mutex)
+				session->file = NULL;
 			return err;
 		}
 		sh = &luo_session_global.incoming;
 	} else {
-		scoped_guard(mutex, &session->mutex)
-			luo_file_unpreserve_files(&session->file_set);
+		luo_session_unpreserve_files(session);
 		sh = &luo_session_global.outgoing;
 	}
 
@@ -380,16 +396,65 @@ static int luo_session_getfile(struct luo_session *session, struct file **filep)
 	struct file *file;
 
 	lockdep_assert_held(&session->mutex);
+
+	/* serialization may evict partially initialized session */
+	if (list_empty(&session->list))
+		return -EBUSY;
+
 	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
 	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
+	session->file = file;
 	*filep = file;
 
 	return 0;
 }
 
+/**
+ * luo_session_get_all_outgoing - Pins all active outgoing sessions.
+ *
+ * This function iterates through all sessions in the outgoing list and
+ * attempts to pin their associated file descriptors. If a session's file
+ * is no longer active (refcount 0), the session is cleaned up and removed.
+ *
+ * Note: Successfully pinned files have their reference count increased.
+ * These references are intentionally leaked in the current kernel upon
+ * successful live update, as the system will transition to a new kernel
+ * image which will reclaim all memory. In case of failure, they are
+ * released in luo_session_put_all_outgoing().
+ */
+static void luo_session_get_all_outgoing(void)
+{
+	struct luo_session_header *sh = &luo_session_global.outgoing;
+	struct luo_session *session, *tmp;
+
+	lockdep_assert_held_write(&sh->rwsem);
+	list_for_each_entry_safe(session, tmp, &sh->list, list) {
+		guard(mutex)(&session->mutex);
+		if (!session->file) {
+			__luo_session_remove(sh, session);
+		} else if (!get_file_active(&session->file)) {
+			luo_session_unpreserve_files(session);
+			__luo_session_remove(sh, session);
+		}
+	}
+}
+
+static void luo_session_put_all_outgoing(void)
+{
+	struct luo_session_header *sh = &luo_session_global.outgoing;
+	struct luo_session *session;
+
+	lockdep_assert_held_write(&sh->rwsem);
+	list_for_each_entry(session, &sh->list, list) {
+		guard(mutex)(&session->mutex);
+		if (session->file)
+			fput(session->file);
+	}
+}
+
 int luo_session_create(const char *name, struct file **filep)
 {
 	struct luo_session *session;
@@ -596,6 +661,7 @@ int luo_session_serialize(void)
 	guard(rwsem_write)(&sh->rwsem);
 
 	sh->rebooting = true;
+	luo_session_get_all_outgoing();
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -616,6 +682,7 @@ int luo_session_serialize(void)
 		luo_session_unfreeze_one(session, &sh->ser[i]);
 		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
 	}
+	luo_session_put_all_outgoing();
 
 	return err;
 }
-- 
2.54.0.545.g6539524ca2-goog


