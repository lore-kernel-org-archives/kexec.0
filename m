Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDkh-0007S0-Ln
 for kexec@lists.infradead.org; Tue, 18 Dec 2018 11:41:33 +0000
Date: Tue, 18 Dec 2018 12:41:18 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
Message-ID: <20181218114118.GE7485@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com>
 <20181217130024.GD12165@zn.tnic>
 <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: lijiang <lijiang@redhat.com>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Tue, Dec 18, 2018 at 03:31:32PM +0800, lijiang wrote:
> The printk_log is used to output human readable text, it will encapsulate header
> information for log_buf, such as timestamp, syslog level, etc.

Me asking those questions is supposed to hint that the explanations need
improvement. But you get the idea...

> >> +PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|
> >> +PG_hwpoision|PG_head_mask
> >> +=====================================================
> >> +It means the attribute of a page. These flags will be used to filter
> >> +the free pages.
> >> +
> >> +PAGE_BUDDY_MAPCOUNT_VALUE or ~PG_buddy
> >> +======================================
> >> +The 'PG_buddy' flag indicates that the page is free and in the buddy
> >> +system. Makedumpfile can exclude the free pages managed by a buddy.
> > 
> > That text belongs with the one above?
> > 
> It exported the value of (~PG_buddy), so it is placed here independently.

Then make that obvious in the description. The one above talks about the
PG flags and this one should talk about PAGE_BUDDY_MAPCOUNT_VALUE and
what it is used for. The fact that it is computed by negating PG_buddy
is an implementation detail.

> These two variables are somewhat similar, but they are used in
> different scenarios.

Those different scenarious need to be part of the description.

> >> +KERNEL_IMAGE_SIZE
> >> +=================
> >> +The size of 'KERNEL_IMAGE_SIZE', currently unused.
> > 
> > So remove?
> > 
> 
> I'm not sure whether it should be removed, so i keep it.

If it is unused, it should be removed as an VMCOREINFO export and from
the docs. But that can be done later, as a separate patch.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
