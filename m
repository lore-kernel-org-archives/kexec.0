Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E36BCD343F
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AJmba2SxX4nhPogxtHtVcmYAhy7NbrUuv2ce99+duXI=; b=IKaVzfm+4TLvtcBeS+SIJiDePm
	IS2hoqQ3eCo4iGAdF5pBs8sDkigmjuWT6iVhXb2ecdhgAbkzpd/G1fDjRjBEAFMnGyQ0hT65dV2bS
	8uZU97WBN7SxwPsdIqke/VdlRaWHVh949yzEnuKMwrUPGeqOEM1IIKe53/Zxk0UuoesDooKTbywYR
	GnMullzhAbTbBT49yw//w2eqzsxd4kOihoYdnYIkw8gY3vC+7+R/qWOtXnaWUYJfBUmctMLkE2cwK
	KJ9kC1VHwUF8I/5l3wlNcNJdu0HG9ZBL6nXXmfwxRZGN/BHnAGo2qwHDIrV/Hg80hbvEq94dgVcz+
	5O11fr5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgrf-00000001lAi-07rc;
	Wed, 06 May 2026 18:20:55 +0000
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgre-00000001l9s-0Bo5
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 18:20:54 +0000
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-6530287803cso7032020d50.1
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778091653; x=1778696453; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJmba2SxX4nhPogxtHtVcmYAhy7NbrUuv2ce99+duXI=;
        b=Zlr31m9R/GfVgXFWCgX9jQIWXzd2H5qkxralUBBExasVzuVKmD/0/JRM5I0DJtM6Vh
         +lz3ZQ+k9bijh6AnshJWfkCZ0ccPjcWpMtgviU7bBra37zxFcqx67mGZwqz7SADPbDoY
         rle1qwXx3+uTZztUUnxUCreHb2hVYfysyzuijlaKAHpIDE7xeyxUT1bqoJKi756JTQtz
         f8St/pNrWx2KRlbGIcmrhVFFehxt3FM3A8T2d2guf3guurB/c/haJH+M65Du21iMDIEG
         RclbScyWTsI3Eu3Ryyn0NvBpu2v6oiwaC2B6+c50VWUnjQz58ULyM/s1BDJ2p/D+5dI4
         VbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091653; x=1778696453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AJmba2SxX4nhPogxtHtVcmYAhy7NbrUuv2ce99+duXI=;
        b=SfBUztRVxa9ik77RR0L4rm10btASDfHCrfTJQZQoYGOV/MHPwgb21PigT311BEPjvd
         CX7WeX5S0vQ2S8gNJhdT/X1uF9hriIInq4X/d/VZ4J1cA0lndEniJ4I72uR0WjCAycc3
         vGlSMYWek4KcKHh7ppx0eCrKEhRUuVUwCsTK4FVvXjlAMcQ14j/HDgCM3GPGVgAaGueP
         Npda5AyBbYApvtpB1wvHZDivFLqum4zlm84Y+GEIKn1oNpxjJVJI/vqSSvOpGtlLn4nv
         QxR+IDpk+PYJRrW6TkGbackOtdhMsvixIHM6xOWWbVB3eYRZBX1nOfJBiQGTLbMKT01L
         TkjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KZ2LpO5TQGioJ/ZBgn2oz0t6w5ggsaWkp/5godyE5IU1/T58zFuKpyxQAdWzSU5htpZc6Wg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwgYSSKEii7N/HpqAOhhj2caNgQubdvupYvE7CCw4BoDBBwaf9M
	2gxpJyod8f0W3ae1BIGbQJmgl4bf3yGOL3YmmCI3o14d5u33nPgs4rcjNEv++lwxOzA=
