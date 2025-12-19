Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B4DD711CF
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pPMTFpj+poxx7/zDrrH8L2s3ujEnA65Czi/amqx2WSc=; b=SE+zpnIs6FdJ9AHA5tsgyKvb6w
	a0BY4ROVYxu6CECF6VnYC04IPe64mRs+RWbcYD7qeVvOQIGeOscyLIYMfJ+/dD3/czJN5x/0lVZv5
	gn6b7IcM5UDYCUOY+W0mRBgkrxIZMl10dhTPMwq6As4pHqjop1SVIg+PSJRSHPU21qYH+s/KMsrNy
	XxZgJbVXIqiNXgcgVKQkcG92gU4HoGI/Jr3WaatouoBtkNcgWSMQcZXrK+Js2ku5UF2fiUxRwIdyW
	QYNlBE7CNKmwwm8DftTC/lBuViEjzYgl+Ws80KqtQa+yrsZuiKk7tis+co0tHuf1TPSnd5U78SXSu
	dojDZ2Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWOgr-00000009P75-0u2t;
	Fri, 19 Dec 2025 00:49:53 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWOgo-00000009P6j-1JFO
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 00:49:52 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so171303066b.2
        for <kexec@lists.infradead.org>; Thu, 18 Dec 2025 16:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766105388; x=1766710188; darn=lists.infradead.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPMTFpj+poxx7/zDrrH8L2s3ujEnA65Czi/amqx2WSc=;
        b=JQYWTr+QePlsfToB8qFs6FGjn1Nq0HT+vTMW6nrp2YjJQ0aZBOR09GkjDWQvDPSdal
         79KEbH94sasu2NUundwHQGei/GzuQgqADG71zm7Bk2ZYcx/dky3Qd6depEnWFFc5Tqzq
         P/JZCCuXQbPewwZxBYIDlW0fsjci+sddR5xP1iHKl6MEEEbeaPWt33qUez/JHzw1Xgtk
         szdjdKzvNvn4wcYIOFs7RgvWUvAW49p+71HrWob2zoA3LOKXosk8q/PUMCDdtg8TopXb
         QNgxC/u57kdwEUeh6uIEsXY2Fcvq7GXzMzD+8Gwk4knwMB+06qsv8Vbtuz3Mj7DLZTxX
         4+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105388; x=1766710188;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPMTFpj+poxx7/zDrrH8L2s3ujEnA65Czi/amqx2WSc=;
        b=i3ixKWuRcHusdD2KlJfjdLp5GovG5XqDpNmfUZ95pGRdmcR08Mfmm+yPg7uOy1z9MA
         aEZMepXMIDC4NDvWJvAEGbZ0nduo0B5ZbcXzxg9t4DK+pjrdoB5NsIOV3xO11BSc51Dw
         xvvDdJwOH0ELulsoKL5SX+sIDH4qPndoE+EVad3Nd2n+dfp607vf/D7rY6Y1LKsogU6Q
         aWxdddlDrp/4UAHh7n8esy+OBjY8L2zx91n4AFPIRYJJrwPM41n56hrTXO+Q8WRgBC4h
         JQDI5qvlv1f1aoC4hJmgsVI1jEvpzwNpkz38cJYoDV7PyfCDSYnhs+geADlkR2MCXjGK
         LraQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuwy1iaFDkRZw3joZT4SdHIaH73VQC7XziQiBC8r/zybCIlDbldYtBFV7MgOzPVTPE8dpKEQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHl/Q0NpWNxW55fyybpKoDzF/dBcTrh5tvSeKpNRulkWxERypI
	dEzAizoHSzvB4GC+Pfi3GLjHGV8LbUoi7CJlylp9hb2u6cZgrTMafzHgcB3odrxtSJ5Qn8/n116
	39/oyJ9sMDwXrNcGjkwxMaosHf5l6BSdOEUPp9MaJcA==
X-Gm-Gg: AY/fxX6t3qUXVxuzcNiHL1n4LnIsdqVWIKkU70+aD2+XY/MaliXjKFSa45v56eQNnI0
	BwcLCpHcuUHdQMllrIMsBU1LaB85gP43AmtEedMyN/DNhEy8diQPGeaYm1HSD7Rj505/5xmDTo1
	Q8Z/kB0KfrE7gd540z2A9rtnhAJx4lyfoMr/3l6WdGAN0O2ZlAu5TmgBlEir2ACEHutAscKK2Wq
	fx6JGg+0h+2bjbjtfbfODUdo7ikoqAw9N8vQA30M5LiPqmFHmZAuvRMZQFeKa8ZXGPZG+BzRJOD
	UwVxhBWDOnCfQeJb2t4QeE51
