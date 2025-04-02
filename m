Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7C5C3601C
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pL3ZRyfio2uIX3TrzfP4lwxC86hOBPNScu2MCFNBrag=; b=dZWnTKdkvhkUQZGgeYRwVqyow3
	YEuq7AeTq6GmcoIDVN9NDlJTnHfpUES7tZC35AZu7PmAz/NvbYFTpSOZ3JPYHNdgTugz+6618RWL2
	uFGp1JucK7TerXGTLY59+oUrIg85GE3J0jTktD8TIoZFzIApeNizo2pDAMho24LJjSvjNH35cF+Qq
	IMPoxTRGsHIl4u9aQQ32Pzer6QdM3ZWdpDNN/tOAC3z4THQ0hwwjQNX7gJic18x0vNPhD3QgfuMny
	v2rQbhkMktBc5pZ8TS1SxAdrW1tvozVIqJB5w2Uk1w97v+Ec60tVZVbQKkVi8hDj0N6kjqo1/EDfS
	BNxKpLKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzxZE-0000000691Z-3RiH;
	Wed, 02 Apr 2025 12:51:40 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzxVQ-0000000689E-04pr
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 12:47:45 +0000
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5AB832041314;
	Wed,  2 Apr 2025 05:47:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AB832041314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743598063;
	bh=pL3ZRyfio2uIX3TrzfP4lwxC86hOBPNScu2MCFNBrag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0z7C6O6DQzbIyvrwGX05zSK0RLYv9bQfd7pijoDyzANgXnejWRJlKt7Zw7j2vcG0
	 eIuIPl4SSoThDxG282nMSlyldt5q4hopNmiXM25x6DBtRP2Ws/vMk+V8XZ8dhJT3AV
	 yxXuxieAfDmgkz97+P7odpZ+nSyNBcToweL3PyIg=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Subject: [PATCH v11 3/9] kexec: define functions to map and unmap segments
Date: Wed,  2 Apr 2025 05:47:16 -0700
Message-ID: <20250402124725.5601-4-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402124725.5601-1-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_054744_120512_F3EBC11B 
X-CRM114-Status: GOOD (  24.73  )
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

Currently, the kernel behavior during kexec load is to fetch the IMA
measurements logs and store logs in kernel memory. When a kexec reboot is
triggered, these stored logs in the kernel memory are carried over to the
second kernel. However, the time gap between kexec load and kexec reboot
can be very long. During this time window, new events extended into TPM 
PCRs miss the chance to be carried over to the second kernel. This results 
in a mismatch between TPM PCR quotes and the actual IMA measurements list
after kexec reboot, leading to remote attestation failure.

To solve this problem, the new design defers reading the IMA measurements
logs into the kexec buffer to the kexec reboot phase, while still allocating
the necessary buffer at kexec load time because it is not appropriate to 
allocate memory at the kexec reboot moment.

The content of memory segments carried over to the new kernel during the
kexec system call can be changed at the kexec 'execute' stage, but the size
of the memory segments cannot be changed at the kexec 'execute' stage.

To copy IMA measurement logs during the kexec operation, IMA allocates 
memory at the kexec 'load' stage and map the segments to the kimage 
structure. The mapped address will then be used to copy IMA measurements 
during the kexec 'execute' stage.

Currently, the mechanism to map and unmap segments to the kimage structure
is not available to subsystems outside of kexec.

Implement kimage_map_segment() to enable IMA to map the measurement log 
list to the kimage structure during the kexec 'load' stage. This function
takes a kimage pointer, a memory address, and a size, then gathers the
source pages within the specified address range, creates an array of page
pointers, and maps these to a contiguous virtual address range. The
function returns the start virtual address of this range if successful, 
or NULL on failure.

Implement kimage_unmap_segment() for unmapping segments using vunmap().

From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h |  6 +++++
 kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..7d6b12f8b8d0 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
 #define kexec_dprintk(fmt, arg...) \
         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
 
+extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
+extern void kimage_unmap_segment(void *buffer);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
+struct kimage;
 static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
+{ return NULL; }
+static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0bdc1686154..a5e378e1dc7f 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
 	return result;
 }
 
+void *kimage_map_segment(struct kimage *image,
+			 unsigned long addr, unsigned long size)
+{
+	unsigned long src_page_addr, dest_page_addr = 0;
+	unsigned long eaddr = addr + size;
+	kimage_entry_t *ptr, entry;
+	struct page **src_pages;
+	unsigned int npages;
+	void *vaddr = NULL;
+	int i;
+
+	/*
+	 * Collect the source pages and map them in a contiguous VA range.
+	 */
+	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
+	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
+	if (!src_pages) {
+		pr_err("Could not allocate ima pages array.\n");
+		return NULL;
+	}
+
+	i = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION) {
+			dest_page_addr = entry & PAGE_MASK;
+		} else if (entry & IND_SOURCE) {
+			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
+				src_page_addr = entry & PAGE_MASK;
+				src_pages[i++] =
+					virt_to_page(__va(src_page_addr));
+				if (i == npages)
+					break;
+				dest_page_addr += PAGE_SIZE;
+			}
+		}
+	}
+
+	/* Sanity check. */
+	WARN_ON(i < npages);
+
+	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
+	kfree(src_pages);
+
+	if (!vaddr)
+		pr_err("Could not map ima buffer.\n");
+
+	return vaddr;
+}
+
+void kimage_unmap_segment(void *segment_buffer)
+{
+	vunmap(segment_buffer);
+}
+
 struct kexec_load_limit {
 	/* Mutex protects the limit count. */
 	struct mutex mutex;
-- 
2.25.1


