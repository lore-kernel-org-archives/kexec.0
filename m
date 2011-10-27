Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJPLc-00039Z-GF
	for kexec@lists.infradead.org; Thu, 27 Oct 2011 12:46:17 +0000
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <kexec@lists.infradead.org> from <haveblue@us.ibm.com>;
	Thu, 27 Oct 2011 06:45:51 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p9RCjfuM135456
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 06:45:41 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p9RCjf3G003359
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 06:45:41 -0600
Subject: Re: kdump: No udev events for memory hotplug?
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20111027073058.GA2422@osiris.boeblingen.de.ibm.com>
References: <1319645292.3321.24.camel@br98xy6r>
	<20111026192449.GE355@redhat.com>
	<20111027073058.GA2422@osiris.boeblingen.de.ibm.com>
Date: Thu, 27 Oct 2011 05:45:33 -0700
Message-ID: <1319719533.23600.55.camel@nimitz>
Mime-Version: 1.0
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
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2011-10-27 at 09:30 +0200, Heiko Carstens wrote:
> > Are any events generated for memory add?
> 
> Looks like uevents are only genereted when memory gets registered and
> unregistered, but not when when it gets set online or offline.
> To achieve that you would need to add similar code to
> store_mem_state()/memory_block_change_state() in drivers/base/memory.c
> like we have it already in store_online() in drivers/base/cpu.c 

Instead of doing it at that low a level, perhaps we should be generating
events when 'totalram_pages' changes.  That way, we'll also trigger
events when things like ballooning happen.

-- Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
