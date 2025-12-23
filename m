Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33FEE6B261
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 04:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TZcCotV/QfG6wRX3tVqdLU94aUxGvWejw2TKi4N7jYo=; b=mWHZ8JfXXewt9CnPtKjqKWMHsa
	ZV3Fb4RD2bH57ep3yTYEsCTYqivgaTR5mAKkQnZW1VH0gOjcMlT3sq1NYds0aehudD5p8ahbPFk1V
	7yYTXsVu6ndAb8axO1itRo3zx+4WATaq1rR+Ti094yVW5FWTRB2/lP1J88TUp8FIwqt5qSEfnVS63
	7gNNesSpftN3dBrR4RihNOqkVEX9JQgPhP9a9WLpOtJ9INq48jyYp4lNHipCS+8F5oLgjMFT0AzAM
	hp/gSY+EYtyMGjr4OhHg40VK2dnk0e6lwkqeA3Z6q6dVDcVYK7pdKop2ckuIDytPq72SfVzKAhAla
	kXbQqlVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXtbG-0000000EUJ2-2uwP;
	Tue, 23 Dec 2025 04:02:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXtbA-0000000EUIR-0rZz
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 04:02:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766462530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZcCotV/QfG6wRX3tVqdLU94aUxGvWejw2TKi4N7jYo=;
	b=EseLCy1JPeQwHwv7Uwiy+SNCsVI1zc2ImeyEVRfckBk40ZxttxMDzSwm0NactoJ/S8iAFS
	uT4Iugquo3fYyCl0oUKiFWGPbzddPyAgeHRtRssZA1umBra6AkxxDorV4Klzyt/Lk+VJfB
	ES/2zPZ6MonCoMl2D910KGGgwdpcYsc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-W3_UWaYHP2i0oo5ZUxMFBA-1; Mon, 22 Dec 2025 23:00:33 -0500
X-MC-Unique: W3_UWaYHP2i0oo5ZUxMFBA-1
X-Mimecast-MFC-AGG-ID: W3_UWaYHP2i0oo5ZUxMFBA_1766462432
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0f0c7a06eso90053065ad.2
        for <kexec@lists.infradead.org>; Mon, 22 Dec 2025 20:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766462432; x=1767067232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZcCotV/QfG6wRX3tVqdLU94aUxGvWejw2TKi4N7jYo=;
        b=utWBqTwvIxM+wihqYKqJ0PD79XsJr626cUibIA0y1iivTei65vvaElAYMZwp6uZLPS
         7J19ILq6oV4G1aQuD8AvqSW6miXz2Gbey/x1gmzlNBE8PDsFYUX0OK//umaY+TFR4RFo
         ss2gzl3U6G3/V9rq47xPmYJN+1xfeAqAlVp6N0hBzH1oLiOEB5vlXJaR8D0dot4ZupBB
         oHhErFXbEuCcNRMZC40hqCYJV5aEvuMidp47nWolBNbZDjhpXneOi9BrJ0lmXR8sZtx3
         /4oS+iIeQvmigA1/mJcNxKAf4YGyM9sJeH5/L9K/axU6F4PFF7dI35NOXNeSgkorapaq
         WaDg==
X-Forwarded-Encrypted: i=1; AJvYcCUoHTUJNl6Lv+utqhfpuqo1tsz7IL6/qKC1eu6aol2MvszNP0abvl7RAndtk9VKHgyYtHhexw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwI4cAyI9LEPsPnaEdjFV7HlhB0+OK1qT+SrKowV5tWY6ajHGx/
	9xiu63YGMkqtTuiDVdig/cBJwp2s7hYe7RYFbxEwcrxGzOqgLGo1Me4eiEVcp8atJ1XtpmrchuK
	or+DZLIeE+Z7sglRb+umaKWpdZx3XktkRDUFgpS6ZqgwuctvRS6IGJBSHHXZRzQ==