X-Google-Smtp-Source: AGHT+IFB1lgQ1YjNGIl9apVtHHzkGNQp5uVzCBPF8ZQ5DIWyfhqYrC+pX3LC94u2npkioZEPfhq0exsjKwkY/tYjlsU=
X-Received: by 2002:a17:907:940a:b0:b2d:830a:8c01 with SMTP id
 a640c23a62f3a-b80371df334mr119522866b.61.1766105388247; Thu, 18 Dec 2025
 16:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20251219002355.3323896-1-pasha.tatashin@soleen.com>
In-Reply-To: <20251219002355.3323896-1-pasha.tatashin@soleen.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 18 Dec 2025 19:49:11 -0500
X-Gm-Features: AQt7F2rlxzFwIQ7bazt1PzsJXWfqo6q4ieEctRpffjsnqxEr8sEh2wU5NyY4J00
Message-ID: <CA+CK2bAOMooH+NE5YanRyfK0KraRug2VHT_M59UpbiD5T2qu-w@mail.gmail.com>
Subject: Re: [PATCH] kho: validate preserved memory map during population
To: akpm@linux-foundation.org, pasha.tatashin@soleen.com, rppt@kernel.org, 
	graf@amazon.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, pratyush@kernel.org, 
	ricardo.neri-calderon@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_164950_399864_4AC6EC26 
X-CRM114-Status: GOOD (  18.95  )
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

On Thu, Dec 18, 2025 at 7:23=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> If the previous kernel enabled KHO but did not call kho_finalize()
> (e.g., CONFIG_LIVEUPDATE=3Dn or userspace skipped the finalization step),
> the 'preserved-memory-map' property in the FDT remains empty/zero.
>
> Previously, kho_populate() would succeed regardless of the memory map's
> state, reserving the incoming scratch regions in memblock. However,
> kho_memory_init() would later fail to deserialize the empty map. By that
> time, the scratch regions were already registered, leading to partial
> initialization and subsequent list corruption (double-free) during
> kho_init().
>
> Move the validation of the preserved memory map earlier into
> kho_populate(). If the memory map is empty/NULL:
> 1. Abort kho_populate() immediately with -ENOENT.
> 2. Do not register or reserve the incoming scratch memory, allowing the n=
ew
>    kernel to reclaim those pages as standard free memory.
> 3. Leave the global 'kho_in' state uninitialized.
>
> Consequently, kho_memory_init() sees no active KHO context
> (kho_in.mem_chunks is NULL) and falls back to kho_reserve_scratch(),
> allocating fresh scratch memory as if it were a standard cold boot.
>
> Fixes: de51999e687c ("kho: allow memory preservation state updates after =
finalization")
> Reported-by: Ricardo <ricardo@example.com>
> Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr.s=
c.intel.com
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 36 +++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 9dc51fab604f..96c708f753d4 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -460,10 +460,9 @@ static void __init deserialize_bitmap(unsigned int o=
rder,
>         }
>  }
>
> -/* Return true if memory was deserizlied */
> -static bool __init kho_mem_deserialize(const void *fdt)
> +/* Returns head of preserved physical memory chunks pointer from FDT */
> +static struct khoser_mem_chunk * __init kho_get_mem_chunks(const void *f=
dt)
>  {
> -       struct khoser_mem_chunk *chunk;
>         const void *mem_ptr;
>         u64 mem;
>         int len;
> @@ -471,16 +470,16 @@ static bool __init kho_mem_deserialize(const void *=
fdt)
>         mem_ptr =3D fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
>         if (!mem_ptr || len !=3D sizeof(u64)) {
>                 pr_err("failed to get preserved memory bitmaps\n");
> -               return false;
> +               return NULL;
>         }
>
>         mem =3D get_unaligned((const u64 *)mem_ptr);
> -       chunk =3D mem ? phys_to_virt(mem) : NULL;
>
> -       /* No preserved physical pages were passed, no deserialization */
> -       if (!chunk)
> -               return false;
> +       return mem ? phys_to_virt(mem) : NULL;

I need to update this patch, phys_to_virt() should not be called from
kho_populate() before KASLR is initialized. This causes a problem with
my live update test. I will send a new version soon.

Pasha

