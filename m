Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D1606A31D
	for <kexec@archiver.kernel.org>; Sun, 22 Nov 2026 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=D9IExhja;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aTTCHqHx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jlHx3q8hlvOapQpFRbpBP1dZTmv+VTbbRyW9rgzkxFM=; b=D9IExhjaySGcKM5aqB1SgRvv2I
	KtOc3nEYJPpkvvnGSd+B7l0n1d6dLJo7Bquf/e4BKkQIl2wxc5NKnNcUvKl6qyR2KSULL/XNOdApC
	5jyR0Na8ClwbUG1vw2RBsO4zKYyv9ktE2Kv1uBP3RIExqFTwKIuNHWVkGvE11nfdS+liVTryAvg5N
	tH+Ec7cEwWyHvP+lt4cvx1g1V7s5NcjnlLQHqBb2HIdhLPk1uoL7gHfUrv1LBw2gaC12pGDIpxHu4
	ULXidoGQN0NQqFXc5mQ7Bgt2bEXMOEOyQAQXsTnpXq12IyQNQA7PrXY1m63K0sugvzVyJttwBRNoT
	dB1WX+5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVEyZ-00000001mdr-2Pj3;
	Sun, 22 Nov 2026 21:19:55 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVEyU-00000001mdC-40eH
	for kexec@lists.infradead.org;
	Sun, 22 Nov 2026 21:19:53 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2f048bc09d7so61315ad.0
        for <kexec@lists.infradead.org>; Sun, 22 Nov 2026 13:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795382389; x=1795987189; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jlHx3q8hlvOapQpFRbpBP1dZTmv+VTbbRyW9rgzkxFM=;
        b=aTTCHqHxcPzw5alwQDQpzFJw6stYPv9bVF7HYmnHWCzsJzL3kH2zOsBbpUCYlZeY80
         M8MljgbFrImKYdFTEkyJlwVb+jEmm2dgKTSTSjkbfiWTotKN/VD7+/ks4EwyUtLaM2vI
         Yq8Zx6wcOJggxKEuvGg7YN04DTxDPhwgebOnZwQf7++p2iMY+Ibc+5pptIvvLqzvCBtH
         64L+v9en6h32kfhfKeCXvVShssGDSwJH5WpxQ0J/AYpXMujr9xbWL4TO7GmEsMfhyIPc
         8k0pj0Bl7RdInnZ6QcyBCTeLW5ZuZ02E4sLJfjI/zPGQOP4UJjGhpOBFI6exOVrvvpz8
         DfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795382389; x=1795987189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlHx3q8hlvOapQpFRbpBP1dZTmv+VTbbRyW9rgzkxFM=;
        b=kHagzRli+XMbm+zT6X88B6i6GG0/RHbHSqOKPMpchoJhLwjaXmv/0L2D3acLmTHAqz
         9iGAysaIxDrC4z3VRzWhEj19/nZxeSiqFUBvDPmVl0l71s05h+ZW4GVr8osunBxy7Fa0
         27mPX5X8yFtXw3yPPXnxHeWLHDu7r0dk5ndSDd1QjhEiO5Nd3v9pc8OBv5ZoX5soWYOR
         dAmKMC0/wCW5ntBspW6/g/blzsq68W5Gsm1p8eo6u9ckmuvgbqrZ05S5P5X0eeyuRqLc
         XdyIyfmF2fZ9usmyRLdLZohAIgbEf6eaVGAyH3alp7tiVtKHKX2A7yaQKZTzJB3PsJuM
         aO+w==
X-Gm-Message-State: APuU4Z+hQiGvnm+gHY2J4ZdcYyCN4LXKasGnrMA40Klfj4ddzqembD74
	mMxMfB8sKlmN3FkOF+tDyopH707/5uFfIHgkpR2AYnQWPwfaiZBo6w8TWiDPfVuijA==
X-Gm-Gg: AZFdTZfqky/j9U9/SwBrw9Ri5r9a+jdFNuulxFp8vGV/YKd3cr202U3fwlNPDg/fFB4
	snNu60RRl0J5isBQ/ccDcPkZLdA+ngl8XBZax0Ya8dI3TiGCZREkArZWaSAruqpQPiWksP9zdmE
	DHsH+t6ETMeso04+hxItzngewd2ZSpxX3iNOP5RBFCTQ55teYjWc+XRkmt8Ai3Ss4+5h6pQpHWH
	bAmsVDGQYFRNUioXoFlgJ/qLIiOeZkkUrc3Aq89Sbir7+L9Xi1A+v6tyAw/YgG0dV4P5lXAZuET
	75ddjG+QOmkq2iYw9iAqgGw6Aer1VdwgbBtxZrobuQ8f9x+0B5LDutmWyW7kTFs9Q9kvwXOYUoU
	/HofTUig7bB1L4qb+IzOzmbfdz3OE/PPe5GSebML9c1lT5sbr5aUYYYTSEX198xvaBMF/c+IO0Q
	sG8UsrxpkRJ5TGn1UaFbRezO1xS17FGaQJ24sB2/FQN4II0ua//+hFUll/oT+On6/69AXqzkAQR
	H2kHh+dJ4Y49Nl06fI6Eckn1LW1QEukLrtKOg2dAFoTCyuJrwTafse/8yqkLklt3zvpDdUTYHtC
	H0pv5IIg5LA+yws3NN//CrsMO7ijASOVFqeWSCefUJ0qUDfOnkZ1Tlf7BobjDX6VV5f8D1nC95V
	5mB9Kq9mO0hEm0FIEuSlZnA==
X-Received: by 2002:a17:903:19e3:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2f066708a17mr4257845ad.15.1795382388397;
        Sun, 22 Nov 2026 13:19:48 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm18461423a91.8.2026.11.22.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 13:19:47 -0800 (PST)
Date: Sun, 22 Nov 2026 21:19:42 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 03/27] liveupdate: Export symbols needed by modules
Message-ID: <awNVk3q6Q6sAHn6U@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-4-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-4-vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_131951_022634_EA82EA26 
X-CRM114-Status: UNSURE (   9.12  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 07:36:32AM -0800, Vipin Sharma wrote:
>Export liveupdate_register_file_handler() and
>liveupdate_unregister_file_handler(). All of these will be used by
>vfio-pci in a subsequent commit, which can be built as a module.
>
>Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>---
> kernel/liveupdate/luo_file.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>index dbae0715220b..6aaa9a531428 100644
>--- a/kernel/liveupdate/luo_file.c
>+++ b/kernel/liveupdate/luo_file.c
>@@ -916,6 +916,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> 	up_write(&luo_register_rwlock);
> 	return err;
> }
>+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
>
> /**
>  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
>@@ -933,6 +934,7 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
> 	luo_flb_unregister_all(fh);
> 	list_del(&ACCESS_PRIVATE(fh, list));
> }
>+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>
> /**
>  * liveupdate_get_token_outgoing - Get the token for a preserved file.
>-- 
>2.56.0.317.g454f8302e1-goog
>

Can you please send this separately, it can probably go in without rest
of the vfio changes? This is required by iommufd and guest_memfd also I
think.

Thanks,
Sami

