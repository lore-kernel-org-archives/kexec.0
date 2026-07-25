Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A97C531C9
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 21:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aPa/LsrTp3hYJdTLzZYHVqwcc+ik3K0gwTpILC+a88c=; b=MvUNDPfj9BA1UltIf/5H+CjsTD
	t/02uSfxd2BxxPAM6vdltgq9D1u83DygiluWk3PnlSM+wkISFYAD0pQQUDt1ZyT9svLiNXTqmWH5o
	5VxqGgdwovxPWeNSGMtG/e4yFv6UtpdEnZPt4gvATbp+EuPtso0hf+aJF4LLI3F6cyFi4sUYChZ4+
	3PE6KSTYMSp7A0PAm4bkEcwcVo7BbC6/optvgoXJxZVvYfyjgIShAlmLuxAplOQ23xmhA8mvHn3UT
	s4GI/6MfaCVATiKsdpvZDIgO1sJEYnvhzqI9Bo8T91hrJDVDA9dUCnacvzYay5RwqCU0rH8QGxWUV
	b6gA6gXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnjZN-00000000iJn-0rTS;
	Sat, 25 Jul 2026 21:06:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnjZL-00000000iJH-3juv
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 21:06:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EA61960A98;
	Sat, 25 Jul 2026 21:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7C41F01558;
	Sat, 25 Jul 2026 21:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013562;
	bh=aPa/LsrTp3hYJdTLzZYHVqwcc+ik3K0gwTpILC+a88c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qx53A1oDvALciaFuFZCSSzhSlAz/InNoUWnSh/Gm5zNnNDFwrP2ubUYudxorFmIZ8
	 7zEIFtByOjtavUSHsMvApD7vD4GBbbBZ01esE+wg5sPWNTKs/+gt2cyZMdOV+UfNyB
	 GhqmCpoYIW4VHpQkIkngfd7iRMJAUjiV4C9aM74c3W8vOj+ntcwdGTREkVPCVA6Avr
	 qHdaGVv0kn9+MfiHmWQe8iz/+hbFJUASZfScyxqob2Rx+S5IFMVrQfSrTNtueszMAu
	 vKdnfxeTOPtQVYJsZOHmXU20gLd2UcFmXX2j+Jf0km+iLaw1Y9SMUcfySmRzl1/sU7
	 qSLDsH6/40CsA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	kexec@lists.infradead.org,
	driver-core@lists.linux.dev
Subject: [PATCH v2 2/3] kernfs: Unmap mmaps of removed files via file->f_mapping
Date: Sat, 25 Jul 2026 21:05:48 +0000
Message-ID: <20260725210549.3716546-3-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725210549.3716546-1-kwilczynski@kernel.org>
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Currently, kernfs_drain_open_files() unmaps the mapping of the sysfs
inode, file_inode(of->file)->i_mapping, when a node with mmapped open
files is removed.  Since commit 636b21b50152 ("PCI: Revoke mappings
like devmem"), PCI resource and legacy sysfs files swap their
f_mapping to iomem_get_mapping() at open time, so their VMAs are
attached to the shared iomem address space, which the drain never
unmaps.

As a result, userspace mappings of PCI BARs survive device removal
and BAR resize, keeping stale PTEs into physical address space that
the kernel may have reassigned since.

Thus, use unmap_mapping_file() for every open file, so that only the
VMAs of the node being removed are zapped, while unrelated mappings
are left intact.  The same helper also covers files without a swapped
f_mapping, and the driver-claim revocation through revoke_iomem() is
unaffected, as those VMAs remain on the shared address space.

This restores the behaviour these files had before the f_mapping swap
was introduced.  A read through a stale mapping after removal now
raises SIGBUS instead of returning stale data.

Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 fs/kernfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8e0e90c93372..eb04439e9c3e 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -815,10 +815,8 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	}
 
 	list_for_each_entry(of, &on->files, list) {
-		struct inode *inode = file_inode(of->file);
-
 		if (of->mmapped) {
-			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
+			unmap_mapping_file(of->file);
 			of->mmapped = false;
 			on->nr_mmapped--;
 		}
-- 
2.55.0


