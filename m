Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00EFC55178
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pFbpBG3BWtAJOPPgNm/eX/59dGOWD3hR8l2ysdNLveY=; b=FQfTCHenJobuArQQclxsObHmP2
	x5EtO3thduiiYjM3ZQDvhzXxXnXoX43ckoO7+yl85odHN9aMIW7lERaGovsW4cFvy1xFlgRe8CuYt
	m+bpkhhNFn+1bFWt/6f61Dp3hwp/W2nTmtRFpAAWVdhqRiwZzWEipR09aQt/GouRYSFEK1AneCOL8
	oysX4gMfIhMqPBA9FUm57s6tMQMMMzwkadA0Lh1mqwGP1u65zT4IGSugmpdojBrnHbYhey4H2bkzd
	Q3K7mJnp0J+ADT9qlLsL9iGepvYpHex9ZM5RnMIBsVcUsTvaPnP6eiuiAmMbaBoNwUqJXAwlVeuk7
	EnGpqA9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAV-0000000Ddtq-32EQ;
	Fri, 31 Jul 2026 21:53:27 +0000
Received: from mail-pg1-x548.google.com ([2607:f8b0:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAR-0000000DdrC-349N
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 21:53:25 +0000
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cb835525b13so1686698a12.1
        for <kexec@lists.infradead.org>; Fri, 31 Jul 2026 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785534802; x=1786139602; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pFbpBG3BWtAJOPPgNm/eX/59dGOWD3hR8l2ysdNLveY=;
        b=d4LHxtLdofA3dxQsFELD8WWOw859kFwQc/vthgSbYbpcZaZHjpQuPxoSbm6xgGPr45
         3qViF9Ri9C9D5rkWcfBZbfwDvWmHpqLc02JGnWMa19sK/59KcpbD9g9dyFIY9/LIy53u
         A6/tyAuzZ7RCwPJTuxdYrEOqnuPjl8oIA3DLFySLCYELi4bLvIMowc6a4fqA4Gft/Qz0
         T22woJPKPOYo49hmlVzST+OBxoZyJXF7wMZyWro9W2H8W9MObiltVOHMWO073/Qv3Jlo
         MXc3eTN9gaSOytiGKC4g3baYGGK1WnPNSAbkLJzAq5ujfKL6ie/LfVZY6Z+u+2cdqaBq
         tkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534802; x=1786139602;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFbpBG3BWtAJOPPgNm/eX/59dGOWD3hR8l2ysdNLveY=;
        b=bBS6cofh7KJ75c8y2MPdHf0YJGPfGbFPYpTvRrQ+AC0DUBV2CFTZc1+xsdbqqNfZMd
         z45/RhYZJwf2/UTGfF8rGADtFrNABTr42tf44dkQksHZp7QFswp6JSBYODKFLW1MmQkz
         3stoIidNfKXhF7XHlQuMAsIcCfZvhR7CW7PRMRw7LIx8huI70KYaZO4ySGINhn1kGJBF
         ny/drQTHDS0nkubUV1YnwykgOSciwMIdxy70MrlOrLY9kIhhA0ZldASeTXP0fl3xQ0Px
         0NK/GId7KDIWhLkDlPG/4zQf2o5h7GDMAwV6SpEL7Zcmf9/4McAhj+Tv2J612bV2MwoS
         yBuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWBZQp/J60UQ/9ugnofgyRohWvcvcp0VgKour0fCFwSFOlddd6heUDejf27DSD8Z8zfKFxjA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3bKCAOE/lflQ4T/LATY8iW6zPf0cwLW0BddN8miL5kPz/MpHy
	10sxFl3cqQA0mYiJKbyGlFGy7U3inZkVTqCbGpPcjLPKtX3dZpTTajUQu4gGunONEVe7z754UHf
	rjgj/HDBumbe7cAKs6mL50Q==
X-Received: from dycjx24.prod.google.com ([2002:a05:7300:fd18:b0:311:1ea1:d67])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e082:b0:3b3:bf95:f7e3 with SMTP id adf61e73a8af0-3c92a89cb5dmr1207283637.43.1785534802213;
 Fri, 31 Jul 2026 14:53:22 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:52:22 -0700
In-Reply-To: <20260731215224.831696-1-loganodell@google.com>
Mime-Version: 1.0
References: <20260731215224.831696-1-loganodell@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731215224.831696-3-loganodell@google.com>
Subject: [RFC PATCH 2/4] kho: Add support for multiple versions in subtrees
From: Logan Odell <loganodell@google.com>
To: graf@amazon.com, rppt@kernel.org, pasha.tatashin@soleen.com
Cc: pratyush@kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_145323_804828_70DBBED5 
X-CRM114-Status: GOOD (  23.04  )
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

Add explicit version support to KHO by creating subnodes with
the version number. The first caller to kho_add_subtree_version will
create the parent node and versioned subnode. Subsequent calls with a
different version will add more subnodes with the version as the name.
Remove is updated to handle cleanup when the final version is removed.

Example Tree:

       / (Root Node)
       =E2=94=9C=E2=94=80=E2=94=80 compatible =3D "kho-v1"
       =E2=94=9C=E2=94=80=E2=94=80 preserved-memory-map =3D <0xphys_map>
       =E2=94=9C=E2=94=80=E2=94=80 some_legacy_node (Legacy Node)
       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 preserved-data =3D <0xphys_l=
egacy>
       =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 blob-size =3D <0xsize_legacy=
>
       =E2=94=94=E2=94=80=E2=94=80 LUO (Versioned Parent Node)
           =E2=94=9C=E2=94=80=E2=94=80 1 (Version 1 Node)
           =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 preserved-data =3D <0xph=
ys_luo_v1>
           =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 blob-size =3D <0xsize_lu=
o_v1>
           =E2=94=94=E2=94=80=E2=94=80 2 (Version 2 Node)
               =E2=94=9C=E2=94=80=E2=94=80 preserved-data =3D <0xphys_luo_v=
2>
               =E2=94=94=E2=94=80=E2=94=80 blob-size =3D <0xsize_luo_v2>

Signed-off-by: Logan Odell <loganodell@google.com>
---
 include/linux/kexec_handover.h         |  14 ++
 include/linux/kho/abi/kexec_handover.h |  16 ++
 kernel/liveupdate/kexec_handover.c     | 215 ++++++++++++++++++++++++-
 3 files changed, 237 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.=
h
index ac4129d1d741..1d47ab76b02b 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -33,8 +33,11 @@ struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
 int kho_add_subtree(const char *name, void *fdt);
+int kho_add_subtree_version(const char *name, int version, void *fdt);
 void kho_remove_subtree(void *fdt);
+void kho_remove_subtree_version(const char *name, int version, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
+int kho_retrieve_subtree_version(const char *name, int version, phys_addr_=
t *phys);
=20
 void kho_memory_init(void);
=20
@@ -102,13 +105,24 @@ static inline int kho_add_subtree(const char *name, v=
oid *fdt)
 	return -EOPNOTSUPP;
 }
=20
+static inline int kho_add_subtree_version(const char *name, int version, v=
oid *fdt)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void kho_remove_subtree(void *fdt) { }
+static inline void kho_remove_subtree_version(const char *name, int versio=
n, void *fdt) { }
=20
 static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys=
)
 {
 	return -EOPNOTSUPP;
 }
=20
+static inline int kho_retrieve_subtree_version(const char *name, int versi=
on, phys_addr_t *phys)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void kho_memory_init(void) { }
=20
 static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi=
/kexec_handover.h
index 2201a0d2c159..55acb73b1d27 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -73,6 +73,22 @@
  *
  *       Physical address pointing to a subnode FDT blob that is also
  *       being preserved.
+ *
+ *   Versioned Subnodes (<subnode-name-N>):
+ *     Alternatively, a subnode can group multiple versions of the same
+ *     data. In this case, the subnode <subnode-name-N> does not contain
+ *     an 'fdt' property directly. Instead, it contains child nodes named
+ *     after the version number (e.g., '1', '2'), which in turn contain
+ *     the 'fdt' property.
+ *
+ *     <subnode-name-N> {
+ *         <version-1> {
+ *             fdt =3D <0x...>;
+ *         };
+ *         <version-2> {
+ *             fdt =3D <0x...>;
+ *         };
+ *     };
  */
=20
 /* The compatible string for the KHO FDT root node. */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_h=
andover.c
index 29a05cec2625..6dc7c328a6e2 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/memblock.h>
 #include <linux/page-isolation.h>
+#include <linux/slab.h>
 #include <linux/unaligned.h>
 #include <linux/vmalloc.h>
=20
@@ -722,15 +723,31 @@ static void __init kho_reserve_scratch(void)
 	kho_enable =3D false;
 }