X-Gm-Gg: AY/fxX7KBu5+HaWr+cfqih6jy6AB/oFCuN6vdRcPyI+tusHIH0CtwzpjsrkXAT0YZKF
	uRguH/u/rVqNgpYkGsu69kanmwk0yChzmJaYGP09yUE2y9bwBfarVCnKFkWQQf+WqcmSZ3+r4/o
	xWghkY7VJAoy5XgL/6FzFygmnF+GrIjQC1YGOgwhS0rGC+/HAff1t+bdNJUxir9ohFrPHubO66K
	V7tpJ3O4k4M0Ur76pCcsOL4VVb6ctteBNQ1WgnxcCBqjTs7tgeVmISuYRJx5NggnKdUazLa2sCP
	KH+CuE04hjDR1lvRJOHg606M/37vv+kILcvseLfCtUrY9usTW3tGOHOBBatDGKCfD4zsS/NKX1X
	m
X-Received: by 2002:a17:902:dac8:b0:2a0:ba6d:d0ff with SMTP id d9443c01a7336-2a2f223177dmr127364765ad.16.1766462431695;
        Mon, 22 Dec 2025 20:00:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzwF5m/iHyn55LEilssrWhhc0HpYjAI8bNeQoZneyKJRrnoEXNFbeVjwUfxPQct8rWlymXvg==
X-Received: by 2002:a17:902:dac8:b0:2a0:ba6d:d0ff with SMTP id d9443c01a7336-2a2f223177dmr127364375ad.16.1766462431140;
        Mon, 22 Dec 2025 20:00:31 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbcfsm113540215ad.50.2025.12.22.20.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 20:00:30 -0800 (PST)
Date: Tue, 23 Dec 2025 11:56:02 +0800
From: Coiby Xu <coxu@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] crash_dump: Constify struct configfs_item_operations and
 configfs_group_operations
Message-ID: <xygbee3xw72kjitwo6xas6cxoqnx4zmny35tqc4anypqdxiow6@ahoenkvggcv2>
References: <d046ee5666d2f6b1a48ca1a222dfbd2f7c44462f.1765735035.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
In-Reply-To: <d046ee5666d2f6b1a48ca1a222dfbd2f7c44462f.1765735035.git.christophe.jaillet@wanadoo.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 72lpEGHgOvhRg2HsnEHpcmUCEiTgQWpjgNuVIV1DUNg_1766462432
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_200212_318760_0486C44C 
X-CRM114-Status: GOOD (  15.58  )
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

On Sun, Dec 14, 2025 at 06:57:30PM +0100, Christophe JAILLET wrote:
>'struct configfs_item_operations' and 'configfs_group_operations' are not
>modified in this driver.
>
>Constifying these structures moves some data to a read-only section, so
>increases overall security, especially when the structure holds some
>function pointers.
>
>On a x86_64, with allmodconfig, as an example:
>Before:
>======
>   text	   data	    bss	    dec	    hex	filename
>  16339	  11001	    384	  27724	   6c4c	kernel/crash_dump_dm_crypt.o
>
>After:
>=====
>   text	   data	    bss	    dec	    hex	filename
>  16499	  10841	    384	  27724	   6c4c	kernel/crash_dump_dm_crypt.o
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---
>Compile tested only.
>
>This change is possible since commits f2f36500a63b and f7f78098690d.
>---
> kernel/crash_dump_dm_crypt.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>index 401423ba477d..0d23dc1de67c 100644
>--- a/kernel/crash_dump_dm_crypt.c
>+++ b/kernel/crash_dump_dm_crypt.c
>@@ -223,7 +223,7 @@ static void config_key_release(struct config_item *item)
> 	key_count--;
> }
>
>-static struct configfs_item_operations config_key_item_ops = {
>+static const struct configfs_item_operations config_key_item_ops = {
> 	.release = config_key_release,
> };
>
>@@ -298,7 +298,7 @@ static struct configfs_attribute *config_keys_attrs[] = {
>  * Note that, since no extra work is required on ->drop_item(),
>  * no ->drop_item() is provided.
>  */
>-static struct configfs_group_operations config_keys_group_ops = {
>+static const struct configfs_group_operations config_keys_group_ops = {
> 	.make_item = config_keys_make_item,
> };
>
>-- 
>2.52.0

Thanks for the patch!

Reviewed-and-tested-by: Coiby Xu <coxu@redhat.com>


-- 
Best regards,
Coiby


