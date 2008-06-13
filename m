Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.246])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6yJp-00011Z-SS
	for kexec@lists.infradead.org; Fri, 13 Jun 2008 01:43:10 +0000
Received: by rv-out-0708.google.com with SMTP id b17so5196132rvf.42
	for <kexec@lists.infradead.org>; Thu, 12 Jun 2008 18:43:09 -0700 (PDT)
Message-ID: <86802c440806121843k221aaed9wc49b3a6a1ea966af@mail.gmail.com>
Date: Thu, 12 Jun 2008 18:43:09 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] Limit E820 map and /proc/iomem for mem parameter on x86-64
In-Reply-To: <20080610215325.GA20673@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <20080610215325.GA20673@suse.de>
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
To: kexec@lists.infradead.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org

On Tue, Jun 10, 2008 at 2:53 PM, Bernhard Walle <bwalle@suse.de> wrote:
> This patch tries to unify the behaviour of i386 and x86-64 when parsing
> the memory (mem/memmap) parameter of the kernel command line:
>
> On i386, the view was limited (i.e. the actual view was presented).
> On x86-64, the view was full (i.e. the BIOS view was presented).
>
> This patch moves the limit_regions() function and the print_memory_map()
> function to a new file e820.c, shared between the two x86 flavours. Then
> it adds calls to limit_regions() in 64 bit code.
>
> I gave the patch a bit testing. However, it's not for merging, it's just
> to get early feedback to see if that goes into the right direction.

can you check tip/master about that e820 merge?

http://people.redhat.com/mingo/tip.git/readme.txt

it made 32bit using e820_register_active_region...and limit_region in
32bit is remove.

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
