Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75678C369CB
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 04:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bzPRpToBtGLM0Yyzg0LtmRUMxWxNQ1Q4t6K4QlkJ7jE=; b=cwUmGNhI4rimviWspvFZ9u06Js
	I0m9VpdupdHGH7ZrO6PSr29Be/YLt5xaa1Khw9PUPmslA9bgpV3c/ZG/jejtyXx4HoBODNgOgTcu4
	4uT8ElQQ+mzskUCnFze/oCMgJ2fp2h2Olx+uLpQcN7bXjyCZtKP9qLjcVRWbsxypy5yx762q1W0KS
	zOtEfzW4WYgV5psedxFrJNYIl2iGTaDjgNPITOE/yNWFOl1l1gdRS6dvMJLbsupyLlo+U45NEb9Ck
	LVe1seeHJ+iy3Q+hXgDDZ1KljgqJ+lyCpvou8ULL7LXQQSnm0x8BNldzXjKCB23ZLA/RQ+ksq/7ey
	1GR3UKKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9cYh-00000008Ii3-0RBv;
	Tue, 29 Apr 2025 04:27:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9cN9-00000008HcO-1Wab
	for kexec@lists.infradead.org;
	Tue, 29 Apr 2025 04:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745900106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzPRpToBtGLM0Yyzg0LtmRUMxWxNQ1Q4t6K4QlkJ7jE=;
	b=S3oglxZkFzc7vHpleILGkXrL5XDemgYv4/0q5sC0ybDCZeZAbKXg7rGcqPrIijBGpJTwEb
	3Z6/4faGq6uaYA0d9CcHQtW90nps57A/jdKFB9lAJjS7DRQidIhjiSBQVdRfwNq5kKd59J
	kpWuuDfviAMyG6aQS0KDM5R6CsudWnM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-GE_NAB8JO4qzB-hCOU3eow-1; Tue,
 29 Apr 2025 00:13:37 -0400
X-MC-Unique: GE_NAB8JO4qzB-hCOU3eow-1
X-Mimecast-MFC-AGG-ID: GE_NAB8JO4qzB-hCOU3eow_1745900014
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1441B19560AA;
	Tue, 29 Apr 2025 04:13:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7A2D1800352;
	Tue, 29 Apr 2025 04:13:20 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: bpf@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [RFCv2 4/7] bpf/kexec: Introduce three bpf kfunc for kexec
Date: Tue, 29 Apr 2025 12:12:11 +0800
Message-ID: <20250429041214.13291-5-piliu@redhat.com>
In-Reply-To: <20250429041214.13291-1-piliu@redhat.com>
References: <20250429041214.13291-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_211507_514746_7F225C1E 
X-CRM114-Status: GOOD (  22.86  )
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

This patch introduces three kfunc dedicated for kexec_file_load.

In the case of kexec, kexec_trylock() ensures no concurrent, which
relieves the kexec bpf kfunc design. (Maybe later, a dedicate
BPF_PROG_TYPE_KEXEC to limit their use case to improve the safety)

bpf_kexec_decompress(): It creates a bridge to the kernel decompressor,
avoiding the need to reimplement the lib/decompress_* in bpf-programs.

bpf_kexec_result_release(): It releases the resource when bpf-prog is
done with that.

bpf_kexec_carrier(): The common data flow in bpf scheme is from kernel
to bpf-prog.  In the case of kexec_file_load, the kexec component needs
to buffer the parsed result by bpf-prog (opposite the usual direction)
to the next stage parsing. bpf_kexec_carrier() makes the opposite data
flow possible. A bpf-prog can publish the parsed payload address to the
kernel, and the latter can copy them for future use.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
To: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 kernel/kexec_pe_image.c | 194 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
index accf6b0f02e39..610bb134f5e34 100644
--- a/kernel/kexec_pe_image.c
+++ b/kernel/kexec_pe_image.c
@@ -15,6 +15,9 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#include <linux/decompress/generic.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -52,6 +55,186 @@ static struct parsed_phase *alloc_new_phase(void)
 	return phase;
 }
 
