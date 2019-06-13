Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hbW0p-0000S1-SW
 for kexec@lists.infradead.org; Thu, 13 Jun 2019 20:07:57 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5DK1bkd002513
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2019 16:07:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t3v7tjk8x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2019 16:07:54 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Thu, 13 Jun 2019 21:07:52 +0100
Subject: Re: [PATCH V8 3/3] Call ima_kexec_cmdline to measure the cmdline args
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 13 Jun 2019 16:07:36 -0400
In-Reply-To: <20190613082627.GA30288@dhcp-128-65.nay.redhat.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
 <20190612221549.28399-4-prsriva02@gmail.com>
 <1560378703.4578.91.camel@linux.ibm.com>
 <20190613082627.GA30288@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1560456456.4805.61.camel@linux.ibm.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec <kexec@lists.infradead.org>, Prakhar Srivastava <prsriva02@gmail.com>, roberto.sassu@huawei.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, vgoyal@redhat.com

On Thu, 2019-06-13 at 16:26 +0800, Dave Young wrote:
> On 06/12/19 at 06:31pm, Mimi Zohar wrote:
> > [Cc: kexec mailing list]
> > 
> > Hi Eric, Dave,
> > 
> > On Wed, 2019-06-12 at 15:15 -0700, Prakhar Srivastava wrote:
> > > During soft reboot(kexec_file_load) boot cmdline args
> > > are not measured.Thus the new kernel on load boots with
> > > an assumption of cold reboot.
> > > 
> > > This patch makes a call to the ima hook ima_kexec_cmdline,
> > > added in "Define a new IMA hook to measure the boot command
> > > line arguments"
> > > to measure the boot cmdline args into the ima log.
> > > 
> > > - call ima_kexec_cmdline from kexec_file_load.
> > > - move the call ima_add_kexec_buffer after the cmdline
> > > args have been measured.
> > > 
> > > Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > 
> > Any chance we could get some Acks?
> 
> The ima_* is blackbox functions to me, looks like this patch is trying
> to measure kexec cmdline buffer and save in some ima logs and then add all the
> measure results including those for kernel/initrd to a kexec_buf and pass to 2nd

Right, including the new boot command line measurement.

> kernel.
> 
> It should be good and only take effect when IMA enabled. If all the
> assumptions are right:
> 
> Acked-by: Dave Young <dyoung@redhat.com>

Thanks, Dave.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
