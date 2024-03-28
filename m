Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B559CD11DF
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 22:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rlcx6d+NOSRQRayDCWEZjjLHOnZyQ3IVQpMVOIzbae8=; b=b+xK3PJywmtXFW
	EYabFhtGd+RSEMCHaQO4LSPZLJfZYQ0PFcqPvyQ7pBVkKDvxe2TtZIvw8VUie/kmf+THnze4fOMHR
	AYW3/bEEkSlI103rtIrGkys19xso8sHSdoXcKCgnn9A1G5X8tsTl4gGk4hM2144y/YgEPZhNIQ48L
	CB0TWwrjuI8NRxcfmnLrt77FsyRpvxkxSZBjsUyC5AOaVV2VcIOGr23ysCtpT+C+Gz9iREEQDdL15
	uwLtJNOlyxf5kvpdfgxPkvOtoGMrgLxoz/mvyy7uDWfYat1aCgxyopTA8UEjzhtaLmJ4K45B2LcMQ
	+Gr3frTYAB2YaZVUbtnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxqJ-0000000FqKb-1MxC;
	Thu, 28 Mar 2024 22:03:27 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxqF-0000000FqK7-48mM
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 22:03:25 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so1240530b3a.2
        for <kexec@lists.infradead.org>; Thu, 28 Mar 2024 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711663402; x=1712268202; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5W1XwHUqOUXzkT7pj5ftVmW2F1U2vvJHxbFamzQmMtE=;
        b=cdbEo2BKPKPfEhTAbOtCRatkneFsUD+GgH/y0rbF3Z1qqraY4hRyznDh8T3zbQhK5X
         DDhC6Wupwc980g8HYMEA9LYZQ5jUhIRCAJ17orOiQ433KTFvRUEt58qNOu2n0Vbg26ay
         +Zhl+YSOLr3TH9swr97WuUzWuluYr9QRALdBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663402; x=1712268202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W1XwHUqOUXzkT7pj5ftVmW2F1U2vvJHxbFamzQmMtE=;
        b=Sc7AkoR+TaV4HfqJNLwDLxe3gF1UXjXs+FA7bfFky6wyAeevCMlwSnRpk/0C3u/N/i
         2Ng5V32lbrcbd4mwCd62pNwVTrFC9JK5CZ/eskYnyNovYx758xeBMlxya2g5a3Z9tlVF
         Wryst98uG9r6XQQMYpjXT9bedsFccUCqIPCBbTw/sbdEIJeq69UVrRqgQO5Wh0uRefvg
         YYB5+Jd9AkBs/6PoAf8NtVobxFm2Q2i+VDTFvwBaAUMx52RStASI49JoCWtSDv78p4tH
         YKEOKOX0NLD9KvKKlSTmQIrrrLX8f7LrLNhISG4d1ZxzkFWJF1/aOwewUEqGHo1k659v
         J+6w==
X-Forwarded-Encrypted: i=1; AJvYcCUSO9CM5AzJc7r9L0FXLKE5GUYrzfHR3bxWh09kFhiLvhWfNr5+a8Q8UANYksV8cdmOhZMWls8aK4zWaQfH1Q3aoosuLjX3WlN2
X-Gm-Message-State: AOJu0YzT5hnhuHaUbCrIpoX8NaXed/6uDMrmsQlQEs4J/PCpyi5yDOFo
	rEEXu7VDsbL8cX+QbF9EPObswFTRIgczJNTHo8fx0de8oI4U1oRLekGI99nSVQ==
X-Google-Smtp-Source: AGHT+IEVXwyYhggPVw8VuFhU/t79pm25Cu/RS/1a4nClVa0kQslD07bEuERIBQRwDdkrXkWM7nSBkg==
X-Received: by 2002:a05:6a21:998e:b0:1a3:c3fd:8e03 with SMTP id ve14-20020a056a21998e00b001a3c3fd8e03mr502896pzb.38.1711663402543;
        Thu, 28 Mar 2024 15:03:22 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78044000000b006eab6f3d8a9sm1857451pfm.207.2024.03.28.15.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:03:22 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:03:21 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] vmcore: replace strncpy with strtomem
Message-ID: <202403281502.BD156CD01@keescook>
References: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_150324_131101_F60D6363 
X-CRM114-Status: GOOD (  23.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Mar 27, 2024 at 09:10:52PM +0000, Justin Stitt wrote:
> strncpy() is in the process of being replaced as it is deprecated in
> some situations [1]. While the specific use of strncpy that this patch
> targets is not exactly deprecated, the real mission is to rid the kernel
> of all its uses.
> 
> Looking at vmcoredd_header's definition:
> |	struct vmcoredd_header {
> |		__u32 n_namesz; /* Name size */
> |		__u32 n_descsz; /* Content size */
> |		__u32 n_type;   /* NT_VMCOREDD */
> |		__u8 name[8];   /* LINUX\0\0\0 */
> |		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> |	};
> ... we can see that both `name` and `dump_name` are u8s. It seems `name`
> wants to be NUL-padded (based on the comment above), but for the sake of
> symmetry lets NUL-pad both of these.

Do we have a way to know that dump_name is not parsed by userspace as a
NUL-terminated string?

> 
> Mark these buffers as __nonstring and use strtomem_pad.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/proc/vmcore.c            | 5 ++---
>  include/uapi/linux/vmcore.h | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..5d7ecf3b75e8 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
>  	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
>  	vdd_hdr->n_type = NT_VMCOREDD;
>  
> -	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
> -		sizeof(vdd_hdr->name));
> -	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
> +	strtomem_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME, 0);
> +	strtomem_pad(vdd_hdr->dump_name, data->dump_name, 0);
>  }
>  
>  /**
> diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
> index 3e9da91866ff..7053e2b62fa0 100644
> --- a/include/uapi/linux/vmcore.h
> +++ b/include/uapi/linux/vmcore.h
> @@ -11,8 +11,8 @@ struct vmcoredd_header {
>  	__u32 n_namesz; /* Name size */
>  	__u32 n_descsz; /* Content size */
>  	__u32 n_type;   /* NT_VMCOREDD */
> -	__u8 name[8];   /* LINUX\0\0\0 */
> -	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> +	__u8 name[8] __nonstring;   /* LINUX\0\0\0 */
> +	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES] __nonstring; /* Device dump's name */
>  };

Unfortunately since this is UAPI, we can't sanely use __nonstring here.
:(


-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
