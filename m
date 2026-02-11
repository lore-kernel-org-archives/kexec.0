Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B39EB597C
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 08:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ihJ36lzkXZ7WFB7v/KaqffqO3gp0QEVYrI9tOHAHfi4=; b=w7gqzKUhJ+xWzCPJWpWuRO5rYa
	qClM5tdwIZWNrOnkRkg8zRu1SiPQaubeRuVG/i6b6zmSyAI5oqtCXCxL/l1kTGilt40nffnslcqzI
	Fm0X1kIh8v5Lb3V+jLZpnPJ9bmyLSQcutm82hUqO0kIBstVG8pCHSTY4GLJ76BSeo/FbEUM3LxOXk
	qkeL1kjPg/8kyN2ly6Be4daGqsHVnIXN3VjZA0lohi/wqYLHLl0e+zYlSeep/nJRjhcRmicekPA+e
	1Z8A6L4+x3B6x0Ds84yQuv41hffxe2WZMvzi2hTrTX48lTqDUlELzUpwv3nUV2OsZUXc4ewQVk1K8
	bR5p2uDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq5WD-00000000O0Y-1X9c;
	Wed, 11 Feb 2026 08:24:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq5WA-00000000NzT-0sMk
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 08:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770798253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihJ36lzkXZ7WFB7v/KaqffqO3gp0QEVYrI9tOHAHfi4=;
	b=HGM0BIZ2j8v/Ckvo+ZUTjfoTeR8qZyKRQafo3MM46cOEZ8By7cR3hnNBDkpdpoh2T0WAIR
	1g2NCUsh7869SpDqdOch7vkAT3334XDhQqnXin9TR45qtZtSYB8+qsOoH59cseIazlnfKY
	8SaT6h7U1jMjbxPyHOUaGPv74O4pNPE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-4a00T37sMXCjXl629GRT3g-1; Wed, 11 Feb 2026 03:24:11 -0500
X-MC-Unique: 4a00T37sMXCjXl629GRT3g-1
X-Mimecast-MFC-AGG-ID: 4a00T37sMXCjXl629GRT3g_1770798251
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a79164b686so20584535ad.0
        for <kexec@lists.infradead.org>; Wed, 11 Feb 2026 00:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770798250; x=1771403050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihJ36lzkXZ7WFB7v/KaqffqO3gp0QEVYrI9tOHAHfi4=;
        b=eBfeV7c0oCd4b28tfkHknEKa9uH+bXUEFZ0fknMEdV51jQjsQdEV3nP0483rrcNf0j
         o82P477Z5B1VYwdw85g9EtIXH2GCpzo7h9v6g48OzccpJwAi3xUwtZ/+emjZCh5RakqI
         zF3m6ETdwMFq9atKKfjD4KkI1MUyOs++QJbLvVdSpFY5lpxgYFupS+bSQe8sWHWICSel
         FOwpkORpwAI54Ox0JMxK/ylgmmY9M/KoyHxdpRHXOmWS07sn/9qOB2ohOzFZ61G5eodj
         Tnp0TbOgZu3TGdYXAGbENeYyS1guHx2vCECkbS7eM0CN1ZdBCE8Z8f8tQg75xiXf1m43
         goig==
X-Gm-Message-State: AOJu0YzlS4X+fqhi/ejPgxOirs3RHmjuZFb3uqBefYYAsx2uoaELsIPC
	cvyNloyNqjTzsTb92hxehzWkdnNvr8PDtzj22NyYtxfUfnPEkVZCL4GuiKzsAAH0nNzVaU4sR7z
	7naxN0aJdevzrJq+KCSZ7VBugui6IndGJZQrxrEb28RwgSgYZAyDLOXZiLB/OTtGUp5bWDm053G
	iy3GRHIO3jk9KhmWPFqGntybuWwJ92lHL9tKlYBg6oQ64=
X-Gm-Gg: AZuq6aLIBZWO1FwZOK9VHrKHgMX0jQD602eBYKbM4N/DQ7xdIgT+/ye5pZIFaQmoLe+
	npH6UknFK+x4PuGpIzp5XRL8N1cQV/U73JFP8Aru9h2XkQGb5uIMtJ8uobmZHfU1D1B95lN8OxA
	N1coinGp/kFeCZg+q3CMZ5iEZsSRNyt7l6K8LHvWH1kTVB3CjmVHLdiycrk3OalM3G5cOb2ZVIs
	yFBXNaRscfN6LcITP06v8GfwbKV1YA1ymWRd3QttIXXYK5VNYQytnhRg9h9jYxCheZzPFUHKjKJ
	ZvwGJoce2gfHBKnHSB2u62eGvmT7ch/7sA5Q8is/05n0hxuUc6jfxWeyrqvsLIySg5V23qGK3vu
	iPnsP757cvOaN
X-Received: by 2002:a17:903:1a0e:b0:2a9:4450:abb7 with SMTP id d9443c01a7336-2a9516fcf6amr203049445ad.39.1770798250358;
        Wed, 11 Feb 2026 00:24:10 -0800 (PST)
X-Received: by 2002:a17:903:1a0e:b0:2a9:4450:abb7 with SMTP id d9443c01a7336-2a9516fcf6amr203049015ad.39.1770798249724;
        Wed, 11 Feb 2026 00:24:09 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29964c62sm14460265ad.55.2026.02.11.00.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:24:09 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v4 1/2] crash_dump/dm-crypt: Don't print in arch-specific code
Date: Wed, 11 Feb 2026 16:23:59 +0800
Message-ID: <20260211082401.2407853-2-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211082401.2407853-1-coxu@redhat.com>
References: <20260211082401.2407853-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YaA8oVJyyRYkC2VBgrrdp663qlM1ZaC1OCdlq4Bnzp8_1770798251
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_002414_313063_D042D5C6 
X-CRM114-Status: GOOD (  14.81  )
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

When the vmcore dumping target is not a LUKS-encrypted target, it's
expected that there is no dm-crypt key thus no need to return -ENOENT.
Also print more logs in crash_load_dm_crypt_keys. The benefit is
arch-specific code can be more succinct.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 6 +-----
 kernel/crash_dump_dm_crypt.c      | 7 +++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7508d0ccc740..d20cf976d01a 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -518,12 +518,8 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		if (ret)
 			return ERR_PTR(ret);
 		ret = crash_load_dm_crypt_keys(image);
-		if (ret == -ENOENT) {
-			kexec_dprintk("No dm crypt key to load\n");
-		} else if (ret) {
-			pr_err("Failed to load dm crypt keys\n");
+		if (ret)
 			return ERR_PTR(ret);
-		}
 		if (image->dm_crypt_keys_addr &&
 		    cmdline_len + MAX_ELFCOREHDR_STR_LEN + MAX_DMCRYPTKEYS_STR_LEN >
 			    header->cmdline_size) {
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 401423ba477d..478dacb0625c 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -405,14 +405,16 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 
 	if (key_count <= 0) {
 		kexec_dprintk("No dm-crypt keys\n");
-		return -ENOENT;
+		return 0;
 	}
 
 	if (!is_dm_key_reused) {
 		image->dm_crypt_keys_addr = 0;
 		r = build_keys_header();
-		if (r)
+		if (r) {
+			pr_err("Failed to build dm-crypt keys header, ret=%d\n", r);
 			return r;
+		}
 	}
 
 	kbuf.buffer = keys_header;
@@ -423,6 +425,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	r = kexec_add_buffer(&kbuf);
 	if (r) {
+		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
 		kvfree((void *)kbuf.buffer);
 		return r;
 	}
-- 
2.53.0


