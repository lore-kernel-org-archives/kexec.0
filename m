Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E8EC19F32
	for <kexec@archiver.kernel.org>; Mon,  3 Mar 2025 01:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zhgK+qmDRl4rHSWqmJa5YbcWbITFtEJIZPZRBB24C/k=; b=MLeLEY2ATCDe4RJW1oIIiXg07v
	juAOTmCNcDDgqpeQf/RHgTI37TCCveQD+WhpMDUNVJP7v9HIB8RIQYhqc0FlHdHzOHt3FAse58bXb
	xfyYX77jqFKoptN/ODHR1cHQFsFrszS4ybpoqog4MtQ5qSpXiXfjD4FIOqGnz6I7ykabhVn7x4C7f
	m4jTh71c68JWXa4N2y7LY+BNuyL3UZpVRRHduW0TrxeW0cPeg0x9vN0gs+n53ZpL3K61Znk5cBz1M
	FB+4ptm9IZ3m+EtxCw0fq83Or/re7bS/DmfvcwbZ5c+7Z4VGH1cHgVGCFgrxCFoXvBuwiPGtapPpw
	xk9gtC1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tov1T-0000000Gvc9-3qkj;
	Mon, 03 Mar 2025 01:55:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tov1S-0000000Gvbg-0ltq
	for kexec@lists.infradead.org;
	Mon, 03 Mar 2025 01:55:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740966909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhgK+qmDRl4rHSWqmJa5YbcWbITFtEJIZPZRBB24C/k=;
	b=hcLG3yEUKrot1u5VE1y7WUtLImStS9kMjlH16aUhn5vA4mAXIblbw58QjXJNlhJtx/kyEa
	kwzBvQmf+FAVFutk/BSuQFjUIPbKTI1z4yElerYbBN5ytq8WyUgOGhjR03jBDz7YVU5N4+
	B+J1BGCU66/FeUWwm0NN2xvs5qoAj7g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-HbBO5pdTN9OhB7UIpFZq_Q-1; Sun,
 02 Mar 2025 20:55:06 -0500
X-MC-Unique: HbBO5pdTN9OhB7UIpFZq_Q-1
X-Mimecast-MFC-AGG-ID: HbBO5pdTN9OhB7UIpFZq_Q_1740966905
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBA1D1944D01;
	Mon,  3 Mar 2025 01:55:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9390B180087B;
	Mon,  3 Mar 2025 01:55:03 +0000 (UTC)
Date: Mon, 3 Mar 2025 09:54:58 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 3/5] kdump, documentation: describe craskernel CMA
 reservation
Message-ID: <Z8UL8pW84S46Ca/K@MiWiFi-R3L-srv>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <Z7deQKy1F8BW1ibi@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7deQKy1F8BW1ibi@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_175510_298146_6B6C522A 
X-CRM114-Status: GOOD (  16.50  )
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

On 02/20/25 at 05:54pm, Jiri Bohac wrote:
......
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec8..ea4d53435515 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -987,6 +987,20 @@
>  			0: to disable low allocation.
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
> +	crashkernel=size[KMG],cma
> +			[KNL, X86] Reserve additional crash kernel memory from CMA.
> +			This reservation is usable by the first system's userspace,
> +			so this should not be used if dumping of userspace
> +			memory is intended. A standard crashkernel reservation,
> +			as described above, is still needed to hold the crash
> +			kernel and initrd.
> +			This option increases the risk of a kdump failure: DMA
> +			transfers configured by the first kernel may end up
> +			corrupting the second kernel's memory. This reservation
> +			method is intended for systems that can't afford to
> +			sacrifice enough memory for standard crashkernel
> +			reservation and where less reliable kdump is preferrable 
There's trailing whitespace at the end of above line, checkpatch should
be run to check it.

> +			to no kdump at all.
>  
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
> 
> -- 
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
> 


