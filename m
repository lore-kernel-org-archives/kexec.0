Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE408C55162
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QeeiJuN0Sjy8Uw4/dZUmNBcs/fHlw0WPwV83tkIdEVg=; b=r5ygyp0XtaTc8mGlE/ELVNZq1C
	QsRjaOQv9ti2WE7Us9X8nlqtnHZmhw/SvD/AAeVjETeZQ/HS2OnXqWrB2FQNfZXMb27EzEDL3539A
	gg0DgUtDuRl8GLFKQZoWtXRBFvUMVPtzQcO31Rlc+lhNFXdoZjBcJBRDqpJOSDP3jPsuxeGYit9uZ
	ql//MLnqNgyacSJ6W1Db+A3ZV0719HLxfeVrUUJa+FMFPZYh8D+DHLvwadxC1ZR1DNCunKpGDZUNj
	UzYv6MzMIf9VEgO3vtFuH9O/QQwA+kSskAbFIkIqwANOjb5L1+T34v64L56tw+SuN+g8BL8O3OIbV
	RQ2Zy1pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpT7n-0000000Ata3-1Cm2;
	Thu, 30 Jul 2026 15:56:47 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpT7k-0000000AtZB-2KCZ
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 15:56:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=QeeiJuN0Sjy8Uw4/dZUmNBcs/fHlw0WPwV83tkIdEVg=; b=AO8WA0+f8euqq12EwlE6zqlxnv
	bkJcCAEfvbZtCzu2GRYOo/JcSRlVreUSCg6WY9xv4LT6+aQWoSzsnaITVSe64UhU6BhO17W7fwEKq
	JnY4W/TQ2dBGUyxthRtbEOCxmciMfK8cmiDsbBK8Oa96wXKXkD9g47ST3hjmIz0mXMvL9UdRJL4sI
	5hYmedxyI4p71RsrwunJCVuttRx/IepHMHFHSq8QfLHLe9wQl+TknlJfAC15NQrBqQDTLtRm35eHb
	80/EC8q6AOwntSOUPFy6Qf7QjSRrXAyonJ1RlJSTzOKlne0IhGJDpa/G5y7XeLSSdGGa7gpiM0KtQ
	rpye85kA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpT7F-009Lmr-2F;
	Thu, 30 Jul 2026 15:56:14 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 30 Jul 2026 08:55:50 -0700
Subject: [PATCH v2] kexec: keep the next kernel off hardware-poisoned pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-kexec_posioned-v2-1-f92d18551f64@debian.org>
X-B4-Tracking: v=1; b=H4sIAAV0a2oC/13MQQqDMBBA0auEWZuSSUUlq95DpMRk1KGQSFLEI
 rl7Ueim28/nHZApMWUw4oBEG2eOAYzQlQC32DCTZA9GgFa6Ua1u5Yt2cs81niN52epxVLbG+m4
 VVALWRBPvF9gPlYCF8zumz+VveNYf1f1TG0qU2CjXocdOTfTwNLINt5hmGEopXxDXIyytAAAA
X-Change-ID: 20260727-kexec_posioned-72bb0a4143a0
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
 kernel-team@meta.com, Kiryl Shutsemau <kas@kernel.org>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=6018; i=leitao@debian.org;
 h=from:subject:message-id; bh=5F5DlBsqdP/R/yM6xPT/BGfLDYVW0Qd0O88Or3DcX4g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqa3QY8WaUST6u3V1yl5vvrupZKusst7u41jay9
 tiljGymnh6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamt0GAAKCRA1o5Of/Hh3
 bQgJD/4qR2Bpc7PQ6Xof+Zl/xPMz2tp0WZ4nlK+s1jkGW1LFYgMOQpX086+gAgiFUKSLQVt2gRp
 plprsrJmOWNBgvWlHgIwEN3TinRH15XCErgM6sar5AT8uHNDs1P9mWnhqHTgKbcAQFoGCWnO9DW
 4F7C7THJHpBigIm6+V+P9FUiOhfRNRIsLNxA8kTI8F6hVT/C1BOM2R11iIXtYAYWZWwZZ49dIXc
 4f1f4F4oRZRbbGwpHX5+H4QRAJCXyUJ6PSacdvG8RkLc2tuLekz9PrQceuxZY3MIzDMGFWvNdya
 a7bUNFu18dnvbwbpLpVXogpS1RI6Dn8UnmHHsaYObUt67fAPTk2laVIBKdltInPGqyw4t2rxGR2
 cLGDKZX0DIyGemo5f87FkrSKMVeROsSqDho03/9yTCRzpJizxitGzlshFe2XCj+Dy9FgBee3ITa
 E/nPuEV/tbqP4DkiKI3gSS951gqT7wCj103x0fKfu7xp8xz8T0eE98B7K25ZRrxTHcgFoXwMn8Z
 fDGl2xeDB5CbC+Fb+WxGREUvtRZW1vom2y0bigxdL8BVR7FGLOyQsPMfKdC3DfuYRjYYXjjauQL
 Wrnh7DzXJU16qI2HdVW1MyXRNMPY1+9tlFb8MLznzSpZxvz6+/oqk2+Zq6wINxkm3VcEBamCe6S
 Q4G3IDtO+A8HIQQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_085644_779185_2E365322 
