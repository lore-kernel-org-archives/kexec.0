Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3rSp-0003zb-TO
 for kexec@lists.infradead.org; Thu, 27 Apr 2017 22:00:42 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3RLx89A144943
 for <kexec@lists.infradead.org>; Thu, 27 Apr 2017 18:00:19 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a3j0kk62m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 27 Apr 2017 18:00:17 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 27 Apr 2017 19:00:15 -0300
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3RM0ChS66388142
 for <kexec@lists.infradead.org>; Thu, 27 Apr 2017 19:00:12 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3RM0DmE008430
 for <kexec@lists.infradead.org>; Thu, 27 Apr 2017 19:00:13 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec: allocate buffer in top-down, if specified,
 correctly
Date: Thu, 27 Apr 2017 19:00:04 -0300
In-Reply-To: <20170426082209.12127-1-takahiro.akashi@linaro.org>
References: <20170426082209.12127-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Message-Id: <1605356.Vp6YPvtjly@morokweng>
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

Hello,

Am Mittwoch, 26. April 2017, 17:22:09 BRT schrieb AKASHI Takahiro:
> The current kexec_locate_mem_hole(kbuf.top_down == 1) stops searching at
> the first memory region that has enough space for requested size even if
> some of higher regions may also have.

kexec_locate_mem_hole expects arch_kexec_walk_mem to walk memory from top to 
bottom if top_down is true. That is what powerpc's version does.

Isn't it possible to walk resources from top to bottom?

> This behavior is not consistent with locate_hole(hole_end == -1) function
> of kexec-tools.
> 
> This patch fixes the bug, going though all the memory regions anyway.

This patch would break powerpc, because at the end of the memory walk kbuf 
would have the lowest memory hole.

If it's not possible to walk resources in reverse order, then this patch needs 
to change powerpc to always walk memory from bottom to top.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
