Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DD4C43458
	for <kexec@archiver.kernel.org>; Mon,  6 Jul 2026 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Og2FoiMIHkhzxa96aH1wPvklWvZPI3x9dY/s87h4T8=; b=ZeHPFYJx8+fbipOu9NKCpdnZk7
	pWN0CimtlPY900iC/ew5p+5dhieoQK9FgQNDQos7l/n4VDAHq3u3ldQ9cAj2LycpxNVKBS9LehSja
	fxhifqdfRiKGkd2EOFwb5re9K2ZCMszNtL8v3IXViUY2QW0M4OQ02tt5ZgEgHPCo0gsCl3+tF5loy
	DrN20fjKOJu9sfBrEbg4XYiSozSeiin6UbxyU7Yca/haHechlejbpVJQ2+KMq4l1O93KZ440YdIPr
	7jSkK4YnWKOMcPu67KVS/yQyIKk7zYvAZu0OSS74UuJW2cfo03fNMYjN+R+yuFBgqKwg0ocaOgDrE
	2NEfHxGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgZZ9-0000000BR7A-2CAs;
	Mon, 06 Jul 2026 03:00:15 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgZZ6-0000000BR6a-0jug
	for kexec@lists.infradead.org;
	Mon, 06 Jul 2026 03:00:13 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3847e8b0f3aso1001536a91.3
        for <kexec@lists.infradead.org>; Sun, 05 Jul 2026 20:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783306810; x=1783911610; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Og2FoiMIHkhzxa96aH1wPvklWvZPI3x9dY/s87h4T8=;
        b=keuqWbL1/0Rgt35ZImY7qkQevRHYPdcb8eqnUOIW4Fte9PLEwiS8HZvonSXTnfHzL+
         7b7cHh7H/cWyOoi9WtaMi3I+bs/mB7A4ofiK6dLXmHFboamIN7g+cx9cdYl3z+D8fJvs
         nvU0A04UpPqgsbfeGyD78ofc/1bhB+KCHii66466Nfzx6PToORueyyyL1MWmDdu6J7e5
         spG+fuX5d7uV3t8craDeJkbtMyCob1SM88SNZH8Txxk6sYJ9rBY85jbxwPmGfEELYnSQ
         2sp/VHU6uilqk/YShFQEyMBlQPoIC3nv3DenUI+iTiDnZXk8ATXBWcMp0gyJbXu6Qv/I
         iPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783306810; x=1783911610;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Og2FoiMIHkhzxa96aH1wPvklWvZPI3x9dY/s87h4T8=;
        b=q+Fffr9lG+Fzxchetznxzdq5xgiwnFb2fwIF705KIPGOThkBczVDQ1AtSL2ZZsRWde
         Nh+ErquQ09hZP3y70qgrttySI9rWgIOhjTy9ptsc8aGzy4op0n2+TBZ+6F/edA1r+oit
         B+5NlUL0PSiNtwKO4mP7CE7YE189K63/sS7RceWwi8piNadglMU0JTgQ+oFbvSjdH3m6
         eSZvI3ftbaLb/vVbRxgMqMqXN4DVSR6uhP+Vux65UPH5VS13dVDObSzxo/qaKgIgiOR/
         JccwUDy3HjoOmev0SDS+9a/oIZejlzfE9cAuRrE5mHCWBioX6flzNpxjDTn9tQG+ioew
         yK7w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+4PH0kXebH/LixlPdLjAAXy5Y8QmQASlZRRfD5xxMRlR2dTHH8fgnJ+Oe6ZMKql0NDlyFIg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxuUbUZnI+rGmBfeMZFKor9iOs5hZrCYZgawyCcJQqjM66VI2Z9
	dz8CIGAPe4cWk09s/hGHi2QOz4Nlvw+SjaYQR0YHH9gUxZRCpT9hnxu2
