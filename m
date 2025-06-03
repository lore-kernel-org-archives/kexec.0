Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE36C5AD49
	for <kexec@archiver.kernel.org>; Tue,  3 Jun 2025 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKWJbX0PLKuRXFkwoq7rogv1tm65PhpIOsVYoZQ/ZIk=; b=bsl/BEZ6YCYX84LeAjjC49h50o
	mz+DcqmMQAw6zfgXsB4Yjp0+P6cBEcBRoNM/Ud1ogssMF+GwhsaIUixah0Jl/xIgxZq+Ze8dOoika
	dIWNcHNOV89c08AkaP/qdt6GNiVP162IT+LTJRapku63d+f3RTjunfcaGyP5nUjQAoR1/jb8G6Pa7
	fXcb77Oofa3iBj6Ay74lPEEUObG94OaoF/EHzCKt1u7xFSayDJBsXuZKFR6hNk0cwe9R7mGPqtPhP
	lOQ0gc9vn8V+aPMVIJdpScK22frKu0G7cc+tMmXyS7/Dv+lqqLWBO4yWEIbgfu3dQHHM5kwQDP7Fd
	4ZtmGz8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMQW1-0000000AtNq-3Y5B;
	Tue, 03 Jun 2025 12:13:13 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMQUo-0000000AtH3-3F4q
	for kexec@lists.infradead.org;
	Tue, 03 Jun 2025 12:12:00 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id AF3D11FBA4;
	Tue,  3 Jun 2025 12:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748952715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKWJbX0PLKuRXFkwoq7rogv1tm65PhpIOsVYoZQ/ZIk=;
	b=KBuDX1qc4X6RVCI1Er/XBW/X9j7Nl7fl7eA0Bm6/fBjn0GAIGBnKMQIBsHYgqT2/BH0o4x
	cHuXiV6nkmBU0TyuPUO1JmzqUTX5cNucS4I8ug7V0UI5a2ijfi6l8WJHUlyfJEvRDmQOki
	SYYan06yt6kxXs++1TYpRem5KHPzTt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748952715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKWJbX0PLKuRXFkwoq7rogv1tm65PhpIOsVYoZQ/ZIk=;
	b=f7zUdW+6DWgJFZCT0bpAFE/fV4iYkZG+u1R5OcMARAGM1iVM8oiOgYVyYRDk/KVXc2sXLT
	SzvANfWba12tJjDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748952715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKWJbX0PLKuRXFkwoq7rogv1tm65PhpIOsVYoZQ/ZIk=;
	b=KBuDX1qc4X6RVCI1Er/XBW/X9j7Nl7fl7eA0Bm6/fBjn0GAIGBnKMQIBsHYgqT2/BH0o4x
	cHuXiV6nkmBU0TyuPUO1JmzqUTX5cNucS4I8ug7V0UI5a2ijfi6l8WJHUlyfJEvRDmQOki
	SYYan06yt6kxXs++1TYpRem5KHPzTt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748952715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKWJbX0PLKuRXFkwoq7rogv1tm65PhpIOsVYoZQ/ZIk=;
	b=f7zUdW+6DWgJFZCT0bpAFE/fV4iYkZG+u1R5OcMARAGM1iVM8oiOgYVyYRDk/KVXc2sXLT
	SzvANfWba12tJjDw==
Date: Tue, 3 Jun 2025 14:11:55 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v4 5/5] x86: implement crashkernel cma reservation
Message-ID: <aD7mi4j2llS-Kpfv@dwarf.suse.cz>
References: <aDoT08LfXUEkS9E4@dwarf.suse.cz>
 <aDoVhDc11ZcJyHm2@dwarf.suse.cz>
 <aD7WLv86BOVS+GPm@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD7WLv86BOVS+GPm@MiWiFi-R3L-srv>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:helo,suse.cz:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_051158_957640_17BB90AD 
X-CRM114-Status: UNSURE (   9.28  )
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

On Tue, Jun 03, 2025 at 07:02:06PM +0800, Baoquan He wrote:
> On 05/30/25 at 10:31pm, Jiri Bohac wrote:
> ......snip.. 
> > @@ -582,7 +582,7 @@ static void __init arch_reserve_crashkernel(void)
> >  
> >  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >  				&crash_size, &crash_base,
> > -				&low_size, NULL, &high);
> > +				&low_size, &cma_size, &high);
> >  	if (ret)
> >  		return;
> >  
> > @@ -592,6 +592,7 @@ static void __init arch_reserve_crashkernel(void)
> >  	}
> >  
> >  	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
> > +	reserve_crashkernel_cma(cma_size);
> 
> Wondering if ,high|low is still allowed (or needed) when ,cma is specified.

Probably not needed but it works, totally independent of the
extra CMA-reserved area.

I saw no reason to artificially prevent it.

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


