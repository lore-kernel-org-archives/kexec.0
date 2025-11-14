Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A4ACE8D76
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUeee70aoCoEDH7tpogbMA7MC1e04DJkCX99vV5Wq8c=; b=2iO1liCvbfBUuxMQ83VRY5cGh+
	zTMqmN1yb7+7cghOIIYb9/B2w6DBJJaDnctuXuNfaC8jp4QiVF7o8wutRN7cyJu2d5hXHRzxxrPYN
	WwCL9ptFOjvQUF95JYZIIm7W7A+YseBcrEm9VSTqfuD+OX28y1S+ZVs8n3ox0kxFshMMAwPspXT0b
	5ivjcjlzJZvKAddJqmHYG0z45EcO1VlFmSpRVsh6UFu08P5a5rEQHkrtrybhq+i+AHQ7UVhzvWnJ3
	mDEzX77DrSUz/BtvXOXQJ67U3uXZrzEPYzSdgvIS8qpKEqJyKQkThoKvrc3lDsta8Yp6Eq6VKocso
	uknRuyqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1z-0000000CzWE-07Kk;
	Fri, 14 Nov 2025 19:00:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1x-0000000CzTH-3tEh
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 19:00:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=kUeee70aoCoEDH7tpogbMA7MC1e04DJkCX99vV5Wq8c=; b=Yg8loIErYz1vlMrQi3kQf42ayR
	KHKBbTNTvIJTLW10JF7Vd9iF8uNSoNY2lhcAyZSGl95mjFSwMTcgUZ9gHBOibGBM+/OEyZFmU/98Y
	9p2tlUxnF2YTExL846duyNh+jD0zzoT2dqV3wklCQOgfFSfjQhqEhT8iKNXEXFApvIBoDB3KR4rCI
	qCm3iXFrO8GZIuVnXD0NKCWFRnI2IrQXU06tuyJYqN7OSXIG5KYX5uG9DXawW8PbzDEkcykhnSJkn
	3C3Smoxxa9+dL6oZgOohhDAbIxohiPZBkKcDs0mZrf1sYbQgj2v/dKWQv18tgnlH3pOnDB4HYmpyS
	HJUrz55g==;
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJyAG-00000003Jom-01eV
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 18:04:54 +0000
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-640f2c9ccbdso2066603d50.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146817; x=1763751617; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUeee70aoCoEDH7tpogbMA7MC1e04DJkCX99vV5Wq8c=;
        b=aCwp7KMYPWVxO17vivsQhos05P/S8vNuvZFg/12pb+4a5DhYL+R6iUlhGP7cS5nR14
         xR5LSBG2xKGh+ia2qC5C4cz/W4t6tugRVVOH+phUDNPfYs/yvkxCOoGjA+qhosPEcO0q
         XqDN5VSzIa/Ex5MzwiOVLE/3SPZ1ciAG7d/bLXAUL5TGdrHw+iPBfliObSewnYMpJZu/
         9/78utDh+yPgKmTrIf9V6/UTtSOy2u9aLLCG1v3mPKaekkW7syiuEX5tKfqUeaIt9Ytm
         lIINMvEopMuRmhIh87T6gk0IS3h1iCd/1SVByGh3sZJre8VrUC+yfP7AuZg1UHTmUhGL
         Dt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146817; x=1763751617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kUeee70aoCoEDH7tpogbMA7MC1e04DJkCX99vV5Wq8c=;
        b=wCUDu4JgpBbMLJmQxzvJcqoS8z9kpRADxEkZEzPEPqjFSA4Ftx2KzH8qY4bTyzt+Fc
         UT9nDXYydDjA3b9YEfjGvEoPB0iGnQ2Ogkd4KHgo9fn3qm+NMJOPopv/TQ4oMOkP85SD
         AVspo2YENpQp5Zgp5ZqgL+aur9NhyW7lYDOXPUhqmqbopmNegxtmYpGpRgwSwu8wHTrC
         +7iQHYNprbiZvQiQowzOaFQmuVcbujKLzkAi8rFibNzYMec4fuFj452hKZLsuYd9PgOA
         VME8s/235RFvONt51aUCUfJOIEsGbHi3xyivcM76SGCrjalolZViPn95xRlfhyQmkqBk
         rIIw==
X-Forwarded-Encrypted: i=1; AJvYcCWphZLtsy0h8AtcOpzFFJSB6CCf0YdEaZpgDoI4Nv/Ggg53dCc59j/+L39VdDv9wqdltNw1UA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzzWqwzokqhFaHnxzhb1kEjwfOZsuIeppfsiR4cPwBks10g1il7
	BZq0MRAoj6eSUvYmCTXmz2HNRzLn5xpAFck8P5YAaPHR5nHukBFoMvp/1enL7k4Yz9Q=
