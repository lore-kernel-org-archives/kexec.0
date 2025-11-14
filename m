Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04516CE8D4F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNA42wzRtY6tumJLzcBMrDKp0mvbCSdRF1f9tLE+ESU=; b=ylUX9aiHMBQsikpxL3oR0tYUOv
	ACS1xHU80urXfoKsbdVxQvTBQ2cghB8FWroLmVq8+q6IR8h0iQfmYzvIIybmwrX3KPwPi74LR7AwU
	u+BusWt/LXtxUokSVfn46zuciYYhhK783vy+PtnM1DYgWKTHut73IVFNO4F2XoaPs0/rFmkggg0Fg
	nyOcox90Z5hQz76lnumfQYL4Z3J1L3XB4uzNaPRZu0Ipapq9O5pnAoBuUVaLVB6BuGKx+w67TdDrz
	2L81M0xO7SiGFZ/bwgT3n04SM7Xh3FhZ+U3mJ+CWd4Oxxj8yloanMdRl3vJMpyJEe8b2te3XVCKt7
	+SYatetA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7m-0000000Cck1-0xYl;
	Fri, 14 Nov 2025 15:54:10 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7j-0000000Cchd-0G5L
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:08 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-640d0895d7cso2705361d50.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135646; x=1763740446; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNA42wzRtY6tumJLzcBMrDKp0mvbCSdRF1f9tLE+ESU=;
        b=NdYSbzoPQMXFC2DXSMk7lEQw+wE/Btrkd+emlvGToyAIZ9GYL82kH4ZA6GkYgYBJkl
         KfvJpAbi00y5L+pMrgoJTITD+7YnEDAI05gbz2adnmMugWfhvr/sqpV1DPYhcpYIC9d/
         FvwuNbv6ieYxpma5ncvz/I21U/o9JSLOKhEb5JDxyWaGgqmHdYUXQ1z5IDPrzn1+7m2j
         UPmCF78k57FUEId5qbsWChZLWA7E6D0VFM2ALJlnaiXqTrTwHCLcOjPkz4DTkjRczBz8
         W7rYQ76w1i2DZ1Bw1G2s0+sAFtsky31nlwSLRMbmPNH3Z0u7+7d4C8Uv82W+nixXv8DS
         ANqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135646; x=1763740446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BNA42wzRtY6tumJLzcBMrDKp0mvbCSdRF1f9tLE+ESU=;
        b=eMGJOvz5/EuMwBEe/w763HqRMMiZ2O7luYiUUQHuuTuHIP3xJIvDVm8YPKtnyGdwKx
         9265bsFgQQS+pIYZTbUmcIN+aePWzAZqHdBSCbE+MR0PkIyMDhC4mCAvnVkmc5VNuQzV
         /VVItvFDmuMyFlAhP2uvLWkAs2Wm/bL3/MvpKahv2zDXEhXSLLMXFOzkmdk53gjWEIsg
         ObOplWGsZz5S9ctiA02wEod9AdAHXd/Q2f+rIeua8CPBofp+bBud20VUTf5XgJjT6Kiq
         U01RJAmByXcXiF4qIA2YJ2RRZ99ZMWF+bvg3gr4ep7rNIGcMltBWM1MDsPCR9IBam4d7
         +9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCX3trHOnzyjQduRv9Sidy7kcREgXQpfXjuSbNAfp7l6ABzZ1eupfUgegdfa/ON3DltXnixRxw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2Zhsb7XOtgYyVFgoUP/4WKmlDAswtEHFb8gOyqolj8tVGeYz0
	T8KoUTSjYiRKNBZ7udy6awUuYcmqSOkoHvaVf4n8t27PieMrjCDTTK2V+x2NcawZ2S4=
X-Gm-Gg: ASbGncvae9eBt1YtLykI9aBLrmQoe43qZR/sl9OAL1GBN+TrLLLPy/V4VZXGccg3H6z
	r4TU8izF5XkhkrW/my3dk0ou3KXcwMelTCfv/Sb+pO/mjk81r3SAh51PUWoSlB9mtvs7oPgle3h
	T9iho4EOFy7IMv59a4zbsr8i0LszruiDylamSeK1ps9/1YFP80oltxgaTZm5qQAImoND0WBETt9
	xx/oYMrH6Z3PAyxLug63AkNkk/uK3dqZTtqfvbLItFnhDhFke9FMv5b+WSdKt1yqeXa1hqLskUJ
	qj7dOSz1uhTi/Ddc6cEokD0RqjB0DnyC4mGmoDo6lVl6zmx/K95oa2BcZnuAAoMHc/Aij+zAEHJ
	WdWGE4HpZSsRTmwcl3SE8Cv4r5PSlr887XARVOqzh73hQCfmavFjgVMOl2zIYVHulkWiUtw6pMk
	7dOz64d4/BjwtydkglOtu1Dp4mBbi0PoznCWxUydtaBZIeYyQTdcmoLcRXQi83OkPzE5Mf
X-Google-Smtp-Source: AGHT+IFexeZ69gOmsixo4URTVxxOjfKW66ZjvkgEzVhORcXdny0LfmoMUzobq4DDg3SxMb7wc7hsuQ==
X-Received: by 2002:a05:690e:4008:b0:640:d864:6e64 with SMTP id 956f58d0204a3-6410d0acb20mr6556525d50.14.1763135645970;
        Fri, 14 Nov 2025 07:54:05 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:05 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v1 03/13] kho: Preserve FDT folio only once during initialization
Date: Fri, 14 Nov 2025 10:53:48 -0500
Message-ID: <20251114155358.2884014-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075407_124520_6A905ECE 
X-CRM114-Status: GOOD (  11.78  )
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

Currently, the FDT folio is preserved inside __kho_finalize(). If the
user performs multiple finalize/abort cycles, kho_preserve_folio() is
called repeatedly for the same FDT folio.

Since the FDT folio is allocated once during kho_init(), it should be
marked for preservation at the same time. Move the preservation call to
kho_init() to align the preservation state with the object's lifecycle
and simplify the finalize path.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index bc7f046a1313..a4b33ca79246 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1164,10 +1164,6 @@ static int __kho_finalize(void)
 	if (err)
 		goto abort;
 
-	err = kho_preserve_folio(virt_to_folio(kho_out.fdt));
-	if (err)
-		goto abort;
-
 	err = kho_mem_serialize(&kho_out);
 	if (err)
 		goto abort;
@@ -1319,6 +1315,10 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
+	err = kho_preserve_folio(virt_to_folio(kho_out.fdt));
+	if (err)
+		goto err_free_fdt;
+
 	if (fdt) {
 		kho_in_debugfs_init(&kho_in.dbg, fdt);
 		return 0;
-- 
2.52.0.rc1.455.g30608eb744-goog


