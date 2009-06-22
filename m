Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MIjqV-0002cY-ST
	for kexec@lists.infradead.org; Mon, 22 Jun 2009 13:46:18 +0000
Date: Mon, 22 Jun 2009 08:45:57 -0500
From: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 1/7] ia64, kdump: Mask MCA/INIT on freezing cpus
Message-ID: <20090622134557.GC7084@sgi.com>
References: <4A39E247.4030908@jp.fujitsu.com> <4A39E2CF.80901@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A39E2CF.80901@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

> To avoid this problem, This patch inserts ia64_set_psr_mc() before the
> deadloop to mask MCA/INIT on cpus going to be frozen.  I confirmed that
> weird log like above are disappeared after applying this patch.

Please do not do this.  Turning off MCA/INIT is just a horrible idea.
When your code has a bug, the INIT of the cpu is the only tool we have
to find out what it is doing short of putting special hardware onto the
machine and trying to track it down.

Without thinking about it, I have a gut feeling there must be some way
to at least allow the MCA/INIT to make it through PROM and be delivered
to the OS.  From there the OS should be able to sort out a way to handle
kdump and MCAs received during a kdump.

Thanks,
Robin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
