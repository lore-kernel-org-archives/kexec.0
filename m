Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwkYg-0005cy-Qi
	for kexec@lists.infradead.org; Thu, 15 May 2008 21:00:15 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <Pine.LNX.4.44L0.0803221645190.27399-100000@netrider.rowland.org>
	<200803222229.45673.rjw@sisk.pl> <m1k5hwzf2z.fsf@frodo.ebiederm.org>
	<200805150147.24968.rjw@sisk.pl>
Date: Thu, 15 May 2008 13:55:29 -0700
In-Reply-To: <200805150147.24968.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 15 May 2008 01:47:23 +0200")
Message-ID: <m1fxsjp9ry.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday, 15 of May 2008, Eric W. Biederman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> Just an added data partial point.  In the kexec case I have had not heard
>> anyone screaming to me that ACPI doesn't work after we switch kernels.
>
> You don't remove power from devices while doing that.

No.  It is the second half of S5.  When we go from the boot kernel
to the restored kernel I am talking about.

That path is exactly what happens successfully in the kexec case.
Transitioning from one kernel to another.

If that path works reliably in kexec then we are talking about
something that can be solved without respect to any specific
ACPI implementation.

Eric



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
