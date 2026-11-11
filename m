Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05C606A332
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t7Z6lKwL;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=dW2pgqYG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sK/H9HvHFSTiGugEGJQyMUnIkFUyigqct4WxtQyCZAI=; b=t7Z6lKwLblwSn0+IjfLvDzgdSi
	1J7R2m3M4bh6+vdeoedeToDTz7ACgkwt2WdxcpU9jtPPX1OFJk1ci4ZkPKSM26MHPEzY6+cwXhDQs
	TN4WuohUxh7yasy3sx5Ta7LU7T5vrJXy+Guz42G6x2xvXouFvt/gKC6x42/uySJQlW9RJhvR+44GA
	rUq5m/ZAnH6o6QmXt8w2XRgL4l7E+9KCLR5yUz6mC1iw7T3HaB7v76HqD/HMCz5K4N6JedCtqJt9s
	8QvX7yFKwxHN7I8wGedEbMfk43fj0+ISPtW/sL/Gs1WzjaqEoOKxArv98vYHuues9Nk/mdQBGUFTF
	AL04cn5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR39K-00000005y3p-3z56;
	Wed, 11 Nov 2026 07:53:42 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR39I-00000005y2L-370V
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:53:41 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so1707575b3a.2
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383620; x=1794988420; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sK/H9HvHFSTiGugEGJQyMUnIkFUyigqct4WxtQyCZAI=;
        b=dW2pgqYG3mFH5LrX++eL+Ni2okD/unBIecuTTWM3vdzc2jxWuTFlaMJUt2M5PTum9b
         gdx2ZTtKMypGhrzfut/jNLHb2i02xik8XRXU+HT3XnIU7KXUjrXXLgH91/cALZaQlwlS
         gXRJ6QUiNdVBXFv9b0+xMBLwZIKeWHa4K+rDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383620; x=1794988420;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sK/H9HvHFSTiGugEGJQyMUnIkFUyigqct4WxtQyCZAI=;
        b=MCTTqkx4klwFfdU3lq55L+mj1NCymhF4+d7GQwocfinZHrrIHe50bJEIRYBwOivC6g
         i/7zIbErRsMscQbzL7SeIP4LJYSYAqr014MIu17nta0HqIE8sl7NeD7nAHzlKEnzKQFp
         McW8rPSbbUNlCHHr3GEDovNC+zUq07Pdu0X4pwiB1oPdMJSc8V6mLSgUcS1E/3rcK1Ad
         RnVXXH++88/Z9WvW11dS09NCfC/qvGC6Zl4GOjHHu92UbEz5gCaeTFDaNRc6C2nzreZ7
         Yx7wfKsTOQDJAxvXleqIFL3nUuF8/ZSTk90OQNHbOrdPc+tr90vZlFd9NNkDafe0Jonc
         Vb4w==
X-Forwarded-Encrypted: i=1; AL+hErFfGWB1KGuqTtkAl5I5FjiJ+5JNUUdRB4v8ELzGgm4ahPb1QnYUMWhWc+/iVTyWvjkikB9GrA==@lists.infradead.org
X-Gm-Message-State: APuU4Z+eeuSAchMKKDuLutxQ/gVpQSfry0Jf6Dqvcm5owKmTr9I/lCJK
	XwrzcwzYA2/P0rDyXjhgsU2OTpNz+0D0Cam6MzPv2+T30DJ2a4fAntCHhdaWpHUFK2c=
X-Gm-Gg: AYBFou2+9bJDEkIpNV1dcF/8+VO5En5tk9t1QDp6n+YRHfwhzBan24h0pv4NIRlsCgu
	5OO/+rjolU3Gok0KjFCugVjbESEXFubG6mHhsZplBDh1SORDJcnxP0fXon8wa2UIcvRRxLp7LeD
	p/OtLlW9e3pZK3hC54mGyTt2aTQowMeEUeI5fi5U6/X6zXKUX0U2tAsgoTUbBLgRvtIP76IJw3D
	VOOApI1a0pyhyCh6IHtOP4Cxn/hkPSnrZ1U0352yfsJ+tMuq3rS9BJY3RJdAY77zlVWZIvChkCv
	n3XMHIX/JLicAgYEQCcHKXCc8wSf93lNl/dNXALoA9Ne5kBawkwGiVj7831CbWJIBava9r47lGW
	8mKmHDP0/W6o4PcHBhvfZF6JW4vhOpYHKOWuqfNudfY2KtUg2Oqmnpv80OVXDgN1zcGjOtbAJYn
	BQR220SqErwUu9dGwOi1I/hHqFr+Wx8bMtozUy1ExKipTSjTwJKe7GT6EJaj2IK3UE855c7Jumb
	P9Yxt7PbyMwcXb6CJhdZ6tX5CjcTsouQCgCjUjMqpTmx7sIuOhtwOXDkUmrZDcItRMYaEu0dPZ8
	AKY4wFfjbwWxg3ndehvhsNWtH3VVBz4oETdAYtBnfhygoMc+LmLzkMUMXAvQPotz8MSEryEeNDx
	kj20WIL+1rzSRVSdPN/qPYZwGRs2nQzODRfyWV3mn25Vb16/O/WQG+i4Q/3SM7Uf57LEdXwfDmU
	i7rQl84pP0w+5XiNNLw2BoPhiwNGNL2GlZ4Jll8wBqn/yW1eqydwaYQQ==
