Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB0606A6BC
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HrUv3OLn;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D4L/w0He
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+dO/10Kb1crg9LuSPobtfRm8dvZ5s9kHfaOxT9vk0Y4=; b=HrUv3OLnPa/SDC7WDjLnc8oG+e
	IoT24b/EFT9JZfFXCv7ojrLL4yywGBEbiHz3a6VN+UxuLs586BjQgcjbzgn9yJwFlf80+XU2DAzQf
	aK6aWjiWsZlixICoFJlG4LYm5EaakJyG0KXF6d69/oEZYpJBptAd80dSghZKTIo759QlgW3clC6cW
	Fq0zHBqPC8u/cFE962c0To2chKWlBb9/JvNc+Z7vq8p0ZmuyYyUk6U/1JzH3Bg8e34GG8fx7hMjB9
	8o2zdWMy78Tg58/2KCFMD3x02dE3MQGGi400bhOFS638F2jorcxWbI/TWFdqG7V0ji4SA8dxoMg0Q
	rvzlUCRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddZ-00000005BhK-0oQR;
	Mon, 23 Nov 2026 23:39:53 +0000
Received: from mail-oi1-x246.google.com ([2607:f8b0:4864:20::246])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddT-00000005Bak-27Id
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:49 +0000
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-4e778acdbc6so4876460b6e.3
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477186; x=1796081986; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+dO/10Kb1crg9LuSPobtfRm8dvZ5s9kHfaOxT9vk0Y4=;
        b=D4L/w0HeoYrY/scS+TKpOnSfG2NvKNZPwGf03vlxLs8mWFJzyt0muF9X+ucCeL9KIs
         p4tC86FYeq9tTmYZKlFCl/Cjk9ZMY0YXLX06/elCw/FhW8fepM+mSuXC1d0fkcFZiiOl
         uyvCnm1rJt6MFFUEhCLkApS5qzdlJfChxQZ5d2g3YlHXGJk7uZ4KZo0+eZXM6sY6lEL/
         mDh5gBzdvV2pcJcsxwgZhUorHB4rPCidsN5ubZLvBE/R9v0b0sOSbx+/QX+s5S0POSKx
         T7V4EGtDiBLSd5v7jmQvv08d/fJsXvl/B+RsTvqllX5q8Z7+jwa9f0emwSuEYnu4DK9i
         6UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477186; x=1796081986;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dO/10Kb1crg9LuSPobtfRm8dvZ5s9kHfaOxT9vk0Y4=;
        b=O7kHCtJkKRPn2is3+0GsMCPck/lVtU8kqi9nAkOiE+9TNybwsnUUHe7yNPi+wpEC0t
         kVubyCbsiKfoQ/C1NkprXe98QDlbCry18SBxoyGHqmYTXuIMtBl1ifnZbXQ/hmVEgow8
         cF2LfLYO1fDseyhMRrLKDy/Rwgo/jib4BryvYh26tY2c0oCPexp7sek+qqbaVCtO3vNM
         d/G3tOsZPLVTMzXheDpSbRByqgPEq2DLtjlpXLtTpmbp0bp7OWDggtMRHdrOxViMPbO1
         zbZGzR1MqjGoW052fy6WKR5z8LQHK0rVIAaRfGS4LstFDmhx1r4cO5DGkKM11hQHzfwa
         u1eg==
X-Gm-Message-State: APuU4Z+40V5dMmcgHLH/oa95pmjuTQmd9Dn0L6DvF4efm2eeGz2hjYtD
	FqiOtIPCehphUxCPGFi51jtnk7H5D7IKNNmffVVfGREB6EBRG/GCQ+CelYgozOyG8G/JB0jEdw+
	Zkzf354gzUvavlJvSl4j3bQwPqAXji2TljFMpzcHOYmCfcUSVxbHwNDGzbgmLUkKVR677aJOYUb
	YcqosZWcTRDGdCwr3FnCuEBWQT/upmJzH8cySwmtEHBFENvNFQIkw=
X-Received: from ilej7-n1.prod.google.com ([2002:a05:6e02:6207:10b0:54e:a760:20a7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:308b:b0:4f1:6c9c:78d3 with SMTP id 5614622812f47-57a0a92272dmr14361377b6e.26.1795477185579;
 Mon, 23 Nov 2026 15:39:45 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:17 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-13-dmatlack@google.com>
Subject: [PATCH v5 12/18] mm/shmem_luo: Allow preserving tmpfs files
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
X-CRM114-CacheID: sfid-20261123_153947_555687_8D13CC6C 
X-CRM114-Status: GOOD (  14.47  )
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
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 mm/shmem_luo.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
index 2ea161fb00fc..ab7e5f51dc7d 100644
--- a/mm/shmem_luo.c
+++ b/mm/shmem_luo.c
@@ -777,9 +777,7 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
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
2.56.1.809.ga0b61035b5-goog


