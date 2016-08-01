Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bUMwj-0007oa-Ra
 for kexec@lists.infradead.org; Mon, 01 Aug 2016 23:48:34 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71NiPaT037124
 for <kexec@lists.infradead.org>; Mon, 1 Aug 2016 19:48:12 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gpcwgebx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 01 Aug 2016 19:48:11 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 20:48:09 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 3AE5A352005F
 for <kexec@lists.infradead.org>; Mon,  1 Aug 2016 19:47:47 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u71Nm6Kg21496290
 for <kexec@lists.infradead.org>; Mon, 1 Aug 2016 20:48:06 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u71Nm6V1000322
 for <kexec@lists.infradead.org>; Mon, 1 Aug 2016 20:48:06 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 0/9] kexec_file_load implementation for PowerPC
Date: Mon, 01 Aug 2016 20:48:05 -0300
In-Reply-To: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <1610701.WIqt6fioh4@hactar>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hello,

Am Donnerstag, 07 Juli 2016, 13:23:26 schrieb Thiago Jung Bauermann:
> Note: We are currently discussing whether we need a new syscall so that
> userspace can provide a custom device tree for the new kernel. Even if
> that ends up being the way forward, it would affect only patches 7 and 8,
> and even in those patches a significant part of the code would stay
> the same. Therefore, it's still important for me to get feedback on
> this series.

The discussion about how to pass device tree nodes/properties via 
kexec_file_load seems a bit stuck at the moment. Since I'm targeting kernel 
4.9 for this patch series, and considering that this code is functional and 
useful as it is, I'd like to keep the process of upstreaming it in motion.

Ping?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
