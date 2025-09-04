Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9B4CA1015
	for <kexec@archiver.kernel.org>; Thu,  4 Sep 2025 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bBcU+drWJ3hvUYUB+y/OOMDGeoQSncTsSGslGzeSXlM=; b=eNrn6eJhEDP6ebED1gb9OuuZaq
	dNInyof/tFxr7isemaGdSJ0yJOj101mqY2OVMCdgQBoxTNYHVowWpzmhxnQB2/MMMWddVf5lBcXuQ
	rum56tHNKHde/TG+x1l+tdB5k412COk4dUupylSB5aE8xVShBUbKrahK8kYowX1Y69h53fSe49moq
	vLPX9yluOnMxF0Rn/M7MePzr6GKHIpiNUT/gajoeJ7EQIbTegdlHhbhf3SIYo69ybQqw497PBxMxK
	28VLqjobqKTBIbd4iSn58eoSYZtJUfKqLiYPUPVvDIP5cJWryAGWAh8V4k9Vb+ZFtqACz2+7Y6MP5
	IiSTvxSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu7Vq-0000000B097-1J5L;
	Thu, 04 Sep 2025 10:48:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu6Qr-0000000Ac26-0LDF
	for kexec@lists.infradead.org;
	Thu, 04 Sep 2025 09:39:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756978742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bBcU+drWJ3hvUYUB+y/OOMDGeoQSncTsSGslGzeSXlM=;
	b=aCQKWBlWt2n5ecwf6urSQEvAniBX+bZ/q8XxFneuZ3/6xriRp/s+kthnU3FjPMImxGfX4h
	NJT3czIEu/YZr9D6HeHlVJFUDuVhEsDzh+vKMwe/bof4sK64G/iHE4yDXq7eXF+XDxV7dr
	S6p2HaoRF579uNFKVCOZChaC+cu/gLQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-qN8ftY6cNKyQs8kvrJKRtA-1; Thu, 04 Sep 2025 05:39:01 -0400
X-MC-Unique: qN8ftY6cNKyQs8kvrJKRtA-1
X-Mimecast-MFC-AGG-ID: qN8ftY6cNKyQs8kvrJKRtA_1756978740
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3278bb34a68so732075a91.0
        for <kexec@lists.infradead.org>; Thu, 04 Sep 2025 02:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756978740; x=1757583540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBcU+drWJ3hvUYUB+y/OOMDGeoQSncTsSGslGzeSXlM=;
        b=Ct0GUQAEHF9n+uj5SHK/kQd98ZjT485KhDjvAbuazcx+sS9nO7OSOmMyY3gIpXLd8Z
         DsBOt5pK2MvfWo1RQswkgr+Z7IqKYGNbLcjRcuu8m6ThcgCoTyL3zUPjXipG80yauH1F
         /30RQ+/5WEy7aiMWw79jjkS6vj32CyppIH2FeXUM9xAilSG9z3hsTosSOY2S/cBQwVlh
         UiFVUE6t7bCo3SRT8Z+qvb3mR/L47BR4jt9LPSvD4YpNVwgFLeRWcXbejNR0cnGSeMht
         Mo8N5bzS7+g8vB9PNtJZlpg7CFzXi+peEqDDM94XpEXBOw4orCSX0ANKsrZxo+NLMV11
         6l9Q==
X-Gm-Message-State: AOJu0Yw7L7gppPm/UFayFRiEbo8Y8Mo+TtnWTWK4ThEhfznYVgLFXVfG
	0gaI4FscDRj4TEs4DLChlGN2JJEFTVZKpXfcEchLpBdEoEEuH2sk/q9LONkwk1OCUUbp9sqGWCy
	ER/Y1GAF8UBPneCHtSgMAxe6s0l1+Td7iLKJcyK3JAw9V+oV19DG72frakPR0V16zIIkZrRHhqS
	CCkNhRR9/4ZaPdCJE2J7+DOpC71oEH/L92/Tpr56QJGPuZ8g==
X-Gm-Gg: ASbGncvC6+ziHV9x3t1qtFTvL+vsgaz4212FCXjbExH1TwBRJrx1eGLcc5LYwYg1qAo
	fqmDHut3bD/HxR9SSXMYCQ6sUCP8BCpMe0EdYscGcC/WlOcgGhwP22bNEBmj5WMjUM5KTEmCE9w
	DFz1alPQFcKeXF8SMEzI5ocFg8A30/GmCD0HW/WVvQlgNNLwcjXc3hZLDiCplp8iXfyl5qJp/iz
	LKK0SMglsyzgFkThdESaR63ZCYZq145U3pENrm4uhHocnDbMB3rwR8lFgjmvVLHQhaoBWAp9mDi
	ewNLtDZvnUSMvrBrynqAHwwDYFr+jtI=
