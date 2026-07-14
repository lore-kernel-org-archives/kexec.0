Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81920C4450A
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 19:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LTqzSy9DWv8WYbFnX1nzfZq92Qbw+6Qv0/TERf7+X3I=; b=QPf3N3hQJlWRGSpOOXtDSYAkxN
	Zs/3mi2StkHEm7uwll3kvl3RLw2s6j7kmhw3JrfT8KX7J1dRV2LSuTqAkPGFK3rlPMOjiyoo1yJkm
	6iFvp0UCIPFBJYC/TJZ/u2VknNjyTeNBDhI2k4QmF43ZmIb7F82J2X/Kr9YkU5JHmN1Ystpho0hXs
	BJQHec3Tt4igzYseKddCjelSPHQV2/OxcUv2AUCNYERutWqP5yGtC+YmU2BtcUJnGQpMdclifaYv6
	xZoPxWVyzvCvA0gmgDF2pUwroS9hkqAlXff/dWLIxSawD+IHWYI1qEdOikLNaSV0feN+5kJ2Et+by
	aPX0cY2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjiqe-0000000D765-3v0c;
	Tue, 14 Jul 2026 19:31:20 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjiqc-0000000D75i-2JHl
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 19:31:19 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-51c0a81d286so9204911cf.1
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784057477; x=1784662277; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LTqzSy9DWv8WYbFnX1nzfZq92Qbw+6Qv0/TERf7+X3I=;
        b=Ql6VdDqPs0zRSeZiY+P4mzJHJ/fy9MmpPNeb6HkZOpuNR6YAjyC1RN8Oj1mEQdh3FG
         yzNX5bV8jDb7hmVMr5ZK0d6iAqSPhR6+6YPeG2N+XFlseCxIG1vz5I2J6BObNXE7FKHx
         8P7Mn1lAiA5LFBo7JklBuKpU06oJbFpfF9CRD3VEq+tVV7NQcVoAcGuv1Vhpte83++O5
         kUS3V3TbTnydsGic40UUE9h9zGW9Q8n2gXRdy0b1sjnbhix4VbtFGPEiXLJgbTN34iBO
         vZtoh2wEqcIOr3wKgEQEDteeIz46N9n/FUk7ftG+WLy1YlXZ1ZAmmWNkrmg8wwTN9oeU
         BlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057477; x=1784662277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTqzSy9DWv8WYbFnX1nzfZq92Qbw+6Qv0/TERf7+X3I=;
        b=TtWkbre5cMsvUHHzD2gjIP1zjBR9rveiiza2MKq45RDHhz21xw1ZO9G/lneOX7fvEr
         CkyzvKsxdPq3cdtztHLUlg5ZFiw7waOtQnApGPUecw5cDpe9E19IXruCt0lcvqKSu/Cn
         CE0DDTPxpiTty4a6s7RDXKOUq673+kgEOV+2XQoRn9r9l88HxxifRyQYaBjtZ1XcYve4
         jwSex7j9LXs69EX7GOKlsD+FAOHHoHeDDo2re5XhHf9RYD3Obg6ujAQi8FcuxY+jKJiB
         SBeCS6xLlKegspMbHEsXCk/+7Qv3RTpogul76p8QKj2o7hnL+QvFteCGoBTwEb7FD3SC
         NoDg==
X-Gm-Message-State: AOJu0YzilnDSrKpR81cgWaGdDDY5PLSwIeZ202bmEcd9+ksu2kpsaw3A
	fwFmnxhnysjTLQ/QEvRD2RXSBiGm4wJp1RrwEPDXix5nPzW+ypZWJF/hp165Bado
X-Gm-Gg: AfdE7ckXanc50zqJjF5J+i/Cci3plDq/rGL5ZUni8to7k4mfqAm6IMxXZCDzvecuhg1
	VzXIoF+WZGK7hWseTeEfbnjc6lWlcK8R9bOr9U65uXA8i067iRpCk1vH1eXNEgELQGh4YqBMhCR
	LTZOwFm9KvJOZeem63Wz1Srw7yApkgqTvF80gOuwjFhhg4zKcf60fhmhTiGYdNxuy2ePM2SjXmy
	bsuG62vT5n2g9ZodGfPAsCNzDsGxUGav1DtD2JAtlNYFLzW+pnQw4yYG5lihF+om6pVdcX+qEE/
	16DSpf1k8SmpxG4equwaSvdEV19RbhCdPD80n0B3AsPLF45gNt3CYN4D46TNg/NWjlxViRU4enp
	n/MDxj2qQlWQwv0oYWK7ivXCzZkE/MjmRh0lzkvz6fLdcGDxvT4TBihKPfLsAUTEEFrtOgEjSkp
	/zg6haGmaUrqW/uLg35fui9kiwCZI5JruRbJ+EvOnWA+ezQi1OEiaWT46fX+L8gn3waXPwZj4TM
	mRD