X-CRM114-Status: GOOD (  23.53  )
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

Memory failures (such as unrecoverable ECCs errors) are getting more and
more common. The kernel knows how to handle it while running, marking it
as poisoned (and SIGBUS user tasks).

Poisoned memory is removed from the buddy allocator, but, not from
other places. A current problem is that kexec will load new kernel
on top of a bad/poisoned memory, which is undesirable.

If the next kernel's image, initrd or purgatory lands on poisoned frame,
the relocation copy writes to the bad memory and the machine checks
during the kexec.

Skip hardware-poisoned frames when placing segments: check them in the
kexec_file hole finder so it lays the next kernel down on good memory,
and reject a poisoned destination in sanity_check_segment_list() for
the kexec_load path, which cannot relocate.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org
---
 include/linux/mm.h  |  8 ++++++++
 kernel/kexec_core.c | 10 ++++++++++
 kernel/kexec_file.c | 19 +++++++++++++++++++
 mm/memory-failure.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7fabe6c66b4b7..48cad9a519d08 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5192,6 +5192,8 @@ extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
+bool range_contains_hwpoison(phys_addr_t start, unsigned long size,
+			     phys_addr_t *poison);
 #else
 static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
@@ -5204,6 +5206,12 @@ static inline void num_poisoned_pages_inc(unsigned long pfn)
 static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 }
+
+static inline bool range_contains_hwpoison(phys_addr_t start, unsigned long size,
+					   phys_addr_t *poison)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d053..9f6ed3c04299b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -212,6 +212,16 @@ int sanity_check_segment_list(struct kimage *image)
 	}
 #endif
 
+	/*
+	 * Reject destinations that land on hardware-poisoned memory: the
+	 * relocation copy would machine-check on the bad frame.
+	 */
+	for (i = 0; i < nr_segments; i++) {
+		if (range_contains_hwpoison(image->segment[i].mem,
+					    image->segment[i].memsz, NULL))
+			return -EADDRNOTAVAIL;
+	}
+
 	/*
 	 * The destination addresses are searched from system RAM rather than
 	 * being allocated from the buddy allocator, so they are not guaranteed
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d86..95cc981a557be 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -475,6 +475,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 {
 	struct kimage *image = kbuf->image;
 	unsigned long temp_start, temp_end;
+	phys_addr_t poisoned_addr;
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
@@ -504,6 +505,14 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		if (range_contains_hwpoison(temp_start, temp_end - temp_start + 1,
+					    &poisoned_addr)) {
+			if (poisoned_addr < kbuf->memsz)
+				return 0;
+			temp_start = poisoned_addr - kbuf->memsz;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
@@ -520,6 +529,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 {
 	struct kimage *image = kbuf->image;
 	unsigned long temp_start, temp_end;
+	phys_addr_t poisoned_addr;
 
 	temp_start = max(start, kbuf->buf_min);
 
@@ -546,6 +556,15 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		/*
+		 * Avoid placing the next kernel on hardware-poisoned memory.
+		 */
+		if (range_contains_hwpoison(temp_start, temp_end - temp_start + 1,
+					    &poisoned_addr)) {
+			temp_start = poisoned_addr + PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a8b03e2920ba8..04a1883d51fda 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -96,6 +96,34 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
 		memblk_nr_poison_sub(pfn, i);
 }
 
+/*
+ * Return true if any online page in [start, start + size) is hardware
+ * poisoned.  On a hit, when @poison is not NULL, @poison is set to the
+ * address of the first poisoned page, which is ugly, but I cannot only
+ * return phys_addr_t, thus this "extra" parameter, instead of returning
+ * the hit.
+ */
+bool range_contains_hwpoison(phys_addr_t start, unsigned long size,
+			     phys_addr_t *poison)
+{
+	unsigned long pfn, end_pfn;
+
+	if (!size || !atomic_long_read(&num_poisoned_pages))
+		return false;
+
+	end_pfn = PHYS_PFN(start + size - 1);
+	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
+		struct page *page = pfn_to_online_page(pfn);
+
+		if (page && PageHWPoison(page)) {
+			if (poison)
+				*poison = PFN_PHYS(pfn);
+			return true;
+		}
+	}
+	return false;
+}
+
 /**
  * MF_ATTR_RO - Create sysfs entry for each memory failure statistics.
  * @_name: name of the file in the per NUMA sysfs directory.

---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260727-kexec_posioned-72bb0a4143a0

Best regards,
--  
Breno Leitao <leitao@debian.org>


