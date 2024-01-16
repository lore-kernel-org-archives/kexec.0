Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398EBC4706C
	for <kexec@archiver.kernel.org>; Tue, 16 Jan 2024 08:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lAGuMTGyoe/Fc6/WLTfxW7JDRjQxClzDzcQlREMuxGQ=; b=is1HirwFx3ruuz
	gAA39UukCLPwmG9x/oGduWrVm6Db4ECQSXo2yxZkEoAwx1v37Dqj9RdQfhgrEld56Os7mzm2nFghr
	XwZFeuPSNeC0C087vHtonF35+viiiRQWVBp6IY4ZStH/m5KHJgsEqRKPl9Ipm2bHwq45crUtZt2YK
	DwEBNvlaWB3Q+KWqXq3hCkY3I4cREikz8IGaYyXpxvDfmkQrMYmmMXbxuQB7uPbX2j71iy08D2Vyi
	ylIolXPh8diyCp6atumb1KlTg8XOKP5oN6zoNh3moPhI9MrYo2sGfOa7pye1pKLuaq18lsOOWC/Dd
	G/twGEr9qPa0FqbIogag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPf6u-00BT39-38;
	Tue, 16 Jan 2024 08:47:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPf6s-00BT0c-18
	for kexec@lists.infradead.org;
	Tue, 16 Jan 2024 08:47:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705394865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UncHVfW4Ux3jXdUAyztvDXP0zGW8LLIYO8kgbeAGUyc=;
	b=icj4p6QI8wMdIkDJeI9SCUf6paK2txg19pmnLxiSb4o3s+JCnHfxtmPKebFnMU0MIaXvOB
	4GZlJbt/UAHvdnyadiQ+TwGOoEUEsQ+DLauEekQRhpRrT3v9q1gykIppJlabNsIh1AdfjA
	9keuuHT5a5+LPQXSKABbj4F30xfUh+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-jat0MiqhMQS1Y64ttKZo5A-1; Tue, 16 Jan 2024 03:47:42 -0500
X-MC-Unique: jat0MiqhMQS1Y64ttKZo5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C26785A58C;
	Tue, 16 Jan 2024 08:47:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 05A31112131D;
	Tue, 16 Jan 2024 08:47:40 +0000 (UTC)
Date: Tue, 16 Jan 2024 16:47:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <kernelfans@gmail.com>, corbet@lwn.net,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Documentation: kdump: Clarify the default size of memory
 reserved by crashkernel low
Message-ID: <ZaZCp0LVTgXAmm79@MiWiFi-R3L-srv>
References: <20231218034020.15341-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231218034020.15341-1-kernelfans@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_004750_478312_12FEF30C 
X-CRM114-Status: GOOD (  17.87  )
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

Hi Jonathan, Andrew,

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

This is a good catch in the obsolete section. Could any of you help
take this?

Thanks
Baoquan

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
