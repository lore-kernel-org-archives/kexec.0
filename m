Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from iolanthe.rowland.org ([192.131.102.54])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZSSm-0006Aj-0h
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 15:01:52 +0000
Date: Wed, 12 Mar 2008 11:01:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
In-Reply-To: <1205286937.29875.9.camel@caritas-dev.intel.com>
Message-ID: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, 12 Mar 2008, Huang, Ying wrote:

> I think "kexec based hibernation" is the only currently available
> possible method to write out image without freezer (after driver works
> are done). If other process is running, how to prevent them from writing
> to disk without freezing them in current implementation?

This is a very good question.

It's a matter of managing the block layer's request queues.  Somehow 
the existing I/O requests must remain blocked while the requests needed 
for writing the image must be allowed to proceed.

I don't know what would be needed to make this work, but it ought to be 
possible somehow...

Alan Stern


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
