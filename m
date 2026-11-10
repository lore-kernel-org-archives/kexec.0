Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1504E60A263C
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jxEjYADo;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lTN7MG0x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3seM7JJG/qIc4h+h1T0VWvSmXn/fwRDakjk9Gf7qDBQ=; b=jxEjYADoR3F+2ZmiGQDub9DMSv
	r3ztUzS/5pxEo0LC92kwwevjOigvglbUjul92i5o5z66B+RybzTfWwwkIQEOwmgBAsBi6a/n7tWTP
	0xXxF/F2CtzBcBMhVq6BbidYKL5fayVN2FrWBL2lz0TUlLgxJl2EsoWV2wlkkjzQsm9Lp4enA3rNc
	bBWOrFLEtYizmQLvxCO63iyxSNtwHL5vXc62f8AhFfK9SdqE+LQCZRfxASADdk9uJqb94mFuDsT3C
	ddvkgx/rW0qE1fKrWLtQXGfw4k0DRXZPGSO1ugv6vDM7B6z92ddXfRoDZzpK/xXCI3UyB89i6GnRT
	TF5mnY0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe0H-00000002S4d-1i18;
	Tue, 10 Nov 2026 05:02:41 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzz-00000002RSs-15oi
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:26 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-6b59665acd6so1151785a12.0
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286941; x=1794891741; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3seM7JJG/qIc4h+h1T0VWvSmXn/fwRDakjk9Gf7qDBQ=;
        b=lTN7MG0x1SWYXU9JUnceRyrBNxJg2vYujUV95/lQgmGqMT+gpAWFC6+0yUUWCHnPxb
         CB8PhRJG9s6UeqQu4U2zbUGZ4uu1nOScNMyYHN5t2QjT+EsvjQ6QlSFeu80YCrtXytNl
         R8t4wCtqsCgm0R3+ng0BABLoCM3EtKBq6n32DEWENxr7WWADrfdOf4QG8nwAy3Zfuk7s
         +TyLc+UzdFgnOJlBNecExVjT9ApDlufxGi3bW7G62kZEiCSwfMP0UIDukrV7OwCW776C
         0W6VMWew2sAtbzwWGG3N0fvqwljMr+d/pUnbHhIkSONUHS1VNM10PqIIIh6V0cT4D4kQ
         JwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286941; x=1794891741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3seM7JJG/qIc4h+h1T0VWvSmXn/fwRDakjk9Gf7qDBQ=;
        b=NZulM3F37s9pgZdl60BNvpuIhsWaAWnZe3wwfAc/BsKuTTWr2TaYmQsjhBMI3HX6l0
         vN7f67m+tlwLhJAiIoxFVtxgoNyv9s9tsYLsSlX8t73lL4V2yj+/cnltyvzjedlrnE0f
         vT9l9cwfB2SDeAngofWHBkdY8JTTyTCTkwgN+xjzJAOKR0XCVlvffLwJHAcleKowoLY/
         RIbMp8INtSGY8bSqaIzAypCzriMFTJuMcP7Df0V9hFdKrJrJ6hloSOgPOLZEoqcGouem
         jBfAkPYS2NSx1fXTKvaPZbn+e0g96v6MwMTDt6AeDtx+KAXP5coe329gu7FCVo1K8TAl
         Odtw==
X-Forwarded-Encrypted: i=1; AL+hErFSSGzaNGo4A5+wG2/HgflmfaNlwUVpiN13M63bbL/yVhRRv/Ua+90lDkBBC9B7rhabA3CkJQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z90dIdUPtfjgKhEaNi6SKqPahkl0WL4ZLyiALuLIVSOlzo7SbN7
	qBBPuDrGs+lMGJh8+0HTIwB6Xi+aLey+A30+7XngIodGv5I72BsYqEUPHhuVtcfBcGSKq+OCQzG
	BBG3I9Qq7fPpuMUrvvg==
X-Received: from edl8-n1.prod.google.com ([2002:a05:6402:4248:10b0:6b1:a845:1d31])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d896:0:b0:6b7:2969:a2b4 with SMTP id 4fb4d7f45d1cf-6b756aeeca3mr787329a12.39.1794286940631;
 Mon, 09 Nov 2026 21:02:20 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:57 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-15-tarunsahu@google.com>
Subject: [PATCH v4 14/19] liveupdate: Add feature header to struct luo_flb_ser
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
X-CRM114-CacheID: sfid-20261109_210223_334184_48BE7A71 
X-CRM114-Status: GOOD (  16.51  )
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
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Precede each serialized File-Lifecycle-Bound (FLB) entry in the preserved
FLB array with struct kho_ser_hdr via DECLARE_KHO_SER so future FLB
metadata features can append fields to struct luo_flb_ser without breaking
compatibility between adjacent kernels.

