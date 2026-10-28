Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2875606A333
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ooC12z9M;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=PFxvy740
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GOkZMWndE8pvmQEZjLf6QfLtdr6Oc875cvI2O5RWo1A=; b=ooC12z9MHoKOZF
	V+Dap4BKOFkDVe6acQ13v3lCqRfwT8Mq3Zo/iRsn0yeMKWCtNKIC11ykxH7KJwt2vaFKJmK+IxOMt
	nBknnD6pT0dGDOUXdI03GT4nImuruZrA4z516wzoCRuVCD+vIP8wN69C37idfCP8B3iQmgpgLaWre
	mE3RwdWL/876T61jRhVbj5g9Ij9lqGNk93t4G36KSuUXHfr8oIXX8zsvMBBhT5lygJV17vhg44c59
	TgLNyVjTL9g7ALwqqbFoI28+Ja7wvHiz1ukOp5RYoBBXX1zeCCsgFkUHixbI1QsTQsHY2BFEFINQS
	Jbya7eoFc7J9jeQJ+o2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMAOX-00000007w9d-2QW0;
	Wed, 28 Oct 2026 20:37:13 +0000
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMAOU-00000007w71-0DIX
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 20:37:11 +0000
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-5eafb65e169so940407e0c.1
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793219828; x=1793824628; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GOkZMWndE8pvmQEZjLf6QfLtdr6Oc875cvI2O5RWo1A=;
        b=PFxvy740MjrCz+2qXRLSf7IcNW5/WMIHq1faWFnASXJpOHnMnfpdKRBMEh+6/QRj9i
         Hrpaj+XvsRtNM5cewtq+G2Cy6DXlhf6jrw4S6gczn7Hi3hFC33gk4+xmtdUYxTP+qKXX
         T/EnXkGhMVChdYWxTDZVpma6Jy3eE6g1LHoaE/5VEZg5KjGujiDotNCmv2oJqnHkuT3i
         u1WVm/apofsmLZ6PjtkZhYVxxg+ZxmQUgefW51boACH3VRD0rpGdZkvFBtWca0Hu++TD
         +z2sjDGPXNVN9lmWmV4f29ZxzOH9ra+zyeDZeAxAIeKVsuagLgAC0K4qij2esKBy8+Jd
         oorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219828; x=1793824628;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOkZMWndE8pvmQEZjLf6QfLtdr6Oc875cvI2O5RWo1A=;
        b=lyuP5ueqzoaNC3Q1eKAdryj/N+a5J/0Tj7O+r+Tp8XtxOgBjJPAeuFEHdWNn031AdR
         KJttWFvVrkM7tCJMIwqfZQ/EQCTcq2brmv2McPe/fedpk46ogmIgqE6MrmnMVxsMTqNU
         Kq8C6fAWtAbe1Ty9/ggR0HAxqk5a07DjZSeuQ0rhXUPLbQzuxZ3z1iuRuEWJK8ud+c61
         aBe7/xWNO1g1DVUWeFqN549ksj8vzmwx9uetN5wS9WNGuVrnRf8QvW+ukmvx7N/ASPrl
         KSF+kxI+qjHSP+Xji6GOLC/EMdG/Qe7IrODVXLhc9qQMEnDanqJTa5TEje7qrdS4qB7E
         MDuA==
X-Gm-Message-State: AFq9FYIdZOCIa5vK/wglFJjNrjMxtyVrsLefdIr5AnJM1vxled4uSo6R
	YDj20NRTo7p7Fsi9Udn0sE4XQIfTyHWV2EOtOCAFqrqu2WihXrN0aOE4o2KG/b41eq0=
