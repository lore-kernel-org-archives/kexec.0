Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF65C624CE
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QGck5j6NKMY1JnPT10nWl78AbcbhkttqeTGSe2kPwRs=; b=NEMG9a8bldGaUVzGuNPN1evfsd
	M4bZ6B3dpUgB4EokxhgawaoEcRpK/kWqcPtqi9aG2pxMval4ObRYjtotykR1mWv5XeGKoUIljcDoK
	A17RuYw+KpXRwIJEFRW1RwDnNUp5HUY54OZXGg/9ivTLPhqZ6r0oek9hrwAvIqIc6eq2Tk8jBQWoC
	0LmOGXNJjSWyeQbKLtIWxRh+V0hTglFBX23n4s3ljjMiUsaCpbSM8f+tD6xMiIgcUoLFiY/Eu4Fjf
	jm3wanTu43etNGldEJZ5EUxOZUitTgZia+ObXKK4HeSHp7z6HhXLt9fEb4jm+9zZq7OeARgjpu3Ur
	NdfDQDtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12Os-00000009Xqx-2lqU;
	Mon, 31 Aug 2026 13:50:14 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12On-00000009Xoc-0R4H
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 13:50:13 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso2596989a12.2
        for <kexec@lists.infradead.org>; Mon, 31 Aug 2026 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788184208; x=1788789008; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QGck5j6NKMY1JnPT10nWl78AbcbhkttqeTGSe2kPwRs=;
        b=YjW3ofFJgd6JVpluL9lvdbw8110ERmZqn6ScepChOUaZoxRE/TlRd8nGnK8D2d5Q3s
         5bIcIOXV7z9zNf/2ZAvk6NdZZ12nzxIwIdHYWnQDapzsif9r/wWlmJrvyzTRWKExFXEJ
         wqq560smyZy+89HJQYvigEA1CnKbnbfBLMNp7Bezv3EndnwHlzreOVip25YEkdmnssAf
         5d3UCnDBM/cRuGYNb8B3bJCFyhsSn2oTA3rSi+TIXWECOZToKDkI31p6AdBxiBoh3cJS
         xq2ALYySrCTdDLmJDIuEtvovCSbbCxaIheblqanjWlDr0twbvVSrPYvuc8HVTn5psd/0
         IRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184208; x=1788789008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QGck5j6NKMY1JnPT10nWl78AbcbhkttqeTGSe2kPwRs=;
        b=U57rqP6iqv1pIYLxWF7LbS02C6JWScRkxRf5Wq1KF0a6W64abh5ObqzY2pKRnztEHC
         6yzniJHCoc8nEv2iipm34EMtTsuWkrsKzrm2Syl1w6nvHTIoGvlZbYHseLCrgVJZGIYt
         BEELN6aJ356UPTEnbLvb/Lu/8Z/JaNZt0+bn7m7l9BygtFkMRMV81dT5jpl4g1GQ/GbR
         hyB1/FP2Z2ju0CIWJI9gGX2+IpXbKbkknrzc99jiyQ7GWKTkkbRSfnOxRplRWZJInTIZ
         x7LrIOxvva8Ck+SFt9fHvKqPDnqEtpOudwK4J0jKts9SsRZ4l5lu2yqOR+R+4Q5/m347
         U/GQ==
X-Gm-Message-State: AFuF++nFPddT6dBNgL1yrSE5WSxk/85kKzmdfR/JRVAEj9J+tyxw+GC4
	PPHeqskFzhkSqFFX5JcPV37M6ilHEv3BWUulmdjWSFbkRSdegLHk+K6n
X-Gm-Gg: AYBFou3Yqu4DFppTAeIdpGI2NPU5nl03sv8+MNkFyq4Qt9jiVJYHme6vQA976omuHJv
	JGeAd7DDJ0+geNJ9pB37WExfXE1XcMdIccZacj3gugXd6GmiIDRnbeNu3YWKALPWt1qUtbUVmZH
	q6FmeAj4VO1si/zmMbQ4N4KN6atApXZ67UfXd08P/dIIk1F2YYXKawnICgVnDwTBjE8bERmpKaG
	H8ENmGkKsSYJqRB8bCMrXzL9hHNIIqsurYrYd1UIv6Jeb3avWfjfeAPow3KxNnrqqE9iYS7eOdr
	k9ns+KIWwxcbX/BiDq8yyBHli2zZshfINr5mZwGQ2C5F5/TA6n2jysWV5rV7mNX5tsWPCkqt7LD
	kX68EES2zAR9O14KzdP4A147cOoLS3jMwMcLKpK7mAuUl3lb1W+tfrpZ1M+eLxhntctoiiZBNJI
	AxqvfpGEt9klc5X3JJS+lyO/vO9erU0/yMkUwJ/Vhn7kLyWQ2jix5X8A==
