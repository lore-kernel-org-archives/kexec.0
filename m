Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.tuxonice.net ([67.207.135.122])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JcpN1-0003kX-Do
	for kexec@lists.infradead.org; Fri, 21 Mar 2008 22:05:51 +0000
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
From: Nigel Cunningham <nigel@nigel.suspend2.net>
In-Reply-To: <Pine.LNX.4.44L0.0803202049550.11234-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0803202049550.11234-100000@netrider.rowland.org>
Date: Sat, 22 Mar 2008 09:05:47 +1100
Message-Id: <1206137147.30885.6.camel@nigel-laptop>
Mime-Version: 1.0
Reply-To: nigel@nigel.suspend2.net
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hi.

On Thu, 2008-03-20 at 20:52 -0400, Alan Stern wrote:
> For an S5 hibernation, the interpreter state within the image is wrong.  
> The image kernel needs to have the interpreter state from the boot 
> kernel -- I don't know if this is possible.

It's possible.

1) When hibernating, allocate a page (or pages if one isn't enough) for
the data to end up in after the atomic restore.
2) Put the location(s) in the image header.
3) At resume time, allocate an equivalent number of extra 'safe' pages
and set up extra pbes for the atomic restore to copy data from the extra
pages to the ones allocated when hibernating.
4) At the appropriate point in time, copy the NVS data to the extra
'safe' pages allocated in step 3.

The data will then be available to the resumed kernel post-resume.

I've been using this method to pass data from the boot kernel to the
resumed kernel for a while now. (I'm using it for I/O speed statistics
and state preservation).

Regards,

Nigel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