X-Gm-Gg: AYBFou0U4h2lhcxxcxoldt7BIJR2Vo6Yh5h68Wo36l5+V03EKX9Jq8XLbdGRhSVTNro
	ftsuwk6Vnse37QGMHE5uhcZJ6zySHDSEN6KRJ3oQJtpSfaGiApKigJsDU2vNmijwNft7NcbH2AY
	zzb3G69iy8YsGultZFqMGtGqQbIVSlfd9uaxL1WrJL6zuNybpFF214PUj81BwFZISog2M2bucA3
	kD97bpyDlbirfh3bLHAGUxmlEVe1YzH1XdAUzwjkRV+6eR+SgvKkXTlV+qv+zAzkGg5yc+/fWwY
	2Y8tVjz3ERfeAryhOXBL7VXto5KtgRwWuu4hGpcRTtH2qjpel0jOZfePrKnPmHDfcgejeSqXBmR
	0DfQ2QeIkYXORLkV70hr2MOTNZ1kihovbVvvRGw6VuA5SgAwipiZuxqIhJ8RkEKPqT2V6xwiVui
	gdT9+4UX0yquIBntnHd+ot87H/mPY/uKZzZwo70oqwDfJrY0k3MfLifKqkYQHfqZJJqAKT13BHm
	2RrmiljLCby2DMNnXe6nL9cBMavtZmaoYNLj7oecpjiAdNlnbmxqACZtW0rDX13/oTburJIAQhn
	p4vQLibwn41kUdqtB2LIUXn6szwo0qNuo8+GINqaucPPLEGzF17rVMJsBzRdsA2pXkyZ1NihiSa
	v4PDm6LKfZ3vErQCjoO/c/onjMPRq0zzk/wAuRM6pcF04
X-Received: by 2002:a05:6122:e146:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5ec4cc275f7mr2103697e0c.4.1793219828216;
        Wed, 28 Oct 2026 13:37:08 -0700 (PDT)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f931911sm3001789e0c.10.2026.10.28.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:37:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 06/10] mm/shmem_luo: Don't make early retrieve
 failures permanent
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
In-Reply-To: <20261022225035.377445-7-dmatlack@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-7-dmatlack@google.com>
Date: Wed, 28 Oct 2026 16:36:59 -0400
Message-Id: <179321981903.1894369.10174219200491856665.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3851;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=tG1lwbJH2imddc9/EkdAvCrAH3EsxAEhBkg3bvhE7pU=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq4lzu/Ke5JngGl45TFenDqO7sG2rxu1esqb+GP
 W9djlMo20SJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCauJc7gAKCRC7dyhM23N6
 3iaED/9+Ua/XelfQOiEDcPhs+IpN2Oer+RtBy5oWFs3Ld85ncxpkokj4M4S+zrCda7T6eqJ99qt
 WLFndguG8lw6lCfX6vMRTCE9OvLMPJBZgk++IOWd8vMSMo6sJuHC2aIVh3oiJGQbplm8A1pHtUd
 vK6/sqWNP+mqdoADa7IlEmu7uydtPZQ6gVUtj2oUDU/YZzfGVeoNe5EpResTvkYk6Vdp1neLYfh
 lGFsCCrjbH7TCtTThMrEBPQ4JJlJ1/OFqdkCwFpq+cdyUtErBGUGLeK2rxFf07U8U/ydQn4SZUM
 WENbDKA0F1DjRR8/sx7kedrfcj9vWP2vd3hFY+cEsyTLawSybRQS3QTUa+gEJtOXZPjHosBrYLV
 SgvOrjrbhjAv0oaxXMYRWWKgn64IPRbOdPvQ4F/QszjMPjkReBEjjmQFtsspuKgQddk58EUwpqT
 4ngiCEIpWUObRZBvgLFJYKOfdLl0q15dVVsk2n07fF0Neb1UD5cKlw/weF8lT3q6GuTXbsMyJum
 A4XQ+dpSI5XTmQAxL/tylp3fhJLTkVqQo9jG9GkfeVltDyl5rgMWOELBqk40kb4LfCQGwzLL4Hl
 lFLQ2ewQ3dOcxeCNM8ZEEzGZDPFihhVjKt13uUjJSoCIYziR5ctZUkisBrVjd+w69E7fYLFUC0e
 eLmLu3ergMn5ALQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_133710_138094_70499674 
