Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C0AC10DAA
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MYj6UUJMiHrZiiCpUDCPuB7zJHhbdbX/9KQw28AKVZk=; b=uUcV5PxKFPBPNu
	djj0Xgk+MiOFF40I3xRCXElJVSfqjLzK0fzLuKWMtl/xwhHfkeoLevvFQ08Pj2iN98Z4jw8Ix5G4g
	8N6wyyomD1IRv9O7NEhODCth11xYm+v1Q/Van4JtzCHW/4376NXaPuP0RcqIS4CxFa99ZF/JAl9LC
	jg+ir2Y0NpjJBQBsH7l5rx7lssYpk+VvNq1WSrLly4qPu9baVBKqNKnQSoToKiiwtr1ab1J+ZCpuQ
	vbc+2AD06IG5OfztrdJUNGZRSPpG8YOjJkF7mxqV2zrO7kqMGDxOfM7Je+xGxq2KlfUd6wjEspBp2
	eC8qTthFFgH9tvFAiOAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8hI6-00Az5L-2a;
	Thu, 30 Nov 2023 13:41:18 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8hI3-00Az4g-1v
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 13:41:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD3C71F8BF;
	Thu, 30 Nov 2023 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701351673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9F9Mgbd1Q4nxfYba9ZeBtXatG2N5U9vDkUkfp7pibMc=;
	b=NDNLxkDV7C7sVgY2ASW+FK9THKNYGKG9Uyf9jdGkIx/rUOWgxWzVeNVfAUva8bkjJR70UN
	Rr49wObYN5j8iyFNhRpZbHH1/MHx37i9VvjqmB1q988TQMS1rVQyC7+5abTjwVI3xBBBJo
	n0arfHpl0zPyW8Hi7NASLOoaXwuBTy4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAA8213AB1;
	Thu, 30 Nov 2023 13:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V4niJvmQaGWRQwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 30 Nov 2023 13:41:13 +0000
Date: Thu, 30 Nov 2023 14:41:12 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baoquan He <bhe@redhat.com>
Cc: Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWiQ-II9CvGv8EWK@tiehlicka>
References: <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.60 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_054115_817050_C5CD0DD5 
X-CRM114-Status: GOOD (  26.18  )
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

On Thu 30-11-23 20:31:44, Baoquan He wrote:
[...]
> > > which doesn't use the proper pinning API (which would migrate away from
> > > the CMA) then what is the worst case? We will get crash kernel corrupted
> > > potentially and fail to take a proper kernel crash, right? Is this
> > > worrisome? Yes. Is it a real roadblock? I do not think so. The problem
> 
> We may fail to take a proper kernel crash, why isn't it a roadblock?

It would be if the threat was practical. So far I only see very
theoretical what-if concerns. And I do not mean to downplay those at
all. As already explained proper CMA users shouldn't ever leak out any
writes across kernel reboot.

> We
> have stable way with a little more memory, why would we take risk to
> take another way, just for saving memory? Usually only high end server
> needs the big memory for crashkernel and the big end server usually have
> huge system ram. The big memory will be a very small percentage relative
> to huge system RAM.

Jiri will likely talk more specific about that but our experience tells
that proper crashkernel memory scaling has turned out a real
maintainability problem because existing setups tend to break with major
kernel version upgrades or non trivial changes.
 
> > > seems theoretical to me and it is not CMA usage at fault here IMHO. It
> > > is the said theoretical driver that needs fixing anyway.
> 
> Now, what we want to make clear is if it's a theoretical possibility, or
> very likely happen. We have met several on-flight DMA stomping into
> kexec kernel's initrd in the past two years because device driver didn't
> provide shutdown() methor properly. For kdump, once it happen, the pain
> is we don't know how to debug. For kexec reboot, customer allows to
> login their system to reproduce and figure out the stomping. For kdump,
> the system corruption rarely happend, and the stomping could rarely
> happen too.

yes, this is understood.
 
> The code change looks simple and the benefit is very attractive. I
> surely like it if finally people confirm there's no risk. As I said, we
> can't afford to take the risk if it possibly happen. But I don't object
> if other people would rather take risk, we can let it land in kernel.

I think it is fair to be cautious and I wouldn't impose the new method
as a default. Only time can tell how safe this really is. It is hard to
protect agains theoretical issues though. Bugs should be fixed.
I believe this option would allow to configure kdump much easier and
less fragile.
 
> My personal opinion, thanks for sharing your thought.

Thanks for sharing.

-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
