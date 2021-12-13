Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwlvs-009ta8-Ax
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 14:04:01 +0000
Date: Mon, 13 Dec 2021 22:03:48 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211213140348.GA26562@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207031631.GA5604@MiWiFi-R3L-srv> <YbdJ00wRFvi0aqze@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbdJ00wRFvi0aqze@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, rppt@linux.ibm.com

On 12/13/21 at 02:25pm, Borislav Petkov wrote:
> On Tue, Dec 07, 2021 at 11:16:31AM +0800, Baoquan He wrote:
> > > This low 1M lock down is needed because AMD SME encrypts memory making
> > > the old backup region mechanims impossible when switching into kdump
> > > kernel. And Intel engineer mentioned their TDX (Trusted domain extensions)
> > > which is under development in kernel also needs lock down the low 1M.
> > > So we can't simply revert above commits to fix the page allocation
> > > failure from DMA zone as someone suggested.
> 
> Did you read
> 
>   f1d4d47c5851 ("x86/setup: Always reserve the first 1M of RAM")
> 
> carefully for a more generically important reason as to why the first 1M
> should not be used?

Apparently I didn't. I slacked off and just grabbed things stored in my
brain. This is the right justification and missed. Thanks for pointing
it out.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