X-CRM114-Status: GOOD (  27.52  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> If shmem_luo_retrieve() fails before it starts restoring the folios,
> mark the failure as retryable and return the error without freeing the
> serialized state. Nothing has consumed the preserved state at that
> point, so the retrieve can be tried again. If no retrieve succeeds,
> finish() frees the preserved folios, like it does for a file that was
> never retrieved.
> 
> This fixes leaking the preserved folios when one of these early steps
> fails, e.g. because the file has seals that this kernel doesn't support.
> The retrieve freed the serialized state but not the folios, and finish()
> then skipped the file because its retrieve had failed.

You should also note that args->retryable was introduced in this 
series, so there is no fixup required for this since this was 
previously not possible.

> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>
> Link: https://patch.msgid.link/20261022225035.377445-7-dmatlack@google.com
>
> diff --git a/mm/shmem_luo.c b/mm/shmem_luo.c
> index b8d86055912d..bcac1bbb3db3 100644
> --- a/mm/shmem_luo.c
> +++ b/mm/shmem_luo.c
> @@ -390,9 +390,9 @@ static void shmem_luo_finish(struct liveupdate_file_op_args *args)
>  	struct shmem_luo_ser *ser;
>  
>  	/*
> -	 * If retrieve was successful, nothing to do. If it failed, retrieve()
> -	 * already cleaned up everything it could. So nothing to do there
> -	 * either. Only need to clean up when retrieve was not called.
> +	 * If retrieve was successful, nothing to do. If it failed permanently,
> +	 * retrieve() already cleaned up everything it could. So nothing to do
> +	 * there either. Only need to clean up when the file was not retrieved.
>  	 */
>  	if (args->retrieve_status)
>  		return;
> @@ -526,11 +526,16 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
>  	if (!ser)
>  		return -EINVAL;
>  
> +	/*
> +	 * Nothing has consumed the preserved state until the folios are
> +	 * restored below, so failures before that can be retried. If no
> +	 * retrieve succeeds, finish() frees the preserved state.
> +	 */
> +	args->retryable = true;
> +
>  	/* Make sure the file only has seals supported by this version. */
> -	if (ser->seals & ~SHMEM_LUO_ALL_SEALS) {
> -		err = -EOPNOTSUPP;
> -		goto free_ser;
> -	}
> +	if (ser->seals & ~SHMEM_LUO_ALL_SEALS)
> +		return -EOPNOTSUPP;
>  
>  	/*
>  	 * The seals are preserved. Allow sealing here so they can be added
> @@ -539,8 +544,7 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
>  	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
>  	if (IS_ERR(file)) {
>  		pr_err("failed to setup file: %pe\n", file);
> -		err = PTR_ERR(file);
> -		goto free_ser;
> +		return PTR_ERR(file);
>  	}
>  
>  	err = memfd_add_seals(file, ser->seals);
> @@ -552,17 +556,20 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
>  	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
>  	i_size_write(file_inode(file), ser->size);
>  
> +	/* The preserved state is consumed from here on. */
> +	args->retryable = false;
> +
>  	if (ser->nr_folios) {
>  		folios_ser = kho_restore_vmalloc(&ser->folios);
>  		if (!folios_ser) {
>  			err = -EINVAL;
> -			goto put_file;
> +			goto free_ser;
>  		}
>  
>  		err = shmem_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
>  		vfree(folios_ser);
>  		if (err)
> -			goto put_file;
> +			goto free_ser;
>  	}
>  
>  	args->file = file;
> @@ -570,10 +577,10 @@ static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
>  
>  	return 0;
>  
> -put_file:
> -	fput(file);
>  free_ser:
>  	kho_restore_free(ser);
> +put_file:
> +	fput(file);
>  	return err;
>  }
>  

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

