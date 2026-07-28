Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40107C531F9
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YIer7IVQu6sdXDBXBO4blJvI/i45KO/+dgraC13Eku8=; b=L50neGvxexC0k3N3s2lyW2HRJa
	40fjtYHboAnIiEHdpCPAQvdHO8VdXCM9ZnAUD1V49IcEEA0hofJiugiQDsacG0J4ajuYiJhhq7fir
	IQpOuUV6Vm8U6eamzt1giS/f6oOr7aMvK8TVofrJ/YbRWSibgXN6zJbJI+0f/VMrNIjJb6f7xPCzo
	7DVz+bidP4Pvlx78a/HFyKwscpdwkvxlpve+AQty9fwidp7CwATC2K8jgZBApO9MFadPlkJUG2A4q
	7SXfXKNXEQ4Y5bjQOkgKAZSHH2DZq+QokevFg+53sBnV0I7GKk4I/gE6XVQbxfuUw9h5m8Pnbq8gW
	yCuOhM8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wokfe-00000005pON-3wY9;
	Tue, 28 Jul 2026 16:28:46 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wokfc-00000005pNt-3hF8
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 16:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=YIer7IVQu6sdXDBXBO4blJvI/i45KO/+dgraC13Eku8=; b=DKb4Qxecq624/3T6timyLsyZpz
	WxHtr5FDMHld1HLlrWfglmV1UXJ8OATH9JKGabK6ApTqv3jHjz5nfthLR2xfHcZafjDUCIfExIm9U
	msJ6/kwBQodU0C16Qc7prlbcJTfTKKYPKV/Lv9R7c+ya8E58HxtFyGLb6JwPrC+cTuxFR4cPHQcVo
	7RN4OqE4ym7MJntrHee9dYHO0kb9x+oKTIaenAaHwz4rcd7I7Y8IBTZ9yKywHFiwrBJHJNn5uvR0k
	SFAmPtOmRKWqvoXsaH7gwyKPhTPk1HQvBoUkqeKAArauwwlglL+HY0dJywBzMvpvobTmgYjS8wHue
	naNKKbKA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wokbA-007nlF-03;
	Tue, 28 Jul 2026 16:24:08 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 28 Jul 2026 09:22:57 -0700
Subject: [PATCH] kexec: keep the next kernel off hardware-poisoned pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-kexec_posioned-v1-1-160c81d180fe@debian.org>
X-B4-Tracking: v=1; b=H4sIAGHXaGoC/x3MUQqAIBAFwKss7zvBLBK8SkRobrUEFQohRHeP+
 h/mRuYknOHoRuJLshw7HNUVYVr9vrCSCEcw2nTaGqs2LjyN5/FBjsqaELRv67bxGhXhTDxL+cN
 +eJ4XcMUxy2AAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4769; i=leitao@debian.org;
 h=from:subject:message-id; bh=nQSm5rYV8cjazgSzvHIJfAskSEGBu9DQvzJ0xkXZLw0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqaNeiZA/VXiwvyo00LoCIEW4X/qMZVed+YMGtk
 aEsqlLrlxSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamjXogAKCRA1o5Of/Hh3
 bcPXD/9Gf4bKeGFEgYJatATA6hZ6ZTE/x4xuWP/vzgqoyCSXNwea3kDhw6x/DWBA7wlC5d67jxE
 yg0NjtHC+3FRc+Ax/+mCjyWlHxzroaHESVsLUBkOviufkhgCpnvU3+alILhY8yPvGHh3r6cRrUx
 ieoLCdWTXHgBPIzvZZTn+Br1lrmyvjvxKVYChiKZZJvq3l4+7EoY49xrBHhnLpoFUPkBcFOrDaU
 LhbLVVp5v8KHZLcOlDh+qjT/Jvlb+Jry6fg4M9URFujcSZbfwl90tN9aazpIBwhmKZ0jFpaKbs1
 hlAeizxQ0/sBQ4qtWvl9QycDzn0QTftbVSUmHmKBBhyiUo2lnADS6zc+IHSiyPNeos5sdcQH0+m
 ozhX2dixp2IoXlkgR37ojd63HPoteWxNALoi4RMUomSEfrercXae88U2crhD+bQn8SegjSH4RNn
 imp6TpWNP7S41laZ2bNBHYfs7K+mE3fyN/QhHD/7nIso61xveRFSmydNjmRue1osvF10/HgsEp4
 QGGMEQhJpEgVHtOLqNGr/efZxWozOBiUODK+mevjoD4mgcL+zMKM+dJicjywpu+o55Mpfhg+j1u
 MwG6Gsgy/tX7CcgtdyzYHij65Yaq571AbD1gNi/kW1XbvRyko9FOXkUoRTrzcgweVGdh7NwICGO
 YSHKrVvala8HXjw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_092844_932860_1FEC3CB6 
X-CRM114-Status: GOOD (  19.66  )
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
 include/linux/mm.h  |  6 ++++++
 kernel/kexec_core.c | 10 ++++++++++
 kernel/kexec_file.c | 14 ++++++++++++++
 mm/memory-failure.c | 18 ++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7fabe6c66b4b7..a89108bcc3f90 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5192,6 +5192,7 @@ extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
+bool range_contains_hwpoison(phys_addr_t start, unsigned long size);
 #else
 static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
@@ -5204,6 +5205,11 @@ static inline void num_poisoned_pages_inc(unsigned long pfn)
 static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 }
+
+static inline bool range_contains_hwpoison(phys_addr_t start, unsigned long size)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d053..18793f925835f 100644
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
+					    image->segment[i].memsz))
+			return -EADDRNOTAVAIL;
+	}
+
 	/*
 	 * The destination addresses are searched from system RAM rather than
 	 * being allocated from the buddy allocator, so they are not guaranteed
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d86..cd77350f12f85 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -504,6 +504,13 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		/* Avoid placing the next kernel on hardware-poisoned memory */
+		if (range_contains_hwpoison(temp_start,
+					    temp_end - temp_start + 1)) {
+			temp_start = temp_start - PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
@@ -546,6 +553,13 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		/* Avoid placing the next kernel on hardware-poisoned memory */
+		if (range_contains_hwpoison(temp_start,
+					    temp_end - temp_start + 1)) {
+			temp_start = temp_start + PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a8b03e2920ba8..032bb23db7566 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -96,6 +96,24 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
 		memblk_nr_poison_sub(pfn, i);
 }
 
+/*
+ * Check if any page in [start, start + size) has hardware-poisoned segments
+ */
+bool range_contains_hwpoison(phys_addr_t start, unsigned long size)
+{
+	unsigned long pfn, end_pfn;
+
+	if (!size || !atomic_long_read(&num_poisoned_pages))
+		return false;
+
+	end_pfn = PHYS_PFN(start + size - 1);
+	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
+		if (pfn_valid(pfn) && PageHWPoison(pfn_to_page(pfn)))
+			return true;
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


