Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AEEC41535
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 07:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SMhDYgOt3biJO7aDsuJenXfNA75ez3FMezJYrkU7KdU=; b=Wd9P6CzyP4MXjU
	FF/tY04BP06Zr96pBKRrbm2cTQSUvEAlMVwFkSZZkb3/M+Apid/OIBRgApMs1SAtgs3mwNgbDdFZ1
	DQ1VRB5QQjxPpjYv4Ruq5vM7CYteF46yFK19EvwYOsVqMvQN7LHe5rtmn0ZFFUYCfge59GHtfmOd3
	PcVeWLW1ftFiMc0MMCQ8Xv/TX1E0S5qeJ4Gg2oRK4NT+k1BsdX1LwyYEPXK4qJ2x+L6tuXsuQ9Kiu
	hgPKiaM+n422v6fFkaHYF4fupEpjBMCoJ4GJFd83hqKLt1W1TxvHTLCKSXC6uO2ZZWAyVUXvnfrFc
	yqY9XtG3BbNpA+gtfP1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUXJ-00D6Cs-09;
	Tue, 19 Dec 2023 07:29:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUXG-00D6Aa-39
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 07:29:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702970940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z41OPAeFuRVfVwpG8mOU7SweUlkIZGPKy5DQ+DlmDTM=;
	b=YBHQqiyyiYK2aqpKEMwwMcbViZzgCVo8RR4t8gDhooLQcJcx4AazNrlu5fI4mgIdIy6wnm
	wwMQry1ThxTOG5iG3N5YvBadsNaGmGKWT6EehyQ4GvhP5gQx2fBsH9DhpMXxVecIz7S6uU
	9EXKRQ3rcBAeJLgfzIGwQLjwcso6tBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-GXz9a8nTNNqDb8SpWVPjkw-1; Tue, 19 Dec 2023 02:28:56 -0500
X-MC-Unique: GXz9a8nTNNqDb8SpWVPjkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1E92848C02;
	Tue, 19 Dec 2023 07:28:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 05E791121306;
	Tue, 19 Dec 2023 07:28:54 +0000 (UTC)
Date: Tue, 19 Dec 2023 15:28:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Documentation: kdump: Clarify the default size of memory
 reserved by crashkernel low
Message-ID: <ZYFGMxkjfN3BVUq5@MiWiFi-R3L-srv>
References: <20231218034020.15341-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231218034020.15341-1-kernelfans@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_232903_082369_B9B4A8A9 
X-CRM114-Status: GOOD (  17.08  )
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

On 12/18/23 at 11:40am, Pingfan Liu wrote:
> From: Pingfan Liu <piliu@redhat.com>
> 
> The default size reserved for crashkernel=,low is decided by the macro
> DEFAULT_CRASH_KERNEL_LOW_SIZE, which is based on arch.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> To: kexec@lists.infradead.org
> To: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kdump/kdump.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 5762e7477a0c..a021ff155012 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -310,8 +310,9 @@ crashkernel syntax
>     region above 4G, low memory under 4G is needed in this case. There are
>     three ways to get low memory:
>  
> -      1) Kernel will allocate at least 256M memory below 4G automatically
> -         if crashkernel=Y,low is not specified.
> +      1) Kernel will allocate a chunk of default size memory, which is based on
> +         architecture, below 4G automatically if crashkernel=Y,low is not
> +         specified.

Good catch, thx.

Acked-by: Baoquan He <bhe@redhat.com>

>        2) Let user specify low memory size instead.
>        3) Specified value 0 will disable low memory allocation::
>  
> -- 
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
