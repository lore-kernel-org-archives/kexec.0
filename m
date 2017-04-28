Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d4BeZ-0000iR-SK
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 19:34:09 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3SJXU2q132087
 for <kexec@lists.infradead.org>; Fri, 28 Apr 2017 15:33:45 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a45uch446-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 28 Apr 2017 15:33:45 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 28 Apr 2017 16:33:43 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3SJXdPX16908702
 for <kexec@lists.infradead.org>; Fri, 28 Apr 2017 16:33:39 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3SJXfV9003289
 for <kexec@lists.infradead.org>; Fri, 28 Apr 2017 16:33:41 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec: allocate buffer in top-down, if specified,
 correctly
Date: Fri, 28 Apr 2017 16:33:34 -0300
In-Reply-To: <20170428005135.GA3963@fireball>
References: <20170426082209.12127-1-takahiro.akashi@linaro.org>
 <1605356.Vp6YPvtjly@morokweng> <20170428005135.GA3963@fireball>
MIME-Version: 1.0
Message-Id: <2404647.dtAsaUPUyE@morokweng>
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
Cc: kexec@lists.infradead.org, dyoung@redhat.com, vgoyal@redhat.com, bhe@redhat.com, linux-kernel@vger.kernel.org

Am Freitag, 28. April 2017, 09:51:39 BRT schrieb AKASHI Takahiro:
> On Thu, Apr 27, 2017 at 07:00:04PM -0300, Thiago Jung Bauermann wrote:
> > Hello,
> > 
> > Am Mittwoch, 26. April 2017, 17:22:09 BRT schrieb AKASHI Takahiro:
> > > The current kexec_locate_mem_hole(kbuf.top_down == 1) stops searching at
> > > the first memory region that has enough space for requested size even if
> > > some of higher regions may also have.
> > 
> > kexec_locate_mem_hole expects arch_kexec_walk_mem to walk memory from top
> > to bottom if top_down is true. That is what powerpc's version does.
> 
> Ah, I haven't noticed that, but x86 doesn't have arch_kexec_walk_mem and
> how can it work for x86?

Looking at v4.9's kexec_add_buffer, the logic has been this way before I 
factored kexec_locate_mem_hole out of it. So x86 has been behaving this way 
for a while.

> > Isn't it possible to walk resources from top to bottom?
> 
> Yes, it will be, but it seems to me that such a behavior is not intuitive
> and even confusing if it doesn't come with explicit explanation.

Yes, I should have put a comment pointing out that assumption.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
