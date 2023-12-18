Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CB2C46CCD
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ck2IMiVbXY6R1df/Ab5e6QZyDoY95WwRMk0ln5nc7nM=; b=cx939oCB6CZ2Ug
	i/feQwGvAGMUjTQf8fkBIh6GI+09wphtKVMNR3h++QAhafXBxpI5UfQXkWddMNYWWBESAAvSjjxmm
	ImbxXEouEE+ChLnVHcPBLk20y58vN9kMBpo1uZ4mIeZxO+LBeUl/6rDr86ECCjos+0/1qgAVWJg9P
	op3Zc55Zm4oZDudxQLgTX9rLv3I8+SeS6C6OKjtwWq/PBw2yNNYqJf0DfPonTpoWTuG1xoVoVKoj6
	5U2KsTrEjGs4mP445sHRTIfa3tjrlzn8pBhrmvy4D/z9YkHvIiTSbAW6zxav5rOIM4TzitpghDU1s
	KHjRCtKj4KRbO954g+eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFP3-00BBjw-2e;
	Mon, 18 Dec 2023 15:19:33 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFP0-00BBi4-0V
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 15:19:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39AF521E57;
	Mon, 18 Dec 2023 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702912765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkE3Ty1UFAMABO07gtqaHbzitATpH+Yca30i00FRs0I=;
	b=oWPetQDH20PCee8AdXpkLJ0uWotz5BxuBmLmvn6Pwe7nRWVUPWF2W+EQd2gFXGDKp+lNLZ
	3VXgXlGq+NZmEIzO9IwJGcKo7ODPSnF4QonVopRGBegW1e5u+enX7oniKGrIFRqXsnB3V6
	yEzIJZjsVBJuHsw8lrHK7C7uMB/IQAE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702912765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkE3Ty1UFAMABO07gtqaHbzitATpH+Yca30i00FRs0I=;
	b=oWPetQDH20PCee8AdXpkLJ0uWotz5BxuBmLmvn6Pwe7nRWVUPWF2W+EQd2gFXGDKp+lNLZ
	3VXgXlGq+NZmEIzO9IwJGcKo7ODPSnF4QonVopRGBegW1e5u+enX7oniKGrIFRqXsnB3V6
	yEzIJZjsVBJuHsw8lrHK7C7uMB/IQAE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F24413995;
	Mon, 18 Dec 2023 15:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2bIiO/xigGUUfAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 18 Dec 2023 15:19:24 +0000
Date: Mon, 18 Dec 2023 16:19:20 +0100
From: Michal Hocko <mhocko@suse.com>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC 0/3] kdump: Check mem_map of CMA area in kdump
Message-ID: <ZYBi-Ljt2yhrEIUc@tiehlicka>
References: <20231218052325.20982-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231218052325.20982-1-kernelfans@gmail.com>
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.84%]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_071930_345409_B99CDF9C 
X-CRM114-Status: GOOD (  15.48  )
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

On Mon 18-12-23 13:23:22, Pingfan Liu wrote:
> From: Pingfan Liu <piliu@redhat.com>
> 
> 
> First of all, this series is only for proof of concept. It only passes compilation.
> 
> For years, CMA is proposed to be used as crashkernel reserved memory.
> But DIO prevent us to follow it since DMA may be in-flight and ruin the
> kdump kernel.
> 
> This series exports the crash kernel's CMA area information through
> device-tree, and kdump kernel skips any page, which refcnt!=mapcount and
> has a potential DMA activity.

I didn't have time to look deeper into implementation (and I will get
back to it only early Jan) but mapcount based checks are really tricky
and unreliable.  folio_maybe_dma_pinned sounds like a better test. You
definitely want to have that checked by more MM people and CC linux-mm.
 
> The exported information include:
> 	u64 kdump_cma_pfn;
> 	u64 kdump_cma_pg_cnt;
> 	u64 kdump_cma_pg_paddr;
> 
> And they should be filled with Jiri's series "[PATCH 0/4] kdump:
> crashkernel reservation from CMA"
> 
> After the conjunction of two series, the CMA used for kdump has only the
> following risk, where the following conditions:
> 	-1.a wrong code forges _refcnt and mapcount to the same value
> 	-2.the page is also used by DIO
> 
> 
> Is it acceptable, or any rescue e.g. CRC on page?

We alredy do have vm_debug=P which enables init time poisoning
on all struct pages. The value is then checked when the page is
allocated.
 
> Please share your thoughts.

Having a sanity check on exported cma pages makes some sense to me. The
exact check might be more involved with false positives but they
shouldn't be a major problem unless there are too many of them.

-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
