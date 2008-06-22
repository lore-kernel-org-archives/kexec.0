Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KAVWH-00059z-NJ
	for kexec@lists.infradead.org; Sun, 22 Jun 2008 19:46:37 +0000
Date: Sun, 22 Jun 2008 21:46:32 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 3/3] Limit E820 map when a user-defined memory map is
	specified
Message-ID: <20080622214632.4a140069@kopernikus.site>
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
> On Fri, Jun 20, 2008 at 8:57 AM, Bernhard Walle <bwalle@suse.de> wrote:
> > This patch brings back limiting of the E820 map when a user-defined
> > E820 map is specified. While the behaviour of i386 (32 bit) was to limit
> > the E820 map (and /proc/iomem), the behaviour of x86-64 (64 bit) was not to
> > limit.
> 
> then if you kexec new kernel, the second kernel will be have that
> limitation too.
> 
> any problem that you encountered without this patch?

No, because the new kexec tool uses the /proc/firmware_mem or whatever
it is called.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