X-Gm-Gg: ASbGncuEN4W3LoIXl8PfSAzM/mc/tYD4FwAk1t2fdmhvCMO1pLASLJIUY1qAtHtRtkQ
	pnDMOdGbLVYF9UIUFBuiXRQbGFcAwgpIqjo+ZwdpgDqu0b+i2Y0cDHe3xNZIhh31rBwt4uSIv0y
	mVbm28+DxMcrKaxB2+tzWU8up2nxnn7rG8GBM4m9VmDUOeljcneKppm6hgxGy8xpjkdpTMN9rLt
	BoCgjhzIv6iKoH6I7Mebe4Iq7gHoXsKgoKiLrWp78HnYMfT70ClTgWo8q68rWeKlwrvevV/Vls/
	SH/LQviN3AUoAZWB8kEom2tzqQaCF7E8DFxwERmTxudlm1Yk2YPDrTTD2krsIxX8svCWR1bAAJz
	ilWDBLwykRpLpK3ddviaRqf4LgqCvXbTrWPeMbJsMDU2t27OuSu/twESnXk+7LEswDRAzJpT0Co
	U42NYKXng7t70M7HZkkPGXuh6xQX/2WLUlToxtX/BR/Bpk/XwgoO4SFv3CXbChj0O3IeL2h02z2
	YkA3Bc=
X-Google-Smtp-Source: AGHT+IEDAZBpiF1oFEsVLGFJo+UdrqqTZLyy4yADm49I+si1ealVeGbZmEoKhxOu20FcmsBgPYr9rw==
X-Received: by 2002:a53:b10f:0:b0:63f:9c11:cfed with SMTP id 956f58d0204a3-641e76402b0mr2553029d50.32.1763146816706;
        Fri, 14 Nov 2025 11:00:16 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:16 -0800 (PST)
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
Subject: [PATCH v2 09/13] kho: Remove abort functionality and support state refresh
Date: Fri, 14 Nov 2025 13:59:58 -0500
Message-ID: <20251114190002.3311679-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_180452_184445_45267F36 
X-CRM114-Status: GOOD (  14.69  )
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

Previously, KHO required a dedicated kho_abort() function to clean up
state before kho_finalize() could be called again. This was necessary
to handle complex unwind paths when using notifiers.

With the shift to direct memory preservation, the explicit abort step
is no longer strictly necessary.

Remove kho_abort() and refactor kho_finalize() to handle re-entry.
If kho_finalize() is called while KHO is already finalized, it will
now automatically clean up the previous memory map and state before
generating a new one. This allows the KHO state to be updated/refreshed
simply by triggering finalize again.

Update debugfs to return -EINVAL if userspace attempts to write 0 to
the finalize attribute, as explicit abort is no longer supported.

Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c          | 21 ++++-----------------
 kernel/liveupdate/kexec_handover_debugfs.c  |  2 +-
 kernel/liveupdate/kexec_handover_internal.h |  1 -
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 63800f63551f..624fd648d21f 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1232,21 +1232,6 @@ void kho_restore_free(void *mem)
 }
 EXPORT_SYMBOL_GPL(kho_restore_free);
 
-int kho_abort(void)
-{
-	if (!kho_enable)
-		return -EOPNOTSUPP;
-
-	guard(mutex)(&kho_out.lock);
-	if (!kho_out.finalized)
-		return -ENOENT;
-
-	kho_update_memory_map(NULL);
-	kho_out.finalized = false;
-
-	return 0;
-}
-
 static int __kho_finalize(void)
 {
 	void *root = kho_out.fdt;
@@ -1297,8 +1282,10 @@ int kho_finalize(void)
 		return -EOPNOTSUPP;
 
 	guard(mutex)(&kho_out.lock);
-	if (kho_out.finalized)
-		return -EEXIST;
+	if (kho_out.finalized) {
+		kho_update_memory_map(NULL);
+		kho_out.finalized = false;
+	}
 
 	ret = __kho_finalize();
 	if (ret)
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index ac739d25094d..2abbf62ba942 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -87,7 +87,7 @@ static int kho_out_finalize_set(void *data, u64 val)
 	if (val)
 		return kho_finalize();
 	else
-		return kho_abort();
+		return -EINVAL;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(kho_out_finalize_fops, kho_out_finalize_get,
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index 52ed73659fe6..0202c85ad14f 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -24,7 +24,6 @@ extern unsigned int kho_scratch_cnt;
 
 bool kho_finalized(void);
 int kho_finalize(void);
-int kho_abort(void);
 
 #ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
 int kho_debugfs_init(void);
-- 
2.52.0.rc1.455.g30608eb744-goog