X-Gm-Gg: AeBDieu3B8vHBJ59fktQ7pysmSp/ulho/TqJjtvYn4mBIGAx0/0/eYWMb6XR/+swvH9
	KIEOUNPbLs883fMHSUi4PUaus8En7O+52FM8z0Qlwo0zFCQz8OpURg3LlL4FJR/tW3cMo1Qbdfh
	PvtHsjFnD/G6Y/LJXDzDVgaxXlmP7V+ubWsMeuqX9qgudJ4chO2O7jkwcZ1Tp8YCdEvVagMTBLU
	a6f5V+RU2HAdm+ujYrAi+PMfaLZ7jEM0WcqKmIifikKClMdHloc14caYAws4C+IGMY/g1ATAP4x
	azNe7N5j5SgeX6lY3dkJf7uBuil7OL6rNsM3dH7fnsGCqGd+SFfd7VACiq++IeS5rKLjX3pVhBT
	EYfU/Q2Q2LHEOH3as+El1qJF/bkZBClKsxTWvTkh2asRR2UbFxbYZ6TLwklYXP4pDtiYM5YQS6X
	suiySNZwFc+Z5voNfSdEvGPa7CUAhCGx70hh+Q9hJ/PUZ1mJo583qERIlxdzzpg4IGsk95sv/Zk
	R61Iutf/bJ8FdJka081UPvnDmQO52mKWYav1myVzL1AZM++hTlGOpS8uUnn
X-Received: by 2002:a53:df50:0:b0:65c:1a0f:d8b8 with SMTP id 956f58d0204a3-65c79905398mr3711532d50.22.1778091652897;
        Wed, 06 May 2026 11:20:52 -0700 (PDT)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7af9f8e7sm1389917d50.13.2026.05.06.11.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:20:52 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com,
	changyuanl@google.com,
	mario.limonciello@amd.com
Subject: [PATCH v2 2/3] liveupdate: skip serialization for context-preserving kexec
Date: Wed,  6 May 2026 14:20:42 -0400
Message-ID: <20260506182039.2623553-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
References: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=pasha.tatashin@soleen.com;
 h=from:subject; bh=TWl94CwLxW3IjwCRKLhFCgMgquV90wVhjyKe40N294Y=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBp+4Z69J88+nkglNXrvKB3IepDP93CUFYvFWwGF
 oCjzLkChRuJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCafuGegAKCRC7dyhM23N6
 3tuSEACovUz5sKdV9Ff958EgDEwTN/HgyvwgLP2h9YFNQzKmSyfT6D6+Dsn4VxJ2zZG22Hck4D4
 euQS3vMKEpLfFbb7npsFzjo+/B/f9mxqaBYNKp++N6PKuWdM6P9Jlh55I/EN5zcemF/9+e2vXyz
 XJUf8EsXSMmuL6CsEySgMc6cF+8hZ9H3bUH+4vN6nWyyoe8PZD0d7Hhq9ROL+j89WDrs44hyYCr
 U2NpohG4vS39ANnTFjX+tYjoK3q3pfaCvFaBEEDpgwXFHIPzieU+GQX9P+sXYxqCkyA7G5xeBio
 MmwKpYDu3XABeRoHxXn5CZc/QwE7ztBVcotuLX7ipwqeOuVTcC+MO0uePdDW1SpfRr3wducrQR2
 3+4Vst0kcLRDAIkrYAFVBGFkyxIYfZ73GrvCIqWItcGTlXIJ1CbQD8YGXa2HK4lsJmnkFe4tC59
 CqZIzCPFJFe773dm0MkfzhXEnUtvGlHdNKrfGoaLH3uF8WPaR1nr/bM24yK+Ekr46sImu6zyd2v
 hLT45c8Ab97VfZjKtKhUZK/lQUXr9FI2xFV61Ykz7fKaSpIjlzesFHSnK+qEtnVWKMRcM8HgQj2
 cg3c2Ae4UaWjuuxenxg/bfIWJD11Z8YiLY7oP8i6yZSXp9rmgahzDuHhYHvX5YC4eFTO9f6kPJl QF/P2sjJQuYmDlg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp; fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_112054_088941_C6FAD2FC 
X-CRM114-Status: UNSURE (   9.91  )
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

A preserve_context kexec returns to the current kernel, which is
unrelated to live update where the state is passed to the next kernel.
Skip liveupdate_reboot() in this case to avoid serialization and prevent
sessions from being left in a frozen state upon return.

Fixes: db8bed8082dc ("kexec: call liveupdate_reboot() before kexec")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a43d2da0fe3e..dc770b9a6d05 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1146,9 +1146,11 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
-	error = liveupdate_reboot();
-	if (error)
-		goto Unlock;
+	if (!kexec_image->preserve_context) {
+		error = liveupdate_reboot();
+		if (error)
+			goto Unlock;
+	}
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-- 
2.54.0.545.g6539524ca2-goog