+struct mem_range_result {
+	refcount_t usage;
+	/*
+	 * Pointer to a kernel space, which is written by kfunc and read by
+	 * bpf-prog. Hence kfunc guarantees its validation.
+	 */
+	char *buf;
+	uint32_t size;     // Size of decompressed data
+	int status;        // Status code (0 for success)
+};
+
+#define MAX_KEXEC_RES_SIZE	(1 << 29)
+
+BTF_KFUNCS_START(bpf_kexec_ids)
+BTF_ID_FLAGS(func, bpf_kexec_carrier, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kexec_decompress, KF_TRUSTED_ARGS | KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_kexec_result_release, KF_RELEASE)
+BTF_KFUNCS_END(bpf_kexec_ids)
+
+static const struct btf_kfunc_id_set kexec_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kexec_ids,
+};
+
+/*
+ * Copy the partial decompressed content in [buf, buf + len) to dst.
+ * If the dst size is beyond the capacity, return 0 to indicate the
+ * decompress method that something is wrong.
+ */
+//to do
+static long flush_buffer(void *buf, unsigned long len)
+{
+
+	//return len to indicate everything goest smoothly
+	return 0;
+}
+
+
+__bpf_kfunc_start_defs();
+
+/*
+ * @name should be one of : kernel, initrd, cmdline
+ */
+__bpf_kfunc int bpf_kexec_carrier(const char *name, struct mem_range_result *r)
+{
+	struct kexec_res *res;
+	int ret = 0;
+
+	if (!r) {
+		pr_err("%s, receive invalid range\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!r || !name)
+		return -EINVAL;
+	if (r->size == 0 || r->size > MAX_KEXEC_RES_SIZE) {
+		pr_err("Invalid resource size: 0x%x\n", r->size);
+		return -EINVAL;
+	}
+
+	res = kzalloc(sizeof(struct kexec_res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	for (int i = 0; i < ARRAY_SIZE(kexec_res_names); i++) {
+		if (!strcmp(kexec_res_names[i], name))
+			res->name = kexec_res_names[i];
+	}
+
+	if (res->name == NULL) {
+		pr_err("Invalid resource name: %s, should be 'kernel', 'initrd', 'cmdline'\n", name);
+		kfree(res);
+		return -EINVAL;
+	}
+
+	res->buf = vmalloc(r->size);
+	if (!res->buf) {
+		kfree(res);
+		return -ENOMEM;
+	}
+	ret = copy_from_kernel_nofault(res->buf, r->buf, r->size);
+	if (unlikely(ret < 0)) {
+		kfree(res->buf);
+		kfree(res);
+		return -EINVAL;
+	}
+	res->size = r->size;
+
+	INIT_LIST_HEAD(&res->node);
+	list_add_tail(&res->node, &cur_phase->res_head);
+	return 0;
+}
+
+__bpf_kfunc struct mem_range_result *bpf_kexec_decompress(char *image_gz_payload, int image_gz_sz,
+			unsigned int expected_decompressed_sz)
+{
+	decompress_fn decompressor;
+	//todo, use flush to cap the memory size used by decompression
+	long (*flush)(void*, unsigned long) = NULL;
+	struct mem_range_result *range;
+	const char *name;
+	void *output_buf;
+	char *input_buf;
+	int ret;
+
+	range = kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
+	if (!range) {
+		pr_err("fail to allocate mem_range_result\n");
+		return NULL;
+	}
+	refcount_set(&range->usage, 1);
+
+	input_buf = vmalloc(image_gz_sz);
+	if (!input_buf) {
+		pr_err("fail to allocate input buffer\n");
+		kfree(range);
+		return NULL;
+	}
+
+	ret = copy_from_kernel_nofault(input_buf, image_gz_payload, image_gz_sz);
+	if (ret < 0) {
+		pr_err("Error when copying from 0x%px, size:0x%x\n",
+				image_gz_payload, image_gz_sz);
+		kfree(range);
+		vfree(input_buf);
+		return NULL;
+	}
+
+	output_buf = vmalloc(expected_decompressed_sz);
+	if (!output_buf) {
+		pr_err("fail to allocate output buffer\n");
+		kfree(range);
+		vfree(input_buf);
+		return NULL;
+	}
+
+	decompressor = decompress_method(input_buf, image_gz_sz, &name);
+	if (!decompressor) {
+		pr_err("Can not find decompress method\n");
+		kfree(range);
+		vfree(input_buf);
+		vfree(output_buf);
+		return NULL;
+	}
+	//to do, use flush
+	ret = decompressor(image_gz_payload, image_gz_sz, NULL, NULL,
+				output_buf, NULL, NULL);
+
+	/* Update the range map */
+	if (ret == 0) {
+		range->buf = output_buf;
+		range->size = expected_decompressed_sz;
+		range->status = 0;
+	} else {
+		pr_err("Decompress error\n");
+		vfree(output_buf);
+		kfree(range);
+		return NULL;
+	}
+	pr_info("%s, return range 0x%lx\n", __func__, range);
+	return range;
+}
+
+__bpf_kfunc int bpf_kexec_result_release(struct mem_range_result *result)
+{
+	if (!result) {
+		pr_err("%s, receive invalid range\n", __func__);
+		return -EINVAL;
+	}
+
+	if (refcount_dec_and_test(&result->usage)) {
+		vfree(result->buf);
+		kfree(result);
+	}
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
 static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
 {
 	struct mz_hdr *mz;
@@ -336,3 +519,14 @@ const struct kexec_file_ops kexec_pe_image_ops = {
 	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
+
+static int __init bpf_kfunc_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &kexec_kfunc_set);
+	if (!!ret)
+		pr_err("Fail to register btf for kexec_kfunc_set\n");
+	return ret;
+}
+late_initcall(bpf_kfunc_init);
-- 
2.49.0


