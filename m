Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0651C47DA9
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wV6aQtj/n9dHKwM4xCNhLSnXv0OW6H9HmqjBLb8myw8=; b=0c+IX4jYruDj9K
	mxOACR2M3VrfHZSxX2A3R6vmL8IpjrfKiRpuXDGjow/bJyJEKginVoq+CqUrn5Qjb7JG7LT/63H4d
	xlfb0CQmQZxllFxAlrEcr8f3meEBzSmaoRdAb3dF66WKpyvRWHxQBo5s5TJaENj4MHyklwO8G2Ddz
	iUjJ/yLEgw8j+iLIT34GsP7VcmfUttdu9TEi+cpkA/7bakUJkzQ3ufCp6+0/izDqhgymyeuqrmcDK
	AqD4NNL7Edka8M3SgM3L+VVxZKx187Nt668CPVrHda9AuDlTwXx4+v2woy+EqiXJ9r1YNCin1tk5/
	qOt4rPNO8lBOexUXLkLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJvp-003E61-2r;
	Fri, 12 Jan 2024 15:58:53 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAtgt-00AcKD-2I
	for kexec@lists.infradead.org;
	Wed, 06 Dec 2023 15:20:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14FB521E97;
	Wed,  6 Dec 2023 15:19:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED5A2136CD;
	Wed,  6 Dec 2023 15:19:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wubtNhuRcGUjSgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 06 Dec 2023 15:19:55 +0000
Date: Wed, 6 Dec 2023 16:19:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXCRF-bvm8ijXxr4@tiehlicka>
References: <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
 <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXB7_rbC0GAkIp7p@tiehlicka>
X-Rspamd-Queue-Id: 14FB521E97
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[39.47%]
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out1.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com
X-Rspamd-Server: rspamd1
X-Spam: Yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_071959_918428_5FFB8988 
X-CRM114-Status: GOOD (  16.32  )
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

On Wed 06-12-23 14:49:51, Michal Hocko wrote:
> On Wed 06-12-23 12:08:05, Philipp Rudo wrote:
[...]
> > If I understand Documentation/core-api/pin_user_pages.rst correctly you
> > missed case 1 Direct IO. In that case "short term" DMA is allowed for
> > pages without FOLL_LONGTERM. Meaning that there is a way you can
> > corrupt the CMA and with that the crash kernel after the production
> > kernel has panicked.
> 
> Could you expand on this? How exactly direct IO request survives across
> into the kdump kernel? I do understand the RMDA case because the IO is
> async and out of control of the receiving end.

OK, I guess I get what you mean. You are worried that there is 
DIO request
program DMA controller to read into CMA memory
<panic>
boot into crash kernel backed by CMA
DMA transfer is done.

DIO doesn't migrate the pinned memory because it is considered a very
quick operation which doesn't block the movability for too long. That is
why I have considered that a non-problem. RDMA on the other might pin
memory for transfer for much longer but that case is handled by
migrating the memory away.

Now I agree that there is a chance of the corruption from DIO. The
question I am not entirely clear about right now is how big of a real
problem that is. DMA transfers should be a very swift operation. Would
it help to wait for a grace period before jumping into the kdump kernel?

> Also if direct IO is a problem how come this is not a problem for kexec
> in general. The new kernel usually shares all the memory with the 1st
> kernel.

This is also more clear now. Pure kexec is shutting down all the devices
which should terminate the in-flight DMA transfers.

-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
