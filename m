Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B047C4167B
	for <kexec@archiver.kernel.org>; Fri,  1 Dec 2023 10:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xmUqAAGaVt455gK4RjOzRVJbw3iGTQkB6/9ns886jM4=; b=JKUH8QSLDJn0F1
	qqAGc1lWqcAVpH+LgB6FShc4CngIBbMpKzdq4pljrfiFVY5hdeH3bfE331zYnKka5pV85nAFD40cH
	30eW+I7KHOGbRLCbBCKExvxkvnDd6FuJ5PtfKfibP0UGezof5Eps1pm9VradFgLkSlRup3fxZHXBl
	nttTYIVkNOzgNGZT4Cu4om2Ga3Fx8MjRPxQKod2fY9/SDN2w0HMxXDml9qpmX4RN0wZbJAB5PLOIA
	0n6iVQ+pMq/TV19UKmXtfKVpFXvg3jhdvgGzRhaTs8licFTQp38nrWQRiimHIREChOJkc1cwDGwUC
	fV+Su0k30kv6kSL7gK1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r90ty-00DECx-2c;
	Fri, 01 Dec 2023 10:37:42 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r90tu-00DECA-2p
	for kexec@lists.infradead.org;
	Fri, 01 Dec 2023 10:37:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5061221C55;
	Fri,  1 Dec 2023 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701427054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3AKHXuA9rkIsDSYU4VYYdpC7Z1E4D6XbgmPzoeVMV08=;
	b=CY5cWtFOcN9jOy0PFWPsrJrLEpFGDaWd6f52ktF+iZ2lmZWLHChlb++7dLUkPDxpsYNoZw
	cVbos4WRyBhkKA8Ojovn8rsa3/Xmd6J20OADutV0XA77pLK1p9OIdUqTTHXWbt62jgMy89
	E4D5c0wnfPIpqefwkppJvFnM515DRS8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EDF81379A;
	Fri,  1 Dec 2023 10:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D1qICG63aWXNZAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 01 Dec 2023 10:37:34 +0000
Date: Fri, 1 Dec 2023 11:37:33 +0100
From: Michal Hocko <mhocko@suse.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Tao Liu <ltao@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWm3bYYsMXVFqnnj@tiehlicka>
References: <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiOO-KNJ82f6Gxu@tiehlicka>
 <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com>
 <ZWiRbLGdBMO2jFGs@tiehlicka>
 <CAF+s44TQ2g6VTL4JSubvch5VkW7SSsePp-aBz+kigg563NijJg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44TQ2g6VTL4JSubvch5VkW7SSsePp-aBz+kigg563NijJg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.59)[81.62%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_023739_090321_07EBB038 
X-CRM114-Status: GOOD (  15.33  )
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

On Fri 01-12-23 08:54:20, Pingfan Liu wrote:
[...]
> > I am not aware of any method to detect a driver is going to configure a
> > RDMA.
> >
> 
> If there is a pattern, scripts/coccinelle may give some help. But I am
> not sure about that.

I am not aware of any pattern.

> > > If this can be resolved, I think this method is promising.
> >
> > Are you indicating this is a mandatory prerequisite?
> 
> IMHO, that should be mandatory. Otherwise for any unexpected kdump
> kernel collapses,  it can not shake off its suspicion.

I appreciate your carefulness! But I do not really see how such a
detection would work and be maintained over time. What exactly is the
scope of such a tooling? Should it be limited to RDMA drivers? Should we
protect from stray writes in general?

Also to make it clear. Are you going to nak the proposed solution if
there is no such tooling available?
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
