Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCJ2N-0000K3-H0
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 18:51:11 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5RIp9fL005219
	for <kexec@lists.infradead.org>; Fri, 27 Jun 2008 14:51:09 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5RIp6qA148890
	for <kexec@lists.infradead.org>; Fri, 27 Jun 2008 12:51:07 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5RIp6hu015613
	for <kexec@lists.infradead.org>; Fri, 27 Jun 2008 12:51:06 -0600
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
From: Dave Hansen <dave@linux.vnet.ibm.com>
In-Reply-To: <1214565175-21512-2-git-send-email-bwalle@suse.de>
References: <1214565175-21512-1-git-send-email-bwalle@suse.de>
	<1214565175-21512-2-git-send-email-bwalle@suse.de>
Date: Fri, 27 Jun 2008 11:51:04 -0700
Message-Id: <1214592664.12598.30.camel@nimitz>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: gregkh@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com, vgoyal@redhat.com

On Fri, 2008-06-27 at 13:12 +0200, Bernhard Walle wrote:
> 
> This patch adds /sys/firmware/memmap interface that represents the
> BIOS
> (or Firmware) provided memory map. The tree looks like:
> 
>     /sys/firmware/memmap/0/start   (hex number)
>                            end     (hex number)
>                            type    (string)
>     ...                 /1/start
>                            end
>                            type

Could we give this a slightly different name?  We have various 'mem_map'
variables in the kernel, and this confused me on first glance. 

Could we just spell out 'memory_map'?

-- Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
