Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0rTx-0006xp-98
 for kexec@lists.infradead.org; Tue, 27 Mar 2018 16:29:59 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E755B7D4E8
 for <kexec@lists.infradead.org>; Tue, 27 Mar 2018 16:29:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAD14183AB
 for <kexec@lists.infradead.org>; Tue, 27 Mar 2018 16:29:31 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com
 (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id CE895181BA02
 for <kexec@lists.infradead.org>; Tue, 27 Mar 2018 16:29:31 +0000 (UTC)
Date: Tue, 27 Mar 2018 12:29:31 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1494614618.14449538.1522168171756.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.415.1522164504.2282.kexec@lists.infradead.org>
References: <mailman.415.1522164504.2282.kexec@lists.infradead.org>
Subject: Re: [PATCH net-next v2 0/2] kernel: add support to collect hardware
 logs in crash recovery kerne
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org



----- Original Message -----
> 
> On Tuesday, March 03/27/18, 2018 at 18:47:34 +0530, Eric W. Biederman wrote:
> > Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
> > 
> > > On Saturday, March 03/24/18, 2018 at 20:50:52 +0530, Eric W. Biederman wrote:
> > >> 
> > >> Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
> > >> 
> > >> > On production servers running variety of workloads over time, kernel
> > >> > panic can happen sporadically after days or even months. It is
> > >> > important to collect as much debug logs as possible to root cause
> > >> > and fix the problem, that may not be easy to reproduce. Snapshot of
> > >> > underlying hardware/firmware state (like register dump, firmware
> > >> > logs, adapter memory, etc.), at the time of kernel panic will be very
> > >> > helpful while debugging the culprit device driver.
> > >> >
> > >> > This series of patches add new generic framework that enable device
> > >> > drivers to collect device specific snapshot of the hardware/firmware
> > >> > state of the underlying device in the crash recovery kernel. In crash
> > >> > recovery kernel, the collected logs are exposed via /sys/kernel/crashdd/
> > >> > directory, which is copied by user space scripts for post-analysis.
> > >> >
> > >> > A kernel module crashdd is newly added. In crash recovery kernel,
> > >> > crashdd exposes /sys/kernel/crashdd/ directory containing device
> > >> > specific hardware/firmware logs.
> > >> 
> > >> Have you looked at instead of adding a sysfs file adding the dumps
> > >> as additional elf notes in /proc/vmcore?
> > >> 
> > >
> > > I see the crash recovery kernel's memory is not present in any of the
> > > the PT_LOAD headers.  So, makedumpfile is not collecting the dumps
> > > that are in crash recovery kernel's memory.
> > >
> > > Also, are you suggesting exporting the dumps themselves as PT_NOTE
> > > instead?  I'll look into doing it this way.
> > 
> > Yes.  I was suggesting exporting the dumps themselves as PT_NOTE
> > in /proc/vmcore.  I think that will allow makedumpfile to collect
> > your new information without modification.
> > 
> 
> If I export the dumps themselves as PT_NOTE in /proc/vmcore, can the
> crash tool work without modification; i.e can crash tool extract these
> notes?
> 
> Thanks,
> Rahul

The crash utility will continue to work without modification.  If the
dumpfile is still in its ELF format, crash will show the PT_NOTE header
and do a raw dump of the contents of the note (i.e., just a stream of
64-bit words, so if it's ASCII data, it won't be too useful).  For a 
compressed kdump, I believe that makedumpfile copies all PT_NOTEs 
to the compressed dumpfile header, but the dumpfile header does not
currently contain a direct pointer to each note.  Here is what's there
now in version 6 of the kdump_sub_header:

 * struct kdump_sub_header {
 * [0]     unsigned long   phys_base;
 * [4]     int             dump_level;         /  header_version 1 and later  /
 * [8]     int             split;              /  header_version 2 and later  /
 * [12]    unsigned long   start_pfn;          /  header_version 2 and later  /
 * [16]    unsigned long   end_pfn;            /  header_version 2 and later  /
 * [20]    off_t           offset_vmcoreinfo;  /  header_version 3 and later  /
 * [28]    unsigned long   size_vmcoreinfo;    /  header_version 3 and later  /
 * [32]    off_t           offset_note;        /  header_version 4 and later  /
 * [40]    unsigned long   size_note;          /  header_version 4 and later  /
 * [44]    off_t           offset_eraseinfo;   /  header_version 5 and later  /
 * [52]    unsigned long   size_eraseinfo;     /  header_version 5 and later  /
 * [56]    unsigned long long   start_pfn_64;  /  header_version 6 and later  /
 * [64]    unsigned long long   end_pfn_64;    /  header_version 6 and later  /
 * [72]    unsigned long long   max_mapnr_64;  /  header_version 6 and later  /

Note that explicit pointers only exist for the vmcoreinfo and eraseinfo notes,
but there are other notes (e.g., the NT_PRSTATUS and QEMU notes) that the crash
utility digs out of the full "size_note" segment of dumpfile memory that contains
a copy of all notes from the original ELF /proc/vmcore file.  Anyway, there 
would be no extraction/display of a new note type in a compressed kdump.  

As far as extraction in a format of your liking, you can always post a patch
to the crash utility mailing list to extract and/or display it in whatever 
format you desire.

Dave










_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
