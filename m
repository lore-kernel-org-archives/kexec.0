Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R6IUU-00054U-D4
	for kexec@lists.infradead.org; Wed, 21 Sep 2011 08:49:15 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8L8nAKH013369
	for <kexec@lists.infradead.org>; Wed, 21 Sep 2011 08:49:10 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8L8n9qq2478286
	for <kexec@lists.infradead.org>; Wed, 21 Sep 2011 09:49:09 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8LFnCLO013120
	for <kexec@lists.infradead.org>; Wed, 21 Sep 2011 09:49:13 -0600
Subject: Re: [patch 1/2] kdump: Initialize vmcoreinfo note at startup
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110920155912.d107fd49.akpm@google.com>
References: <20110920143400.776127689@linux.vnet.ibm.com>
	<20110920143436.019045253@linux.vnet.ibm.com>
	<20110920155912.d107fd49.akpm@google.com>
Date: Wed, 21 Sep 2011 10:49:08 +0200
Message-ID: <1316594948.3888.3.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@google.com>
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, vgoyal@redhat.com

Hello Andrew,

On Tue, 2011-09-20 at 15:59 -0700, Andrew Morton wrote:
> On Tue, 20 Sep 2011 16:34:01 +0200

[snip]

> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> > -void crash_save_vmcoreinfo(void)
> > +static void update_vmcoreinfo_note(void)
> >  {
> > -	u32 *buf;
> > +	u32 *buf = (u32 *) vmcoreinfo_note;
> 
> The cast is unneeded?

Correct. I removed the cast (with the blank :), thanks!

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
