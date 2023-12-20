Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F83C3DA6E
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 04:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AoE6YjneYuJo+f/0HMT2QjDWx0PzKmJXvOPLh5/ARGo=; b=jyEhQqyPy7zYPx
	KetZftvjhUy5E2oGKHDtAIRAEgnSjCT3IS85mGT15DqsY8jIMuNfAD92/aX20FT8Pk9zOYWIf1MQl
	uFQsWSPToYiNHgFckSJODkvZhEsvkB1Pzwzyrp86RCGIH9WzVvEofAxYQiqVghGAJuCbh5WO9WMIW
	Xy/y5BYXHDr8dNwJvyKgRzCEGPDhyKhc57cWbd0I/itmv5Y04UOc7TKxEZGPuSGAuX8ijw46jitM3
	HtuEcdmxeufwm4Uvz15vp73IuvS5o6D129YUr5R0IJocJildDFu75IGrXsDpBEqPXBtb1fP4DNn9H
	c8Au9bZrm97Q+pJIenZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFo6U-00G7zL-3C;
	Wed, 20 Dec 2023 04:22:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFo6R-00G7wW-1y
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 04:22:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703046157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G45CImyqsOOmdqDD2eGP+r9BP7+mm5bd9KiBb8nBAIM=;
	b=CiOGIy9Kw6oQ0ZpO2ZUNgNABmiAArjFHoSdR2EULO16V8MQGKXaTQVNbH8Cyd5B7Vyxjpo
	K0YNrlY3nmJwRvL3iwG4zkE5HCq/bQCbZEhFs5IGAeBQJgZ6PgPyTGghA6Rf8GASckkxQp
	gnc0zNJAjPYmVz3i8XVxHd9H5h9XPv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Tu1M_nxTPP6L7Ts-3ewPyw-1; Tue, 19 Dec 2023 23:22:34 -0500
X-MC-Unique: Tu1M_nxTPP6L7Ts-3ewPyw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B6FA832D62;
	Wed, 20 Dec 2023 04:22:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 83323492BE6;
	Wed, 20 Dec 2023 04:22:32 +0000 (UTC)
Date: Wed, 20 Dec 2023 12:22:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Conor Dooley <conor@kernel.org>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, joe@perches.com, nathan@kernel.org
Subject: Re: [PATCH v4 5/7] kexec_file, ricv: print out debugging message if
 required
Message-ID: <ZYJsBW0Y7Y+XhSgf@MiWiFi-R3L-srv>
References: <20231213055747.61826-1-bhe@redhat.com>
 <20231213055747.61826-6-bhe@redhat.com>
 <20231219-twitch-many-ca8877857182@spud>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231219-twitch-many-ca8877857182@spud>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_202239_743078_CFD10768 
X-CRM114-Status: GOOD (  16.97  )
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

On 12/19/23 at 02:44pm, Conor Dooley wrote:
> On Wed, Dec 13, 2023 at 01:57:45PM +0800, Baoquan He wrote:
> > Then when specifying '-d' for kexec_file_load interface, loaded
> > locations of kernel/initrd/cmdline etc can be printed out to help debug.
> > 
> > Here replace pr_debug() with the newly added kexec_dprintk() in kexec_file
> > loading related codes.
> > 
> > And also replace pr_notice() with kexec_dprintk() in elf_kexec_load()
> > because loaded location of purgatory and device tree are only printed
> > out for debugging, it doesn't make sense to always print them out.
> > 
> > And also remove kexec_image_info() because the content has been printed
> > out in generic code.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> I'm sorry - I meant to look at this several days ago but I forgot.
> Apart from the typo that crept back into $subject, this version explains
> the rationale behind what you're changing a lot better, thanks.

Thanks for careful checking. I forgot the typo fixing you have pointed
out in v3 reviewing.

Hi Andrew,

Could you help fix the typo in subject?

[PATCH v4 5/7] kexec_file, ricv: print out debugging message if required
                           ~~~ s/ricv/riscv/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