Compute LUO_FLB_MAX and outgoing entry offsets using
kho_ser_size(luo_flb_ser), and initialize each entry feature header in
luo_flb_serialize(). On the incoming path in luo_flb_retrieve_one(),
validate each entry feature header with kho_ser_validate() and advance
between entries using fhdr->size so entries written with a different
feature layout are traversed accurately.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h |  6 ++----
 kernel/liveupdate/luo_flb.c | 39 +++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 4913707ba0d3..1b660d41bb90 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -181,7 +181,7 @@ DECLARE_KHO_SER(luo_flb_header_ser, 16, 0, 0);
  * passed to the new kernel. Each entry allows the LUO core to restore one
  * global, shared object.
  *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
+ * Preceded by &struct kho_ser_hdr.
  */
 struct luo_flb_ser {
 	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
@@ -189,9 +189,7 @@ struct luo_flb_ser {
 	u64 count;
 };
 
-static_assert(sizeof(struct luo_flb_ser) == 64);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_flb_ser) == 8);
+DECLARE_KHO_SER(luo_flb_ser, 64, 0, 0);
 
 /* Kernel Live Update Test ABI */
 #ifdef CONFIG_LIVEUPDATE_TEST
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index a8dcdb8456fd..d38c223741ff 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -53,11 +53,11 @@
 
 #define LUO_FLB_PGCNT		1ul
 #define LUO_FLB_MAX		(((LUO_FLB_PGCNT << PAGE_SHIFT) -	\
-		kho_ser_size(luo_flb_header_ser)) / sizeof(struct luo_flb_ser))
+		kho_ser_size(luo_flb_header_ser)) / kho_ser_size(luo_flb_ser))
 
 struct luo_flb_header {
 	struct luo_flb_header_ser *header_ser;
-	struct luo_flb_ser *ser;
+	DECLARE_KHO_SER_HDR(luo_flb_ser, *fhdr);
 	bool active;
 };
 
@@ -159,6 +159,7 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 	struct luo_flb_header *fh = &luo_flb_global.incoming;
+	DECLARE_KHO_SER_HDR(luo_flb_ser, *fhdr) = fh->fhdr;
 	struct liveupdate_flb_op_args args = {0};
 	bool found = false;
 	int err;
@@ -177,10 +178,18 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	if (!fh->active)
 		return -ENODATA;
 
-	for (int i = 0; i < fh->header_ser->count; i++) {
-		if (!strcmp(fh->ser[i].name, flb->compatible)) {
-			private->incoming.data = fh->ser[i].data;
-			refcount_set(&private->incoming.count, fh->ser[i].count);
+	for (u64 i = 0; i < fh->header_ser->count;
+	     i++, fhdr = (void *)fhdr + fhdr->size) {
+		struct luo_flb_ser *ser;
+
+		err = kho_ser_validate(fhdr, luo_flb_ser);
+		if (err)
+			return err;
+
+		ser = kho_ser_payload(fhdr, luo_flb_ser);
+		if (!strcmp(ser->name, flb->compatible)) {
+			private->incoming.data = ser->data;
+			refcount_set(&private->incoming.count, ser->count);
 			found = true;
 			break;
 		}
@@ -573,7 +582,7 @@ int __init luo_flb_setup_outgoing(u64 *flbs_pa)
 
 	header_ser->pgcnt = LUO_FLB_PGCNT;
 	luo_flb_global.outgoing.header_ser = header_ser;
-	luo_flb_global.outgoing.ser = (void *)fhdr + kho_ser_size(luo_flb_header_ser);
+	luo_flb_global.outgoing.fhdr = (void *)fhdr + kho_ser_size(luo_flb_header_ser);
 	luo_flb_global.outgoing.active = true;
 
 	return 0;
@@ -594,7 +603,7 @@ int __init luo_flb_setup_incoming(u64 flbs_pa)
 
 	luo_flb_global.incoming.header_ser =
 		kho_ser_payload(fhdr, luo_flb_header_ser);
-	luo_flb_global.incoming.ser = (void *)fhdr + fhdr->size;
+	luo_flb_global.incoming.fhdr = (void *)fhdr + fhdr->size;
 	luo_flb_global.incoming.active = true;
 
 	return 0;
@@ -626,10 +635,16 @@ void luo_flb_serialize(void)
 		long count = refcount_read(&private->outgoing.count);
 
 		if (count > 0) {
-			strscpy(fh->ser[i].name, gflb->compatible,
-				sizeof(fh->ser[i].name));
-			fh->ser[i].data = private->outgoing.data;
-			fh->ser[i].count = count;
+			DECLARE_KHO_SER_HDR(luo_flb_ser, *fhdr) =
+				(void *)fh->fhdr + i * kho_ser_size(luo_flb_ser);
+			struct luo_flb_ser *ser;
+
+			kho_ser_init(fhdr, luo_flb_ser);
+			ser = kho_ser_payload(fhdr, luo_flb_ser);
+			strscpy(ser->name, gflb->compatible,
+				sizeof(ser->name));
+			ser->data = private->outgoing.data;
+			ser->count = count;
 			i++;
 		}
 	}
-- 
2.56.0.506.g506a7eabc5-goog


