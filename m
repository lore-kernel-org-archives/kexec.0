Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEvhj-0006bW-Ev
 for kexec@lists.infradead.org; Wed, 24 Feb 2021 15:03:56 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11OF3daf075661
 for <kexec@lists.infradead.org>; Wed, 24 Feb 2021 10:03:51 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [192.155.248.74])
 by mx0a-001b2d01.pphosted.com with ESMTP id 36wmmf9bv9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 24 Feb 2021 10:03:50 -0500
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <kexec@lists.infradead.org> from <Bruce.Mitchell@ibm.com>;
 Wed, 24 Feb 2021 15:01:49 -0000
In-Reply-To: <CAHD1Q_z8zhpXFUybsPX6yOW2WPuYgpxsv-k90fwgqzyP1QqPVw@mail.gmail.com>
From: "Bruce Mitchell" <Bruce.Mitchell@ibm.com>
Date: Wed, 24 Feb 2021 15:01:47 +0000
MIME-Version: 1.0
References: <CAHD1Q_z8zhpXFUybsPX6yOW2WPuYgpxsv-k90fwgqzyP1QqPVw@mail.gmail.com>,
 <OF267FCB7E.EA06E022-ON00258685.0074D9AA-00258685.0074D9AE@notes.na.collabserv.com>
Message-Id: <OFFF9D2648.9979A637-ON00258686.00528F89-00258686.00528F8E@notes.na.collabserv.com>
Subject: RE: Issues with kdump/kexec on an ARM dual-core ARM Cortex-A7.
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
To: "Guilherme G. Piccoli" <guilherme.piccoli@canonical.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

>
> On Tue, Feb 23, 2021 at 6:18 PM Bruce Mitchell <Bruce.Mitchell@ibm.com> wrote:
> >
> >
> > I am having troubles getting kdump/kexec functioning on an
> > ARM dual-core ARM Cortex-A7 (a BMC by ASPEED AST2600) and QEMU.
> > I do have kexec -l loading the new kernel, but after kexec -e
> > the new kernel starts booting and the I get a watchdog BUG as shown here:
> > [240.343350] kexec_core: Starting new kernel
> > [241.639076] IRQ36: set affinity failed(-22).
> > [241.657868] Bye!
> > [ 0.000000] Booting Linux on physical CPU 0xf00
> >
>
> Just our of curiosity, what happens when you try "kexec -p" and induce
> a kernel panic, to jump to kdump kernel? Does it work, or it's the
> same?

Same results.

>
> Also, worth to try irqpoll maybe as a parameter of the second kernel,
> to see if it can progress.

Thanks for the suggestion.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
