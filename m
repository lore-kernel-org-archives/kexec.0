Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8940CD1288
	for <kexec@archiver.kernel.org>; Thu,  4 Apr 2024 04:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O9SdkJoQ7MdqfK/DYJ1EbiOMKMS7iOvPJ48FTIBN1C0=; b=MnCpFVs9165EB4
	gi2L+Ifold/2WcFxbY/ZJnut1FH/0Z072OmEG+e73/kVQe/Mpuo9jhRR4QZXouJGAw4nBF0pvw4x8
	Dn2L9rqpuJQqG87K3GN7Mm41TTTPw1FA3mn70TYNjenksDN66AXpZBGc43vIg82UFtTbGUERz9hW9
	uJCeR40KQ23FY9JU684nDb00mlbwPaHa9/iZG+C7XWWwuXuhj4xdi3oXBr35Hf0a42+KGHDH9DktP
	67h/f4B/N64+aIEXX0zSEaNIZO1pTZNwFaD8iFBYHoBKtcYaM/b2ADmWoWqO4GCon/YYHpm4dMSdK
	sO12Q+H/jRz3HAg1iVyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsEOU-000000019EI-18Sc;
	Thu, 04 Apr 2024 04:08:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsEOR-000000019D9-0w0j
	for kexec@lists.infradead.org;
	Thu, 04 Apr 2024 04:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712203679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tnf/JqmvOIZtBLVJwY7VQErV1KE6NDkwVDWid6kh50=;
	b=B0dVQptSTzzVXOVtfIvYrZTOmM6Hfoqaj8V3yMAwqIzqEWYeUo5u0fGHtPzKfywpd9bTYw
	uNz2tMlBT4g4EDV1y6/pcPtd7xDEFwnDzxi21rPbd0+N4toESGlQeTSfJ1e3h7cpWtUx5P
	sJVStcgsq/hC19o0WCsOIs6A3/QY2TQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-6qohKH8hNYix2r2mMKHUzQ-1; Thu, 04 Apr 2024 00:07:55 -0400
X-MC-Unique: 6qohKH8hNYix2r2mMKHUzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9445185A782;
	Thu,  4 Apr 2024 04:07:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F31448173;
	Thu,  4 Apr 2024 04:07:53 +0000 (UTC)
Date: Thu, 4 Apr 2024 12:07:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Justin Stitt <justinstitt@google.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] vmcore: replace strncpy with strscpy_pad
Message-ID: <Zg4nkkXYySZT6ZdE@MiWiFi-R3L-srv>
References: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_210803_365980_3190D95A 
X-CRM114-Status: GOOD (  19.84  )
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

On 04/01/24 at 06:39pm, Justin Stitt wrote:
> strncpy() is in the process of being replaced as it is deprecated [1].
> We should move towards safer and less ambiguous string interfaces.
> 
> Looking at vmcoredd_header's definition:
> |	struct vmcoredd_header {
> |		__u32 n_namesz; /* Name size */
> |		__u32 n_descsz; /* Content size */
> |		__u32 n_type;   /* NT_VMCOREDD */
> |		__u8 name[8];   /* LINUX\0\0\0 */
> |		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> |	};
> ... we see that @name wants to be NUL-padded.
> 
> We're copying data->dump_name which is defined as:
> |	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
> ... which shares the same size as vdd_hdr->dump_name. Let's make sure we
> NUL-pad this as well.
> 
> Use strscpy_pad() which NUL-terminates and NUL-pads its destination
> buffers. Specifically, use the new 2-argument version of strscpy_pad
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - don't mark buffers as __nonstring, instead use a string API (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/proc/vmcore.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..5d08d4d159d3 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
>  	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
>  	vdd_hdr->n_type = NT_VMCOREDD;
>  
> -	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
> -		sizeof(vdd_hdr->name));
> -	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
> +	strscpy_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME);
> +	strscpy_pad(vdd_hdr->dump_name, data->dump_name);

LGTM, thx

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
