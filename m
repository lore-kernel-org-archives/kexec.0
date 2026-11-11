Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4960A2619
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GVkXxwKB;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZP6GDQ+U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HqU3Pl0zqzkcuaNDEwB/Ax9fkH+ammw/qBuPNlSTruE=; b=GVkXxwKBVlF2NvjmMlT/2K5/lI
	+AaBXzjlj2cbLknoS6J80xQtGxpTVTCZ5lHYaf+1U/1KJBsR1z2Z3wIbMEX8lw//WffDe0tTEMOMd
	tQYg+MBsDSfoSgcNW+DXL9KfGIeH7a9OD9rbKsg10is8fhDDff8v8tYfiQokWH9yBN5aUwad152Eh
	/Q63/xmZ4K/uo0uj4JHoYySMh05ho2NTHNfBm3IaovnbuuuDs+x/SfETlLM9vh3H2xI3NlGTVmb7X
	AFhhvRgLybtsW18Sa+3JTkbzZwBVY0YYbPWyo87ETarKBNbZ1JeKZp4TkPMUVryrvLDDWIBCIMYZx
	vut+4rTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR38g-00000005xjm-1Sqo;
	Wed, 11 Nov 2026 07:53:02 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR38d-00000005xiL-3piR
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:53:01 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so2277313b3a.0
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383579; x=1794988379; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HqU3Pl0zqzkcuaNDEwB/Ax9fkH+ammw/qBuPNlSTruE=;
        b=ZP6GDQ+UjEdcfLhhaInlzs7zT1INfaWubdSwkiaGWMTVVkD2GT3GOfNAmfLv+ac/4e
         mQae25igq7FjO0QRNauZCzeQnesJe/q8qA67e3P73lzSLBnqneutUukuY4VlIG+6xtw6
         YquU+N1UwSxYdYBRCkZzN108yXPHwbRMwW37o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383579; x=1794988379;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqU3Pl0zqzkcuaNDEwB/Ax9fkH+ammw/qBuPNlSTruE=;
        b=QqFsSj02VWBV51F/ZYSfR4GFu/YIU4p29I/qJDP6wsRGTI3BYQ/32arpkR3E4KHFf7
         RGipZT1YEcLsBCWYb36AQ9wb3tco5xsWi6F0LSQaOIRxORFi5UpXlpyFJHwE5flNl+RM
         ZQYM2+bxS1PmUbhuVswhWYDKQviXYpBePNQV/FR0RF3iEA9GPqGRkd5OgdSGq/x6bp2f
         PvVnzv8/CgzFhSPZ8f0HVNqQDh4PyrdPVEuWpO3SMvt05kDW178VNEBPTwhI8NSq8K2G
         tR2uFzTOS9+0g0zIRNdodu0S2syZDg/BFRj7pbrCZoZGcrS+pMty1J4irosDaluXTsB4
         VUaQ==
X-Forwarded-Encrypted: i=1; AL+hErFlVCP7CBzp0JCveYVE/kA2lxQmsHYKCuzc4MrcLbTz5FDrlbgjNnKLUY0uk5C+gendZcm6Hw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8yS0+yOSmPQjklMySjfDVTjDX15L6huJmlOLz7Xi5yutlKcWEk
	49WuxPMOnp8LJKPS4YaPn03el6Kdlpt/ZfvacWODZQ+IPUqKq65t/5rTSAH4WB5iyOo=
