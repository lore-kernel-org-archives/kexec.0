Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCIly-0000Dw-Ey
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 18:34:14 +0000
Date: Fri, 27 Jun 2008 20:34:09 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: x86: Add /sys/firmware/memmap
Message-ID: <20080627203409.3bc891e3@kopernikus.site>
In-Reply-To: <20080627181833.GA7735@suse.de>
References: <1214565175-21512-1-git-send-email-bwalle@suse.de>
	<20080627181833.GA7735@suse.de>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: Greg KH <gregkh@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, yhlu.kernel@gmail.com, vgoyal@redhat.com, linux-kernel@vger.kernel.org

* Greg KH <gregkh@suse.de> [2008-06-27 11:18]:
> 
> Looks good, want me to take this through my tree (due to the firmware
> core change)?  If so, can you get an ack on the x86 portion from the
> respective people as well?

Well, the x86 part only applies on tip (because your tree doesn't have
the e820_{32,64} -> e820 merge). So, wouldn't it easier to ack that
patch from your side and merge via tip?



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
