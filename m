Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ui4BF-0001b2-VQ
 for kexec@lists.infradead.org; Thu, 30 May 2013 14:50:19 +0000
Date: Thu, 30 May 2013 10:49:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 1/3] kdump: Introduce ELF header in new memory feature
Message-ID: <20130530144937.GE2864@redhat.com>
References: <1369394983-65360-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1369394983-65360-2-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524151856.GE18218@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130524151856.GE18218@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org

On Fri, May 24, 2013 at 11:18:56AM -0400, Vivek Goyal wrote:
> On Fri, May 24, 2013 at 01:29:41PM +0200, Michael Holzheu wrote:
> > Currently for s390 we create the ELF core header in the 2nd kernel
> > with a small trick. We relocate the addresses in the ELF header in
> > a way that for the /proc/vmcore code it seems to be in the 1st kernel
> > (old) memory and the read_from_oldmem() returns the correct data.
> > This allows the /proc/vmcore code to use the ELF header in the
> > 2nd kernel.
> > 
> > This patch now exchanges the old mechanism with the new and much
> > cleaner function call override feature that now offcially allows to
> > create the ELF core header in the 2nd kernel.
> > 
> > To use the new feature the following has to be done by the architecture
> > backend code:
> > 
> >  * Override arch_get_crash_header() to return the address of the ELF
> >    header in new memory.
> >  * Override arch_free_crash_header() to free the memory of the ELF
> >    header in new memory.
> >  * Override arch_read_from_crash_header() to read from the ELF header
> >    in new memory
> 
> I think above function is not clear in definition. What happens to reading
> of data pointed by ELF headers. For sections of data pointed by PT_NOTE
> we are calling arch_read_from_crash_header() but for accessing data
> pointed by PT_LOAD, we must be calling regular functions.
> 
> Not very sure what to do about this. Just that it looks little ugly
> right now.

Hi Michael,

How about if we introduce another function to read notes, say
arch_read_crash_notes(). So arch_read_from_crash_header() is meant
to get just ELF headers (ELF header and PT_LOAD, PT_NOTE type elf headers)
and arch_read_crash_notes() gets the data as pointed by PT_NOTE elf
header.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
