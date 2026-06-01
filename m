Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5F8CD6E55
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=93c3I3ubLRTv9EP1rAjvzUBB3rvXuHxApHqCDxTcN3c=; b=MQsg8U8MKewx6XouZY6J5BO595
	KC1Jl+uuNswxIjNUldDekjtex2YiWK2+o+CXYjXTVYl2cGQS0Ui88/zm0NS3hcD/J7EEtLWLeRTUH
	he529q4HRNQyoI0pGE5h9J7BrJWpDmmbXSnAv3vJeBVwIlzsEbFi/YhpbplrDC1jDYh7OQWeqXhAq
	c/QHaGKzInm9D/Up0BzMVnNdE2re+4E0kYg6Z+vBr9eRbzix1psF/DrU4hKWJFHIpSj1hObTRe6k9
	tdXu0tm/FYLElF2WizgbnE/a9bdphy+aN4WTjk+LxLtJtSbBA3dY2UchHGaWgpqOl3yDl140/AtdV
	H+1zSFYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3FK-0000000BFVB-3xKU;
	Mon, 01 Jun 2026 14:04:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3FJ-0000000BFUl-0T1d
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 14:04:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8253F436E8;
	Mon,  1 Jun 2026 14:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93471F00893;
	Mon,  1 Jun 2026 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322640;
	bh=93c3I3ubLRTv9EP1rAjvzUBB3rvXuHxApHqCDxTcN3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=I7v5ZKnV/Qbs3YwWgfExlqOMIyS8FMffwjzB1hpdLnTlaMxN/pAY6yQGT1Qeg3Swj
	 l1JqSAzZi2cEjyAfvIubam+9HECaY7nhbTtT7aUa9gN5Fz2Bb8RhWpJGgt3iRrJ+KF
	 zhFWGxW7/4VmYSiUrMoM6Aka9E1Wra1rL79BXxSAV7Cvy9m837RfLymf7HpdOngHKg
	 Ot6iMsSm5j+qSMLfo1vsB2ff6CGjQY7Eei5vYWNrCv2QDvVKxLicp0AqToTDXwbeco
	 0loSOjiW7KETp8OetSdLGG2P7a9c5iTY3cv/9OwXlqPyin8cp3S2XAXWvZkZMtuWmV
	 IYAtVtIohPqEg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v4 09/13] liveupdate: Remove limit on the number of
 sessions
In-Reply-To: <20260530221938.115978-10-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 30 May 2026 22:19:34 +0000")
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
	<20260530221938.115978-10-pasha.tatashin@soleen.com>
Date: Mon, 01 Jun 2026 16:03:56 +0200
Message-ID: <2vxzfr36fjcj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_070401_206699_6F327E3C 
X-CRM114-Status: GOOD (  19.28  )
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

On Sat, May 30 2026, Pasha Tatashin wrote:

> Currently, the number of LUO sessions is limited by a fixed number of
> pre-allocated pages for serialization (16 pages, allowing for ~819
> sessions).
>
> This limitation is problematic if LUO is used to support things such as
> systemd file descriptor store, and would be used not just as VM memory
> but to save other states on the machine.
>
> Remove this limit by transitioning to a linked-block approach for
> session metadata serialization. Instead of a single contiguous block,
> session metadata is now stored in a chain of 16-page blocks. Each block
> starts with a header containing the physical address of the next block
> and the number of session entries in the current block.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
[...]
> @@ -63,13 +58,15 @@
>  #define _LINUX_KHO_ABI_LUO_H
>  
>  #include <linux/align.h>
> +#include <linux/kho/abi/block.h>
>  #include <uapi/linux/liveupdate.h>
>  
>  /*
>   * The LUO state is registered under this KHO entry name.
>   */
>  #define LUO_KHO_ENTRY_NAME	"LUO"
> -#define LUO_ABI_COMPATIBLE	"luo-v3"
> +#define LUO_COMPAT_BASE		"luo-v3"
> +#define LUO_ABI_COMPATIBLE	LUO_COMPAT_BASE "-" KHO_BLOCK_ABI_COMPATIBLE

That's clever :-)

[...]
>  int luo_session_serialize(void)
>  {
>  	struct luo_session_header *sh = &luo_session_global.outgoing;
>  	struct luo_session *session;
> -	int i = 0;
> +	struct kho_block_it it;
>  	int err;
>  
>  	down_write(&luo_session_serialize_rwsem);
>  	down_write(&sh->rwsem);
>  	*sh->sessions_pa = 0;
>  
> +	kho_block_it_init(&it, &sh->block_set);
> +
>  	list_for_each_entry(session, &sh->list, list) {
> -		err = luo_session_freeze_one(session, &sh->ser[i]);
> -		if (err)
> +		struct luo_session_ser *ser = kho_block_it_next(&it);
> +
> +		if (!ser) {
> +			err = -ENOSPC;
>  			goto err_undo;
> +		}
>  
> -		strscpy(sh->ser[i].name, session->name,
> -			sizeof(sh->ser[i].name));
> -		i++;
> -	}
> +		err = luo_session_freeze_one(session, ser);
> +		if (err) {
> +			kho_block_it_prev(&it);
> +			goto err_undo;
> +		}
>  
> -	if (sh->header_ser && sh->count > 0) {
> -		sh->header_ser->count = sh->count;
> -		*sh->sessions_pa = virt_to_phys(sh->header_ser);
> +		strscpy(ser->name, session->name, sizeof(ser->name));
>  	}
> +
> +	kho_block_it_finalize(&it);
> +
> +	if (sh->sessions_pa && sh->count > 0)

Nit: Why check for sh->sessions_pa? It can never be NULL.

Other than this, 

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

> +		*sh->sessions_pa = sh->block_set.head_pa;
>  	up_write(&sh->rwsem);
>  
>  	return 0;
>  
>  err_undo:
>  	list_for_each_entry_continue_reverse(session, &sh->list, list) {
> -		i--;
> -		luo_session_unfreeze_one(session, &sh->ser[i]);
> -		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
> +		struct luo_session_ser *ser = kho_block_it_prev(&it);
> +
> +		luo_session_unfreeze_one(session, ser);
> +		memset(ser->name, 0, sizeof(ser->name));
>  	}
>  	up_write(&sh->rwsem);
>  	up_write(&luo_session_serialize_rwsem);

-- 
Regards,
Pratyush Yadav

