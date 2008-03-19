Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netrider.rowland.org ([192.131.102.5])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jbo7S-0005uq-GD
	for kexec@lists.infradead.org; Wed, 19 Mar 2008 02:33:34 +0000
Date: Tue, 18 Mar 2008 22:33:31 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
In-Reply-To: <200803190108.05004.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0803182228520.10154-100000@netrider.rowland.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>, Len Brown <lenb@kernel.org>

On Wed, 19 Mar 2008, Rafael J. Wysocki wrote:

> Well, I've been saying that for I-don't-remember-how-long: on my box, if you
> use S5 instead of entering S4, the fan doesn't work correctly after the
> resume.  Plain and simple.
> 
> Perhaps there's a problem with our ACPI drivers that causes this to happen,
> but I have no idea what that can be at the moment.

IMO it would be worthwhile to track this down.  It's a clear indication 
that something is wrong somewhere.

Could it be connected with the way the boot kernel hands control over
to the image kernel?  Presumably ACPI isn't prepared to deal with that
sort of thing during a boot from S5.  It would have to be fooled into
thinking the two kernels were one and the same.

Alan Stern


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
