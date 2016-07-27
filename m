Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bSXaB-0001u1-LK
 for kexec@lists.infradead.org; Wed, 27 Jul 2016 22:45:44 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6RMiBHE085917
 for <kexec@lists.infradead.org>; Wed, 27 Jul 2016 18:45:22 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24eauhqgjt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 27 Jul 2016 18:45:22 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 27 Jul 2016 19:45:20 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of memory
 ranges in device tree
Date: Wed, 27 Jul 2016 19:45:13 -0300
In-Reply-To: <c4af21ba365767f88a2516719dd0f3b70777b549.1468970114.git.geoff@infradead.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <c4af21ba365767f88a2516719dd0f3b70777b549.1468970114.git.geoff@infradead.org>
MIME-Version: 1.0
Message-Id: <3562841.ROYbCgkeeq@hactar>
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
To: kexec@lists.infradead.org
Cc: Geoff Levand <geoff@infradead.org>, Pratyush Anand <panand@redhat.com>, Simon Horman <horms@verge.net.au>, linux-arm-kernel@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

Hello,

Am Dienstag, 19 Juli 2016, 23:28:13 schrieb Geoff Levand:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> The end address of "reg" attribute in device tree's memory should be
> inclusive.

Actually, there's a bug/inconsistency in kexec-tools right now.

crashdump-arm.c expect usablemem_rgns.ranges[i].end to be the last byte in 
the range, but crashdump-powerpc.c, crashdump-ppc64.c and fs2dt.c expect it 
to be the first byte after the range.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
