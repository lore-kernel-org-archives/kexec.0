Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TPlsI-00007R-TM
 for kexec@lists.infradead.org; Sun, 21 Oct 2012 03:06:51 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121018031608.GA3925@localhost.localdomain>
 <878vb332a9.fsf@xmission.com> <20121019145300.GC27052@redhat.com>
Date: Sat, 20 Oct 2012 20:06:23 -0700
In-Reply-To: <20121019145300.GC27052@redhat.com> (Vivek Goyal's message of
 "Fri, 19 Oct 2012 10:53:00 -0400")
Message-ID: <874nlole1c.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kdump: pass acpi_rsdp= to 2nd kernel for efi booting
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, Dave Young <dyoung@redhat.com>, khalid@gonehiking.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Thu, Oct 18, 2012 at 02:20:46PM -0700, Eric W. Biederman wrote:
>> 
>> I have a question.  In the case where this fails are we successfully
>> passing the ACPI sections in the e820 map?
>
> For kdump we pass everything on commandline using memmap=. This also
> includes passing ACPI regions. I don't think we exclude those memmap=
> options for EFI.
>
> Also I am wondering that for kdump case why are we passing new memory
> map using command line which ultimately overides the e820 map we put
> into bootparams.
>
> It should make sense to just put modified map in e820 map in bootparam
> and not append all these options on command line. Also simplifiying
> the command line. 

As I recall we pass in the real memory map in e820 which allows for
/proc/oldmem and friends to work, and use the memory map to pass in
which information we really want to use.

Given that what we use for the old memory map is the ELF headers
passed from the crashed kernel there does seem to be room for cleanup
in that area.

> This is orthogonal to question you asked but I think this is one
> improvement we should do for kexec on panic code.

Certainly it is worth working on.

>> If we are passing the acpi sections is that not enough for the kernel
>> to find the rdsp area?  I'm just a bit surprised we need this patch
>> is all.
>> 
>> Somehow it seems a bit ugly to pass information that could be conveyed
>> in the memory map on the command line.
>
> I have no idea how UEFI case is working. Dave/Khalid might have more
> details on this.

It is the non-pure UEFI case where non-UEFI table scans work.

Of course it puzzles me why we can't find the table via scanning memory
when running in a pure UEFI environment.  Ah well that is a problem for
another day.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
