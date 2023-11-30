Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AFCC47258
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fxAVsgmbgvjiuywxWdlvs4TH71//3scA98yyNX57kYU=; b=wsiY3jDRfd6cP9
	/ABlwXYN7ASfL3TY+mUHcFKck551dtsAHSjXsJucIR8sajEAmkTSrpgaBqxHjn7HX7hzJSGKzxI/i
	0LQVc6k+l8bW1SFuPD++hvxkCT0zaNTCxVaE0op83b9JOz3tQzKZqF12wsF7/qy5Gg3f/Ec6f68zm
	kRncEIWUPvnHomvmlhCjibD23g3J6cs+ZqZUk/hv1uQfzdN7jZU/KLb66kg2jr+6C/Kjt8rq9vX8v
	JTzXgAFEbWX6yO2XMwcncXyZHwOm12LNABzCqyV2Anu3NrsBWhLQGgzt9XuOrJ+TmDS6qgOzFZkOQ
	oeq6Rvg66ZJZPu21pUzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJvm-003E5A-1s;
	Fri, 12 Jan 2024 15:58:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8e60-00AQ2O-1v
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 10:16:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5771F1FCEA;
	Thu, 30 Nov 2023 10:16:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A81913AB1;
	Thu, 30 Nov 2023 10:16:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id InggBv5gaGXEDAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 30 Nov 2023 10:16:30 +0000
Date: Thu, 30 Nov 2023 11:16:29 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baoquan He <bhe@redhat.com>
Cc: Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWhg_b3O6piZtkQ-@tiehlicka>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.74%]
X-Rspamd-Queue-Id: 5771F1FCEA
X-Spam: Yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_021636_807629_07A5019B 
X-CRM114-Status: GOOD (  14.08  )
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

On Thu 30-11-23 11:00:48, Baoquan He wrote:
[...]
> Now, we are worried if there's risk if the CMA area is retaken into kdump
> kernel as system RAM. E.g is it possible that 1st kernel's ongoing RDMA
> or DMA will interfere with kdump kernel's normal memory accessing?
> Because kdump kernel usually only reset and initialize the needed
> device, e.g dump target. Those unneeded devices will be unshutdown and
> let go. 

I do not really want to discount your concerns but I am bit confused why
this matters so much. First of all, if there is a buggy RDMA driver
which doesn't use the proper pinning API (which would migrate away from
the CMA) then what is the worst case? We will get crash kernel corrupted
potentially and fail to take a proper kernel crash, right? Is this
worrisome? Yes. Is it a real roadblock? I do not think so. The problem
seems theoretical to me and it is not CMA usage at fault here IMHO. It
is the said theoretical driver that needs fixing anyway.

Now, it is really fair to mention that CMA backed crash kernel memory
has some limitations
	- CMA reservation can only be used by the userspace in the
	  primary kernel. If the size is overshot this might have
	  negative impact on kernel allocations
	- userspace memory dumping in the crash kernel is fundamentally
	  incomplete.

Just my 2c
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
