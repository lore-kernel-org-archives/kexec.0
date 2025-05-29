Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E155C54FB3
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 04:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u/ykuzUNlnG+gXezyEE+wMJKp6YscsHmpoCNBbPLXnA=; b=zCPw05tdlSh9xdCwAUJzEZam92
	sRQ83BYMgkc8S/cC2M1cbq98V4Hs/KVYN4m6sQr8xVpPxPS/mJxC27hMN9p6BitnoXIj8KE5KEdJm
	OQjbTKR29beeANKdx3/+1Bk9imyTM4ia6FPYX02P15+Ppc0LZpeidlTiBRw8J8DRp7AIaDsV00zzt
	2VLysiok0uQkR8VR2h0EuI3zM/zFEP7ZgtIaZ4TblOTVnZ7gGzUW8tE5QyzXwRBHbt9MPTrPqAEUy
	ByMxSB2ZWfAMEAHWPoN3Qf5QsCKAj8Agf0lv16G+OvUuCZShpwXf9G3IGdOq4i/DFhEOqqN9sD/hO
	SLNQhd1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKUkK-0000000EtcE-0BDS;
	Thu, 29 May 2025 04:20:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKUkH-0000000EtbM-3DNS
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 04:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/ykuzUNlnG+gXezyEE+wMJKp6YscsHmpoCNBbPLXnA=;
	b=hy1k1BVSbX6ItDRJaaTuIwBHg+yLWTnxSB6M/jzMq+nzO7B/d1jlh1f1wbuG/9ea5p2+Tg
	PW2W5Aj8M8jnz0ksIf1SlwtwULNwBLV4BeS1OMHa8W0FQF4cyPid80HajtqKEM8N5t4kpp
	ss2sudbGuR1kndfbAws2UizyorSSXa4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-lo6DfNe-OdGdbVJDIpPbfQ-1; Thu,
 29 May 2025 00:19:53 -0400
X-MC-Unique: lo6DfNe-OdGdbVJDIpPbfQ-1
X-Mimecast-MFC-AGG-ID: lo6DfNe-OdGdbVJDIpPbfQ_1748492391
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E10FE1800366;
	Thu, 29 May 2025 04:19:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77DB0180047F;
	Thu, 29 May 2025 04:19:40 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
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
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org
Subject: [PATCHv3 6/9] kexec: Integrate with the introduced bpf kfuncs
Date: Thu, 29 May 2025 12:17:41 +0800
Message-ID: <20250529041744.16458-7-piliu@redhat.com>
In-Reply-To: <20250529041744.16458-1-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_211957_878556_D3D870A3 
X-CRM114-Status: GOOD (  15.55  )
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

First, register as a listener on bpf_copy_to_kernel() Second, in order
that the hooked bpf-prog can call the sleepable kfuncs,
bpf_handle_pefile and bpf_post_handle_pefile should also be marked as
KF_SLEEPABLE to allow that behavior.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 kernel/kexec_pe_image.c | 59 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
index 3097efccb8502..e49d6db3c329d 100644
--- a/kernel/kexec_pe_image.c
+++ b/kernel/kexec_pe_image.c
@@ -52,6 +52,43 @@ static struct parsed_phase *alloc_new_phase(void)
 	return phase;
 }
 
+/*
+ * @name should be one of : kernel, initrd, cmdline
+ */
+static int bpf_kexec_carrier(const char *name, struct mem_range_result *r)
+{
+	struct kexec_res *res;
+
+	if (!r || !name)
+		return -EINVAL;
+
+	res = kzalloc(sizeof(struct kexec_res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+	res->name = kstrdup(name, GFP_KERNEL);
+	kref_get(&r->ref);
+	res->r = r;
+
+	INIT_LIST_HEAD(&res->node);
+	list_add_tail(&res->node, &cur_phase->res_head);
+	return 0;
+}
+
+static struct carrier_listener kexec_res_listener[3] = {
+	{ .name = "kernel",
+	  .kmalloc = false,
+	  .handler = bpf_kexec_carrier,
+	},
+	{ .name = "initrd",
+	  .kmalloc = false,
+	  .handler = bpf_kexec_carrier,
+	},
+	{ .name = "cmdline",
+	  .kmalloc = true,
+	  .handler = bpf_kexec_carrier,
+	},
+};
+
 static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
 {
 	struct mz_hdr *mz;
@@ -161,6 +198,22 @@ __attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_c
 {
 }
 
+BTF_KFUNCS_START(kexec_modify_return_ids)
+BTF_ID_FLAGS(func, bpf_handle_pefile, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_post_handle_pefile, KF_SLEEPABLE)
+BTF_KFUNCS_END(kexec_modify_return_ids)
+
+static const struct btf_kfunc_id_set kexec_modify_return_set = {
+	.owner = THIS_MODULE,
+	.set = &kexec_modify_return_ids,
+};
+
+static int __init kexec_bpf_prog_run_init(void)
+{
+	return register_btf_fmodret_id_set(&kexec_modify_return_set);
+}
+late_initcall(kexec_bpf_prog_run_init);
+
 /*
  * PE file may be nested and should be unfold one by one.
  * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
@@ -212,6 +265,9 @@ static void *pe_image_load(struct kimage *image,
 	cmdline_start = cmdline;
 	cmdline_sz = cmdline_len;
 
+	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
+		register_carrier_listener(&kexec_res_listener[i]);
+
 	while (is_valid_format(linux_start, linux_sz) &&
 	       pe_has_bpf_section(linux_start, linux_sz)) {
 		struct kexec_context context;
@@ -252,6 +308,9 @@ static void *pe_image_load(struct kimage *image,
 		disarm_bpf_prog();
 	}
 
+	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
+		unregister_carrier_listener(kexec_res_listener[i].name);
+
 	/* the rear of parsed phase contains the result */
 	list_for_each_entry_reverse(phase, &phase_head, head) {
 		if (initrd != NULL && cmdline != NULL && parsed_kernel != NULL)
-- 
2.49.0


