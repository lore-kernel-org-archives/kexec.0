Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A860E6007
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pQlTq2Yx;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aaj2yyeD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zTFnRhvBDyUF5JRAjEQ7l0v+FU3UL1Jli3F24C62wAY=; b=pQlTq2Yx9R8nqWcUIRj42b9uyg
	2WuL5Z890U7jwSdxsY8fRaw1pU+CWYJUaY4stdRRD7xYSzHGId6FsmyEZeGGxuoOZJEpplUXwY4WB
	9TbVW00M038EPsEyBlUBWKCVogkrB3LwQs4qvYbEn5ctF7iGMDl3rSVQclg2fzcrW4ks3gdcdnl9O
	+U+603mWfi5HPrbxfh3AgLib7SCNmOhhWle7EFQ7+Ka2NXTvVurbOWXkYQZ22pXFqpnQKOCOfLkAg
	Rx9ChxVPuZu2HncDUhizGCnRw5ppKV4/yHMcchYOReziHVlmmdS13JQAtwI7k4sjfH4IdrPMH4/Tz
	imYg68aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5v-0000000H9Wv-0aZW;
	Mon, 02 Nov 2026 15:37:11 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5q-0000000H9Qa-3rJL
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:08 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2eb362d1f5eso34108355ad.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633823; x=1794238623; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zTFnRhvBDyUF5JRAjEQ7l0v+FU3UL1Jli3F24C62wAY=;
        b=aaj2yyeD2OsmtTFLlJ5Xh7NrLSe2a8wC47AlybVlfsbDXDbbirtMpVXBcWZ/Yml2eu
         GNxR0NbXYosCo8t+WTP4Zz6RRUaBky4SrKTsBPyTGFFw/JG0kz2/CaZ/mqkNSAThTVOg
         kPyl0J9YvSGK+0+8u2EQhcM8B42bwJ/hOe733PMyh8E2VjIy2NDaLD7P/M9BPUKCGsvr
         DwpYYsb+EYBQg8+8/SbYp9e2SsklsjILaY6p6FP7QBFNXd6tDOV3Qjsmh12czg8j6hJ3
         SyIJ5L9c5H5SzsfziOnGNb0DSLbym2ZMurP/3c6L3OMrDegvNfxaPuRFKODzX9D1zxl4
         D55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633823; x=1794238623;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTFnRhvBDyUF5JRAjEQ7l0v+FU3UL1Jli3F24C62wAY=;
        b=KljmaGpmlKJjOkI1drp5xKTzWUx05ixqJ2lCpxATaocTzVWZWP0h3qpG1f3J+BPF6n
         RrJ3uENESpE99J4xl94j5h2xyg2u+TIoCw9KIErO7shBCXJ2aV5LJV0p8gmw+etANS9Y
         gCWSYkokbKAcqZ2fPmJXJ4PbtOoxfvAypwnu4/Pl/+Xs8gxk2Xk8mE0Uv741FxgCyOqi
         TVdtTpIJFbmLtA9VRtXxLDs8ISViTM2z8Vrl18bvWrJAjvc/Yz0JOph3IhzSdgy7kpA8
         F56rWm11HD7rvJAI2WTSLrLQu8nfnPjlGQ3KVRcNIgcg6T8C5S8vS0SgjWnMmRtWX9jj
         Q8lg==
X-Gm-Message-State: APuU4Z/fGQULOJZGBn53JiLYJNkbdQuk7fx2UNZLpfTMNTZsIfRp3HZL
	9mXi+ksm9gBM/S8meyYNXbMpy8DyEnWhSQXXwOvFRnh1kiq2+CH5Fnq4UB/a2QjgZWXAvKqUBhq
	hlGK/jBI3cgh5m0TWs9cOp6V6RYYPY+5IuNvLuSFo2nihgFVVkv+MyRJltLjMEbBn4QppthqBqC
	oc5TkV21OHUJBW0DVTBUgKXVt9nAQroK7teJjt/TOM/CpOkw==
X-Received: from plar18.prod.google.com ([2002:a17:902:c7d2:b0:2e4:8c0e:97db])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0e:b0:2e2:fc90:11a4
 with SMTP id d9443c01a7336-2eb364faec7mr97592545ad.48.1793633823158; Mon, 02
 Nov 2026 07:37:03 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:32 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-4-vipinsh@google.com>
Subject: [PATCH v6 03/27] liveupdate: Export symbols needed by modules
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_073707_026326_976C8261 
X-CRM114-Status: UNSURE (   9.12  )
X-CRM114-Notice: Please train this message.
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

Export liveupdate_register_file_handler() and
liveupdate_unregister_file_handler(). All of these will be used by
vfio-pci in a subsequent commit, which can be built as a module.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 kernel/liveupdate/luo_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index dbae0715220b..6aaa9a531428 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -916,6 +916,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	up_write(&luo_register_rwlock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
 
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -933,6 +934,7 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	luo_flb_unregister_all(fh);
 	list_del(&ACCESS_PRIVATE(fh, list));
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
 
 /**
  * liveupdate_get_token_outgoing - Get the token for a preserved file.
-- 
2.56.0.317.g454f8302e1-goog


