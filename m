Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RXaYz-0001Tw-Hv
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 15:34:44 +0000
Date: Mon, 05 Dec 2011 10:34:39 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [Crash-utility] [RFC] makedumpfile, crash: LZO compression support
Message-ID: <9cf2e4ff-773c-4bd0-8a49-f4e93505cf88@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20111205175055.fd3ddb2f.kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
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
To: "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> > > Hello Hatayama-san,
> > > 
> > > Thank you for your work.
> > > 
> > >> Performance Comparison:
> > >> 
> > >>   Sample Data
> > >> 
> > >>     Ideally, I must have measured the performance for many enough
> > >>     vmcores generated from machines that was actually running, but now
> > >>     I don't have enough sample vmcores, I couldn't do so. So this
> > >>     comparison doesn't answer question on I/O time improvement.  This
> > >>     is TODO for now.
> > > 
> > > I'll measure the performance for actual vmcores by makedumpfile.
> > > Please wait for a while.
> 
> I measured the performance of makedumpfile for some vmcores.
> Please see below.
> 
> 
> Sample Data
>   
>   To simulate a working server, I captured VMCOREs while almost all pages
>   were alloceted and filled with random data. (See attached file "fill_random.c")
> 
>   I captured the VMCOREs of 5GB, 7.5GB and 10GB in the same condition.
> 
> How to measure
> 
>   I measured the total execution time and the size of output file.
> 
>   $ time makedumpfile --message-level 16 [-c|-l| ] vmcore dumpfile
> 
> Result
> 
>     See attached file "result.txt".
> 
> 
> This time, lzo's compression was the quickest, and lzo's compression ratio is
> almost the same(only a bit worse) as zlib's.
> It seems good, and I will merge the patch set into the makedumpfile.
> 
> What is your opinion, Dave?

Well, I'm not particularly thrilled about the requirement of three additional
packages and the extra library.  In the most recent crash release I did add
the capability of easily adding extra libraries to the build procedure.  But
if the feature ever becomes the default in a future RHEL distribution, then I
guess I won't have any choice but to force the requirement of the packages and
library.

Dave
 
 
> Thanks.
> KUMAGAI, Atsushi
> 
> > 
> > That's very helpful. Thanks in advance.
> > 
> > But of course I'm also still looking for alternative way.
> > 
> > Thanks.
> > HATAYAMA, Daisuke
> > 
> 
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