X-Received: by 2002:a17:90b:38c5:b0:327:c207:b3fb with SMTP id 98e67ed59e1d1-328156cc954mr21219724a91.25.1756978740226;
        Thu, 04 Sep 2025 02:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmAXPmAL5N6uswnGBHysh3EB25MAwxpg6uYHvn+wpMjFnTWn4DyTfl7/V8xNgx5Kkp7ntNlA==
X-Received: by 2002:a17:90b:38c5:b0:327:c207:b3fb with SMTP id 98e67ed59e1d1-328156cc954mr21219683a91.25.1756978739508;
        Thu, 04 Sep 2025 02:38:59 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm16676762b3a.67.2025.09.04.02.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:38:59 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: fuqiang wang <fuqiang.wang@easystack.cn>,
	x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v6 1/2] x86/kexec: fix potential cmem->ranges out of memory
Date: Thu,  4 Sep 2025 17:38:52 +0800
Message-ID: <20250904093855.1180154-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9PEoBtmhE9dcBErzYD62NRBooos-cKNQhaErX6q9ZyQ_1756978740
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_023905_202149_60CAE683 
X-CRM114-Status: GOOD (  17.45  )
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

From: fuqiang wang <fuqiang.wang@easystack.cn>

In memmap_exclude_ranges(), elfheader will be excluded from crashk_res.
In the current x86 architecture code, the elfheader is always allocated
at crashk_res.start. It seems that there won't be a new split range.
But it depends on the allocation position of elfheader in crashk_res. To
avoid potential out of memory in future, add a extra slot. Otherwise
loading the kdump kernel will fail because crash_exclude_mem_range will
return -ENOMEM. random kexec_buf for passing dm crypt keys may cause a
range split too,
add another extra slot here.

The similar issue also exists in fill_up_crash_elf_data(). The range to
be excluded is [0, 1M], start (0) is special and will not appear in the
middle of existing cmem->ranges[]. But in cast the low 1M could be
changed in the future, add a extra slot too.

Previously discussed link:
[1] https://lore.kernel.org/kexec/ZXk2oBf%2FT1Ul6o0c@MiWiFi-R3L-srv/
[2] https://lore.kernel.org/kexec/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/
[3] https://lore.kernel.org/kexec/ZYQ6O%2F57sHAPxTHm@MiWiFi-R3L-srv/

Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v5->v6:
- rebase onto v6.17-rc4

v4->v5 (Baoquan):
- This is on top of Coiby's LUKS patchset in branch mm-nonmm-unstable of
  akpm/mm.git. I did some adaption based on Coiby's patches.
- [PATCH v9 0/8] Support kdump with LUKS encryption by reusing LUKS volume keys

 arch/x86/kernel/crash.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c6b12bed173d..5efdcd95a283 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -165,8 +165,18 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	/*
 	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
 	 * may cause range splits. So add extra slots here.
+	 *
+	 * Exclusion of low 1M may not cause another range split, because the
+	 * range of exclude is [0, 1M] and the condition for splitting a new
+	 * region is that the start, end parameters are both in a certain
+	 * existing region in cmem and cannot be equal to existing region's
+	 * start or end. Obviously, the start of [0, 1M] cannot meet this
+	 * condition.
+	 *
+	 * But in order to lest the low 1M could be changed in the future,
+	 * (e.g. [start, 1M]), add a extra slot.
 	 */
-	nr_ranges += 2 + crashk_cma_cnt;
+	nr_ranges += 3 + crashk_cma_cnt;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -323,10 +333,15 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	struct crash_mem *cmem;
 
 	/*
-	 * Using random kexec_buf for passing dm crypt keys may cause a range
-	 * split. So use two slots here.
+	 * In the current x86 architecture code, the elfheader is always
+	 * allocated at crashk_res.start. But it depends on the allocation
+	 * position of elfheader in crashk_res. To avoid potential out of
+	 * bounds in future, add an extra slot.
+	 *
+	 * And using random kexec_buf for passing dm crypt keys may cause a
+	 * range split too, add another extra slot here.
 	 */
-	nr_ranges = 2;
+	nr_ranges = 3;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return -ENOMEM;

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.51.0


