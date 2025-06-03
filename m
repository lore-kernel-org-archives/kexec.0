Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7FDC5AD49
	for <kexec@archiver.kernel.org>; Tue,  3 Jun 2025 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQ5BcGXjRwsj6/hcoXpBN/g6LN6iRqFAvntQX5XvCpU=; b=17ak3De5Ui0sd0LomSDdnKSHAr
	GO6r/xsUP7BjlQZLNpe0SuldiCfcKYlNLURKr6D5sVnMNMcmXhvqlR4VYSqD6/B2SinHaSDGSOQqb
	WGFF87ev7Frdv/T6GobROpd03WNCX6WtleLoYPIxM2Zn8y6wStCvy03A5Jom12P4Pe13jXhBIKRTO
	Mvr70em/xj4JB/TajxatfpvUsdOrRs86bMN33JZY/uk0GJPR6GhmOqtDl15XVhhfxR7b0W+aAdeSI
	70p9Mdnz5pSTHhRUhn6gXtI2BFEvEHAt2K4KxAQugfIhk8eYest7iTrbL92nIKL4SoqYmG/OwkrrU
	XV89/KmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMPPT-0000000Ajr9-0fAk;
	Tue, 03 Jun 2025 11:02:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMPPQ-0000000AjqJ-1Qyt
	for kexec@lists.infradead.org;
	Tue, 03 Jun 2025 11:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748948538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ5BcGXjRwsj6/hcoXpBN/g6LN6iRqFAvntQX5XvCpU=;
	b=CqNZYHJC1dSty83a03GdQ7DSz1pIvOqh+02TuhADU3nYJJE/dTEtDgnFWT5cDQcIpa+8AT
	jwRHSK+O6Z6JJc5S6ict5FS2sX1mKDOcPkqUSjW6ES8SRJ2uJ817gLsOPuLVQfmarzTIsL
	RJ7176488u6rZGkkh7oz5g+Bw5fMSnY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-9zuB8_OqPZWhpRAKD_cPpA-1; Tue,
 03 Jun 2025 07:02:14 -0400
X-MC-Unique: 9zuB8_OqPZWhpRAKD_cPpA-1
X-Mimecast-MFC-AGG-ID: 9zuB8_OqPZWhpRAKD_cPpA_1748948533
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 416031800980;
	Tue,  3 Jun 2025 11:02:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE32119560AB;
	Tue,  3 Jun 2025 11:02:10 +0000 (UTC)
Date: Tue, 3 Jun 2025 19:02:06 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v4 5/5] x86: implement crashkernel cma reservation
Message-ID: <aD7WLv86BOVS+GPm@MiWiFi-R3L-srv>
References: <aDoT08LfXUEkS9E4@dwarf.suse.cz>
 <aDoVhDc11ZcJyHm2@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDoVhDc11ZcJyHm2@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_040220_451245_7C786D71 
X-CRM114-Status: UNSURE (   8.07  )
X-CRM114-Notice: Please train this message.
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

On 05/30/25 at 10:31pm, Jiri Bohac wrote:
......snip.. 
> @@ -582,7 +582,7 @@ static void __init arch_reserve_crashkernel(void)
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  				&crash_size, &crash_base,
> -				&low_size, NULL, &high);
> +				&low_size, &cma_size, &high);
>  	if (ret)
>  		return;
>  
> @@ -592,6 +592,7 @@ static void __init arch_reserve_crashkernel(void)
>  	}
>  
>  	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
> +	reserve_crashkernel_cma(cma_size);

Wondering if ,high|low is still allowed (or needed) when ,cma is specified.


