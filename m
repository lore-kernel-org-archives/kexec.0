Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1B0C982FA
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xd0t5fQ0wbqovFneONezXRLopfuFSVDwWIsqSLQ6+6E=; b=dVX7y0kVccY5+UbU+PX4V94BwU
	iuwmn+mdJ+zMH05mm8HR4I4eFbK6SbilBkloolkKlxRYKC0pN8s3TCybA4KtHB/m+z8rXs3Ee26vd
	ivNlAlC3PiHw7sGoz5MFnCG0tbFyQbNvipoY9m/X3dWL1rIU938U6iste/jTUNqvO5v3Y9LAX/R4G
	6xsPhES8LZV7+6gFT/1skDfLo9PojpbybYeLFNicr3dtxj81Tia7IEQp7pcI3kMcp88iZh/PwJJWO
	FjqqGSWDbb49DabEII/0f36FmiBDXGD9SOhsDOEAT5nj4bkIUDr2K5nHsu8xzcP3OEVgPb3kE003v
	9naZMEGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4N-00000000MHL-0J5k;
	Sun, 20 Sep 2026 20:23:27 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NMV-00000000IeP-2EWt
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:38:08 +0000
Received: by mail-yx2-x11.google.com with SMTP id 956f58d0204a3-66fded6b087so2183714d50.1
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933086; x=1790537886; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xd0t5fQ0wbqovFneONezXRLopfuFSVDwWIsqSLQ6+6E=;
        b=UKFOcbdWS9UX4Sedh8mEkstvE6tVlsl9ik176AX6WUTM6vlpsHAo31iss+QiqPe3HR
         LQct6J4AkjD4/eBpJT/naoOI8JmfM+M+j+fRxKPRjSyqgu258wH66MG2pMZvTvpk8xrz
         pApbq1Z4xHiAeMDkz/smDJOtrn93GbiFNinC8wlbL6AE/caCSYltteOzYDOrgXP9HPDU
         GQ7cmP0eD2ttwdcNjofZfqOkLpPz7GazdIH7MIjvoPleWZSOo8grlt3YicPfrHQ57J1B
         tJTGoiJr/a3It6jzlFN/NuQ0qdidTqVW46IlaLiLP79OEiCtY0DbRcLWjRQzbl9RwMMG
         toUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933086; x=1790537886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Xd0t5fQ0wbqovFneONezXRLopfuFSVDwWIsqSLQ6+6E=;
        b=QOTr9YTnMpmNShmeGGFTQ0hFbHBNC06pUJXfSK3IPSTojKn4yCKsD6+AVBzXRkutpQ
         BWaVW1lsJCcFHXlEulHIzNEbb2d2221EUk0ouZZlP2slRNJLH8k4lhfoP8OJlhaICSv+
         HcvumtBVnJffkBljJ9DKB9k8mBejFhix1kGLHMCKY1vJa4oduIArEjl/2NEdSxTJMkBH
         LPzcxfvPxjdCZsj9fEAgJ+/6vGxF2QLkKZA69MyHui/uXitOJoRGqpAFf0bSrb7Fb2eA
         TgUoE5Xs4EE0Zh/zMkeIl+CeIcwoo7iyLniaCkvDejLJaDGQyhu0v0kl6a5HpqTDYSle
         lIzw==
X-Forwarded-Encrypted: i=1; AKwUvBy+8OcqdNiMw874QKXCaYpZKY1dMEj7bh9SxHsxzKssKlE0YA/tBEb+EPwn/sm6AUdW+MgKKw==@lists.infradead.org
X-Gm-Message-State: AFuF++kyIb1rK3/0NUR5Z6Sx1R6B3dUwphtmSXCgYjPBF48IWAluW4VX
	/W0q347x01MBOtZ2KHWGkybmePQL28WzN7JjYvnVLFnO9tC8Ar0n3TJacwLuwaJB2Ro=
X-Gm-Gg: AYBFou2thq4dlTBf6WaOHtXvg/IsmL4ZbAJgxpJ8IxGIz9vg+HnZ3BnwIifbu8Lp5Ud
	TVuekExrlfuOOkG61oYrIXglU7UD4TA5x5q4KimHUmT1KihwsGYOSRQreIKkHr+recvm+X5nHed
	1CDshdP6pwfxhvgi2kZO/X80LpHfKWqCnkYR5urp0bIMmCc7CZ/WYeiqmh9shLUi48tscTQT/Is
	uW870eZYDR+xBz/yu22WikQyAUW7viQ8gMv7CMbYIuMBXBUYwknUcrazXvFN0ONFezwsEAEWXx+
	NzVkwndGfNuefvfqxfPfzucYDJEouZ32RByBEPc+pXI3GdvgH/0CKa9rNijAyXbdVBU7h/ggDy3
	PQrC4DOZcMrUWfCxBPr2h2/SsLy3K5KJfWR25cK/UTGdjZg7MhMnnQLWDgpIfnKfGqQeASYzB7A
	1M4u0+W/lps+VEwRKRWrhYs3MF4xq3K+NLxD/qKW0D4oCYmCCQsNpASo5RxfKILwcyBOkKAx1s1
	oqC7ZREaIWZrusmaRJffz48kwdLeBjrpQsV7cIVy1r4hQ3sdp5mwZ0knQS09Eav0a32yM0rlxyB
	oQiHs254tgOizvRyA34=
X-Received: by 2002:a05:690e:dce:b0:66f:c1be:a646 with SMTP id 956f58d0204a3-6717fd8f1ddmr2788927d50.56.1789933086522;
        Sun, 20 Sep 2026 12:38:06 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672991445desm2614214d50.20.2026.09.20.12.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:06 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 12/46] liveupdate: Add liveupdate_session_name() helper
Date: Sun, 20 Sep 2026 15:36:16 -0400
Message-ID: <20260920193650.3373435-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123807_603774_CE974931 
X-CRM114-Status: GOOD (  10.35  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:19 -0700
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

Provide an accessor function liveupdate_session_name() to retrieve the
name of a live update session from its session handle.

This allows kernel subsystems like CPU preservation to identify the
session managing preserved resources.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h      |  6 ++++++
 kernel/liveupdate/luo_session.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..119ad0f82705 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -256,6 +256,7 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 /* Get a token for an outgoing file, or -ENOENT if file is not preserved */
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 				  struct file *file, u64 *tokenp);
+const char *liveupdate_session_name(struct liveupdate_session *s);
 
 #else /* CONFIG_LIVEUPDATE */
 
@@ -321,5 +322,10 @@ static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 	return -EOPNOTSUPP;
 }
 
+static inline const char *liveupdate_session_name(struct liveupdate_session *s)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..3c4f195d375d 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -683,3 +683,17 @@ int luo_session_serialize(void)
 
 	return err;
 }
+
+/**
+ * liveupdate_session_name - Get the name of a liveupdate session
+ * @s: Live update session pointer.
+ *
+ * Return: Pointer to session name string.
+ */
+const char *liveupdate_session_name(struct liveupdate_session *s)
+{
+	struct luo_session *session = (struct luo_session *)s;
+
+	return session->name;
+}
+EXPORT_SYMBOL_GPL(liveupdate_session_name);
-- 
2.55.0.1082.g2b9226bbc0-goog


