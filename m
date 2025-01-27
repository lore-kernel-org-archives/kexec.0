Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F040C0218A
	for <kexec@archiver.kernel.org>; Mon, 27 Jan 2025 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=754tTQ0Xv0FV1pAPiQ7XMzOqvV5Ru3eT2/4MtIxHkKc=; b=lR/TSzzZW+W6DuTXqS96sF/HGp
	mxpgKpDBqf0fDxXXA0rrCSvG6s7wH3ONVBen+z52yy+Fln09mxG3XqckAaagY1Y1jo65UYbEcHth8
	gqGrmFqeMyWlCtNK473l3p/9oFkZY/3QLwNu03jTAHcaQVUOWVOW7dStHDqdNvu/Io+t1d6Dm4lAO
	BW4yRHsQ9TGxBnW58NWvuUHZEQg71M+Q+6JZu7FP+h2FH7NcUTR9frx6yg/DUGXEbTavCHIEHuHCO
	wlIvMcRgpTIGt0EKWMBiXxW7aQ0jhElX5aqeTj4HfOKh71kX0n5l+fMdJb9nKdZD+Yes7UZWlX6ng
	9K/26Gxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRfv-00000002j4c-0tO8;
	Mon, 27 Jan 2025 16:09:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRG9-00000002dIt-1Ylu;
	Mon, 27 Jan 2025 15:42:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=754tTQ0Xv0FV1pAPiQ7XMzOqvV5Ru3eT2/4MtIxHkKc=; b=Pyozw0tsKLD9gp97o+N6ZbHkTo
	Il8/2Vpa4F0aqTQ5eLNtncdojFavxqC+3hOoMyt2pPZYgpxoa7oSXp+1z19h2FwdJ9ksectEr6L5y
	pdndzuM9IJbuYbMGyY8OnttTeia0ZsfUEQN3vE3Kvu3ywzVzVm7PiaoVN1j+XGx7cGtNMyIWcHM2K
	IHU9EJmiTnsw2atKedPjlIYgnndG3plYffG/psV0clxoDlPsLg9vBJ8MCt7RCyZQNR2Rl4uIk2hOI
	SGpvgckCCBw+KC2Pto4K/lzMPYNt+Lyqoqjs99RL8H5P/AQH7nlJDuMDpJ1IZ/IMsyAIp8YsG+ytq
	PlpOQ/eA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRG3-00000009b8r-2Zcd;
	Mon, 27 Jan 2025 15:42:39 +0000
Date: Mon, 27 Jan 2025 15:42:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Joel Granados <joel.granados@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
	Song Liu <song@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Corey Minyard <cminyard@mvista.com>
Subject: Re: Re: Re: [PATCH v2] treewide: const qualify ctl_tables where
 applicable
Message-ID: <Z5epb86xkHQ3BLhp@casper.infradead.org>
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
 <Z4+jwDBrZNRgu85S@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <nslqrapp4v3rknjgtfk4cg64ha7rewrrg24aslo2e5jmxfwce5@t4chrpuk632k>
 <CAMj1kXEZPe8zk7s67SADK9wVH3cfBup-sAZSC6_pJyng9QT7aw@mail.gmail.com>
 <f4lfo2fb7ajogucsvisfd5sg2avykavmkizr6ycsllcrco4mo3@qt2zx4zp57zh>
 <87jzag9ugx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzag9ugx.fsf@intel.com>
X-Mailman-Approved-At: Mon, 27 Jan 2025 08:09:21 -0800
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

On Mon, Jan 27, 2025 at 04:55:58PM +0200, Jani Nikula wrote:
> You could have static const within functions too. You get the rodata
> protection and function local scope, best of both worlds?

timer_active is on the stack, so it can't be static const.

Does this really need to be cc'd to such a wide distribution list?

