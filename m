Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B1606A32E
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JYnBsBcE;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QU3U5dKK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CgBCpjKfzBqNZpJUjcpaoZF5kynIHAd0/p/NXGzkOjc=; b=JYnBsBcEw6nWeW27vYgFO2XdxB
	h/FfE7i6shukgWgLNChqub8lwhEfMgyfp8+prNtiNxOMOfnlw0IHj9NvnoZXETnbVz3OUnm6oGrbt
	RgysU0R+CZT+3gcnZPxbE1UUNbf2XTQn139EeWRZrj64P/FB/evlXqmd6GuLRPlibFSUD7i5+Bf0P
	wLL2iZgXj5TsGDZgZSWpRZuga3Li6sthXaVNJ6mubvGgsq977Vwx0oHrwSs0E/u8KWjrJGXZjNRl1
	n6oplrxJAYl73H1GOb2SBQ+UDzlgwgvdAmLmXlcih7jSl0JReh+6qi+86M7Fhf92uvdoW1h2Mg2I+
	PBjPzGDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe0h-00000002Svf-2sBn;
	Tue, 10 Nov 2026 05:03:07 +0000
Received: from mail-ed1-x546.google.com ([2a00:1450:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe02-00000002RYB-1w8e
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:35 +0000
Received: by mail-ed1-x546.google.com with SMTP id 4fb4d7f45d1cf-6b570b713cbso2126993a12.3
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286944; x=1794891744; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgBCpjKfzBqNZpJUjcpaoZF5kynIHAd0/p/NXGzkOjc=;
        b=QU3U5dKKoy/VX2zmeNS8Vh4PVc0QaKJB4PBA3ohRnPkQ6Snm8XmLzx0wOD+LCQUOls
         VjWgYGVj7PTMFBqK29cYcrAu0KmYgxgYE4N+cRz6TlrAkVR4Z8MjaF79UqLjgMqc3jLe
         bU83Iwqraa/jV6KWphLtLqWQAlKYqAingU7hee1iDQKOUw1Llova1rSdHY4p+nkUvJDU
         CKtnPcdaZ0q792/k1Wz2ZjzLJZU5x0Ne/wR/k7vnvQiOAsc3/T1Mo97e6aRkHa6+V7XQ
         BWt3el/MzKXrd6p/jUtaeiT2ig2B8R841dTnlHsi3DZv5jAWpn9hhADWWWHU4pcujYo2
         mvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286944; x=1794891744;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgBCpjKfzBqNZpJUjcpaoZF5kynIHAd0/p/NXGzkOjc=;
        b=XGnJMHpRzKQvm2bjBN2NSnEHa76H/MbdrWljIfD+2mU2pUU0JuvWeCNGmYMVjoWMFj
         xkEofIF/IDxEJHhK3KJWt8ABsz3pcNY7AUAvtMkKriAL5ZyLjpeCS+LudgxNig/Wfomr
         kv1wzLnff0Uu05SzBgjSnlszZ2EL2cZBvvTZuPI8zaJ7dcp14S49imUldU4FpeGX7qPB
         ixZiOYVZnzbq8yZ2kEMhvYhvYrw0HYwNXG/vO0FPY+aFVE7BaWvsIYNUSNZLsO8sRaKd
         dUq6z+iHhCfO9TDmvjnI1w/HrgrSVDIopq2O2oWf596tX1CxgjeJDUfun7tCYnh7CstZ
         q13A==
X-Forwarded-Encrypted: i=1; AL+hErHsEmuS56Ne8YlT8A7RmjOahBymr870fos+7vLNOGQujRV766mAJv3i6ixbn7D8/Yx6y+Utww==@lists.infradead.org
X-Gm-Message-State: APuU4Z+ojVogTr7oGtzTrFLjYMRAc4D6qX+9gb63Fdt9wo0aKxmdT3gH
	WP9k29YheLei2OVcUYTbOfe8LuDPdJVJTsg6qRtkhguLKKIDl1wP8Ic8AzlCjrCP/sqflBC5zib
	M7Jm9Gl13Q857DtpS1Q==
X-Received: from edtj4.prod.google.com ([2002:aa7:ca44:0:b0:6b7:3b3e:5148])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d496:0:b0:6ac:934e:a9ca with SMTP id 4fb4d7f45d1cf-6b755626f5fmr907953a12.0.1794286944079;
 Mon, 09 Nov 2026 21:02:24 -0800 (PST)
Date: Tue, 10 Nov 2026 05:02:00 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-18-tarunsahu@google.com>
Subject: [PATCH v4 17/19] mm: memfd_luo: Add feature header to struct memfd_luo_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_210226_720719_2CA44B70 
X-CRM114-Status: GOOD (  19.08  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Precede struct memfd_luo_ser with struct kho_ser_hdr using
DECLARE_KHO_SER. Later memfd features can be appended under new
feature indices without breaking compatibility between adjacent kernels.

Allocate both the memfd_luo_ser feature header and the kho_vmalloc
feature header in the same preserved folio. On restore and retrieve,
validate incoming required features before accessing payload fields.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/memfd.h |  7 ++--
 mm/memfd_luo.c                | 67 ++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index b0597c438973..27f8880ee593 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -83,6 +83,8 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  * @nr_folios:   Number of folios in the folios array.
  * @folios_fhdr: Pointer to KHO vmalloc descriptor for the array of
  *               struct memfd_luo_folio_ser.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct memfd_luo_ser {
 	u64 pos;
@@ -93,9 +95,8 @@ struct memfd_luo_ser {
 	DECLARE_KHOSER_PTR(folios_fhdr, DECLARE_KHO_SER_HDR(kho_vmalloc, *));
 };
 
-static_assert(sizeof(struct memfd_luo_ser) == 40);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct memfd_luo_ser) == 8);
+/* Register memfd_luo_ser with KHO serialization accessors */
+DECLARE_KHO_SER(memfd_luo_ser, 40, 0, 0);
 
 /* The compatibility string for memfd file handler */
 #define MEMFD_LUO_FH_COMPATIBLE	"memfd-v3"
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 74c1ff5877c3..94510f73a606 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -256,16 +256,21 @@ static void memfd_luo_unpreserve_folios(DECLARE_KHO_SER_HDR(kho_vmalloc, *folios
 
 static size_t memfd_luo_ser_size(void)
 {
-	return sizeof(struct memfd_luo_ser) + kho_ser_size(kho_vmalloc);
+	return kho_ser_size(memfd_luo_ser) + kho_ser_size(kho_vmalloc);
 }
 
-static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
+static struct memfd_luo_ser *
+memfd_luo_ser_init(DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr))
 {
 	DECLARE_KHO_SER_HDR(kho_vmalloc, *folios_fhdr);
-	struct memfd_luo_ser *ser = mem;
+	struct memfd_luo_ser *ser;
+
+	kho_ser_init(fhdr, memfd_luo_ser);
+	folios_fhdr = (void *)fhdr + kho_ser_size(memfd_luo_ser);
 
-	folios_fhdr = mem + sizeof(struct memfd_luo_ser);
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
 	KHOSER_STORE_PTR(ser->folios_fhdr, folios_fhdr);
+
 	return ser;
 }
 
@@ -273,6 +278,7 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	int err = 0, seals;
 	u64 inode_size;
@@ -304,12 +310,12 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	}
 
 	/* Allocate the main serialization structure in preserved memory */
-	ser = kho_alloc_preserve(memfd_luo_ser_size());
-	if (IS_ERR(ser)) {
-		err = PTR_ERR(ser);
+	fhdr = kho_alloc_preserve(memfd_luo_ser_size());
+	if (IS_ERR(fhdr)) {
+		err = PTR_ERR(fhdr);
 		goto err_unlock;
 	}
-	ser = memfd_luo_ser_init(ser);
+	ser = memfd_luo_ser_init(fhdr);
 
 	ser->pos = args->file->f_pos;
 	ser->size = inode_size;
@@ -323,12 +329,12 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	inode_unlock(inode);
 
 	args->private_data = folios_ser;
-	args->serialized_data = virt_to_phys(ser);
+	args->serialized_data = virt_to_phys(fhdr);
 
 	return 0;
 
 err_free_ser:
-	kho_unpreserve_free(ser);
+	kho_unpreserve_free(fhdr);
 err_unlock:
 	shmem_freeze(inode, false);
 	inode_unlock(inode);
@@ -337,12 +343,14 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 
 static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 {
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
 		return -EINVAL;
 
-	ser = phys_to_virt(args->serialized_data);
+	fhdr = phys_to_virt(args->serialized_data);
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
 
 	/*
 	 * The pos might have changed since prepare. Everything else stays the
@@ -356,6 +364,7 @@ static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
@@ -364,13 +373,14 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 	inode_lock(inode);
 	shmem_freeze(inode, false);
 
-	ser = phys_to_virt(args->serialized_data);
+	fhdr = phys_to_virt(args->serialized_data);
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
 
 	memfd_luo_unpreserve_folios(KHOSER_LOAD_PTR(ser->folios_fhdr),
 				    args->private_data,
 				    ser->nr_folios);
 
-	kho_unpreserve_free(ser);
+	kho_unpreserve_free(fhdr);
 	inode_unlock(inode);
 }
 
@@ -402,6 +412,7 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
 	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 
 	/*
@@ -412,10 +423,16 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (WARN_ON_ONCE(!args->serialized_data))
 		return;
 
+	fhdr = phys_to_virt(args->serialized_data);
+	if (kho_ser_validate(fhdr, memfd_luo_ser)) {
+		pr_warn("invalid feature header, folios not discarded\n");
+		goto out;
+	}
+
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios_fhdr));
 		if (!folios_ser)
@@ -426,7 +443,7 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	}
 
 out:
-	kho_restore_free(ser);
+	kho_restore_free(fhdr);
 }
 
 static int memfd_luo_retrieve_folios(struct file *file,
@@ -533,14 +550,24 @@ static int memfd_luo_retrieve_folios(struct file *file,
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
 	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	struct file *file;
 	int err;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (WARN_ON_ONCE(!args->serialized_data))
 		return -EINVAL;
 
+	fhdr = phys_to_virt(args->serialized_data);
+	err = kho_ser_validate(fhdr, memfd_luo_ser);
+	if (err) {
+		pr_err("memfd_luo_ser feature validation failed: %pe\n",
+		       ERR_PTR(err));
+		goto free_ser;
+	}
+
+	ser = kho_ser_payload(fhdr, memfd_luo_ser);
+
 	/* Make sure the file only has seals supported by this version. */
 	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
@@ -581,14 +608,14 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	}
 
 	args->file = file;
-	kho_restore_free(ser);
+	kho_restore_free(fhdr);
 
 	return 0;
 
 put_file:
 	fput(file);
 free_ser:
-	kho_restore_free(ser);
+	kho_restore_free(fhdr);
 	return err;
 }
 
-- 
2.56.0.506.g506a7eabc5-goog


