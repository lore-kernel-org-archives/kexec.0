Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF8606A337
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mNBy2lVT;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=AEnV+Ok9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8qRp/BwQBEaKjJByyj+gyRQztnD96+imNxep8e/AfWM=; b=mNBy2lVTpTz0qM
	qW0upA3+KYDPb3dbryW06XXVZ5J9pCkcSPajuuHblPIPIFFPYmQ4VHOW/VFP9h3AcnPtm3ZP4lLGj
	YPMWz+P6piySQoeUq2ikhvbbVMKKChVcOktNRuZ6o8OVwCfc9ZMiNb1RjuGmpAENdfF4QBCdVFwbo
	n3N/9EC+xBWMMVviO7KWW9YZ2LpL+9CWdTgA5acH0Lwlu7BIXoehuKtP0x+FcRER8z/JJAvsjch5Z
	UJ5/ZpCB2AbkZznRcYkIdwMlR0wN3gppgMqYblbMlfekxEVrd2Bf3GAPy0IOIub9PydZrj10GZ5pS
	1CKt4axaI+L1zFKWZyLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP6e-000000040sB-1mi1;
	Wed, 04 Nov 2026 00:44:00 +0000
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP6b-000000040po-0XXx
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 00:43:58 +0000
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so45725137.2
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 16:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793753036; x=1794357836; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8qRp/BwQBEaKjJByyj+gyRQztnD96+imNxep8e/AfWM=;
        b=AEnV+Ok9KAiqvp9lGDPXP5IvlSxCD0drwj8LzXQhsZZkYaOLJK3QG5YQeh2tbVCuRw
         YTMzldll7trUDcGQoDaZ+uw5o3RoeBQFrASaIJy9Tv0EqMu3TBfigANBlnXSvciVp5XG
         KuqqaBJmREffwP91MpumR5UsWKTb615CBn7ZeCAymQZbB+gduMYTk0v9t/FiMHtqb+yW
         uB2VyPv3Q2WXRc/HLBeGCIk6VZTO++vr/NEgQEU2d+JVDVCfdg1AP8TjYkxT9bn89eRQ
         DOCgDFGhFQSWzskKenZG541tXNJDkscJJfgUmm2dnxgTtUVaCI0YrnTObdI3HsZbMGbO
         DV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753036; x=1794357836;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qRp/BwQBEaKjJByyj+gyRQztnD96+imNxep8e/AfWM=;
        b=QWVW9N5ygVrZxMbbkN9Ft4tiIUB2oIqpPEqwE7qIXbXwBCfiwjGWFMNt4n0Aj4nqfM
         vgjshKH1jb3w1aWIQf3MGpl7RSNgbWIhzWxHu7ZMIayKxzYC/sUM2G8pgzT/k9sjp8qv
         U3p8dMRyMwoOo1jIT/KX8BulH3OehETwksBLXtr+9ItaFvzgXRiVLy16yL60rgvqRXiz
         y8oBl/s4fPIgn3Sa61Y1iGbadk7fVJ/eP6B22P4xguVhD7ERryCRSq7a3HKDic1Em4N4
         0idQD5gytzMr5FywmC9nNQjaSUPphxy9kqzDm25BItISqOQ7FJbS1QK9crOG/mdU2ujm
         MmZQ==
X-Gm-Message-State: APuU4Z/S3qjaa2kyF/1Li3eaY1cRBkEx3j/fWbVCfDqJx1eYYWhdvuF9
	zq9GyTRPdZGXszDvdQHLIH4/8RYFqcSb2+rjeSSORlv+WPRJXwk+SHrvvs5+IQjNs7E=
X-Gm-Gg: AYBFou1SM8hDY4Jox3TG+//9lhsyhaikaQNsx1yZmmIBrq9sC5/CrtaNqLPZU077FCN
	Kr8KA13kEltLON85I4jqfLD/22HnbD66lfqO/sjJYlfzYTgtpbJXCO900LH8mDZEZGX1jMFdCiW
	HbzmivwZiktprYksc5WGkJ2o0Iqqfy3FkBextR+5P90GYxFLmpZTDQJkMkbaNU9EbcKfifEXWok
	YtbNyS+1NVgzbrBE1v/876ZvKgog2QptCN8oyMCGPUiAtDZ0zfVCN3d9ePGnGGqN3aPIQd+wyUw
	zvaiTBqcUbgdDbObbZ0MrKIy8nS66WUu3T3bSPYmap3swch4IryOTB2bHdpL0Z3YxzoIsEUFI6S
	craR23B5SK+LcmYsPaxwmPnBVwnJr5cGpJJocTo5i77WMC2xJUN2p8nwxXGuN8ArtpU6Bqq7Fz2
	23g3UIkPemFnNCs9ucvW6SEQUlr5ZDeakJm3ujXxwMpbEj9VT86EXYW5E5AltLnQa1my2ui+3Gf
	zNjH5v50Xog4daJLMBEv4RchjUD+2yIOMzUOOKg4lZGG7AHAclL95iplJRF6pC58K4I4eYNTVRq
	kvEDGgyNsSVRaRjtjqVRnuFvJ4LRe1gEalxW0hE2NpZ3cmQIsIz8GBuTD/N5yV8KGkkZGtUCHC/
	aYlc+gvGMkkecBwJODWYKX4sW/2sRR9GtnHIlRBfljzcn90NxgAxNRYE/Gvs6b+uetA==
