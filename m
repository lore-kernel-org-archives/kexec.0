Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78CE60A262B
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Lxppy7nl;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=i9tWsjS4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OO34thgIpfnBLKDxy+V7gJ/LfMCRQ5G6mslroPjHH60=; b=Lxppy7nl9+/9H6zZxblc0mWUzz
	05CcXBs/IM/0E+4Ln6vobz08VaxARhjQthETrotyl92ZycDPS5RaZbjJoHBdAHL8K749azzImull9
	KjK9OH3XZmTlIQU3eUkBMXrVWGEYpU+f9ADZnbQGCRRqXO551XaNpeJZtNaYtnEy5e0MnS5ZSRsG+
	gcDbYK+M/1hsvG6/EkxpKEN5BJn0D4v8QorXf4dOZy75nb7nSs/TLP5lk9OzqTP1keRooSbqKmUDD
	LBFf+k3JMIhQIZsZTlkGDjAmdbR596Ps0gvitB8lqGM6o299H4+SDJLmMH6E9HAMW7Us5FWmW7YMg
	n0bseY/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR38m-00000005xnH-1u2Z;
	Wed, 11 Nov 2026 07:53:08 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR38k-00000005xle-1WMH
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:53:08 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4b467581b98so26276065e9.0
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383584; x=1794988384; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OO34thgIpfnBLKDxy+V7gJ/LfMCRQ5G6mslroPjHH60=;
        b=i9tWsjS4OqpDqx7G4ohwuZmOFNGpsXKEee625dqAh2S5Qo0Mc0OLJtxPwp8iZveOUg
         z0OcxW/TqYuQkDeaR/nokQY6rTQOfdQtPpgi0h8xuaZ9KovKaARAufmt6RgreT910S45
         4gyMJERyBx/w4ld2O72FGUc+4dEXdrEo7SCww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383584; x=1794988384;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OO34thgIpfnBLKDxy+V7gJ/LfMCRQ5G6mslroPjHH60=;
        b=lnyHzx+JKZjRBdHxxTKqB7nguVUIiBJ+hZ1wr2XtqkjkTHpJ6sWRH7yWPuJ1XhVOD0
         6LO5UmZxQIXwZRcSWKQuxfKDtCDKTWQVo+lNPMeTO0SjOiABZq9ie7/+7SQU7WVis6tZ
         Dq8xcMTtrmGRuimmL3gzGw5ti0JMMF3nLxNgZzNto1fWsXR04wVA/v58IGkPtIQiRbu9
         maPBt4tiE/kDdE43YHz//cC0XA2hpezykH8uDCvEP4gD2/2oyqpcOcwZ013EFRJgTeLD
         Ns288eZVhbUNFZc8nBrd3TRcZeRX3F5YPjwxSDMkn7agRnHoDRVULVwhC+37limt0Fmr
         dt9g==
X-Forwarded-Encrypted: i=1; AL+hErFQy6EAsl9srMZsTaaOHBsYS3UF5qurgL3wfj7be3sYF+0bZ1xD6wFCoL9hpaN2HKYJrblhDw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8fkTXJzieETmhdq5dA3KnjD0GO4elIwXuI9nhVg2VCWGqHOKBl
	didYt6HPcYHh0abo+0WBTHsjYByK1ehRsA1dk66I6p8+VnQvcqZxvpJzANyWXQYp/Ow=
X-Gm-Gg: AYBFou0wsQqkUc8rVGAhcwp9AmE6IA9pdvKrSbEuGRsqs7kXQ78OIIsjTzyyYiq+k02
	k2L5TUCvwl6SCmOF6IOq+6sg4fe292YDJHDaDxdPu5bNsyhobLO797KqdsWlNplMFSb8hKvCiaV
	TjbvCSNukQY1WZfDT8O+VHaUgstWhAAjrkytjPt0nACPoyht1HDLIzHNWSZdEsBcUQ3LCnoJuXQ
	MbM7tGe/M1veIlq50TpkP7/7h6mYEwbzf9Ku41HCyR7tMkMve6iZSgJ7Ssmb61kihDftFtJIslB
	6DVylfMFFN1pWbNU+7CR3Jj8j9WnyuuQzgzyzVPbHepM97hMVqQ5xZqUhcb85HHh0KtNs7/LWbM
	RY5GKe6IxZvcPB4oVFdHjGWAB3BNvD/6jEap+ySvSfv/9loh54Fgdi69USB2L2RhBquiZqlIUj3
	TH/UDVt4MfZImFUNTVFSTkszpAIZ0gowS4Xkzq0Qx+YXPahYDxmTcGlDTgIkvBpI9mGUNJOYx7W
	R00bs9JIvwdWv80jvuUQ14pGk9bIU8TQK7j42ai2UKljvAkYqYN6/sLEoT15NUwQcYqY5Jzndo3
	lmTbyeL/rbn79zHu3G7+5yNg750nr+y+wu7qe4UwmK4O2UkQ6ro1cuaYZyd9rREyjHo1gKrLGDQ
	cJx5uZODwnoO6AZFaoMflpAYiqC4/kKmGULemM7Lv4nquQYl7VB7JvyoUsaRrkO8xrQnfUjyQpI
	qrnCsZK8H18unjqF1xmsn4EYre7SXv/1rXWHIElh3an+fJhRXA47Wp
X-Received: by 2002:a05:600c:3508:b0:4b2:3c81:d1 with SMTP id 5b1f17b1804b1-4ba093811c8mr23533605e9.5.1794383584057;
        Tue, 10 Nov 2026 23:53:04 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a763sm120391615e9.4.2026.11.10.23.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:53:03 -0800 (PST)
