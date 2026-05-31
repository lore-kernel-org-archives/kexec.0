Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66487CD6E52
	for <kexec@archiver.kernel.org>; Sun, 31 May 2026 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ecmbfN6Hxv0wzfAQ6MM3bdc8Nu3WaBbGIPmE7GrM3yA=; b=GuUaiiXQFq49XoLcoe111XVuRj
	97CkW4eOoCBI3VVYsGaWF6hyRk5vjmRu4BCxvKMcrVkzy+l+l5/WnNBrAtrfmc+SfvVefnnsArtNC
	P36QZq++ran97996T8VIVZOgJJkgpJl1MXzaOyHokYTSviJaSYsiO4DyUoMAzJpNNd/fSzol42957
	uUyZMFusL/ydeYZg1GDEIMMu7hJjIz5F8O3OAO4Z3JLM3msGBx156WdekqZJnQnKDXo1f4Ffv7heR
	+SK7OLRW0NHQTzjD9rRbR250yyMf1raXX5x5/wjm9WtGwyaa0U0WMLpZxviot8wp/OWzhqk0Pk4N+
	BnBmE1YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTgKY-00000009cy3-2c8e;
	Sun, 31 May 2026 13:35:54 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTgKU-00000009cxW-3vGX
	for kexec@lists.infradead.org;
	Sun, 31 May 2026 13:35:52 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so130584386d6.3
        for <kexec@lists.infradead.org>; Sun, 31 May 2026 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780234550; x=1780839350; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ecmbfN6Hxv0wzfAQ6MM3bdc8Nu3WaBbGIPmE7GrM3yA=;
        b=JsKzg+Uh9cX5LNfJH95xtx4qwN5dvUOHgOLt7I5UE7EA3JJmUMH8hbYyWAO3bljF2N
         1MZ55iH9hDfym/QnTbL0lvUyXK2YTK/H8+YFM5er4btp/4qXE7GsTEgnh5rK2NRMGR9E
         29ADgZmYjKpSGsZTO+MOAWUdGnt0162OJ+QWhKrgYHMCQCzQJDNSwT39JDzy+Ej141/y
         IvCEnFu7WhtJj0171Ac4fHvA/eWWoZ1LnoM3+imvqrAHDxJjUYxf9xl0X0/H0n9BQZOs
         Zm9D5kUNVQEz9e3odKmSPm2PRpLV0QB2vYlS+HiyO/xJchvGmWx12ovQR9bZR8Sdimr9
         aG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780234550; x=1780839350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ecmbfN6Hxv0wzfAQ6MM3bdc8Nu3WaBbGIPmE7GrM3yA=;
        b=VVWRMBMmSY/V2un9el2zweTCO8l80m6h/dYmie527h+9MuEW8W+vEO9ZvB25kNtvMI
         1iYKjDpqoSaC4YXBpS0HNQwTQ0lNjUntUEXWAIRdEgdrgKTcwhtlnJQva+NpRqNLpwx0
         tfHc4sJqFXJYyfTUOUaX1bFODD/qMiDP81F4oIteCfZ0TKM10naZiMhC3yBEUfWcXLPR
         YTUqdmzTWeP+tQoqAlrm3EZkgJo0hGX8vuFBKISuj6vpanQPSrxtcwFCNUq0ZIleqCB7
         1UhX+lKN+FRPSnZ/dQoJBiu7PNCgNR7o591Zer0HWBrk3N6BgAgqlttdtXnigmIXeOJt
         kZxw==
X-Forwarded-Encrypted: i=1; AFNElJ+JIB8QMtJL8opFsrawosi/VDKfA2iNs4tP30Qq5Qg7apNFV3ixhUxny5xmjRiXcvreiBem4A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyo4Hy9DwZPCnTyR8HRP7uO7WcQH2AIZK+j7Df7ReM1VfGRrrUM
	5LX+JGI/Cj3k7KEz6o4LGddvlptGNYJnCSjMRFRrQ5XDObmxVAxx2A6T2/5XPQXT30Y=
X-Gm-Gg: Acq92OEHImjmopLDtPX/2U0DWygJM2wWgUqI2o8RuCtBZv8gHtHjdTMfzt3hshqupNH
	T3m9LCibZRY3NagBUGxb0emF8YPW0J6GW+ZXZi5K0MalB2MbyjovSkzXIi+xUT0Citm2Xd50wPp
	BMd/wvo8vOHtzZCpMM9jSsle0V6Dm40kTNrFARsEnV0F0cFlEwjO3Q2OYp8/aXkIkYYMQr4jeyv
	A6gkFpYlzG7WTA7uRoANbxQGf4sZ7vyzxJrS5tSG54sUboNajOyBI+9fb/0iFo6DHPCo/sR79I9
	2TPV+wA3vfulixSQc6Brt1ACs2HT+eoO9EPl3bGGCgLpKpYmY4ahN+I8y0g57Dw/T+Pb75U1bFi
	SMH4pTmto/R4qAxgmIm4R8qM9wgscD5pMX7TosRY7mVKp0eSJwtLdgGG0kSqDGCpft1TI0Xu6qm
	07h4MX/i+lypU6PjQGUXGsc697a/94RNfVgBqoIY9x28Dc/5M+CTI20MstMnEo2w==
X-Received: by 2002:ad4:5f8e:0:b0:8cc:ee2e:8d9b with SMTP id 6a1803df08f44-8ccefd58403mr113278696d6.18.1780234549737;
        Sun, 31 May 2026 06:35:49 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0425dfsm69984996d6.3.2026.05.31.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 06:35:49 -0700 (PDT)
Date: Sun, 31 May 2026 13:35:48 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
	pasha.tatashin@soleen.com, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v4 01/13] liveupdate: change file_set->count type to u64
 for type safety
Message-ID: <ahwv0ZiyQ6TzoCah@plex>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530221938.115978-2-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_063550_983890_A3898A11 
X-CRM114-Status: GOOD (  18.67  )
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

On 05-30 22:19, Pasha Tatashin wrote:
> This improves type safety and aligns the in-memory file_set->count with
> the serialized count type. It avoids potential truncation or sign
> conversion mismatch issues.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index dd53d4a7277e..ae58206f14ac 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -52,7 +52,7 @@ static inline int luo_ucmd_respond(struct luo_ucmd *ucmd,
>  struct luo_file_set {
>  	struct list_head files_list;
>  	struct luo_file_ser *files;
> -	long count;
> +	u64 count;

From Sashiko 1:
...
Since FLBs use a single contiguous block for serialization, an untrusted
KHO payload could provide an abnormally large count.
...

Answer: NO, there is a chain of trust during live update. The previous 
kernel acts as a boot loader for the next kernel, and performs all the 
necessary verifications. We trust the previous kernel to pass the right 
things if compatability strings and format matches. KHO payload has the 
same trust as the previous kernel.

Therefore, we assume the serialized metadata is well-formed and valid. 
Defending against a malicious or hostile KHO payload is outside the 
threat model of this system.

From Sashiko 2:
...
If luo_session_finish_one() fails (for example, if a file handler returns
-EBUSY), the early return skips luo_session_remove() and
luo_session_free(). Since this is called during the VFS release operation
via fput(), VFS will unconditionally destroy the file descriptor regardless
of the return value.
...

Answer: NO. A finish failure means that we cannot safely release 
resources, as they might be associated with devices and DMA activity. We 
deliberately leak these resources to avoid memory corruption and data 
leaks. When userspace fails to finish properly and closes the session, 
the only way to recover these resources is to perform a cold reboot or 
another live update.

>  };
>  
>  /**
> -- 
> 2.53.0
> 

