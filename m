Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZJDQ-00068H-16
 for kexec@lists.infradead.org; Mon, 15 Aug 2016 14:50:12 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7FEn3Zq057661
 for <kexec@lists.infradead.org>; Mon, 15 Aug 2016 10:49:51 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24symnxka3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 15 Aug 2016 10:49:50 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 15 Aug 2016 11:49:47 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E93491DC0054
 for <kexec@lists.infradead.org>; Mon, 15 Aug 2016 10:49:35 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7FEniFV65798166
 for <kexec@lists.infradead.org>; Mon, 15 Aug 2016 11:49:44 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7FEnhkn014078
 for <kexec@lists.infradead.org>; Mon, 15 Aug 2016 11:49:44 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take
 kexec_buf as argument.
Date: Mon, 15 Aug 2016 11:49:42 -0300
In-Reply-To: <20160815073049.GB21080@balbir.ozlabs.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160815073049.GB21080@balbir.ozlabs.ibm.com>
MIME-Version: 1.0
Message-Id: <1906561.y8blzB2uZ8@hactar>
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
To: bsingharora@gmail.com
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Am Montag, 15 August 2016, 17:30:49 schrieb Balbir Singh:
> On Thu, Aug 11, 2016 at 08:08:07PM -0300, Thiago Jung Bauermann wrote:
> > Adapt all callers to the new function prototype.
> 
> Could you please expand on this?

Is the following better?

Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.

> Looks good otherwise
> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Thank you for reviewing this series!

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
