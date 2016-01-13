Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aJEFG-00006f-Vs
 for kexec@lists.infradead.org; Wed, 13 Jan 2016 05:45:23 +0000
Date: Wed, 13 Jan 2016 11:14:57 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH RFC V2 1/2] arm64: Add enable/disable d-cache support for
 purgatory
Message-ID: <20160113054457.GC8122@dhcppc1>
References: <cover.1452572612.git.panand@redhat.com>
 <5679d4baaa5e644f8302982c6f468214ed3d3f3d.1452572612.git.panand@redhat.com>
 <5694BAA1.8000607@linaro.org>
 <20160112095342.GJ21206@dhcppc13.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160112095342.GJ21206@dhcppc13.redhat.com>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: geoff@infradead.org, kexec@lists.infradead.org, horms@verge.net.au, james.morse@arm.com, jk@ozlabs.org, scottwood@freescale.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

Hi Akashi,

On 12/01/2016:03:23:42 PM, Pratyush Anand wrote:
> > >+static void init_page_table(void)
> > >+{
> > >+	inval_cache_range((uint64_t)page_table,
> > >+				(uint64_t)page_table + PAGE_TABLE_SIZE);
> > >+	memset(page_table, 0, PAGE_TABLE_SIZE);
> > 
> > why invalidate first?
> 
> Humm..may be you are right. It was copied from arch/arm64/kernel/head.S.
> http://lxr.free-electrons.com/source/arch/arm64/kernel/head.S#L322

I am not yet sure about the cache eviction policy on different arch. So as per
kernel code's comment (Invalidate the idmap and swapper page tables to avoid
potential dirty cache lines being evicted.), I would like to keep it here.  May
be I will add similar comment here as well.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
