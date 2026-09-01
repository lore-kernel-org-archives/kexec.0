Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D8CC624D8
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P31f4AxefLaMEsH/zGccMYrThdu9slSJRJY7f7YnBMU=; b=tKvD+Ll+YMJ7YpU/M+fBwyDfFs
	W0Tkz/3PZvnYA6FsonJaLMIBGU7JzFuq8O4i0CbRCx5Im6HBDuBoC6e1m1nulwNbtiRROtiq/3Y/N
	Smcj96EpJX47EmDp80BiAx7kBnojdMSV71qk0A5OwPRgPlFp0wzCepmVPf+3Efu7XxMbX+URjGgxm
	yi11oRgSONlAYsZ+XC9OuzBk4A9xtjpXwc53g2dpHfgCNfmWVZHNoVPrU2WeSwfsbX5+uftfFuK7g
	QlGIbCa42COjcZgK2gqLAXf0mhC+K3m6dS/3sJRadVRfFfGZdYyO/8DMlHZ6kFN9vXLwoiiFBoPUm
	xJGGM33w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StU-0000000CuzG-3rMM;
	Tue, 01 Sep 2026 18:07:37 +0000
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StP-0000000Cutf-0tto
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 18:07:36 +0000
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso142598a12.1
        for <kexec@lists.infradead.org>; Tue, 01 Sep 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788286047; x=1788890847; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P31f4AxefLaMEsH/zGccMYrThdu9slSJRJY7f7YnBMU=;
        b=SfOOsGvCamR+KSP351TMmDx4IpbYfk7t13OwDIyb0D76bLIGo3FTQHukT5V1CZqroO
         s+B7L3jw5XE1HrFoXZl5fnSEI9zehs9IB9uKVszdpb+h7YA+1Eqahx5clvuLNAeJw27+
         hIahj6PLbIQ17djvqMX3N3d5KIClavjJJc9QbPs6Nu3pdiGePUeb8IR6qVbx3PfDCEoO
         Gy2yHPvzz7IztUiwmtXzBDXw5uIDBduVVaaWN65GYmKvzAy1NMzJM/RZEIsdIW81qVlG
         g7+y5VSv0gDp8Tfu6t80w6k9KdS6+p4UJZhlsIhQfkpoDlh+aY3Cg+FHIEKZzxHdnlO6
         cp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788286047; x=1788890847;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P31f4AxefLaMEsH/zGccMYrThdu9slSJRJY7f7YnBMU=;
        b=TXdd2wwbTwHykg0TEaxrxdZKkx203oFCuAmhT/mY7/78hyiLWyBjXAQu6eBRHK31VU
         GWtlUl83DLMPoLZyOd7/K9JMjRbuvlGDwxk1aWbNl71UhIAbEvEEgspWIuKl2N6rh2bZ
         rlwSrPcNEWBrlQhKyDm5+EbHk35ta3uktEtKhzalAXY0mMDjbMw0H5KximWa3TRkM3o9
         WNIbWnDcRbUquvGTpfwTiooJ9o6fOLMq6hVmKEWi2d+LsaB2DsSuXopxIa/H9/oJQqRW
         DEtIzoiOSYtEZWEOBHoayskYEClypW7QEyO2S4fPdokFzr5j9gDFtC7m+n0hd4fBUp+R
         W5OA==
X-Gm-Message-State: AFuF++nhYnuSiqIGNZSM+g7Z3kZFN9s2JgNWhXONqIFe4RVtkzBsjsK3
	M3JFhjZP0z/X3VLvK8W3EtTJDImPR7iaeqJuRcfcg7THQ0cSXVNsJ5fIJYx4+XsxQUif6EmU2za
	zpBG99LvN4Sgt/O8xXUpp9zQhCig75KAIekpLveTs/LK/mjvCpMCBFI53wQ3tyabO3EsNIUnQ7m
	KDoAa5ywxYpjH+lUILa22aamoE0HN+7r9exYlTfWNo4S0s4AMC8lw=
X-Received: from pgea25.prod.google.com ([2002:a05:6a02:5399:b0:c88:b675:3609])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:31c7:b0:3d3:adbf:777e with SMTP id adf61e73a8af0-3d7afe35cddmr15820173637.19.1788286046490;
 Tue, 01 Sep 2026 11:07:26 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:07:11 +0000
In-Reply-To: <20260901180713.4185641-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260901180713.4185641-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901180713.4185641-4-dmatlack@google.com>
Subject: [RFC PATCH 3/5] mm/memfd_luo: Implement retrieve_into callback for
 shmem folios
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_110731_255648_5D92799E 
X-CRM114-Status: GOOD (  15.73  )
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

Implement the .retrieve_into() file handler API for memfd/shmem files.
This implementation uses the standalone logic extracted previously to
securely drop physical memory into an empty target inode.

Userspace topology delegation requires injecting folios into existing
file descriptors. This implementation verifies the target descriptor is
a shmem file and strictly guarantees it is empty before locking the
inode and bridging the KHO folios into its address space.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 mm/memfd_luo.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..dcda5bf98646 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -590,10 +590,58 @@ static unsigned long memfd_luo_get_id(struct file *file)
 	return (unsigned long)file_inode(file);
 }
 
+static int memfd_luo_retrieve_into(struct liveupdate_file_op_args *args, struct file *target_file)
+{
+	struct inode *inode = file_inode(target_file);
+	struct memfd_luo_folio_ser *folios_ser;
+	struct memfd_luo_ser *ser;
+	int err;
+
+	/* Security/Safety checks: Ensure it's a shmem file and is completely empty */
+	if (!shmem_mapping(target_file->f_mapping))
+		return -EINVAL;
+
+	inode_lock(inode);
+	if (i_size_read(inode) != 0) {
+		inode_unlock(inode);
+		return -EBUSY;
+	}
+
+	ser = phys_to_virt(args->serialized_data);
+	if (!ser) {
+		inode_unlock(inode);
+		return -EINVAL;
+	}
+
+	if (ser->nr_folios) {
+		folios_ser = kho_restore_vmalloc(&ser->folios);
+		if (!folios_ser) {
+			inode_unlock(inode);
+			return -EINVAL;
+		}
+
+		/* Inject the physical pages from KHO using the extracted helper */
+		err = memfd_luo_retrieve_folios(target_file, folios_ser, ser->nr_folios);
+		kho_restore_free(folios_ser);
+		if (err) {
+			inode_unlock(inode);
+			return err;
+		}
+	}
+
+	/* Fast-forward the kernel inode size to match the injected data */
+	vfs_setpos(target_file, ser->pos, MAX_LFS_FILESIZE);
+	i_size_write(inode, ser->size);
+
+	inode_unlock(inode);
+	return 0;
+}
+
 static const struct liveupdate_file_ops memfd_luo_file_ops = {
 	.freeze = memfd_luo_freeze,
 	.finish = memfd_luo_finish,
 	.retrieve = memfd_luo_retrieve,
+	.retrieve_into = memfd_luo_retrieve_into,
 	.preserve = memfd_luo_preserve,
 	.unpreserve = memfd_luo_unpreserve,
 	.can_preserve = memfd_luo_can_preserve,
-- 
2.55.0.966.g6673acef38-goog