X-Received: by 2002:a05:6a00:2d2a:b0:8a0:1e49:71bb with SMTP id d2e1a72fcca58-8bc1ddf8792mr1803838b3a.57.1794383619946;
        Tue, 10 Nov 2026 23:53:39 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a6c51sm1842597b3a.14.2026.11.10.23.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:53:39 -0800 (PST)
Date: Tue, 10 Nov 2026 23:53:35 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 7/9] kho: Report how much handover memory is preserved and
 restored
Message-ID: <920192d01c6534b5754648e12840f73cdcfa73de.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794383544.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235340_787744_FE2C9910 
X-CRM114-Status: GOOD (  18.04  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Most memory the previous kernel preserved stays reserved until its user
restores it through KHO, either to use it again or to free it. If
nothing does, it stays reserved for as long as the kernel runs. On a
hypervisor host that can be gigabytes, but amusingly nothing really
shows it reliably. The host simply has less memory than it should, which
is not exactly obvious.

All preserved memory is reserved in kho_preserved_memory_reserve(), and
everything restored through KHO goes through kho_restore_page(), so KHO
can count both easily. Let's add preserved_size and restored_size, in
bytes, to /sys/kernel/kexec/kho_incoming/.

For example, after a live update preserving a 64 MiB memfd:

                     preserved_size  restored_size
    before retrieval       67403776           8192
    after retrieval        67403776       67395584

The 8 KiB left are the incoming KHO FDT and LUO's FLB header.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../ABI/testing/sysfs-kernel-kexec-kdump      | 10 ++++++++
 Documentation/admin-guide/mm/kho.rst          |  3 +++
 kernel/liveupdate/kexec_handover.c            | 23 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
index 5636cd060cb2..2b9f9917d2d4 100644
--- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
+++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
@@ -79,3 +79,13 @@ Description:	read only
 		           the walk of its preserved memory map.
 		"failed"   The kernel rejected the handover.
 User:		system monitoring
+
+What:		/sys/kernel/kexec/kho_incoming/preserved_size
+What:		/sys/kernel/kexec/kho_incoming/restored_size
+Date:		Nov 2026
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Bytes preserved by the previous kernel and bytes restored
+		through KHO, respectively. Both are 0 unless the incoming
+		state is "revived".
+User:		system monitoring
diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 9d74d4ce18b5..37a62daa7622 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -91,6 +91,9 @@ sysfs Interfaces
 ``/sys/kernel/kexec/kho_incoming/state``
     Status of the incoming KHO handover.
 
+``/sys/kernel/kexec/kho_incoming/preserved_size`` and ``restored_size``
+    Bytes preserved by the previous kernel and bytes restored through KHO.
+
 See Documentation/ABI/testing/sysfs-kernel-kexec-kdump for the sysfs ABI.
 
 debugfs Interfaces
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index dfd6fa7e4a71..fe6b66270124 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -110,6 +110,8 @@ struct kho_in {
 	char previous_release[__NEW_UTS_LEN + 1];
 	u32 kexec_count;
 	enum kho_incoming_state state;
+	unsigned long preserved_pages;
+	atomic_long_t restored_pages;
 	struct kho_debugfs dbg;
 	struct kho_radix_tree radix_tree;
 };
@@ -552,6 +554,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio,
 		kho_init_pages(page, nr_pages);
 
 	adjust_managed_page_count(page, nr_pages);
+	atomic_long_add(nr_pages, &kho_in.restored_pages);
 	return page;
 }
 
@@ -643,6 +646,7 @@ static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
 	info.magic = KHO_PAGE_MAGIC;
 	info.order = order;
 	page->private = info.page_private;
+	kho_in.preserved_pages += 1UL << order;
 
 	return 0;
 }
@@ -978,8 +982,26 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 }
 static struct kobj_attribute state_attr = __ATTR_RO(state);
 
+static ssize_t preserved_size_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)kho_in.preserved_pages << PAGE_SHIFT);
+}
+static struct kobj_attribute preserved_size_attr = __ATTR_RO(preserved_size);
+
+static ssize_t restored_size_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	u64 pages = atomic_long_read(&kho_in.restored_pages);
+
+	return sysfs_emit(buf, "%llu\n", pages << PAGE_SHIFT);
+}
+static struct kobj_attribute restored_size_attr = __ATTR_RO(restored_size);
+
 static struct attribute *kho_incoming_attrs[] = {
 	&state_attr.attr,
+	&preserved_size_attr.attr,
+	&restored_size_attr.attr,
 	NULL
 };
 
@@ -1785,6 +1807,7 @@ static void __init kho_mem_retrieve(void)
 	kho_in.fdt_phys = 0;
 	kho_in.radix_tree.root = NULL;
 	kho_in.state = KHO_INCOMING_FAILED;
+	kho_in.preserved_pages = 0;
 }
 
 static __init int kho_out_fdt_setup(void)
-- 
2.54.0


