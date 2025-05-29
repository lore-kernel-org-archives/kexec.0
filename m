Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B46BC54FB3
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 04:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4Ki9z0ShHf2vySh7hI3sELvA68yXo/Rw604jsSCFYw=; b=KOJzaUVi9rFO/pDSyNFmrQYBaL
	z2+8wwiz3vgZWbbEhwPmDJlTYnQV1v64P7DB8ZdblFAPKz5w8cNwMDrB0mw/gxHoCZv8NvphCwBg/
	shfiFL+APol1Dd5Ai0ZCgb1q5mxZKHzi6TJJf8VY1g/QLO9tw/J0f1XJdwPxjZQYPScSxcLuOHj24
	RKidfH4xrkY8MOQYNQDmDiX+veWO00g/1v2lEf5ziBArS4mEmseHCt0cdDm609gQ+Hi8ofigHaOtA
	MxvfoVozQZSuZkGhu2tKqZSzTVkPEsqn180VOglq49x2qfjvmpOGQgG7BMjvcq3wCv8HXmEiSRxCE
	LVdnjEpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKUjP-0000000EtLk-0TZf;
	Thu, 29 May 2025 04:19:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKUjK-0000000EtKy-0asz
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 04:19:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4Ki9z0ShHf2vySh7hI3sELvA68yXo/Rw604jsSCFYw=;
	b=gu5sv/i992FURVtYLIhzeaUDSLuP3n7i3Ciq2LYML19pJIGcLQXhR2EfJ+3FsntCnaLvif
	lb7XEm7hRTprUMUBbEO1SeCT/aWKv8MMV9rZQ36LtUF/fvd8APr0xp4N0/9K2e3yabow4k
	4Z2ABOiH0XbqillKFpUvFVtQW0SBlIs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-4lVwXHmcNwS6Hn_h41fmww-1; Thu,
 29 May 2025 00:18:51 -0400
X-MC-Unique: 4lVwXHmcNwS6Hn_h41fmww-1
X-Mimecast-MFC-AGG-ID: 4lVwXHmcNwS6Hn_h41fmww_1748492329
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47F331956086;
	Thu, 29 May 2025 04:18:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AEEC18003FC;
	Thu, 29 May 2025 04:18:36 +0000 (UTC)
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
Subject: [PATCHv3 1/9] kexec_file: Make kexec_image_load_default global visible
Date: Thu, 29 May 2025 12:17:36 +0800
Message-ID: <20250529041744.16458-2-piliu@redhat.com>
In-Reply-To: <20250529041744.16458-1-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_211858_252150_61FF9F0D 
X-CRM114-Status: GOOD (  11.86  )
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

In latter patches, PE format parser will extract the linux kernel inside
and try its real format parser. So making kexec_image_load_default
global.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
To: kexec@lists.infradead.org
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c8971861521a5..26398b269ac29 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -148,6 +148,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
 
 int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
+void *kexec_image_load_default(struct kimage *image);
 int kexec_image_post_load_cleanup_default(struct kimage *image);
 
 /*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index fba686487e3b5..6a72bdfab5f5c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -65,7 +65,7 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 	return ret;
 }
 
-static void *kexec_image_load_default(struct kimage *image)
+void *kexec_image_load_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
-- 
2.49.0


