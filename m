Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07D9D3941E
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/i6VxgmNfg5cptySEU9CsbiBxFSCKM3OfYrwIMNa32Y=; b=UMFGoqdcotV2v+kEQCf8hfS6Wj
	o72EytdDo4JRHwY7GWCofTMPNBOmy7i8w/ij9L+AE/IUxuxEFSXuda61Zv63If79IkbbK3BhpIT/f
	uru6dCB+4fZNxEtONnjaSUO6uVQs49ny/L5B/mx95Kx0CDfXAnFbNS1hVXDbeJ1qXmsWKNyIZyeK+
	eqEPFrUQivk9aPEhFG8h9anvoebTzpmV1+tWabBAlY7wt90utA4kpi5jMucE49GqwTc3s6wSEhobz
	AZPx0Rp3VVudzpqxY+E9oc0FCl1gOoJ3RXAsC0NX4W2qg1aGzPHtaboS/s1OpHrNNFLIwhNA1JYI8
	HCaGiphQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFr-0000000044W-0YRn;
	Thu, 02 Apr 2026 12:34:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ERE-00000002Yad-2i5F;
	Wed, 25 Mar 2026 02:57:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=/i6VxgmNfg5cptySEU9CsbiBxFSCKM3OfYrwIMNa32Y=; b=RTThtsxgOaBqLYfKGhsXuO91EF
	0vaga5hiSiK2H8FScmLm8PQdGtk/GhsaJV8CEfZk2xXh7lewf3jZb72X7l2ud3A34TAkuee1V5vcF
	V11ydGRYG/KeKbtRJ66SsVGTMy8a2bRXTadKMvSlsTmN8Y0+BS8EOvldm8r4g+IMRdPgaCCUvb+KF
	qogRyQIArf6fXt7iAVQZ6F/y8Pd53Q2eV7MFgej6aP0YEg98riUiKNAXtUTFHsJYzK+tYPbOqXMnb
	GaeLTRWlBJIKw3aIWnxlCrVIBkXOPYqstROFgFlGhkmFbX3aVupBOwp8qZw8venNfAmevuFCeby7T
	jmZx1Y6Q==;
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ER9-00000005JOG-1vuh;
	Wed, 25 Mar 2026 02:57:43 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/i6VxgmNfg5cptySEU9CsbiBxFSCKM3OfYrwIMNa32Y=;
	b=ivD1fPbTzEYIJATMUPqbbryzgl7/XSZpHThXqBefheozkff0gSztd7U9PEHTUquuHnasS9xc2
	mfTtj6jOikZBW+4M7XNr7Mn9Kz/8Fosc1CbU1SZGOjMp8hXNmqG/SEzSLJ+0fWa03btTTiY+eqQ
	6UVj+DXWUth+j08yU/82eDs=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fgWdr14vwz1T4Fq;
	Wed, 25 Mar 2026 10:52:00 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CFB984056A;
	Wed, 25 Mar 2026 10:57:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 10:57:27 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <ruanjinjie@huawei.com>,
	<rppt@kernel.org>, <ardb@kernel.org>, <leitao@debian.org>, <osandov@fb.com>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <eajames@linux.ibm.com>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
	<jbohac@suse.cz>, <fuqiang.wang@easystack.cn>, <guoren@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>, <james.morse@arm.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
Subject: [PATCH v10 2/8] powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
Date: Wed, 25 Mar 2026 10:58:58 +0800
Message-ID: <20260325025904.2811960-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325025904.2811960-1-ruanjinjie@huawei.com>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_025740_553773_D27F600D 
X-CRM114-Status: GOOD (  11.64  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:23 -0700
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

In get_crash_memory_ranges(), if crash_exclude_mem_range() failed
after realloc_mem_ranges() has successfully allocated the cmem
memory, it just returns an error but leaves cmem pointing to
the allocated memory, nor is it freed in the caller
update_crash_elfcorehdr(), which cause a memory leak, goto out
to free the cmem.

Fixes: 849599b702ef ("powerpc/crash: add crash memory hotplug support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index a325c1c02f96..1d12cef8e1e0 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -440,7 +440,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 	ret = get_crash_memory_ranges(&cmem);
 	if (ret) {
 		pr_err("Failed to get crash mem range\n");
-		return;
+		goto out;
 	}
 
 	/*
-- 
2.34.1


