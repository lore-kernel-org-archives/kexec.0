Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qmta12.emeryville.ca.mail.comcast.net
 ([2001:558:fe2d:44:76:96:27:227])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TPIt7-0005nH-U2
 for kexec@lists.infradead.org; Fri, 19 Oct 2012 20:09:46 +0000
Message-ID: <1350677378.30243.19.camel@rhapsody>
Subject: Re: [PATCH v2] kdump: pass acpi_rsdp= to 2nd kernel for efi booting
From: Khalid Aziz <khalid@gonehiking.org>
Date: Fri, 19 Oct 2012 14:09:38 -0600
In-Reply-To: <20121019145300.GC27052@redhat.com>
References: <20121018031608.GA3925@localhost.localdomain>
 <878vb332a9.fsf@xmission.com> <20121019145300.GC27052@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, horms@verge.net.au, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Fri, 2012-10-19 at 10:53 -0400, Vivek Goyal wrote:
> On Thu, Oct 18, 2012 at 02:20:46PM -0700, Eric W. Biederman wrote:
> > 
> > If we are passing the acpi sections is that not enough for the kernel
> > to find the rdsp area?  I'm just a bit surprised we need this patch
> > is all.
> > 
> > Somehow it seems a bit ugly to pass information that could be conveyed
> > in the memory map on the command line.
> 
> I have no idea how UEFI case is working. Dave/Khalid might have more
> details on this.

On a UEFI machine with CSM, kernel finds RSDP in EBDA. On a UEFI machine
with no CSM, kernel fails to find RSDP and here is the message I see:

ACPI BIOS Bug: Error: A valid RSDP was not found (20120913/tbxfroot-219)


--
Khalid



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
