Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netrider.rowland.org ([192.131.102.5])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jbzmn-000503-7c
	for kexec@lists.infradead.org; Wed, 19 Mar 2008 15:01:06 +0000
Date: Wed, 19 Mar 2008 11:01:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
In-Reply-To: <m1ve3jtmxk.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.44L0.0803191057270.4958-100000@netrider.rowland.org>
MIME-Version: 1.0
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>, Len Brown <lenb@kernel.org>

On Tue, 18 Mar 2008, Eric W. Biederman wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:

> > Could it be connected with the way the boot kernel hands control over
> > to the image kernel?  Presumably ACPI isn't prepared to deal with that
> > sort of thing during a boot from S5.  It would have to be fooled into
> > thinking the two kernels were one and the same.
> 
> It should be easy to test if it is a hand over problem, by turning off
> the laptop by placing it in S5 (shutdown -h now) and then booting same
> kernel again.

?  Doesn't this happen every time Rafael turns the computer off and 
then turns it back on?

Do you mean that Rafael should do an S5-type hibernate, but then reboot 
in such a way that the image isn't loaded and resumed?

Alan Stern


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
