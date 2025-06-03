Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EECAC5AD49
	for <kexec@archiver.kernel.org>; Tue,  3 Jun 2025 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hXN9nPbX3VjM2OeWHPUoDpb9LpXeCU9nEzDdnFdKokk=; b=QfPC2CtuuA3torGdAcWtlwKEW2
	UepH++5K/QR+7zn3Rk35kavxhJIO8rKOisUK+Sl8unwiyglwyZtBL0WecIcNOmtyb80tWqK89JsRk
	AhQstFDmqaOsc49GwsEm3D/juLvbpOaZKaSiq8DTpvm09thrX1Ls27hJ8eIw2KcPttw1WBAPL2Hxx
	c/NrwQVahm+qSS+SfPmN4IGFBa6XjgfxFQZ1p4QJQqoaEAU5yXWm80rrAkQ1FFP8ekjaCWJdXQR+R
	XQfoj1ZY31MiFT1o3PRY5AivK+IISP3mnKGL5s+v1dBJxdfSuandLpmpYZ4zfVu52lNmdVdsBpLwO
	shrzSldA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMRDn-0000000AyJL-3HJd;
	Tue, 03 Jun 2025 12:58:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMRCX-0000000AyBv-3Mog
	for kexec@lists.infradead.org;
	Tue, 03 Jun 2025 12:57:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748955428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXN9nPbX3VjM2OeWHPUoDpb9LpXeCU9nEzDdnFdKokk=;
	b=b10H6bDBNgjb7l2jT+nAMq3vvpctQogsGrA0dS+fCOs6eo1JgzeFi7QCzXgcR2l4hwm+B+
	mF2TkUW2Z+qWGFSRefntcMjPKt9zLMs8KXPKNWOE+IV1OaHEky2f8xZG978gyV4Et63iku
	6CvqzJX+3syEttgNMzdRi2Q9m4cnX/Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-YxuB4EGBOPeFqJBeX4rZKg-1; Tue,
 03 Jun 2025 08:57:04 -0400
X-MC-Unique: YxuB4EGBOPeFqJBeX4rZKg-1
X-Mimecast-MFC-AGG-ID: YxuB4EGBOPeFqJBeX4rZKg_1748955423
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56F771808888;
	Tue,  3 Jun 2025 12:56:55 +0000 (UTC)
Received: from localhost (unknown [10.72.112.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 304753001FF6;
	Tue,  3 Jun 2025 12:56:47 +0000 (UTC)
Date: Tue, 3 Jun 2025 20:56:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v4 5/5] x86: implement crashkernel cma reservation
Message-ID: <aD7w/YfdKMqa7m89@MiWiFi-R3L-srv>
References: <aDoT08LfXUEkS9E4@dwarf.suse.cz>
 <aDoVhDc11ZcJyHm2@dwarf.suse.cz>
 <aD7WLv86BOVS+GPm@MiWiFi-R3L-srv>
 <aD7mi4j2llS-Kpfv@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD7mi4j2llS-Kpfv@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_055709_913093_B5569F55 
X-CRM114-Status: GOOD (  13.48  )
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

On 06/03/25 at 02:11pm, Jiri Bohac wrote:
> On Tue, Jun 03, 2025 at 07:02:06PM +0800, Baoquan He wrote:
> > On 05/30/25 at 10:31pm, Jiri Bohac wrote:
> > ......snip.. 
> > > @@ -582,7 +582,7 @@ static void __init arch_reserve_crashkernel(void)
> > >  
> > >  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> > >  				&crash_size, &crash_base,
> > > -				&low_size, NULL, &high);
> > > +				&low_size, &cma_size, &high);
> > >  	if (ret)
> > >  		return;
> > >  
> > > @@ -592,6 +592,7 @@ static void __init arch_reserve_crashkernel(void)
> > >  	}
> > >  
> > >  	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
> > > +	reserve_crashkernel_cma(cma_size);
> > 
> > Wondering if ,high|low is still allowed (or needed) when ,cma is specified.
> 
> Probably not needed but it works, totally independent of the
> extra CMA-reserved area.

Allowing it can simplify the current code, while I can't imagine what
cases need people to specify
"crashkernel=xM,high crashkernel=xM,low crashkernel=zM,cma" at one time.

Just personal thought, I haven't think of a strong reason to prevent it
too.

> 
> I saw no reason to artificially prevent it.
> 
> -- 
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
> 


