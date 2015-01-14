Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YBGaf-0000Z8-5C
 for kexec@lists.infradead.org; Wed, 14 Jan 2015 05:34:02 +0000
Date: Wed, 14 Jan 2015 13:31:57 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec/x86: fix crashkernel reserved mem detection
Message-ID: <20150114053157.GC24543@dhcp-16-105.nay.redhat.com>
References: <1419514701-9397-1-git-send-email-wolchkov.yuri@gmail.com>
 <54AF74B7.4000807@suse.de>
 <20150109085927.GA8288@dhcp-16-105.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150109085927.GA8288@dhcp-16-105.nay.redhat.com>
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
To: Tony Jones <tonyj@suse.de>
Cc: kexec@lists.infradead.org, horms@verge.net.au, wolchkov.yuri@gmail.com

On 01/09/15 at 04:59pm, Baoquan He wrote:
> On 01/08/15 at 10:27pm, Tony Jones wrote:
> > On 12/25/2014 05:38 AM, Yuri Volchkov wrote:
> > > Function crashkernel_mem_callback had wrong parameters type
> > > So crash_reserved_mem got completely insane values
> > > As a result kexec was unable to allocate segments for crashkernel
> > > For instance, I got this message:
> > > 	"Could not find a free area of memory of 0x9f000 bytes..."
> > > 
> > > Signed-off-by: Yuri Volchkov <wolchkov.yuri@gmail.com>
> > 
> > See the patch attached to https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=771671
> > which also fixes kexec/arch/sh/crashdump-sh.c and kexec/arch/sh/kexec-sh.c
> > 
> > Definitely a problem.  Without the x86 fix we seem same failure on i586
> 
> Hi Tony,
> 
> commit 4362bfa make that change, but skip the crashkernel_mem_callback.
> It need be fixed.
> 
> I am wondering how the insane values happened on i386, and it didn't
> happen on x86_64.

Never mind, have got it.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