X-Received: by 2002:a17:90b:3c05:b0:396:5cdc:4bea with SMTP id 98e67ed59e1d1-39907ab0955mr1271319a91.5.1788184205245;
        Mon, 31 Aug 2026 06:50:05 -0700 (PDT)
Received: from localhost ([45.112.44.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f552473sm33354998eec.0.2026.08.31.06.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:50:04 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 31 Aug 2026 21:45:41 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/9] crash_dump: Read the number of dm-crypt keys from
 reserved memory
Message-ID: <apWDnUNUZSkvYY38@Rk>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-4-coiby.xu@gmail.com>
 <859d4e5f-c491-4a0d-a7ea-0a16159f8059@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <859d4e5f-c491-4a0d-a7ea-0a16159f8059@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_065009_153600_7F025EEB 
X-CRM114-Status: GOOD (  14.53  )
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

On Sun, Aug 30, 2026 at 12:49:42PM +0530, Sourabh Jain wrote:
>
>
>On 28/08/26 14:18, Coiby Xu wrote:
>>In case user adds/deletes the keys by mistake, it's safer to read the
>>number of keys from reserved memory.
>>
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Reported-and-Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 36 +++++++++++++++++++++++-------------
>>  1 file changed, 23 insertions(+), 13 deletions(-)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index 026c7de4ad85..0b9e09c60745 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -89,21 +89,31 @@ static int get_keys_from_kdump_reserved_memory(void)
>>  {
>>  	struct keys_header *keys_header_loaded;
>>  	size_t keys_header_size;
>>-
>>-	keys_header_size = get_keys_header_size(key_count);
>>-	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>>-	if (!keys_header)
>>-		return -ENOMEM;
>>+	int r = 0;
>>  	arch_kexec_unprotect_crashkres();
>>  	keys_header_loaded = kmap_local_page(pfn_to_page(
>>  		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
>>+	if (keys_header_loaded->total_keys <= 0 ||
>>+	    keys_header_loaded->total_keys > KEY_NUM_MAX) {
>>+		pr_warn("keys_header saved to reserved memory may be corrupt\n");
>>+		r = -EINVAL;
>>+		goto kunmap;
>>+	}
>>+
>>+	keys_header_size = get_keys_header_size(keys_header_loaded->total_keys);
>>+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>>+	if (!keys_header) {
>>+		r = -ENOMEM;
>>+		goto kunmap;
>>+	}
>>+
>>  	memcpy(keys_header, keys_header_loaded, keys_header_size);
>>+kunmap:
>>  	kunmap_local(keys_header_loaded);
>>  	arch_kexec_protect_crashkres();
>>-
>>-	return 0;
>>+	return r;
>>  }
>>  static int restore_dm_crypt_keys_to_thread_keyring(void)
>>@@ -447,12 +457,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	mutex_lock(&config_keys_subsys.su_mutex);
>>  	mutex_acquired = true;
>>-	if (key_count <= 0) {
>>-		kexec_dprintk("No dm-crypt keys\n");
>>-		return 0;
>>-	}
>>-
>>  	if (!is_dm_key_reused) {
>>+		if (key_count <= 0) {
>>+			kexec_dprintk("No dm-crypt keys\n");
>>+			return 0;
>>+		}
>>+
>
>Not directly related to this patch, but I have a query.
>
>Do we really need to take config_keys_subsys.su_mutex when keys are
>reused? If not, how about moving the acquisition and release of
>config_keys_subsys.su_mutex into build_keys_header()?

Good suggestion! I'll try to apply it to next version.

>
>
>- Sourabh Jain
>>  		r = build_keys_header();
>>  		if (r)
>>  			goto out;
>>@@ -463,7 +473,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	 * cleaned up at the end of kexec_file_load syscall
>>  	 */
>>  	kbuf.buffer = keys_header;
>>-	kbuf.bufsz = get_keys_header_size(key_count);
>>+	kbuf.bufsz = get_keys_header_size(keys_header->total_keys);
>>  	kbuf.memsz = kbuf.bufsz;
>>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>

-- 
Best regards,
Coiby

