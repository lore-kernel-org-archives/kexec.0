Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KAVfz-0005y5-7t
	for kexec@lists.infradead.org; Sun, 22 Jun 2008 19:56:39 +0000
Date: Sun, 22 Jun 2008 21:56:35 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 3/3] Limit E820 map when a user-defined memory map is
	specified
Message-ID: <20080622215635.7a0ebaae@kopernikus.site>
In-Reply-To: <86802c440806201334s30cbc685se44326812841fdd2@mail.gmail.com>
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
	<1213977420-1555-4-git-send-email-bwalle@suse.de>
	<86802c440806201334s30cbc685se44326812841fdd2@mail.gmail.com>
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
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

* "Yinghai Lu" <yhlu.kernel@gmail.com> [2008-06-20 13:34]:
> 
> any problem that you encountered without this patch?

Sorry, forgot to answer that question.

Yes, if you use mem=3G and take a dump, kexec builds the ELF core
headers for the full memory size, which means that the dump is as large
as the physical memory of the machine is, which doesn't make sense.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