X-Gm-Gg: AfdE7cmjDB0G78605D2PAkwvxW9YOJ/HfVwexhnVvZY4mx/vr/4szOWAjbov01ZUpxP
	5/OMTyePyQGFMq8DDmFQ+ANd1qcjDTKIAGbKao2J9hCzy75Lyk5yHwX/LKc1WQFeMsTvcVCZVRY
	TRjtJV/8ac0+3PxMPzuXg9qSw4AS6CyJ2CKVZ+ke1a58F+E5adnlBoruJTjxYuJGPwXTF/n5nfG
	3S+AbPahMzYM5bEYNemqbnpL7jQnQHFztJOSbORYVLlvRQlN39GpcPpsrcGOUmJsgf8dsJ1rf10
	j3RZObWMvK4JPs6+17qx5eUZd04ifhwfxpxYIXlpigdl+MhilC8B3Q/OP/tpO7c4kmY4ijQPDoe
	JFeY+jjhga0Azi/u1kI8BLqjCmO0VNCj9jh8zPpzda64SCqus+zhuXSeVoay3s4pLNUJ0gFXdPx
	pXjxdoAQ==
X-Received: by 2002:a17:90b:2682:b0:381:21ea:9147 with SMTP id 98e67ed59e1d1-38281184e03mr9983981a91.13.1783306810305;
        Sun, 05 Jul 2026 20:00:10 -0700 (PDT)
Received: from localhost ([2a09:bac5:55f0:18c8::278:41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31151fff32fsm12857601eec.21.2026.07.05.20.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 20:00:09 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 6 Jul 2026 10:59:40 +0800
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Dave Young <ruirui.yang@linux.dev>, Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crash_dump: release keyring reference at the correct
 time
Message-ID: <aksWPOkN7IgZ6ffn@Rk>
References: <20260704112509.3717884-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260704112509.3717884-1-lgs201920130244@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260705_200012_221774_4B41509F 
X-CRM114-Status: GOOD (  16.91  )
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

On Sat, Jul 04, 2026 at 07:25:09PM +0800, Guangshuo Li wrote:
>restore_dm_crypt_keys_to_thread_keyring() gets a reference to the user
>keyring before restoring the saved dm-crypt keys.
>
>The same keyring reference is then passed to add_key_to_keyring() for each
>saved key, but add_key_to_keyring() drops that reference on every call.
>This is only balanced when exactly one key is restored. With multiple
>keys, the keyring reference is dropped too many times and may trigger a
>refcount underflow or use-after-free.
>
>When more than five keys are restored, a refcount underflow/use-after-free
>warning can be triggered.
>
>The early error paths after lookup_user_key() also return without dropping
>the keyring reference.
>
>Keep ownership of the keyring reference in
>restore_dm_crypt_keys_to_thread_keyring(), drop it once on all exit paths,
>and make add_key_to_keyring() only use the reference without consuming it.
>
>Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
>Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>---
>v2:
>  - Mention the refcount underflow/use-after warning seen when restoring
>    more than five keys, as suggested by Coiby Xu.
>  - Order local variables in reverse Christmas tree style.
>
> kernel/crash_dump_dm_crypt.c | 15 ++++++++++-----
> 1 file changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>index cb875ddb6ba6..c685497cd470 100644
>--- a/kernel/crash_dump_dm_crypt.c
>+++ b/kernel/crash_dump_dm_crypt.c
>@@ -81,7 +81,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
> 		kexec_dprintk("Error when adding key");
> 	}
>
>-	key_ref_put(keyring_ref);
> 	return r;
> }
>
>@@ -104,6 +103,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
> 	struct dm_crypt_key *key;
> 	size_t keys_header_size;
> 	key_ref_t keyring_ref;
>+	int ret = 0;
> 	u64 addr;
>
> 	/* find the target keyring (which must be writable) */
>@@ -118,7 +118,8 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
> 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
> 	if (key_count > KEY_NUM_MAX) {
> 		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
>-		return -1;
>+		ret = -1;
>+		goto out;
> 	}
>
> 	kexec_dprintk("There are %u keys\n", key_count);
>@@ -126,8 +127,10 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>
> 	keys_header_size = get_keys_header_size(key_count);
> 	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>-	if (!keys_header)
>-		return -ENOMEM;
>+	if (!keys_header) {
>+		ret = -ENOMEM;
>+		goto out;
>+	}
>
> 	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
>
>@@ -137,7 +140,9 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
> 		add_key_to_keyring(key, keyring_ref);
> 	}
>
>-	return 0;
>+out:
>+	key_ref_put(keyring_ref);
>+	return ret;
> }
>
> static int read_key_from_user_keyring(struct dm_crypt_key *dm_key)
>-- 
>2.43.0
>
>

Hi Guangshuo,

Thanks for addressing my feedback!

Reviewed-and-tested-by: Coiby Xu <Coiby.Xu@gmail.com>

-- 
Best regards,
Coiby

