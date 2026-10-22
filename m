Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBEA606A319
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PTzdU3Bz;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=P/9g5mjf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QRGmnu+5Eb3jc4pybJnePwOeBfzJdgL5DEYasCwAfpw=; b=PTzdU3BzZfNQP6f+wr23tKYN9o
	VHd9ssj/VNQGnhQNe50IT3mMHhxdGP+kacxCWDI5SpB1TRxtEj3fmRtHCapNH3mcWNao4K8+p51aF
	Ksh6++axalXByquCFxrZ2rVVp8DBURJUDG3xGsoWv29JZlRDHBw8jgVnt9WYDTP4V+8bJoZtb4Y71
	tTShS9wwL6emtGWQXTiV2GOHkswuexbCwiW1ewlsx+75LT74au8WDOHJDC3ofzvnZQGq76KRP9WF2
	5ZP3veAljxMc64k/PPf04WzVcYPKLbLBdKo2OZXlIdIpJCXDrDULutQ+dNSP3YKWHybbCpQLSaRg6
	cjHKbvLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1cV-0000000F5vz-1FvP;
	Thu, 22 Oct 2026 22:50:47 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1cS-0000000F5sW-0qGa
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 22:50:45 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2df8d1e91c9so3917165ad.0
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792709443; x=1793314243; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRGmnu+5Eb3jc4pybJnePwOeBfzJdgL5DEYasCwAfpw=;
        b=P/9g5mjfLWuAv/d1ePKX22S6RgmS7+aMxI3ArmB6WCHUfyBqsNTs4NE3F77HZtM/21
         KkWAPPqsNrtSC5iffWyESQ4T4qne02bjsQ6hJhVen56lxHuqPlP3Nm5WiZVKsWrQWVRt
         ETgNjNkB6QPqNS32QX6l8s9EP28aXOjXbOgqT3RRq0AebVl9H0ArJkWpntM2LNGpDBn7
         Et9zEDoZXAH259+ABKYxRB+xqKxmUHl0aB+fGWwfISqgPlyFpqiscC5rbNCk8D10jNe+
         N/ZbLs48Up5Cn3hTd0BCt7VqxlcoohsAUOAQ+BqVcaJj5ENLi/JKdlC+c10vfbzK58oS
         SWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709443; x=1793314243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRGmnu+5Eb3jc4pybJnePwOeBfzJdgL5DEYasCwAfpw=;
        b=YnVqtNnYYmYL1o9SmoHet/pLo8Zw+wTOCYtkGMBhEEmaxziCm6EcPFjSGehcE8D8sF
         LzgXxRv1grdVBbiilaS7VBjrAha4r886bEVgznzNxae4M8Mf8OeaKnIqnuMkJf24/2c6
         j9GQD7PBFuUBRtZXIRR0Gu9wpjgRtJm+AMWcVulHweQCVIM65EzBZu+IOzt1pDChuCYb
         URms5ImnovmkFkHQ8Z00B1aDrSXWxHq7YSTdqZANgR3MteNi1Aayf+q6icUQU2qMX0r3
         0dlj8CzurTSwIC9lQeehnbU0LMhbEIMeXqujrqA0rZUMI6fPlOJIqBjn0PCBHRYA3QmA
         kusA==
X-Gm-Message-State: AFq9FYKI3t6sJznc4/wao9HmkPrK59agb22+1e5VTH6laNcZ22lcjXzd
	wTu5wx4i4zlNc3mezJHITb7+5MKVINPHP9T8Ms+WZzhgrwUh8rIqk6PLn2c3R7u7rra6Lg4odDe
	HKeMJpnYaUiDJv8CmVDZRcL+SiOkv4iZV4ff1jtwXTdocxxFIxzywirbarouMXzGfS5MQRZWJgW
	OHbSYKZmVQ0MjFwWAGGTXVHAR7Tc/Pkth5VHYtZqnFceOnLUpfLj0=
X-Received: from plpa12.prod.google.com ([2002:a17:902:900c:b0:2e4:8c0e:97db])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5c8:b0:2ea:192a:13b8 with SMTP id d9443c01a7336-2ea7d09b8ebmr5151125ad.20.1792709442296;
 Thu, 22 Oct 2026 15:50:42 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:50:30 +0000
In-Reply-To: <20261022225035.377445-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022225035.377445-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022225035.377445-6-dmatlack@google.com>
Subject: [PATCH v2 05/10] liveupdate: Don't WARN if tracking a retrieved file fails
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_155044_240694_485F39D0 
X-CRM114-Status: GOOD (  16.13  )
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

Handle a failure to add a retrieved file to luo_preserved_files instead
of triggering a WARN_ON(). xa_insert() can fail with -ENOMEM, and
userspace can trigger that with LIVEUPDATE_SESSION_RETRIEVE_FD, so
warning about it lets userspace crash systems with panic_on_warn.

The handler has already consumed the preserved state when this happens,
so make the failure permanent. Keep the file until the file set is
finished, like any other retrieved file, so that its resources are not
released before then. Finishing the file set then erases the file from
luo_preserved_files, which does nothing for a file that was never added.

Fixes: 00d0b372374f ("liveupdate: prevent double management of files")
Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 kernel/liveupdate/luo_file.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 908ae124ea5e..5a82e45b9062 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -684,14 +684,25 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token, u64 arg,
 		return err;
 	}
 
+	err = xa_insert(&luo_preserved_files,
+			luo_get_id(luo_file->fh, args.file), args.file,
+			GFP_KERNEL);
+	if (err) {
+		/*
+		 * The handler has consumed the preserved state, so the retrieve
+		 * can't be retried. Keep the file until the file set is
+		 * finished, so that its resources are released at the same
+		 * time as those of other retrieved files.
+		 */
+		luo_file->file = args.file;
+		luo_file->retrieve_status = err;
+		return err;
+	}
+
 	luo_file->file = args.file;
 	/* Get reference so we can keep this file in LUO until finish */
 	get_file(luo_file->file);
 
-	WARN_ON(xa_insert(&luo_preserved_files,
-			  luo_get_id(luo_file->fh, luo_file->file),
-			  luo_file->file, GFP_KERNEL));
-
 	*filep = luo_file->file;
 	luo_file->retrieve_status = 1;
 
-- 
2.56.0.257.gf7497c7d27-goog


