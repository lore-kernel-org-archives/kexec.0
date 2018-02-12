Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1elCJ4-0006rO-MH
 for kexec@lists.infradead.org; Mon, 12 Feb 2018 11:30:01 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1CBTMoP013439
 for <kexec@lists.infradead.org>; Mon, 12 Feb 2018 06:29:48 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g35j3jdjc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 12 Feb 2018 06:29:47 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Mon, 12 Feb 2018 11:29:45 -0000
Date: Mon, 12 Feb 2018 12:29:40 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/17] s390/kexec_file: Add kexec_file_load system call
In-Reply-To: <CAOFm3uFfXZZuQ6cM=pi34ybxM37BQVz08ctJmh5LryVGVgEjjA@mail.gmail.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
 <20180212100754.55121-15-prudo@linux.vnet.ibm.com>
 <CAOFm3uFfXZZuQ6cM=pi34ybxM37BQVz08ctJmh5LryVGVgEjjA@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20180212122940.2238fdd0@ThinkPad>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Mon, 12 Feb 2018 11:56:25 +0100
Philippe Ombredanne <pombredanne@nexb.com> wrote:

> On Mon, Feb 12, 2018 at 11:07 AM, Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:
> > This patch adds the kexec_file_load system call to s390 as well as the arch
> > specific functions common code requires to work. Loaders for the different
> > file types will be added later.
> >
> > Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>  
> 
> <snip>
> 
> > --- /dev/null
> > +++ b/arch/s390/kernel/machine_kexec_file.c
> > @@ -0,0 +1,174 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */  
> 
> I know this may sound weird but in .c files this should be instead:
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> See Documentation/process/license-rules.rst for why.

Oups, you are right. I fixed it locally for all files.

Thanks for pointing this out
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
