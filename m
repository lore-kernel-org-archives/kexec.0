Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73382C07E97
	for <kexec@archiver.kernel.org>; Fri,  1 Dec 2023 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M7JzJrI3mDRSYstkK09q1V6kO65WBZ016HX7VTav6kc=; b=SePtsTiaJDDsbS
	BPdn/CLnfQOfwOzbWa3Ue3eI0Zj/VtZZ9g/Ao7MVTdUKUwf0oyFhlqL8srICvJKcdeBNeWyWhX8GL
	Makvy3S4PtFnl0M6YpseYjP1y0wgpN0XCalug79OWhD8vTlx5p3iz3H/c2NzksXmlswBlxscua9Rw
	ZG50qz63lfxs/w1fN2IJkmzAziN92SqyI/0UE8e2R5DS+2miJBVHV+5xj7j1kte7zzyl7TuZYZT01
	YU71qdQoJTKuUbool0mgl2nNY3Dq3xSc6w33HMJ3sETkN3ptV5vZwiM+y7fQ/62NQD7nr6uTgk6xZ
	lhXaKPx04UQaL+LJjcDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r96r9-00EGsI-0O;
	Fri, 01 Dec 2023 16:59:11 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r96r4-00EGpO-0f
	for kexec@lists.infradead.org;
	Fri, 01 Dec 2023 16:59:09 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB7481FD7F;
	Fri,  1 Dec 2023 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701449943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lC7vlGIZCDtxYgghp69uMiLgN5wT33v6vp9VGEip7M=;
	b=iCLzZBGeHwTaopLyzeZXrnzlZRLhRgwoMlJ3TstRPb7jsrLGdVJjjx68Ls6C/+sF1usJbe
	qJTiD2w/AwtWxrIixZGsUj4HmgByLfRDPasE04Barcf4uZC17nqzLSk+it6ZebwH8hvwWH
	wU6jKOVF56YSfkqLowsXrT+Zn6APurw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7DDB1379A;
	Fri,  1 Dec 2023 16:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /FoDJtcQamUlZAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 01 Dec 2023 16:59:03 +0000
Date: Fri, 1 Dec 2023 17:59:02 +0100
From: Michal Hocko <mhocko@suse.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWoQ1k2AikSiMjys@tiehlicka>
References: <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
 <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231201165113.43211a48@rotkaeppchen>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-0.996];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_085906_405569_05626B14 
X-CRM114-Status: GOOD (  27.33  )
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

On Fri 01-12-23 16:51:13, Philipp Rudo wrote:
> On Fri, 1 Dec 2023 12:55:52 +0100
> Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Fri 01-12-23 12:33:53, Philipp Rudo wrote:
> > [...]
> > > And yes, those are all what-if concerns but unfortunately that is all
> > > we have right now.  
> > 
> > Should theoretical concerns without an actual evidence (e.g. multiple
> > drivers known to be broken) become a roadblock for this otherwise useful
> > feature? 
> 
> Those concerns aren't just theoretical. They are experiences we have
> from a related feature that suffers exactly the same problem regularly
> which wouldn't exist if everybody would simply work "properly".

What is the related feature?
 
> And yes, even purely theoretical concerns can become a roadblock for a
> feature when the cost of those theoretical concerns exceed the benefit
> of the feature. The thing is that bugs will be reported against kexec.
> So _we_ need to figure out which of the shitty drivers caused the
> problem. That puts additional burden on _us_. What we are trying to
> evaluate at the moment is if the benefit outweighs the extra burden
> with the information we have at the moment.

I do understand your concerns! But I am pretty sure you do realize that
it is really hard to argue theoreticals.  Let me restate what I consider
facts. Hopefully we can agree on these points
	- the CMA region can be used by user space memory which is a
	  great advantage because the memory is not wasted and our
	  experience has shown that users do care about this a lot. We
	  _know_ that pressure on making those reservations smaller
	  results in a less reliable crashdump and more resources spent
	  on tuning and testing (especially after major upgrades).  A
	  larger reservation which is not completely wasted for the
	  normal runtime is addressing that concern.
	- There is no other known mechanism to achieve the reusability
	  of the crash kernel memory to stop the wastage without much
	  more intrusive code/api impact (e.g. a separate zone or
	  dedicated interface to prevent any hazardous usage like RDMA).
	- implementation wise the patch has a very small footprint. It
	  is using an existing infrastructure (CMA) and it adds a
	  minimal hooking into crashkernel configuration.
	- The only identified risk so far is RDMA acting on this memory
	  without using proper pinning interface. If it helps to have a
	  statement from RDMA maintainers/developers then we can pull
	  them in for a further discussion of course.
	- The feature requires an explicit opt-in so this doesn't bring
	  any new risk to existing crash kernel users until they decide
	  to use it. AFAIU there is no way to tell that the crash kernel
	  memory used to be CMA based in the primary kernel. If you
	  believe that having that information available for
	  debugability would help then I believe this shouldn't be hard
	  to add.  I think it would even make sense to mark this feature
	  experimental to make it clear to users that this needs some
	  time before it can be marked production ready.

I hope I haven't really missed anything important. The final
cost/benefit judgment is up to you, maintainers, of course but I would
like to remind that we are dealing with a _real_ problem that many
production systems are struggling with and that we don't really have any
other solution available.
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