X-Received: by 2002:ac8:5f52:0:b0:51c:7aa7:e0ef with SMTP id d75a77b69052e-51cbfaeecddmr136788781cf.44.1784057476662;
        Tue, 14 Jul 2026 12:31:16 -0700 (PDT)
Received: from CW-D0XG2Q16P7-L.mynetworksettings.com ([2600:4041:5d66:ce00:556c:61bb:256d:59a3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae23f42sm118297841cf.19.2026.07.14.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:31:16 -0700 (PDT)
From: Maxi Saparov <maxi.saparov@gmail.com>
To: kexec@lists.infradead.org
Cc: Kazuhito Hagio <k-hagio-ab@nec.com>,
	Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>,
	Maxi Saparov <masaparov@coreweave.com>
Subject: [PATCH] [makedumpfile] Avoid glibc lazy-unwind machinery in parallel teardown
Date: Tue, 14 Jul 2026 15:30:45 -0400
Message-ID: <20260714193045.14773-1-maxi.saparov@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_123118_634415_2F2C26E2 
X-CRM114-Status: GOOD (  16.31  )
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

From: Maxi Saparov <masaparov@coreweave.com>

Worker threads end with pthread_exit(), and the consumer thread then
pthread_cancel()s every worker even after a fully successful pass.
Both make glibc lazily dlopen() libgcc_s.so.1 for stack unwinding
(misc/unwind-link.c), and glibc aborts the process when that load
fails:

  libgcc_s.so.1 must be installed for pthread_exit to work

In a minimal kdump initramfs nothing has loaded libgcc_s.so.1 by the
time the copy finishes, so the process-wide first load happens exactly
when every worker exits and is cancelled concurrently at peak
memory pressure in the capture kernel. Observed intermittently with
1.7.7, glibc 2.39 and --num-threads 2 on arm64 crash captures, aborting
right after "Copying data" reached 100% with libgcc_s.so.1 present and
loadable, leaving an otherwise complete dump marked incomplete.

This bug only affects dynamically linked builds, which is currently what
most mainstream distributions ship (Debian / Ubuntu build with
LINKTYPE=dynamic). Statically linked builds pull the unwinder
(libgcc_eh.a) at build time so there is no concern with dlopen failing
on teardown.

Avoid entering the unwind machinery at all on the success path:

- return from the worker function instead of calling pthread_exit();
  the return value still reaches pthread_join(), but a plain return
  never enters glibc's unwinder,
- pthread_cancel() the workers only when bailing out on an error,
  where they may still be blocked producing pages.  On success every
  worker is already exiting on its own, so joining is sufficient.

Signed-off-by: Maxi Saparov <masaparov@coreweave.com>
---
 makedumpfile.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 46d9ac7..5c8b60e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8790,7 +8790,9 @@ fail:
 	if (bitmap_memory_parallel.buf != NULL)
 		free(bitmap_memory_parallel.buf);
 
-	pthread_exit(retval);
+	/* Plain return: pthread_exit() would enter glibc's unwind path,
+	 * which requires loading libgcc_s.so.1. */
+	return retval;
 }
 
 int
@@ -8994,12 +8996,16 @@ finish:
 
 out:
 	if (threads != NULL) {
-		for (i = 0; i < info->num_threads; i++) {
-			if (threads[i] != NULL) {
-				res = pthread_cancel(*threads[i]);
-				if (res != 0 && res != ESRCH)
-					ERRMSG("Can't cancel thread %d. %s\n",
-							i, strerror(res));
+		/* Cancel only on error; on success the workers are already
+		 * exiting and joining is sufficient. */
+		if (!ret) {
+			for (i = 0; i < info->num_threads; i++) {
+				if (threads[i] != NULL) {
+					res = pthread_cancel(*threads[i]);
+					if (res != 0 && res != ESRCH)
+						ERRMSG("Can't cancel thread %d. %s\n",
+								i, strerror(res));
+				}
 			}
 		}
 
-- 
2.54.0


