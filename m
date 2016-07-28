Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bSv99-00087Z-PI
 for kexec@lists.infradead.org; Thu, 28 Jul 2016 23:55:24 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6SNrj3p004596
 for <kexec@lists.infradead.org>; Thu, 28 Jul 2016 19:55:03 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24fjnwy7sx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 28 Jul 2016 19:55:02 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 28 Jul 2016 20:55:00 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of memory
 ranges in device tree
Date: Thu, 28 Jul 2016 20:54:55 -0300
In-Reply-To: <20160727232331.GY1041@n2100.armlinux.org.uk>
References: <cover.1468970114.git.geoff@infradead.org>
 <3562841.ROYbCgkeeq@hactar> <20160727232331.GY1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Message-Id: <1860371.lT9GInp2C3@hactar>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Pratyush Anand <panand@redhat.com>, Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, linux-arm-kernel@lists.infradead.org

Am Donnerstag, 28 Juli 2016, 00:23:31 schrieb Russell King - ARM Linux:
> On Wed, Jul 27, 2016 at 07:45:13PM -0300, Thiago Jung Bauermann wrote:
> > Hello,
> > 
> > Am Dienstag, 19 Juli 2016, 23:28:13 schrieb Geoff Levand:
> > > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > 
> > > The end address of "reg" attribute in device tree's memory should be
> > > inclusive.
> > 
> > Actually, there's a bug/inconsistency in kexec-tools right now.
> > 
> > crashdump-arm.c expect usablemem_rgns.ranges[i].end to be the last byte
> > in the range, but crashdump-powerpc.c, crashdump-ppc64.c and fs2dt.c
> > expect it to be the first byte after the range.
> 
> Well, ARM (and the generic code I introduced for mem_ranges) follows
> what i386, ia64, mips, s390, and sh all do with struct memory_range
> when used for crashdump.
> 
> It is extremely bad for a project to have a single structure used
> inconsistently like this - even with generic helpers, you can't be
> sure that the right helpers are used on the right structures, and
> it will lead to off-by-one errors all over the place.  Just don't
> pull crap like this, it's asking for trouble - settle on one way
> and stick to it.

Agreed. Personally, I prefer base address and size because it's unambiguous. 
But as long as just one convention is used and the structure and helpers 
make it clear which one they expect, it doesn't matter that much.

> Given that the majority of architectures treat .end as inclusive, I
> think ppc* and fs2dt need to conform to the convention establised by
> the other architectures for this structure.

So do valid_memory_range and find_memory_range in kexec/kexec.c, which 
assume struct memory_range is end-exclusive too. I'm not sure about 
locate_hole, it seems to assume end-inclusive but it does have a line saying 
"size = end - start".

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
