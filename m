Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DADBC43458
	for <kexec@archiver.kernel.org>; Sun, 12 Jul 2026 12:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kwd2Hm1aeQSElHv9iBES7Olf7mP2g8VZIOWbrDqKMfE=; b=geQgCXfHsmvv/epm6+ZU1nP3cy
	TExqucSmLpGbRXFaiTs/iMT9qRk5FW5uuSWWHZCH1IaDOhIDfSSzA1PKa+XIsT9mVZiBI/hXxX2RQ
	Nrh7YWlweyWVD5Id4UnvgaIm/7mkVvHwWCOJgUOvgdeknV9Hi6pd1zSC/RQbrljqLOatoFHL3KRMZ
	gaiHkKnBWlgaJ0AN6WcJPwSygy1lHZY8Z4Kj9ZEHkU51+7Rt1Jg/aI4B51CSARh5YIeS9oqCGOyrK
	nxRPY1ldEGuRzvh7wbiu2kaRC8oAz74jePnE7DlVk+ueepvjFPNLds8zSvga75lo4sWZCgE/Gvo2F
	KJif00wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wisrP-00000007QfG-2zPj;
	Sun, 12 Jul 2026 12:00:39 +0000
Received: from out-189.mta0.migadu.com ([91.218.175.189])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wisrL-00000007Qel-1QBX
	for kexec@lists.infradead.org;
	Sun, 12 Jul 2026 12:00:38 +0000
Date: Sun, 12 Jul 2026 20:00:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783857630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kwd2Hm1aeQSElHv9iBES7Olf7mP2g8VZIOWbrDqKMfE=;
	b=wnq/4E/Yz4q4SWFX7z7A07PSbNlosNAoawhV3qB2X3Ay3rP18dPq8rkPQkpaSjvwToSsYX
	/KQN1ffo5ZAelv06TSLfA8/kDD9AArLlh6ZiwjQpadsSuV06Ca1jHueGB+BMemTiS6QKcQ
	rfhY1xpVaY8G5SiC3AGZt3DuxUSIdJ8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, Coiby Xu <coxu@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crash_dump: release keyring reference at the correct
 time
Message-ID: <alOB02chtcQcG6lo@MiWiFi-R3L-srv>
References: <20260704112509.3717884-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704112509.3717884-1-lgs201920130244@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_050037_176120_657B1456 
X-CRM114-Status: GOOD (  24.16  )
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

On 07/04/26 at 07:25pm, Guangshuo Li wrote:
> restore_dm_crypt_keys_to_thread_keyring() gets a reference to the user
> keyring before restoring the saved dm-crypt keys.
> 
> The same keyring reference is then passed to add_key_to_keyring() for each
> saved key, but add_key_to_keyring() drops that reference on every call.
> This is only balanced when exactly one key is restored. With multiple
> keys, the keyring reference is dropped too many times and may trigger a
> refcount underflow or use-after-free.
> 
> When more than five keys are restored, a refcount underflow/use-after-free
> warning can be triggered.
> 
> The early error paths after lookup_user_key() also return without dropping
> the keyring reference.
> 
> Keep ownership of the keyring reference in
> restore_dm_crypt_keys_to_thread_keyring(), drop it once on all exit paths,
> and make add_key_to_keyring() only use the reference without consuming it.
> 
> Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Mention the refcount underflow/use-after warning seen when restoring
>     more than five keys, as suggested by Coiby Xu.
>   - Order local variables in reverse Christmas tree style.
> 
>  kernel/crash_dump_dm_crypt.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

LGTM,

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index cb875ddb6ba6..c685497cd470 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -81,7 +81,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>  		kexec_dprintk("Error when adding key");
>  	}
>  
> -	key_ref_put(keyring_ref);
>  	return r;
>  }
>  
> @@ -104,6 +103,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>  	struct dm_crypt_key *key;
>  	size_t keys_header_size;
>  	key_ref_t keyring_ref;
> +	int ret = 0;
>  	u64 addr;
>  
>  	/* find the target keyring (which must be writable) */
> @@ -118,7 +118,8 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>  	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
>  	if (key_count > KEY_NUM_MAX) {
>  		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	kexec_dprintk("There are %u keys\n", key_count);
> @@ -126,8 +127,10 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>  
>  	keys_header_size = get_keys_header_size(key_count);
>  	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
> -	if (!keys_header)
> -		return -ENOMEM;
> +	if (!keys_header) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
>  	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
>  
> @@ -137,7 +140,9 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>  		add_key_to_keyring(key, keyring_ref);
>  	}
>  
> -	return 0;
> +out:
> +	key_ref_put(keyring_ref);
> +	return ret;
>  }
>  
>  static int read_key_from_user_keyring(struct dm_crypt_key *dm_key)
> -- 
> 2.43.0
> 

