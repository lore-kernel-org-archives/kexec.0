Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8123C54EAA
	for <kexec@archiver.kernel.org>; Wed, 25 Jan 2023 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1jYZ8a4Tf0TJKVHR+rkQgl48lmBTBoMzs4KOvBjKuwg=; b=Wfw8cMwLoMBNAjlupEv6hL+MTY
	RFJ3enRbMETOl7mqsT/jnHxRXD/bPPjrpCl7yHPkMPKnDpN0e1btofkzuzucTDRqGThZgJ9fJWdvV
	pHG387U+spgFzVbXBls1s+Q3/5suCIwpeaH71aG8wLM3Us/WcplKPdG3E7vQVcO51d01Sfwm+Ihnj
	DlirBkOA60x2plCmwQ3ZDexfqXWGM8Fp0XpbHJQZLe7fVksLuXDQWod9209U5enlZ/vTpEetmvk6J
	GBy/Q80B5C04L/JFoDK3VNQh+MwsZiEyhNWm2qeUgoqmLO0kCPr67pEQWoW/uFnRj1CXXo/6GKvDv
	AOmoCDfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKfaz-007May-Sv; Wed, 25 Jan 2023 13:13:45 +0000
Received: from casper.infradead.org ([90.155.50.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKbJO-006UNB-JI
	for kexec@bombadil.infradead.org; Wed, 25 Jan 2023 08:39:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mVuGMhZwlEMXe0FAwC4rLE7OnnAfe6cAroxVvXklBMk=; b=CAi5NHana2F69EPEMaqSDQLLCs
	v8fwQVXfEspdrqOsDfF5qyP5Rp24+6jCbRWGgYCqaswUbwzzwBt1/C0a7LvHJ7vTmhlf5i+J9tlUv
	TxpFNnZ/PvAJcoARJtpjDpFOionWYjoknWzVk63jnWSgARDz16t1f7/Ko4fodXEyG6BEwE5svty8m
	ILdaWPN8cLfJayMh5TpzL+OuiwCNbwng2cQTYm9nlCTDCLAVGXyIxQO92gJXunev3iWTFlBg+Lyka
	j1kMKq3tv3CJXve8WQTtXxup05lhUK6nYeWguCG8tKTtYyBQn+tMcm1id/3C47aJDimZoa3OGJxwi
	ZA6NYvhw==;
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKbJI-005mZX-2V
	for kexec@lists.infradead.org; Wed, 25 Jan 2023 08:39:16 +0000
Received: by mail-yb1-xb49.google.com with SMTP id a14-20020a5b0ace000000b007bf99065fcbso19067244ybr.2
        for <kexec@lists.infradead.org>; Wed, 25 Jan 2023 00:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVuGMhZwlEMXe0FAwC4rLE7OnnAfe6cAroxVvXklBMk=;
        b=VwtVZ3ffN/XX+4OSphvkCPu5LWSZpevMhnHytsAi7M7gsxKAkKbzq3/Ez6cAZGs+/z
         JzIcfmxATmRyceN+/Zt8AqltlXqbiRJWNjswPpQNjZE22YwQ3Z8QnOSAOet+uqjmXlIE
         OyZz8lnbt23bEWFA19bN7QyWM6BlHY9bxVkgVCuFfE21FaJHoilx3LiQj39QBuuIrUeb
         wQOUdgl76g8l+p4COnuz8oTsyo6A7P+o3cLtEEcXBMjD1VU3kk8/P76KYyyBr91hidcu
         b/JvxTM3TLDOWOtw79r0Hu/8F/9388RbMrqUiDk2vbRh2AxEmOh9ht/7njQAxt7Q0X5z
         07nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVuGMhZwlEMXe0FAwC4rLE7OnnAfe6cAroxVvXklBMk=;
        b=4OcPHBAqjAHTdhGd21Z+DWYK+3Xay8u1x7zU/lEigWJQPl7kKl5YDDfwzoJ0FkdX9O
         ZhH+6SLuz3cW5yOWx47civIIRCQFYB7I9x4sHVIICMZxSIiP2mBepfnXux/iWVJ5NDP7
         tGpII21NGESddQ8vD6lEy4nxZyWGjuuJv0lU87GoQgSlSkKYiES0JHEcLm0/1geL69nk
         z+8Rl8RECd8UaepWvSwBIqS2DuusOj3Bs/pOeN3XelNnslLeBXtsCB/+eJPqOvkdPjcz
         ct52seB3iwprLB6dA0Jhz3o4D6IHyk7vGfadGm1a0eXfEpeOnmDf12J8L1kSsdyzAL6u
         +9Cg==
X-Gm-Message-State: AO0yUKWQMz6tP6uwR+031yfMWnhQzWATs03vUwzCvffF4VLJacMhChow
	zsq35ZcBVAl4SUhQyq6GbRPoA7WThtQ=
X-Google-Smtp-Source: AK7set/eGcbmxK47Xow2TUKC1msmny+SAO+Fcyz1BhvcA/uBRY0Kash94Ztfh9nd8yz0OXKqanY9SYPz0MI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f7b0:20e8:ce66:f98])
 (user=surenb job=sendgmr) by 2002:a25:c247:0:b0:80b:6201:bee7 with SMTP id
 s68-20020a25c247000000b0080b6201bee7mr702095ybf.340.1674635945821; Wed, 25
 Jan 2023 00:39:05 -0800 (PST)
