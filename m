Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bd2xz-0002D1-E9
 for kexec@lists.infradead.org; Thu, 25 Aug 2016 22:17:44 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7PM8cF7146950
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 18:17:22 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 251tmxscxq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 18:17:22 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 19:17:19 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 99BDE3520068
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 18:16:56 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7PMHILE32375288
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 19:17:18 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7PMHHgJ014842
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 19:17:17 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/5] kexec_file: Add buffer hand-over for the next
 kernel
Date: Thu, 25 Aug 2016 19:17:15 -0300
In-Reply-To: <20160825141243.e8a3f0f864b5d9dee496a1e4@linux-foundation.org>
References: <1472149111-30598-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160825141243.e8a3f0f864b5d9dee496a1e4@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <2766587.yalBJ6tfVf@hactar>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Balbir Singh <bsingharora@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Richter <erichte@linux.vnet.ibm.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-ima-devel@lists.sourceforge.net, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

Am Donnerstag, 25 August 2016, 14:12:43 schrieb Andrew Morton:
> I grabbed these two patch series.  I also merged the "IMA:
> Demonstration code for kexec buffer passing." demonstration patch just
> to get things a bit of testing.

Thank you very much!

> I assume that once the "ima: carry the
> measurement list across kexec" series has stabilised, I should drop the
> demo patch and also grab those?  If so, pelase start cc'ing me.

I'm not sure how Mimi is planning to upstream that series.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
