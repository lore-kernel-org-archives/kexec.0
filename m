Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66772C369D7
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 11:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BSVU9eIBR3l15K077xp3Qt4+PcRGovcejmxiQIVjN6c=; b=3LSjWhGe8gfmyHBHF8UZ47wfyR
	1rfBDhgKaWBh0jTTZTMUX4YkV0n/OA4SDr/YJ5eELa+1q3iHr9V1hiP8txF/SqPVPTQS4UgzIMasV
	bkchzQINp3EL1QK2KvmbQArsVdYm5jPDOvE662TI7WCfnUNtJbRJyA3v5ZLmy5xtzh7DNlgJNxr+J
	Nw79yQwR2wKoE7huqRRVQiUhzSozs6Ofb+Qm31jqFltgAJ5NBG4lrKelwMRh1jTSPKgbXRD6WuWAF
	Ts/MnIAwF5L5fKKa6uk51TP9uwDtI9FM/t1TmqVnLjxAUg4GkUR1qbR8xh0Ojxx2IGo2OR5lohTSk
	oDgTsjaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7BNp-00000006rlr-1qy6;
	Tue, 22 Apr 2025 11:01:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Ady-00000006i5l-3xeK
	for kexec@lists.infradead.org;
	Tue, 22 Apr 2025 10:14:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ED13A5C5A03
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2025 10:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E83C4CEE9
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2025 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745316861;
	bh=GGZQLcehfLdHFNoOW9lBso9vDK2pIErN49tXTE/vl8A=;
	h=From:Date:Subject:To:Cc:From;
	b=VZ9zx+zTPKE/NCV0Wq78SMlgUy3Dcz/5WPkDmYu//lOhTJnnhi/goTpuRv+6xXrFR
	 w3plAwbbMeQcEYtYtzFLNxpziPUnjfodvG5wiIRbMFfhsKPCYfE3NHf5OMpGyQ3rHH
	 0g2dt8cMCM8O+7JWEAtQJKk1erC5o0sQhlW2UfSJUe/CR+/UFvud10xUYPEmbOn/m5
	 HDUosj5l6/A+Ls1qfuGC1IwxdvwONv95gKdkJ0NKiyQTaA42suAj8FcDEJ/q+GP9vS
	 2pm5aJCoO63u5eUyS0FY/ZKfRjfE38o1qWjDcQlsdbwpXCja4W5j8usQ1ZcILk5r5/
	 j9AqA8/Bx4ygA==
From: Simon Horman <horms@kernel.org>
Date: Tue, 22 Apr 2025 11:14:13 +0100
Subject: [PATCH] workflow: update to Ubuntu 24.04
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-ubuntu-24-04-v1-1-5ecea9f52f64@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPRrB2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyMj3dKk0rySUl0jE10DE11T42RzE0szY0OzNAMloJaCotS0zAqwcdG
 xtbUAuAdzd14AAAA=
To: kexec@lists.infradead.org
Cc: 
X-Mailer: b4 0.14.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_031423_040485_4C825C65 
X-CRM114-Status: UNSURE (   8.55  )
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

Bump workflow to use latest LTS release.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 .github/workflows/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 46edde66e384..fd9ea6c8eca7 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -5,7 +5,7 @@ on: push
 jobs:
   build:
     name: Build
-    runs-on: ubuntu-22.04
+    runs-on: ubuntu-24.04
     strategy:
       matrix:
         arch:


