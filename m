Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tlw14-0004AQ-T5
 for kexec@lists.infradead.org; Fri, 21 Dec 2012 06:23:33 +0000
Date: Fri, 21 Dec 2012 15:19:03 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC] makedumpfile-1.5.1 RC
Message-Id: <20121221151903.4fd8ab5aefb5b3a9f8f02191@mxc.nes.nec.co.jp>
In-Reply-To: <1355851243.13097.908.camel@lisamlinux.fc.hp.com>
References: <20121116171539.152467f3611c12fbd6b6be0d@mxc.nes.nec.co.jp>
 <1353413695.13097.131.camel@lisamlinux.fc.hp.com>
 <1354627899.13097.320.camel@lisamlinux.fc.hp.com>
 <20121207142646.9c4b3dd78ab602d687194f65@mxc.nes.nec.co.jp>
 <1355173565.13097.525.camel@lisamlinux.fc.hp.com>
 <20121213140648.d4f3a203fcf3bad6d7e80510@mxc.nes.nec.co.jp>
 <1355851243.13097.908.camel@lisamlinux.fc.hp.com>
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
To: lisa.mitchell@hp.com
Cc: kexec@lists.infradead.org, jerry.hoemann@hp.com

Hello Lisa,

On Tue, 18 Dec 2012 10:20:43 -0700
Lisa Mitchell <lisa.mitchell@hp.com> wrote:

> On Thu, 2012-12-13 at 05:06 +0000, Atsushi Kumagai wrote:
> 
> > 
> > In cyclic mode, we can save only a chunk of bitmap at a time, 
> > this fact forces us to scan each cyclic region twice as below:
> > 
> >   Step1: To determine the offset of kdump's page data region.
> >   Step2: To distinguish whether each page is unnecessary or not.
> > 
> > Step1 should be done before writing phase (write_kdump_pages_and_bitmap_cyclic())
> > and step2 is run while writing phase, the whole scan is needed for
> > each step.
> > On the other hand, v1.4 can execute both step1 and step2 with the temporary
> > bitmap file, the whole scan is done just one time to create the file.
> > 
> > It's a disadvantage in performance, but I think it's unavoidable.
> > (There is the exception when the number of cycles is 1, but current
> > version also scan twice in spite of redundancy.)
> > 
> > If more performance is needed, I think we should invent other
> > approaches like the idea discussed in the thread below:
> > 
> >   http://lists.infradead.org/pipermail/kexec/2012-December/007494.html
> > 
> > Besides, I think v1.4 with the local disc which can contain the temporary
> > bitmap file is the fastest version for now.
> > 
> > > Atushi, am I using the new makedumpfile 1.5.1GA correctly with the
> > > kernel patch? 
> > 
> > Yes, I think you can use mem_map array logic correctly with the patch.
> > And you can confirm it with -D option. If you didn't meet the conditions
> > to use mem_map array logic, the message below will be showed.
> > 
> >   "Can't select page_is_buddy handler; follow free lists instead of mem_map array."
> > 
> > > I didn't understand how to use the options of makedumpfile you
> > > mentioned, and when I tried with a vmlinux file, and the -x option,
> > > makedumpfile didn't even start, just failed and reset. 
> > 
> > It might be another problem related -x option.
> > For investigation, could you run the command below and show its messages ?
> > There is no need to run in 2nd kernel environment.
> > 
> >   # makedumpfile -g vmcoreinfo -x vmlinux
> > 
> > 
> > Thanks
> > Atsushi Kumagai
> > 
> 
> 
> Thanks for this info, Atsushi.
> 
> I was able to test makedumpfile-v1.5.1 on the 4 TB DL980 we had this
> weekend, along with the kexec patch to invoke the memory array logic,
> and I got encouraging results, in that the difference  in dump time
> between makedumpfile 1.4  on a RHEL 6.3 system and makedumpfile-v1.5.1
> with the memory array logic seems to be now very small:

Thanks for your hard work, it's good results.

According to your measurements on 256 GB and 4 TB, the difference in
dump time may be about ten percent of the total time in any memory size.

I think it's acceptable overhead costs to keep memory consumption
and the mem_map array logic works as we expected.


Thanks
Atsushi Kumagai


> Here are my results (file system timestamp data and note the system had
> it's filesystem time set way in the past):
> 
> 					
> 
> 1.  makedumpfile 1.4 (RHEL 6.3 default), crashkernel 512M:
> 
>        root@spb crash]# ls -al --time-style=full-iso
> 127.0.0.1-2012-05-09-19:55:50^M
> total 10757984^M
> drwxr-xr-x. 2 root root        4096 2012-05-09 21:53:21.289507559
> -0600 .^M
> drwxr-xr-x. 4 root root        4096 2012-05-09 22:10:08.729553037
> -0600 ..^M
> -rw-------. 1 root root 11016160846 2012-05-09 21:53:21.020384817 -0600
> vmcore^
> 
> 21:53:21 - 19:55:50 
> 
> Dump filter/copy time:  1 hour, 57 minutes, 29 seconds
> 
> 
> 2. makedumpfile-v1.5.1, with kexec patch, using memory array logic, took
> 3 dumps to see variations in times:
> 
> ls -al --time-style=full-iso 127.0.0.1-2012-05-10-23:42:35^M
> total 10444952^M
> drwxr-xr-x. 2 root root        4096 2012-05-11 01:52:18.512639105
> -0600 .^M
> drwxr-xr-x. 6 root root        4096 2012-05-10 23:42:39.270955565
> -0600 ..^M
> -rw-------. 1 root root 10695618226 2012-05-11 01:52:18.479636812 -0600
> vmcore^M
> 
> Dump filter/copy time: 2 hours, 9 minutes, 11 sec
> 
> 
> 127.0.0.1-2012-05-12-20:57:08:^M
> total 10469304^M
> drwxr-xr-x. 2 root root        4096 2012-05-12 23:05:39.082084132
> -0600 .^M
> drwxr-xr-x. 5 root root        4096 2012-05-12 20:57:12.627084279
> -0600 ..^M
> -rw-------. 1 root root 10720553208 2012-05-12 23:05:39.051082490 -0600
> vmcore^M
> 
> 
> Dump filter/copy time:  2 hours     8 minutes  26 seconds
> 
> 27.0.0.1-2012-05-10-09:52:17:^M
> total 10650776^M
> drwxr-xr-x. 2 root root        4096 2012-05-10 12:04:22.456078284
> -0600 .^M
> drwxr-xr-x. 6 root root        4096 2012-05-10 09:52:22.068605263
> -0600 ..^M
> -rw-------. 1 root root 10906381384 2012-05-10 12:04:22.425076466 -0600
> vmcore
> 
> Dump filter/copy time: 2 hours 13 minutes
> 
> So the dump times seem to vary + or minus 2-3 minutes, and the average
> was about 2 hours 10 minutes, or 10-12 minutes longer than the
> makedumpfile 1.4 dump time for a 4 TB system, when using a crashkernel
> constrained to 384 MB, and the cyclic buffer feature is used.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