X-Received: by 2002:a05:6102:5126:b0:7cc:9f01:1378 with SMTP id ada2fe7eead31-7d07227aa1bmr5468508137.1.1793753035777;
        Tue, 03 Nov 2026 16:43:55 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm527432137.11.2026.11.03.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:43:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 09/10] mm/shmem_luo: Allow retrieving tmpfs files
 with O_RDONLY
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mm@kvack.org, Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>
In-Reply-To: <20261103010216.3447716-10-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-10-dmatlack@google.com>
Date: Tue, 03 Nov 2026 19:43:45 -0500
Message-Id: <179375302574.727293.7162114309691231709.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=YJNHuLpjxIokzzpeqa7IUF5TSeIz4RUMcZp7xbSVc0o=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq6n/F6EDZbzsbaVPLjMR9sGnRAbDjC1Ciq/AWa
 k9NfuYfEceJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaup/xQAKCRC7dyhM23N6
 3lCsEACbXM9A4HxMiLl0Hu2iZsdE1Zmu0oXPj7p9V/8TudGtpt1T3tZNzMqRg6mcMoIdIXCEIg2
 JGGNbNtFurmX2M5+0ioNMR5zbXreBE6AuMkYyEhsz9mLhC6GBjKjgPj2jwt+KnOABcJebeqvRKd
 y4Ya+Yp8Es0cpw17FEDkCzUKbK3//D/WIsWKUn6UM7hucv2w/fAkxpXo5BN543+YBaI8xkMMVRn
 n2g2UW/55sOqpWCgyLP5hKC7O0nH80i67ccDx51adPqeWorKXdA8tAiJGEPA1HvKWrQDq1M5XiV
 TL4ToZhvaP2cDPZOzpWQ+SgM8RR5rEbNjx9HbRyEDqVkGL4ewRKR51X3p3i1MjK/Icggu6iRZCV
 pQA4W2yUN0jd8+lNPUAiYVySmSCxilvwg6NSyXvMmni81dEPk1fNTTLz0RXPakYv7ZOo3Msi6nl
 7tFk0/DrvNUKZ0r6ofwz0pJr2y99tYr9lo1aH+1zucM2oxgldSBR4CeGzDL5Qw+ht5ewGuRtCiB
 ipQP2XasfAbUcUZS6qWGqKtqHwJTzTNR0SpjLgOb1maNy6iJzZa9Ft7S02FAM7S0MoEuYDPga+D
 8lVnnR8pCfP6Vv6S/s9t7rUIlGpD3nal/TBbtUq5aGwpDr8N80Ks9Ddzg29Xk+EE4VtpUcJ5HMk
 PbRmcH5B06b972g==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_164357_193513_6DE66975 
X-CRM114-Status: GOOD (  12.88  )
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Allow userspace to pass O_RDONLY in struct liveupdate_shmem_retrieve_arg
> to retrieve a tmpfs file read-only.
> 
> open() requires write access for O_TMPFILE, so create the file writable
> like before, then reopen it read-only with dentry_open() using the flags
> of the writable file, which file_open_root() normalized, and drop the
> writable file. Like open(), which grants the requested access to a new
> file regardless of its mode, don't check permission for the read-only
> open.
> 
> Retrieving a file read-only allows a restored binary to be executed
> before the session is finished. LUO keeps the retrieved file open until
> then, and executing a binary that is open for writing fails with
> -ETXTBSY. Being able to execute restored binaries right away matters
> when they are needed to finish restoring the system, e.g. to bring up
> the services that retrieve and finish the remaining sessions.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Link: https://patch.msgid.link/20261103010216.3447716-10-dmatlack@google.com

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


