Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E52606E49C
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H+EIejYD;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LHISnBIz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=daK/IkDIXVqnfjYl8/M+M9VjkzPIwCe5yl4tay+gSqg=; b=H+EIejYDe63F7y5d7oYDqORWTv
	kw37yR/qcIka4o/d0bwL7MNVGHntGueQvUxeZRV9v2tmWpYnkRUNkZ3MXIedHjBnlU9OKmXrVIcT/
	4zRZR8xX6ntbpSPS4P/pmo94qIFlVQm6OzDqQUuo2nD+5ExDFqSvil7TjlFuL7+ppdHM1kbx2bbEi
	KEeUUVothT7CtfkiNI1X/ayQ3ywBg53QIz9OQ4Xkel0Rz5fbvAr9+qoeTCKNQh92MYJct39RuTTJd
	Iu0Cc9/e6a+vE3YhpVa90F+TKx4TkGuIGIBCbIfrlmvVm+wOks8Tba9rs31LoPJeZ3pYMuE6gG+12
	CfDLM/vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe01-00000002RZI-3a82;
	Tue, 10 Nov 2026 05:02:25 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzo-00000002REv-0drc
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:15 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-6b597374a17so1549575a12.2
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286930; x=1794891730; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=daK/IkDIXVqnfjYl8/M+M9VjkzPIwCe5yl4tay+gSqg=;
        b=LHISnBIzBAJ8EpUBuvyzITi4lKKCP5gYClQ4OZ4ziVCZo6UvNDsqpq8RLKDXWpVV29
         U8JmnoqUQozWC7aasFYMm914/7SGRquHrgWc1awzyOu2ywIPrOQEf1bhlN/2aOa28Bfh
         hZDGYIHYT1KsqC8O5yOUM6H4YDCBjoGPy4hgwg704cRUdWzWj4fW2t//GLVNIH8yVi4k
         9CmTh4PnATxBtG4WGIVCiV2RgmQqiz02IEzupYZOcg1r+pr8/hTpWDDeMwyuvMjwS/AF
         21Mti2eoo2SpjXZjFglmElvn4li2VuHVtR88GMlOtlM34UY1InzxZhoNjDij1NMhCdQz
         tWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286930; x=1794891730;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=daK/IkDIXVqnfjYl8/M+M9VjkzPIwCe5yl4tay+gSqg=;
        b=DYROl+dl/6+NubfROSXXV1McM6Hx2X/2l4L98eZu+TYv29KC19k04VyPdtJsKk1gSA
         V218Rw2EDvduzxfFXAU2gpcHbqRhaJ8n1VeI4rsnLX/RdNOnZ0haf4mACQc3sbTMFB0T
         OJb4D+RLEydo2FcuweU8rbXGe8iY0p5JtR4voDCdWUxDGQojOZlgAM4a+T+weyTBplJq
         m6TOOd59+9cjYHe78CbbVYXkCkaRJoTv5s808mPdd6ky5k3ZaZr1KZAUP2oENL/JP+5x
         NP9fep84FRYk9P+ooyte6VzL/pLi0nv/X+ZROAnF7lAuKNhlzHAMPeoXwiq9BuMn3TEA
         ThhA==
X-Forwarded-Encrypted: i=1; AL+hErHaUDXM3746Zmofp6orfa/eoiM2Xxrx54vqyFG50ba3Ocp2pcGdTeAWolyl13SBZfPfcoqIzg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+f8o6eq4mT7cE73a6cPjLdd9Typin6zq/8znNRXcFUsfUZ0fLy
	jXPoCMLmMCOzKDQSLDIEEKC/XJYGIfrPbKM9iz7yJSz+KgDKTyM2n8B0DY+1xikJV+8IoX/czTI
	77OikwZoSZTKLEakd+g==
X-Received: from edwl2.prod.google.com ([2002:a05:6402:1242:b0:6b3:bbb1:9405])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a6c3:10b0:6b4:8ba2:83ba with SMTP id 4fb4d7f45d1cf-6b756addabfmr786498a12.43.1794286929585;
 Mon, 09 Nov 2026 21:02:09 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:47 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-5-tarunsahu@google.com>
Subject: [PATCH v4 04/19] liveupdate: Reference struct luo_file_set_ser via
 serialized pointer
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
X-CRM114-CacheID: sfid-20261109_210212_233520_29D601CA 
X-CRM114-Status: GOOD (  16.58  )
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

struct luo_session_ser currently embeds struct luo_file_set_ser directly
by value. Embedding struct luo_file_set_ser couples the session layout's
size and field offsets to struct luo_file_set_ser, preventing either
structure from appending fields independently across kexec.

