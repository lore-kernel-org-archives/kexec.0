Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF9606AA9F
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QmM55K0k;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SaFDk7dW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WlJZl+UE9pf/QC95ZJSnwsGYNSdLtTHc9yxgINOhNxY=; b=QmM55K0kQy761yIc116mKJKdco
	mVFiHIrfGmCwiDZLVbKVFeONKd3JCuFr/lG0N2FrzJM7mKyvivS9xfvE+oCmcNR2ZxI/W0Pwk23+9
	QLhJAM7FIS0hl8k8d0oACJP1PynjobBPg3m7zAUf25GQSObeR6RxCpKzSavKTnjYMvKHM4GE0eF9Z
	Uv7eYkKyTCYegHJ/bMBRhQgeFXxh1fvnlglslEyoFmUKjNc7G3Z3k+YfyN6idv4X2qhZw5sN+bNUE
	fQ7YhP+YbTPOTpv7KyOcPY0IWXIvkJgxt2RbNXGLvBphgKMFa/Me/vrniWOGvY9W6Or5o64PZt+1a
	VRCSC6XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8e-00000005J72-2ik7;
	Wed, 11 Nov 2026 00:24:32 +0000
Received: from mail-oa1-x46.google.com ([2001:4860:4864:20::46])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQw8X-00000005IuS-3MI0
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 00:24:29 +0000
Received: by mail-oa1-x46.google.com with SMTP id 586e51a60fabf-46a5954cdfcso2511297fac.3
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 16:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794356664; x=1794961464; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlJZl+UE9pf/QC95ZJSnwsGYNSdLtTHc9yxgINOhNxY=;
        b=SaFDk7dWfU052j97mHlYLMMJlbop4zqMmkWiG8WjZvd2BAYyMuqvKf0msKw9/YWz7g
         Mn0kg4yOIM22xxRlFofOvehnC3bHQSKirCNuYq7lbIJ9HCR5ginC1reIkpqeRZ+l89ca
         +o4SacIhsxqYlF2KroqHtgFetmKxxk+4RI89RnqXR4qwg9zCd85TvRyhmgAKgnkiNvyb
         LzN7buVe9diK91Pf1CVJ4hb9iCdz0nlhjPmdoc5lb3j682pcDWNk8MKbV05IzY30uo7y
         X6ueFAKBLTDqDJeZtY7M6TlUXJWzzEN5Dp1FPhfKztrDR+Hs8J4KgGnsqYDdvSfKnJVF
         mgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356664; x=1794961464;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WlJZl+UE9pf/QC95ZJSnwsGYNSdLtTHc9yxgINOhNxY=;
        b=0w11dxGyPu9pnw1nxGhVR1e8bjZxtOBPX4d+n1IbUY37XPM1R1nq1xewVOT4td5xlM
         JPZHfcZrz0acuQ9UNdV2wtG1X2b+vkz2JvbRfkExP42s1SrE6nZnFffhPwosWmp9A/EK
         hXKFE9F8iJkl1q+9VuNXG7En8oA+uBeqaectDhrWK3cPHvZTJFuPMdC1JDOkN3Ba3isn
         cbCerXPr4ob0Zu5IXz54QlHZNb7CFTOE951/x3YmYTO+6KAN+OMst7vjut0rgVfjdTJR
         WgNGR8oJlU9XfR+8hPbMcgCmi55rRYUrPWxXsDLBCkzjDqUf/w4vQuQM0Z3tZRrG+ghE
         I5bw==
X-Gm-Message-State: APuU4Z/yk6lO7tatpWp2syKrY6SINAO7V2NpLblXjoEAXKJSU8WvsBNd
	AkHcjOxNv01pqmUXISYvZ6ajmk+R5TyNFtaTVxX77fCp/rQUiF+KCQZY6RmeqpQ9wutlB7bpud/
	ItFQgcMwWnrKEkLzL/pA3RzEI/tttuKtGY4N1u8c5DPKDr+9MDaQUufsv358/CV3kYYhn7ntv+R
	KboCQLU4fuZlSiUzABEvcQwMMXxC1SM/1e7LtaQ5xwoECrgYVnjuw=
X-Received: from iovs14.prod.google.com ([2002:a05:6602:2bce:b0:9c7:8645:9285])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1a01:b0:540:5827:6d8a with SMTP id 5614622812f47-56b98d23beemr555789b6e.66.1794356663846;
 Tue, 10 Nov 2026 16:24:23 -0800 (PST)
Date: Wed, 11 Nov 2026 00:23:51 +0000
In-Reply-To: <20261111002358.1842967-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111002358.1842967-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111002358.1842967-14-dmatlack@google.com>
Subject: [PATCH v4 13/19] mm/shmem_luo: Allow preserving tmpfs files
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
X-CRM114-CacheID: sfid-20261110_162425_885034_309C8D0A 
X-CRM114-Status: GOOD (  14.48  )
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

Allow preserving files on tmpfs mounts by dropping the link count check
from shmem_luo_can_preserve(). The check was meant to limit preservation
to memfds, which never have links. It isn't needed anymore, since tmpfs
files are now retrieved into a file on a tmpfs mount.

Userspace can keep using a linked file by its path until the Live
Update. The path of the file isn't preserved. Userspace creates the file
to retrieve it into, and can then link that file at the path it wants.

Preserving a linked file affects everyone who opens it by its path,
since its size is frozen while it is preserved. The permission check
added by "mm/shmem_luo: Require permission to preserve a file" covers
that: Callers need permission to write to the file, or must own it if
its size can't change anyway.

Signed-off-by: David Matlack <dmatlack@google.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/shmem_luo.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index 7242664ee4ae..94d617b15489 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -757,9 +757,7 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 static bool shmem_luo_can_preserve(struct liveupdate_file_handler *handler,
 				   struct file *file)
 {
-	struct inode *inode = file_inode(file);
-
-	return shmem_file(file) && !inode->i_nlink;
+	return shmem_file(file);
 }
 
 static unsigned long shmem_luo_get_id(struct file *file)
-- 
2.56.0.542.g3ef89b7020-goog