X-Gm-Gg: AYBFou0Zd8rao1CeyqJVtTFW+iFz6RIRxtNuhq4he8EtjXhNvQbJCaC4/kxhKMbdeTQ
	4EpzNK3WyVHiV7kTURmm+58DMS4YPUHEbQybsN4/Cnp0kGzpPz7c7rKV7pXS9aXlkqg41Qmd6uP
	LBw6d/k8YBahfs85FA7GZP3/1eF24OqTKTYAa93+i5Ap0TuxlJeNMss4mjd2GdQqpbfWIewFeT0
	1psKiv0l/w9rnAjGpeQa5r1orfK8MUfD0iPuRG9zpnLDiXrgcsrvkYDCX6cg3Hnc4oQRoXWwMXy
	i3SbjISqSbt5MC7RZVVw57Hq3iX1Y00w4o/z0/mRwCCzQe4Zryo2a778OcLMfS+0/NJYgCPw0yT
	msLobOw8U2hTJ/h0VxPf3CbCAtCZ1tTq7IQECfTCj4JHMfiTvYjZwKThKE7IV/OjxV5O8Bm4NXW
	sxpH+pgUxBcUSFHmEkRo5URA2gD2ehTLoI0Y61T6f6P5xIFYfIkm5qktoUhPRuv1B5F0FzF7x6v
	f4i0e1e/HD3ofZld3kpoWq/cvoGzKVsllhytONW5FHwUrPHMrwac8Zf4HHX+cJCWCf3fIlsga3V
	JAemhFyxwpSh6rKO8x9rUk/G808vg1vYNC2dRtII3yS5jj6jqQkJAZy0p4qdjmxiBFtzKrxD4BE
	mqwrBZXRptB+u17W62la0cdYgVvHRGYL+ZodEW5L8WN4ZvmzOBA3gZ+eqZ6T6OorDEsohJPH9J7
	TX690tdXQSupPcJR3sc1uEy4wEP2lW1I79Z+4ulTU7vU8HNW1357yt
X-Received: by 2002:a05:6a20:431a:b0:3e2:47ab:6a25 with SMTP id adf61e73a8af0-3f2fe3d4734mr1995928637.46.1794383579151;
        Tue, 10 Nov 2026 23:52:59 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86e030sm1861501b3a.27.2026.11.10.23.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:52:58 -0800 (PST)
Date: Tue, 10 Nov 2026 23:52:55 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Alexander Graf <graf@amazon.com>,
	Baoquan He <baoquan.he@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/9] kho: Reclaim the metadata page left reserved after kexec
Message-ID: <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794383544.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235259_954706_5A6FDBB1 
X-CRM114-Status: GOOD (  15.88  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After a KHO kexec, the new kernel keeps the page holding the previous
kernel's kexec metadata reserved for as long as it runs. It only needs
the page once, since kho_in_kexec_metadata() copies the previous release
and the kexec count out of it at boot, and nothing reads it again.

Free it with kho_restore_free() once copying is complete.

Fixes: 76aa46b9e404 ("kho: kexec-metadata: track previous kernel chain")
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/admin-guide/mm/kho.rst |  4 +++-
 kernel/liveupdate/kexec_handover.c   | 10 +++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 902d171a780a..f9d2cc5999ee 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -120,4 +120,6 @@ stabilized.
 
 ``/sys/kernel/debug/kho/in/sub_fdts/``
     Similar to ``kho/out/sub_fdts/``, but contains sub blobs
-    of KHO producers passed from the old kernel.
+    of KHO producers passed from the old kernel. A blob disappears
+    once the kernel has read and freed it, as ``kexec-metadata`` does
+    during boot.
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index eeec298aa9d6..3046b89e5db4 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1808,6 +1808,9 @@ static void __init kho_in_kexec_metadata(void)
 
 	pr_info("exec from: %s (count %u)\n",
 		kho_in.previous_release, kho_in.kexec_count);
+
+	kho_debugfs_blob_remove(&kho_in.dbg, metadata);
+	kho_restore_free(metadata);
 }
 
 /*
@@ -1885,14 +1888,15 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
+	if (fdt)
+		kho_in_debugfs_init(&kho_in.dbg, fdt);
+
 	err = kho_kexec_metadata_init(fdt);
 	if (err)
 		goto err_free_fdt;
 
-	if (fdt) {
-		kho_in_debugfs_init(&kho_in.dbg, fdt);
+	if (fdt)
 		return 0;
-	}
 
 	for (int i = 0; i < kho_bootmem_cnt; i++) {
 		unsigned long base_pfn = PHYS_PFN(kho_bootmem[i].addr);
-- 
2.54.0


