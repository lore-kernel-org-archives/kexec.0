Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2878C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 10:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mRf4CyE2fhIJOxZeHnTuwI0L62rLoBqYSOirS5s5gbw=; b=xV7kBAjY6cZHTe
	LJ2YWx4fOXkiX0aoJY8XhYBJs6Dr37VOZo7SDQUVysGW+gnWbX1SN19Iopwoy74RfLIw4TF4aS+/m
	zIGo3kyCl7djQFQeH/77t1g9QMbFxpUkuWv0xY6aQcIFe/3+vblP4VyQSZEA37Y4u4CcF6EJPbYcy
	h2h/AXTuL+owG5DD3ZKiEcUQVDJO+pN6TaU8pLZ2VZun+sfV6TQXe+2pcFvMKM+hDua0ewMOLztu/
	Y1EQuolL5G7zQV2kpdbWEG7oKcv+T3C7HgjdFHx9Nbfq7yadKBfES0TqfyzFN2dENZcwpbc2kRBtI
	vKN//R6Fe1IRNAZprzXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7v8G-004q2G-29;
	Tue, 28 Nov 2023 10:15:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7u54-004fYV-2d
	for kexec@bombadil.infradead.org;
	Tue, 28 Nov 2023 09:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YdytCUyn5cNRRJv2hEdz/XdNxU+cT/USl/FZSZ/v+/w=; b=F/A9IaQXHje4jnB62hj4sSQnyV
	Nlh0fIHvZVZfa/PQUIWvJyamDsiIYZrBmxhwHouIjK0g8Yw86Eg+MkzvhipEtL6AQJoyPUsavVHXM
	EY0YCq4w2XStIh3KXB4ohPQm7s6XzZ1pC2gazbag2j6Ez55i3uj4v2xwYbHFv+SDOj7GGNqivXfF0
	ZydMcwKfBcgbGYgE3Cs4kXrXcxiSMrEDkAyPnu3ORY029a4v1sqmAd+3P6dSd55cpqyhgls/Jskzh
	Ai1jO9nyx0sUOkkkz1bY6aNuF08DocNPhYLxQxnwKUSx+wWu8adZSac9epZiUqxb/x0s86aAwAI+U
	um9kk3oA==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7u51-00GYvB-0B
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 09:08:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E86591F6E6;
	Tue, 28 Nov 2023 09:08:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D011B13763;
	Tue, 28 Nov 2023 09:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Uq5MAmuZWXmVgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 09:08:25 +0000
Date: Tue, 28 Nov 2023 10:08:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baoquan He <bhe@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWWuBSiZZdF2W12j@tiehlicka>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: E86591F6E6
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_090831_259746_15EE66B0 
X-CRM114-Status: GOOD (  19.90  )
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

On Tue 28-11-23 10:11:31, Baoquan He wrote:
> On 11/28/23 at 09:12am, Tao Liu wrote:
[...]
> Thanks for the effort to bring this up, Jiri.
> 
> I am wondering how you will use this crashkernel=,cma parameter. I mean
> the scenario of crashkernel=,cma. Asking this because I don't know how
> SUSE deploy kdump in SUSE distros. In SUSE distros, kdump kernel's
> driver will be filter out? If latter case, It's possibly having the
> on-flight DMA issue, e.g NIC has DMA buffer in the CMA area, but not
> reset during kdump bootup because the NIC driver is not loaded in to
> initialize. Not sure if this is 100%, possible in theory?

NIC drivers do not allocation from movable zones (that includes CMA
zone). In fact kernel doesn't use GFP_MOVABLE for non-user requests.
RDMA drivers might and do transfer from user backed memory but for that
purpose they should be pinning memory (have a look at
__gup_longterm_locked and its callers) and that will migrate away from
the any zone.
 
[...]
> The crashkernel=,cma requires no userspace data dumping, from our
> support engineers' feedback, customer never express they don't need to
> dump user space data. Assume a server with huge databse deployed, and
> the database often collapsed recently and database provider claimed that
> it's not database's fault, OS need prove their innocence. What will you
> do?

Don't use CMA backed crash memory then? This is an optional feature.
 
> So this looks like a nice to have to me. At least in fedora/rhel's
> usage, we may only back port this patch, and add one sentence in our
> user guide saying "there's a crashkernel=,cma added, can be used with
> crashkernel= to save memory. Please feel free to try if you like".
> Unless SUSE or other distros decides to use it as default config or
> something like that. Please correct me if I missed anything or took
> anything wrong.

Jiri will know better than me but for us a proper crash memory
configuration has become a real nut. You do not want to reserve too much
because it is effectively cutting of the usable memory and we regularly
hit into "not enough memory" if we tried to be savvy. The more tight you
try to configure the easier to fail that is. Even worse any in kernel
memory consumer can increase its memory demand and get the overall
consumption off the cliff. So this is not an easy to maintain solution.
CMA backed crash memory can be much more generous while still usable.
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
