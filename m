Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWptq-00019j-E5
 for kexec@lists.infradead.org; Fri, 09 Nov 2012 14:49:39 +0000
Subject: Re: [PATCH 0/3] makedumpfile: calculate the size of cyclic buffer
 automatically.
From: Lisa Mitchell <lisa.mitchell@hp.com>
In-Reply-To: <20121109141717.GB4842@redhat.com>
References: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
 <20121109141717.GB4842@redhat.com>
Date: Fri, 09 Nov 2012 03:46:21 -0700
Message-ID: <1352457981.13097.122.camel@lisamlinux.fc.hp.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, 2012-11-09 at 14:17 +0000, Vivek Goyal wrote:
> On Fri, Nov 09, 2012 at 04:02:14PM +0900, Atsushi Kumagai wrote:
> > Hello,
> > 
> > I made the patch set based on v1.5.1-beta to calculate the size of cyclic 
> > buffer automatically.
> > 
> > In v1.5.0, users have to specify the buffer size depending on system memory
> > size with --cyclic-buffer option in order to get decent performance.
> > 
> > This patch set avoids the inconvenience above by choosing the lesser value
> > of the two below as the size of cyclic buffer automatically:
> > 
> >   a. the size enough for storing the 1st/2nd bitmap for the whole of vmcore
> >   b. 80% of free memory (as safety limit)
> > 
> > Additionally, this patch set remove --cyclic-buffer option because I think
> > it has been already unnecessary.
> 
> I was wondering how about retaining --cyclic-buffer <size> option. If 
> there are use cases where user's don't like default of 80% of free memory
> they can override this policy by specifying --cyclic-buffer.
> 
> Thanks
> Vivek

I second that, I'd like the --cyclic-buffer option to stay.  I see PATCH
3/3 to remove cyclic buffer option, and I also would like it left there,
for debug of issues that may come up later.  It's great that the code
will automatically calculate the best cyclic buffer option, which is
what it should do for the best customer out-of-the-box dump enablement,
but the ability to manipulate it for debug purposes, or for workarounds
if things go wrong, is valuable. 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