=20
+static int fdt_err_to_errno(int fdt_err)
+{
+	switch (fdt_err) {
+	case 0:
+		return 0;
+	case -FDT_ERR_NOSPACE:
+		return -ENOSPC;
+	case -FDT_ERR_EXISTS:
+		return -EEXIST;
+	case -FDT_ERR_NOTFOUND:
+		return -ENOENT;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int kho_add_subtree_node(const char *name, void *root_fdt, void *fd=
t, int off)
 {
 	int err;
-	phys_addr_t phys =3D virt_to_phys(fdt);
+	u64 phys =3D virt_to_phys(fdt);
=20
 	err =3D fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
 			  &phys, sizeof(phys));
 	if (err)
-		return err;
+		return fdt_err_to_errno(err);
=20
 	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
=20
@@ -762,12 +779,11 @@ int kho_add_subtree(const char *name, void *fdt)
=20
 	fdt_err =3D fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
 	if (fdt_err < 0)
-		return err;
+		return fdt_err_to_errno(fdt_err);
=20
 	off =3D fdt_add_subnode(root_fdt, 0, name);
 	if (off < 0) {
-		if (off =3D=3D -FDT_ERR_EXISTS)
-			err =3D -EEXIST;
+		err =3D fdt_err_to_errno(off);
 		goto out_pack;
 	}
=20
@@ -780,6 +796,93 @@ int kho_add_subtree(const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
=20
+/**
+ * kho_add_subtree_version - record physical address of a sub FDT in KHO r=
oot tree with version.
+ * @name: name of the sub tree group.
+ * @version: version of the sub tree.
+ * @fdt: the sub tree blob.
+ *
+ * Finds or creates a child node named @name in KHO root FDT, and then
+ * creates a child node named @version under @name, and records
+ * the physical address of @fdt there.
+ *
+ * A debugfs blob entry is also created at
+ * ``/sys/kernel/debug/kho/out/sub_fdts/@name-@version`` when kernel is co=
nfigured with
+ * CONFIG_KEXEC_HANDOVER_DEBUGFS
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_add_subtree_version(const char *name, int version, void *fdt)
+{
+	void *root_fdt =3D kho_out.fdt;
+	int err =3D -ENOMEM;
+	int off, sub_off, fdt_err;
+	char version_str[12];
+	char *dbg_name =3D NULL;
+	bool created_parent =3D false;
+
+	mutex_lock(&kho_out.lock);
+
+	fdt_err =3D fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
+	if (fdt_err < 0) {
+		err =3D fdt_err_to_errno(fdt_err);
+		goto out;
+	}
+
+	off =3D fdt_subnode_offset(root_fdt, 0, name);
+	if (off =3D=3D -FDT_ERR_NOTFOUND) {
+		off =3D fdt_add_subnode(root_fdt, 0, name);
+		if (off < 0) {
+			err =3D fdt_err_to_errno(off);
+			goto out_pack;
+		}
+		created_parent =3D true;
+	} else if (off < 0) {
+		err =3D fdt_err_to_errno(off);
+		goto out_pack;
+	}
+
+	snprintf(version_str, sizeof(version_str), "%d", version);
+	sub_off =3D fdt_add_subnode(root_fdt, off, version_str);
+	if (sub_off < 0) {
+		err =3D fdt_err_to_errno(sub_off);
+		goto err_del_parent;
+	}
+
+	dbg_name =3D kasprintf(GFP_KERNEL, "%s-%s", name, version_str);
+	if (!dbg_name) {
+		err =3D -ENOMEM;
+		goto err_del_subnode;
+	}
+
+	err =3D kho_add_subtree_node(dbg_name, root_fdt, fdt, sub_off);
+	if (err)
+		goto err_free_dbg_name;
+
+	kfree(dbg_name);
+
+out_pack:
+	fdt_pack(root_fdt);
+out:
+	mutex_unlock(&kho_out.lock);
+	return err;
+
+err_free_dbg_name:
+	kfree(dbg_name);
+err_del_subnode:
+	if (created_parent)
+		fdt_del_node(root_fdt, off);
+	else
+		fdt_del_node(root_fdt, sub_off);
+	goto out_pack;
+
+err_del_parent:
+	if (created_parent)
+		fdt_del_node(root_fdt, off);
+	goto out_pack;
+}
+EXPORT_SYMBOL_GPL(kho_add_subtree_version);
+
 void kho_remove_subtree(void *fdt)
 {
 	phys_addr_t target_phys =3D virt_to_phys(fdt);
@@ -799,10 +902,10 @@ void kho_remove_subtree(void *fdt)
 		int len;
=20
 		val =3D fdt_getprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME, &len);
-		if (!val || len !=3D sizeof(phys_addr_t))
+		if (!val || len !=3D sizeof(*val))
 			continue;
=20
-		if ((phys_addr_t)*val =3D=3D target_phys) {
+		if ((phys_addr_t)get_unaligned(val) =3D=3D target_phys) {
 			fdt_del_node(root_fdt, off);
 			kho_debugfs_fdt_remove(&kho_out.dbg, fdt);
 			break;
@@ -813,6 +916,59 @@ void kho_remove_subtree(void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_remove_subtree);
=20
+/**
+ * kho_remove_subtree_version - remove a versioned sub FDT from KHO root t=
ree.
+ * @name: name of the sub tree group.
+ * @version: version of the sub tree.
+ * @fdt: the sub tree blob to remove.
+ *
+ * Removes the @version subnode under @name node and its associated debugf=
s entry.
+ * If @name node becomes empty, it is also removed.
+ */
+void kho_remove_subtree_version(const char *name, int version, void *fdt)
+{
+	phys_addr_t target_phys =3D virt_to_phys(fdt);
+	void *root_fdt =3D kho_out.fdt;
+	int off, sub_off;
+	int err;
+	char version_str[12];
+
+	mutex_lock(&kho_out.lock);
+
+	err =3D fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
+	if (err < 0)
+		goto out;
+
+	off =3D fdt_subnode_offset(root_fdt, 0, name);
+	if (off < 0)
+		goto out_pack;
+
+	snprintf(version_str, sizeof(version_str), "%d", version);
+	sub_off =3D fdt_subnode_offset(root_fdt, off, version_str);
+	if (sub_off < 0)
+		goto out_pack;
+
+	{
+		const u64 *val;
+		int len;
+
+		val =3D fdt_getprop(root_fdt, sub_off, KHO_FDT_SUB_TREE_PROP_NAME, &len)=
;
+		if (val && len =3D=3D sizeof(*val) && (phys_addr_t)get_unaligned(val) =
=3D=3D target_phys) {
+			fdt_del_node(root_fdt, sub_off);
+			kho_debugfs_fdt_remove(&kho_out.dbg, fdt);
+
+			if (fdt_first_subnode(root_fdt, off) =3D=3D -FDT_ERR_NOTFOUND)
+				fdt_del_node(root_fdt, off);
+		}
+	}
+
+out_pack:
+	fdt_pack(root_fdt);
+out:
+	mutex_unlock(&kho_out.lock);
+}
+EXPORT_SYMBOL_GPL(kho_remove_subtree_version);
+
 /**
  * kho_preserve_folio - preserve a folio across kexec.
  * @folio: folio to preserve.
@@ -1336,12 +1492,55 @@ int kho_retrieve_subtree(const char *name, phys_add=
r_t *phys)
 	if (!val || len !=3D sizeof(*val))
 		return -EINVAL;
=20
-	*phys =3D (phys_addr_t)*val;
+	*phys =3D (phys_addr_t)get_unaligned(val);
=20
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
=20
+/**
+ * kho_retrieve_subtree_version - retrieve a preserved versioned sub FDT.
+ * @name: the name of the sub FDT group passed to kho_add_subtree_version(=
).
+ * @version: the version of the sub FDT.
+ * @phys: if found, the physical address of the sub FDT is stored in @phys=
.
+ *
+ * Retrieve a preserved sub FDT named @version under @name and store its
+ * physical address in @phys.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_retrieve_subtree_version(const char *name, int version, phys_addr_=
t *phys)
+{
+	const void *fdt =3D kho_get_fdt();
+	const u64 *val;
+	int offset, sub_offset, len;
+	char version_str[12];
+
+	if (!fdt)
+		return -ENOENT;
+
+	if (!phys)
+		return -EINVAL;
+
+	offset =3D fdt_subnode_offset(fdt, 0, name);
+	if (offset < 0)
+		return -ENOENT;
+
+	snprintf(version_str, sizeof(version_str), "%d", version);
+	sub_offset =3D fdt_subnode_offset(fdt, offset, version_str);
+	if (sub_offset < 0)
+		return -ENOENT;
+
+	val =3D fdt_getprop(fdt, sub_offset, KHO_FDT_SUB_TREE_PROP_NAME, &len);
+	if (!val || len !=3D sizeof(*val))
+		return -EINVAL;
+
+	*phys =3D (phys_addr_t)get_unaligned(val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_retrieve_subtree_version);
+
 static __init int kho_out_fdt_setup(void)
 {
 	void *root =3D kho_out.fdt;
--=20
2.55.0.508.g3f0d502094-goog


