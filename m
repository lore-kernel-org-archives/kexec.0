Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ezJCd-00059y-2h
 for kexec@lists.infradead.org; Fri, 23 Mar 2018 09:41:40 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2N9d88J024870
 for <kexec@lists.infradead.org>; Fri, 23 Mar 2018 05:41:24 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvv966q1y-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 23 Mar 2018 05:41:24 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Fri, 23 Mar 2018 09:41:22 -0000
Date: Fri, 23 Mar 2018 10:41:16 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 00/11] kexec_file: Clean up purgatory load
In-Reply-To: <20180321160042.0f7d1fe21937f37af96a982a@linux-foundation.org>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
 <20180321160042.0f7d1fe21937f37af96a982a@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <20180323104116.0a3f00f4@ThinkPad>
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
To: Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hi Andrew,
Hi Dave,

i checked out linux-next with the patches and it looks good to me. Also made a
quick test and everything works fine.

Thanks very much to both of you
Philipp


On Wed, 21 Mar 2018 16:00:42 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 21 Mar 2018 12:27:40 +0100 Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:
> 
> > here is the updated patch set including Dave's comments.  
> 
> There were some syntactic clashes with the "kexec_file, x86, powerpc:
> refactoring for other architecutres" series.  Please check (in
> linux-next) that I got it all correct and that both patch series are
> functioning correctly.
> 
> I expect to send all this into Stephen for -next tomorrow.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
