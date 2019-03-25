Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8OeM-00039j-4p
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 12:24:40 +0000
Date: Mon, 25 Mar 2019 13:24:26 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/3 v9] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
Message-ID: <20190325122426.GK12016@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-3-lijiang@redhat.com>
 <20190322192800.GM12472@zn.tnic>
 <47bfcbe2-1631-9733-74c2-fb3e56540052@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47bfcbe2-1631-9733-74c2-fb3e56540052@redhat.com>
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
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Mon, Mar 25, 2019 at 02:53:02PM +0800, lijiang wrote:
> In this function, i printed its values, and only got the value of reserved
> type, so i changed the IORES_DESC_NONE to the IORES_DESC_RESERVED.
> 
> In addition, after the new descriptor 'IORES_DESC_RESERVED' is introduced,
> the IORES_DESC_NONE does not include the IORES_DESC_RESERVED any more, it
> could miss to handle the value of the reserved type.

Yes, IORES_DESC_RESERVED is supposed to denote the e820 reserved type.
Why should IORES_DESC_NONE include it ?!?!

IORES_DESC_NONE is, well, an invalid, i.e., "none" type:

/*
 * I/O Resource Descriptors
 *
 * Descriptors are used by walk_iomem_res_desc() and region_intersects()
 * for searching a specific resource range in the iomem table.  Assign
 * a new descriptor when a resource range supports the search interfaces.
 * Otherwise, resource.desc must be set to IORES_DESC_NONE (0).
 */

> Do you mean i should never touch the three chunks? If i made a mistake, i
> will remove this changes next post.

I'm looking at the hunks below and you're changing ->desc assignments in
some random function which doesn't look like you know what you're doing.
Maybe it gets you what you want but it sure as hell doesn't look right
to me.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
