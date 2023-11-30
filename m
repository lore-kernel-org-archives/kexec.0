Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7076C47DA7
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xNlsRXR07Ey1T5e9mTJz41Zc67+AOuP9OHjWWhNLPU4=; b=A7zGPcZONzd2tA
	8LCa7JsyCu3Kv6gXuTbbQUZ2r/6wV+NCsgW6vxqecsYfiWxzthsb83uUrQooLrfnqV7OEfw8uiB1T
	j6meOWQhgs3VH1jn9bW272Rb0cIXqbwZhpidMpdZU2+pNUa5JaoytosnjQdqyd2r5fk3vEo/hcRlr
	EN9lck6Ri32JQOFaDTmjzZYHiH6CobUfy2gc5s4x0TOk8v1gB3o34RNWdtfJSQy3W8GfxJJde47e9
	8Gcf8T1TiYpmvsoYGZhxj64efR/RP0dQqnJBmfvYwIhGuIECq/GBTZABhRL7UPcZtprjiG0tclADC
	YtXO6+jBKdj2KhIsCqyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJvn-003E5J-02;
	Fri, 12 Jan 2024 15:58:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8h6n-00Axrh-0s
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 13:29:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A09AD1FCE9;
	Thu, 30 Nov 2023 13:29:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7360F13AB1;
	Thu, 30 Nov 2023 13:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Aq3+FzyOaGWUQAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 30 Nov 2023 13:29:32 +0000
Date: Thu, 30 Nov 2023 14:29:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baoquan He <bhe@redhat.com>
Cc: Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWiOO-KNJ82f6Gxu@tiehlicka>
References: <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out2.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.997];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: A09AD1FCE9
X-Spam: Yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_052937_488571_F1BAEC2B 
X-CRM114-Status: GOOD (  31.50  )
X-Mailman-Approved-At: Fri, 12 Jan 2024 07:58:47 -0800
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

On Thu 30-11-23 20:04:59, Baoquan He wrote:
> On 11/30/23 at 11:16am, Michal Hocko wrote:
> > On Thu 30-11-23 11:00:48, Baoquan He wrote:
> > [...]
> > > Now, we are worried if there's risk if the CMA area is retaken into kdump
> > > kernel as system RAM. E.g is it possible that 1st kernel's ongoing RDMA
> > > or DMA will interfere with kdump kernel's normal memory accessing?
> > > Because kdump kernel usually only reset and initialize the needed
> > > device, e.g dump target. Those unneeded devices will be unshutdown and
> > > let go. 
> > 
> > I do not really want to discount your concerns but I am bit confused why
> > this matters so much. First of all, if there is a buggy RDMA driver
> > which doesn't use the proper pinning API (which would migrate away from
> > the CMA) then what is the worst case? We will get crash kernel corrupted
> > potentially and fail to take a proper kernel crash, right? Is this
> > worrisome? Yes. Is it a real roadblock? I do not think so. The problem
> > seems theoretical to me and it is not CMA usage at fault here IMHO. It
> > is the said theoretical driver that needs fixing anyway.
> > 
> > Now, it is really fair to mention that CMA backed crash kernel memory
> > has some limitations
> > 	- CMA reservation can only be used by the userspace in the
> > 	  primary kernel. If the size is overshot this might have
> > 	  negative impact on kernel allocations
> > 	- userspace memory dumping in the crash kernel is fundamentally
> > 	  incomplete.
> 
> I am not sure if we are talking about the same thing. My concern is:
> ====================================================================
> 1) system corrutption happened, crash dumping is prepared, cpu and
> interrupt controllers are shutdown;
> 2) all pci devices are kept alive;
> 3) kdump kernel boot up, initialization is only done on those devices
> which drivers are added into kdump kernel's initrd;
> 4) those on-flight DMA engine could be still working if their kernel
> module is not loaded;
> 
> In this case, if the DMA's destination is located in crashkernel=,cma
> region, the DMA writting could continue even when kdump kernel has put
> important kernel data into the area. Is this possible or absolutely not
> possible with DMA, RDMA, or any other stuff which could keep accessing
> that area?

I do nuderstand your concern. But as already stated if anybody uses
movable memory (CMA including) as a target of {R}DMA then that memory
should be properly pinned. That would mean that the memory will be
migrated to somewhere outside of movable (CMA) memory before the
transfer is configured. So modulo bugs this shouldn't really happen.
Are there {R}DMA drivers that do not pin memory correctly? Possibly. Is
that a road bloack to not using CMA to back crash kernel memory, I do
not think so. Those drivers should be fixed instead.

> The existing crashkernel= syntax can gurantee the reserved crashkernel
> area for kdump kernel is safe.

I do not think this is true. If a DMA is misconfigured it can still
target crash kernel memory even if it is not mapped AFAICS. But those
are theoreticals. Or am I missing something?
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