Date: Tue, 10 Nov 2026 23:53:01 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/9] kho: Make bootmem reservations visible to fleet
 monitoring
Message-ID: <c41c639fc5f453d60a265ba42a233f2ea5b48319.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794383544.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235306_451854_0B1B7B87 
X-CRM114-Status: GOOD (  23.20  )
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

We want to use live update at Meta to upgrade hypervisors whose VMs
can't be migrated away first. But this poses a problem: whether we can
enable KHO on a class of host depends on how much memory it leaves
available for unmovable allocations. In an early test, a 64 GiB host
with hugetlb_cma=6G set aside about 30 GiB of bootmem, which the running
kernel can only use for movable allocations.

The reservation varies with the kernel, memory size, NUMA layout and
command line. Our fleet collector needs the actual size from each host
so we can decide where to enable KHO and catch a kernel release that
takes those hosts over their bootmem budget.

Today the collector would have to sum kho/out/bootmem_len in debugfs,
which isn't a userspace ABI. In /proc/meminfo, free bootmem contributes
to CmaFree, but the reservation doesn't contribute to CmaTotal. The cma
count in /proc/zoneinfo includes bootmem after a cold boot but not after
a KHO kexec. On an 8 GiB QEMU guest booted with
kho_bootmem=32M,1536M,512M:

                CmaTotal  CmaFree     zoneinfo cma (all zones)
    cold boot   0 kB      2127872 kB  2129920 kB
    KHO kexec   0 kB       881336 kB  0 kB

Even if bootmem becomes a CMA area, CmaTotal will still include other
areas such as hugetlb CMA, so inferring the bootmem size is still
error-prone.

Let's report the total bootmem reservation in bytes at
/sys/kernel/kexec/kho_bootmem_size.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../ABI/testing/sysfs-kernel-kexec-kdump          |  8 ++++++++
 Documentation/admin-guide/mm/kho.rst              |  9 +++++++++
 include/linux/kexec_handover.h                    |  1 +
 kernel/kexec_core.c                               | 13 +++++++++++++
 kernel/liveupdate/kexec_handover.c                | 15 +++++++++++++++
 5 files changed, 46 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
index f59051b5d96d..80941a7d8a7c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
+++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
@@ -59,3 +59,11 @@ Description:	read only
 		to the crash (kdump) kernel. It lists the start and end physical
 		addresses of CMA regions assigned for crashkernel use.
 User:		kdump service
+
+What:		/sys/kernel/kexec/kho_bootmem_size
+Date:		Nov 2026
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Total size of the KHO bootmem regions in bytes. Returns 0
+		when KHO is disabled.
+User:		system monitoring
diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index f9d2cc5999ee..c329d720bf25 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -81,6 +81,15 @@ At scale, correlating crashes to the previous kernel version enables
 faster root cause analysis when issues only occur in specific kernel
 transition scenarios.
 
+sysfs Interfaces
+================
+
+``/sys/kernel/kexec/kho_bootmem_size``
+    Total size of the KHO bootmem regions in bytes, or 0 when KHO is
+    disabled.
+
+See Documentation/ABI/testing/sysfs-kernel-kexec-kdump for the sysfs ABI.
+
 debugfs Interfaces
 ==================
 
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ef2b188c8ed0..736d51e79fd2 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -40,6 +40,7 @@ void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t bootmem_phys,
 		  u64 bootmem_len);
 
 bool kho_bootmem_overlap(phys_addr_t phys, size_t size);
+phys_addr_t kho_bootmem_size(void);
 
 static inline enum migratetype kho_bootmem_migratetype(unsigned long pfn,
 						       enum migratetype mt)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index f4a31565c447..ed105e6351eb 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/kexec.h>
+#include <linux/kexec_handover.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/liveupdate.h>
@@ -1324,6 +1325,15 @@ static struct kobj_attribute crash_elfcorehdr_size_attr = __ATTR_RO(crash_elfcor
 #endif /* CONFIG_CRASH_HOTPLUG */
 #endif /* CONFIG_CRASH_DUMP */
 
+#ifdef CONFIG_KEXEC_HANDOVER
+static ssize_t kho_bootmem_size_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)kho_bootmem_size());
+}
+static struct kobj_attribute kho_bootmem_size_attr = __ATTR_RO(kho_bootmem_size);
+#endif
+
 static struct attribute *kexec_attrs[] = {
 	&loaded_attr.attr,
 #ifdef CONFIG_CRASH_DUMP
@@ -1335,6 +1345,9 @@ static struct attribute *kexec_attrs[] = {
 #ifdef CONFIG_CRASH_HOTPLUG
 	&crash_elfcorehdr_size_attr.attr,
 #endif
+#endif
+#ifdef CONFIG_KEXEC_HANDOVER
+	&kho_bootmem_size_attr.attr,
 #endif
 	NULL
 };
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 3046b89e5db4..21d77e29d2bb 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -942,6 +942,21 @@ static void __init kho_reserve_bootmem(void)
 	kho_enable = false;
 }
 
+phys_addr_t kho_bootmem_size(void)
+{
+	phys_addr_t size = 0;
+	unsigned int i;
+
+	/* kho_init() can disable KHO without clearing kho_bootmem_cnt. */
+	if (!kho_enable)
+		return 0;
+
+	for (i = 0; i < kho_bootmem_cnt; i++)
+		size += kho_bootmem[i].size;
+
+	return size;
+}
+
 /*
  * Look for free blocks of 1G. This is a heuristic chosen to work efficiently
  * with large systems with hundreds of gigabytes of memory. It will work poorly
-- 
2.54.0


