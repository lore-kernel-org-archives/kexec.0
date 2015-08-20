Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSPWg-0008WO-NG
 for kexec@lists.infradead.org; Thu, 20 Aug 2015 13:05:03 +0000
Date: Thu, 20 Aug 2015 09:04:37 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1497907178.20184517.1440075877293.JavaMail.zimbra@redhat.com>
In-Reply-To: <55D57913.2070303@kyup.com>
References: <mailman.5.1440010802.20553.kexec@lists.infradead.org>
 <2097586247.19732970.1440016713516.JavaMail.zimbra@redhat.com>
 <55D57913.2070303@kyup.com>
Subject: Re: Dmesg not being dumped
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
To: Nikolay Borisov <kernel@kyup.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> 
> 
> On 08/19/2015 11:38 PM, Dave Anderson wrote:
> > 
> > 
> > ----- Original Message -----
> >>
> >> Hi,
> >>
> >> On 08/19/2015 12:02 PM, Baoquan He wrote:
> >>> On 08/19/15 at 09:21am, Nikolay Borisov wrote:
> >>>> Hello,
> >>>>
> >>>> I've recently noticed that when creating crashdumps the dmesg is not
> >>>> being saved. The error reported is this: "Missing the struct log size
> >>>> export". I've tested with both kernel 4.1.1 and 3.12.28. My version of
> >>>> kexec tools is : kexec-tools 2.0.9 released 04 June 2015. The kernel has
> >>>> been compiled with debugging info so the respective symbol should be
> >>>> exported but apparently it is not. Any ideas how to debug that?
> >>>
> >>> That would be more helpful if you can attach the 1st kernel and kdump
> >>> kernel console log.
> >>
> >> I just tested with 4.1.6 with the same result. I'm sending you a link to
> >> the bzImage in question
> >> http://georgi.unixsol.org/cruft/tmp/bzImage-4.1.6-clouder1 ( I assume
> >> you meant the bzImage, if you need I can provide the vmlinux as well).
> >> Unfortunately, I couldn't figure how to obtain the log of kdump in
> >> textual format (and didn't want to send pictures). Here are the 3
> >> relevant lines (from memory):
> >>
> >> Saving vmcore-dmesg.txt
> >> Missing the struct log size export
> >> Error saving vmcore-dmesg.txt.
> >>
> >> Yet, when I load the crashdump inside the 'crash' utility and invoke the
> >> 'log' command the dmesg log is there. Whereas the vmcore-dmesg-incomplete.txt is empty.
> > 
> > FYI -- the crash utility doesn't use the vmcoreinfo data for its "log" command,
> > but you can dump the vmcore's header contents, including the vmcoreinfo strings,
> > with the "help -n" command.  For example:
> 
> Thanks for the tip, using that I can confirm that the actual symbols are
> in the resulting vmcoreinfo:
> 
> 		      SIZE(printk_log)=16
> 		      OFFSET(printk_log.ts_nsec)=0
>                       OFFSET(printk_log.len)=8
>                       OFFSET(printk_log.text_len)=10
>                       OFFSET(printk_log.dict_len)=12
> 
> So the required symbol is there (printk_log) but for some reason kexec
> cannot read it... I tried creating an uncompressed crash (removing the
> -c option from the makedumpfile command to no avail)..

The vmcoreinfo data strings were initially located in an ELF note in /proc/vmcore.
When makedumpfile -c was run on /proc/vmcore, it copied those ELF notes into the
compressed kdump header, and you have dumped them above.

So it seems to be an issue with vmcore-dmesg.  If you change the core_collector
variable to "cp" or "scp", it will copy /proc/vmcore unmodified to the target
location.  Then you can run vmcore-dmesg on that file to debug it.

Dave
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
