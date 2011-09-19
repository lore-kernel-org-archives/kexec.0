Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R5f2n-00069z-5H
	for kexec@lists.infradead.org; Mon, 19 Sep 2011 14:42:02 +0000
Date: Mon, 19 Sep 2011 15:41:37 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: kdump: copy kernel relocation code at the kexec
	prepare stage
Message-ID: <20110919144136.GT16381@n2100.arm.linux.org.uk>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
	<20110919122059.GQ16381@n2100.arm.linux.org.uk>
	<53612FE6B944314AAADB181E45A45B641387938501@sc-vexch3.marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53612FE6B944314AAADB181E45A45B641387938501@sc-vexch3.marvell.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Lei Wen <leiwen@marvell.com>
Cc: Yu Tang <ytang5@marvell.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chao Xie <cxie4@marvell.com>

On Mon, Sep 19, 2011 at 07:11:59AM -0700, Lei Wen wrote:
> Thanks for this reminding!
> Then how about add flush_icache_range at the end of machine_kexec_prepare?
> Could it be acceptable?

I think it should be done.

> Also with this change, do we still need flush icache at the end stage of
> machine_kexec?

You need to use flush_icache_range() whenever you write _instructions_
to an area of memory which you intend to execute.  If you're not writing
instructions, you shouldn't use flush_icache_range().

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
