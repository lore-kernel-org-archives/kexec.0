Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D802CE8D4B
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=igCLvLEtUCW/UbsBfP3ZrnZSCO09iCMGfzuHZKMcaqM=; b=ZdPI+hS558k2Vsed606CbBO5pp
	Nzs51AKpcOEXqcM/B7f+ro4EYJdVQopXU5tAAUIxGDjc597bXYElMTzA5F8CmELiiAK30W8G8Qm4M
	8Wl+x9Ddp4gO51zXhdSOXCB+dLA+CWU6g9kVxwLhyXE2AloHmgUOkTmh6+kaC2YETcZYcRCHkR8NL
	bC1geyk4NZUF1t84oOHocseQfb1hI7sP2VDm5QXOumXi26FlBgLOhZhW5c3xOvLfCOwIJH5354k4a
	oO4IR4Ww7YWKuwold7AlxNIn+LqGIyMpJgUOH9sUaIbFrElo3C4xwB8exMc+gAFbeN9uoRCC5yQsj
	uC5J/uvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7u-0000000CcrB-1n4k;
	Fri, 14 Nov 2025 15:54:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7q-0000000Cco8-3UVr
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 15:54:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=igCLvLEtUCW/UbsBfP3ZrnZSCO09iCMGfzuHZKMcaqM=; b=Bo8tNVtIGhia4w0c4TNAE7ijeU
	ewuJXSdR69UUi2qFtYOk253cNjQozglYYOpFxtiGO8JYC7kSZXnYzeJ3jWLMSePbsy+3McAB3Gj4w
	nwFD+1XzkWP3Maujv3NQ7uB5Zh12twja59GLegQg7Hby+IXbgTaoBrTXG7qWxo4GX8m5YR8Uwgstz
	rXTcCRpX2RQRVPx9dZweEgUN/YrIOhtfHMIcBAPvktwA4ME1bQxUemo8pCNjIQucH73vox/Jj8CE9
	OuSVLWqdMN6a2asHR9i5NoHE6i455zIvnujR6DcOCcIYSvnC896GHS5D0Kg3flDgtOueOPXw0fZ1+
	mvUHCdyw==;
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJvG9-00000002tBV-0NkI
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 14:58:47 +0000
Received: by mail-yx1-xb12e.google.com with SMTP id 956f58d0204a3-641e942242cso679900d50.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135650; x=1763740450; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igCLvLEtUCW/UbsBfP3ZrnZSCO09iCMGfzuHZKMcaqM=;
        b=PW2EU9dDCa3FtNtKhk6ujlfSWxvq6mV8n5pr4qrnuFvjfSdlprLeKxqCosRB/iqT+5
         yLTRDL//DxoWu3n9SZmey/O8+Bo76/+5erb9dUwwPN+lSWJIIIMZbsDOSFym8TFZihLp
         uopGAI1S2LsVjyLHqzQNaOtTvx4MPCdXy69dnqzVHveBg53qXxFMUWB2OkIvX1OZ35iE
         fY0ciZLGUP8At86kb4/kRB1a+PBCBHPhZmhBD47lFMfZglqdBaHWEcgbmgMV/AikSlDa
         /SK10zX1TNbhLXGf5bRgyuiaLWvtJNyammQQQZaxulY8Qyv/Lj0S/DBq1lgH8j8lC3Ui
         L+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135650; x=1763740450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=igCLvLEtUCW/UbsBfP3ZrnZSCO09iCMGfzuHZKMcaqM=;
        b=c3wP+aJcYnkqXOiCsvcCCruzbnoSXi1/lheXdwEq0KKyM+V2bgDh1y/T9R+/dRbOs8
         nsnyIYIG2Tba8y9r/NuYg7gWnJV45ilsubqNADNynys0PUJ2da4/l3NnCyuIP0X/mxwF
         t0/qhkf/kU9Vu1FkKY05t30luhahEc9R9F/FsAFQtfnl+cfMlHUJju1iQRCnHZN/R6+N
         Z8gj1QOZx5mP918CMT8dX27sLEKt7TQr6rL5lhoONyUI2tUCQJW1FbPlqD17C2QN+X1f
         MQp/9jLAjtNePYjbjHGVebHMBC2ENaO56+ZbGdP1+QXJOldLdJlxUFaaGvl7pnWwZ13E
         LOHA==
X-Forwarded-Encrypted: i=1; AJvYcCWvUTxtzhql7KsscgriO+KNF4eYOwZyVIVp/N/BR7XLIpFNvc6VstdRbthcRlV5b0EwPfDFpg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyySAAigeX3Pz1RASNv01BkCrgbJej8fTJl3IrRumOwQPLn5mFc
	DElw5vbQkOVcROwj1Jo/cwDN7pi8rRGbq3ViZfKHYkVCHkho0h1enslQdynUnRoFXnQ=