Convert struct luo_session_ser to hold a DECLARE_KHOSER_PTR pointer to
struct luo_file_set_ser instead of embedding it by value. Reserve space
for both structures in each session block-set entry, placing struct
luo_file_set_ser immediately after struct luo_session_ser, and bump
LUO_ABI_COMPATIBLE from luo-v5 to luo-v6.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h     |  9 +++++----
 kernel/liveupdate/luo_session.c | 27 ++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 721949374fa1..f1152470f71a 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -61,13 +61,14 @@
 #include <linux/build_bug.h>
 #include <linux/kconfig.h>
 #include <linux/kho/abi/block.h>
+#include <linux/kho/abi/kexec_handover.h>
 #include <uapi/linux/liveupdate.h>
 
 /*
  * The LUO state is registered under this KHO entry name.
  */
 #define LUO_KHO_ENTRY_NAME	"LUO"
-#define LUO_ABI_COMPATIBLE	"luo-v5"
+#define LUO_ABI_COMPATIBLE	"luo-v6"
 #define LUO_ABI_COMPAT_LEN	ALIGN(sizeof(LUO_ABI_COMPATIBLE), 8)
 
 /**
@@ -133,7 +134,7 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  * struct luo_session_ser - Represents the serialized metadata for a LUO session.
  * @name:         The unique name of the session, provided by the userspace at
  *                the time of session creation.
- * @file_set_ser: Serialized files belonging to this session,
+ * @file_set_ser: Serialized pointer to the files belonging to this session.
  *
  * This structure is used to package session-specific metadata for transfer
  * between kernels via Kexec Handover. An array of these structures (one per
@@ -144,10 +145,10 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  */
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
-	struct luo_file_set_ser file_set_ser;
+	DECLARE_KHOSER_PTR(file_set_ser, struct luo_file_set_ser *);
 };
 
-static_assert(sizeof(struct luo_session_ser) == 80);
+static_assert(sizeof(struct luo_session_ser) == 72);
 static_assert(!IS_ENABLED(CONFIG_64BIT) ||
 	      __alignof__(struct luo_session_ser) == 8);
 
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 74bc66929f4b..df667fe15fb2 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -131,18 +131,21 @@ struct luo_session_global {
 	struct luo_session_header outgoing;
 };
 
+#define LUO_SESSION_SER_SIZE (sizeof(struct luo_session_ser) + \
+			      sizeof(struct luo_file_set_ser))
+
 static struct luo_session_global luo_session_global = {
 	.incoming = {
 		.list = LIST_HEAD_INIT(luo_session_global.incoming.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
 		.block_set = KHO_BLOCK_SET_INIT(luo_session_global.incoming.block_set,
-						sizeof(struct luo_session_ser)),
+						LUO_SESSION_SER_SIZE),
 	},
 	.outgoing = {
 		.list = LIST_HEAD_INIT(luo_session_global.outgoing.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
 		.block_set = KHO_BLOCK_SET_INIT(luo_session_global.outgoing.block_set,
-						sizeof(struct luo_session_ser)),
+						LUO_SESSION_SER_SIZE),
 	},
 };
 
@@ -223,14 +226,16 @@ static void luo_session_unfreeze_one(struct luo_session *session,
 				     struct luo_session_ser *ser)
 {
 	guard(mutex)(&session->mutex);
-	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
+	luo_file_unfreeze(&session->file_set,
+			  KHOSER_LOAD_PTR(ser->file_set_ser));
 }
 
 static int luo_session_freeze_one(struct luo_session *session,
 				  struct luo_session_ser *ser)
 {
 	guard(mutex)(&session->mutex);
-	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
+	return luo_file_freeze(&session->file_set,
+			       KHOSER_LOAD_PTR(ser->file_set_ser));
 }
 
 static int luo_session_release(struct inode *inodep, struct file *filep)
@@ -552,6 +557,17 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
 	return 0;
 }
 
+static struct luo_session_ser *luo_session_ser_init(void *mem)
+{
+	struct luo_file_set_ser *file_set_ser;
+	struct luo_session_ser *ser = mem;
+
+	file_set_ser = mem + sizeof(struct luo_session_ser);
+	KHOSER_STORE_PTR(ser->file_set_ser, file_set_ser);
+
+	return ser;
+}
+
 static int luo_session_deserialize_one(struct luo_session_header *sh,
 				       struct luo_session_ser *ser)
 {
@@ -575,7 +591,7 @@ static int luo_session_deserialize_one(struct luo_session_header *sh,
 
 	scoped_guard(mutex, &session->mutex) {
 		err = luo_file_deserialize(&session->file_set,
-					   &ser->file_set_ser);
+					   KHOSER_LOAD_PTR(ser->file_set_ser));
 	}
 	if (err) {
 		pr_warn("Failed to deserialize files for session [%s] %pe\n",
@@ -657,6 +673,7 @@ int luo_session_serialize(void)
 			goto err_undo;
 		}
 
+		ser = luo_session_ser_init(ser);
 		err = luo_session_freeze_one(session, ser);
 		if (err) {
 			kho_block_set_it_prev(&it);
-- 
2.56.0.506.g506a7eabc5-goog


