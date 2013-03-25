Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK6gy-00058F-KQ
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 12:40:02 +0000
Date: Mon, 25 Mar 2013 07:39:55 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH] kexec: lengthen the kernel command line image
Message-ID: <20130325123955.GA30905@sgi.com>
References: <E1U2S71-00057C-Hj@eag09.americas.sgi.com>
 <20130305015127.GA28547@verge.net.au> <514FFFD1.5080704@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <514FFFD1.5080704@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Mon, Mar 25, 2013 at 03:42:09PM +0800, Zhang Yanfei wrote:
> ??? 2013???03???05??? 09:51, Simon Horman ??????:
> > On Mon, Feb 04, 2013 at 01:53:55PM -0600, Cliff Wickman wrote:
> >> From: Cliff Wickman <cpw@sgi.com>
> >>
> >> The crash kernel's boot command line is not long enough to contain the
> >> necessary memmap= options for a large memory.
> >>
> >> The fix is simple, as long as the boot loader's command line is also long enough.
> >> I'm not sure about boot loader or kernel restrictions to this length.
> >>
> >> Signed-off-by: Cliff Wickman <cpw@sgi.com>
> > 
> > Thanks, applied.
> 
> Hello
> 
> I have a question about this patch.
> 
> In x86 code, COMMAND_LINE_SIZE is defined as below:
> 
> arch/x86/include/asm/setup.h
> 
> #define COMMAND_LINE_SIZE 2048
> 
> So even the patch lengthens the commandline length here, when reboot into
> the new kernel, the commandline will still be stripped to 2048? right?
> 
> So the patch seems unnecessary or unusable. Correct me if I am wrong.

You are right, we can't go beyond 2048.

We had a problem caused by the fact that the e820 table was not fully
re-created in the crash kernel.  Without the reserved i/o spaces our
root megaraid devices were not being discovered (we use extended PCI, and
PCI segment 1, which seems to make that problem exclusively SGI's for now).  

My workaround at first was to pass all the i/o reservations as memmap=
options, but that created a command line longer than 2048.  Hence this
patch.  Then I had to amend that idea by creating a single memmap= entry that
coalesced all reserved spaces beyond usable memory into one big reserved
space.  I should have withdrawn the above patch when I realized that we
cannot get around the 2048 limit.

I did not pursue the successful version of this patch however, because
of the alternate direction being taken: that of somehow passing the entire
e820 table to the crash kernel.  That will fix the problem we have with
reserved i/o spaces.

-Cliff
-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
