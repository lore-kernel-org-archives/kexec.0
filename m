Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0453606A329
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b0bILu/R;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=kyyGEtAB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vsBN/U3w7HiU12daWsEJrqxDOHajJ7sejATwoccs78Q=; b=b0bILu/RUPJVW1
	TUHuC3W4QWBIamj5hm0KfZEygYeqxJAOqgzXufNdFR8vK7b8nw7uQV/jdqI/7B28g1/frvjIGXFNK
	51iXBMIaeKU66365tRqsJJpR9E9txWF34Fjwbgw36PfxCqHts/+bhPn2CPJMWXwfbwXYNnIMrx7Qd
	Uf1AFQtJir0HrUXwq8Ckzh43Byfvf0wbv/DofZjWlDQ//+7eiM6/FvHsJO+iEYEfdaGDbdn7Q66VP
	/nPExIDbdEvVTMSJgDvhzSY7giSaRdfT0bHCvr2nTVVrtdfLDm1zpXHDYRgThHNzieTRYHp9bFln5
	uVYpHq/m+TCHLIPlCCOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOLS9-00000003dxo-0XFC;
	Tue, 03 Nov 2026 20:49:57 +0000
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOLS5-00000003dxT-3v2o
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 20:49:55 +0000
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-7c33cc572e6so888847137.1
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793738992; x=1794343792; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vsBN/U3w7HiU12daWsEJrqxDOHajJ7sejATwoccs78Q=;
        b=kyyGEtAByIdoJo72xuvikF+H2/YkfGbx9MSU1CiR/vYyEOnAmkEYo4gNg1KqMML529
         KvL/TecIXAP9s0+yfL6sWu2WoNMgeR+dR3gyMQIbIOqogW5If/ypFX0UYHfcdayi9EHK
         o3X32lltI/cxwKdkPBnz/tWGKKVblbyxE03t7OOBVPmhx66Cx1vPXSWOeS+bxJHlxXdU
         or7tsAa8JMbk+NXfpz4t9kqsKSW3/SWaV7Xi/QigyegNcmHgjUs/C4vftHRPkehfUyDi
         2l2DRxBM/fbi5Xp2BTooeYD9Bz0oDCcNmnva/UrNucxHZqjim1BHSO1buE1XpTHBLiLU
         gZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738992; x=1794343792;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vsBN/U3w7HiU12daWsEJrqxDOHajJ7sejATwoccs78Q=;
        b=ntKnVLhO+7UAmnbKAqwxxN8uPs3lPkhS4qcXP5wq+ZK2DWN/mQYAkAqZ5OlN5W8tWr
         WZUi/dpJvJKiHBxMz4z4ouBTn6IqvjsBj9WcDOasf5rWrvr8MG1hZ5qeHSL+GmEnDRMA
         /0T9PoErMyEpfkFUZUpltdRToxZim7CcAexCOLkOs+NVoipQC55LEuLL93sXOHQG04Ie
         Hk3yLvn5DCu1dt4zjg4uwcUsnNulhwxJNTwC8xhlsvYFfYgbejUqDIabj2kIjCIlhtqQ
         EVVv8N6HvHlPtpOFImqI4JoVZGRE2F+jInBbK4Tb7jgfC7L4sKiQNNJlIegHQZJIcBa1
         65jw==
X-Gm-Message-State: APuU4Z/C6N5yI6A4n9a0/6Y2N5rbpgWfaTVOzfceXQ/1f4gI0GQOCQry
	XzOKXr9wRQVjhXVKkGkpmp+qGNX+VmERhF5H3IZJtgR9UVxrCt06XUaYSyRPJ5ucsYoV2+lLMMk
	ihcPS
X-Gm-Gg: AYBFou1gELc2ndy1nzJvtc+5ec+cs8dP223s9JX++EWuanLlitjzwO50LWb8dM01mNG
	xVcDPOE0JwWNkGIqIFKoYzj+2qN1bnt3NvA9PR/GlfBJjrIGPSYx9VMHuLoBgEwYHSjt3uNjlvm
	C9NSfbL5nnYoyvInzeG+9wnc0FgmXftLMIaxlwrSCcJzneg8/AIGgENYtdEZt+/qCCc5OELmFZn
	BnYE/nbANM0JGE17TpdLDX6f9KkTM0i64CtYcyO/P+2QOrqwfJfKXpxLAsnILYl/8SfLnlLYoTF
	0hwQCHmzbbhkH+IWnpMDWSrQ2RwNjY/Ws7C7nX59afqKh6awOY791JjFvyuXHAXRt8c2FusIl4c
	flEf7aGUtdhzXOGZ53AI8SpvSR2RNpC+aF0d8u65kFnu68REEKWOl5VPMVvyyLR2JBjexKsbjKr
	GO+bOzL5tmnBY6pThmM4r5l88DjzHMGfkLaaDqgLaVfJIfWv0KbdIcv1Fltpcc4eQYcrAuku3Ik
	WwvGZ8sGyp5x+4D9DBetPJV+g3DtoFRenZB4e7daU2Qdo6+bcw7lNZj0WLURwyjW3WIYjXmeGbw
	7HDHxeChciPmTtGQIVTig7i+BPqxF89gZtqAhnl1mrKk/IsYSCP5CyiVvQkDf7g2YDsRWBLe7S0
	aAdyXVq6YsYhi5a+175MGayPuRisuo27QmNiFkNpH5+cLgA9wEgkkWfEbodJ4AXrJRSaAKw==
X-Received: by 2002:a05:6102:4194:b0:7b4:9eba:69dd with SMTP id ada2fe7eead31-7d0543c880dmr4776321137.45.1793738992639;
        Tue, 03 Nov 2026 12:49:52 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d77c6esm117398e0c.6.2026.11.03.12.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:49:52 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <20261103172251.2348370-1-pratyush@kernel.org>
References: <20261103172251.2348370-1-pratyush@kernel.org>
Subject: Re: [PATCH v2] mm/memfd_luo: don't use memfd_pin_folios()
Message-Id: <179373899206.721270.10991415543158845800.b4-ty@b4>
Date: Tue, 03 Nov 2026 15:49:52 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_124954_106052_DD7CD44B 
X-CRM114-Status: GOOD (  10.73  )
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 03 Nov 2026 18:22:50 +0100, Pratyush Yadav wrote:
> memfd_luo takes a snapshot of the folios in the file's mapping. To make
> sure the snapshot does not go out of sync, it pins the folios in the
> file via memfd_pin_folios(). The pinning also migrates the folios out of
> MIGRATE_MOVABLE to make sure doesn't land in KHO boot memory or in a CMA
> region.
> 
> memfd_pin_folios() does not lock the folios. So it can race with
> shmem_writeout(). A folio returned by memfd_pin_folios() might already
> be in swap cache. This happens to work but is fragile. memfd_luo looks
> at folio flags and index on a folio that isn't in the memfd's page
> cache.
> 
> [...]

Applied, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=next

[1/1] mm/memfd_luo: don't use memfd_pin_folios()
      commit: 9d07522bf59b3eb4b89b3a791a780a30884bfb5a

Best regards,
-- 
Pasha