X-Gm-Gg: ASbGncskq1lJeYnMHw9b0R2m9U1Qwae5t+M49Q3klIUWyvM3SLVZwUzfkDqCohDRcjt
	IB9COOdrLbSkM9bRWCU5u+/hCjQxxSTu4ws0HbaYbvyqKcpEr5Sfn7aJ5IV8M5wYiow19QpaM4c
	RPR/UG8cmAQBzHNIQ7IA3kRYZCgFQRwO3ZEJUPOOiD6JhJS1amBotAhP9WRunSI6dmzAScfhYsw
	5qbt3FoIzMRwoWFSq3z+ORQldrJKQS5sIYPx9hv5H1AZZ0daI6c8RkLfqVwxonlY/5PPTPXlXUt
	nWX6BTqraktITqX9M2AskBMdU35OgjFZ5NfiVNxbE1uGtjvHHqLyzUj75A6vNiQ8os0SOqwId+C
	Te6jXKYSpPtyKfwNo7v1tk2dGFQAV+xY3sPy2TFKHxAR5eMbpDzpzwmtIOKJVR+Hqr0qsKWu8Yh
	PP5FH2/oDXNL1XOkQRJ60tcIUBw5DxWnPAVscjCPcKQkAVuqm1w81s7+tzdzvgIVMUtb+2tHQ0L
	GFiU0k=
X-Google-Smtp-Source: AGHT+IHbg7qHrmk7KLr97k4oOuXP3IULJ1XbsWmcMpEHUeh0oxpcL5aioIi8mM1kv7CPvyvvy//CpA==
X-Received: by 2002:a05:690e:d8a:b0:629:acb6:d8a with SMTP id 956f58d0204a3-641e7562fd0mr2830828d50.26.1763135649967;
        Fri, 14 Nov 2025 07:54:09 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:09 -0800 (PST)
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
Subject: [PATCH v1 07/13] kho: Remove global preserved_mem_map and store state in FDT
Date: Fri, 14 Nov 2025 10:53:52 -0500
Message-ID: <20251114155358.2884014-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_145845_237527_2E1C5353 
X-CRM114-Status: GOOD (  15.98  )
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

Currently, the serialized memory map is tracked via
kho_out.preserved_mem_map and copied to the FDT during finalization.
This double tracking is redundant.

Remove preserved_mem_map from kho_out. Instead, maintain the physical
address of the head chunk directly in the preserved-memory-map FDT
property.

Introduce kho_update_memory_map() to manage this property. This function
handles:
1. Retrieving and freeing any existing serialized map (handling the
   abort/retry case).
2. Updating the FDT property with the new chunk address.

This establishes the FDT as the single source of truth for the handover
state.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 43 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index aea58e5a6b49..f1c3dd1ef680 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -117,9 +117,6 @@ struct kho_out {
 	struct mutex fdts_lock;
 
 	struct kho_mem_track track;
-	/* First chunk of serialized preserved memory map */
-	struct khoser_mem_chunk *preserved_mem_map;
-
 	struct kho_debugfs dbg;
 };
 
@@ -380,6 +377,27 @@ static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
 	}
 }
 
+/*
+ *  Update memory map property, if old one is found discard it via
+ *  kho_mem_ser_free().
+ */
+static void kho_update_memory_map(struct khoser_mem_chunk *first_chunk)
+{
+	void *ptr;
+	u64 phys;
+
+	ptr = fdt_getprop_w(kho_out.fdt, 0, PROP_PRESERVED_MEMORY_MAP, NULL);
+
+	/* Check and discard previous memory map */
+	memcpy(&phys, ptr, sizeof(u64));
+	if (phys)
+		kho_mem_ser_free((struct khoser_mem_chunk *)phys_to_virt(phys));
+
+	/* Update with the new value */
+	phys = first_chunk ? (u64)virt_to_phys(first_chunk) : 0;
+	memcpy(ptr, &phys, sizeof(u64));
+}
+
 static int kho_mem_serialize(struct kho_out *kho_out)
 {
 	struct khoser_mem_chunk *first_chunk = NULL;
@@ -420,7 +438,7 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 		}
 	}
 
-	kho_out->preserved_mem_map = first_chunk;
+	kho_update_memory_map(first_chunk);
 
 	return 0;
 
@@ -1136,8 +1154,7 @@ int kho_abort(void)
 	if (!kho_out.finalized)
 		return -ENOENT;
 
-	kho_mem_ser_free(kho_out.preserved_mem_map);
-	kho_out.preserved_mem_map = NULL;
+	kho_update_memory_map(NULL);
 	kho_out.finalized = false;
 
 	return 0;
@@ -1147,21 +1164,15 @@ static int __kho_finalize(void)
 {
 	void *root = kho_out.fdt;
 	struct kho_sub_fdt *fdt;
-	u64 *preserved_mem_map;
+	u64 empty_mem_map = 0;
 	int err;
 
 	err = fdt_create(root, PAGE_SIZE);
 	err |= fdt_finish_reservemap(root);
 	err |= fdt_begin_node(root, "");
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
-	/**
-	 * Reserve the preserved-memory-map property in the root FDT, so
-	 * that all property definitions will precede subnodes created by
-	 * KHO callers.
-	 */
-	err |= fdt_property_placeholder(root, PROP_PRESERVED_MEMORY_MAP,
-					sizeof(*preserved_mem_map),
-					(void **)&preserved_mem_map);
+	err |= fdt_property(root, PROP_PRESERVED_MEMORY_MAP, &empty_mem_map,
+			    sizeof(empty_mem_map));
 	if (err)
 		goto err_exit;
 
@@ -1184,8 +1195,6 @@ static int __kho_finalize(void)
 	if (err)
 		goto err_exit;
 
-	*preserved_mem_map = (u64)virt_to_phys(kho_out.preserved_mem_map);
-
 	return 0;
 
 err_exit:
-- 
2.52.0.rc1.455.g30608eb744-goog


