Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51500C531D0
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gp0it8LdFQOsDvrEyvMyOsogKt81zs4FSO3UF+0hUBw=; b=IVEemAHpmnFTXlqEtqYy8KYEjQ
	oOmgaD+M6QtK6QHaaOAbHF5yLa69+nRUZ3IWRhmSoXbC4lYH37RFOy/fTPvWPCxzPnqHdtgVBF+WV
	5k8N/isiZdUtUgMZWlitQB/CgdbGTJgtoRXssX6XNwzjrGUAqASWyHL1+GWjEoJXGyGHRI9yuD/Rv
	/ZE+RKcKHUi/2L4Rhe9QLPVOkkc262Ghxu1v4apWC8S2Emc/Tcggg1wcECijitv4XDoF70babFuY7
	KgURxcgTfxk1mgkSJ7mR0QKYTu1DVu71pnHJm9KGoTpK5zAiOSdeyqk4/rsMkCKJ2XVEYAWlCaP5v
	tRkViKeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnjZR-00000000iLc-1DcX;
	Sat, 25 Jul 2026 21:06:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnjZQ-00000000iLC-1FKl
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 21:06:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D2CAD42A78;
	Sat, 25 Jul 2026 21:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0388C1F00A3D;
	Sat, 25 Jul 2026 21:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013566;
	bh=Gp0it8LdFQOsDvrEyvMyOsogKt81zs4FSO3UF+0hUBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IwtkvEFyAIM6vGrDMW4/eUdNQ038aHJMSbJCAgVJsuaLJ5jupcJsAw/nYe6E6lw4T
	 YhHwt5fqo81OTeSFy3m+6oEOt0xQeFajetvg4K400c72KKY2UurSSkwefCB40T7p9e
	 LGLPNeQPAz2eXdLWjyBJA8on8wZC5JRnM+GAE1HThZqfu5MFqNZ/I+HuF5knkEXm0H
	 BWt3V+O+L9cJlnq3dhjZXHAvdatLD31aNENVKgeMfT52yLNg/agMDhL1vTBw5Fe63X
	 4Uix4b8zjxDzLQ0Z4eMxM+LiTeEzGTUSP2N6+DZ61oNgbWgM3iIde6udTc5qeZcqMf
	 G2V/byQRp2Tfw==
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
Subject: [PATCH v2 3/3] proc: Unmap mmaps of removed files via file->f_mapping
Date: Sat, 25 Jul 2026 21:05:49 +0000
Message-ID: <20260725210549.3716546-4-kwilczynski@kernel.org>
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

Currently, proc_entry_rundown() releases every open file of an entry
that is being removed, but never unmaps the userspace mappings created
through those files, so these stay in place after the entry is gone.

For the /proc/bus/pci device files, the VMAs of such mappings are
attached to the shared iomem address space, as these files swap their
f_mapping to iomem_get_mapping() at open time, see commit 636b21b50152
("PCI: Revoke mappings like devmem").

As a result, userspace mappings of PCI BARs survive device removal,
keeping stale PTEs into physical address space that the kernel may
have reassigned since.

Thus, use unmap_mapping_file() in close_pdeo() to unmap the pages of
each open file, so that only the VMAs created through the removed file
are zapped, while unrelated mappings on the shared address space are
left intact.  Add a pde_is_removed() helper next to pde_is_permanent()
to tell a rundown from a regular close(), which leaves mappings alone,
and use it in place of the open-coded checks in proc_misc_d_revalidate()
and proc_misc_d_delete().

This reaches every removable entry with a proc_release() hook, not only
the PCI ones.  Other than /proc/bus/pci, the only entries that also set
a proc_mmap() hook are /proc/vmcore and the ALSA information entries.

Mappings of /proc/vmcore are now also unmapped when the entry is
removed.  The ALSA proc_mmap() hook calls a per-entry callback that no
entry implements, so these cannot be mapped and nothing changes for
them.

A read through a stale mapping after removal now raises SIGBUS instead
of returning stale data.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 fs/proc/generic.c  | 4 ++--
 fs/proc/inode.c    | 2 ++
 fs/proc/internal.h | 5 +++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index adc9b9a092b0..0d090e3f3a26 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -222,14 +222,14 @@ static int proc_misc_d_revalidate(struct inode *dir, const struct qstr *name,
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	if (atomic_read(&PDE(d_inode(dentry))->in_use) < 0)
+	if (pde_is_removed(PDE(d_inode(dentry))))
 		return 0; /* revalidate */
 	return 1;
 }
 
 static int proc_misc_d_delete(const struct dentry *dentry)
 {
-	return atomic_read(&PDE(d_inode(dentry))->in_use) < 0;
+	return pde_is_removed(PDE(d_inode(dentry)));
 }
 
 static const struct dentry_operations proc_misc_dentry_ops = {
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index b7634f975d98..f1ebedc85b15 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -239,6 +239,8 @@ static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
 		spin_unlock(&pde->pde_unload_lock);
 
 		file = pdeo->file;
+		if (pde_is_removed(pde))
+			unmap_mapping_file(file);
 		pde->proc_ops->proc_release(file_inode(file), file);
 
 		spin_lock(&pde->pde_unload_lock);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index b232e1098117..53335381ae89 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -79,6 +79,11 @@ static inline bool pde_is_permanent(const struct proc_dir_entry *pde)
 	return pde->flags & PROC_ENTRY_PERMANENT;
 }
 
+static inline bool pde_is_removed(const struct proc_dir_entry *pde)
+{
+	return atomic_read(&pde->in_use) < 0;
+}
+
 /* This is for builtin code, not even for modules which are compiled in. */
 static inline void pde_make_permanent(struct proc_dir_entry *pde)
 {
-- 
2.55.0


