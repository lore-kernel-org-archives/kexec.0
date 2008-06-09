Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K5kPM-0001jq-3P
	for kexec@lists.infradead.org; Mon, 09 Jun 2008 16:39:48 +0000
Message-ID: <484D5CCB.5020709@firstfloor.org>
Date: Mon, 09 Jun 2008 18:39:39 +0200
From: Andi Kleen <andi@firstfloor.org>
MIME-Version: 1.0
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
References: <20080608134628.757299158@halley.suse.de>	<20080608134629.743220278@halley.suse.de>	<87bq2bmvro.fsf@saeurebad.de>	<20080609132207.GC3542@redhat.com>
	<20080609182341.00d6e746@halley.suse.de>
In-Reply-To: <20080609182341.00d6e746@halley.suse.de>
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
Cc: kexec@lists.infradead.org, Johannes Weiner <hannes@saeurebad.de>, linux-kernel@vger.kernel.org, anderson@redhat.com, hpa@zytor.com, Amul Shah <amul.shah@unisys.com>, Vivek Goyal <vgoyal@redhat.com>

Bernhard Walle wrote:
> * Vivek Goyal [2008-06-09 09:22]:
>> Kdump first kernel always tries to reserve just physical RAM and nothing
>> else. So I am not sure what does above code do. Try to reserve a memory
>> which is not RAM but is in the region less than highest mapped entity and
>> in that case return silently without any warning. In what case do we
>> exercise this path?
> 
> I don't know. That code has been introduced in 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=5e58a02a8f6a7a1c9ae41f39286bcd3aea0d6f24
> 
> Ccing Andi.
> 
> IMO we should not print any warning in that function, leaving the error
> handling to the caller.

Don't remember the details. Perhaps Amul does (cc'ed)

-Andi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