Date: Wed, 25 Jan 2023 00:38:49 -0800
In-Reply-To: <20230125083851.27759-1-surenb@google.com>
Mime-Version: 1.0
References: <20230125083851.27759-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125083851.27759-5-surenb@google.com>
Subject: [PATCH v2 4/6] mm: replace vma->vm_flags indirect modification in ksm_madvise
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: michel@lespinasse.org, jglisse@google.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org, 
	ldufour@linux.ibm.com, paulmck@kernel.org, luto@kernel.org, 
	songliubraving@fb.com, peterx@redhat.com, david@redhat.com, 
	dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de, 
	kent.overstreet@linux.dev, punit.agrawal@bytedance.com, lstoakes@gmail.com, 
	peterjung1337@gmail.com, rientjes@google.com, axelrasmussen@google.com, 
	joelaf@google.com, minchan@google.com, jannh@google.com, shakeelb@google.com, 
	tatashin@google.com, edumazet@google.com, gthelen@google.com, 
	gurua@google.com, arjunroy@google.com, soheil@google.com, 
	hughlynch@google.com, leewalsh@google.com, posk@google.com, will@kernel.org, 
	aneesh.kumar@linux.ibm.com, npiggin@gmail.com, chenhuacai@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, qianweili@huawei.com, wangzhou1@hisilicon.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, l.stach@pengutronix.de, 
	krzysztof.kozlowski@linaro.org, patrik.r.jakobsson@gmail.com, 
	matthias.bgg@gmail.com, robdclark@gmail.com, quic_abhinavk@quicinc.com, 
	dmitry.baryshkov@linaro.org, tomba@kernel.org, hjc@rock-chips.com, 
	heiko@sntech.de, ray.huang@amd.com, kraxel@redhat.com, sre@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, tfiga@chromium.org, 
	m.szyprowski@samsung.com, mchehab@kernel.org, dimitri.sivanich@hpe.com, 
	zhangfei.gao@linaro.org, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	dgilbert@interlog.com, hdegoede@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, alex.williamson@redhat.com, deller@gmx.de, 
	jayalk@intworks.biz, viro@zeniv.linux.org.uk, nico@fluxnic.net, 
	xiang@kernel.org, chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	miklos@szeredi.hu, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	bhe@redhat.com, andrii@kernel.org, yoshfuji@linux-ipv6.org, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, perex@perex.cz, 
	tiwai@suse.com, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, 
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-graphics-maintainer@vmware.com, linux-ia64@vger.kernel.org, 
	linux-arch@vger.kernel.org, loongarch@lists.linux.dev, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-acpi@vger.kernel.org, 
	linux-crypto@vger.kernel.org, nvdimm@lists.linux.dev, 
	dmaengine@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
	linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	xen-devel@lists.xenproject.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-accelerators@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev, 
	target-devel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-aio@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, devel@lists.orangefs.org, 
	kexec@lists.infradead.org, linux-xfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com, 
	selinux@vger.kernel.org, alsa-devel@alsa-project.org, kernel-team@android.com, 
	surenb@google.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230125_083912_638490_C963F7A4 
X-CRM114-Status: GOOD (  12.52  )
X-Mailman-Approved-At: Wed, 25 Jan 2023 05:13:42 -0800
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Replace indirect modifications to vma->vm_flags with calls to modifier
functions to be able to track flag changes and to keep vma locking
correctness. Add a BUG_ON check in ksm_madvise() to catch indirect
vm_flags modification attempts.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 5 ++++-
 arch/s390/mm/gmap.c                | 5 ++++-
 mm/khugepaged.c                    | 2 ++
 mm/ksm.c                           | 2 ++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 1d67baa5557a..325a7a47d348 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -393,6 +393,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 {
 	unsigned long gfn = memslot->base_gfn;
 	unsigned long end, start = gfn_to_hva(kvm, gfn);
+	unsigned long vm_flags;
 	int ret = 0;
 	struct vm_area_struct *vma;
 	int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
@@ -409,12 +410,14 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			ret = H_STATE;
 			break;
 		}
+		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-			  merge_flag, &vma->vm_flags);
+			  merge_flag, &vm_flags);
 		if (ret) {
 			ret = H_STATE;
 			break;
 		}
+		reset_vm_flags(vma, vm_flags);
 		start = vma->vm_end;
 	} while (end > vma->vm_end);
 
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 3a695b8a1e3c..d5eb47dcdacb 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2587,14 +2587,17 @@ int gmap_mark_unmergeable(void)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	unsigned long vm_flags;
 	int ret;
 	VMA_ITERATOR(vmi, mm, 0);
 
 	for_each_vma(vmi, vma) {
+		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-				  MADV_UNMERGEABLE, &vma->vm_flags);
+				  MADV_UNMERGEABLE, &vm_flags);
 		if (ret)
 			return ret;
+		reset_vm_flags(vma, vm_flags);
 	}
 	mm->def_flags &= ~VM_MERGEABLE;
 	return 0;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8abc59345bf2..76b24cd0c179 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -354,6 +354,8 @@ struct attribute_group khugepaged_attr_group = {
 int hugepage_madvise(struct vm_area_struct *vma,
 		     unsigned long *vm_flags, int advice)
 {
+	/* vma->vm_flags can be changed only using modifier functions */
+	BUG_ON(vm_flags == &vma->vm_flags);
 	switch (advice) {
 	case MADV_HUGEPAGE:
 #ifdef CONFIG_S390
diff --git a/mm/ksm.c b/mm/ksm.c
index 04f1c8c2df11..992b2be9f5e6 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2573,6 +2573,8 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
 
+	/* vma->vm_flags can be changed only using modifier functions */
+	BUG_ON(vm_flags == &vma->vm_flags);
 	switch (advice) {
 	case MADV_MERGEABLE:
 		/*
-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
